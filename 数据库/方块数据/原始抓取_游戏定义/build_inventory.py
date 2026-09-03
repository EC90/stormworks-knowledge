#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
基于游戏定义(只读) + 汉化对照表，生成全量部件清单 master inventory，
并对照现有 方块数据 册做"未被引用"覆盖缺口分析。
只读游戏文件与对照表，不修改任何源。
"""
import os, json, re, glob

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)  # 方块数据
SRC_JSON = os.path.join(HERE, "components_index.json")
GLOSSARY = r"D:/STORMWORKS/汉化相关/数据/sw_glossary.jsonl"

# 数值 category 代号 -> 推断的中文大类（依样例名推断，仅供分组参考）
CAT_LABEL = {
    "": "其他/管道(no category)",
    "0": "B 基础方块", "1": "V 控制面", "2": "V 载具控制/仪表",
    "3": "P 推进", "4": "M 机械", "5": "L 逻辑", "6": "U 显示",
    "7": "S 传感器", "8": "D 装饰", "9": "F 流体", "10": "E 电力",
    "11": "J 喷气引擎", "12": "W 武器/弹药", "13": "M 模块化引擎",
    "14": "I 工业设备", "15": "W 窗户",
}

# 1) 载入 759 游戏定义
recs = json.load(open(SRC_JSON, encoding="utf-8"))

# 2) 建立 en->zh（仅 kind=name）
en2zh = {}
miss = 0
with open(GLOSSARY, encoding="utf-8") as f:
    for line in f:
        line = line.strip()
        if not line:
            continue
        try:
            d = json.loads(line)
        except Exception:
            continue
        if d.get("kind") == "name" and d.get("en"):
            en2zh.setdefault(d["en"], d.get("zh", ""))

def zh_of(name):
    z = en2zh.get(name, "")
    return z if z else "※未收录"

# 3) 载入现有 方块数据 册文本，用于覆盖缺口分析
md_files = glob.glob(os.path.join(ROOT, "**", "*.md"), recursive=True)
db_text = "\n".join(open(p, encoding="utf-8", errors="ignore").read() for p in md_files)

def referenced(name, zh):
    # 英文名或中文名其一出现在任意 册 中即视为已覆盖（子串匹配，忽略大小写）
    if name and name.lower() in db_text.lower():
        return True
    if zh and zh != "※未收录" and zh in db_text:
        return True
    return False

# 4) 写全量清单
cats = {}
for r in recs:
    cats.setdefault(r["category"], []).append(r)

lines = ["# 游戏全量部件清单（权威索引 · 759 项）", "",
         "> 源：`E:/SteamLibrary/steamapps/common/Stormworks/rom/data/definitions/*.xml`（lxml 只读解析，759 个定义）",
         "> 中文名来自 `D:/STORMWORKS/汉化相关/数据/sw_glossary.jsonl`（`kind=name`）。`※未收录` = 对照表未收录，用前回查。",
         "> 尺寸为 voxel(x×y×z)，1 voxel=0.25 m；`—` 表示无 voxel 定义（绳节点类或动态活塞）。", ""]

gaps_logic = []   # 有逻辑节点但册未引用
gaps_all = []     # 全部未引用
cov = {}          # cat -> [total, referenced]
for c in sorted(cats, key=lambda x: (len(x), x)):
    items = sorted(cats[c], key=lambda r: r["name"])
    tot = len(items); ref = 0
    lines.append(f"## cat[{c}] {CAT_LABEL.get(c, '?')} （{len(items)} 项）")
    lines.append("")
    lines.append("| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |")
    lines.append("|---|---|---|---|---|---|---|")
    for r in items:
        zh = zh_of(r["name"])
        vox = r.get("vox", "") or "—"
        nl = len(r["logic"])
        lines.append(f"| {zh} | {r['name']} | {r['mass']} | {r['value']} | {vox} | {nl} | {r['file']} |")
        if referenced(r["name"], zh):
            ref += 1
        else:
            gaps_all.append((r["name"], zh, c, nl))
            if nl > 0:
                gaps_logic.append((r["name"], zh, c, nl))
    cov[c] = [tot, ref]
    lines.append("")

out = os.path.join(HERE, "all_components_inventory.md")
with open(out, "w", encoding="utf-8") as f:
    f.write("\n".join(lines))

print(f"已写出 {out}")
print(f"全量部件：{len(recs)} 项；对照表命中中文：{sum(1 for r in recs if zh_of(r['name'])!='※未收录')} 项；未收录：{sum(1 for r in recs if zh_of(r['name'])=='※未收录')} 项")
print(f"未被任何 册 引用（名/中均未出现）：{len(gaps_all)} 项（其中含逻辑节点 {len(gaps_logic)} 项）")
print("\n=== 各大类覆盖情况（total / 已覆盖 / 未覆盖）===")
for c in sorted(cov, key=lambda x: (len(x), x)):
    t, rf = cov[c]
    print(f"  cat[{c:>2}] {CAT_LABEL.get(c,'?'):14s} 总{t:>3}  覆盖{rf:>3}  缺失{t-rf:>3}")
