> **AI 阅读规则（先读这段，先于正文）**
> - 📌 路径占位符 `<WS>`/`<HOME>`/`<PY>`/`<PYX>`/`<SW_GAME>`/`<SW_WORKSHOP>` 均**因机器而异**，
>   用 `python "<WS>\工作区导航\脚本\sw_paths.py"` 解析，见 `<WS>\工作区导航\07_路径占位符约定.md`。
> - 本册是 Stormworks Lua 的**总入口索引**，不是 API 全文。API 细节在 `原始抓取_*/` 与 `01_addon_Lua_API速查.md`。
> - Stormworks 有**两套完全不同的 Lua 体系**，混淆是最常见的错误：
>   - **脚本 Lua（Script Lua）** = 装在载具/建筑上的「Lua 脚本方块」，通过 `input/output` 读写复合信号、在显示器上画图。回调只有 `onTick` + `onDraw`。
>   - **附加 Lua（Addon Lua）** = 任务/模组脚本，跑在 `server.*` 全局对象上，操作整个世界（生成载具、天气、玩家）。回调有几十个（`onCreate`/`onVehicleSpawn`/`onChatMessage`…）。
>   - **两者 API 不互通**：脚本 Lua 没有 `server`，附加 Lua 没有 `screen`/`input`/`output`。
> - 凡涉及 Stormworks 专有名词先看 `<WS>\汉化相关\` 对照表；本册着重**机制差异**，不重复术语翻译。
> - 数值/签名以游戏内 Help 标签与官方更新为准；日文 wiki 原文基准 **v1.15.20（2026-08-15）**，Fandom 多页停留在 2021–2023 且为空壳，仅作补充。

# Stormworks Lua 总体设定

来源抓取：

| 来源 | 站点 | 抓取工具 | 原始抓取目录 |
| --- | --- | --- | --- |
| 英文 Fandom（脚本 Lua 指南） | stormworks.fandom.com | `stormworks-fandom-kb` 零依赖爬虫 | `原始抓取_fandom/` |
| 日文 wikiwiki.jp（附加 Lua 官方帮助翻译） | wikiwiki.jp/sbarjp | `stormworks-wiki-to-book` 的 wikiwiki 爬虫 | `原始抓取_jp/` |
| 官方 Lua API 手册（汉化，游戏内 addon 编辑器说明文档的中文翻译） | 本地 `../StormworksLuaAPI.docxStormworks官方Lua API手册汉化.docx` | 直接解包 docx 抽取 | （已并入 `00_*`/`01_*`，未单列原始抓取） |
| 社区脚手架 `framework.lua`（PonyIDE 风格脚本 Lua 模板） | rising.at/Stormworks/lua/framework.lua | 网页读取 | （已并入 `00_*` §2/§5/§14/§16，未单列原始抓取） |

抓取时间：2026-08-31。Fandom 9 页 / 日文 16 页 / 官方手册 1 份，**全部 0 失败**。
官方手册与日文 wiki 高度重叠，但其独有内容（AI 驾驶、DLC/节日检查、载具部件读取家族补全、完整回调集、`getTimeMillisec`）已并入 `01_addon_Lua_API速查.md` 的「补充」节与 `00_*` 第 9 节。

## 本册文档索引

| 文件 | 用途 | 何时读 |
| --- | --- | --- |
| `00_速查_SW_Lua与常规Lua差异.md` | **最高频坑位清单**：Stormworks Lua 与标准 Lua 的差异点速查 | 写任何 SW Lua 前先扫一遍 |
| `01_addon_Lua_API速查.md` | 附加 Lua `server.*` 函数族分类速查（Game/Objects/Vehicles/UI/Addon/Matrices/Callbacks） | 调 `server.xxx` 时查签名与返回结构 |
| `原始抓取_fandom/` | Fandom 9 页原始 Markdown（脚本 Lua 指南、例子、陷阱） | 需要原文/例子时 |
| `原始抓取_jp/` | 日文 wiki 16 页原始 Markdown（附加 Lua 官方帮助翻译） | 需要某个 `server.*` 函数完整文档时 |
| **`../Lua示例/`**（平铺 10 篇） | **游戏内 Lua 指导书 + 例题集**：`00_AI写作指导` 为动手前必读，01~08 按功能分册 | **写/改载具与微控里的脚本 Lua 时的唯一入口** |
| `../_原始资料/BKN的Stormworks Lua手册/BKN46-bknsw-6300d21/docs/` | BKN 45 篇实战手册原始副本（含 Screen/雷达/状态机/Telementry） | 需要某个具体函数的完整原文时 |
| `../_原始资料/BKN工具集_Lua参考实现/` | BKN 最小可运行参考实现：脚本侧坐标变换/自动装弹/雷达告警/激光通信编码 + **附加 Lua 实用库 `addon-lib/`**（json/timers/ui/vehicle 等 9 模块）+ 完整 addon 范例 `time-attack-addon/` | 写附加 Lua 需要现成封装或完整范例时（入口为其 `README.md` 对照表） |

> **游戏内 Lua 的特殊设定（仅 ASCII 源码 / 8192 字符上限 / 多人变量不同步）已并入 `00_速查_SW_Lua与常规Lua差异.md` 第 13/14/15 节**，本索引不再单列。
> `../Lua示例/` 已于 2026-08-31 完成整合：原 `Lua例文集.md`（日文 wiki + BKN 融合）与 `WorkshopLua/`（创意工坊提取）全部并入，
> 并**修正了原稿中多处代码错误**（物理传感器欧拉角单位、旋转矩阵笔误、雷达解包变量未定义、状态机 `=` / `==` 等）。
> **不要绕过 `../Lua示例/` 直接抄 `_原始资料/` 里的旧版或原始副本。**

## 两套 Lua 一眼对照

| 维度 | 脚本 Lua（Lua 脚本方块） | 附加 Lua（Addon / 任务脚本） |
| --- | --- | --- |
| 运行位置 | 载具/建筑上的脚本方块 | 世界/任务 addon（每个存档一个 lua_data.xml） |
| 全局对象 | `input` `output` `screen` `property` `map` `async` `math` `table` `string` | `server` `matrix` `math` `table` `string`（**无** `screen`/`input`/`output`/`property`/`map`） |
| 主回调 | `onTick(game_ticks)` + `onDraw()` | `onCreate` `onTick` `onDestroy` `onChatMessage` `onVehicleSpawn` …（约 40 个） |
| 数据通道 | 复合信号 `input.getNumber/setNumber` `getBool/setBool`（32 数 + 32 布尔通道） | 直接调 `server.*` 读世界；持久化用 `g_savedata` 表 |
| 画图 | `screen.*`（接显示器/摄像头叠加） | `server.setPopup/setPopupScreen/addMapObject`（地图与弹窗 UI，**不能画像素屏**） |
| 坐标系 | 复合/物理传感器系（见方块知识册 17 册） | 世界系 **Y 轴 = 垂直/高度**，位置用 4×4 变换矩阵 |
| 网络 | `async.httpGet` + `httpReply`（见下「HTTP 限制」） | 同左，另可用 `server.command`/`server.announce` 脚本间通信 |
| 帮助/文档 | 游戏内脚本方块 Help 标签、PonyIDE | 游戏内 addon 编辑器 Help、本册 `01_*` |

## 时效性（rev / 最后修改）

| 来源页 | 版本/修订 | 备注 |
| --- | --- | --- |
| Fandom `Wiki/Guides/Lua/*`（9 页） | rev 2021–2023，`Stormworks_API` 页是空壳（已弃用） | 仅脚本 Lua 概念有效；API 细节以游戏内为准 |
| 日文 `アドオンLua/*`（16 页） | 原文基准 **v1.15.20（2026-08-15）** | 附加 Lua 当前最完整来源 |

## 重抓命令（断点续跑，增量安全）

```bash
PY="<PY>"
S="<WS>/技能库/stormworks-fandom-kb/scripts"
# Fandom（零依赖）：--title 可重复，只抓这些
"$PY" "$S/wiki_crawl.py" --output "<WS>/数据库/Lua/lua总体设定/原始抓取_fandom" \
  --title "Wiki/Guides/Lua" --title "Wiki/Guides/Lua/Exploring the Stormworks Lua API" \
  --title "Wiki/Guides/Lua/Special Advice for Lua" --title "Wiki/Guides/Lua/Stormworks API" \
  --title "Wiki/Guides/Lua/Learning Lua as a beginner" --title "Wiki/Guides/Lua/Learning Lua as a programer" \
  --title "Gameplay/Workbench/Lua Programming" --title "Gameplay/Mechanics/Lua" --title "Lua Scripting"

PYV="<PYX>"
W="<WS>/技能库/stormworks-wiki-to-book/scripts/wikiwiki_crawl.py"
# 日文（依赖 requests/bs4/lxml）：1.5s 间隔，遇 429 分批重跑
"$PYV" "$W" --wiki sbarjp --page "アドオンLua" --page "アドオンLua/AI" --page "アドオンLua/Addon" \
  --page "アドオンLua/Callbacks" --page "アドオンLua/Examples" --page "アドオンLua/Game" \
  --page "アドオンLua/General" --page "アドオンLua/Matrices" --page "アドオンLua/Misc" \
  --page "アドオンLua/Objects" --page "アドオンLua/UI" --page "アドオンLua/Vehicles" \
  --page "Luaスクリプト" --page "Luaスクリプト/Lua初心者講座" --page "Luaスクリプト/初心者向けLua回路講座" \
  --page "Lua例文集" --output "<WS>/数据库/Lua/lua总体设定/原始抓取_jp"
```

## 原文错漏 / 已知坑位清单

- ⚠ Fandom `Stormworks API` 页是**空壳**（仅标题，rev 2748，分类标 `deprecated_source_tags`），API 细节已迁移到游戏内 Help 与日文 wiki，不要照抄。
- ⚠ Fandom `Lua Scripting`、`Wiki/Guides/Lua` 等是 **stub**，无实质内容。
- ⚠ 日文 wiki 原文**多次强调 v1.15.20 基准**，附加 Lua 更新频繁，函数签名以官方更新为准。
- ⚠ `math.atan2` 在 Stormworks **不存在**（见 `00_*` 差异手册）；`table.maxn` 未实现。
- ⚠ 多返回值函数（如 `server.getPlayerPos`）要加括号只取第一个：`(server.getPlayerPos(id))`（见 `01_*` Examples 原页）。
- ⚠ 官方汉化手册证实：`onCustomCommand` 的 `args ...` **必须显式展开**为 `arg1..arg4`（或 `one..five`），不能原样用 `...`（见 `00_*` 第 9 节、`01_*` 补充节示例）。
- ⚠ 官方汉化手册补出的完整回调集（含 `onCharacterSit/Unsit`、`onVehicleDamaged` 带 voxel 坐标、`onForestFire*`、`onToggleMap` 等）已并入 `00_*` 第 9 节，调回调前先扫该节。
- ⚠ 确定性随机：官方推荐 `server.getTimeMillisec()` 作种子（见 `00_*` 第 1 节、`01_*` 补充节），**不要**依赖双端一致的 `math.random()`。
- 官方手册的 `标准Lua函数`/`矩阵数学概念` 属 AI 已知通识，本册未重复收录，只保留 Stormworks 沙盒差异与专属 API。
- ⚠ 社区脚手架 `framework.lua`（rising.at）补出了脚本 Lua 的 `property`/`map` 全局对象、`screen` 绘图 API 清单、触控屏走复合通道 1–6 的约定、以及 `onDraw` 的 nil 守卫写法，已并入 `00_*` §16（及 §2/§5/§14）。其自带的通用数学/绘图辅助（`clamp`/`lerp`/`round`/`rot`/`grad`/`ssquash`/`inRect`/`drawArc`/`drawPointer`/`drawRing` 等）属 **AI 已知通识**，**未搬入本册**——需要时可自行实现或参考原脚手架。

## 延伸阅读（本工作区其他册）

- 雷达/声纳/物理传感器坐标系与 Lua 解算 → `<WS>\数据库\方块数据\17_传感器与雷达.md`
- 弹道计算机（含可直接贴的 `ballistics.lua`）→ `<WS>\数据库\方块数据\16_武器与弹药.md` + `弹道计算参考/`
