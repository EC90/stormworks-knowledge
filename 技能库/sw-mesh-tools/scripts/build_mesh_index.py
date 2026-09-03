#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
build_mesh_index.py — 构建 .mesh 摘要索引（唯一的游戏目录直读脚本）

数据流（严格延续工作区既有范式，对标 parse_defs.py → components_index.json → sw_defs.py）
--------------------------------------------------------------------------------------
    E:\\ 游戏目录（只读）
        ├─ rom/data/definitions/*.xml   部件定义 → mesh 引用
        └─ rom/meshes/**/*.mesh         几何二进制
             ↓  build_mesh_index.py
    D:\\STORMWORKS\\数据库\\方块数据\\数据\\mesh_index.json
             ↓  sw_geom.py（只读 D 盘，日常查询不再触碰 E 盘）

设计要点
--------
* **两层索引**：顶点/索引/三角面（465 MB 数据）永不落盘，只存标量摘要；
  需要完整几何时用 sw_mesh.py 现场从 E 盘解析。
* **排除备份镜像**：统一走 sw_mesh.iter_game_meshes()。
* **中文名来自术语表派生产物** xml_id_map.json（其 zh 字段本身就取自
  汉化术语表，hit=false 表示术语表未命中，保留自译标记）。

用法
----
    python build_mesh_index.py                      全量构建
    python build_mesh_index.py --incremental        增量（按 size+mtime 跳过未变文件）
    python build_mesh_index.py --verify-only        只校验不写盘
