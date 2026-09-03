# -*- coding: utf-8 -*-
"""Stormworks 路径探测器（纯标准库、跨平台、零依赖）。

用途
----
本工作区的指导文档用**占位符**写路径（`<SW_GAME>` / `<STEAM_LIB>` / `<HOME>` …），
因为用户名与 Steam 库盘符在不同机器上并不相同。本脚本负责把占位符解析成当前机器的真实路径。

新环境接手第一步：
    python sw_paths.py              # 打印人类可读的路径表
    python sw_paths.py --json       # 机器可读，供 AI 直接消费
    python sw_paths.py --write      # 写入/刷新 工作区导航/路径配置.json

探测顺序（每一步都有独立回退）：
1. Steam 本体：Windows 注册表 HKCU\\Software\\Valve\\Steam → 常见安装路径 → 环境变量
2. Steam 库列表：读 <Steam>\\steamapps\\libraryfolders.vdf（自写极简 VDF 解析）
3. 游戏根目录：各库下 steamapps\\common\\Stormworks
4. 创意工坊：各库下 steamapps\\workshop\\content\\573090（573090 = Stormworks appid，固定）
5. 汉化补丁：工坊目录内**遍历**找 language.tsv（不硬编码工坊物品 id）
6. 用户数据：<HOME>\\AppData\\Roaming\\Stormworks（Windows）
7. Python：WorkBuddy 托管解释器 → venv → 系统 python

退出码：0 = 全部关键路径命中；1 = 有关键路径未找到（stderr 会给排查建议）。
"""
from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import sys
from datetime import datetime

# ---------------------------------------------------------------- 常量（跨平台不变的部分）

APP_ID = "573090"                                  # Stormworks appid，固定
GAME_DIR_NAME = "Stormworks"                       # steamapps\common\<GAME_DIR_NAME>
COMMON_REL = os.path.join("steamapps", "common", GAME_DIR_NAME)
WORKSHOP_REL = os.path.join("steamapps", "workshop", "content", APP_ID)
DEFS_REL = os.path.join("rom", "data", "definitions")
LANG_TSV_NAME = "language.tsv"

# 各平台 Steam 默认安装位置（回退用）
STEAM_FALLBACKS = {
    "win32": [
        r"C:\Program Files (x86)\Steam",
        r"C:\Program Files\Steam",
    ],
    "darwin": [
        os.path.expanduser("~/Library/Application Support/Steam"),
    ],
}
STEAM_FALLBACKS.setdefault("linux", [os.path.expanduser("~/.steam/steam"),
                                     os.path.expanduser("~/.local/share/Steam")])

# 各平台 Steam 库默认位置（注册表/vdf 都拿不到时的最后回退）
LIB_FALLBACKS = {
    "win32": ["C:\\Program Files (x86)\\Steam", "D:\\SteamLibrary", "E:\\SteamLibrary",
              "F:\\SteamLibrary", "D:\\Steam", "E:\\Steam"],
    "darwin": [os.path.expanduser("~/Library/Application Support/Steam")],
}
LIB_FALLBACKS.setdefault("linux", [os.path.expanduser("~/.steam/steam"),
                                   os.path.expanduser("~/.local/share/Steam")])

# WorkBuddy 托管 Python 的候选（相对 <HOME>）
WB_PY_GLOBS = [
    os.path.join(".workbuddy", "binaries", "python"),
    os.path.join(".workbuddy-ai", "binaries", "python"),
]

# ---------------------------------------------------------------- 工具


def _isdir(p):
    return bool(p) and os.path.isdir(p)


def _isfile(p):
    return bool(p) and os.path.isfile(p)


def _norm(p):
    if not p:
        return ""
    if sys.platform == "win32":
        # Git Bash / MSYS 传进来的 POSIX 路径（/c/Users/xxx）先转成 Windows 形式，
        # 否则 normpath 会得到 \c\Users\xxx 这种永远不存在的路径
        m = re.match(r"^/([A-Za-z])/(.*)$", p)
        if m:
            p = "%s:\\%s" % (m.group(1), m.group(2).replace("/", "\\"))
        p = p.replace("/", "\\") if re.match(r"^[A-Za-z]:/", p) else p
    p = os.path.normpath(p)
    if sys.platform == "win32" and len(p) >= 2 and p[1] == ":":
        p = p[0].upper() + p[1:]          # 盘符统一大写，便于对照
    return p


