#!/usr/bin/env python3
# -*- coding: utf-8 -*-
r"""
build_specialist.py —— 合成 20_特种设备.md（Fandom `Specialist Equipment` 分类）

为什么需要这个脚本：
  Fandom 的 Components 索引页里，`Specialist Equipment` 与 `Weapons` 一样**没有分类子页**
  （00_速查_部件总表 的分类索引里唯一一个 ❌）。但知识库里有两样东西能补上：
    ① 各 Research 页的 "Makes available" 表 → 枚举出该分类的全部成员 + **解锁所需研究项**
    ② 每个部件自己的页面 → Specifications（wiki 数值，⚠ 可能过时）

再与游戏定义文件（真值）和汉化对照表合并，产出 `20_特种设备.md`。

数据来源（**只读**，绝不写 E: 盘）：
  ① Fandom 知识库   D:\STORMWORKS\数据库\stormworks_fandom\records\*.json
  ② 游戏定义解析     D:\STORMWORKS\数据库\方块数据\原始抓取_游戏定义\components_index.json
  ③ 汉化对照表       D:\STORMWORKS\汉化相关\数据\sw_glossary.jsonl（kind=name）

🔴 只读红线：本脚本不读写 E:\SteamLibrary\... 下任何文件。产出只写 D:\STORMWORKS\。

用法：
  python build_specialist.py            # 生成/覆盖 20_特种设备.md
  python build_specialist.py --dry      # 只打印合并结果，不写文件
"""

import json
import os
import re
import sys
from collections import defaultdict

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(HERE)          # ...\数据库\方块数据
ROOT = os.path.dirname(os.path.dirname(BASE))   # D:\STORMWORKS

KB_RECORDS = os.path.join(ROOT, "数据库", "stormworks_fandom", "records")
INDEX = os.path.join(BASE, "原始抓取_游戏定义", "components_index.json")
GLOSSARY = os.path.join(ROOT, "汉化相关", "数据", "sw_glossary.jsonl")
OUT = os.path.join(BASE, "20_特种设备.md")

CAT_NAME = {
    "": "其他/管道", "0": "B 基础方块", "1": "V 控制面", "2": "V 载具控制/仪表",
    "3": "P 推进", "4": "M 机械", "5": "L 逻辑", "6": "U 显示", "7": "S 传感器",
    "8": "D 装饰", "9": "F 流体", "10": "E 电力", "11": "J 喷气引擎",
    "12": "W 武器/弹药", "13": "M 模块化引擎", "14": "I 工业设备", "15": "W 窗户",
}

# Fandom 名 → 游戏内名（wiki 名 ≠ 游戏内名，这是本项目最高频的问题源）
ALIAS = {
    "Pulley": "Rope Pulley",
    "Pulley (Corner)": "Rope Pulley (Corner)",
}

# 分组：便于按用途阅读（键 = 分组标题，值 = 该组英文名的前缀/完整名匹配规则）
GROUPS = [
    ("绞车与滑轮（Winch / Pulley）",
     lambda n: n.startswith(("Small Winch", "Medium Winch", "Large Winch", "Huge Winch"))
     or n.startswith(("Rope Pulley", "Fluid Hose Pulley", "Electric Cable Pulley"))),
    ("人员救援（Rescue）",
     lambda n: n in ("Harness", "Stretcher", "Medical Bed", "Heater",
                     "Mounted End-Effector", "Mounted Welder", "Vehicle Parachute",
                     "Landing Float")),
    ("消防（Firefighting）",
     lambda n: n in ("Fluid Cannon", "Fluid Nozzle", "Foghorn", "Siren")),
    ("摄像头与显示（Video）",
     lambda n: n.startswith("Camera")
     or n in ("Light (RGB)", "Small Spotlight (Block)", "Small Spotlight (Mounted)")),
    ("装备架 · 服装（Outfit）", lambda n: n.startswith("Outfit Inventory")),
    ("装备架 · 携带物（Equipment）", lambda n: n.startswith("Equipment Inventory")),
    ("航天（Space）", lambda n: n in ("RCS Thruster", "Outfit Inventory (Space)",
                                      "Outfit Inventory (Space Exploration)")),
    ("其他", lambda n: True),
]


