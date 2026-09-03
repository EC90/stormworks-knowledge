#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
只读解析 Stormworks 游戏定义文件（E:\SteamLibrary\...\rom\data\definitions\*.xml），
导出权威部件索引（name/mass/value/尺寸/描述/逻辑节点），用于校验与补全 D:\STORMWORKS\数据库。

只读游戏文件，绝不修改。输出写入 D:\STORMWORKS\数据库\方块数据\原始抓取_游戏定义\。

注意：游戏 XML 中部分属性名以数字开头（如 physics_shape_rotation 的 00="1"），
违反 XML 规范，标准 ElementTree 会整文件拒绝。故用 lxml(recover=True) 容错解析。
"""
import os, json, glob
import lxml.etree as LET

SRC = r"E:/SteamLibrary/steamapps/common/Stormworks/rom/data/definitions"
OUT = r"D:/STORMWORKS/数据库/方块数据/原始抓取_游戏定义"
os.makedirs(OUT, exist_ok=True)

VOX = 0.25  # 1 voxel = 0.25 m

# 逻辑节点 type 码含义（据 Stormworks 定义经验 + 游戏 XML 实测）
# 1=数值 2=开关 3=连接(流体/绳索) 4=电力 5=数据/视频 8=绳索/网络连接
def type_name(t):
    return {"1": "数值", "2": "开关", "3": "连接口", "4": "电力",
            "5": "数据", "8": "绳索"}.get(t, f"type{t}")

def parse_file(path):
    try:
        tree = LET.parse(path, LET.XMLParser(recover=True))
    except Exception as e:
        return None
    root = tree.getroot()
    if root is None or root.tag != "definition":
        return None
    a = root.attrib
    rec = {
        "file": os.path.basename(path),
        "name": a.get("name", ""),
        "category": a.get("category", ""),
        "type": a.get("type", ""),
        "mass": a.get("mass", ""),
        "value": a.get("value", ""),
        "tags": a.get("tags", ""),
    }
    # 尺寸（voxel）
    vm = root.find("voxel_min"); vx = root.find("voxel_max")
    if vm is not None and vx is not None:
        try:
            sx = int(float(vx.get("x"))) - int(float(vm.get("x"))) + 1
            sy = int(float(vx.get("y"))) - int(float(vm.get("y"))) + 1
            sz = int(float(vx.get("z"))) - int(float(vm.get("z"))) + 1
            rec["vox"] = f"{sx}x{sy}x{sz}"
            rec["size_m"] = f"{sx*VOX:.2f}x{sy*VOX:.2f}x{sz*VOX:.2f}"
        except (TypeError, ValueError):
            rec["vox"] = ""
    # tooltip
    tp = root.find("tooltip_properties")
    if tp is not None:
        rec["desc"] = (tp.get("description") or "").strip()
        rec["short"] = (tp.get("short_description") or "").strip()
    # logic nodes
    nodes = []
    ln = root.find("logic_nodes")
    if ln is not None:
        for n in ln.findall("logic_node"):
            na = n.attrib
            nodes.append({
                "label": na.get("label", ""),
                "type": na.get("type", ""),
                "mode": na.get("mode", ""),
                "desc": (na.get("description") or "").strip(),
            })
    rec["logic"] = nodes
    return rec

def main():
    files = sorted(glob.glob(os.path.join(SRC, "*.xml")))
    all_recs = []
    failed = []
    for f in files:
        r = parse_file(f)
        if r and r.get("name"):
            all_recs.append(r)
        else:
            failed.append(os.path.basename(f))
    # 全量 JSON
    with open(os.path.join(OUT, "components_index.json"), "w", encoding="utf-8") as fh:
        json.dump(all_recs, fh, ensure_ascii=False, indent=1)
    # 索引名→文件/基础属性，便于快速查
    idx = {r["name"]: {"file": r["file"], "mass": r["mass"], "value": r["value"],
                       "vox": r.get("vox", ""), "size_m": r.get("size_m", ""),
                       "tags": r["tags"], "n_logic": len(r["logic"])} for r in all_recs}
    with open(os.path.join(OUT, "name_index.json"), "w", encoding="utf-8") as fh:
        json.dump(idx, fh, ensure_ascii=False, indent=1)

    # 聚焦：工业先锋 DLC + 喷气引擎 相关文件名
    focus_kw = ["furnace_electric","furnace_industrial","steam_coal","lobster_pot",
                "rope_hook_net","steam_nuclear","oil_rig","steam_boiler","steam_condenser",
                "steam_piston","steam_turbine","steam_whistle",
                "jet_engine"]
    focus = [r for r in all_recs if any(k in r["file"] for k in focus_kw)]

    # 输出 markdown 摘要
    md = ["# 游戏定义聚焦提取（工业先锋 DLC + 喷气引擎）", "",
          "> 源：`E:/SteamLibrary/steamapps/common/Stormworks/rom/data/definitions/*.xml`（lxml recover 只读解析）",
          f"> 共解析 {len(all_recs)} 个定义文件；聚焦 {len(focus)} 个。", ""]
    for r in focus:
        md.append(f"## {r['name']}  (`{r['file']}`)")
        md.append(f"- mass={r['mass']}  value=${r['value']}  vox={r.get('vox','')}  size={r.get('size_m','')}  tags={r['tags']}")
        if r.get("short"):
            md.append(f"- 简述：{r['short']}")
        if r.get("desc"):
            md.append(f"- 描述：{r['desc']}")
        if r["logic"]:
            md.append(f"- 逻辑节点（{len(r['logic'])}）：")
            for n in r["logic"]:
                tn = type_name(n["type"])
                io = "入" if n["mode"] == "1" else ("出" if n["mode"] == "0" else "")
                extra = f" [{tn}{('/'+io) if io else ''}]"
                d = f" — {n['desc']}" if n["desc"] else ""
                md.append(f"  - {n['label']}{extra}{d}")
        md.append("")
    with open(os.path.join(OUT, "industry_jet_extract.md"), "w", encoding="utf-8") as fh:
        fh.write("\n".join(md))

    print(f"解析完成：{len(all_recs)} 个定义 → components_index.json / name_index.json")
    if failed:
        print(f"跳过（无定义/无 name）：{len(failed)} 个")
    print(f"聚焦工业+喷气：{len(focus)} 个 → industry_jet_extract.md")
    print("聚焦部件名：")
    for r in focus:
        print(f"  {r['name']:32s} mass={r['mass']:>6}  ${r['value']:>6}  {r.get('vox',''):>7}  nodes={len(r['logic'])}")

if __name__ == "__main__":
    main()
