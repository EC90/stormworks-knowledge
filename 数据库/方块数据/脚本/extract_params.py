#!/usr/bin/env python3
# -*- coding: utf-8 -*-
r"""
extract_params.py —— 从游戏定义文件里挖出「真实参数」

背景
----
`rom\data\definitions\*.xml` 的 `<definition>` 根元素上挂着几十个属性，
绝大多数是**模板默认值**（所有部件共用一份属性模板，用不到的字段就留着默认值）。
之前 parse_defs.py 只取了 name/category/type/mass/value/voxel/logic，
把 `radar_range`、`rx_range`、`radar_speed`、`pump_pressure`、`cable_length`、
`force_emitter_*`、`electric_magnitude` 这些**真参数**全漏了。

本脚本的办法：**差分**——对每个属性算全库众数（数值归一化后），
与众数不同的才是这个部件真正用到的参数。

⚠ 坑：同一个数值在文件里有 `0` / `0.000000` / `0.0000` 多种写法，
   直接比字符串会把几百个「其实等于默认值」的部件误判成有参数。必须数值归一化。

输出
----
  原始抓取_游戏定义\component_params.json   {英文名: [{attr, label, value, unit, verified}]}

🔴 只读红线：只读 E:\SteamLibrary\...，产出只写 D:\STORMWORKS\。

用法：
  python extract_params.py             # 生成 component_params.json
  python extract_params.py --survey    # 只打印「哪些属性有非默认值」，用于扩充白名单
"""

import glob
import json
import os
import re
import sys
from collections import Counter, defaultdict

import lxml.etree as LET   # 必须用 lxml：physics_shape_rotation 有 00="1" 这种数字开头的属性名，
                           # 不符合 XML 规范，xml.etree 会整份文件报错；lxml recover=True 能过。

DEFS = r"E:\SteamLibrary\steamapps\common\Stormworks\rom\data\definitions"
HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(HERE)
OUT = os.path.join(BASE, "原始抓取_游戏定义", "component_params.json")

# ---------------------------------------------------------------- 白名单
# attr: (中文标签, 单位, 验证状态, 备注, 适用分类 set[str]|None)
#   验证状态 "v" = 已验证（与游戏内 tooltip 或 wiki 数值互证）
#            "?" = 语义/单位由命名推断，未经官方确认
#   适用分类 = 只在这些游戏内分类里认这个参数；None = 不限。
#     ⚠ 这一列是**去噪的关键**：所有部件共用一份属性模板，用不到的字段留着默认值，
#        但有些部件会把无关字段写成 0（如 Static Block 的 rudder_surface_area=0），
#        单靠「≠ 众数」会把几百个这种噪声捞进来。
#   另有两种全局过滤：drop_zero（0 = 不适用）、sane（合理数值区间，挡掉脏值）。
SENSORS = {"7"}                 # S 传感器
MECH = {"4"}                    # M 机械
VEH = {"1", "2"}                # V 控制面 / 载具控制
PROP = {"3"}                    # P 推进
FLUID = {"9", "14"}             # F 流体 / I 工业设备
ELEC = {"10"}                   # E 电力
DECO = {"8"}                    # D 装饰
DISP = {"2", "6"}               # U 显示
WEAP = {"12"}                   # W 武器