"""

from __future__ import annotations

import argparse
import json
import os
import re
import sys
import time
from collections import Counter, defaultdict

from sw_mesh import (
    GAME_ROOT,
    WORKSPACE_ROOT,
    guard_output_path,
    iter_game_meshes,
    load_mesh,
    mesh_ref_key,
    parse_mesh,
)

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

DEF_DIR = "rom/data/definitions"
OUT_DEFAULT = os.path.join(
    WORKSPACE_ROOT, "数据库", "方块数据", "数据", "mesh_index.json"
)
ID_MAP = os.path.join(
    WORKSPACE_ROOT, "数据库", "方块数据", "数据", "xml_id_map.json"
)

#: 定义 XML 中的 mesh 引用属性（按语义主次排序）
MESH_ATTRS = (
    "mesh_data_name",
    "mesh_0_name",
    "mesh_1_name",
    "mesh_2_name",
    "mesh_editor_only_name",
)

RE_DEF = re.compile(r"<definition\b[^>]*>")
RE_ATTR = re.compile(r"([\w.\-]+)\s*=\s*\"([^\"]*)\"")

#: 地形类子目录（用于分区标记）
TERRAIN_DIRS = {
    "moon_surface",
    "arid_mainland",
    "mainland",
    "arid_mainland_assets",
    "fish",
    "volcanic",
    "undersea_assets",
    "mainland_assets",
    "volcanic_assets",
    "rock_library",
    "arid_islands",
    "trees",
}


# --------------------------------------------------------------------------
# 路径键：把磁盘路径转成定义 XML 里的引用格式（相对 rom/）
# --------------------------------------------------------------------------


# mesh_ref_key 由 sw_mesh 提供（路径约定集中在核心库，避免重复实现）

# --------------------------------------------------------------------------
# 定义 XML → mesh 引用
# --------------------------------------------------------------------------


def scan_definitions(root: str = GAME_ROOT):
    """扫描部件定义，返回 (引用映射, 缺失引用列表, 统计)。

    引用映射: { mesh_ref_key: [ {def, name, zh, attr, ...}, ... ] }
    """
    def_dir = os.path.join(root, DEF_DIR)
    id_map = load_id_map()

    refs = defaultdict(list)
    missing = []
    stats = {"def_files": 0, "defs": 0, "with_mesh_data_name": 0, "refs": 0}

    if not os.path.isdir(def_dir):
        return dict(refs), missing, stats

    for fn in sorted(os.listdir(def_dir)):
        if not fn.lower().endswith(".xml"):
            continue
        stats["def_files"] += 1
        path = os.path.join(def_dir, fn)
        with open(path, "r", encoding="utf-8", errors="replace") as fh:
            text = fh.read()
        m = RE_DEF.search(text)
        if not m:
            continue
        stats["defs"] += 1
        attrs = dict(RE_ATTR.findall(m.group(0)))

        stem = os.path.splitext(fn)[0]
        info = id_map.get(stem, {})
        name = attrs.get("name", "")

        if attrs.get("mesh_data_name", "").strip():
            stats["with_mesh_data_name"] += 1

        for attr in MESH_ATTRS:
            val = (attrs.get(attr) or "").strip()
            if not val:
                continue
            stats["refs"] += 1
            key = val.replace("\\", "/")
            if not key.lower().endswith(".mesh"):
                # 游戏侧数据笔误（如 component_wheel_3 缺 .mesh 后缀）
                missing.append(
                    {
                        "ref": key,
                        "def": stem,
                        "name": name,
                        "attr": attr,
                        "reason": "引用缺少 .mesh 后缀（游戏数据笔误）",
                    }
                )
                continue
            refs[key].append(
                {
                    "def": stem,
                    "name": name,
                    "zh": info.get("zh", ""),
                    "attr": attr,
                    "category": attrs.get("category", info.get("category", "")),
                    "mass": attrs.get("mass", info.get("mass", "")),
                    "value": attrs.get("value", info.get("value", "")),
                    "vox": info.get("vox", ""),
                }
            )

    return dict(refs), missing, stats


def load_id_map() -> dict:
    """加载 xml_id_map.json（术语表派生：zh / vox / category）。"""
    if not os.path.isfile(ID_MAP):
        return {}
    with open(ID_MAP, "r", encoding="utf-8") as fh:
        data = json.load(fh)
    return {c["id"]: c for c in data.get("components", [])}


# --------------------------------------------------------------------------
# 主流程
# --------------------------------------------------------------------------


def build_index(
    root: str = GAME_ROOT,
    incremental: bool = False,
    out_path: str = OUT_DEFAULT,
    verbose: bool = True,
) -> dict:
    t0 = time.time()

    old = {}
    if incremental and os.path.isfile(out_path):
        try:
            with open(out_path, "r", encoding="utf-8") as fh:
                old = json.load(fh).get("meshes", {})
            if verbose:
                print("增量模式：已载入 %d 条既有记录" % len(old))
        except (json.JSONDecodeError, OSError):
            old = {}

    refs, missing_def_refs, def_stats = scan_definitions(root)

    meshes = {}
    terrain = Counter()
    stats = {
        "files": 0,
        "parsed": 0,
        "reused": 0,
        "failed": 0,
        "exact_close": 0,
        "total_verts": 0,
        "total_tris": 0,
        "with_def": 0,
        "bounds_exact": 0,
        "bounds_tile_declared": 0,
        "shader_hist": Counter(),
        "failures": [],
    }

    for path in iter_game_meshes(root):
        stats["files"] += 1
        key = mesh_ref_key(path)
        try:
            st = os.stat(path)
            sig = [st.st_size, int(st.st_mtime)]
        except OSError:
            sig = None

        # 增量：签名未变直接复用
        if incremental and key in old and sig is not None:
            rec = old[key]
            if rec.get("size") == sig[0] and rec.get("mtime") == sig[1]:
                # 引用关系可能变了，仍然刷新 used_by
                rec["used_by"] = refs.get(key, [])
                meshes[key] = rec
                stats["reused"] += 1
                # 复用的记录同样要累积统计，否则 stats 会失真为 0
                if rec.get("exact"):
                    stats["exact_close"] += 1
                stats["total_verts"] += rec.get("verts", 0)
                stats["total_tris"] += rec.get("tris", 0)
                bk = rec.get("bounds_kind")
                if bk == "exact":
                    stats["bounds_exact"] += 1
                elif bk == "tile_declared":
                    stats["bounds_tile_declared"] += 1
                for s in rec.get("shaders", []):
                    stats["shader_hist"][s] += 1
                if rec.get("used_by"):
                    stats["with_def"] += 1
                else:
                    terrain[os.path.basename(os.path.dirname(path))] += 1
                continue

        try:
            m = load_mesh(path)
        except Exception as exc:  # noqa: BLE001
            stats["failed"] += 1
            if len(stats["failures"]) < 20:
                stats["failures"].append({"path": path, "error": str(exc)})
            continue

        stats["parsed"] += 1
        if m.is_exact:
            stats["exact_close"] += 1
        stats["total_verts"] += m.vertex_count
        stats["total_tris"] += m.tri_count

        bk = m.bounds_kind
        if bk == "exact":
            stats["bounds_exact"] += 1
        elif bk == "tile_declared":
            stats["bounds_tile_declared"] += 1
        for s in m.shader_ids:
            stats["shader_hist"][s] += 1

        used_by = refs.get(key, [])
        if used_by:
            stats["with_def"] += 1
        else:
            terrain[os.path.basename(os.path.dirname(path))] += 1

        rec = m.summary()
        rec["size"] = sig[0] if sig else m.file_size
        rec["mtime"] = sig[1] if sig else 0
        rec["file_size"] = m.file_size
        rec["palette_top"] = [
            [list(c), n] for c, n in (m.palette.most_common(6) if m.palette else [])
        ]
        rec["paint_base"] = [255, 125, 0]
        rec["used_by"] = used_by
        rec["group"] = "component" if used_by else "terrain"

        # SDK 源资产（存在性登记，用于对账）
        stem = os.path.splitext(os.path.basename(path))[0]
        if os.path.dirname(path).lower().endswith("rom\\meshes") or (
            os.path.basename(os.path.dirname(path)).lower() == "meshes"
        ):
            for ext in (".dae", ".fbx"):
                p = os.path.join(root, "sdk", "meshes", stem + ext)
                if os.path.isfile(p):
                    rec["sdk_src"] = "sdk/meshes/" + stem + ext
                    break

        meshes[key] = rec

        if verbose and stats["files"] % 500 == 0:
            print("  ... %d / 3653" % stats["files"], file=sys.stderr)

    # 引用了但磁盘上不存在的 mesh
    missing = list(missing_def_refs)
    for key in refs:
        if key not in meshes:
            missing.append(
                {
                    "ref": key,
                    "def": refs[key][0]["def"] if refs[key] else "",
                    "name": refs[key][0]["name"] if refs[key] else "",
                    "attr": refs[key][0]["attr"] if refs[key] else "",
                    "reason": "文件不存在",
                }
            )

    elapsed = time.time() - t0

    index = {
        "_about": (
            "Stormworks .mesh 摘要索引。几何实测数据来自游戏二进制（只读解析），"
            "used_by 关联来自 rom/data/definitions/*.xml。"
            "完整顶点/索引不入库，需要时用 scripts/sw_mesh.py 现场解析。"
        ),
        "_source": {
            "game_root": root,
            "meshes": "rom/meshes/**/*.mesh（已排除 back up/ 镜像）",
            "definitions": DEF_DIR,
            "glossary_derived": "数据库\\方块数据\\数据\\xml_id_map.json（zh 取自汉化术语表）",
            "builder": "技能库\\sw-mesh-tools\\scripts\\build_mesh_index.py",
            "spec": "技能库\\sw-mesh-tools\\reference\\格式规格.md",
            "built_at": time.strftime("%Y-%m-%d %H:%M:%S"),
            "mode": "incremental" if incremental else "full",
            "elapsed_sec": round(elapsed, 2),
        },
        "_stats": {
            "files": stats["files"],
            "parsed": stats["parsed"],
            "reused": stats["reused"],
            "failed": stats["failed"],
            "exact_close": stats["exact_close"],
            "total_verts": stats["total_verts"],
            "total_tris": stats["total_tris"],
            "with_def": stats["with_def"],
            "terrain_only": stats["files"] - stats["with_def"],
            "bounds_exact": stats["bounds_exact"],
            "bounds_tile_declared": stats["bounds_tile_declared"],
            "excluded_backup": _count_backup(root),
            "shader_hist": {str(k): v for k, v in sorted(stats["shader_hist"].items())},
            "def_files": def_stats["def_files"],
            "defs": def_stats["defs"],
            "def_refs": def_stats["refs"],
            "missing_refs": len(missing),
            "failures_sample": stats["failures"],
        },
        "_terrain_groups": dict(terrain.most_common()),
        "_missing": missing,
        "meshes": meshes,
    }
    return index


def _count_backup(root: str) -> int:
    from sw_mesh import count_backup_meshes

    return count_backup_meshes(root)


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(description="构建 .mesh 摘要索引")
    ap.add_argument("--root", default=GAME_ROOT)
    ap.add_argument("-o", "--out", default=OUT_DEFAULT)
    ap.add_argument("--incremental", action="store_true")
    ap.add_argument("--verify-only", action="store_true", help="只校验不写盘")
    ap.add_argument("--quiet", action="store_true")
    args = ap.parse_args(argv)

    verbose = not args.quiet
    idx = build_index(args.root, args.incremental, args.out, verbose)

    s = idx["_stats"]
    if verbose:
        print("=" * 62)
        print("mesh 索引构建完成")
        print("=" * 62)
        print("文件总数      : %d（排除 back up/ %d 个）" % (s["files"], s["excluded_backup"]))
        print("本次解析      : %d（增量复用 %d）" % (s["parsed"], s["reused"]))
        print("精确闭合      : %d" % s["exact_close"])
        print("失败          : %d" % s["failed"])
        print("顶点 / 三角   : %d / %d" % (s["total_verts"], s["total_tris"]))
        print("关联到部件    : %d 个 mesh" % s["with_def"])
        print("仅地形/无引用 : %d 个" % s["terrain_only"])
        print("bounds exact  : %d；tile_declared : %d" % (s["bounds_exact"], s["bounds_tile_declared"]))
        print("定义引用总数  : %d（%d 个定义文件）" % (s["def_refs"], s["def_files"]))
        print("缺失引用      : %d" % s["missing_refs"])
        print("耗时          : %s s" % idx["_source"]["elapsed_sec"])
        if s["failures_sample"]:
            print("\n失败样本：")
            for f in s["failures_sample"][:10]:
                print("  %s\n      %s" % (f["path"], f["error"]))
        if idx["_missing"]:
            print("\n缺失引用（游戏数据缺陷）：")
            for mref in idx["_missing"]:
                print("  %-52s ← %s (%s)" % (mref["ref"], mref.get("def", ""), mref["reason"]))

    if args.verify_only:
        return 0 if s["failed"] == 0 else 2

    out = guard_output_path(args.out)
    with open(out, "w", encoding="utf-8") as fh:
        json.dump(idx, fh, ensure_ascii=False, separators=(",", ":"))
    if verbose:
        print("\n已写入 %s（%.2f MB）" % (out, os.path.getsize(out) / 1048576))
    return 0 if s["failed"] == 0 else 2


if __name__ == "__main__":
    sys.exit(main())