def norm(s):
    return re.sub(r"\s+", " ", (s or "").strip().lower())


def load_defs():
    with open(INDEX, encoding="utf-8") as f:
        recs = json.load(f)
    return {norm(r.get("name") or ""): r for r in recs}


def load_zh():
    m = {}
    if not os.path.isfile(GLOSSARY):
        print("[!] 汉化表不存在：%s" % GLOSSARY)
        return m
    with open(GLOSSARY, encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            try:
                r = json.loads(line)
            except json.JSONDecodeError:
                continue
            if r.get("kind") != "name":
                continue
            en, zh = (r.get("en") or "").strip(), (r.get("zh") or "").strip()
            if en and zh and zh != en:
                m.setdefault(norm(en), zh)
    return m


# ---------- ① 从 Fandom 研究页枚举分类成员 ----------
CAT_RE = re.compile(r"^\s*Specialist\s+Equipment\s*$", re.I)
ROW_RE = re.compile(r"^\s*\|\s*(?:\[\[)?Specialist\s+Equipment(?:\|[^\]]*\])?\s*\|\s*([^|]+?)\s*\|", re.I | re.M)
LINK_RE = re.compile(r"\[\[([^\]｜|]+)(?:[|｜][^\]]*)?\]\]")
SKIP = {"component", "category", "name", ""}


def clean(s):
    s = LINK_RE.sub(r"\1", str(s))
    return s.replace("'''", "").replace("''", "").strip()


def scan_specialist():
    members = defaultdict(set)
    if not os.path.isdir(KB_RECORDS):
        raise SystemExit("[x] 找不到 Fandom 知识库：%s" % KB_RECORDS)
    for fn in sorted(os.listdir(KB_RECORDS)):
        if not fn.endswith(".json"):
            continue
        with open(os.path.join(KB_RECORDS, fn), "r", encoding="utf-8") as f:
            try:
                d = json.load(f)
            except Exception:
                continue
        if d.get("redirect"):
            continue
        title = d.get("title") or ""
        for t in (d.get("tables") or []):
            for r in (t.get("rows") or []):
                if not isinstance(r, (list, tuple)) or len(r) < 2:
                    continue
                c0, c1 = clean(r[0]), clean(r[1])
                if CAT_RE.match(c0) and c1.lower() not in SKIP and set(c1) - set("-: "):
                    members[c1].add(title)
        wt = d.get("wikitext") or ""
        if isinstance(wt, str) and CAT_RE.search(wt):
            for m in ROW_RE.finditer(wt):
                n = clean(m.group(1))
                if n.lower() not in SKIP and set(n) - set("-: ") and len(n) <= 60:
                    members[n].add(title)
    return members


# ---------- ② 抓每个部件的 wiki Specifications（⚠ 非权威，仅作对照） ----------
def scan_wiki_specs(names):
    """返回 {英文名: {dimensions/cost/introduced/...}}，取不到就是空 dict。"""
    want = {norm(n) for n in names}
    out = {}
    if not os.path.isdir(KB_RECORDS):
        return out
    for fn in sorted(os.listdir(KB_RECORDS)):
        if not fn.endswith(".json"):
            continue
        with open(os.path.join(KB_RECORDS, fn), "r", encoding="utf-8") as f:
            try:
                d = json.load(f)
            except Exception:
                continue
        if d.get("redirect"):
            continue
        key = norm(d.get("title") or "")
        if key not in want:
            continue
        spec = {}
        for t in (d.get("tables") or []):
            rows = t.get("rows") or []
            if not rows:
                continue
            head = [clean(c).lower() for c in rows[0]] if isinstance(rows[0], (list, tuple)) else []
            if "field" not in head or "value" not in head:
                continue
            fi, vi = head.index("field"), head.index("value")
            for r in rows[1:]:
                if not isinstance(r, (list, tuple)) or len(r) <= max(fi, vi):
                    continue
                k, v = clean(r[fi]), clean(r[vi])
                if k and v:
                    spec.setdefault(k.lower(), v)
        out[key] = spec
    return out


def fmt_num(v):
    try:
        f = float(v)
    except (TypeError, ValueError):
        return str(v)
    return str(int(f)) if f == int(f) else ("%g" % f)


def main():
    dry = "--dry" in sys.argv
    members = scan_specialist()
    defs = load_defs()
    zh = load_zh()
    wiki = scan_wiki_specs(members)

    rows = []
    unresolved = []
    for wiki_name in sorted(members, key=str.lower):
        game_name = ALIAS.get(wiki_name, wiki_name)
        rec = defs.get(norm(game_name))
        if rec is None:
            unresolved.append((wiki_name, game_name))
            continue
        key = norm(game_name)
        rows.append({
            "wiki": wiki_name,
            "en": game_name,
            "zh": zh.get(key, "※未收录"),
            "mass": fmt_num(rec.get("mass")),
            "cost": fmt_num(rec.get("value")),
            "vox": rec.get("vox") or "—",
            "size": rec.get("size_m") or "—",
            "cat": CAT_NAME.get(rec.get("category", ""), rec.get("category", "")),
            "catn": rec.get("category", ""),
            "file": rec.get("file", ""),
            "logic": rec.get("logic") or [],
            "desc": (rec.get("desc") or "").strip(),
            "short": (rec.get("short") or "").strip(),
            "research": sorted(members[wiki_name]),
            "wspec": wiki.get(norm(wiki_name)) or wiki.get(key) or {},
        })

    # ---------- 渲染 ----------
    L = []
    A = L.append
    A("> **AI 阅读规则（优先于正文）**")
    A("> 1. 中文名来自 `D:\\STORMWORKS\\汉化相关\\` 对照表，**不得改写**；`※未收录` = 补丁未收。")
    A("> 2. `mass` / `$` / **尺寸** / **逻辑节点** 一律取自游戏定义文件（`rom\\data\\definitions\\*.xml`），")
    A(">    **是唯一真值**，高于任何 wiki；wiki 数值只作为历史对照，标 `⚠`。")
    A("> 3. `⚠` = wiki 名与游戏内名不一致，或数值存疑/已过时，用前实测。")
    A("> 4. **解锁研究项**列来自 Fandom 研究页（职业模式 / Research），创造模式不受限制。")
    A("")
    A("# 20 特种设备（Specialist Equipment）")
    A("")
    A("**本节回答**：Fandom 唯一没有分类子页的 `Specialist Equipment` 到底包含哪些部件，")
    A("各自由哪个研究项解锁，以及它们的权威规格。")
    A("")
    A("**为什么这一册是合成的**：Fandom 的 Components 索引页里 `Specialist Equipment`")
    A("与 `Weapons` 一样**没有子页面**（见 `00_速查_部件总表.md` 分类索引里唯一一个 ❌）。")
    A("本册改由三条证据合成——")
    A("")
    A("| 证据 | 来源 | 可信度 |")
    A("|---|---|---|")
    A("| 分类成员 + **解锁研究项** | Fandom 各 Research 页的 *Makes available* 表 | ⚠ 英文社区维护 |")
    A("| mass / $ / 尺寸 / 逻辑节点 | 游戏定义文件 `rom\\data\\definitions\\*.xml` | 🎮 **真值** |")
    A("| 中文名 | 创意工坊汉化补丁（`汉化相关\\`） | ✅ 游戏内显示 |")
    A("")
    A("**重新生成**：`python 脚本\\build_specialist.py`（整体覆盖，勿手改本文件）。")
    A("")
    A("---")
    A("")

    A("## 20.1 分类成员总表")
    A("")
    A("> 共 **%d** 个部件。尺寸为 **X(东) × Y(上) × Z(北)** 格数，1 格 = 0.25 m。"
      % len(rows))
    A("> 表中 `$` 为建造花费（非研究点数）。")
    A("")
    A("| 中文 | 游戏内英文名 | Fandom 名 | mass | $ | 尺寸(格) | 尺寸(m) | 游戏分类 | 解锁研究项 |")
    A("|---|---|---|---|---|---|---|---|---|")
    for r in rows:
        wn = "" if r["wiki"] == r["en"] else ("⚠ %s" % r["wiki"])
        A("| %s | `%s` | %s | %s | %s | %s | %s | %s | %s |" % (
            r["zh"], r["en"], wn, r["mass"], r["cost"], r["vox"], r["size"],
            r["cat"], "、".join(x.replace(" Research", "") for x in r["research"])))
    A("")

    # 按用途分组
    A("## 20.2 按用途分组")
    A("")
    used = set()
    for title, pred in GROUPS:
        grp = [r for r in rows if r["en"] not in used and pred(r["en"])]
        if not grp:
            continue
        for r in grp:
            used.add(r["en"])
        A("### %s（%d）" % (title, len(grp)))
        A("")
        for r in grp:
            head = "**%s** `%s`" % (r["zh"], r["en"])
            bits = ["mass %s" % r["mass"], "$%s" % r["cost"],
                    "%s 格（%s m）" % (r["vox"], r["size"]) if r["vox"] != "—" else "尺寸 —"]
            A("- %s —— %s" % (head, "，".join(bits)))
            if r["short"]:
                A("  - %s" % r["short"])
            if r["logic"]:
                nd = "；".join("`%s`(%s%s)" % (
                    n.get("label", "?"),
                    {1: "数值", 2: "开关", 3: "连接口", 4: "电力", 5: "数据", 8: "绳索"}.get(
                        int(n.get("type", 0) or 0), "type%s" % n.get("type")),
                    "·入" if str(n.get("mode")) == "1" else "·出")
                    for n in r["logic"])
                A("  - 逻辑节点：%s" % nd)
            ws = r["wspec"]
            if ws.get("introduced"):
                A("  - 引入版本：⚠ %s" % ws["introduced"])
            if ws.get("dimensions") and ws["dimensions"] not in ("—", ""):
                A("  - wiki 尺寸：⚠ %s" % ws["dimensions"])
        A("")

    # wiki 与游戏定义冲突
    conflicts = []
    for r in rows:
        ws = r["wspec"]
        wd = (ws.get("dimensions") or "").strip()
        if wd and wd not in ("—", ""):
            g = set(re.findall(r"\d+", r["vox"]))
            w = set(re.findall(r"\d+", wd))
            if g and w and g != w:
                conflicts.append((r, wd))
        wc = (ws.get("cost") or "").replace("$", "").replace(",", "").strip()
        if wc and re.fullmatch(r"[\d.]+", wc) and abs(float(wc) - float(r["cost"] or 0)) > 0.01:
            conflicts.append((r, "cost %s" % ws["cost"]))
    if conflicts:
        A("## 20.3 ⚠ wiki 数值与游戏定义冲突")
        A("")
        A("> **一律以游戏定义为准**。列出来是为了说明旧 wiki 数据不可信到什么程度。")
        A("")
        A("| 部件 | 游戏定义（真值） | Fandom wiki |")
        A("|---|---|---|")
        seen = set()
        for r, wv in conflicts:
            k = (r["en"], wv)
            if k in seen:
                continue
            seen.add(k)
            A("| %s `%s` | %s 格 / $%s | %s |" % (r["zh"], r["en"], r["vox"], r["cost"], wv))
        A("")

    # 未解析
    if unresolved:
        A("## 20.%d 未在游戏定义中找到对应" % (4 if conflicts else 3))
        A("")
        A("> 这些是 Fandom 分类成员，但游戏定义文件里没有同名部件——多为**已被移除/改名**的旧部件。")
        A("")
        for wn, gn in unresolved:
            A("- ⚠ `%s`（尝试匹配 `%s`）" % (wn, gn))
        A("")

    A("## 术语对照（本册）")
    A("")
    A("| 游戏内英文名 | 中文（汉化补丁） |")
    A("|---|---|")
    for r in rows:
        A("| `%s` | %s |" % (r["en"], r["zh"]))
    A("")

    text = "\n".join(L) + "\n"

    if dry:
        print(text)
        print("[dry] 共 %d 个部件，%d 个未解析，%d 处 wiki 冲突"
              % (len(rows), len(unresolved), len(conflicts)))
        return 0

    with open(OUT, "w", encoding="utf-8", newline="\n") as f:
        f.write(text)
    print("[✓] 已写入 %s" % OUT)
    print("    部件 %d 个 · 未解析 %d 个 · wiki 冲突 %d 处" % (len(rows), len(unresolved), len(conflicts)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
