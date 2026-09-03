#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
sw_defs.py —— Stormworks 部件「游戏定义文件」权威查询与核对工具

═══════════════════════════════════════════════════════════════════
🔴 只读红线（最高优先级，不可违反）
───────────────────────────────────────────────────────────────────
以下两处是 Steam 托管目录，本工具（及任何调用它的 AI）**只有读权限**，
严禁写入、修改、删除、移动、重命名其中的任何内容：
  · 游戏根目录   <SW_GAME>   = <STEAM_LIB>\\steamapps\\common\\Stormworks
  · 创意工坊订阅 <SW_WORKSHOP> = <STEAM_LIB>\\steamapps\\workshop\\content\\573090

⚠ **`<STEAM_LIB>` 的盘符与目录名因机器而异**（`E:\\SteamLibrary` 只是本机值），
本工具按 `环境变量 SW_DEFS / SW_GAME` → `工作区导航\\路径配置.json` →
`工作区导航\\脚本\\sw_paths.py` 自动探测的顺序解析，都拿不到才回退到内置默认值。
找不到时先跑 `python <WS>\\工作区导航\\脚本\\sw_paths.py --write`（见 `工作区导航\\07_路径占位符约定.md`）。

一切产出只写进 <WS>（`D:\\STORMWORKS`）下。
本工具的默认路径全部指向「已解析好的 JSON」，即只读取工作区下的缓存产物，
**日常使用完全不碰 Steam 盘**。只有显式执行 `refresh` 子命令时才读游戏目录且仅只读。
═══════════════════════════════════════════════════════════════════

权威性：`rom/data/definitions/*.xml` 是部件 mass / $ / 尺寸 / 逻辑节点 的**唯一真值**，
高于任何 wiki（Fandom 为社区维护，多为 2019–2023 快照）与玩家实测。

───────────────────────────────────────────────────────────────────
用法
───────────────────────────────────────────────────────────────────
  sw_defs.py get "Radar (Basic)"        # 查单个部件全部字段
  sw_defs.py get 雷达 --zh               # 用中文查（走汉化对照表）
  sw_defs.py search radar               # 按英文名模糊搜
  sw_defs.py search radar --file        # 连定义文件名一起搜
  sw_defs.py cat 7                      # 列出第 7 类（传感器）全部部件
  sw_defs.py cats                       # 分类代号一览
  sw_defs.py check 06_传感器.md          # 核对某册里的英文名是否真实存在
  sw_defs.py check -v                   # 省略文件名 = 核对全部册（-v 也列 wiki 别称式写法）
  sw_defs.py stats                      # 库规模

  sw_defs.py refresh                    # 从游戏定义文件重新解析（需 lxml；只读游戏目录）

设计：纯标准库，任意 python 3.8+ 即可跑（`<PY>`）。
     refresh 例外（需要 lxml，用带三方包的解释器 `<PYX>`；
     可用环境变量 PYX / PY 覆盖，否则自动探测，都拿不到才回退 sys.executable）。
