#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
sw_geom.py — 部件几何查询器（只读 D 盘索引，不触碰游戏目录）

数据来源：数据库\\方块数据\\数据\\mesh_index.json
          由 build_mesh_index.py 从游戏二进制只读解析生成。

与 sw_defs.py 的分工
--------------------
* `sw_defs.py`  —— 权威规格：mass / $ / 逻辑节点 / 占位格数（来自定义 XML）
* `sw_geom.py`  —— 真实几何：实测 AABB / 尺寸 / 三角数 / 着色器 / 可涂色顶点
                   （来自 .mesh 二进制实测）

两者是「逻辑占位」与「物理外观」两个维度，可交叉纠错。

用法
----
    python sw_geom.py get 气压计              按中文名 / 英文名 / 定义 id 查询
    python sw_geom.py get Barometer
    python sw_geom.py mesh component_barometer 按 mesh 名查询
    python sw_geom.py stats                   索引统计
    python sw_geom.py top --by verts          排行（verts / tris / vol / paint）
    python sw_geom.py missing                 列出游戏数据缺陷（缺失引用）
    python sw_geom.py terrain                 地形件分组汇总
"""

from __future__ import annotations

import argparse
import json
import os
import sys

INDEX_PATH = os.path.join(
    os.path.dirname(os.path.abspath(__file__)),
    "..",
    "..",
    "..",
    "数据库",
    "方块数据",
    "数据",
    "mesh_index.json",
)

SHADER_NAMES = {0: "Opaque", 1: "Transparent", 2: "Emissive", 3: "Lava"}
BLOCK_METERS = 0.25

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")


# --------------------------------------------------------------------------
# 索引加载
# --------------------------------------------------------------------------

_CACHE = None


def load_index(path: str = None) -> dict:
    global _CACHE
    if _CACHE is not None and path is None:
        return _CACHE
    p = os.path.abspath(path or INDEX_PATH)
    if not os.path.isfile(p):
        sys.exit(
            "索引不存在：%s\n请先运行：python build_mesh_index.py" % p
        )
    with open(p, "r", encoding="utf-8") as fh:
        data = json.load(fh)
    if path is None:
        _CACHE = data
    return data


def build_reverse(idx: dict) -> dict:
    """反向索引：查询词 → [mesh_key]。

    一个部件可能对应多个 mesh（mesh_data_name + mesh_0/1/2_name），
    一个 mesh 也可能被多个部件共用。
    """
    rev = {}
    for key, rec in idx.get("meshes", {}).items():
        stem = os.path.splitext(os.path.basename(key))[0]
        for token in {stem, key}:
            rev.setdefault(token.lower(), []).append(key)
        for u in rec.get("used_by", []):
            for token in {u.get("zh", ""), u.get("name", ""), u.get("def", "")}:
                if token:
                    rev.setdefault(token.lower(), []).append(key)
    return rev


# --------------------------------------------------------------------------
# 输出辅助
# --------------------------------------------------------------------------


def _dim_str(dim_m) -> str:
    return "%.4f × %.4f × %.4f m" % tuple(dim_m)


def _blk_str(dim_b) -> str:
    return "%.2f × %.2f × %.2f 格" % tuple(dim_b)


def _rgb_hex(rgb) -> str:
    return "#%02x%02x%02x" % tuple(rgb)


def _paint_desc(rec) -> str:
    v = rec.get("verts", 0)
    p = rec.get("paint_verts", 0)
    if not v:
        return "—"
    if p == 0:
        return "不可涂装（全固定配色）"
    if p == v:
        return "整件随涂装变色（%d/%d）" % (p, v)
    return "部分可涂装 %d/%d（%.0f%%）" % (p, v, 100.0 * p / v)


def fmt_record(key: str, rec: dict, verbose: bool = True) -> str:
    L = []
    L.append("mesh         : %s" % key)
    L.append(
        "体积数据     : %s  =  %s"
        % (_dim_str(rec["dim_m"]), _blk_str(rec["dim_blocks"]))
    )
    L.append(
        "AABB         : (%.4f, %.4f, %.4f) ~ (%.4f, %.4f, %.4f)  [%s]"
        % (
            rec["aabb"][0],
            rec["aabb"][1],
            rec["aabb"][2],
            rec["aabb"][3],
            rec["aabb"][4],
            rec["aabb"][5],
            rec.get("bounds_kind", "?"),
        )
    )
    L.append(
        "拓扑         : %d 顶点 / %d 三角 / %d submesh"
        % (rec["verts"], rec["tris"], rec["subs"])
    )
    L.append(
        "着色器       : %s"
        % ", ".join(
            "%d(%s)" % (s, SHADER_NAMES.get(s, "?")) for s in rec.get("shaders", [])
        )
    )
    L.append("涂装         : %s" % _paint_desc(rec))
    if rec.get("alpha_nonopaque"):
        L.append("alpha≠255    : %d 个顶点" % rec["alpha_nonopaque"])
    if rec.get("palette_top"):
        tops = ", ".join(
            "%s×%d" % (_rgb_hex(c), n) for c, n in rec["palette_top"][:5]
        )
        L.append("主色调       : %s" % tops)
    if verbose and rec.get("used_by"):
        L.append("关联部件 (%d)：" % len(rec["used_by"]))
        for u in rec["used_by"]:
            vox = ("  占位%s" % u["vox"]) if u.get("vox") else ""
            L.append(
                "    %-12s %-34s [%s]%s"
                % (u.get("zh") or "—", u.get("name") or "—", u.get("attr", ""), vox)
            )
    if rec.get("sdk_src"):
        L.append("SDK 源资产   : %s" % rec["sdk_src"])
    if not rec.get("exact"):
        L.append("⚠ 解析未精确闭合，数据不可信")
    return "\n".join(L)


# --------------------------------------------------------------------------
# 子命令
# --------------------------------------------------------------------------


def cmd_get(keyword: str, index_path=None, limit: int = 10) -> int:
    idx = load_index(index_path)
    rev = build_reverse(idx)
    kw = keyword.strip().lower()

    exact = rev.get(kw, [])
    hits = list(dict.fromkeys(exact))
    if not hits:
        hits = list(
            dict.fromkeys(
                k
                for token, keys in rev.items()
                if kw in token
                for k in keys
            )
        )

    if not hits:
        print("未找到匹配「%s」的部件或 mesh" % keyword)
        print(json.dumps({"query": keyword, "hits": 0}, ensure_ascii=False))
        return 1

    shown = hits[:limit]
    print("匹配 %d 条，显示前 %d：\n" % (len(hits), len(shown)))
    for i, key in enumerate(shown):
        print(fmt_record(key, idx["meshes"][key]))
        if i < len(shown) - 1:
            print("\n" + "-" * 66 + "\n")

    print()
    print(
        json.dumps(
            {
                "query": keyword,
                "hits": len(hits),
                "results": [
                    {
                        "mesh": k,
                        "dim_m": idx["meshes"][k]["dim_m"],
                        "dim_blocks": idx["meshes"][k]["dim_blocks"],
                        "verts": idx["meshes"][k]["verts"],
                        "tris": idx["meshes"][k]["tris"],
                        "paint_verts": idx["meshes"][k]["paint_verts"],
                        "used_by": idx["meshes"][k].get("used_by", []),
                    }
                    for k in hits[:40]
                ],
            },
            ensure_ascii=False,
        )
    )
    return 0


def cmd_mesh(name: str, index_path=None) -> int:
    idx = load_index(index_path)
    meshes = idx.get("meshes", {})
    key = name if name.startswith("meshes/") else "meshes/%s" % name
    if not key.endswith(".mesh"):
        key += ".mesh"
    if key not in meshes:
        cands = [k for k in meshes if name.lower() in k.lower()]
        if not cands:
            print("未找到 mesh「%s」" % name)
            return 1
        print("精确键未命中，模糊匹配 %d 条：\n" % len(cands))
        for k in cands[:10]:
            print(fmt_record(k, meshes[k]))
            print("-" * 66)
        return 0
    print(fmt_record(key, meshes[key], verbose=True))
    return 0


def cmd_stats(index_path=None) -> int:
    idx = load_index(index_path)
    s = idx["_stats"]
    src = idx["_source"]
    print("=" * 62)
    print("mesh 索引统计")
    print("=" * 62)
    print("构建时间      : %s（耗时 %s s）" % (src["built_at"], src["elapsed_sec"]))
    print("mesh 总数     : %d（排除 back up/ %d 个）" % (s["files"], s["excluded_backup"]))
    print("精确闭合      : %d    失败 : %d" % (s["exact_close"], s["failed"]))
    print("顶点 / 三角   : %d / %d" % (s["total_verts"], s["total_tris"]))
    print("关联到部件    : %d 个 mesh" % s["with_def"])
    print("地形/无引用   : %d 个" % s["terrain_only"])
    print(
        "bounds 可信度 : exact %d / tile_declared %d"
        % (s["bounds_exact"], s["bounds_tile_declared"])
    )
    print("定义引用总数  : %d（%d 个定义文件）" % (s["def_refs"], s["def_files"]))
    print("缺失引用      : %d" % s["missing_refs"])
    print("shader 分布   : %s" % s["shader_hist"])
    print()
    print(json.dumps({"stats": s, "source": src}, ensure_ascii=False))
    return 0


def cmd_top(by="verts", limit=20, index_path=None) -> int:
    idx = load_index(index_path)
    meshes = idx["meshes"]

    def vol(r):
        d = r["dim_m"]
        return d[0] * d[1] * d[2]

    keyfn = {
        "verts": lambda r: r["verts"],
        "tris": lambda r: r["tris"],
        "vol": vol,
        "paint": lambda r: r["paint_verts"],
        "size": lambda r: r["file_size"],
    }.get(by, lambda r: r["verts"])

    # 只排部件件（有定义关联），地形件无语义价值
    items = [(k, r) for k, r in meshes.items() if r.get("used_by")]
    items.sort(key=lambda kv: -keyfn(kv[1]))

    print("%-46s %-22s %8s %8s" % ("mesh", "部件", by, "格数"))
    print("-" * 96)
    for k, r in items[:limit]:
        zh = r["used_by"][0].get("zh") or r["used_by"][0].get("name", "")
        val = keyfn(r)
        vtxt = "%.4f" % val if by == "vol" else str(val)
        print(
            "%-46s %-22s %8s %8s"
            % (k[:46], zh[:22], vtxt, _blk_str(r["dim_blocks"]))
        )
    print()
    print(
        json.dumps(
            {
                "by": by,
                "total_components": len(items),
                "top": [
                    {
                        "mesh": k,
                        "zh": (r["used_by"][0].get("zh") if r["used_by"] else ""),
                        by: keyfn(r),
                        "dim_blocks": r["dim_blocks"],
                    }
                    for k, r in items[:limit]
                ],
            },
            ensure_ascii=False,
        )
    )
    return 0


def cmd_missing(index_path=None) -> int:
    idx = load_index(index_path)
    miss = idx.get("_missing", [])
    print("游戏数据缺陷：定义 XML 引用了不存在的 mesh（%d 条）\n" % len(miss))
    for m in miss:
        print(
            "  %-54s ← %-28s [%s]\n      %s"
            % (m["ref"], m.get("def", ""), m.get("attr", ""), m["reason"])
        )
    print()
    print(json.dumps({"missing": miss}, ensure_ascii=False))
    return 0


def cmd_terrain(index_path=None) -> int:
    idx = load_index(index_path)
    g = idx.get("_terrain_groups", {})
    print("无定义引用的 mesh 分组（按目录）\n")
    for k, v in sorted(g.items(), key=lambda kv: -kv[1]):
        print("  %-24s %d" % (k, v))
    print("\n合计 %d" % sum(g.values()))
    print()
    print(json.dumps({"terrain_groups": g}, ensure_ascii=False))
    return 0


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(
        prog="sw_geom.py", description="部件几何查询器（只读本地索引）"
    )
    ap.add_argument("--index", default=None, help="指定索引路径")
    sub = ap.add_subparsers(dest="cmd", required=True)

    p = sub.add_parser("get", help="按中文名/英文名/定义 id 查询")
    p.add_argument("keyword")
    p.add_argument("--limit", type=int, default=10)

    p = sub.add_parser("mesh", help="按 mesh 名查询")
    p.add_argument("name")

    sub.add_parser("stats", help="索引统计")

    p = sub.add_parser("top", help="排行")
    p.add_argument("--by", default="verts", choices=["verts", "tris", "vol", "paint", "size"])
    p.add_argument("--limit", type=int, default=20)

    sub.add_parser("missing", help="游戏数据缺陷清单")
    sub.add_parser("terrain", help="地形件分组汇总")

    args = ap.parse_args(argv)

    if args.cmd == "get":
        return cmd_get(args.keyword, args.index, args.limit)
    if args.cmd == "mesh":
        return cmd_mesh(args.name, args.index)
    if args.cmd == "stats":
        return cmd_stats(args.index)
    if args.cmd == "top":
        return cmd_top(args.by, args.limit, args.index)
    if args.cmd == "missing":
        return cmd_missing(args.index)
    if args.cmd == "terrain":
        return cmd_terrain(args.index)
    return 1


if __name__ == "__main__":
    sys.exit(main())