PARAMS = {
    # --- 探测 ---
    "radar_range":  ("探测距离", "m", "v", "与游戏内 desc 的 (Range : N) 逐项吻合", SENSORS | MECH, True, None),
    "radar_speed":  ("扫描速度", "?", "?", "仅新雷达/新声纳有；单位未确认", SENSORS, True, None),
    "rx_range":     ("无线电有效距离", "m", "v", "与 desc 的 Max effective range 吻合", VEH | MECH | DISP, True, None),
    # --- 光 ---
    "light_range":     ("光照距离", "?", "?", "", DECO | DISP | VEH | MECH, True, None),
    "light_fov":       ("光锥角", "?", "?", "", DECO | DISP | VEH | MECH, True, None),
    "light_intensity": ("光强", "?", "?", "", DECO | DISP | VEH | MECH, True, None),
    # --- 推进 / 桨 ---
    "force_emitter_max_force":        ("最大推力", "?", "?", "", PROP | VEH, True, None),
    "force_emitter_max_vector":       ("最大矢量", "?", "?", "", PROP | VEH, True, None),
    "force_emitter_efficiency":       ("推进效率", "?", "?", "", PROP, True, None),
    "force_emitter_blade_efficiency": ("桨叶效率", "?", "?", "", PROP, True, None),
    "force_emitter_blade_physics_length": ("桨叶物理长度", "m", "?", "", PROP, True, None),
    "force_emitter_blade_height":     ("桨叶高度", "m", "?", "", PROP, True, None),
    "force_emitter_blade_count":      ("桨叶数", "片", "?", "", PROP, True, None),
    "force_emitter_default_pitch":    ("默认桨距", "?", "?", "", PROP, True, None),
    "engine_max_force":               ("引擎最大力", "?", "?", "", PROP, True, None),
    "rudder_surface_area":            ("舵面面积", "?", "?", "", VEH, True, None),
    # --- 电力 ---
    "electric_magnitude":      ("电力系数", "?", "?", "发电机/用电器功率系数", ELEC | PROP | MECH, True, None),
    "electric_charge_capacity": ("储电容量", "?", "?", "", ELEC | MECH | DISP, True, None),
    "electric_type":           ("电气类型", "enum", "?", "", ELEC | MECH | PROP, False, None),
    # --- 流体 / 热 ---
    "pump_pressure":        ("泵压", "?", "?", "", FLUID | PROP | MECH, True, None),
    "water_component_type": ("水系统部件类型", "enum", "?", "", FLUID, False, None),
    "steam_component_type": ("蒸汽部件类型", "enum", "?", "", FLUID, False, None),
    # --- 浮力 ---
    "buoy_radius": ("浮力半径", "m", "?", "", {"0"} | VEH | MECH | PROP, True, (0, 100)),
    "buoy_factor": ("浮力系数", "?", "?", "", {"0"} | VEH | MECH | PROP, True, (0, 100)),
    "buoy_force":  ("浮力", "?", "?", "", {"0"} | VEH | MECH | PROP, True, (0, 1e6)),
    # --- 缆 / 磁 ---
    "cable_length": ("缆长", "m", "?", "绞车与绳索类", MECH | VEH, True, (0, 1e6)),
    "cable_radius": ("缆半径", "m", "?", "", MECH | VEH, True, (0, 100)),
    "magnet_force": ("磁力", "?", "?", "", MECH | VEH, True, None),
    # --- 机构 ---
    "max_motor_force": ("马达最大力矩", "?", "?", "", MECH | VEH | PROP, True, None),
    "max_motor_speed": ("马达最大转速", "?", "?", "", MECH | VEH | PROP, True, None),
    "constraint_range_of_motion": ("约束行程", "?", "?", "", MECH | VEH, True, None),
    "constraint_axis":     ("约束轴", "enum", "?", "", MECH | VEH, False, None),
    "constraint_type":     ("约束类型", "enum", "?", "", MECH | VEH, False, None),
    "dynamic_max_rotation": ("最大转角", "?", "?", "", VEH | MECH, True, None),
    "dynamic_min_rotation": ("最小转角", "?", "?", "", VEH | MECH, False, None),
    # --- 轮 ---
    "wheel_radius":           ("轮半径", "m", "?", "", VEH, True, None),
    "wheel_suspension_height": ("悬挂高度", "m", "?", "", VEH, True, None),
    "wheel_wishbone_length":  ("叉臂长度", "m", "?", "", VEH, True, None),
    "phys_collision_dampen":  ("碰撞阻尼", "?", "?", "", VEH | MECH, True, None),
    # --- 座椅 ---
    "seat_pose":           ("坐姿", "enum", "?", "", MECH | VEH, False, None),
    "seat_health_per_sec": ("每秒治疗量", "?", "?", "", MECH | VEH, True, None),
    # --- 武器 ---
    "weapon_class":                ("武器类别", "enum", "?", "", WEAP, False, None),
    "weapon_type":                 ("武器类型", "enum", "?", "", WEAP, False, None),
    "weapon_ammo_capacity":        ("弹药容量", "发", "?", "", WEAP, True, None),
    "weapon_barrel_length_voxels": ("炮管长度", "格", "?", "", WEAP, True, None),
    "weapon_belt_type":            ("弹链类型", "enum", "?", "", WEAP, False, None),
    # --- 引擎 / 喷气 ---
    "engine_module_type":        ("引擎模块类型", "enum", "?", "模块化引擎", {"13"}, False, None),
    "jet_engine_component_type": ("喷气部件类型", "enum", "?", "", {"11"}, False, None),
    # --- 逻辑 / 显示 / 连接 ---
    "logic_gate_type":    ("逻辑门类型", "enum", "?", "", {"5"} | SENSORS, False, None),
    "logic_gate_subtype": ("逻辑门子类型", "enum", "?", "", {"5"} | SENSORS, False, None),
    "indicator_type":     ("仪表类型", "enum", "?", "", DISP | VEH, False, None),
    "monitor_border":     ("屏幕边框", "m", "?", "", {"6"}, True, None),
    "monitor_inset":      ("屏幕内缩", "m", "?", "", {"6"}, True, None),
    "connector_type":     ("连接器类型", "enum", "?", "", VEH | MECH | ELEC, False, None),
    "trans_conn_type":    ("管道类型", "enum", "?", "", FLUID, False, None),
    "block_type":         ("方块形状", "enum", "?", "", {"0"}, False, None),
    # --- 物品栏 ---
    "inventory_class":        ("物品栏类别", "enum", "?", "", MECH, False, None),
    "inventory_default_item": ("默认物品", "enum", "?", "", MECH, False, None),
}

