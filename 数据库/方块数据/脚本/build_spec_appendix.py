#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
build_spec_appendix.py —— 为 01~19 各册生成「🎮 权威规格表」附录

数据来源（**只读**，绝不写 E: 盘）：
  ① 游戏定义解析产物  D:\\STORMWORKS\\数据库\\方块数据\\原始抓取_游戏定义\\components_index.json
     （由 rom\\data\\definitions\\*.xml 只读解析而来，是 mass/$/尺寸/逻辑节点的唯一真值）
  ② 汉化对照表        D:\\STORMWORKS\\汉化相关\\数据\\sw_glossary.jsonl（取 kind=name 的中文名）

生成内容（写进各册 .md 的 SPEC-APPENDIX 标记之间，可重复运行、幂等覆盖）：
  A. 本册出现过的部件 → 权威规格（中文/英文/mass/$/尺寸(X×Y×Z)/逻辑节点数/定义文件）
  B. 同一分类下**本册未提到**的部件 → 缺口清单（提示补内容）

🔴 只读红线：本脚本不读写 E:\\SteamLibrary\\... 下任何文件。一切产出只写 D:\\STORMWORKS\\。

用法：
  python build_spec_appendix.py              # 处理全部册
  python build_spec_appendix.py 06 传感器      # 只处理匹配 06 的册
  python build_spec_appendix.py --dry          # 只打印统计，不写文件
