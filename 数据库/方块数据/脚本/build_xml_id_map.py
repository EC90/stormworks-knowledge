#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""生成载具 XML 部件编号（d 值）对照表 xml_id_map.json / xml_id_map.md。

数据链：载具XML <c d="engine_diesel"> → 定义文件 engine_diesel.xml →
根节点 name="Large Engine" → 汉化术语表 (sw_glossary.jsonl, kind=name) → 中文译名。

输入：
  原始抓取_游戏定义/components_index.json  （759 条，含 file/name/category/...）
  汉化相关/数据/sw_glossary.jsonl          （kind=name 的 en→zh）
输出：
  数据/xml_id_map.json
  数据/xml_id_map.md

游戏更新新增部件后重跑本脚本即可再生成。纯标准库，零依赖。
用法：
  python build_xml_id_map.py            # 生成（默认自译兜底）
  python build_xml_id_map.py --no-guess # 未命中项 zh 留空，只打印清单
"""
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(HERE)                       # 数据库/方块数据/
WS = os.path.dirname(os.path.dirname(BASE))        # D:\STORMWORKS\
INDEX = os.path.join(BASE, "原始抓取_游戏定义", "components_index.json")
GLOSSARY = os.path.join(WS, "汉化相关", "数据", "sw_glossary.jsonl")
OUT_DIR = os.path.join(BASE, "数据")
OUT_JSON = os.path.join(OUT_DIR, "xml_id_map.json")
OUT_MD = os.path.join(OUT_DIR, "xml_id_map.md")

CAT_NAME = {
    "":  "其他/管道(no category)",
    "0": "B 基础方块", "1": "V 控制面", "2": "V 载具控制/仪表", "3": "P 推进",
    "4": "M 机械", "5": "L 逻辑", "6": "U 显示", "7": "S 传感器",
    "8": "D 装饰", "9": "F 流体", "10": "E 电力", "11": "J 喷气引擎",
    "12": "W 武器/弹药", "13": "M 模块化引擎", "14": "I 工业设备", "15": "W 窗户",
}

# 未命中术语表时的自译兜底（沿同族用词习惯，交付物中标 ※、hit=false）
# 依据：龙骨(大)=Keel (Large)、机械枢轴(动力)=Robotic Pivot (Power)、
#       锥形块=Pyramid、楔形块=Wedge、着陆浮子=Landing Float
MANUAL_ZH = {
    "buoyancy_float_block": "浮力块",
    "buoyancy_float_pyramid": "浮力锥形块",
    "buoyancy_float_wedge": "浮力楔形块",
    "keel_medium": "龙骨(中)",
    "keel_small": "龙骨(小)",
    "multibody_pivot_torque_a": "枢轴(动力)",
    "multibody_pivot_torque_b": "枢轴(动力)",
    "multibody_compact_pivot_a": "枢轴(紧凑型)",
    "multibody_compact_pivot_b": "枢轴(紧凑型)",
}


def bad_zh(zh, en):
    """术语表脏数据判定：zh 无翻译价值（占位符/蛇形 id/与英文相同）。"""
    if not zh or zh == "（未翻译）" or zh == en:
        return True
    if re.match(r"^[a-z0-9_.]+$", zh):
        return True
    return False


def load_glossary():
    en2zh = {}
    with open(GLOSSARY, encoding="utf-8") as f:
        for line in f:
            try:
                o = json.loads(line)
            except json.JSONDecodeError:
                continue
            if o.get("kind") == "name" and o.get("en") and o.get("zh") \
                    and not bad_zh(o["zh"], o["en"]):
                # 同名多条时保留第一条（术语表已去重）
                en2zh.setdefault(o["en"], o["zh"])
    return en2zh


def main():
    no_guess = "--no-guess" in sys.argv
    with open(INDEX, encoding="utf-8") as f:
        recs = json.load(f)
    if isinstance(recs, dict):
        recs = list(recs.values())
    en2zh = load_glossary()

    items, missed = [], []
    for r in sorted(recs, key=lambda x: x.get("file", "")):
        d_id = os.path.splitext(r.get("file", ""))[0]
        en = r.get("name", "")
        zh, hit = en2zh.get(en), True
        if zh is None:
            hit = False
            zh = MANUAL_ZH.get(d_id, "")
            if zh:
                zh = "※" + zh
            missed.append((d_id, en))
        items.append({
            "id": d_id,
            "en": en,
            "zh": zh,
            "category": r.get("category"),
            "type": r.get("type"),
            "mass": r.get("mass"),
            "value": r.get("value"),
            "vox": r.get("vox"),
            "hit": hit,
        })

    os.makedirs(OUT_DIR, exist_ok=True)
    doc = {
        "_about": "载具XML存档 <c d=\"...\"> 编号 ↔ 部件名对照表。d=定义文件名(去.xml)，en=游戏内英文名，zh=汉化术语表译名（※为自译），hit=false 表示术语表未命中。",
        "_notes": {
            "t属性": "经 197 辆创意工坊载具（483 种部件）实测：t 与定义根节点 type 属性无对应，"
                     "也与相邻方块/网格变体无关；全域观测值仅 0–7，逐实例变化，语义未定（游戏内部子类型索引）。"
                     "解读载具时以 d 属性为准，t 原样保留即可。",
            "invalid_xml": "载具 XML 含数字开头属性名（矩阵 00-33），非合法 XML，解析前需预处理。",
        },
        "_source": {
            "definitions": "E:/SteamLibrary/steamapps/common/Stormworks/rom/data/definitions",
            "index": os.path.relpath(INDEX, WS),
            "glossary": os.path.relpath(GLOSSARY, WS),
        },
        "count": len(items),
        "miss": len(missed),
        "components": items,
    }
    with open(OUT_JSON, "w", encoding="utf-8") as f:
        json.dump(doc, f, ensure_ascii=False, indent=1)

    # 人读版：按分类分组
    groups = {}
    for it in items:
        groups.setdefault(it.get("category"), []).append(it)
    lines = ["# 载具 XML 部件编号对照表（d 值 ↔ 部件名）", "",
             "> 载具 XML 中 `<c d=\"engine_diesel\" ...>` 的 `d` 属性即本表 `id` 列。",
             "> `zh` 取自汉化术语表；`※` 前缀为术语表未收录的自译名。", ""]
    for cat in sorted(groups, key=lambda c: (c is None, c)):
        cname = CAT_NAME.get(str(cat), f"分类{cat}")
        lines.append(f"## {cname}（category={cat}）\n")
        lines.append("| id（载具XML d值） | 英文名 | 中文名 | 尺寸(格) | mass | $ |")
        lines.append("| --- | --- | --- | --- | --- | --- |")
        for it in groups[cat]:
            lines.append("| `{}` | {} | {} | {} | {} | {} |".format(
                it["id"], it["en"] or "—", it["zh"] or "—",
                it.get("vox") or "—", it.get("mass", "—"), it.get("value", "—")))
        lines.append("")
    with open(OUT_MD, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

    print(f"生成 {OUT_JSON}")
    print(f"生成 {OUT_MD}")
    print(f"共 {len(items)} 条；术语表命中 {len(items) - len(missed)}，未命中 {len(missed)}")
    if missed:
        print("未命中清单（id \\t 英文名）：")
        for d_id, en in missed:
            print(f"  {d_id}\t{en}")


if __name__ == "__main__":
    main()
