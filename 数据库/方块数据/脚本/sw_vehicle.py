#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""载具 XML 解读工具：把 Stormworks 载具存档里的 <c d="..."> 编号翻译成中文部件名。

编号链：d 属性 → 定义文件名 → 游戏内英文名 → 汉化译名（对照表 xml_id_map.json）。
游戏更新后先重跑 build_xml_id_map.py 再用本工具。纯标准库，零依赖。

用法：
  sw_vehicle.py stats <载具.xml>    # 部件统计（中文名 × 数量，按类别分组）
  sw_vehicle.py list  <载具.xml>    # 逐部件清单（id/中文名/t/坐标）
  sw_vehicle.py find  <关键词>      # 按 id 或中英文关键词反查编号
输出末尾附一行 JSON 摘要，供 AI 直接消费。
"""
import json
import os
import re
import sys
import xml.etree.ElementTree as ET
from collections import Counter, defaultdict

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(HERE)                       # 数据库/方块数据/
WS = os.path.dirname(os.path.dirname(BASE))
MAP_JSON = os.path.join(BASE, "数据", "xml_id_map.json")

CAT_NAME = {
    "":  "其他/管道(no category)",
    "0": "B 基础方块", "1": "V 控制面", "2": "V 载具控制/仪表", "3": "P 推进",
    "4": "M 机械", "5": "L 逻辑", "6": "U 显示", "7": "S 传感器",
    "8": "D 装饰", "9": "F 流体", "10": "E 电力", "11": "J 喷气引擎",
    "12": "W 武器/弹药", "13": "M 模块化引擎", "14": "I 工业设备", "15": "W 窗户",
}

_MAP = None


def load_map():
    global _MAP
    if _MAP is None:
        with open(MAP_JSON, encoding="utf-8") as f:
            doc = json.load(f)
        _MAP = {it["id"]: it for it in doc["components"]}
    return _MAP


def zh_name(d_id):
    it = load_map().get(d_id)
    if it is None:
        return None
    return it["zh"] or it["en"] or d_id


def iter_components(tree):
    """遍历 bodies/body/components/c，产出 (elem, body_unique_id)。"""
    for body in tree.iter("body"):
        uid = body.get("unique_id", "?")
        comps = body.find("components")
        if comps is None:
            continue
        for c in comps.findall("c"):
            yield c, uid


def coord_of(c):
    vp = c.find("./o/vp")
    if vp is not None:
        return f"({vp.get('x','?')},{vp.get('y','?')},{vp.get('z','?')})"
    return ""


def parse_vehicle(path):
    with open(path, encoding="utf-8", errors="ignore") as f:
        raw = f.read()
    # Stormworks 载具 XML 不是合法 XML：矩阵属性名以数字开头（00="1" 01="0"…），
    # ElementTree 无法解析。预处理：给数字开头的属性名加下划线前缀。
    raw = re.sub(r'\s(\d+)="', r' _\1="', raw)
    tree = ET.fromstring(raw)
    counts = Counter()          # (d, t) -> n
    pos = defaultdict(list)     # d -> [坐标]
    bodies = set()
    for c, uid in iter_components(tree):
        d = c.get("d", "?")
        counts[(d, c.get("t", "?"))] += 1
        pos[d].append(coord_of(c))
        bodies.add(uid)
    return tree, counts, pos, sorted(bodies)


def unrecognized(counts):
    m = load_map()
    return sorted({d for (d, _) in counts if d not in m})


def cmd_stats(path):
    _, counts, pos, bodies = parse_vehicle(path)
    groups = defaultdict(Counter)   # 类别 -> 中文名(id) -> n
    for (d, _), n in counts.items():
        it = load_map().get(d)
        cat = CAT_NAME.get(str(it.get("category")), f"分类{it.get('category')}") if it else "未识别"
        label = zh_name(d) if it else d
        groups[cat][f"{label} [`{d}`]"] += n
    total = sum(counts.values())
    print(f"载具文件 : {os.path.basename(path)}")
    print(f"body 数  : {len(bodies)}   部件总数 : {total}   部件种数 : {len({d for d,_ in counts})}")
    for cat in sorted(groups):
        print(f"\n【{cat}】")
        for label, n in sorted(groups[cat].items(), key=lambda kv: -kv[1]):
            print(f"  {label} × {n}")
    summary(total, counts)


def cmd_list(path, limit=None):
    _, counts, pos, _ = parse_vehicle(path)
    total = sum(counts.values())
    print(f"载具文件 : {os.path.basename(path)}   部件总数 : {total}")
    print(f"{'d (编号)':<38} {'t':<4} {'中文名':<22} {'类别':<8} {'n':<5} 坐标(前3)")
    for (d, t), n in sorted(counts.items()):
        it = load_map().get(d)
        zh = zh_name(d) if it else "!!未识别"
        cat = CAT_NAME.get(str(it.get("category")), "?") if it else "?"
        coords = ", ".join(pos[(d, t)][:3]) + (" …" if len(pos[(d, t)]) > 3 else "")
        print(f"{d:<38} {t:<4} {zh:<22} {cat:<8} {n:<5} {coords}")
    summary(total, counts)


def cmd_find(keyword):
    m = load_map()
    kw = keyword.strip().lower()
    hits = []
    for it in m.values():
        hay = f"{it['id']} {it['en']} {it['zh']}".lower()
        if kw in hay:
            hits.append(it)
    if not hits:
        print(f"未找到匹配「{keyword}」的部件编号")
        return
    print(f"{'id (载具XML d值)':<40} 英文名                 中文名")
    for it in hits[:40]:
        print(f"{it['id']:<40} {it['en']:<22} {it['zh']}")
    if len(hits) > 40:
        print(f"… 共 {len(hits)} 条，仅显示前 40")
    print(json.dumps({"find": keyword, "hits": len(hits),
                      "results": [{"id": it["id"], "en": it["en"], "zh": it["zh"]} for it in hits[:40]]},
                     ensure_ascii=False))


def summary(total, counts):
    print(json.dumps({
        "total": total,
        "kinds": len({d for d, _ in counts}),
        "counts": {d: n for (d, _), n in sorted(counts.items())},
        "unrecognized": unrecognized(counts),
    }, ensure_ascii=False))


def main():
    args = sys.argv[1:]
    if not args:
        print(__doc__)
        sys.exit(1)
    cmd = args[0]
    if cmd == "stats" and len(args) == 2:
        cmd_stats(args[1])
    elif cmd == "list" and len(args) == 2:
        cmd_list(args[1])
    elif cmd == "find" and len(args) == 2:
        cmd_find(args[1])
    else:
        print(__doc__)
        sys.exit(1)


if __name__ == "__main__":
    main()
