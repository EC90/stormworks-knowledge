---
name: sw-mesh-tools
description: 解析 Stormworks 的 .mesh 二进制几何文件，查询部件的真实渲染尺寸（AABB/三角数/着色器/可涂色区域）。当需要知道部件的实际几何尺寸、三角面数、是否能涂装、部件与 mesh 的对应关系，或要导出部件模型，以及游戏更新后校验 .mesh 格式是否漂移时使用。
agent_created: true
---

# Stormworks `.mesh` 几何解析

> 📌 **路径占位符（因机器而异，先解析再用）**：
> `<WS>` = 工作区根、`<PY>` = 纯标准库 Python、`<SW_GAME>` = 游戏根目录（🚫 只读）。
> 解析：`<PY> "<WS>\工作区导航\脚本\sw_paths.py" --json`。
> 脚本已内置三级解析（环境变量 `SW_GAME` → `<WS>\工作区导航\路径配置.json` → 回退值），**换机器不用改代码**。

## 适用场景

- 想知道某个部件的**真实几何尺寸**（亚格精度），而不只是 XML 声明的占位格数
- 需要部件的三角面数、着色器类型、**是否可涂装**
- 要导出部件模型（OBJ）做外观参考
- 查「哪些部件共用同一个网格」「这个 mesh 被哪些部件引用」
- **游戏更新后**校验 `.mesh` 格式是否漂移

## 🚫 只读红线（代码级护栏，不可绕过）

1. `<SW_GAME>` **只读**。解析器全程 `open(path,'rb')`，代码内不含任何写模式。
2. **一切产出只能写进 `<WS>`**。`guard_output_path()` 会拒绝工作区之外的导出路径。
3. 不复制社区代码（规避 LGPL-3.0），只参照格式事实自行实现。

## 快速命令

```bash
PY="<PY>"
K="<WS>\技能库\sw-mesh-tools\scripts"

# ① 查部件几何（中文名 / 英文名 / 定义 id 都能查）
"$PY" "$K/sw_geom.py" get 气压计
"$PY" "$K/sw_geom.py" get Barometer

# ② 按 mesh 名查
"$PY" "$K/sw_geom.py" mesh component_barometer

# ③ 排行（verts / tris / vol / paint / size）
"$PY" "$K/sw_geom.py" top --by verts --limit 20

# ④ 单文件详情 / 导出 OBJ
"$PY" "$K/sw_mesh.py" info "<SW_GAME>\rom\meshes\component_barometer.mesh"
"$PY" "$K/sw_mesh.py" obj  "<SW_GAME>\rom\meshes\component_barometer.mesh" -o "<WS>\_work\mesh_preview\x.obj"

# ⑤ 全量校验格式（3653 个文件，约 11 秒；失败退出码 2）
"$PY" "$K/sw_mesh.py" verify

# ⑥ 重建索引（游戏更新后）
"$PY" "$K/build_mesh_index.py" --incremental

# ⑦ SDK 源资产交叉验证
"$PY" "$K/sdk_crosscheck.py" --limit 150

# ⑧ 离线自检 17 项（改脚本后 / 游戏更新后必跑；失败退出码 1）
"$PY" "$K/selftest.py"
```

## 数据链路

```
<SW_GAME>\rom\data\definitions\*.xml   部件定义（mesh_data_name 引用）
<SW_GAME>\rom\meshes\**\*.mesh         几何二进制（只读）
        ↓  build_mesh_index.py（唯一的游戏目录直读脚本）
<WS>\数据库\方块数据\数据\mesh_index.json      摘要索引（2 MB，不含顶点）
        ↓  sw_geom.py（只读本地索引，日常查询不碰游戏目录）
<WS>\数据库\方块数据\21_部件几何档案.md         第 21 册知识册
```

**两层索引**：顶点/索引/三角面（465 MB）**永不落盘**，只存标量摘要；
需要完整几何时用 `sw_mesh.py` 现场从游戏目录解析。

## 格式速查（完整规格见 `reference\格式规格.md`）

```
小端
char[4]  "mesh"                     magic
u16      7 / u16 1 / u16 vc / u16 19 / u16 0      ← 头部共 14 字节
Vertex[vc] 28B: f32[3]pos + u8[4]RGBA + f32[3]normal   （无 UV，设计如此）
u32      indexCount ; u16[indexCount]
u16      subMeshCount
  per: u32 start, u32 length, u16 0, u16 shaderId,
       f32[6] bounds, u16 0, u16 nameLen, char[name], f32[3](1,1,1)
u16      0                          尾哨兵
```