def _dedup(seq):
    seen, out = set(), []
    for x in seq:
        if not x:
            continue
        k = _norm(x).lower()
        if k in seen:
            continue
        seen.add(k)
        out.append(_norm(x))
    return out


# ---------------------------------------------------------------- VDF 解析（极简）


def _vdf_tokenize(text):
    """把 VDF 文本切成 token 流：字符串（去引号）或裸词。"""
    i, n, out = 0, len(text), []
    while i < n:
        c = text[i]
        if c in " \t\r\n":
            i += 1
            continue
        if c == '"':
            j = text.find('"', i + 1)
            if j < 0:
                out.append(text[i + 1:])
                break
            out.append(text[i + 1:j])
            i = j + 1
            continue
        if c == "{" or c == "}":
            out.append(c)
            i += 1
            continue
        if text.startswith("//", i):                       # 行注释
            j = text.find("\n", i)
            i = n if j < 0 else j + 1
            continue
        j = i
        while j < n and text[j] not in ' \t\r\n"{}':
            j += 1
        out.append(text[i:j])
        i = j
    return out


def _vdf_parse(tokens, pos=0):
    """返回 (dict, pos)。值要么是字符串，要么是嵌套 dict。"""
    obj = {}
    key = None
    while pos < len(tokens):
        t = tokens[pos]
        if t == "}":
            return obj, pos + 1
        if t == "{":
            if key is None:
                pos += 1
                continue
            child, pos = _vdf_parse(tokens, pos + 1)
            obj[key] = child
            key = None
            continue
        if key is None:
            key = t
        else:
            obj[key] = t
            key = None
        pos += 1
    return obj, pos


def _read_vdf(path):
    try:
        with open(path, "r", encoding="utf-8", errors="replace") as f:
            text = f.read()
    except OSError:
        return {}
    obj, _ = _vdf_parse(_vdf_tokenize(text))
    return obj


# ---------------------------------------------------------------- 探测步骤


def find_steam():
    """Steam 本体安装目录。"""
    cands = []

    if sys.platform == "win32":
        try:
            import winreg
            for root, sub in ((winreg.HKEY_CURRENT_USER, r"Software\Valve\Steam"),
                              (winreg.HKEY_LOCAL_MACHINE, r"Software\Valve\Steam"),
                              (winreg.HKEY_LOCAL_MACHINE, r"Software\WOW6432Node\Valve\Steam")):
                try:
                    with winreg.OpenKey(root, sub) as k:
                        cands.append(winreg.QueryValueEx(k, "SteamPath")[0])
                        cands.append(winreg.QueryValueEx(k, "InstallPath")[0])
                except OSError:
                    pass
        except ImportError:
            pass

    for env in ("STEAM_PATH", "SteamPath", "STEAM_DIR"):
        if os.environ.get(env):
            cands.append(os.environ[env])

    cands.extend(STEAM_FALLBACKS.get(sys.platform, []))

    for c in _dedup(cands):
        if _isdir(c):
            return c
    return ""


def find_library_folders(steam):
    """所有 Steam 库目录（含 Steam 本体所在库）。"""
    libs = []
    if steam:
        libs.append(steam)
        vdf = os.path.join(steam, "steamapps", "libraryfolders.vdf")
        data = _read_vdf(vdf)
        node = data.get("libraryfolders", data)
        if isinstance(node, dict):
            for _k, v in node.items():
                if isinstance(v, dict) and v.get("path"):
                    libs.append(v["path"])
                elif isinstance(v, str) and os.sep in v:
                    libs.append(v)
    libs.extend(LIB_FALLBACKS.get(sys.platform, []))
    # vdf 里常残留已卸载/已拔盘的库，只保留真实存在的，避免误导后续排查
    return [p for p in _dedup(libs) if _isdir(p)]


def find_game_root(libs):
    for lib in libs:
        p = os.path.join(lib, COMMON_REL)
        if _isdir(p):
            return p
    return ""


