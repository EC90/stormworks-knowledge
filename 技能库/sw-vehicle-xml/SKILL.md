---
name: sw-vehicle-xml
description: 解析与编辑 Stormworks 载具 XML（vehicles/*.xml）与微控制器内部接线的权威方法。当需要分析载具结构、读取部件体素坐标/旋转、修改微控制器 Lua 脚本或内部接线、计算部件间位置偏差时使用。含 MC 内部组件 type 语义表与编辑验证纪律。
agent_created: true
---

# Stormworks 载具 XML 解析与编辑

> 📌 **路径占位符（因机器而异，先解析再用）**：
> `<WS>` = 工作区根（`D:\STORMWORKS`）、`<HOME>` = 用户主目录（**含用户名**）、
> `<SW_SAVE>` = Stormworks 存档目录、`<PY>` / `<PYX>` = Python 解释器（纯标准库 / 带三方包）、
> `<SW_GAME>` / `<SW_WORKSHOP>` / `<STEAM_LIB>` = 游戏根目录 / 创意工坊 / Steam 库（**盘符与目录名都不固定**）。
> 解析：`python "<WS>/工作区导航/脚本/sw_paths.py"`（`--json` / `--write`）。
> 报 `MISS` 时按其排查建议定位后回写 `工作区导航\路径配置.json` 与
> `04_环境与外部依赖.md` §7。约定见 `工作区导航\07_路径占位符约定.md`。


## 何时使用

分析/修改 `<SW_SAVE>\data\vehicles\*.xml`（或 missions 内载具；`<SW_SAVE>` 位置随平台变化，由 `sw_paths.py` 解析）：
部件清单与坐标、微控制器（MC）内外接线、替换 MC 内 Lua、按 XML 计算部件固定偏差。

## 载具 XML 结构要点

- 🔑 **camera_med（Camera Medium）确实支持 Pivot X/Y 云台控制**（Fandom wiki 漏写，游戏定义 `rom/data/definitions/camera_med.xml` 为唯一权威）：
  `<logic_node label="Pivot" type="5" description="Inputs for camera X/Y pivot. (Value 1 : Pivot X) (Value 2 : Pivot Y)">`，
  tooltip「Can be pivoted up to **0.125 turns** using composite input」。**Pivot 复合输入上限 ±0.125 圈**，符号：Value1=水平、Value2=垂直（具体正负方向以实测为准）。写 Lua 驱动相机云台时钳制到 ±0.125。
- 🔑 **SW示波器 CSV 列索引是 0 基**：录制 MC 的 `output.setNumber(N, val)` 对应 CSV **第 N-1 列**（num1→col0 … num20→col19）。读数据时务必 `col = num-1` 偏移，否则会把相邻通道（如 FOV）误当目标通道。
- 单根 `<vehicle>` → `<bodies>` 下**多个 `<body>`**；**每个 `<body>` 就是一个物理网格（子网格）**。
  **判断部件在哪个网格 = 看它在哪个 `<body>` 的 `<components>` 里**（multibody 部件如座圈/枢轴会创建子 body）。
  示例：RADAR_TEST 的 body279=平台固定部分（含 turret_large_a 底座），body285=座圈旋转子网格（含 turret_large_b + 雷达 + 物理传感器 + 摄像头）。
  ⚠ 载具 `<c>` 上的 `t="N"` 属性是另一概念（语义未定），**网格归属以 `<body>` 为准，勿用 t 判断**。
- 部件位置：`<o><vp x y z>`（体素，0.25 m/格；缺省属性=0；**无 `<vp>` = 原点 (0,0,0)**）；子网格内部件的 vp 是相对该子网格的局部坐标。
- 旋转：`<o r="...">` 为行优先 3×3 矩阵，语义 = **部件本地系(X右/Y前/Z上) → 载具体素系(X右/Y上/Z前)**。
  r=identity 即两系对齐（部件前=体素+Z，上=+Y）。部件定义 XML 里的 `<logic_node><position>` 偏移同样按此系相加。
- 外部接线：`<logic_node_links><logic_node_link type="T">` 两端 `<voxel_pos_0/1>`；
  type：1=数值 4=电 5=复合 6=视频（None=布尔）。voxel = 部件 vp + 定义文件节点 position。
- 部件权威规格查 `数据库/方块数据/脚本/sw_defs.py`；定义 id ↔ 游戏内名对照查
  `数据库/方块数据/原始抓取_游戏定义/name_index.json`；雷达/相机/传感器节点语义先看 `17_传感器与雷达.md`。

## 微控制器（MC）内部结构

`<microprocessor_definition><group>` 下两类元素：

**components_bridge（外壳接口，映射外部 logic_slots）** type 语义：
| type | 含义 |
|---|---|
| 3 | 数值输出 | 
| 4 | 复合输入 |
| 5 | 复合输出 |
| 6 | 视频输入 |
| 7 | 视频输出 |

**components（内部元件）** type 语义：
| type | 含义 |
|---|---|
| 29 | 布尔读取：`i`=通道偏移(0基)，in1=复合源 |
| 31 | 数值读取：同上 |
| 40 | 数值打包进复合：`count`、`offset`(0基起始通道)、`inc`=**上一级混合总线**、in1..n |
| 41 | 布尔打包：count、in1..n（可挂入 40 的 inc 链） |
| 56 | Lua：`script` 属性；in1=复合入、in2=视频入；输出 node0=复合(被 bridge in1 引用)、node_index=1=视频 |
| 58 / 34 / 20 | 文本 / 数值 / 枚举属性（`n`=属性名，`v`=值） |

- **总线汇合**：type40 用 `inc` 串联成链（如 81←95←83←88），链头输出 = 全部通道并集。
  Lua 只有 1 个复合输入，多源数据必须先 pack 成一条总线再进 lua。
- 🔑 **`inc` 的透传语义（2026-09-04 实测反推，`ACM HMD.xml`）**：`inc` 指向**上一级混合总线**——
  可以是另一个打包块，**也可以直接是一个 type 4 混合输入桥**。链头指向桥时，
  该打包块**未接线的低位通道会原样透传这个桥**（如 `in1..in6` 全空 = 透传传感器桥的 ch1-6）；
  `in_k` 则覆盖到通道 `offset+k`（`offset` 0 基，缺省 0）。
  → **一个微控里可以挂多条链共享同一个输入桥做基底**，各自往不同 `offset` 注入不同数据，
  喂给不同的 Lua 块（每块拿到一份定制总线，公用部分只打包一次）。
- 🔑 **一个微控可有多个 type 56 Lua 块，各自独立全局环境**（同名函数互不覆盖、也不共享）。
  收益：每块有独立的 8192 字符预算，是拆分大 HUD 的正当手段。
  **画面串联**：块 A 的视频输出（`node_index=1`）接块 B 的 `in2`（视频输入），B 的 `onDraw` 画在 A 之上，
  B 的视频输出再接到 type 7 视频输出桥 —— 即「图层叠加」。
- bridge↔外部 voxel 的几何顺序不可靠；**按通道内容/功能推断配对并交叉验证**（读几个通道、有无布尔、去向部件是什么）。
- 对象间连线：`<in1 component_id="..."/>`；一个输出可扇出到多个输入。

## Lua script 属性序列化（重要）

- 文件内是**字面换行**（游戏原生格式，游戏能正确解析 `--` 行注释），直接写多行即可，缩进用 tab。
- 属性双引号包裹：脚本内**禁用双引号**；`<`、`&` **绝对禁止**（`>` 合法）；
  **比较运算一律用 `>` 方向**（`if a>10`、`if -10>b`、`if DEAD>math.abs(e)`），或 `math.min/math.max`，严禁 `b<10`、`e<DEAD` 这类写法（`<` 会直接破坏 XML，游戏崩溃/解析失败）。
  **注释里也不得出现半角 `<`**（如「误差<0.01」会照样破坏 XML）——注释用「低于/大于/≤(全角)」等文字替代。
- MC Lua 上限约 4096 字符/脚本；Stormworks Lua `math.atan` 单参数（ atan2 用 at(x/y) 且 y>0 代替）。

## 编辑纪律（必须执行）

1. **先备份**原文件到 `<WS>\_work\`（禁写 Steam 目录；载具目录属用户数据，备份后再改）。
2. 用 Edit 精确替换；**Edit 报告成功后必须重新 grep 复核**（本技能建立时亲历一次静默未生效，二次执行才落盘）。
3. 改后 `python -c "import xml.etree.ElementTree as ET;ET.parse(path)"` 验 well-formed（游戏解析器更宽松，ET 通过即安全）。
4. 坐标解算/数学逻辑改动：用 Python 复刻 Lua 逻辑做**离线数值仿真**（多姿态往返误差=0）再交付。
5. 解析大文件（载具 XML 常 0.5MB+ 单行）：禁止 Read 全文，用 Python/grep 定点提取。
6. ⚠ **同一载具的多个 Lua 块可有同名函数/变量但语义不同**：实测 `RADAR_TEST` 的 object 82 与 object 96
   都定义了 `rotm` / `wld` / `CAMOFF` —— 但 96 里是**死代码**（结果未参与 pivot/FOV），
   82 里是**活的**（`*pi2`、`wld(m,RADOFF...)` 用于解算世界坐标）。
   **清理/替换必须按 `object id` 精确限定作用域**（正则锚定 `id="96" script="([^"]*)"` 后只对捕获组操作），
   **切勿按函数名全局替换**，否则会静默删掉另一块的活代码。

## 检索指引（雷达 / 摄像头 / 座圈）

以下均为**本机实测**结论，与 wiki/Fandom 冲突时以它们为准：

| 需求 | 文档 |
|---|---|
| 雷达噪声表征、稳像架构原理、座圈调参历程、工程陷阱清单 | `数据库/方块数据/雷达与摄像头稳定_阶段总结.md` |
| 可直抄的 Lua（残差→Pivot + FOV、座圈控制） | `数据库/Lua/Lua示例/03_传感器与雷达解算.md` §10 |
| 部件节点 / 通道语义 | `数据库/方块数据/17_传感器与雷达.md`（§2 雷达、§6.2 摄像机含 Pivot） |

🔑 **架构要点**：camera_med 的 Pivot 是**无惯性逻辑轴**（给角度即瞬间指向），
故摄像头应走「雷达 az/el 残差 + 轻滤波 α=0.3 → Pivot」，**与座圈（物理电机、有真实滞后）解耦**；
**不要**给无惯性轴套用 ABF 等重滤波——会引入 ~10 tick 滞后，画面永远落后座圈半拍。

## 参考实现

`<WS>\_work\radar_test\parse_vehicles.py` —— 载具结构解析器（部件清单/MC 内部接线/Lua 提取/逻辑链接）。
