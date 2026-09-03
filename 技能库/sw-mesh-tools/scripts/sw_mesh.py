#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
sw_mesh.py — Stormworks `.mesh` 二进制解析器（纯标准库，零第三方依赖）

格式规格见 ../reference/格式规格.md

设计要点
--------
1. 只读：本文件对游戏目录只使用 open(path,'rb')，代码内不含任何写模式。
2. 护栏：任何导出路径必须落在 D:\\STORMWORKS 下，否则拒绝执行。
3. 自证式校验：解析结束时 bytes_consumed 必须等于 file_size。
   格式一旦漂移，该断言会大面积失败 —— 这是最可靠的版本漂移探测器。
4. 惰性：顶点默认不驻留内存（975 MB 全量数据），只累积标量统计量。

CLI
---
    python sw_mesh.py info  <file>            单文件详情（人类可读）
    python sw_mesh.py json  <file>            单文件详情（JSON）
    python sw_mesh.py head  <file>            仅头部 14 字节
    python sw_mesh.py obj   <file> -o out.obj 导出 Wavefront OBJ
    python sw_mesh.py verify [--root DIR]     全量校验（排除 back up/）
"""

from __future__ import annotations

import argparse
import json
import os
import struct
import sys
from collections import Counter
from dataclasses import dataclass, field
from typing import Iterator

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
if hasattr(sys.stderr, "reconfigure"):
    sys.stderr.reconfigure(encoding="utf-8", errors="replace")

# --------------------------------------------------------------------------
# 常量
# --------------------------------------------------------------------------

MAGIC = b"mesh"

#: 工作区根目录（唯一允许写入的位置）
WORKSPACE_ROOT = r"D:\STORMWORKS"

#: 游戏根目录的回退值（本机实测；优先用环境变量 / 路径配置）
_DEFAULT_GAME_ROOT = r"E:\SteamLibrary\steamapps\common\Stormworks"


def resolve_game_root() -> str:
    """解析 `<SW_GAME>`：环境变量 → 工作区路径配置 → 回退默认值。

    接入工作区统一的路径占位符机制（见 `工作区导航\\07_路径占位符约定.md`），
    换机器时无需改代码。
    """
    env = os.environ.get("SW_GAME")
    if env and os.path.isdir(env):
        return env
    cfg = os.path.join(WORKSPACE_ROOT, "工作区导航", "路径配置.json")
    if os.path.isfile(cfg):
        try:
            with open(cfg, "r", encoding="utf-8") as fh:
                data = json.load(fh)
            p = (data.get("paths") or {}).get("<SW_GAME>")
            if p and os.path.isdir(p):
                return p
        except (OSError, ValueError):
            pass
    return _DEFAULT_GAME_ROOT


#: 游戏根目录（只读红线）
GAME_ROOT = resolve_game_root()

#: 头部：magic(4) + 5×u16(10) = 14 字节
HEADER = struct.Struct("<4s5H")
HEADER_SIZE = HEADER.size  # 14

#: 顶点：f32[3] pos + u8[4] RGBA + f32[3] normal = 28 字节
VERTEX = struct.Struct("<3f4B3f")
VERTEX_SIZE = VERTEX.size  # 28

#: 索引区前导计数
U32 = struct.Struct("<I")
#: submesh 固定部分：u32 start, u32 length, u16 zero, u16 shaderId, f32[6] bounds, u16 zero, u16 nameLen
SUBMESH_HEAD = struct.Struct("<IIHH6fHH")
#: submesh 尾部 scale，恒 (1,1,1)
SUBMESH_TAIL = struct.Struct("<3f")
#: 文件尾哨兵
SENTINEL = struct.Struct("<H")

#: 头部恒定字段（3653/3653 实测）—— 用于版本漂移探测
HEADER_CONST = (7, 1, 19, 0)  # (h0, h1, h3, h4)，h2 是可变顶点数

#: shaderId 语义
SHADER_NAMES = {0: "Opaque", 1: "Transparent", 2: "Emissive", 3: "Lava"}

#: 可涂色基色（实测 RGB(255,125,0) 为主，另有两档变体）
PAINT_BASE_COLORS = {(255, 125, 0), (155, 125, 0), (55, 135, 0)}

#: 1 格 = 0.25 m
BLOCK_METERS = 0.25

#: 备份镜像目录（完全复制 rom/，必须排除，否则索引翻倍）
BACKUP_DIR = "back up"


class MeshFormatError(ValueError):
    """.mesh 解析失败。"""


# --------------------------------------------------------------------------
# 数据模型
# --------------------------------------------------------------------------


@dataclass(frozen=True, slots=True)
class Vertex:
    x: float
    y: float
    z: float
    r: int
    g: int
    b: int
    a: int
    nx: float
    ny: float
    nz: float

    def as_obj(self) -> str:
        return "v %.6f %.6f %.6f" % (self.x, self.y, self.z)


@dataclass(slots=True)
class SubMesh:
    index_start: int
    index_length: int
    shader_id: int
    name: str
    bounds_min: tuple
    bounds_max: tuple
    scale: tuple
    #: 解析期发现的异常（z1/z2 非 0、scale 非 (1,1,1)）
    anomalies: list = field(default_factory=list)

    @property
    def shader_name(self) -> str:
        return SHADER_NAMES.get(self.shader_id, "Unknown(%d)" % self.shader_id)

    @property
    def size(self) -> tuple:
        return tuple(
            hi - lo for lo, hi in zip(self.bounds_min, self.bounds_max)
        )


@dataclass(slots=True)
class Mesh:
    path: str
    file_size: int
    vertex_count: int
    index_count: int
    submeshes: list
    #: 解析结束时游标位置；== file_size 表示精确闭合
    bytes_consumed: int
    sentinel: int
    #: 顶点统计（惰性模式下亦可用，遍历时累积标量）
    aabb: tuple = None
    palette: Counter = None
    paint_verts: int = 0
    alpha_nonopaque: int = 0
    normal_bad: int = 0
    #: 仅 deep 模式填充
    vertices: list = None
    indices: list = None
    #: 头部原始字段，用于漂移探测
    header_fields: tuple = None
    error: str = None

    @property
    def is_exact(self) -> bool:
        return self.bytes_consumed == self.file_size and self.error is None

    @property
    def tri_count(self) -> int:
        return self.index_count // 3

    @property
    def dim_m(self) -> tuple:
        """实测包围盒尺寸（米）。无顶点时回退到 submesh bounds 并集。"""
        if self.aabb:
            lo, hi = self.aabb[:3], self.aabb[3:]
            return tuple(round(hi[i] - lo[i], 6) for i in range(3))
        return self._bounds_union_size()

    @property
    def dim_blocks(self) -> tuple:
        """实测包围盒尺寸（格），1 格 = 0.25 m。"""
        return tuple(round(v / BLOCK_METERS, 4) for v in self.dim_m)

    def _bounds_union_size(self) -> tuple:
        if not self.submeshes:
            return (0.0, 0.0, 0.0)
        lo = [min(s.bounds_min[i] for s in self.submeshes) for i in range(3)]
        hi = [max(s.bounds_max[i] for s in self.submeshes) for i in range(3)]
        return tuple(round(hi[i] - lo[i], 6) for i in range(3))

    @property
    def bounds_kind(self) -> str:
        """submesh 声明的 bounds 是否与顶点实测 AABB 一致。

        部件件（component_*）940/940 精确；地形件多为瓦片声明框，
        与真实几何不符，不可当作 AABB 使用。
        """
        if not self.aabb or not self.submeshes:
            return "unknown"
        decl = self._bounds_union_size()
        real = self.dim_m
        for d, r in zip(decl, real):
            if abs(d - r) > 1e-3 * max(1.0, abs(r)):
                return "tile_declared"
        return "exact"

    @property
    def shader_ids(self) -> list:
        return sorted({s.shader_id for s in self.submeshes})

    def summary(self) -> dict:
        """摘要记录（标量，落 JSON 索引用）。"""
        return {
            "verts": self.vertex_count,
            "tris": self.tri_count,
            "subs": len(self.submeshes),
            "aabb": [round(v, 6) for v in self.aabb] if self.aabb else None,
            "dim_m": list(self.dim_m),
            "dim_blocks": list(self.dim_blocks),
            "bounds_kind": self.bounds_kind,
            "shaders": self.shader_ids,
            "sub_names": [s.name for s in self.submeshes],
            "paint_verts": self.paint_verts,
            "alpha_nonopaque": self.alpha_nonopaque,
            "normal_bad": self.normal_bad,
            "exact": self.is_exact,
        }


# --------------------------------------------------------------------------
# 解析
# --------------------------------------------------------------------------


def parse_mesh(data: bytes, path: str = "", deep: bool = False) -> Mesh:
    """解析 .mesh 二进制内容。

    Parameters
    ----------
    data : bytes
        文件全部内容。
    path : str
        仅用于记录，不做任何 IO。
    deep : bool
        True 时保留 vertices / indices 列表（用于 OBJ 导出）。
        默认 False，只累积标量统计，避免 975 MB 顶点常驻内存。
    """
    size = len(data)
    try:
        magic, h0, h1, vc, h3, h4 = HEADER.unpack_from(data, 0)
    except struct.error as exc:
        raise MeshFormatError("头部不足 14 字节: %s" % exc) from exc

    if magic != MAGIC:
        raise MeshFormatError("magic 不匹配: %r（应为 b'mesh'）" % (magic,))

    header_fields = (h0, h1, vc, h3, h4)
    if (h0, h1, h3, h4) != HEADER_CONST:
        # 不抛异常，交由 verify 统计 —— 这可能是游戏版本改了格式
        pass

    pos = HEADER_SIZE

    # ---- 顶点区 ----
    need = pos + vc * VERTEX_SIZE
    if need > size:
        raise MeshFormatError(
            "顶点区越界：需 %d 字节，文件仅 %d" % (need, size)
        )

    verts = None
    if deep:
        verts = [
            Vertex(*t) for t in VERTEX.iter_unpack(memoryview(data)[pos:need])
        ]

    aabb, palette, paint, alpha_bad, nrm_bad = _scan_vertices(data, pos, vc)
    pos = need

    # ---- 索引区 ----
    if pos + 4 > size:
        raise MeshFormatError("索引计数越界")
    (index_count,) = U32.unpack_from(data, pos)
    pos += 4

    need = pos + index_count * 2
    if need > size:
        raise MeshFormatError(
            "索引区越界：需 %d 字节，文件仅 %d" % (need, size)
        )
    indices = None
    if deep:
        indices = list(struct.unpack_from("<%dH" % index_count, data, pos))
    else:
        # 仅校验上界，不构造列表
        fmt = "<%dH" % index_count
        max_span = (size - pos) // 2
        check_n = min(index_count, max_span)
        if check_n:
            chunk = struct.unpack_from("<%dH" % check_n, data, pos)
            if max(chunk) >= vc:
                raise MeshFormatError(
                    "索引越界：max=%d >= vertexCount=%d" % (max(chunk), vc)
                )
    pos = need

    # ---- submesh 区 ----
    if pos + 2 > size:
        raise MeshFormatError("submesh 计数越界")
    (sub_count,) = struct.unpack_from("<H", data, pos)
    pos += 2

    subs = []
    for _ in range(sub_count):
        if pos + SUBMESH_HEAD.size > size:
            raise MeshFormatError("submesh 头越界")
        (start, length, z1, shader, *bounds, z2, name_len) = (
            SUBMESH_HEAD.unpack_from(data, pos)
        )
        pos += SUBMESH_HEAD.size

        if pos + name_len > size:
            raise MeshFormatError("submesh 名称越界")
        raw_name = data[pos : pos + name_len]
        pos += name_len
        try:
            name = raw_name.decode("utf-8")
        except UnicodeDecodeError:
            name = raw_name.decode("utf-8", errors="replace")

        if pos + SUBMESH_TAIL.size > size:
            raise MeshFormatError("submesh 尾部越界")
        scale = SUBMESH_TAIL.unpack_from(data, pos)
        pos += SUBMESH_TAIL.size

        anomalies = []
        if z1 != 0 or z2 != 0:
            anomalies.append("zero_field=(%d,%d)" % (z1, z2))
        if any(abs(v - 1.0) > 1e-6 for v in scale):
            anomalies.append("scale=%s" % (scale,))

        subs.append(
            SubMesh(
                index_start=start,
                index_length=length,
                shader_id=shader,
                name=name,
                bounds_min=tuple(bounds[0:3]),
                bounds_max=tuple(bounds[3:6]),
                scale=scale,
                anomalies=anomalies,
            )
        )

    # ---- 尾哨兵 ----
    sentinel = None
    if pos + SENTINEL.size <= size:
        (sentinel,) = SENTINEL.unpack_from(data, pos)
        pos += SENTINEL.size

    mesh = Mesh(
        path=path,
        file_size=size,
        vertex_count=vc,
        index_count=index_count,
        submeshes=subs,
        bytes_consumed=pos,
        sentinel=sentinel if sentinel is not None else -1,
        aabb=aabb,
        palette=palette,
        paint_verts=paint,
        alpha_nonopaque=alpha_bad,
        normal_bad=nrm_bad,
        vertices=verts,
        indices=indices,
        header_fields=header_fields,
    )
    return mesh


def _scan_vertices(data: bytes, offset: int, count: int):
    """单次遍历顶点区，累积标量统计（不构造 Vertex 对象）。

    返回 (aabb, palette, paint_verts, alpha_nonopaque, normal_bad)
    aabb = (minx, miny, minz, maxx, maxy, maxz)
    """
    if count == 0:
        return None, Counter(), 0, 0, 0

    mv = memoryview(data)[offset : offset + count * VERTEX_SIZE]
    minx = miny = minz = float("inf")
    maxx = maxy = maxz = float("-inf")
    palette = Counter()
    paint = 0
    alpha_bad = 0
    nrm_bad = 0

    for x, y, z, r, g, b, a, nx, ny, nz in VERTEX.iter_unpack(mv):
        if x < minx:
            minx = x
        if x > maxx:
            maxx = x
        if y < miny:
            miny = y
        if y > maxy:
            maxy = y
        if z < minz:
            minz = z
        if z > maxz:
            maxz = z

        palette[(r, g, b)] += 1
        if a != 255:
            alpha_bad += 1
        if (r, g, b) in PAINT_BASE_COLORS:
            paint += 1
        if abs(nx * nx + ny * ny + nz * nz - 1.0) > 1e-3:
            nrm_bad += 1

    return (minx, miny, minz, maxx, maxy, maxz), palette, paint, alpha_bad, nrm_bad


def load_mesh(path: str, deep: bool = False) -> Mesh:
    """只读打开并解析单个 .mesh 文件。"""
    with open(path, "rb") as fh:
        data = fh.read()
    return parse_mesh(data, path=path, deep=deep)


# --------------------------------------------------------------------------
# 遍历（排除 back up 镜像）—— 所有脚本共用此单一实现
# --------------------------------------------------------------------------


def iter_game_meshes(root: str = GAME_ROOT, exts=(".mesh",)) -> Iterator[str]:
    """遍历游戏目录下所有 .mesh，自动剪枝 `back up/` 镜像目录。

    排除逻辑集中在此，禁止在其他脚本里各自实现。
    """
    root = os.path.abspath(root)
    backup_abs = os.path.abspath(os.path.join(root, BACKUP_DIR))
    exts = tuple(e.lower() for e in exts)

    for dirpath, dirnames, filenames in os.walk(root):
        # 剪枝：备份镜像 + 常见噪声目录
        dirnames[:] = [
            d
            for d in dirnames
            if os.path.abspath(os.path.join(dirpath, d)) != backup_abs
        ]
        for fn in filenames:
            if fn.lower().endswith(exts):
                yield os.path.join(dirpath, fn)


def count_backup_meshes(root: str = GAME_ROOT) -> int:
    """统计被排除的备份镜像文件数（写入索引 _stats 便于回归）。"""
    backup = os.path.join(root, BACKUP_DIR)
    if not os.path.isdir(backup):
        return 0
    n = 0
    for _, _, files in os.walk(backup):
        n += sum(1 for f in files if f.lower().endswith(".mesh"))
    return n


def rel_to_rom(path: str) -> str:
    """把绝对路径转成「含 rom/ 前缀」的相对形式。"""
    p = os.path.abspath(path).replace("\\", "/")
    idx = p.lower().rfind("/rom/")
    return p[idx + 1 :] if idx >= 0 else p


def mesh_ref_key(path: str) -> str:
    """把磁盘路径转成定义 XML 里的引用格式（相对 rom/，不含 rom/ 前缀）。

    `E:\\...\\rom\\meshes\\a.mesh` → `meshes/a.mesh`

    定义 XML 的 `mesh_data_name` 采用此写法，故作为索引的统一键。
    与 `rel_to_rom()` 的差别仅在于是否保留 `rom/` 前缀。
    """
    p = os.path.abspath(path).replace("\\", "/")
    idx = p.lower().rfind("/rom/")
    return p[idx + 5 :] if idx >= 0 else p


# --------------------------------------------------------------------------
# 导出（护栏：只允许写入 D:\\STORMWORKS）
# --------------------------------------------------------------------------


def guard_output_path(path: str) -> str:
    """导出路径必须落在工作区内，否则拒绝。只读红线的代码级护栏。"""
    abs_p = os.path.abspath(path)
    ws = os.path.abspath(WORKSPACE_ROOT)
    try:
        inside = os.path.commonpath([abs_p, ws]) == ws
    except ValueError:
        # 跨盘符时 commonpath 直接抛 ValueError；此时必然不在工作区内。
        # 必须转成 MeshFormatError，否则调用方按护栏异常捕获会漏掉，
        # 且报错信息丢失「只读红线」语义。
        inside = False
    if not inside:
        raise MeshFormatError(
            "拒绝写入工作区之外的路径：%s\n"
            "（只读红线：一切产出只能写进 %s）" % (abs_p, WORKSPACE_ROOT)
        )
    parent = os.path.dirname(abs_p)
    os.makedirs(parent, exist_ok=True)
    return abs_p


def to_obj(mesh: Mesh, out_path: str, name: str = None) -> str:
    """导出 Wavefront OBJ。需要 deep=True 解析。"""
    if mesh.vertices is None or mesh.indices is None:
        raise MeshFormatError("导出 OBJ 需要 deep=True 解析")

    out_path = guard_output_path(out_path)
    base = name or os.path.splitext(os.path.basename(mesh.path or "mesh"))[0]

    lines = [
        "# Stormworks .mesh -> OBJ",
        "# source: %s" % (mesh.path or ""),
        "# verts=%d tris=%d submeshes=%d"
        % (mesh.vertex_count, mesh.tri_count, len(mesh.submeshes)),
        "o %s" % base,
    ]
    for v in mesh.vertices:
        lines.append(v.as_obj())

    idx = mesh.indices
    cursor = 0
    for si, sm in enumerate(mesh.submeshes):
        lines.append("g %s_%d_%s" % (base, si, sm.name or "unnamed"))
        # usemtl 标注 shader 语义，便于在 Blender 里区分材质
        lines.append("usemtl shader_%d_%s" % (sm.shader_id, sm.shader_name))
        n = sm.index_length if sm.index_length else (len(idx) - cursor)
        end = min(cursor + n, len(idx) - 2)
        for i in range(cursor, end, 3):
            a, b, c = idx[i] + 1, idx[i + 1] + 1, idx[i + 2] + 1
            lines.append("f %d %d %d" % (a, b, c))
        cursor = end

    with open(out_path, "w", encoding="utf-8") as fh:
        fh.write("\n".join(lines) + "\n")
    return out_path


# --------------------------------------------------------------------------
# 全量校验
# --------------------------------------------------------------------------


def verify_all(root: str = GAME_ROOT, verbose: bool = True) -> dict:
    """全量解析所有非备份 .mesh，返回统计字典。

    退出码语义由 CLI 决定：任何一条不闭合即视为格式漂移。
    """
    stats = {
        "root": root,
        "files": 0,
        "exact_close": 0,
        "failed": 0,
        "total_verts": 0,
        "total_indices": 0,
        "header_const_ok": 0,
        "sentinel_zero": 0,
        "normal_ok": 0,
        "alpha_nonopaque_files": 0,
        "submesh_hist": Counter(),
        "shader_hist": Counter(),
        "failures": [],
        "excluded_backup": count_backup_meshes(root),
    }

    for path in iter_game_meshes(root):
        stats["files"] += 1
        try:
            with open(path, "rb") as fh:
                data = fh.read()
            m = parse_mesh(data, path=path)
        except (MeshFormatError, struct.error, OSError) as exc:
            stats["failed"] += 1
            if len(stats["failures"]) < 20:
                stats["failures"].append({"path": path, "error": str(exc)})
            continue

        if m.is_exact:
            stats["exact_close"] += 1
        else:
            stats["failed"] += 1
            if len(stats["failures"]) < 20:
                stats["failures"].append(
                    {
                        "path": path,
                        "error": "指针未闭合 consumed=%d size=%d"
                        % (m.bytes_consumed, m.file_size),
                    }
                )

        stats["total_verts"] += m.vertex_count
        stats["total_indices"] += m.index_count
        h0, h1, _vc, h3, h4 = m.header_fields
        if (h0, h1, h3, h4) == HEADER_CONST:
            stats["header_const_ok"] += 1
        if m.sentinel == 0:
            stats["sentinel_zero"] += 1
        if m.normal_bad == 0:
            stats["normal_ok"] += 1
        if m.alpha_nonopaque:
            stats["alpha_nonopaque_files"] += 1
        stats["submesh_hist"][len(m.submeshes)] += 1
        for s in m.shader_ids:
            stats["shader_hist"][s] += 1

        if verbose and stats["files"] % 500 == 0:
            print("  ... %d 个已解析" % stats["files"], file=sys.stderr)

    return stats


# --------------------------------------------------------------------------
# CLI
# --------------------------------------------------------------------------


def _fmt_info(m: Mesh) -> str:
    L = []
    L.append("文件          : %s" % (m.path or "<memory>"))
    L.append(
        "大小          : %d B（解析消耗 %d B）%s"
        % (m.file_size, m.bytes_consumed, "✓精确闭合" if m.is_exact else "✗未闭合")
    )
    L.append("顶点 / 三角   : %d / %d" % (m.vertex_count, m.tri_count))
    L.append("头部字段      : h0=%d h1=%d vc=%d h3=%d h4=%d" % m.header_fields)
    L.append("尾哨兵        : %d" % m.sentinel)
    if m.aabb:
        L.append(
            "实测 AABB     : (%.4f, %.4f, %.4f) ~ (%.4f, %.4f, %.4f)"
            % tuple(round(v, 4) for v in m.aabb)
        )
    dm, db = m.dim_m, m.dim_blocks
    L.append(
        "实测尺寸      : %.4f × %.4f × %.4f m  =  %.3f × %.3f × %.3f 格"
        % (dm[0], dm[1], dm[2], db[0], db[1], db[2])
    )
    L.append("bounds 可信度 : %s" % m.bounds_kind)
    L.append("可涂色顶点    : %d / %d" % (m.paint_verts, m.vertex_count))
    L.append(
        "alpha≠255     : %d 个顶点；法线异常 %d 个" % (m.alpha_nonopaque, m.normal_bad)
    )
    if m.palette:
        top = m.palette.most_common(6)
        L.append("主色调 Top%d   :" % len(top))
        for col, n in top:
            L.append(
                "    RGB(%3d,%3d,%3d)  %7d 顶点  #%02x%02x%02x"
                % (col[0], col[1], col[2], n, col[0], col[1], col[2])
            )
    L.append("SubMesh (%d)   :" % len(m.submeshes))
    for i, s in enumerate(m.submeshes):
        L.append(
            "  [%d] name=%-14r shader=%d(%-11s) idx=%d..+%d  bounds=(%.3f,%.3f,%.3f)~(%.3f,%.3f,%.3f)%s"
            % (
                i,
                s.name,
                s.shader_id,
                s.shader_name,
                s.index_start,
                s.index_length,
                s.bounds_min[0],
                s.bounds_min[1],
                s.bounds_min[2],
                s.bounds_max[0],
                s.bounds_max[1],
                s.bounds_max[2],
                ("  ⚠ " + ",".join(s.anomalies)) if s.anomalies else "",
            )
        )
    return "\n".join(L)


def _mesh_to_json(m: Mesh) -> dict:
    d = {
        "path": m.path,
        "file_size": m.file_size,
        "bytes_consumed": m.bytes_consumed,
        "exact": m.is_exact,
        "vertex_count": m.vertex_count,
        "index_count": m.index_count,
        "tri_count": m.tri_count,
        "header_fields": list(m.header_fields),
        "sentinel": m.sentinel,
        "aabb": list(m.aabb) if m.aabb else None,
        "dim_m": list(m.dim_m),
        "dim_blocks": list(m.dim_blocks),
        "bounds_kind": m.bounds_kind,
        "paint_verts": m.paint_verts,
        "alpha_nonopaque": m.alpha_nonopaque,
        "normal_bad": m.normal_bad,
        "palette_top": [
            [list(c), n] for c, n in (m.palette.most_common(8) if m.palette else [])
        ],
        "submeshes": [
            {
                "name": s.name,
                "shader_id": s.shader_id,
                "shader": s.shader_name,
                "index_start": s.index_start,
                "index_length": s.index_length,
                "bounds_min": list(s.bounds_min),
                "bounds_max": list(s.bounds_max),
                "scale": list(s.scale),
                "anomalies": s.anomalies,
            }
            for s in m.submeshes
        ],
    }
    return d


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(
        prog="sw_mesh.py",
        description="Stormworks .mesh 解析器（纯标准库，只读）",
    )
    sub = ap.add_subparsers(dest="cmd", required=True)

    p_info = sub.add_parser("info", help="单文件详情")
    p_info.add_argument("file")

    p_json = sub.add_parser("json", help="单文件详情（JSON）")
    p_json.add_argument("file")

    p_head = sub.add_parser("head", help="仅头部 14 字节")
    p_head.add_argument("file")

    p_obj = sub.add_parser("obj", help="导出 Wavefront OBJ")
    p_obj.add_argument("file")
    p_obj.add_argument("-o", "--out", required=True, help="输出路径（须在 D:\\STORMWORKS 下）")
    p_obj.add_argument("--name", default=None)

    p_ver = sub.add_parser("verify", help="全量校验（排除 back up/）")
    p_ver.add_argument("--root", default=GAME_ROOT)
    p_ver.add_argument("--json", action="store_true")

    args = ap.parse_args(argv)

    if args.cmd == "info":
        m = load_mesh(args.file)
        print(_fmt_info(m))
        return 0 if m.is_exact else 2

    if args.cmd == "json":
        m = load_mesh(args.file)
        print(json.dumps(_mesh_to_json(m), ensure_ascii=False, indent=2))
        return 0 if m.is_exact else 2

    if args.cmd == "head":
        with open(args.file, "rb") as fh:
            blob = fh.read(HEADER_SIZE)
        magic, h0, h1, vc, h3, h4 = HEADER.unpack(blob)
        print("magic : %r" % magic)
        print("h0    : %d (期望 7)" % h0)
        print("h1    : %d (期望 1)" % h1)
        print("verts : %d" % vc)
        print("h3    : %d (期望 19)" % h3)
        print("h4    : %d (期望 0)" % h4)
        print("hex   : %s" % blob.hex(" "))
        return 0

    if args.cmd == "obj":
        m = load_mesh(args.file, deep=True)
        out = to_obj(m, args.out, args.name)
        print(
            "已导出 %s  →  v=%d f=%d  (%d submesh)" % (out, m.vertex_count, m.tri_count, len(m.submeshes))
        )
        return 0

    if args.cmd == "verify":
        stats = verify_all(args.root, verbose=not args.json)
        if args.json:
            s = dict(stats)
            s["submesh_hist"] = dict(s["submesh_hist"])
            s["shader_hist"] = {str(k): v for k, v in s["shader_hist"].items()}
            print(json.dumps(s, ensure_ascii=False, indent=2))
        else:
            print("=" * 60)
            print("全量校验结果  root=%s" % stats["root"])
            print("=" * 60)
            print("文件总数        : %d" % stats["files"])
            print("精确闭合        : %d" % stats["exact_close"])
            print("失败            : %d" % stats["failed"])
            print("排除 back up/   : %d" % stats["excluded_backup"])
            print("顶点总量        : %d" % stats["total_verts"])
            print("索引总量        : %d" % stats["total_indices"])
            print("头部恒定        : %d" % stats["header_const_ok"])
            print("尾哨兵=0        : %d" % stats["sentinel_zero"])
            print("法线全单位      : %d" % stats["normal_ok"])
            print("含 alpha≠255    : %d 个文件" % stats["alpha_nonopaque_files"])
            print("submesh 数分布  : %s" % dict(sorted(stats["submesh_hist"].items())))
            print("shader 分布     : %s" % dict(sorted(stats["shader_hist"].items())))
            if stats["failures"]:
                print("\n失败样本（最多 20 条）：")
                for f in stats["failures"]:
                    print("  %s\n      %s" % (f["path"], f["error"]))
        return 0 if stats["failed"] == 0 else 2

    return 1


if __name__ == "__main__":
    sys.exit(main())