def find_workshop(libs):
    hits = [os.path.join(lib, WORKSHOP_REL) for lib in libs]
    hits = [p for p in hits if _isdir(p)]
    # 工坊目录内容最多的那个最可能是当前在用的库
    if not hits:
        return ""
    return max(hits, key=lambda p: len(os.listdir(p)) if os.path.isdir(p) else 0)


def find_language_tsv(workshop):
    """汉化补丁 language.tsv。遍历工坊子目录，不硬编码物品 id。"""
    if not _isdir(workshop):
        return ""
    best = ""
    best_size = -1
    try:
        entries = sorted(os.listdir(workshop))
    except OSError:
        return ""
    for name in entries:
        cands = [os.path.join(workshop, name, LANG_TSV_NAME),
                 os.path.join(workshop, name, "localization", LANG_TSV_NAME)]
        for c in cands:
            if _isfile(c):
                try:
                    size = os.path.getsize(c)
                except OSError:
                    size = 0
                if size > best_size:
                    best, best_size = c, size
    return best


def find_save_dir():
    home = os.path.expanduser("~")
    cands = []
    if sys.platform == "win32":
        appdata = os.environ.get("APPDATA") or os.path.join(home, "AppData", "Roaming")
        cands.append(os.path.join(appdata, "Stormworks"))
    elif sys.platform == "darwin":
        cands.append(os.path.join(home, "Library", "Application Support", "Stormworks"))
    else:
        cands.append(os.path.join(home or "", ".local", "share", "Stormworks"))
        cands.append(os.path.join(home or "", ".config", "Stormworks"))
    for c in _dedup(cands):
        if _isdir(c):
            return c
    return ""


def _py_works(path):
    if not _isfile(path):
        return False
    try:
        r = subprocess.run([path, "-c", "print(1)"], stdout=subprocess.DEVNULL,
                           stderr=subprocess.DEVNULL, timeout=20)
        return r.returncode == 0
    except Exception:
        return False


# 不含 python 解释器的大目录，避免无谓深挖
_SKIP_DIRS = {"lib", "libs", "lib64", "dlls", "include", "tools", "doc",
              "share", "tcl", "tk", ".git", "__pycache__"}


def _walk_py_exes(base, rel_chain):
    """在 base 下按 rel_chain 逐级找 python 可执行文件。

    rel_chain 耗尽后再往下挖一层（versions/<版本>/python.exe 这种结构）。
    深度固定为 1 层，且跳过符号链接，避免 `current` 这类联结造成死循环。
    """
    if not _isdir(base):
        return []
    if rel_chain:
        head, rest = rel_chain[0], rel_chain[1:]
        return _walk_py_exes(os.path.join(base, head), rest)

    exe = "python.exe" if sys.platform == "win32" else "python3"
    cands = (exe, os.path.join("Scripts", exe),
             os.path.join("bin", "python3"), os.path.join("bin", "python"))

    def _pick(d):
        got = []
        for c in cands:
            p = os.path.join(d, c)
            if _isfile(p):
                got.append(p)
        return got

    out = _pick(base)
    try:
        names = sorted(os.listdir(base))
    except OSError:
        return out
    for n in names:
        if n.lower() in _SKIP_DIRS:
            continue
        sub = os.path.join(base, n)
        if os.path.islink(sub) or not _isdir(sub):
            continue
        out.extend(_pick(sub))
    return out


