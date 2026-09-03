# -*- coding: utf-8 -*-
r"""定位汉化补丁主数据源 `language.tsv`（占位符 `<SW_LANG_TSV>`）。

换机器后两样东西都会变，所以**不能写死**：
  · Steam 库的盘符与目录名（`E:\SteamLibrary` 只是本机值）
  · 汉化补丁的创意工坊物品 ID（`2019972792` 只是当前值）
因此本模块按文件名在工坊目录下搜索，而不认物品 ID。

解析顺序（快路径优先，昂贵的全盘探测只在必要时触发）：
  1. 环境变量 `SW_LANG_TSV`（指向文件）或 `SW_WORKSHOP` / `STEAM_LIB`（指向目录，随后按文件名搜）
  2. `<WS>\工作区导航\路径配置.json` 的 `paths["<SW_LANG_TSV>"]`
  3. 内置旧值（**仅当该文件确实存在**才采用）
  4. 调 `<WS>\工作区导航\脚本\sw_paths.py --json`（注册表 + VDF 枚举全部 Steam 库，最慢但最全）
  5. 仍失败 → 返回内置旧值，由调用方回退到 GitHub 上游

依赖：纯标准库。
"""
import json
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
GLOSSARY_DIR = os.path.dirname(HERE)                       # 汉化相关
WS = os.path.dirname(GLOSSARY_DIR)                         # <WS>

# 内置兜底值：仅本机有效，换机器后由上面的探测链覆盖
_FALLBACK_TSV = r"E:\SteamLibrary\steamapps\workshop\content\573090\2019972792\language.tsv"
_TSV_NAME = "language.tsv"
_WORKSHOP_REL = os.path.join("steamapps", "workshop", "content", "573090")


def _ok(path):
    return bool(path) and os.path.isfile(path)


def search_tsv_in(workshop_dir):
    """在 <SW_WORKSHOP> 下按文件名找 language.tsv（不认工坊物品 ID），取最大的一份。"""
    if not workshop_dir or not os.path.isdir(workshop_dir):
        return ""
    best, best_size = "", -1
    try:
        entries = sorted(os.listdir(workshop_dir))
    except OSError:
        return ""
    for name in entries:
        sub = os.path.join(workshop_dir, name)
        if not os.path.isdir(sub):
            continue
        cand = os.path.join(sub, _TSV_NAME)
        if not os.path.isfile(cand):
            continue
        try:
            size = os.path.getsize(cand)
        except OSError:
            size = 0
        if size > best_size:
            best, best_size = cand, size
    return best


def _from_path_config():
    cfg = os.path.join(WS, "工作区导航", "路径配置.json")
    if not os.path.isfile(cfg):
        return ""
    try:
        with open(cfg, "r", encoding="utf-8") as f:
            paths = json.load(f).get("paths") or {}
    except Exception:
        return ""
    v = (paths.get("<SW_LANG_TSV>") or "").strip()
    if _ok(v):
        return v
    v2 = (paths.get("<SW_WORKSHOP>") or "").strip()
    return search_tsv_in(v2)


def _from_sw_paths():
    """调工作区的路径探测脚本（较慢，仅作最后手段）。"""
    sp = os.path.join(WS, "工作区导航", "脚本", "sw_paths.py")
    if not os.path.isfile(sp):
        return ""
    try:
        import subprocess
        r = subprocess.run([sys.executable, sp, "--json"],
                           stdout=subprocess.PIPE, stderr=subprocess.DEVNULL,
                           timeout=180)
        out = r.stdout.decode("utf-8", "replace")
        if not out.strip():
            return ""
        paths = json.loads(out).get("paths") or {}
    except Exception:
        return ""
    for k in ("<SW_LANG_TSV>", "<SW_WORKSHOP>"):
        v = (paths.get(k) or "").strip()
        if k == "<SW_LANG_TSV>" and _ok(v):
            return v
        if k == "<SW_WORKSHOP>":
            found = search_tsv_in(v)
            if found:
                return found
    return ""


def resolve_language_tsv():
    """返回汉化补丁 language.tsv 的真实路径；找不到时返回兜底值（由调用方回退）。"""
    # 1) 环境变量
    v = os.environ.get("SW_LANG_TSV", "").strip().strip('"')
    if _ok(v):
        return v
    for var in ("SW_WORKSHOP", "STEAM_LIB"):
        base = os.environ.get(var, "").strip().strip('"')
        if not base:
            continue
        ws_dir = base if var == "SW_WORKSHOP" else os.path.join(base, _WORKSHOP_REL)
        found = search_tsv_in(ws_dir)
        if found:
            return found

    # 2) 路径配置 / 3) 内置旧值（存在才算）
    for cand in (_from_path_config(), _FALLBACK_TSV):
        if _ok(cand):
            return cand

    # 4) 全盘探测
    found = _from_sw_paths()
    if found:
        return found

    # 5) 兜底
    return _FALLBACK_TSV


if __name__ == "__main__":
    p = resolve_language_tsv()
    print(p)
    sys.exit(0 if _ok(p) else 1)
