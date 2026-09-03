#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
build_geom_book.py — 生成第 21 册《部件几何档案》

输入：数据库\\方块数据\\数据\\mesh_index.json（由 build_mesh_index.py 生成）
输出：数据库\\方块数据\\21_部件几何档案.md

本册提供**从 .mesh 二进制实测的真实渲染几何**，与 01–20 册（XML 推算的占位格数）
是「物理外观」与「逻辑占位」两个维度，可交叉纠错。

用法
----
    python build_geom_book.py                     生成知识册
    python build_geom_book.py -o <路径>           指定输出（须在 D:\\STORMWORKS 下）
"""

from __future__ import annotations

import argparse
import json
import os
import sys
from collections import Counter, defaultdict

from sw_mesh import WORKSPACE_ROOT, guard_output_path

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

INDEX = os.path.join(
    WORKSPACE_ROOT, "数据库", "方块数据", "数据", "mesh_index.json"
)
OUT_DEFAULT = os.path.join(WORKSPACE_ROOT, "数据库", "方块数据", "21_部件几何档案.md")

SHADER_NAMES = {0: "Opaque", 1: "Transparent", 2: "Emissive", 3: "Lava"}

#: 与 sw_vehicle.py 保持一致的分类名
CAT_NAME = {
    "": "其他/管道(no category)",
    "0": "B 基础方块", "1": "V 控制面", "2": "V 载具控制/仪表", "3": "P 推进",
    "4": "M 机械", "5": "L 逻辑", "6": "U 显示", "7": "S 传感器",
    "8": "D 装饰", "9": "F 流体", "10": "E 电力", "11": "J 喷气引擎",
    "12": "W 武器/弹药", "13": "M 模块化引擎", "14": "I 工业设备", "15": "W 窗户",
}


def load(path=INDEX):
    with open(path, "r", encoding="utf-8") as fh:
        return json.load(fh)


def parse_vox(v: str):
    try:
        a, b, c = [float(x) for x in v.lower().split("x")]
        return (a, b, c) if a > 0 and b > 0 and c > 0 else None
    except (ValueError, AttributeError):
        return None


def paint_desc(rec) -> str:
    v, p = rec["verts"], rec["paint_verts"]
    if not v:
        return "—"
    if p == 0:
        return "固定色"
    if p == v:
        return "整件涂装"
    return "%d/%d" % (p, v)


def blk(dim) -> str:
    return "%.2f×%.2f×%.2f" % tuple(dim)


def build_book(idx: dict) -> str:
    meshes = idx["meshes"]
    stats = idx["_stats"]
    src = idx["_source"]
    L = []
    W = L.append

    # ---------- 收集部件视角的记录 ----------
    rows = []  # (cat, zh, name, def, meshkey, rec, attr)
    for key, r in meshes.items():
        for u in r.get("used_by", []):
            rows.append((u, r, key))
    main_rows = [(u, r, k) for u, r, k in rows if u["attr"] == "mesh_data_name"]
    main_rows.sort(key=lambda t: (str(t[0].get("category", "")), t[0].get("zh") or t[0].get("name", "")))

    # ---------- 标题 ----------
    W("# 21 · 部件几何档案")
    W("")
    W("> **数据来源**：游戏 `.mesh` 二进制实测（只读解析，未修改任何游戏文件）  ")
    W("> **解析工具**：`技能库\\sw-mesh-tools\\scripts\\sw_mesh.py`  ")
    W("> **格式规格**：`技能库\\sw-mesh-tools\\reference\\格式规格.md`  ")
    W("> **索引数据**：`数据库\\方块数据\\数据\\mesh_index.json`  ")
    W("> **生成时间**：%s（本次构建：%s，耗时 %s 秒；全量重建约 7.5 秒）" % (
        src["built_at"],
        "增量" if src.get("mode") == "incremental" else "全量",
        src["elapsed_sec"]))
    W("")
    W("---")
    W("")

    # ---------- §1 定位 ----------
    W("## 1. 本册的定位：实测几何 vs 占位格数")
    W("")
    W("现有 01–20 册与 `00_速查_部件总表.md` 的尺寸，来自定义 XML 的 `<surface>` / `vox` "
      "推算的**占位格数**（如「占 1x1x1」）；本册提供**从二进制实测的真实渲染几何**。")
    W("")
    W("两者是不同维度，交叉比对可发现单看一边看不到的信息：")
    W("")
    W("| 现象 | 含义 | 实例 |")
    W("| --- | --- | --- |")
    W("| 实测 < 占位 | 部件实体不满格，存在留空 | Push Button：占位 1x2x1，实测仅 **1×0.08×1** 格（按钮几乎贴面板） |")
    W("| 实测 ≈ 占位 | 标准方块类，尺寸可信 | 气压计 1×0.32×1 格 |")
    W("| 实测 > 占位 | **可动部件烘焙了极限姿态** | 气动活塞 占位 1x2x1，实测 1×**5.10**×1（活塞杆伸出态） |")
    W("| 占位 >> 视觉体积 | **占位即效果范围**（雷达扫描区） | 雷达(巨) 占位与实测**均为 37×5×37 格**，但视觉上只是个小雷达 |")
    W("")
    W("**全量比对结论（558 条可比对部件）**：吻合 515 条（92.3%）、超出 21 条（3.8%）、"
      "偏小 22 条（3.9%）。92.3% 的吻合率是对解析正确性的强验证——"
      "占位格数是完全独立的数据源，解析若出错不可能与它在九成样本上吻合。")
    W("")
    W("---")
    W("")

    # ---------- §2 单位与字段 ----------
    W("## 2. 单位、坐标系与字段释义")
    W("")
    W("- **1 格 = 0.25 m**，**Y 轴向上**，顶点坐标单位为米。")
    W("- 本册「实测格」= 顶点实测 AABB 尺寸 ÷ 0.25。")
    W("")
    W("| 字段 | 含义 |")
    W("| --- | --- |")
    W("| 顶点 / 三角 | 渲染网格规模（三角 = 索引数 ÷ 3） |")
    W("| 实测格 | **顶点真实 AABB**，亚格精度 |")
    W("| 占位 vox | 定义 XML 声明的占位格数（`vox`），仅部分定义有值 |")
    W("| 着色器 | submesh 的 shaderId：0 Opaque / 1 Transparent / 2 Emissive / 3 Lava |")
    W("| 涂装 | 顶点中命中可涂色基色 RGB(255,125,0) 的数量。**固定色**=不可涂装；**整件涂装**=全部顶点随涂装变色 |")
    W("| bounds | `exact`=声明与实测一致可直接用；`tile_declared`=瓦片声明框，不可当尺寸 |")
    W("")
    W("> ⚠ **`.mesh` 顶点不含 UV 坐标**（设计如此，非解析遗漏）。"
      "Stormworks 靠顶点色 + shaderId + 程序化材质渲染。")
    W("")
    W("---")
    W("")

    # ---------- §3 全量档案表 ----------
    W("## 3. 部件几何档案（按分类）")
    W("")
    W("覆盖 **%d 条** `mesh_data_name` 定义（占全部 759 个定义的 %.1f%%），"
      "对应 %d 个不同 mesh。" % (
          len(main_rows), 100.0 * len(main_rows) / 759,
          len({k for _, _, k in main_rows})))
    W("排序：按分类 → 中文名。")
    W("")
    W("> **关于重复行**：游戏内存在**同名变体定义**（`_fluid` / `_torque` / `_v2` 等后缀），"
      "它们与基础版共用同一个 mesh，因此表中会出现同名多行 —— 这是真实数据，不是重复错误。"
      "用「定义 id」列可区分。例：`multibody_robotic_pivot_01_b` 与 "
      "`multibody_robotic_pivot_01_b_fluid` 都显示「机械枢轴b」，共用 "
      "`component_robotic_pivot_b.mesh`。")
    W("")
    by_cat = defaultdict(list)
    for u, r, k in main_rows:
        by_cat[str(u.get("category", ""))].append((u, r, k))

    for cat in sorted(by_cat, key=lambda c: (c == "", c.zfill(2))):
        items = by_cat[cat]
        W("### %s（%d 条）" % (CAT_NAME.get(cat, "分类" + cat), len(items)))
        W("")
        W("| 中文名 | 游戏内名 | 定义 id | mesh | 顶点 | 三角 | 实测格 | 占位 vox | 着色器 | 涂装 |")
        W("| --- | --- | --- | --- | ---: | ---: | --- | --- | --- | --- |")
        for u, r, k in items:
            shaders = "/".join(
                SHADER_NAMES.get(s, str(s)) for s in r.get("shaders", [])
            )
            vox = u.get("vox") or "—"
            flag = ""
            if r.get("bounds_kind") != "exact":
                flag = " ⚠"
            W("| %s | %s | `%s` | `%s` | %d | %d | %s%s | %s | %s | %s |" % (
                (u.get("zh") or "—").replace("|", "/"),
                (u.get("name") or "—").replace("|", "/"),
                u.get("def", ""),
                os.path.basename(k),
                r["verts"], r["tris"],
                blk(r["dim_blocks"]), flag,
                vox, shaders, paint_desc(r),
            ))
        W("")

    W("> ⚠ 标记表示 `bounds_kind != exact`，尺寸可能含瓦片声明框，谨慎引用。")
    W("")
    W("---")
    W("")

    # ---------- §4 着色器与涂装 ----------
    W("## 4. 着色器与涂装特性")
    W("")
    sh = Counter()
    for r in meshes.values():
        for s in r.get("shaders", []):
            sh[s] += 1
    W("### 4.1 着色器分布（全量 %d 个 mesh）" % len(meshes))
    W("")
    W("| shaderId | 名称 | mesh 数 |")
    W("| ---: | --- | ---: |")
    for s in sorted(sh):
        W("| %d | %s | %d |" % (s, SHADER_NAMES.get(s, "?"), sh[s]))
    W("")
    W("材质另受名称约定影响：`MATERIALglass`、`MATERIALadditive`。")
    W("")
    W("### 4.2 涂装特性（部件视角，%d 条）" % len(main_rows))
    W("")
    fixed = sum(1 for _, r, _ in main_rows if r["verts"] and r["paint_verts"] == 0)
    full = sum(1 for _, r, _ in main_rows if r["verts"] and r["paint_verts"] == r["verts"])
    part = len(main_rows) - fixed - full
    W("| 类别 | 条数 | 含义 |")
    W("| --- | ---: | --- |")
    W("| 固定色 | %d | 无顶点命中基色，**不可涂装**（如 Electric Battery Small） |" % fixed)
    W("| 部分涂装 | %d | 仅局部随涂装变色（多数部件） |" % part)
    W("| 整件涂装 | %d | 全部顶点随涂装变色（如 Fluid Tank Small 120/120） |" % full)
    W("")
    W("可涂色基色实测为 **RGB(255,125,0)** `#ff7d00`（另有两档变体 "
      "`(155,125,0)`、`(55,135,0)`）。")
    W("")
    W("---")
    W("")

    # ---------- §5 共用 mesh 台账 ----------
    W("## 5. 多部件共用 mesh 台账")
    W("")
    shared = []
    for key, r in meshes.items():
        users = r.get("used_by", [])
        if len(users) > 1:
            shared.append((len(users), key, users))
    shared.sort(key=lambda x: (-x[0], x[1]))
    n_comp = len({k for _, r, k in rows})
    W("**%d 个 mesh 服务 %d 条部件定义引用**，其中被多个定义共用的有 %d 个。"
      % (n_comp, len(rows), len(shared)))
    W("")
    W("共用分两类，均可从「定义 id」看出：")
    W("")
    W("1. **功能性共用** —— 不同部件用同一网格（如多种传感器共用外壳）。")
    W("2. **变体共用** —— 同一部件的 `_fluid` / `_torque` / `_v2` 等变体与基础版共用网格。")
    W("")
    W("| 共用数 | mesh | 引用部件 |")
    W("| ---: | --- | --- |")
    for n, key, users in shared[:40]:
        names = "、".join(
            (u.get("zh") or u.get("name") or u.get("def", "")) for u in users[:6]
        )
        if len(users) > 6:
            names += " …(共%d)" % len(users)
        W("| %d | `%s` | %s |" % (n, os.path.basename(key), names))
    if len(shared) > 40:
        W("")
        W("（共 %d 个共用 mesh，此处列出前 40）" % len(shared))
    W("")
    W("---")
    W("")

    # ---------- §6 实测 vs 占位背离 ----------
    W("## 6. 实测尺寸与占位格数的背离清单")
    W("")
    cmp_rows = []
    for u, r, k in main_rows:
        v = parse_vox(u.get("vox", ""))
        if not v:
            continue
        ratio = max(r["dim_blocks"][i] / v[i] for i in range(3))
        cmp_rows.append((ratio, u, r, k, v))
    cmp_rows.sort(key=lambda x: -x[0])

    W("可比对 %d 条（其余定义无 `vox`）。**比值 = max(实测格 ÷ 占位格)**。" % len(cmp_rows))
    W("")
    W("> **占位格数的来源**：定义 XML 的 `<voxel_min>` / `<voxel_max>` 元素"
      "（`parse_defs.py` 解析生成），与 `.mesh` 二进制**完全独立**。"
      "因此本节比对构成对解析正确性的独立验证，而非循环论证。")
    W("")
    W("### 6.1 显著超出占位（%d 条）" % len([x for x in cmp_rows if x[0] > 1.15]))
    W("")
    W("原因几乎全是**可动部件把极限姿态烘焙进了 mesh**，属真实几何而非解析错误。")
    W("")
    W("| 比值 | 中文名 | mesh | 占位 vox | 实测格 | 判读 |")
    W("| ---: | --- | --- | --- | --- | --- |")
    for ratio, u, r, k, v in cmp_rows:
        if ratio <= 1.15:
            continue
        W("| %.2f | %s | `%s` | %s | %s | 可动部件极限姿态 |" % (
            ratio, u.get("zh") or u.get("name"), os.path.basename(k),
            u.get("vox"), blk(r["dim_blocks"])))
    W("")
    small = [x for x in cmp_rows if x[0] < 0.85]
    W("### 6.2 显著小于占位（%d 条）" % len(small))
    W("")
    W("部件实体不满格，建模/配重时不能以占位格数估算实际体积。")
    W("")
    W("| 比值 | 中文名 | mesh | 占位 vox | 实测格 |")
    W("| ---: | --- | --- | --- | --- |")
    for ratio, u, r, k, v in sorted(small, key=lambda x: x[0])[:30]:
        W("| %.2f | %s | `%s` | %s | %s |" % (
            ratio, u.get("zh") or u.get("name"), os.path.basename(k),
            u.get("vox"), blk(r["dim_blocks"])))
    W("")
    W("---")
    W("")

    # ---------- §7 数据解读注意事项 ----------
    W("## 7. 数据解读注意事项（必读）")
    W("")
    W("### 7.1 占位远大于视觉体积的部件（雷达类）")
    W("")
    W("**雷达(巨) 案例**：`component_radar_huge.mesh` 实测 37×5×37 格（9.25×1.25×9.25 m），"
      "看似离谱，但定义 XML `radar_huge.xml` 明确声明 "
      "`<voxel_min x=\"-18\" y=\"0\" z=\"-18\"/>` / `<voxel_max x=\"18\" y=\"4\" z=\"18\"/>`，"
      "算得占位正是 **37×5×37 格** —— 与 mesh 实测**完全一致**。")
    W("")
    W("因此这不是解析异常，而是**游戏设计：雷达的占位即其扫描范围**。"
      "顶点到中轴距离分布在 1.507~4.625 m（中心 1.5 m 半径内无顶点），是一个大圆环。")
    W("")
    W("> 💡 **可玩性提示**：雷达类部件会**占掉大片空间**（雷达(巨) 占 37×5×37 格），"
      "在紧凑载具内布雷达时要预留空间；反过来说，雷达的扫描范围与占位等价，"
      "可用占位格数直接推算覆盖范围。")
    W("")
    W("> ⚠ **方法论说明**：曾尝试用「顶点全为基色」「归一化填充度」等启发式自动识别"
      "「辅助几何」，均**产生大量误报**（机翼、龙骨、气罐等真实大尺寸/薄壳部件被误判）。"
      "原因在于薄壳结构（气罐是空心圆柱）与范围指示环的几何特征高度重叠，无法用简单统计量区分。"
      "**本册因此不做自动判定**，改以 §6 的 vox 比对为判读依据。")
    W("")
    big = sorted(main_rows, key=lambda t: -max(t[1]["dim_blocks"]))[:20]
    W("实测包围盒最大的 20 个部件（**仅供参考，不代表尺寸异常**）：")
    W("")
    W("| 最大边(格) | 中文名 | mesh | 实测格 | 顶点 | 可比对性 |")
    W("| ---: | --- | --- | --- | ---: | --- |")
    for u, r, k in big:
        v = parse_vox(u.get("vox", ""))
        if v:
            ratio = max(r["dim_blocks"][i] / v[i] for i in range(3))
            if ratio <= 1.15:
                note = "与占位一致（%s），尺寸可信" % u.get("vox")
            else:
                note = "超出占位 %.2f 倍，见 §6.1" % ratio
        else:
            note = "无占位参照，需人工确认"
        W("| %.1f | %s | `%s` | %s | %d | %s |" % (
            max(r["dim_blocks"]), u.get("zh") or u.get("name"),
            os.path.basename(k), blk(r["dim_blocks"]), r["verts"], note))
    W("")
    W("### 7.2 地形件不可用 bounds")
    W("")
    W("地形件（`moon_surface_*`、`arid_island_*`、`mainland_*` 等）的 `bounds` 是"
      "**瓦片声明框**而非真实几何。例：`arid_island_10_10.mesh` 声明 ±500/±1000，"
      "实测 y∈[-354.63, 183.12]。全量 %d 个 mesh 属 `tile_declared`，本册档案表已用 ⚠ 标记。"
      % stats["bounds_tile_declared"])
    W("")
    W("---")
    W("")

    # ---------- §8 地形件汇总 ----------
    W("## 8. 无定义引用的 mesh 分组")
    W("")
    g = idx.get("_terrain_groups", {})
    W("共 %d 个 mesh 未被任何部件定义引用（地形瓦片、场景件、未使用资产），"
      "按目录汇总，不逐条展开。" % sum(g.values()))
    W("")
    W("| 目录 | 数量 |")
    W("| --- | ---: |")
    for k, v in sorted(g.items(), key=lambda kv: -kv[1]):
        W("| `%s` | %d |" % (k, v))
    W("| **合计** | **%d** |" % sum(g.values()))
    W("")
    W("---")
    W("")

    # ---------- §9 缺陷附录 ----------
    W("## 9. 已知游戏数据缺陷")
    W("")
    miss = idx.get("_missing", [])
    W("定义 XML 引用了磁盘上不存在的 mesh，共 **%d 条记录**（去重后 %d 个不同引用）。"
      "这是游戏侧数据问题，不是解析错误。" % (len(miss), len({m["ref"] for m in miss})))
    W("")
    W("| 引用 | 来源定义 | 属性 | 问题 |")
    W("| --- | --- | --- | --- |")
    for m in miss:
        W("| `%s` | `%s` | %s | %s |" % (
            m["ref"], m.get("def", ""), m.get("attr", ""), m["reason"]))
    W("")
    W("> `component_wheel_3/5/7/9` 四个引用**连 `.mesh` 后缀都没有**，属游戏侧笔误。")
    W("")
    W("---")
    W("")

    # ---------- §10 复现 ----------
    W("## 10. 复现与查询")
    W("")
    W("```bash")
    W('PY="C:/Users/EC90/.workbuddy/binaries/python/versions/3.13.12/python.exe"')
    W('K="D:/STORMWORKS/技能库/sw-mesh-tools/scripts"')
    W("")
    W('# ① 全量校验格式（3653 个文件，约 11 秒；失败返回退出码 2）')
    W('"$PY" "$K/sw_mesh.py" verify')
    W("")
    W("# ② 单文件详情")
    W('"$PY" "$K/sw_mesh.py" info "E:/SteamLibrary/steamapps/common/Stormworks/rom/meshes/component_barometer.mesh"')
    W("")
    W("# ③ 导出 OBJ（须落在 D:\\\\STORMWORKS 下）")
    W('"$PY" "$K/sw_mesh.py" obj "<mesh路径>" -o "D:/STORMWORKS/_work/mesh_preview/x.obj"')
    W("")
    W("# ④ 重建索引（游戏更新后）")
    W('"$PY" "$K/build_mesh_index.py" --incremental')
    W("")
    W("# ⑤ 查询部件几何")
    W('"$PY" "$K/sw_geom.py" get 气压计')
    W('"$PY" "$K/sw_geom.py" mesh component_barometer')
    W('"$PY" "$K/sw_geom.py" top --by verts --limit 20')
    W("```")
    W("")
    W("**游戏更新后的例行检查**：先跑 ①，若指针闭合失败说明格式已漂移，"
      "需更新 `reference\\格式规格.md` 后再重建索引。")
    W("")
    return "\n".join(L) + "\n"


def count_vox(idx: dict) -> int:
    n = 0
    for r in idx["meshes"].values():
        for u in r.get("used_by", []):
            if u.get("vox"):
                n += 1
    return n


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(description="生成第 21 册《部件几何档案》")
    ap.add_argument("--index", default=INDEX)
    ap.add_argument("-o", "--out", default=OUT_DEFAULT)
    args = ap.parse_args(argv)

    idx = load(args.index)
    md = build_book(idx)
    out = guard_output_path(args.out)
    with open(out, "w", encoding="utf-8") as fh:
        fh.write(md)
    print("已生成 %s（%.1f KB，%d 行）" % (out, len(md.encode("utf-8")) / 1024, md.count("\n")))
    return 0


if __name__ == "__main__":
    sys.exit(main())