def find_python():
    """返回 (基础解释器, 带三方包的 venv 解释器, 备注)。"""
    home = os.path.expanduser("~")
    base_cands, venv_cands = [], []

    for rel in WB_PY_GLOBS:
        root = os.path.join(home, rel)
        if not _isdir(root):
            continue
        # versions/<ver>/python.exe
        base_cands.extend(_walk_py_exes(root, ["versions"]))
        # envs/<name>/Scripts/python.exe
        venv_cands.extend(_walk_py_exes(os.path.join(root, "envs"), []))
        venv_dir = os.path.join(root, "envs")
        if _isdir(venv_dir):
            try:
                for n in sorted(os.listdir(venv_dir)):
                    for sub in ("Scripts", "bin"):
                        for exe in ("python.exe", "python", "python3"):
                            venv_cands.append(os.path.join(venv_dir, n, sub, exe))
            except OSError:
                pass

    base_cands = [p for p in _dedup(base_cands) if _py_works(p)]
    venv_cands = [p for p in _dedup(venv_cands) if _py_works(p)]

    base = base_cands[0] if base_cands else ""
    venv = ""
    for p in venv_cands:                      # 优先挑装了 requests/bs4 的
        try:
            r = subprocess.run([p, "-c", "import requests, bs4"],
                               stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, timeout=30)
        except Exception:
            continue
        if r.returncode == 0:
            venv = p
            break
    if not venv and venv_cands:
        venv = venv_cands[0]

    note = ""
    if not base:
        base = sys.executable
        note = "未找到 WorkBuddy 托管 Python，已回退到当前解释器 %s" % base
    if not venv:
        venv = base
        note = (note + "；" if note else "") + "未找到带三方包的 venv，三方包脚本需自行准备环境"
    return base, venv, note


# ---------------------------------------------------------------- 主流程

# (占位符, 说明, 是否关键)
SPEC = [
    ("<WS>", "工作区根目录", True),
    ("<HOME>", "用户主目录（含用户名，因机器而异）", True),
    ("<STEAM_LIB>", "Steam 库根目录（Stormworks 所在那个，盘符不固定）", True),
    ("<SW_GAME>", "游戏根目录", True),
    ("<SW_DEFS>", "部件定义目录（🎮 权威数据源）", True),
    ("<SW_WORKSHOP>", "创意工坊订阅目录（appid 573090，只读）", True),
    ("<SW_LANG_TSV>", "简中汉化补丁（术语表主数据源）", True),
    ("<SW_SAVE>", "Stormworks 用户数据（载具/微控存档）", False),
    ("<PY>", "Python 基础解释器（纯标准库）", True),
    ("<PYX>", "带 requests/bs4/lxml 的 venv 解释器", False),
]


def _overrides_from_env():
    """环境变量手动覆盖。

    自动探测失败时的兜底：AI/用户手工定位到真实路径后，用同名环境变量喂进来即可，
    例如 Windows:  set SW_GAME=D:\\Games\\SteamLibrary\\steamapps\\common\\Stormworks
         Linux/Mac: export SW_GAME=/home/u/.steam/steam/steamapps/common/Stormworks
    """
    out = {}
    for key, _desc, _crit in SPEC:
        v = os.environ.get(key.strip("<>"), "").strip()
        if v:
            out[key] = _norm(v)
    return out


