---
name: stormworks-update-check
description: 检查 Stormworks 游戏是否有新更新，并按更新内容只读核对游戏根目录、更新 <WS>\数据库。判定逻辑全部内置脚本，AI 只需跑一个命令读一行结论。触发场景：用户要求检查 Stormworks 是否更新、数据库需随游戏版本刷新、或例行维护检查游戏更新状态。
agent_created: true
---

# Stormworks 游戏更新检查

> 📌 **路径占位符（因机器而异，先解析再用）**：
> `<WS>` = 工作区根（`D:\STORMWORKS`）、`<HOME>` = 用户主目录（**含用户名**）、
> `<SW_SAVE>` = Stormworks 存档目录、`<PY>` / `<PYX>` = Python 解释器（纯标准库 / 带三方包）、
> `<SW_GAME>` / `<SW_WORKSHOP>` / `<STEAM_LIB>` = 游戏根目录 / 创意工坊 / Steam 库（**盘符与目录名都不固定**）。
> 解析：`python "<WS>/工作区导航/脚本/sw_paths.py"`（`--json` / `--write`）。
> 报 `MISS` 时按其排查建议定位后回写 `工作区导航\路径配置.json` 与
> `04_环境与外部依赖.md` §7。约定见 `工作区导航\07_路径占位符约定.md`。


用**最少注意力**判断 Stormworks 是否更新，并在有更新时引导核对游戏文件、更新数据库。

## 核心：只跑一个命令

```bash
PY="<PY>"
S="<WS>/技能库/stormworks-update-check/scripts"

"$PY" "$S/sw_update_check.py"
```

读**最后一行结论**（四选一），照做即可，**不需要读任何新闻正文、不需要自己算日期**：

| 结论 | 含义 | AI 该做什么 |
|---|---|---|
| `FRESH` | 距上次检查未满 7 天 | **什么都不做**，直接回复用户「游戏 7 天内已检查过，无需重复」。 |
| `NONE` | 已检查，无新更新 | 回复用户「已检查，无新更新」。结束。 |
| `BASELINE` | 首次运行，刚建立基线 | 回复用户「已建立更新检查基线，最新版本是 …」。结束。 |
| `UPDATED` | 发现新更新 | **进入步骤 2**（下面）。 |

> 例外：用户**主动**说「检查游戏是否更新」时，加 `--force` 忽略 7 天窗口强制对比：
> `"$PY" "$S/sw_update_check.py" --force`

## 步骤 2：有更新时，只读核对游戏根目录并更新数据库

只有脚本输出 `UPDATED` 时才走这步。脚本会列出新增条目的**版本号 + 日期 + 标题**。

1. **先看更新标题说了什么**（脚本已列出），判断改动范围，例如：
   - 提到某个部件名（如 `train_wheels_dynamic_x1_xsmall`）→ 该部件的定义文件可能变了
   - 提到某机制（如 `airburst` 空爆、`hydrogen fuel cell` 氢燃料电池）→ 对应册子可能过时
   - 纯 bug 修复（`Fix - …`）→ 通常不影响部件参数，可不动数据库
2. **只读核对游戏文件**（**绝不写 E: 盘**）：
   ```bash
   # 看 definitions 最近改了哪些文件（时间戳）
   ls -lat "<SW_DEFS>/" | head -20
   # 看某个具体部件的定义（用 sw_defs.py 权威工具）
   "<PY>" \
     "<WS>/数据库/方块数据/脚本/sw_defs.py" get "部件英文名"
   ```
   其它可能受影响的目录：`sdk/data/game_constants.xml`（物理常量）、`rom/data/preset_vehicles_advanced/`、`rom/data/tiles/`。
3. **更新 `<WS>\数据库`**（产出只写 D: 盘）：
   - 部件参数变了 → 先重跑权威解析，再改对应册子：
     ```bash
     # 重新解析游戏定义（只读 E:，写 D:，需 lxml 环境）
     "<PYX>" \
       "<WS>/数据库/方块数据/脚本/sw_defs.py" refresh
     ```
   - 涉及部件参数库 → 重跑 `extract_params.py`；涉及规格附录 → 重跑 `build_spec_appendix.py`。
   - 中文名仍以 `汉化相关/` 对照表为准（`sw_check.py --auto` + `sw_lookup.py`）。
4. 更新后，在 `<WS>\.workbuddy\memory\YYYY-MM-DD.md` 记一笔（版本号、改了哪些册子）。

## 状态文件

`stormworks_update_state.json`（本 skill 目录下）记录 `last_seen`（上次看到的新闻时间戳）
与 `last_title`。脚本自动读写，**不要手改**。首次运行会自建基线。

## 关键事实（已勘察，勿重探）

- Steam 新闻页 `store.steampowered.com/news/app/573090` 是 JS 动态加载，WebFetch 抓不到正文；
  **改用官方 API**：`https://api.steampowered.com/ISteamNews/GetNewsForApp/v2/?appid=573090&count=10&format=json`，
  无需登录、无需 key，返回 `appnews.newsitems[].date`（Unix 秒）+ `title`。
- 游戏主程序与 definitions 的时间戳即「游戏实际更新时间」的权威依据：
  `stormworks.exe` / `rom/data/definitions/*.xml` 的 mtime。上次更新 **V1.15.20 HOTFIX（2026-08-15）**。
- 基线示例（2026-08-15 新闻时间戳 `1786789235`）：V1.15.20 HOTFIX / v1.15.19 Small Train Wheels /
  v1.15.18 Airburst / v1.15.16 Hydrogen Fuel Cell and Space Mining。
- 只读红线：<STEAM_LIB> 下任何文件**只有读权限**；一切产出只写 <WS>\。