"""

import json
import os
import re
import sys
from collections import Counter

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(HERE)
INDEX = os.path.join(BASE, "原始抓取_游戏定义", "components_index.json")
GLOSSARY = os.path.join(os.path.dirname(os.path.dirname(BASE)),
                        "汉化相关", "数据", "sw_glossary.jsonl")
VOX_M = 0.25

BEGIN = "<!-- SPEC-APPENDIX-BEGIN -->"
END = "<!-- SPEC-APPENDIX-END -->"
GAP_LIMIT = 40          # 缺口超过这个数就不展开成表，只给计数与查询命令

# 权威规格（mass/$/尺寸/逻辑节点）已集中在 components_index.json，可随时用
# `sw_defs.py get/search/cat` 即时查询。各册正文表格已含人读所需的关键参数，
# 若再附一份「出现过的部件」权威规格表（A 段）是纯重复、白白抬高文件体积、浪费 AI 检索 token。
# 因此对**所有编号分册**都只生成 B 段（缺口清单）——那才是正文真正缺的信息。
# 20_特种设备.md 是 build_specialist.py 整文件生成、不含本附录，天然不受影响。
SKIP_SECTION_A = set()  # 运行时按 fn 自动填充（见 main()：凡 ^\d\d_ 开头的册都跳过 A 段）

CAT_NAME = {
    "": "其他/管道", "0": "B 基础方块", "1": "V 控制面", "2": "V 载具控制/仪表",
    "3": "P 推进", "4": "M 机械", "5": "L 逻辑", "6": "U 显示", "7": "S 传感器",
    "8": "D 装饰", "9": "F 流体", "10": "E 电力", "11": "J 喷气引擎",
    "12": "W 武器/弹药", "13": "M 模块化引擎", "14": "I 工业设备", "15": "W 窗户",
}


def norm(s):
    return re.sub(r"\s+", " ", (s or "").strip().lower())


def load_defs():
    with open(INDEX, encoding="utf-8") as f:
        return json.load(f)


def load_zh():
    """英文原名 -> 中文名（只取 kind=name，即部件名）。"""
    m = {}
    if not os.path.isfile(GLOSSARY):
        print(f"[!] 汉化表不存在：{GLOSSARY}")
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


CELL_SKIP = re.compile(
    r"^[\s\-—–/·|]*$"
    r"|^[-+]?[\d.,]+\s*(m|km|kg|kW|MJ|kJ|RPS|°|%|tick|s|格|倍)?$"
)


def split_names(cell):
    out = []
    for part in re.split(r"[/／]|·|、", cell):
        p = part.strip().strip("*`").strip()
        p = re.sub(r"\s*\((…|\.\.\.|…)\)\s*", "", p)
        p = re.sub(r"[⚠✅❌🎮※]", "", p).strip()
        if not p or CELL_SKIP.match(p):
            continue
        if not re.match(r"^[A-Za-z]", p):
            continue
        if not re.search(r"[A-Za-z]{2}", p) or len(p) > 48:
            continue
        out.append(p)
    return out


def names_in_md(path):
    """返回 {候选名: 出现次数}，只看表格行。

    ⚠ 必须跳过本工具自己生成的附录区域，否则第二次运行时会把附录里的英文名
    当成「本册提到过的部件」再匹配一次，导致覆盖数单调递增（不幂等）。
    """
    cnt = Counter()
    in_appendix = False
    for line in open(path, encoding="utf-8"):
        s = line.strip()
        if BEGIN in s:
            in_appendix = True
            continue
        if END in s:
            in_appendix = False
            continue
        if in_appendix:
            continue
        if not s.startswith("|") or re.match(r"^\|[\s:\-\|]+\|$", s):
            continue
        for cell in s.strip("|").split("|"):
            for n in split_names(cell):
                cnt[n] += 1
    return cnt


def fmt_mass(m):
    try:
        f = float(m)
        return str(int(f)) if f == int(f) else f"{f:g}"
    except (TypeError, ValueError):
        return "—"


def size_str(r):
    if not r.get("vox"):
        return "—"
    return r["vox"]


def row(r, zh_map):
    zh = zh_map.get(norm(r.get("name")), "")
    if not zh:
        zh = "※未收录"
    ln = len(r.get("logic", []))
    return (f"| {zh} | {r.get('name','')} | {fmt_mass(r.get('mass'))} | "
            f"{r.get('value') or '—'} | {size_str(r)} | {ln} | `{r.get('file','')}` |")


def build_for(path, defs, zh_map, skip_a=False, all_cats=False):
    cnt = names_in_md(path)
    by_norm = {}
    for r in defs:
        by_norm.setdefault(norm(r.get("name")), r)     # 同名取首个

    matched = {}     # norm -> rec
    for n in cnt:
        r = by_norm.get(norm(n))
        if r:
            matched[norm(r.get("name"))] = r

    if not matched:
        return None, 0, 0

    # 主导分类：按数量降序累加到覆盖 ≥60% 为止。
    # 否则一册里偶然出现一两个方块，会把整个「基础方块」分类都算成缺口，噪声巨大。
    if all_cats:
        # 总表类文件：不挑分类，全库比对，找出「总表里一个都没提到」的部件
        main_cats = sorted({r.get("category", "") for r in defs},
                           key=lambda x: (x == "", int(x) if x.isdigit() else 99))
    else:
        cats = Counter(r.get("category", "") for r in matched.values())
        total = sum(cats.values())
        # 双重门槛：单个分类占比 ≥25%（防「顺带提了一嘴」的大分类混入），
        # 且累加到 ≥60% 即停（防把整册不相关的分类全拉进来）。
        main_cats, acc = [], 0
        for c, n in cats.most_common():
            if total and n / total < 0.25 and main_cats:
                break
            main_cats.append(c)
            acc += n
            if acc >= total * 0.6:
                break

    lines = []
    lines.append("")
    lines.append(BEGIN)
    lines.append("")
    lines.append("## 🎮 权威规格表（游戏定义文件 · 本附录自动生成，勿手改）")
    lines.append("")
    lines.append("> **来源（只读解析，权威高于任何 wiki）**：")
    lines.append("> `<SW_DEFS>\\*.xml`")
    lines.append("> 中文名取自创意工坊汉化补丁；`※未收录` 表示该名补丁未收，游戏内仍显示英文。")
    lines.append("> 尺寸一律按 **X(东) × Y(上) × Z(北)** 格数，**1 格 = 0.25 m**。")
    lines.append("> 重新生成：`python 脚本\\build_spec_appendix.py`（会整体覆盖本附录，勿在标记之间手改）。")
    lines.append("")
    if skip_a:
        lines.append("> 权威规格（mass / $ / 尺寸 / 逻辑节点）不再重复列于本册，")
        lines.append("> 需要时用 `python 脚本\\sw_defs.py get/search/cat` 即时查询（真值在 `components_index.json`）。")
        lines.append("> 下面只保留**缺口清单**——即正文还没覆盖到的部件。")
        lines.append("")
    else:
        lines.append("### A. 本册出现过的部件（权威规格）")
        lines.append("")
        lines.append("| 中文 | 游戏内英文名 | mass | $ | 尺寸(X×Y×Z) | 逻辑节点 | 定义文件 |")
        lines.append("|---|---|---|---|---|---|---|")
        for r in sorted(matched.values(), key=lambda x: (x.get("category", ""), x.get("name", ""))):
            lines.append(row(r, zh_map))
        lines.append("")
        lines.append(f"> 合计 **{len(matched)}** 个部件在本册中被提及且可在游戏定义中确认。")
        lines.append("")

    # B. 同分类下本册未覆盖的部件
    gaps = []
    for c in main_cats:
        for r in defs:
            if r.get("category") != c:
                continue
            if norm(r.get("name")) in matched:
                continue
            gaps.append((c, r))
    if gaps:
        lines.append("### B. 同分类中本册**未覆盖**的部件（缺口清单）")
        lines.append("")
        if len(gaps) > GAP_LIMIT:
            # 缺口太多说明本册只「顺带」涉及这些大类，全列出来是噪声，给命令让 AI 自己查
            cc = Counter(c for c, _ in gaps)
            detail = "、".join(f"cat[{c}] {CAT_NAME.get(c, '?')} ({n})" for c, n in cc.most_common())
            lines.append(f"> 本册涉及的分类里还有 **{len(gaps)}** 个部件未被正文提到：{detail}。")
            lines.append("> 数量较多，不在此展开（避免噪声）。需要时按分类查权威清单：")
            lines.append(">")
            lines.append("> ```bash")
            for c, _ in cc.most_common():
                lines.append(f"> python 脚本\\sw_defs.py cat {c}   # {CAT_NAME.get(c, '?')}")
            lines.append("> ```")
            lines.append("")
        else:
            lines.append("> 下列部件属于本册涵盖的分类，但本册正文没有提到。写相关内容前**值得先看一眼**，")
            lines.append("> 避免漏掉现成可用的部件。中文名 `※未收录` = 汉化补丁未收。")
            lines.append("")
            cur = None
            for c, r in sorted(gaps, key=lambda x: (x[0] == "", int(x[0]) if x[0].isdigit() else 99, x[1].get("name", ""))):
                if c != cur:
                    cur = c
                    lines.append("")
                    lines.append(f"**cat[{c}] {CAT_NAME.get(c, '?')}**")
                    lines.append("")
                    lines.append("| 中文 | 游戏内英文名 | mass | $ | 尺寸(X×Y×Z) | 逻辑节点 | 定义文件 |")
                    lines.append("|---|---|---|---|---|---|---|")
                lines.append(row(r, zh_map))
            lines.append("")
            lines.append(f"> 缺口合计 **{len(gaps)}** 个部件。")
            lines.append("")
    lines.append(END)
    lines.append("")
    return "\n".join(lines), len(matched), len(gaps)


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("-")]
    dry = "--dry" in sys.argv

    defs = load_defs()
    zh_map = load_zh()
    print(f"[i] 游戏定义 {len(defs)} 条 · 汉化部件名 {len(zh_map)} 条")

    # 只处理 00~19 册。20_特种设备.md 由 build_specialist.py 整文件生成、自带权威规格表，
    # 若交给本脚本会在末尾追加重复附录，故明确排除。
    files = sorted(f for f in os.listdir(BASE)
                   if re.match(r"^\d\d_.*\.md$", f) and not f.startswith("20_"))
    if args:
        files = [f for f in files if any(a in f for a in args)]

    total_m = total_g = 0
    for fn in files:
        path = os.path.join(BASE, fn)
        appendix, m, g = build_for(path, defs, zh_map,
                                   skip_a=re.match(r"^\d\d_", fn) is not None,
                                   all_cats=(fn == "00_速查_部件总表.md"))
        if appendix is None:
            print(f"  · {fn:<34} 无匹配部件，跳过")
            continue
        total_m += m
        total_g += g
        print(f"  ✓ {fn:<34} 覆盖 {m:>3} 个 · 缺口 {g:>3} 个")
        if dry:
            continue
        text = open(path, encoding="utf-8").read()
        if BEGIN in text and END in text:
            pre, rest = text.split(BEGIN, 1)
            _, post = rest.split(END, 1)
            text = pre + appendix.strip("\n") + post
        else:
            text = text.rstrip("\n") + "\n\n---\n" + appendix
        with open(path, "w", encoding="utf-8", newline="\n") as f:
            f.write(text)
    print(f"[✓] 合计覆盖 {total_m} 个部件，列出缺口 {total_g} 个"
          + ("（dry-run，未写文件）" if dry else ""))


if __name__ == "__main__":
    main()