def detect(overrides=None):
    home = os.path.expanduser("~")
    steam = find_steam()
    libs = find_library_folders(steam)
    game = find_game_root(libs)
    workshop = find_workshop(libs)
    lang = find_language_tsv(workshop)
    save = find_save_dir()
    py, pyx, note = find_python()

    # Steam 库根目录：反推游戏目录所在的那个库
    steam_lib = ""
    if game:
        steam_lib = os.path.dirname(os.path.dirname(os.path.dirname(game)))  # 去掉 common\Stormworks 与上两级
        steam_lib = _norm(game[: len(game) - len(COMMON_REL)].rstrip("\\/"))
    elif libs:
        steam_lib = libs[0]

    # 本脚本位于 <WS>\工作区导航\脚本\ 下，向上三级即工作区根
    ws = _norm(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

    vals = {
        "<WS>": ws,
        "<HOME>": _norm(home),
        "<STEAM_LIB>": steam_lib,
        "<SW_GAME>": game,
        "<SW_DEFS>": os.path.join(game, DEFS_REL) if game else "",
        "<SW_WORKSHOP>": workshop,
        "<SW_LANG_TSV>": lang,
        "<SW_SAVE>": save,
        "<PY>": py,
        "<PYX>": pyx,
    }

    applied = dict(overrides or {})
    if applied:
        vals.update(applied)
        # 派生项跟着覆盖值重算，避免手动改了 <SW_GAME> 而 <SW_DEFS> 还指向旧位置
        g = vals.get("<SW_GAME>", "")
        if g:
            vals["<SW_DEFS>"] = os.path.join(g, DEFS_REL)
            # 只有当覆盖值确实以 steamapps\common\Stormworks 结尾时才反推库根，避免切出半个路径
            if g.endswith(COMMON_REL) and len(g) > len(COMMON_REL):
                vals["<STEAM_LIB>"] = _norm(g[: len(g) - len(COMMON_REL)].rstrip("\\/"))
        if not vals.get("<SW_WORKSHOP>") and vals.get("<STEAM_LIB>"):
            vals["<SW_WORKSHOP>"] = os.path.join(
                vals["<STEAM_LIB>"], "steamapps", "workshop", "content", APP_ID)
        if not vals.get("<SW_LANG_TSV>"):
            vals["<SW_LANG_TSV>"] = find_language_tsv(vals.get("<SW_WORKSHOP>", ""))
        note = (note + "；" if note else "") + "手动覆盖：" + ", ".join(sorted(applied))

    return vals, {"steam": steam, "libraries": libs, "note": note}


def evaluate(vals):
    rows = []
    for key, desc, critical in SPEC:
        v = vals.get(key, "")
        exists = _isdir(v) if key not in ("<PY>", "<PYX>", "<SW_LANG_TSV>") else (
            _isfile(v) if key == "<SW_LANG_TSV>" else _isfile(v)
        )
        rows.append({
            "placeholder": key,
            "desc": desc,
            "value": v,
            "ok": bool(v) and exists,
            "critical": critical,
        })
    return rows


_STEAM_KEYS = ("<SW_GAME>", "<SW_DEFS>", "<STEAM_LIB>", "<SW_WORKSHOP>", "<SW_LANG_TSV>")


def _advice(rows):
    """路径缺失时的排查引导。同类问题只提示一次，末尾给出 AI 的收尾动作。"""
    missing = [r["placeholder"] for r in rows if not r["ok"]]
    tips = []

    if any(k in missing for k in _STEAM_KEYS):
        tips.append(
            "[Steam 相关：%s] 未找到。按顺序排查：\n"
            "      1) Steam 是否装在非默认位置？在 Steam 库里对 Stormworks 右键 → 属性 →\n"
            "         已安装文件 → 浏览，地址栏往上两级就是 Steam 库根目录（形如 X:\\SteamLibrary），\n"
            "         即 <STEAM_LIB>；其下 steamapps\\common\\Stormworks 即 <SW_GAME>。\n"
            "      2) 游戏装在其他盘？把该库根目录加进 Steam 设置 → 存储，或直接手工定位：\n"
            "         全盘搜 Stormworks.exe，所在目录即 <SW_GAME>。\n"
            "      3) <SW_WORKSHOP> = <STEAM_LIB>\\steamapps\\workshop\\content\\573090，\n"
            "         该目录只在有创意工坊订阅物时才存在；没订阅就没有，属正常。\n"
            "      4) <SW_LANG_TSV> 是简中汉化补丁的 language.tsv，在 <SW_WORKSHOP> 下任一子目录里。\n"
            "         本脚本是按文件名搜的，不依赖固定的工坊物品 ID。找不到时术语表无法刷新，\n"
            "         退化为直接读 汉化相关\\常用术语速查.md 与 汉化相关\\词典\\，不影响其他工作。"
            % "/".join(k for k in _STEAM_KEYS if k in missing)
        )
    if "<SW_SAVE>" in missing:
        tips.append("[<SW_SAVE>] 未找到：该目录只在游戏至少启动过一次后才生成。先启动一次游戏。")
    if any(k in missing for k in ("<PY>", "<PYX>")):
        tips.append(
            "[<PY>/<PYX>] 未找到托管的 Python，已回退到当前解释器。若脚本报 ModuleNotFoundError，\n"
            "      用 `python -m venv` 建环境并装 requests/bs4/lxml，然后重跑 --write。"
        )
    if "<HOME>" in missing or "<WS>" in missing:
        tips.append("[<HOME>/<WS>] 未找到：检查脚本是否被移出了工作区，或 HOME 环境变量是否异常。")

    if any(r["critical"] and not r["ok"] for r in rows):
        tips.append(
            "【AI 收尾动作】找到真实路径后必须回写，否则下次接手还要重找一遍：\n"
            "      1) 跑 `python <WS>\\工作区导航\\脚本\\sw_paths.py --write` 重新生成 路径配置.json；\n"
            "         若自动探测仍失败，用编辑器直接改 工作区导航\\路径配置.json 的 paths 字段。\n"
            "      2) 更新 工作区导航\\04_环境与外部依赖.md 里的「本机实测值」小节，\n"
            "         把新环境的真实路径写进去，并注明它与占位符的对应关系。\n"
            "      3) 若发现某种环境（如 Steam 在 macOS/Linux、游戏装在非 Steam 库）\n"
            "         是现有探测逻辑覆盖不到的，补进 sw_paths.py 的探测链，而不是只在文档里打补丁。"
        )
    return tips


def main():
    ap = argparse.ArgumentParser(description="探测 Stormworks 相关路径，解析工作区文档里的占位符")
    ap.add_argument("--json", action="store_true", help="输出 JSON（机器可读）")
    ap.add_argument("--write", action="store_true", help="写入/刷新 工作区导航/路径配置.json")
    ap.add_argument("--out", default="", help="--write 时指定输出文件")
    ap.add_argument("--set", action="append", default=[], metavar="KEY=VALUE",
                    help="手动覆盖某项，可重复，如 --set SW_GAME=D:\\Games\\Stormworks；"
                         "KEY 也可写 <SW_GAME> 形式")
    args = ap.parse_args()

    overrides = _overrides_from_env()
    for item in args.set:
        if "=" not in item:
            ap.error("--set 需写成 KEY=VALUE，收到：%s" % item)
        k, v = item.split("=", 1)
        k = k.strip()
        if not k.startswith("<"):
            k = "<" + k.strip("<>") + ">"
        overrides[k] = _norm(v.strip())
    known = {key for key, _d, _c in SPEC}
    unknown = [k for k in overrides if k not in known]
    if unknown:
        ap.error("未知的占位符：%s（可用：%s）" % (", ".join(unknown), " ".join(known)))

    vals, extra = detect(overrides)
    rows = evaluate(vals)

    if args.write:
        out = args.out or os.path.join(vals["<WS>"], "工作区导航", "路径配置.json")
        payload = {
            "generated_at": datetime.now().astimezone().isoformat(timespec="seconds"),
            "generator": "工作区导航/脚本/sw_paths.py",
            "platform": sys.platform,
            "workspace_root": vals["<WS>"],
            "paths": {r["placeholder"]: r["value"] for r in rows},
            "status": {r["placeholder"]: r["ok"] for r in rows},
            "steam_path": extra["steam"],
            "steam_libraries": extra["libraries"],
            "note": extra["note"],
        }
        with open(out, "w", encoding="utf-8") as f:
            json.dump(payload, f, ensure_ascii=False, indent=2)
            f.write("\n")
        if not args.json:
            print("已写入：%s" % out)

    if args.json:
        print(json.dumps({
            "workspace_root": vals["<WS>"],
            "paths": {r["placeholder"]: r["value"] for r in rows},
            "status": {r["placeholder"]: r["ok"] for r in rows},
            "steam_libraries": extra["libraries"],
            "note": extra["note"],
        }, ensure_ascii=False, indent=2))
    else:
        print("Stormworks 路径探测（%s）\n" % datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
        w = max(len(r["desc"]) for r in rows)
        for r in rows:
            flag = "OK  " if r["ok"] else ("MISS" if r["critical"] else " -- ")
            print("  %s  %-10s %-*s  %s" % (flag, r["placeholder"], w, r["desc"], r["value"] or "(未找到)"))
        if extra["steam"]:
            print("\n  Steam 本体      : %s" % extra["steam"])
        if extra["libraries"]:
            print("  Steam 库列表    : %s" % ", ".join(extra["libraries"]))
        if extra["note"]:
            print("\n  备注：%s" % extra["note"])
        tips = _advice(rows)
        if tips:
            print("\n⚠ 排查建议：")
            for t in tips:
                print("  " + t)

    missing_critical = [r for r in rows if r["critical"] and not r["ok"]]
    return 1 if missing_critical else 0


if __name__ == "__main__":
    sys.exit(main())
