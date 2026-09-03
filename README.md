# STORMWORKS 工作区

> 个人向的 **Stormworks: Build and Rescue** 中文资料整理工作区：
> 汉化术语基准 + 部件数据 + 机制原理 + Lua 手册 + 本机实测归档。
>
> **本工作区设计为平台无关**——不依赖 WorkBuddy、Cursor、Claude Code 或任何特定 AI 工具。
> 所有能力都是「本地文件 + 标准库 Python 脚本」，任何平台打开本目录后都能接手。
>
> 📌 **路径占位符**：本文档及全工作区文档里的 `<WS>`（工作区根）、`<HOME>`（用户主目录，**含用户名**）、
> `<PY>`/`<PYX>`（Python 解释器）、`<SW_GAME>`/`<SW_WORKSHOP>`/`<SW_SAVE>`（游戏根目录 / 创意工坊 / 存档，
> **盘符与目录名都不固定**）都是**因机器而异**的地址。用 `工作区导航\脚本\sw_paths.py` 解析，
> 约定与排查见 [`工作区导航/07_路径占位符约定.md`](工作区导航/07_路径占位符约定.md)。
>
> 📦 **本仓库已公开于 GitHub：`EC90/stormworks-knowledge`**（许可 CC BY-NC-SA 4.0，见 [LICENSE](LICENSE)）。
> 共建流程见 [CONTRIBUTING.md](CONTRIBUTING.md)；`_tools/`、`pony IDE/`、`.workbuddy/`、`_work/` 等
> 本机/第三方/个人内容**不随仓库分发**（排除清单见 [.gitignore](.gitignore)）。

---

## 新会话从这里开始（3 步）

1. **AI 助手**：读 [`AGENTS.md`](AGENTS.md)（平台无关的 AI 契约：术语纪律、红线、检索顺序、命令速查）。
2. **先解析路径占位符，再跑术语表新鲜度检查**（毫秒级，过期自动重建）：

   ```bash
   # 把 <WS>/<PY>/<SW_GAME>… 换成这台机器的真实路径（纯标准库，任意 python 3.8+ 可跑）
   python "<WS>/工作区导航/脚本/sw_paths.py"           # 打印真实值；--write 可刷新 路径配置.json
   PY="<PY>"                                          # 上一步给出的解释器；没有托管 Python 就用系统 python
   "$PY" "<WS>/汉化相关/脚本/sw_check.py" --auto
   ```

3. **按任务类型查知识库**——完整对照表见 [`工作区导航/01_接手清单.md`](工作区导航/01_接手清单.md)。

---

## 三条红线（违反会造成不可恢复的损失）

1. 🚫 **Steam 目录只读**
   `<SW_GAME>` = `<STEAM_LIB>\steamapps\common\Stormworks`（游戏根目录）与
   `<SW_WORKSHOP>` = `<STEAM_LIB>\steamapps\workshop\content\573090`（创意工坊订阅物）
   **严禁**写入/修改/删除/移动，也禁止在其下建临时文件。
   **`<STEAM_LIB>` 的盘符与目录名不固定**（本机是 `E:\SteamLibrary`），一切产出只写进 `<WS>`（`D:\STORMWORKS`）。