# 只看这些；其余（audio_*、mesh_*、door_* 等）不是"部件参数"
SKIP_PREFIX = ("audio_", "mesh", "sfx_")
SKIP_SUFFIX = ("_name", "_map", "_ogg", "_mesh")


def nkey(v):
    """数值归一化：把 '0' / '0.000000' / '0.0' 归一成同一个键。"""
    s = (v or "").strip()
    try:
        f = float(s)
    except ValueError:
        return ("s", s.lower())
    return ("n", round(f, 6))


def is_num(v):
    return nkey(v)[0] == "n"


def fmt(v):
    try:
        f = float(v)
    except (TypeError, ValueError):
        return v
    return str(int(f)) if f == int(f) else ("%g" % f)


def load():
    p = LET.XMLParser(recover=True)
    recs = []
    for f in sorted(glob.glob(os.path.join(DEFS, "*.xml"))):
        try:
            root = LET.parse(f, p).getroot()
        except Exception:
            continue
        if root is None or root.tag != "definition":
            continue
        recs.append((os.path.basename(f), root.get("name") or "",
                     root.get("category") or "", dict(root.attrib)))
    return recs


def compute_defaults(recs):
    """每个属性在全库中的众数 = 模板默认值。"""
    vals = defaultdict(Counter)
    for _, _, _, a in recs:
        for k, v in a.items():
            vals[k][nkey(v)] += 1
    return {k: c.most_common(1)[0][0] for k, c in vals.items()}


def main():
    recs = load()
    if not recs:
        print("[x] 没解析到任何定义，检查路径：%s" % DEFS)
        return 1
    defaults = compute_defaults(recs)

    if "--survey" in sys.argv:
        print("[i] 解析 %d 个定义\n" % len(recs))
        print("%-36s %6s %-14s %s" % ("属性", "非默认", "默认(众数)", "示例"))
        print("-" * 110)
        rows = []
        for k in defaults:
            if any(k.startswith(p) for p in SKIP_PREFIX):
                continue
            if any(k.endswith(s) for s in SKIP_SUFFIX):
                continue
            nd = []
            for fn, name, cat, a in recs:
                if k in a and nkey(a[k]) != defaults[k]:
                    nd.append((name, a[k]))
            if nd:
                rows.append((len(nd), k, nd))
        for n, k, nd in sorted(rows, key=lambda x: -x[0]):
            ex = "，".join("%s=%s" % (nm, v) for nm, v in nd[:3])
            mark = "★" if k in PARAMS else " "
            print("%s%-35s %6d  %-14s %s" % (mark, k, n, fmt(str(defaults[k][1])), ex))
        return 0

    out = {}
    for fn, name, cat, a in recs:
        got = []
        for attr, spec in PARAMS.items():
            label, unit, verified, note, cats, drop_zero, sane = spec
            if attr not in a:
                continue
            if cats is not None and cat not in cats:
                continue
            raw = a[attr]
            if nkey(raw) == defaults[attr]:
                continue
            try:
                fv = float(raw)
            except (TypeError, ValueError):
                fv = None
            if fv is not None:
                if drop_zero and fv == 0:
                    continue
                if sane is not None and not (sane[0] <= fv <= sane[1]):
                    continue          # 脏值：如 cable_length=-431602080（未初始化的内存残值）
            got.append({
                "attr": attr, "label": label, "value": fmt(raw),
                "unit": unit, "verified": verified, "note": note,
            })
        if got:
            got.sort(key=lambda x: (x["verified"] != "v", x["attr"]))
            out.setdefault(name, {"file": fn, "category": cat, "params": []})
            # 同名部件（如 Radar (Dish) 有两个文件）合并参数
            for g in got:
                if g not in out[name]["params"]:
                    out[name]["params"].append(g)

    data = {
        "_meta": {
            "source": r"E:\SteamLibrary\steamapps\common\Stormworks\rom\data\definitions\*.xml",
            "definitions": len(recs),
            "components_with_params": len(out),
            "note": "只列与各属性全库众数（模板默认值）不同的参数；数值已归一化。",
            "verified": "v=与游戏内 tooltip 或 wiki 数值互证；?=语义由命名推断，未确认",
        },
        "components": out,
    }
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, "w", encoding="utf-8", newline="\n") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

    nparam = sum(len(v["params"]) for v in out.values())
    print("[✓] 已写入 %s" % OUT)
    print("    定义 %d 个 · 有参数的部件 %d 个 · 参数条目 %d 条"
          % (len(recs), len(out), nparam))
    return 0


if __name__ == "__main__":
    sys.exit(main())
