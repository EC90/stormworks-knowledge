# CODEBUDDY.md — STORMWORKS 工作区（WorkBuddy 专属层）

> **平台无关的权威契约在 [`AGENTS.md`](AGENTS.md)**，规则改动一律改那里。
> 本文件是 **WorkBuddy 会话的精简副本 + 生态专属补充**。
> 之所以保留副本：WorkBuddy 只自动注入 `CODEBUDDY.md`，不注入 `AGENTS.md`。
> 保证两份一致的办法——**本文件只做摘要与转发，细节一律指向 `AGENTS.md` / `工作区导航\`。**

---

## 📌 路径占位符（先解析，再动手）

**全工作区文档一律用占位符写路径**：`C:\Users\EC90`、`E:\SteamLibrary` 只是**本机值**，
**用户名与盘符因机器而异**。含义与排查见 `AGENTS.md` §0、完整约定见 `工作区导航\07_路径占位符约定.md`。

```bash
python "<WS>/工作区导航/脚本/sw_paths.py"           # 打印真实值 + OK/MISS；--json / --write
```

报 `MISS` 时：按建议人工定位 → `--set <KEY>=<路径> --write` 回写 → 更新 `04_环境与外部依赖.md` §7。

## 🔴 只读红线（先于一切）

| 路径 | 内容 |
| --- | --- |
| `<SW_GAME>\` = `<STEAM_LIB>\steamapps\common\Stormworks\` | 游戏根目录（定义文件、常量、meshes） |
| `<SW_WORKSHOP>\` = `<STEAM_LIB>\steamapps\workshop\content\573090\` | 创意工坊订阅物 |

**严禁**写入/修改/删除/移动/重命名，也禁止在其下建临时文件。一切产出只写进 `<WS>`（`D:\STORMWORKS`）。
⚠ `<SW_SAVE>\data\vehicles\*.xml` 属用户数据（`%APPDATA%\Stormworks`），改前先备份到 `<WS>\_work\`。

## 📖 术语必须查表

涉及 Stormworks 游戏内容的中英互译，**先查 `<WS>\汉化相关\` 对照表，禁止凭语感意译**。

```bash
PY="<PY>"                        # 由 sw_paths.py 给出
G="<WS>/汉化相关/脚本"