- **1 格 = 0.25 m**，Y 轴向上
- shaderId：0 Opaque / 1 Transparent / 2 Emissive / 3 Lava
- 可涂色基色 **RGB(255,125,0)** `#ff7d00`（另有 `(155,125,0)`、`(55,135,0)` 两档变体）
- `paint_verts == 0` → 不可涂装；`== verts` → 整件随涂装变色

## 硬规则（不要自行发挥）

1. **必须排除 `back up/` 镜像**（3613 个，与 `rom/` 完全重复）。
   排除逻辑集中在 `sw_mesh.iter_game_meshes()`，**所有脚本共用，禁止各自实现**。
   漏排会导致索引翻倍、部件关联出现幽灵条目。
2. **指针闭合是最强断言**：`bytes_consumed == file_size`。
   当前 **3653/3653 通过**。格式一旦漂移必然大面积不闭合 —— 这是版本漂移的第一探测器。
3. **社区文档一律先经全量指针闭合复核再采信**，不得直接照抄。
   本机已实测修正三处社区错误（详见规格文档 §5）：
   - 头部是 **5 个 u16 / 14 字节**（社区写 6 个 u16 / 16 字节，照抄会全部错位）
   - `rom/meshes` 顶层 **1777 个 stem 100% 有同名 SDK 源资产**
   - **alpha 不恒为 255**（221/3653 个文件含 alpha≠255）
4. **未解字段禁止杜撰语义**：`u16 7`、`u16 1`、`u16 19`、submesh 的 `start/length` 与尾部 `f32[3](1,1,1)` 用途不明，一律标「恒定但语义未定」。
5. **bounds 有两种语义，不可混用**：
   - 部件件（`component_*`）940/940 精确 → `bounds_kind: "exact"`，可直接用
   - 地形件是**瓦片声明框**（1596 个）→ `"tile_declared"`，不可当尺寸
6. **SDK 交叉验证的两个指标可信度不同**：
   - 三角数一致率 ~84% → **可作佐证**
   - 顶点数一致率 ~48% → **不可作断言**，编译期必然做顶点合并（weld），源 `.dae` 是未合并的 split vertices
7. **术语必须先查表**：部件中文名走 `<WS>\汉化相关\数据\sw_glossary.jsonl`（或直接复用其派生产物 `xml_id_map.json` 的 `zh` 字段）。未命中须标 `※`。

## 数据解读陷阱（已踩过，别再踩）

- **可动部件烘焙了极限姿态**：气动活塞占位 1x2x1，实测 1×**5.10**×1（活塞杆伸出态）。实测 > 占位属正常，不是解析错误。
- **占位 ≠ 视觉体积**：雷达(巨) 占位与实测**均为 37×5×37 格**（定义 `<voxel_min x="-18"/>`/`<voxel_max x="18"/>`），
  因为**雷达的占位即其扫描范围**。这不是异常，是游戏机制。
- **勿用启发式自动判定「辅助几何」**：试过「顶点全为基色」「归一化填充度」，均大量误报
  （机翼、龙骨、气罐等真实大尺寸/薄壳部件被误判）。判读依据是 §6 的 vox 比对。
- **同名多行不是重复 bug**：`_fluid` / `_torque` / `_v2` 变体与基础版共用同一 mesh，用「定义 id」列区分。

## 与其他工具的分工

| 工具 | 提供什么 |
| --- | --- |
| `sw_defs.py` | 🎮 权威规格：mass / $ / 逻辑节点 / **占位格数**（来自定义 XML） |
| `sw_geom.py`（本技能） | **真实几何**：实测 AABB / 三角数 / 着色器 / 可涂色顶点（来自 .mesh 二进制） |
| `sw_vehicle.py` | 载具 XML 解读与部件统计 |

两者是「逻辑占位」与「物理外观」两个维度，可交叉纠错。
**独立验证**：占位格数来自 `<voxel_min>/<voxel_max>`，与 `.mesh` 二进制完全无关；
558 条可比对部件中 **92.3% 吻合**，构成对解析正确性的强验证。

## 游戏更新后的例行流程

1. **`selftest.py`** —— 17 项自检（格式漂移/备份排除/护栏/基准值）。
   指针闭合失败即格式已漂移；索引类测试不依赖游戏目录，永远可跑。
2. `sw_mesh.py verify` —— 全量 3653 个文件复验
3. 重新逆向并更新 `reference\格式规格.md`（含更新基准值到 `selftest.py` 的 `BAROMETER` 常量）
4. `build_mesh_index.py --incremental`
5. `build_geom_book.py` 重新生成第 21 册