2. 📖 **Stormworks 术语必须查表**
   涉及游戏内容的中英互译，先查 `汉化相关\` 的对照表（8795 条）并采用既有译法，
   **禁止凭语感意译**。完整规则见 [`术语对照指南.md`](术语对照指南.md)。
3. 🎮 **数据权威性排序**
   游戏定义文件 > 游戏内文本 > 日文 wikiwiki.jp > Fandom/社区 wiki。
   要精确数值先查 `数据库\方块数据\脚本\sw_defs.py`，查不到才考虑实测。

---

## 目录速览

| 目录 | 内容 |
| --- | --- |
| **`工作区导航\`** | 🧭 **先看这里**：接手清单 / 目录地图 / 脚本清单 / 环境依赖 / 长期知识 / 记忆索引 |
| **`技能库\`** | 本工作区全部 Stormworks 技能（5 个，2026-09-02 统一迁入） |
| `汉化相关\` | 中英对照表（术语基准）+ 生成/查询脚本。⚠ 词典与数据为生成物，勿手改 |
| `数据库\` | 知识册（部件 / 机制 / Lua / PID）+ BKN 工具 + 本地 wiki 库 + 示波器数据 |
| `数据库\方块数据\` | 部件知识册 20 册 + 速查总表 + 传感器与雷达 + 两份实测阶段总结 |
| `数据库\stormworks基本设定\` | 机制知识册 14 篇（浮力、流体、电力、绳索、Lua 等） |
| `数据库\Lua\` | Lua 示例 10 篇 + 总体设定 + 模块化引擎控制参考手册 |
| `_work\` | 临时工作区（载具 XML 备份、雷达测试分析） |
| `_tools\` | steamcmd 副本（用于下载工坊物品） |
| `AI相关\` | 早期创意工坊 Lua 提取流水线与旧版爬虫（保留追溯） |
| `pony IDE\` | 第三方编辑器源码副本（只读参考） |

完整逐层说明见 [`工作区导航/02_目录地图.md`](工作区导航/02_目录地图.md)。

> ⚠ 上表中 `_tools\`、`pony IDE\`、`.workbuddy\`（含记忆日志）、`_work\` 属本机/第三方/临时内容，
> **不随 Git 仓库分发**（排除清单见 [.gitignore](.gitignore)）。

---

## AI 平台入口对照

| 平台 | 读取的文件 | 说明 |
| --- | --- | --- |
| 任意平台 | `AGENTS.md` | **权威契约**，内容平台无关 |
| WorkBuddy / CodeBuddy | `CODEBUDDY.md` | 薄层，仅 WorkBuddy 生态专属补充 |
| Claude Code | `CLAUDE.md` | 薄转发 → `AGENTS.md` |
| GitHub Copilot | `.github\copilot-instructions.md` | 薄转发 → `AGENTS.md` |
| Cursor | `.cursor\rules\stormworks.mdc` | 薄转发 → `AGENTS.md` |

**转发文件不含独立规则**，改动请一律改 `AGENTS.md`，避免多份规则漂移。

---

## 常用命令

```bash
PY="<PY>"                                  # 纯标准库解释器，由 sw_paths.py 给出
S="<WS>/数据库/方块数据/脚本"
K="<WS>/技能库"

# 术语
"$PY" "$WS/汉化相关/脚本/sw_lookup.py" "modular engine cylinder"

# 🎮 部件权威规格（mass / $ / 尺寸 / 逻辑节点）
"$PY" "$S/sw_defs.py" get "Modular Engine Crankshaft 1x1"

# 载具 XML 部件统计（中文名 × 数量）
"$PY" "$S/sw_vehicle.py" stats "<SW_SAVE>/data/vehicles/eng_test.xml"

# 本地 Fandom 库检索（737 页，先查后抓）
"$PY" "$K/stormworks-fandom-kb/scripts/wiki_query.py" search "modular engine cylinder"

# 游戏更新检查（读末行结论 FRESH / NONE / BASELINE / UPDATED）
"$PY" "$K/stormworks-update-check/scripts/sw_update_check.py"
```

全部 40+ 脚本的用途与参数见 [`工作区导航/03_脚本与工具清单.md`](工作区导航/03_脚本与工具清单.md)。

---

## 维护约定

- 回复语言：**简体中文**。
- 术语表由 Windows 定时任务 `StormworksGlossarySync`（每天 10:00）自动同步，
  **不依赖任何 AI 平台**；管理用 PowerShell `*-ScheduledTask` cmdlet（`schtasks.exe` 被安全策略拦截）。
- 工作记忆按日追加到 `.workbuddy\memory\YYYY-MM-DD.md`，长期结论蒸馏进
  `工作区导航\05_项目长期知识.md`。
- 环境与外部依赖（Python 运行时、Steam 只读路径、目录联结说明）见
  [`工作区导航/04_环境与外部依赖.md`](工作区导航/04_环境与外部依赖.md)——**该文 §7 是全工作区唯一记录本机真实路径的地方**。