"$PY" "$G/sw_check.py" --auto                      # ① 新鲜度（毫秒级，过期自动重建；0最新/2待更新/3失败）
"$PY" "$G/sw_lookup.py" "modular engine cylinder"  # ② 单条查询
"$PY" "$G/sw_batch.py" --terms "Motor Small, Wheel 3x3 Suspension"   # 批量：HIT/FUZZY/MISS
"$PY" "$G/sw_find.py" Motor Rocket --parts-only                      # 同义词兜底
```

命中率低多半是 **wiki 名 ≠ 游戏内名**（词序相反 / 括号位置不同），走 `sw_batch → sw_find → 标※自译` 三级流程。
完整规则：`<WS>\术语对照指南.md`。

## 🎮 数据权威性

游戏定义文件 🎮 > 游戏内文本 ✅ > 日文 wikiwiki.jp > Fandom/社区 wiki ⚠。

```bash
S="<WS>/数据库/方块数据/脚本"
"$PY" "$S/sw_defs.py" get "部件游戏内英文名"   # mass / $ / 尺寸 / 逻辑节点（mode=0输出, 1输入）
"$PY" "$S/sw_vehicle.py" stats "<载具.xml>"    # 载具部件中文统计（末尾附 JSON 摘要）
```

## 先查知识库

| 册 | 位置 |
| --- | --- |
| 基本设定（14 篇） | `数据库\stormworks基本设定\` |
| 部件册（20 册 + 速查总表） | `数据库\方块数据\` |
| PID 册 | `数据库\PID控制与调试.md` |
| Lua（10 篇示例 + 总体设定） | `数据库\Lua\` |

写代码前：弹道 → `16_武器与弹药.md` + `弹道计算参考\`；雷达/声纳/物理传感器 → `17_传感器与雷达.md`；
雷达噪声与座圈 → `雷达与摄像头稳定_阶段总结.md`；模块化引擎 → `模块化引擎实测_阶段总结.md`。

## 硬约束（写代码前）

- **MC Lua**：禁用双引号与半角 `<`（用 `>` 方向比较或 `math.min/max`，注释里也不行）；上限约 4096 字符；`math.atan` 单参数。
- **批量上传**：`async.httpGet` 的 URL **< ~4000 字符**（超 4096 游戏崩溃）。
- **物理传感器欧拉角（ch4-6）单位是弧度**，不是圈，直接喂 `sin/cos`，**勿 ×2π**；雷达角度仍是圈。
- **载具 XML**：改前备份；Edit 后必须 grep 复核；不是合法 XML，用 `sw_vehicle.py`/Python 解析；禁止 Read 全文。

## 收工写记忆

追加 `<WS>\.workbuddy\memory\YYYY-MM-DD.md`（只追加）；长期结论蒸馏进
`<WS>\工作区导航\05_项目长期知识.md`，在 `.workbuddy\memory\MEMORY.md` 留摘要与指针（≤3000 字符）。
⚠ 记忆目录**不入库**。

## GitHub 共建（公开仓库）

仓库 `EC90/stormworks-knowledge`（公开，CC BY-NC-SA 4.0）。**提交纪律见 `AGENTS.md` §9**：
`.gitignore` 排除集不可绕过（`_tools\`、`pony IDE\`、`.workbuddy\`、`路径配置.json` 等不 push）；
文档只写路径占位符。gh CLI 便携版在 `<WS>\_tools\gh-cli\`（不入库）。

---

# WorkBuddy 生态专属

## 技能加载路径

WorkBuddy 从两处加载技能，本工作区**两者都指向同一份实体**，不会有副本漂移：

| 加载路径 | 实体 |
| --- | --- |
| `<WS>\.workbuddy\skills\` | → 目录联结（junction）指到 `<WS>\技能库\` |
| `<HOME>\.workbuddy\skills\sw-modular-engine-bench\` | → 目录联结指到 `<WS>\技能库\sw-modular-engine-bench\` |

**技能实体统一在 `<WS>\技能库\`（可见目录）**：`sw-vehicle-xml`、`sw-modular-engine-bench`、
`stormworks-fandom-kb`、`stormworks-update-check`、`stormworks-wiki-to-book`、`sw-mesh-tools`、
`sw-property-options`（共 7 个）。
新增/修改技能一律在 `技能库\` 里做。⚠ 删除联结时用 `rmdir`，**不要** `rm -rf`（会删掉 `技能库\` 里的真身）。

## 记忆分层

| 层 | 位置 | 说明 |
| --- | --- | --- |
| 云端画像 | 会话开头 `<memory>` 注入 | 只读，勿本地改 |
| 历史会话 | `conversation_search` 工具 | 跨项目找特定往事时用 |
| 用户级 | `<HOME>\.workbuddy\MEMORY.md`（**含用户名**） | 已镜像到 `.workbuddy\memory\外部_用户级记忆_镜像.md` |
| 项目长期 | `工作区导航\05_项目长期知识.md`（完整） + `.workbuddy\memory\MEMORY.md`（摘要） | 无长度限制版在导航目录 |
| 每日日志 | `.workbuddy\memory\YYYY-MM-DD.md` | 只追加 |

## 自动化

- **不要**用 WorkBuddy 自动化替代术语表同步——已由 Windows 定时任务 **`StormworksGlossarySync`**
  （每天 10:00，S4U 注册）承担，**不依赖任何 AI 平台**。
- 管理用 PowerShell `Get- / Start- / Disable- / Unregister-ScheduledTask`（`schtasks.exe` 被安全策略拦截）。
- ⚠ PowerShell 工具在部分环境不回显 stdout，需要看输出时先 `Set-Content` 写文件再读。

## 环境

```bash
PY="<PY>"    # <HOME>/.workbuddy/binaries/python/versions/<版本>/python.exe         纯标准库
PYX="<PYX>"  # <HOME>/.workbuddy-ai/binaries/python/envs/default/Scripts/python.exe  requests/bs4/lxml/PIL
PYN="<HOME>/.workbuddy/binaries/python/envs/ocr-light/Scripts/python.exe"           numpy/PIL
```

真实值由 `sw_paths.py` 探测（`<PY>` / `<PYX>` 两项）。基础解释器**无任何第三方包**；
**没有托管 Python 时系统 Python 3.8+ 也可跑大多数脚本**。
详细环境说明见 `工作区导航\04_环境与外部依赖.md`（其 §7 记录本机真实值）。

**回复语言：简体中文。**
