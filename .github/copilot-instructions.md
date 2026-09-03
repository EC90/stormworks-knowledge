# Copilot Instructions — STORMWORKS 工作区

本工作区的 AI 规则**唯一权威来源是 [`../AGENTS.md`](../AGENTS.md)**。请完整阅读并遵守它。
本文件只是转发层，不含独立规则。

> 📌 **路径占位符**：`<WS>`（工作区根，`D:\STORMWORKS`）、`<HOME>`（用户主目录，**含用户名**）、
> `<STEAM_LIB>`/`<SW_GAME>`/`<SW_WORKSHOP>`（Steam 库 / 游戏根 / 创意工坊，**盘符不固定**）、
> `<PY>`（Python 解释器）**都是因机器而异的地址**，用
> `python "<WS>/工作区导航/脚本/sw_paths.py"` 解析。缺失时按其排查建议定位后回写，见 `AGENTS.md` §0。

## 最关键的 4 条

1. 🚫 `<SW_GAME>`（= `<STEAM_LIB>\steamapps\common\Stormworks\`）与
   `<SW_WORKSHOP>`（= `<STEAM_LIB>\steamapps\workshop\content\573090\`）**只读**，
   严禁写入/修改/删除，也不要在其下建临时文件。产出只写 `<WS>`（`D:\STORMWORKS`）。
2. 📖 Stormworks 中英互译**必须查** `<WS>\汉化相关\` 对照表，禁止凭语感意译。
   每次会话先跑：
   ```bash
   python "<WS>/工作区导航/脚本/sw_paths.py"     # 先解析 <WS>/<PY>/<SW_GAME>… 占位符
   "<PY>" "<WS>/汉化相关/脚本/sw_check.py" --auto
   ```
3. 🎮 要精确数值先查 `数据库\方块数据\脚本\sw_defs.py`（游戏定义文件为唯一权威），查不到才实测。
4. 微控制器 Lua 里**不得出现半角 `<` 和双引号**（会破坏 XML）；批量上传 URL 长度 **< 4000 字符**。

## 下一步

读 [`../工作区导航/01_接手清单.md`](../工作区导航/01_接手清单.md) 按任务类型定位知识源。