"""

import argparse
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(HERE)                      # 数据库/方块数据
WS = os.path.dirname(os.path.dirname(BASE))       # 工作区根 <WS>
INDEX = os.path.join(BASE, "原始抓取_游戏定义", "components_index.json")
BOOKS_DIR = BASE

# 内置兜底值：仅当所有自动探测手段都失效时使用（盘符与用户名因机器而异，见文件头说明）
_FALLBACK_GAME_DEFS = r"E:\SteamLibrary\steamapps\common\Stormworks\rom\data\definitions"
_DEFS_REL = os.path.join("rom", "data", "definitions")


def _sw_paths_json():
    """调用工作区的路径探测脚本，拿占位符真实值。失败返回 {}（静默）。"""
    sp = os.path.join(WS, "工作区导航", "脚本", "sw_paths.py")
    if not os.path.isfile(sp):
        return {}
    try:
        import subprocess
        r = subprocess.run([sys.executable, sp, "--json"],
                           stdout=subprocess.PIPE, stderr=subprocess.DEVNULL,
                           timeout=180)
        out = r.stdout.decode("utf-8", "replace")
        if not out.strip():
            return {}
        return json.loads(out).get("paths", {}) or {}
    except Exception:
        return {}


def _read_path_config():
    """读 sw_paths.py --write 生成的 路径配置.json。失败返回 {}。"""
    cfg = os.path.join(WS, "工作区导航", "路径配置.json")
    if not os.path.isfile(cfg):
        return {}
    try:
        with open(cfg, "r", encoding="utf-8") as f:
            return (json.load(f).get("paths") or {})
    except Exception:
        return {}


def resolve_game_defs():
    """解析只读源 `<SW_DEFS>`。

    顺序：环境变量 SW_DEFS / SW_GAME → 工作区导航/路径配置.json → sw_paths.py 探测 → 内置兜底。
    """
    for k, rel in (("SW_DEFS", ""), ("SW_GAME", _DEFS_REL)):
        v = os.environ.get(k, "").strip().strip('"')
        if v:
            return os.path.join(v, rel) if rel else v
    for src in (_read_path_config(), _sw_paths_json()):
        for k in ("<SW_DEFS>", "<SW_GAME>"):
            v = (src.get(k) or "").strip()
            if not v:
                continue
            return os.path.join(v, _DEFS_REL) if k == "<SW_GAME>" else v
    return _FALLBACK_GAME_DEFS


def resolve_venv_python():
    """解析带三方包的解释器 `<PYX>`（refresh 需要 lxml）。"""
    for k in ("PYX", "PY"):
        v = os.environ.get(k, "").strip().strip('"')
        if v and os.path.isfile(v):
            return v
    for src in (_read_path_config(), _sw_paths_json()):
        for k in ("<PYX>", "<PY>"):
            v = (src.get(k) or "").strip()
            if v and os.path.isfile(v):
                return v
    return sys.executable


# 只读源（仅 refresh 用）
GAME_DEFS = resolve_game_defs()

CAT_NAME = {
    "":  "其他/管道(no category)",
    "0": "B 基础方块", "1": "V 控制面", "2": "V 载具控制/仪表", "3": "P 推进",
    "4": "M 机械", "5": "L 逻辑", "6": "U 显示", "7": "S 传感器",
    "8": "D 装饰", "9": "F 流体", "10": "E 电力", "11": "J 喷气引擎",
    "12": "W 武器/弹药", "13": "M 模块化引擎", "14": "I 工业设备", "15": "W 窗户",
}

# 部件 type 码（游戏内部方块类型）
TYPE_NAME = {
    "0": "方块", "16": "旧传感器", "56": "新雷达", "57": "新声纳",
    "62": "探鱼器",
}


def load():
    if not os.path.isfile(INDEX):
        sys.exit(f"[!] 索引不存在：{INDEX}\n    先跑 sw_defs.py refresh 生成（需 lxml 环境）。")
    with open(INDEX, encoding="utf-8") as f:
        return json.load(f)


def norm(s):
    """归一化用于匹配：小写、去多余空白。"""
    return re.sub(r"\s+", " ", (s or "").strip().lower())


# ────────────────────────── 子命令 ──────────────────────────

def cmd_get(args):
    recs = load()
    key = norm(args.name)
    hits = [r for r in recs if norm(r.get("name")) == key]
    if not hits:
        hits = [r for r in recs if key in norm(r.get("name"))]
        if hits:
            print(f"[i] 无精确匹配，模糊命中 {len(hits)} 条：\n")
    if not hits:
        print(f"[!] 游戏定义中查不到：{args.name}")
        return 1
    for r in hits:
        show(r)
        print("-" * 66)
    return 0


def show(r):
    print(f"🎮 {r.get('name')}")
    print(f"   定义文件 : {r.get('file')}")
    print(f"   分类     : cat[{r.get('category')}] {CAT_NAME.get(r.get('category', ''), '?')}"
          f"   type={r.get('type')} {TYPE_NAME.get(r.get('type', ''), '')}")
    print(f"   mass     : {fmt_mass(r.get('mass'))}")
    print(f"   价格 $   : {r.get('value')}")
    if r.get("vox"):
        print(f"   尺寸     : {r['vox']} 格  =  {r.get('size_m')} m   (X东×Y上×Z北, 1格=0.25m)")
    else:
        print("   尺寸     : —（绳节点类或动态部件，无 voxel 定义）")
    if r.get("short"):
        print(f"   简介     : {r['short']}")
    if r.get("desc"):
        print(f"   描述     : {r['desc']}")
    if r.get("tags"):
        print(f"   tags     : {r['tags']}")
    if r.get("logic"):
        print(f"   逻辑节点 : {len(r['logic'])} 个")
        for n in r["logic"]:
            # mode 语义（已用全量定义文件统计验证：mode=0→输出 208:2，mode=1→输入 40:1）
            d = "出" if n.get("mode") == "0" else ("入" if n.get("mode") == "1" else n.get("mode"))
            t = {"1": "数值", "2": "开关", "3": "连接口", "4": "电力",
                 "5": "数据", "8": "绳索"}.get(n.get("type"), f"type{n.get('type')}")
            print(f"       [{d}/{t}] {n.get('label')}"
                  + (f"  — {n['desc']}" if n.get("desc") else ""))


def fmt_mass(m):
    try:
        f = float(m)
        return str(int(f)) if f == int(f) else m
    except (TypeError, ValueError):
        return m or "—"


def cmd_search(args):
    recs = load()
    key = norm(args.pattern)
    hits = []
    for r in recs:
        hay = norm(r.get("name"))
        if args.file:
            hay += " " + norm(r.get("file"))
        if key in hay:
            hits.append(r)
    if not hits:
        print(f"[!] 无匹配：{args.pattern}")
        return 1
    print(f"[i] 命中 {len(hits)} 条\n")
    print(f"{'英文名':<44}{'mass':>8}{'$':>8}  {'尺寸':<12}cat  定义文件")
    print("-" * 100)
    for r in hits:
        print(f"{r.get('name',''):<44}{fmt_mass(r.get('mass')):>8}{r.get('value',''):>8}  "
              f"{r.get('vox') or '—':<12}{r.get('category',''):<5}{r.get('file','')}")
    return 0


def cmd_cat(args):
    recs = load()
    hits = [r for r in recs if r.get("category") == args.code]
    if not hits:
        print(f"[!] 无分类 {args.code}；跑 sw_defs.py cats 看代号")
        return 1
    print(f"cat[{args.code}] {CAT_NAME.get(args.code,'?')} —— {len(hits)} 项\n")
    print(f"{'英文名':<44}{'mass':>8}{'$':>8}  {'尺寸':<12}定义文件")
    print("-" * 96)
    for r in sorted(hits, key=lambda x: x.get("name", "")):
        print(f"{r.get('name',''):<44}{fmt_mass(r.get('mass')):>8}{r.get('value',''):>8}  "
              f"{r.get('vox') or '—':<12}{r.get('file','')}")
    return 0


def cmd_cats(args):
    recs = load()
    from collections import Counter
    c = Counter(r.get("category", "") for r in recs)
    print(f"{'cat':<6}{'名称':<22}数量")
    print("-" * 40)
    def _k(x):
        return (0, -1) if x == "" else (1, int(x) if x.isdigit() else 999)
    for k in sorted(c, key=_k):
        print(f"{k or '(空)':<6}{CAT_NAME.get(k,'?'):<22}{c[k]}")
    print("-" * 40)
    print(f"{'合计':<28}{len(recs)}")
    return 0


def cmd_stats(args):
    recs = load()
    with_logic = sum(1 for r in recs if r.get("logic"))
    with_vox = sum(1 for r in recs if r.get("vox"))
    with_desc = sum(1 for r in recs if r.get("desc"))
    print(f"部件总数        : {len(recs)}")
    print(f"有逻辑节点定义   : {with_logic}")
    print(f"有 voxel 尺寸    : {with_vox}")
    print(f"有英文描述       : {with_desc}")
    mt = os.path.getmtime(INDEX)
    import datetime
    print(f"索引生成时间     : {datetime.datetime.fromtimestamp(mt):%Y-%m-%d %H:%M}")
    print(f"索引文件         : {INDEX}")
    return 0


# ────────────────────── 核对（找册子里不存在的部件名） ──────────────────────

# 单元格里明显不是部件名的东西（数值、单位、纯符号、中文说明等）
CELL_SKIP = re.compile(
    r"^[\s\-—–/·|]*$"                                              # 空/纯符号
    r"|^[-+]?[\d.,]+\s*(m|km|kg|kW|MJ|kJ|RPS|°|%|tick|s|格|倍)?$"   # 纯数值
)


def split_names(cell):
    """把单元格拆成候选部件名（处理 'A / B / C'）。"""
    out = []
    for part in re.split(r"[/／]|·|、", cell):
        p = part.strip().strip("*`").strip()
        p = re.sub(r"\s*\(…+\)\s*", "", p)           # 去 (…) 省略号
        p = re.sub(r"⚠|✅|❌|🎮|※", "", p).strip()
        if not p or CELL_SKIP.match(p):
            continue
        # 必须是「拉丁字母开头」的部件名，且至少含一个字母
        if not re.match(r"^[A-Za-z]", p):
            continue
        if not re.search(r"[A-Za-z]{2}", p):
            continue
        # 排除长得像句子/说明的（含大量小写虚词或过长）
        if len(p) > 48:
            continue
        out.append(p)
    return out


# 常见枚举值 / 模式名 / 通用英文词，不是部件名
STOP_WORDS = {
    "absolute", "directional", "horizontal", "vertical", "relative", "heading",
    "mode", "on", "off", "none", "default", "enable", "disable", "activate",
    "electric", "power", "composite", "video", "audio", "rope", "number", "bool",
    "lpf", "abf", "npc", "npcs", "players", "all", "yes", "no", "true", "false",
    "input", "output", "value", "values", "data", "signal", "signals", "tick",
    # 表头与单位（非部件名，避免核对时误报）
    "mass", "type", "name", "size", "price", "cost", "notes", "note", "desc",
    "description", "range", "level", "count", "total", "file", "node", "nodes",
    "km", "m", "cm", "mm", "mile", "miles", "kn", "kg", "swatt", "hp", "rpm",
    "rps", "gravity", "water", "air", "fuel", "steam", "oil", "coal", "heat",
}


def build_exclusions(recs):
    """逻辑节点名不是部件名，从定义文件自动收集，避免误报。"""
    labels = set()
    for r in recs:
        for n in r.get("logic", []):
            if n.get("label"):
                labels.add(norm(n["label"]))
    return labels


def _tokens(s):
    """把部件名拆成小写词元，忽略括号/连字符等标点。"""
    return [t for t in re.split(r"[^a-z0-9]+", (s or "").lower()) if t]


def guess_game_name(n, recs):
    """
    「wiki 名 ≠ 游戏内名」是本项目最高频问题（词序相反、括号位置不同、前缀缺失）。
    本函数用「词元集合包含」做宽容匹配，给未知名一个可能的游戏内名建议。
    例：Pistol → Equipment inventory (Pistol)；Speaker Small → Speaker (Small)。
    """
    toks = _tokens(n)
    if not toks or len(toks) > 4:
        return None
    tset = set(toks)
    best, best_extra = None, 99
    for r in recs:
        gname = r.get("name") or ""
        gtoks = _tokens(gname)
        if not gtoks or not tset.issubset(set(gtoks)):
            continue
        extra = len(gtoks) - len(tset)
        if extra < best_extra:
            best, best_extra = gname, extra
            if extra == 0:
                break
    # 只在高置信（游戏内名最多多 3 个词元）时给建议，避免噪声
    if best is None or best_extra > 3:
        return None
    return best


def cmd_check(args):
    recs = load()
    by_norm = {}
    for r in recs:
        by_norm.setdefault(norm(r.get("name")), []).append(r)
    logic_labels = build_exclusions(recs)

    if args.file:
        targets = [args.file]
    else:
        targets = sorted(f for f in os.listdir(BOOKS_DIR)
                         if re.match(r"^\d\d_.*\.md$", f))

    total_unknown = 0
    total_suggested = 0
    for fn in targets:
        path = os.path.join(BOOKS_DIR, fn)
        if not os.path.isfile(path):
            print(f"[!] 找不到 {fn}")
            continue
        text = open(path, encoding="utf-8").read()
        # ① 剔除自动生成的「权威规格表」附录：它本身就来自本索引，核对它是循环论证，
        #    且其中的 .xml 文件名、加粗节点描述会造成大量纯噪声误报。
        text = re.sub(r"<!--\s*SPEC-APPENDIX-BEGIN\s*-->.*?<!--\s*SPEC-APPENDIX-END\s*-->",
                      "", text, flags=re.S)
        # 只看表格行与行内代码/反引号内容，避免正文散文误报
        names = {}
        for line in text.split("\n"):
            s = line.strip()
            if not s.startswith("|"):
                continue
            if re.match(r"^\|[\s:\-\|]+\|$", s):     # 分隔行
                continue
            for cell in s.strip("|").split("|"):
                c = cell.strip().replace("`", "")
                # ② 跳过非部件名单元格：定义文件名 / 加粗节点描述 / 含中文的说明 / 括号
                if not c or c.endswith(".xml"):
                    continue
                if "**" in c or "（" in c or "(" in c:
                    continue
                if re.search(r"[\u4e00-\u9fff]", c):   # 含中文 → 说明文字，非部件名
                    continue
                for n in split_names(cell):
                    n2 = n.strip().strip("`")
                    if not n2 or n2.endswith(".xml"):
                        continue
                    if re.search(r"[\u4e00-\u9fff]", n2):
                        continue
                    names.setdefault(n2, 0)
                    names[n2] += 1

        unknown, wiki_style, suggested = [], [], 0
        for n in names:
            nn = norm(n)
            if nn in by_norm or nn in logic_labels or nn in STOP_WORDS:
                continue
            # 去掉英文说明/表头性质的长串
            if re.search(r"\b(the|is|are|and|or|to|of|for|with|can|when|if|this|that|"
                         r"output|input|value|based|from|into|then|use|used)\b", n, re.I):
                continue
            # 全大写且含括号 → 多半是 wiki 的别称写法，单独归类
            if n.isupper() or (re.match(r"^[A-Z0-9 ()_\-/]+$", n) and not re.search(r"[a-z]", n)):
                wiki_style.append(n)
                continue
            unknown.append(n)

        print("=" * 72)
        print(f"{fn}  —— 候选部件名 {len(names)} 个 · 查不到 {len(unknown)} 个"
              + (f" · wiki 别称式 {len(wiki_style)} 个" if wiki_style else ""))
        if unknown:
            for n in sorted(unknown):
                # 「wiki 名 ≠ 游戏内名」是本项目最高频问题，自动给出可能的游戏内名
                hit = guess_game_name(n, recs)
                if hit:
                    suggested += 1
                    print(f"   ⚠ {n}   → 疑似游戏内名：{hit}")
                else:
                    print(f"   ⚠ {n}")
            total_unknown += len(unknown)
            total_suggested += suggested
        if wiki_style and args.verbose:
            for n in sorted(wiki_style):
                print(f"   · {n}   (wiki 别称写法)")
    print("=" * 72)
    print(f"合计候选查不到：{total_unknown} 个"
          + (f"（其中 {total_suggested} 个已给出疑似游戏内名建议，"
             f"仍需人工确认 {total_unknown - total_suggested} 个）" if total_suggested else ""))
    print("[i] 「查不到」不一定错——可能是：wiki 旧名/拼写错误/已移除部件/英文说明文字。")
    print("    但每一个都值得人工确认，尤其是部件清单表里的。")
    return 0


# ────────────────────────── refresh（唯一会读游戏目录的路径） ──────────────────────────

REFRESH_SRC = r'''
import os, json, glob
import lxml.etree as LET
SRC = r"SRC_PATH_TOKEN"
OUT = r"INDEX_PATH"
VOX = 0.25
os.makedirs(os.path.dirname(OUT), exist_ok=True)

def parse_file(path):
    try:
        tree = LET.parse(path, LET.XMLParser(recover=True))
    except Exception:
        return None
    root = tree.getroot()
    if root is None or root.tag != "definition":
        return None
    a = root.attrib
    rec = {"file": os.path.basename(path), "name": a.get("name", ""),
           "category": a.get("category", ""), "type": a.get("type", ""),
           "mass": a.get("mass", ""), "value": a.get("value", ""), "tags": a.get("tags", "")}
    vm, vx = root.find("voxel_min"), root.find("voxel_max")
    rec["vox"] = ""
    if vm is not None and vx is not None:
        try:
            s = [int(float(vx.get(k))) - int(float(vm.get(k))) + 1 for k in "xyz"]
            rec["vox"] = "%dx%dx%d" % tuple(s)
            rec["size_m"] = "%gx%gx%g" % (s[0]*VOX, s[1]*VOX, s[2]*VOX)
        except (TypeError, ValueError):
            pass
    tp = root.find("tooltip_properties")
    rec["desc"] = (tp.get("description") or "").strip() if tp is not None else ""
    rec["short"] = (tp.get("short_description") or "").strip() if tp is not None else ""
    nodes = []
    ln = root.find("logic_nodes")
    if ln is not None:
        for n in ln.findall("logic_node"):
            na = n.attrib
            nodes.append({"label": na.get("label", ""), "type": na.get("type", ""),
                          "mode": na.get("mode", ""), "description": (na.get("description") or "").strip()})
    rec["logic"] = nodes
    return rec

files = sorted(glob.glob(os.path.join(SRC, "*.xml")))
all_recs, failed = [], []
for f in files:                       # 只读！绝不写 E:
    r = parse_file(f)
    if r and r.get("name"):
        all_recs.append(r)
    else:
        failed.append(os.path.basename(f))
with open(OUT, "w", encoding="utf-8") as fh:
    json.dump(all_recs, fh, ensure_ascii=False, indent=1)
print("refreshed:", len(all_recs), "records; failed:", len(failed))
if failed:
    print("failed files:", failed[:20])
'''


def cmd_refresh(args):
    print("🔴 refresh 将从游戏根目录只读解析定义文件：")
    print(f"   {GAME_DEFS}")
    print("   只读，绝不写入/修改/删除其中任何内容。产物写入：")
    print(f"   {INDEX}\n")
    import subprocess
    import tempfile
    src = (REFRESH_SRC
           .replace("INDEX_PATH", INDEX.replace("\\", "\\\\"))
           .replace("SRC_PATH_TOKEN", GAME_DEFS.replace("\\", "\\\\")))
    fd, tmp = tempfile.mkstemp(suffix=".py", prefix="_sw_defs_refresh_")
    with os.fdopen(fd, "w", encoding="utf-8") as f:
        f.write(src)
    try:
        # 需要 lxml → <PYX>（自动探测，见 resolve_venv_python）
        py = resolve_venv_python()
        r = subprocess.run([py, tmp], cwd=WS)
        return r.returncode
    finally:
        os.unlink(tmp)


def cmd_options(args):
    """查载具 XML 属性的下拉选项枚举（读 数据/property_options.json）"""
    import json
    path = os.path.normpath(os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "..", "数据", "property_options.json"))
    if not os.path.exists(path):
        print("缺少 %s —— 先运行 技能库/sw-property-options/scripts/extract_property_options.py" % path)
        return 1
    with open(path, "r", encoding="utf-8") as fh:
        data = json.load(fh)
    props = data.get("properties", {})
    if args.attr:
        p = props.get(args.attr)
        if not p:
            print("属性 %r 不在枚举键清单中" % args.attr)
            return 1
        hits = {args.attr: p}
    else:
        hits = {k: v for k, v in props.items() if v.get("options")}
    for k, p in sorted(hits.items()):
        print("%s  [%s]  标签:%s" % (k, p["verified"], p.get("label") or "-"))
        if p.get("options"):
            for i, s in enumerate(p["options"]):
                print("  %d = %s" % (i, s))
        else:
            print("  (无可靠序列) 候选: %s" % (p.get("candidates") or "-"))
        if p.get("components"):
            print("  部件: %s" % ", ".join(p["components"][:6]))
        if p.get("note"):
            print("  注: %s" % p["note"])
    return 0


def main():
    ap = argparse.ArgumentParser(
        description="Stormworks 部件游戏定义文件权威查询/核对（游戏目录只读）")
    sub = ap.add_subparsers(dest="cmd", required=True)

    p = sub.add_parser("get", help="查单个部件")
    p.add_argument("name")
    p.set_defaults(func=cmd_get)

    p = sub.add_parser("options", help="查载具 XML 属性的下拉选项枚举（属性名省略则列出全部已解析）")
    p.add_argument("attr", nargs="?", default=None, help="如 m_sweep_mode / gear_ratio")
    p.set_defaults(func=cmd_options)

    p = sub.add_parser("search", help="英文名模糊搜索")
    p.add_argument("pattern")
    p.add_argument("--file", action="store_true", help="连定义文件名一起搜")
    p.set_defaults(func=cmd_search)

    p = sub.add_parser("cat", help="按分类代号列出")
    p.add_argument("code")
    p.set_defaults(func=cmd_cat)

    p = sub.add_parser("cats", help="分类代号一览")
    p.set_defaults(func=cmd_cats)

    p = sub.add_parser("stats", help="库规模")
    p.set_defaults(func=cmd_stats)

    p = sub.add_parser("check", help="核对册里的英文名是否在游戏定义中存在")
    p.add_argument("file", nargs="?", help="指定册文件名，省略则核对全部")
    p.add_argument("-v", "--verbose", action="store_true", help="也列出 wiki 别称式写法")
    p.set_defaults(func=cmd_check)

    p = sub.add_parser("refresh", help="从游戏定义文件重新解析（需 lxml，只读 E:）")
    p.set_defaults(func=cmd_refresh)

    args = ap.parse_args()
    sys.exit(args.func(args) or 0)


if __name__ == "__main__":
    main()
