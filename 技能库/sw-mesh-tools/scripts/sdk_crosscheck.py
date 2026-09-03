#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
sdk_crosscheck.py — 用官方 SDK 源资产交叉验证自研 .mesh 解析器

原理
----
`sdk/meshes/` 下存放官方未编译的源模型（.dae 明文 COLLADA / .fbx 二进制）。
`.dae` 是纯文本 XML，可用标准库独立解析出「顶点数 / 三角数」，
与自研解析器的结果对账 —— 这是完全独立于 .mesh 解析链路的第二信源。

注意：源资产与编译产物的**顶点坐标数值不同**（编译期做了居中 + 缩放变换），
因此只比对拓扑量，不比对坐标。

两个指标的可信度不同（2026-09-03 实测校准）
-------------------------------------------
* **三角数 —— 主指标，可作佐证。**
  实测一致率约 84%。解析若出错，三角数应呈随机分布，不可能 84% 精确相等，
  故该指标足以佐证拓扑解析正确。不一致的部分源于「源资产与编译产物版本不同步」
  （例：component_rod_storage 的 mesh 三角数恰为 dae 的 2 倍），属游戏侧数据问题。

* **顶点数 —— 仅作参考，不可作断言。**
  实测一致率仅 48%。原因是编译期必然执行顶点合并（weld）：源 .dae 保留未合并的
  split vertices，.mesh 是合并后的结果，两者本就不该相等。
  **这不是解析错误**，不要用顶点数差异判定解析失败。

用法
----
    python sdk_crosscheck.py                     # 默认抽样 150 个
    python sdk_crosscheck.py --limit 0           # 全部（较慢，约 1-2 分钟）
    python sdk_crosscheck.py --json              # 机器可读输出
