# BKN 工具集 · Lua 参考实现（原样收录）

> **AI 阅读规则（先读这段，先于正文）**
> - 来源：BKN46/bkn-stormworks-utils（提交 `54fcd2b`，2026-07-11，MIT 许可，见 `LICENSE`）。
> - 本目录是**代码原文收录**，未做中文整理——因为其中每个主题的"知识"在下面的对照表里
>   均有工作区正式知识册覆盖。这里的价值是**最小可运行参考实现**，写代码时照抄风格用。
> - 与 bknsw 文档站（`../BKN的Stormworks Lua手册/BKN46-bknsw-6300d21/`，已是最新提交）
>   互补：那边讲原理，这边是作者的实战代码。

## 文件 → 知识册对照表

| 文件 | 内容 | 概念已覆盖于 |
| --- | --- | --- |
| `sw-bases/matrix_transform.lua` | 欧拉角→旋转矩阵、全局↔局部坐标变换（**含 isGlobalToLocal 双向开关**） | `方块数据/17_传感器与雷达.md`、bknsw `Tools/Math/matrix-*.md` |
| `sw-bases/radar.lua` | 雷达目标从载具局部系解算到世界系（矩阵转置 × 局部坐标 + 载具位置） | 同上 + bknsw `Tools/Radar/` |
| `sw-bases/screen_projection.lua` | 世界目标投影到载具局部系（炮塔/屏幕指向用） | 同上 |
| `sw-bases/autoLoader.lua` | 火炮自动装弹状态机 + **tick 延迟事件队列**（addDelay/doDelay 模式） | `Lua/Lua示例/02_逻辑IO·状态机·定时.md`、bknsw `Tutorial/state_machine.md` |
| `rwr_雷达告警.lua` | 雷达告警接收机：解析雷达扫描输出的多目标方位，融合罗盘 | `方块数据/17_传感器与雷达.md` §雷达数据 |
| `laser-encoding_激光通信编码.lua` | **用激光信标/激光点传感器做串行数据传输**：6 tick 窗口同步帧 `111111` + 数据帧 `0xxxx0`，9 Hz | 工作区无直接覆盖（`10_无线电.md` 是无线电），此为独有技巧 |
| `addon-lib/*.lua` | **附加 Lua（Addon Lua）实用标准库**：json / timers / ui / vehicle / data / math / strings / utils，共 9 模块约 600 行 | `lua总体设定/01_addon_Lua_API速查.md`（API 层面），此处为封装层实现 |
| `time-attack-addon/` | 完整计时赛 addon 应用：检查点、`g_savedata` 持久化、httpGet 数据上报、看门狗（Lua+Python 双实现） | `lua总体设定/01_addon_Lua_API速查.md`（概念），此处为完整范例 |

## 使用建议

- 写**脚本方块 Lua**（onTick/onDraw）要抄坐标变换/状态机骨架 → 先看 `sw-bases/`；
- 写**附加 Lua**（server.*）需要 JSON、计时器、UI 面板、载具数据 → 直接 `require` 风格参考 `addon-lib/`；
- 做**载具间无电缆数据链**且无线电不适用时 → `laser-encoding`（注意：带宽极低，约 9 bit/s 量级）；
- 要一个**从零到成品的 addon 全流程范例** → `time-attack-addon/main.lua`（408 行，含存档结构设计）。

## 术语备注（依 `汉化相关/` 对照表）

激光信标（Laser Beacon）、激光点传感器（Laser Point Sensor）、雷达（Radar）、
激光编码（Laser Wavelength，UI 实际标签）、微控制器（microcontroller）、复合信号（composite）。

上游仓库：<https://github.com/BKN46/bkn-stormworks-utils>
（本目录未收录其 sw-oscilloscope / sw-video-lua 子目录——工作区已有本地化版本：
`数据库/SW示波器v0.1.3/`、`数据库/SW Lua读取处理视频信号 by BKN/`。）
