#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
selftest.py — sw-mesh-tools 离线自检（纯标准库，不联网）

用途
----
在以下时机跑一遍，确认解析链路没坏 / 游戏格式没漂移：

* 改过 `sw_mesh.py` 之后
* **游戏更新之后**（`.mesh` 格式一旦变，指针闭合会大面积失败）
* 换了机器 / 换了 Steam 库盘符之后

测试分两类
---------
* **索引类**：只读本地 `mesh_index.json`，永远可跑。
* **解析类**：需要游戏目录 `<SW_GAME>`；目录不可用时自动 SKIP（不判失败）。

退出码：`0` 全部通过（允许 SKIP）｜`1` 有 FAIL

用法
----
    python selftest.py            # 人类可读
    python selftest.py --json     # 机器可读
"""

from __future__ import annotations

import json
import os
import sys

from sw_mesh import (
    GAME_ROOT,
    HEADER_CONST,
    MAGIC,
    WORKSPACE_ROOT,
    MeshFormatError,
    count_backup_meshes,
    guard_output_path,
    iter_game_meshes,
    load_mesh,
    mesh_ref_key,
    parse_mesh,
    to_obj,
)

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

INDEX_PATH = os.path.join(
    WORKSPACE_ROOT, "数据库", "方块数据", "数据", "mesh_index.json"
)

# 本机实测确立的基准值（气压计，3653 个文件全量校验通过）
BAROMETER = {
    "rel": "meshes/component_barometer.mesh",
    "file_size": 6346,
    "verts": 196,
    "tris": 130,
    "subs": 1,
    "header": (7, 1, 196, 19, 0),
    "dim_m": (0.25, 0.079, 0.25),
    "paint_verts": 12,
    "bounds_kind": "exact",
    "shaders": [0],
    "sub_names": ["ID44"],
    "zh": "气压计",
}

_RESULTS = []


def check(name, fn):
    """登记并执行一项检查，返回 (status, detail)。"""
    try:
        detail = fn()
        status = "PASS"
    except AssertionError as exc:
        status, detail = "FAIL", str(exc) or "断言失败"
    except FileNotFoundError as exc:
        status, detail = "SKIP", "文件缺失: %s" % exc
    except Exception as exc:  # noqa: BLE001
        status, detail = "FAIL", "%s: %s" % (type(exc).__name__, exc)
    _RESULTS.append({"name": name, "status": status, "detail": detail})
    return status, detail


def game_available() -> bool:
    return os.path.isdir(GAME_ROOT)


def _need_game():
    if not game_available():
        raise FileNotFoundError(GAME_ROOT)


def load_index():
    if not os.path.isfile(INDEX_PATH):
        raise FileNotFoundError(INDEX_PATH)
    with open(INDEX_PATH, "r", encoding="utf-8") as fh:
        return json.load(fh)


# --------------------------------------------------------------------------
# 索引类（永远可跑）
# --------------------------------------------------------------------------


def t_index_exists():
    idx = load_index()
    assert "meshes" in idx and "_stats" in idx, "索引结构不完整"
    return "%d 条记录" % len(idx["meshes"])


def t_index_stats():
    idx = load_index()
    s = idx["_stats"]
    assert s["files"] == 3653, "文件数应为 3653，实为 %s" % s["files"]
    assert s["exact_close"] == 3653, "精确闭合应为 3653，实为 %s" % s["exact_close"]
    assert s["failed"] == 0, "失败应为 0，实为 %s" % s["failed"]
    assert s["total_verts"] == 15760161, "顶点总量不符：%s" % s["total_verts"]
    assert s["excluded_backup"] == 3613, "排除备份应为 3613，实为 %s" % s["excluded_backup"]
    return "files=%d 闭合=%d 顶点=%d" % (s["files"], s["exact_close"], s["total_verts"])


def t_index_barometer():
    idx = load_index()
    rec = idx["meshes"].get(BAROMETER["rel"])
    assert rec is not None, "索引缺少 %s" % BAROMETER["rel"]
    assert rec["verts"] == BAROMETER["verts"], "verts=%s" % rec["verts"]
    assert rec["tris"] == BAROMETER["tris"], "tris=%s" % rec["tris"]
    assert rec["paint_verts"] == BAROMETER["paint_verts"], "paint=%s" % rec["paint_verts"]
    assert rec["bounds_kind"] == BAROMETER["bounds_kind"], "bounds_kind=%s" % rec["bounds_kind"]
    ub = rec.get("used_by") or []
    assert ub, "气压计未关联到部件定义"
    assert ub[0].get("zh") == BAROMETER["zh"], "中文名=%s" % ub[0].get("zh")
    return "%s / %d v / %d t" % (ub[0]["zh"], rec["verts"], rec["tris"])


def t_index_no_backup():
    idx = load_index()
    bad = [k for k in idx["meshes"] if "back up" in k.lower()]
    assert not bad, "索引混入备份条目 %d 个，例：%s" % (len(bad), bad[:2])
    return "0 条备份条目"


def t_index_bounds_kinds():
    idx = load_index()
    s = idx["_stats"]
    assert s["bounds_exact"] == 2057, "exact 应为 2057，实为 %s" % s["bounds_exact"]
    assert s["bounds_tile_declared"] == 1596, "tile 应为 1596，实为 %s" % s["bounds_tile_declared"]
    kinds = {r.get("bounds_kind") for r in idx["meshes"].values()}
    assert kinds <= {"exact", "tile_declared", "unknown", None}, "出现未知 bounds_kind: %s" % kinds
    return "exact=%d tile=%d" % (s["bounds_exact"], s["bounds_tile_declared"])


def t_index_missing_refs():
    idx = load_index()
    miss = idx.get("_missing", [])
    refs = {m["ref"] for m in miss}
    assert len(refs) == 7, "去重后缺失引用应为 7 个，实为 %d：%s" % (len(refs), sorted(refs))
    return "%d 条记录 / %d 个不同引用" % (len(miss), len(refs))


def t_no_def_duplicate():
    """(def, attr) 组合全库不得重复 —— 曾用名「重复行」是变体共用，不是解析重复。"""
    from collections import Counter

    idx = load_index()
    c = Counter()
    for r in idx["meshes"].values():
        for u in r.get("used_by", []):
            c[(u["def"], u["attr"])] += 1
    dup = [k for k, n in c.items() if n > 1]
    assert not dup, "存在重复 (def,attr)：%s" % dup[:5]
    return "%d 个引用组合无重复" % len(c)


# --------------------------------------------------------------------------
# 解析类（需游戏目录）
# --------------------------------------------------------------------------


def _game_path(rel: str) -> str:
    """索引键是相对 rom/ 的形式，需补回 rom/ 前缀。"""
    return os.path.join(GAME_ROOT, "rom", rel.replace("/", os.sep))


def t_parse_barometer():
    _need_game()
    p = _game_path(BAROMETER["rel"])
    m = load_mesh(p)
    assert m.is_exact, "指针未闭合 %d/%d" % (m.bytes_consumed, m.file_size)
    assert m.file_size == BAROMETER["file_size"], "size=%s" % m.file_size
    assert m.vertex_count == BAROMETER["verts"], "verts=%s" % m.vertex_count
    assert m.tri_count == BAROMETER["tris"], "tris=%s" % m.tri_count
    assert len(m.submeshes) == BAROMETER["subs"], "subs=%s" % len(m.submeshes)
    assert m.header_fields == BAROMETER["header"], "header=%s" % (m.header_fields,)
    assert m.sentinel == 0, "尾哨兵=%s" % m.sentinel
    assert m.normal_bad == 0, "法线异常 %d 个" % m.normal_bad
    assert m.paint_verts == BAROMETER["paint_verts"], "paint=%s" % m.paint_verts
    assert m.shader_ids == BAROMETER["shaders"], "shaders=%s" % m.shader_ids
    assert [s.name for s in m.submeshes] == BAROMETER["sub_names"], "names=%s" % [
        s.name for s in m.submeshes
    ]
    return "闭合 / header=%s / %dv" % (m.header_fields, m.vertex_count)


def t_dim_and_bounds():
    _need_game()
    m = load_mesh(_game_path(BAROMETER["rel"]))
    got = tuple(round(v, 3) for v in m.dim_m)
    exp = BAROMETER["dim_m"]
    assert got == exp, "dim_m=%s 期望 %s" % (got, exp)
    assert m.bounds_kind == "exact", "bounds_kind=%s" % m.bounds_kind
    return "dim=%s blocks=%s" % (got, tuple(round(v, 2) for v in m.dim_blocks))


def t_header_constancy():
    """头部恒定字段 (7,1,·,19,0) —— 版本漂移的第一探测器。"""
    _need_game()
    n = 0
    for i, p in enumerate(iter_game_meshes()):
        if i >= 200:
            break
        with open(p, "rb") as fh:
            head = fh.read(14)
        assert len(head) == 14 and head[:4] == MAGIC, "magic 异常: %s" % p
        _, h0, h1, _vc, h3, h4 = __import__("struct").unpack("<4s5H", head)
        assert (h0, h1, h3, h4) == HEADER_CONST, "头部漂移 %s: %s" % (p, (h0, h1, h3, h4))
        n += 1
    assert n > 0, "未遍历到任何 mesh"
    return "抽验 %d 个文件恒定 (7,1,·,19,0)" % n


def t_excludes_backup():
    """排除 back up/ 是强制项，漏排会让索引翻倍。"""
    _need_game()
    n = 0
    for p in iter_game_meshes():
        assert "back up" not in p.lower(), "未排除备份: %s" % p
        n += 1
    assert n == 3653, "有效 mesh 应为 3653，实为 %d" % n
    assert count_backup_meshes() == 3613, "备份计数应为 3613"
    return "有效 %d / 排除 %d" % (n, count_backup_meshes())


def t_multi_submesh():
    """多 submesh 文件（占 249 个）必须同样精确闭合。"""
    _need_game()
    checked = 0
    for p in iter_game_meshes():
        with open(p, "rb") as fh:
            blob = fh.read(14)
        if len(blob) < 14:
            continue
        m = parse_mesh(open(p, "rb").read(), path=p)
        if len(m.submeshes) >= 2:
            assert m.is_exact, "多 submesh 未闭合: %s (%d/%d)" % (
                p, m.bytes_consumed, m.file_size)
            checked += 1
            if checked >= 30:
                break
    assert checked > 0, "未找到多 submesh 文件"
    return "%d 个多 submesh 文件全部闭合" % checked


def t_terrain_tile_declared():
    """地形件 bounds 是瓦片声明框，必须被标为 tile_declared，不可当尺寸用。"""
    _need_game()
    idx = load_index()
    cand = [k for k, r in idx["meshes"].items() if r.get("bounds_kind") == "tile_declared"]
    assert cand, "索引中无 tile_declared 记录"
    m = load_mesh(_game_path(cand[0]))
    assert m.is_exact, "地形件解析未闭合: %s" % cand[0]
    assert m.bounds_kind == "tile_declared", "分类错误: %s" % m.bounds_kind
    return "%s 分类正确" % os.path.basename(cand[0])


def t_obj_export():
    _need_game()
    m = load_mesh(_game_path(BAROMETER["rel"]), deep=True)
    out = os.path.join(WORKSPACE_ROOT, "_work", "mesh_preview", "_selftest_barometer.obj")
    to_obj(m, out)
    with open(out, "r", encoding="utf-8") as fh:
        text = fh.read()
    nv = text.count("\nv ")
    nf = text.count("\nf ")
    assert nv == BAROMETER["verts"], "OBJ 顶点 %d 期望 %d" % (nv, BAROMETER["verts"])
    assert nf == BAROMETER["tris"], "OBJ 面 %d 期望 %d" % (nf, BAROMETER["tris"])
    return "v=%d f=%d" % (nv, nf)


def t_output_guard():
    """只读红线的代码级护栏：工作区之外的导出必须被拒绝。"""
    ok = guard_output_path(os.path.join(WORKSPACE_ROOT, "_work", "mesh_preview", "_x.obj"))
    assert ok.startswith(os.path.abspath(WORKSPACE_ROOT)), "工作区内路径被误拒"
    for bad in (r"E:\SteamLibrary\x.obj", r"C:\Windows\x.obj"):
        try:
            guard_output_path(bad)
        except MeshFormatError:
            continue
        raise AssertionError("未拒绝工作区外路径: %s" % bad)
    return "工作区内放行 / 区外拒绝"


def t_ref_key():
    p = os.path.join(GAME_ROOT, "rom", "meshes", "a.mesh")
    assert mesh_ref_key(p) == "meshes/a.mesh", mesh_ref_key(p)
    return "rom/meshes/a.mesh → meshes/a.mesh"


def t_paint_base_color():
    """可涂色基色 RGB(255,125,0) —— 判断部件能否涂装的依据。"""
    _need_game()
    idx = load_index()
    rec = idx["meshes"][BAROMETER["rel"]]
    top = [c for c, _n in rec.get("palette_top", [])]
    assert [255, 125, 0] in [list(c) for c in top], "调色板未含基色: %s" % top
    return "基色 #ff7d00 命中"


TESTS = [
    ("索引存在且结构完整", t_index_exists),
    ("索引统计符合基准", t_index_stats),
    ("索引气压计记录", t_index_barometer),
    ("索引未混入 back up/", t_index_no_backup),
    ("bounds_kind 分类计数", t_index_bounds_kinds),
    ("缺失引用 7 个", t_index_missing_refs),
    ("(def,attr) 无重复", t_no_def_duplicate),
    ("解析气压计全字段", t_parse_barometer),
    ("实测尺寸与 bounds", t_dim_and_bounds),
    ("头部恒定(7,1,·,19,0)", t_header_constancy),
    ("排除 back up/ 镜像", t_excludes_backup),
    ("多 submesh 精确闭合", t_multi_submesh),
    ("地形件 tile_declared", t_terrain_tile_declared),
    ("OBJ 导出 v/f 数", t_obj_export),
    ("导出路径护栏", t_output_guard),
    ("路径键转换", t_ref_key),
    ("可涂色基色", t_paint_base_color),
]


def main(argv=None) -> int:
    import argparse

    ap = argparse.ArgumentParser(description="sw-mesh-tools 离线自检")
    ap.add_argument("--json", action="store_true")
    args = ap.parse_args(argv)

    for name, fn in TESTS:
        check(name, fn)

    n_pass = sum(1 for r in _RESULTS if r["status"] == "PASS")
    n_fail = sum(1 for r in _RESULTS if r["status"] == "FAIL")
    n_skip = sum(1 for r in _RESULTS if r["status"] == "SKIP")

    if args.json:
        print(json.dumps(
            {"pass": n_pass, "fail": n_fail, "skip": n_skip, "results": _RESULTS},
            ensure_ascii=False, indent=2))
    else:
        print("=" * 66)
        print("sw-mesh-tools 离线自检   game_root=%s%s" % (
            GAME_ROOT, "" if game_available() else "  (不可用 → 解析类测试 SKIP)"))
        print("=" * 66)
        for r in _RESULTS:
            mark = {"PASS": "✓", "FAIL": "✗", "SKIP": "-"}[r["status"]]
            print("  %s %-28s %s" % (mark, r["name"], r["detail"]))
        print("-" * 66)
        print("PASS %d / FAIL %d / SKIP %d" % (n_pass, n_fail, n_skip))

    return 1 if n_fail else 0


if __name__ == "__main__":
    sys.exit(main())