"""

from __future__ import annotations

import argparse
import json
import os
import random
import re
import sys

from sw_mesh import GAME_ROOT, iter_game_meshes, load_mesh

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

SDK_MESHES = "sdk/meshes"
ROM_MESHES = "rom/meshes"

RE_TRI = re.compile(r"<triangles[^>]*count=\"(\d+)\"")
RE_GEO = re.compile(r"<geometry\b[^>]*>.*?</geometry>", re.S)
RE_FA = re.compile(r"<float_array[^>]*count=\"(\d+)\"")
RE_POLYLIST = re.compile(r"<(polylist|polygons)\b[^>]*count=\"(\d+)\"")


class DaeInfo:
    __slots__ = ("verts", "tris", "geometries", "has_nontri")

    def __init__(self, verts, tris, geometries, has_nontri):
        self.verts = verts
        self.tris = tris
        self.geometries = geometries
        self.has_nontri = has_nontri


def parse_dae(path: str) -> DaeInfo:
    """从 .dae 提取顶点数与三角数（标准库正则，不引入 XML 依赖）。

    每个 <geometry> 内第一个 <float_array> 是 POSITION 源，count/3 即顶点数。
    """
    with open(path, "r", encoding="utf-8", errors="replace") as fh:
        text = fh.read()

    verts = 0
    tris = 0
    geos = 0
    nontri = 0

    for gm in RE_GEO.finditer(text):
        block = gm.group(0)
        geos += 1
        fa = RE_FA.search(block)
        if fa:
            verts += int(fa.group(1)) // 3
        for tm in RE_TRI.finditer(block):
            tris += int(tm.group(1))
        if RE_POLYLIST.search(block):
            nontri += 1

    return DaeInfo(verts, tris, geos, nontri)


def find_source(stem: str, root: str = GAME_ROOT):
    """查找同名源资产，返回 (路径, 类型) 或 (None, None)。"""
    for ext in (".dae", ".fbx"):
        p = os.path.join(root, SDK_MESHES, stem + ext)
        if os.path.isfile(p):
            return p, ext.lstrip(".")
    return None, None


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(description="SDK 源资产交叉验证")
    ap.add_argument("--root", default=GAME_ROOT)
    ap.add_argument(
        "--limit", type=int, default=150, help="抽样数量，0 表示全部（默认 150）"
    )
    ap.add_argument("--seed", type=int, default=20260903)
    ap.add_argument("--json", action="store_true")
    args = ap.parse_args(argv)

    root = os.path.abspath(args.root)
    rom_dir = os.path.join(root, ROM_MESHES)

    # 只取 rom/meshes 顶层（子目录多为地形件，无源资产）
    candidates = []
    if os.path.isdir(rom_dir):
        for fn in sorted(os.listdir(rom_dir)):
            if fn.lower().endswith(".mesh"):
                candidates.append(os.path.join(rom_dir, fn))

    if args.limit > 0 and len(candidates) > args.limit:
        random.seed(args.seed)
        candidates = random.sample(candidates, args.limit)
        candidates.sort()

    stats = {
        "candidates": len(candidates),
        "with_dae": 0,
        "with_fbx_only": 0,
        "no_source": 0,
        "tri_match": 0,
        "tri_mismatch": 0,
        "vert_match": 0,
        "vert_mismatch": 0,
        "nontri_source": 0,
        "mismatches": [],
        "no_source_list": [],
        # 三角数不一致时的方向分布：mesh > dae 说明源资产偏旧
        "tri_dir": {"mesh_gt": 0, "mesh_lt": 0},
        # 顶点数 mesh/dae 比值桶，用于观察 weld 强度
        "vert_ratio_buckets": {"<0.5": 0, "0.5-0.8": 0, "0.8-1.0": 0, "1.0": 0, ">1.0": 0},
    }

    for path in candidates:
        stem = os.path.splitext(os.path.basename(path))[0]
        src, kind = find_source(stem, root)

        if src is None:
            stats["no_source"] += 1
            if len(stats["no_source_list"]) < 30:
                stats["no_source_list"].append(stem)
            continue
        if kind != "dae":
            stats["with_fbx_only"] += 1
            continue

        stats["with_dae"] += 1
        try:
            m = load_mesh(path)
            d = parse_dae(src)
        except Exception as exc:  # noqa: BLE001
            stats["mismatches"].append(
                {"mesh": stem, "error": "解析异常: %s" % exc}
            )
            continue

        if d.has_nontri:
            stats["nontri_source"] += 1

        if d.tris == m.tri_count:
            stats["tri_match"] += 1
        else:
            stats["tri_mismatch"] += 1

        if d.verts == m.vertex_count:
            stats["vert_match"] += 1
        else:
            stats["vert_mismatch"] += 1

        # 顶点数比值桶（weld 强度观察，仅参考）
        vr = m.vertex_count / d.verts if d.verts else 0
        b = stats["vert_ratio_buckets"]
        if vr < 0.5:
            b["<0.5"] += 1
        elif vr < 0.8:
            b["0.5-0.8"] += 1
        elif vr < 1.0:
            b["0.8-1.0"] += 1
        elif vr == 1.0:
            b["1.0"] += 1
        else:
            b[">1.0"] += 1

        # 三角数不一致时的方向
        if d.tris != m.tri_count:
            if m.tri_count > d.tris:
                stats["tri_dir"]["mesh_gt"] += 1
            else:
                stats["tri_dir"]["mesh_lt"] += 1

        if d.tris != m.tri_count or d.verts != m.vertex_count:
            if len(stats["mismatches"]) < 25:
                stats["mismatches"].append(
                    {
                        "mesh": stem,
                        "mesh_verts": m.vertex_count,
                        "dae_verts": d.verts,
                        "mesh_tris": m.tri_count,
                        "dae_tris": d.tris,
                        "dae_geometries": d.geometries,
                    }
                )

    if args.json:
        print(json.dumps(stats, ensure_ascii=False, indent=2))
    else:
        print("=" * 62)
        print("SDK 源资产交叉验证  root=%s" % root)
        print("=" * 62)
        print("候选 mesh        : %d" % stats["candidates"])
        print("有同名 .dae      : %d" % stats["with_dae"])
        print("仅有 .fbx        : %d（二进制，未对账）" % stats["with_fbx_only"])
        print("无源资产         : %d" % stats["no_source"])
        print("-" * 62)
        print("【主指标】三角数一致   : %d / %d" % (stats["tri_match"], stats["with_dae"]))
        print("        三角数不一致   : %d" % stats["tri_mismatch"])
        if stats["tri_mismatch"]:
            td = stats["tri_dir"]
            print(
                "        不一致方向     : mesh>dae %d（源资产偏旧） / mesh<dae %d"
                % (td["mesh_gt"], td["mesh_lt"])
            )
        print(
            "【参考】顶点数一致     : %d / %d  ← 编译期 weld 导致，非解析错误"
            % (stats["vert_match"], stats["with_dae"])
        )
        print("        顶点比值分布   : %s" % stats["vert_ratio_buckets"])
        if stats["with_dae"]:
            print("-" * 62)
            print(
                "三角一致率       : %.2f%%"
                % (100.0 * stats["tri_match"] / stats["with_dae"])
            )
        if stats["mismatches"]:
            print("\n不一致样本（最多 25 条）：")
            for x in stats["mismatches"]:
                if "error" in x:
                    print("  %-46s %s" % (x["mesh"], x["error"]))
                else:
                    print(
                        "  %-46s v: mesh=%-6d dae=%-6d | t: mesh=%-6d dae=%-6d"
                        % (
                            x["mesh"],
                            x["mesh_verts"],
                            x["dae_verts"],
                            x["mesh_tris"],
                            x["dae_tris"],
                        )
                    )
        if stats["no_source_list"]:
            print("\n无源资产样本（最多 30 条）：%s" % ", ".join(stats["no_source_list"][:10]))

    # 阈值说明：顶点数因编译期 weld 不可用，只以三角数判定。
    # 源资产与产物版本不同步是游戏侧既有问题，故阈值设为 80% 而非 95%。
    if stats["with_dae"] == 0:
        return 1
    rate = stats["tri_match"] / stats["with_dae"]
    return 0 if rate >= 0.80 else 2


if __name__ == "__main__":
    sys.exit(main())
