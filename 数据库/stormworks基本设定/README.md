# Stormworks 基本设定（Gameplay / Mechanics）

> 📌 **路径占位符**：`<WS>`（工作区根）、`<HOME>`（用户主目录，**含用户名**）、`<PY>`/`<PYX>`（Python 解释器）、
> `<SW_GAME>`/`<SW_WORKSHOP>`（游戏根目录 / 创意工坊，**盘符不固定**）**都因机器而异**，
> 用 `python "<WS>\工作区导航\脚本\sw_paths.py"` 解析。见 `<WS>\工作区导航\07_路径占位符约定.md`。

本册是 Fandom Stormworks Wiki 中 [`Gameplay/Mechanics`](https://stormworks.fandom.com/wiki/Gameplay/Mechanics)
及其全部子页面的**中文整理版**，供建造与查资料时快速参考。

- 数据来源：Fandom Stormworks Wiki，内容许可 **CC BY-NC-SA**
- 抓取时间：2026-08-30
- 抓取范围：`Gameplay/Mechanics` 前缀全部页面，共 19 条记录（15 篇正文 + 4 个重定向）
- 抓取工具：`<WS>\技能库\stormworks-fandom-kb\scripts\wiki_crawl.py`（零依赖版）
  （`--prefix "Gameplay/Mechanics"`；原 `AI相关\stormworks_fandom_kb\` 依赖版已于 2026-09-08 移除）

## 目录

| 文件 | 对应英文页 | 内容 |
| --- | --- | --- |
| [01_物理基础.md](01_物理基础.md) | Basic Physics / Basic Physics Concept | 重力常数、力的单位、流体物理、物理引擎 |
| [02_浮力.md](02_浮力.md) | Buoyancy | 密度与浮沉、封闭空间、常见漏水点 |
| [03_重心.md](03_重心.md) | Center of Mass | 重心与浮心/推力中心/升力中心的关系 |
| [04_流体.md](04_流体.md) | Fluids | 管道、液箱、压力与气体、呼吸、抽运 |
| [05_燃料.md](05_燃料.md) | Fuel | 柴油 / 航空燃油 / 煤炭 |
| [06_电力.md](06_电力.md) | Electricity | SV / Swatts / SWs、电池、发电、耗电、断电 |
| [07_机械动力.md](07_机械动力.md) | Mechanical Power | 机械动力的产生与消耗 |
| [08_升力与机翼.md](08_升力与机翼.md) | Lift | 机翼升力、已知缺陷 |
| [09_配平.md](09_配平.md) | Trim | 俯仰/偏航配平的设置方法 |
| [10_车轮.md](10_车轮.md) | Wheels | 新旧两代车轮的差异 |
| [11_逻辑与信号.md](11_逻辑与信号.md) | Logic | 六类逻辑节点与连接规则 |
| [12_Lua.md](12_Lua.md) | Lua | 脚本组件简介 |
| [13_绳索.md](13_绳索.md) | Rope | 拖带、吊装、装饰、人员吊运 |
| [14_游戏物理常量.md](14_游戏物理常量.md) | `sdk/data/game_constants.xml` 🎮 | 全部 38 个物理常量（重力/阻尼/阻力/升力/浮力）权威值 |
| [术语对照_本册.md](术语对照_本册.md) | — | 本册专有名词中英对照 |

## 时效性说明（重要）

Wiki 由英文社区志愿维护，**内容可能过时**。各页面的最后修订时间与适用版本如下：

| 页面 | 适用版本 / 最后修订 |
| --- | --- |
| Fluids | v1.15.1（2025-11-06 修订） |
| Electricity | V1.15.2（2025-08-16 修订） |
| Mechanical Power | 2026-04-28 修订 |
| Rope | 2025-08-21 修订 |
| Fuel | 2025-08-07 修订 |
| Buoyancy、Trim | V1.4.14（2022-03-29），**已明显过时** |
| Basic Physics、Center of Mass、Lift、Logic、Lua、Wheels | 2025-05-14 Wiki 迁移时的快照 |

其中 `Buoyancy` 与 `Trim` 标注的版本距今较久，涉及数值的部分请以游戏内实测为准。

原文有若干**空章节**（如 Basic Physics 下的 Aerodynamic、RPS、Gas），整理时如实标注为「原文空缺」，未做补充。

## 权威数据源（🎮）

本册的**精确数值以游戏定义文件为准，优先级高于 wiki**：

- **物理常量**：`<SW_GAME>\sdk\data\game_constants.xml`
  —— 已整理进 [14_游戏物理常量.md](14_游戏物理常量.md)（38 个常量，🎮 级真值）。
- 涉及浮力、阻力、升力、阻尼等**量化计算**时，优先查 14 册，不要引用 wiki 里可能过时的数值。

## 术语规则

本册中英对照以 `<WS>\汉化相关\` 的术语基准表为准（本次核对时该表为最新，
8795 条）。凡表中已收录的译法一律原样采用；表中未收录的词按同族用词习惯自译，
并在 [术语对照_本册.md](术语对照_本册.md) 中用「※」标出。

## 原始抓取数据

`原始抓取/` 保存爬虫的原始输出，供程序读取与增量更新：

```text
原始抓取/
├─ manifest.json       数据集摘要
├─ pages.jsonl         页面级记录（含分类、章节、表格、链接元数据）
├─ chunks.jsonl        RAG / 向量库摄取用分块
├─ records/            每页完整 JSON
├─ markdown/           每页 Markdown（英文原文）
├─ page_chunks/        每页独立分块
├─ state.json          断点状态，重跑可增量更新
└─ crawl.log           运行日志
```

需要刷新时：

```bash
"<PY>" \
  "<WS>/技能库/stormworks-fandom-kb/scripts/wiki_crawl.py" \
  --prefix "Gameplay/Mechanics" \
  --output "<WS>/数据库/stormworks基本设定/原始抓取"
```

默认只抓取新增或修订号变化的页面；加 `--force` 可无条件重抓。
