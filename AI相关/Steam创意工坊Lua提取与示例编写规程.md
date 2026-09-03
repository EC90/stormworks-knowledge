# Steam 创意工坊 Lua 提取与示例编写规程

> **AI 阅读规则（先读这段，先于一切操作）**
> 本文件是一份**可复用的执行规程**：用户在与你对话时 @ 本文件并说「执行 / 按规程跑 / 提取创意工坊 Lua」，你就严格按以下步骤操作。
> 本规程的两条最高优先级约束，不可违反：
> 1. 🔴 **只读红线**：`<SW_WORKSHOP>` 下的所有文件**你只能读，绝对禁止写入、修改、删除、移动**。那是用户的 Steam 创意工坊订阅物，任何破坏都不可挽回。所有产出只写到 `<WS>\` 下。
> 2. 🟠 **省注意力原则**：你只学习/总结**游戏内 Lua 在 Stormworks 特殊环境下独有的实现手法**，省略任何通用 Lua 语法（循环、表操作、字符串基础等 LLM 已知内容）。产出物要带导航索引，让未来的你/其他 AI 能快速定位范例。

---

## 0. 一句话定位

把 Steam 创意工坊**载具 / 微控**中的游戏内 Lua 脚本，提取、理解、分类，写成**带索引、省注意力**的示例集，
**并入 `<WS>\数据库\Lua\Lua示例\`**（平铺的指导书 + 例题集，无子文件夹），供以后写游戏内 Lua 时查范例。

**三条工作流原则（2026-08-31 起）**
1. 🔍 **先查重再动手**：用户给工坊链接时，先 `ws_reference.py` 查「已订阅 / 已暂存 / 已学习」，三者皆有就直接读，不要重复下载或精读。
2. ⬇️ **下载只是手段**：只有三者皆无才 `ws_download.py` 免订阅下载；不需要订阅、不影响用户账号。
3. 🧹 **用完即清理**：Lua 提取完、手法写进指导书后，下载原件即冗余，按 `步骤 0c` 清理（保留 SteamCMD 本体）。

> ⚠ **2026-08-31 起产出位置已变更**：原 `Lua示例\WorkshopLua\` 子目录已取消，内容并入平铺的 `01`~`08` 分类文件。
> 新增例题时**直接追加到对应分类文件**，并同步更新 `Lua示例\README.md` 的索引表与反查表——**以及重建已学习索引**（`ws_reference.py --rebuild`）。

---

## 1. 事实基线（你不必重新摸索，直接采用）

| 事实 | 值 / 说明 |
| --- | --- |
| 创意工坊根目录 | `<SW_WORKSHOP>` = `<STEAM_LIB>\steamapps\workshop\content\573090`（**盘符不固定**，本机为 `E:\SteamLibrary`；Git Bash 下形如 `/e/SteamLibrary/steamapps/workshop/content/573090`）。用 `工作区导航\脚本\sw_paths.py` 解析 |
| 物品 = 子文件夹 | 每个子文件夹名是一个**纯数字 id**，正好等于 steam 网页 `?id=` 后的数字 |
| 物品描述页 URL | `https://steamcommunity.com/sharedfiles/filedetails/?id=<子文件夹名>` |
| 含 Lua 的物品类型 | `vehicle.xml`（载具）、`microcontroller.xml`（独立微控）。**只处理这两种** |
| 需忽略的文件 | `language.xml` / `language.tsv`（汉化补丁）、`*.png` / `*.vts` / `*.prefab`、地图瓦片、纯资源包等——这些**不含载具/微控 Lua**，直接跳过 |
| Lua 在 .xml 中的存法 | 以**属性**形式存在于 `<object ... script='...'>`（`<components>` 内的 Lua 脚本块，典型容器 `<c type="56">`） |
| Lua 文本是 XML 转义的 | `&lt;`→`<`、`&gt;`→`>`、`&amp;`→`&`、`&quot;`→`"`、`&apos;`→`'`。**提取后必须反转义**才能还原真代码 |
| 单文件可能多段 Lua | 一个 .xml 里可有多个 `<object script='...'>`（多个脚本块），每个都是独立脚本，全部提取 |
| 这些 Lua 都是「脚本 Lua」 | 创意工坊载具/微控 = 游戏内 Lua 脚本方块，**不是**附加 Lua。故示例只用 `onTick/onDraw + input/output/screen/property/map/async`，**不要出现 `server.*`** |

> 现状规模参考（写规程时实测）：约 219 个物品，其中 181 含 `vehicle.xml`、25 含 `microcontroller.xml`。

---

## 2. 执行四步

### 步骤 1 — 只读遍历创意工坊（仅列举，绝不改）

- 用只读方式列出 `E:\...\content\573090` 下所有子文件夹名（即 id 清单）。
- 对每个 id，判断其是否含 `vehicle.xml` 或 `microcontroller.xml`；不含的直接忽略（见基线「需忽略的文件」）。
- ✅ 允许：列目录、读文件、grep。❌ 禁止：在该路径下创建/写入/删除任何文件。

### 步骤 0 — 🔍 先查重（**用户给工坊链接时的第一步，必做**）

> **原则：下载是手段不是目的。用户给你一个工坊链接时，先查它是不是已经有了、是不是已经学过了。**
> 只有「三者皆无」时才执行下载。

```bash
PY="<PY>"
R="<WS>/AI相关/_scripts/ws_reference.py"

"$PY" "$R" "https://steamcommunity.com/sharedfiles/filedetails/?id=3750251471"   # 查询（url 或纯 id 均可）
"$PY" "$R" --list-learned      # 列出所有「已写成例题」的物品
"$PY" "$R" --list-staged       # 列出所有免订阅暂存物品
"$PY" "$R" --rebuild           # 指导书改动后重建「已学习」索引
"$PY" "$R" --purge-check       # 检查哪些暂存可以安全清理
```

脚本会回答四件事并给出建议动作：

| 检查 | 位置 | 命中后的处置 |
| --- | --- | --- |
| ① 已订阅？ | `<STEAM_LIB>\...\content\573090\<id>` | 直接读（**只读**），无需下载 |
| ② 已免订阅暂存？ | `<WS>\_tools\steamcmd\...\573090\<id>` | 直接读暂存，无需重下 |
| ③ 已学习？ | `数据库\Lua\Lua示例\*.md` 中有 `- 来源：steam id <id>` 行 | **直接读指导书对应章节，不再重复下载与精读** |
| ④ 已提取 Lua？ | `AI相关\_提取暂存\<id>_*.lua` | 直接看脚本，连 xml 都不用读 |

**判定优先级**：③ 已学习 > ① 已订阅 > ② 已暂存 > ④ Lua 已提取 > **三者皆无 → 才下载**。

> ⚠ **「已学习」的判定标准**：必须是指导书里带 `来源：steam id <id>` 的**例题**。
> 只出现在「同类作品索引」候选表里的 **不算已学习**（脚本会标 ⬜ 并提示未展开）。
> `--rebuild` 区分这两类；`≥9 位数字`且不在索引表内才判为已学习（避免把配色串 `111111366222111` 误当 id）。

### 步骤 0b — 免订阅下载（仅当步骤 0 判定「三者皆无」时执行）

> **不需要订阅、不需要登录、不需要拥有游戏**，即可把任意 Stormworks 创意工坊物品下载到 D:\。
> 用它可以把语料从「已订阅的 256 个」扩展到「全站任意物品」。

```bash
D="<WS>/AI相关/_scripts/ws_download.py"

"$PY" "$D" 3750251471                     # 下载单个
"$PY" "$D" 3750251471 3793436512          # 批量
"$PY" "$D" --browse 2                     # 抓「最新」2 页的 id 后全部下载
"$PY" "$D" 3750251471 --copy-to "D:/目标"  # 下载后再复制一份
```

**原理**：SteamCMD `+login anonymous` + `+workshop_download_item 573090 <id>`。
SteamCMD 用**自己的匿名账号**下载到自己的目录，**不触碰用户订阅目录、不改变任何订阅状态**
（实测：下载 7 个未订阅物品后，用户订阅数仍 256，`find -newermt` 确认 E:\ 零改动）。

**两条硬性约束（踩过的坑，勿改）**
1. ⚠ **SteamCMD 安装路径必须是纯 ASCII**。含中文会直接报
   `Fatal Error: Steamcmd 在该 Windows 版本上无法从含有非 ASCII 字符的文件夹路径运行`。
   已固定在 `<WS>\_tools\steamcmd`（`<WS>` 与 `_tools` 均为 ASCII）。
2. ⚠ **下载目录不可指定**：SteamCMD 固定输出到
   `<WS>\_tools\steamcmd\steamapps\workshop\content\573090\<id>\`。
   脚本的 `--copy-to` 是「下载后再复制」，不是改变下载位置。

下载后可直接复用本规程的步骤 3~4：`--copy-to` 到暂存目录，或把 `extract_workshop_lua.py`
的 `SRC` 指向下载根目录即可提取 Lua。

> 已知无效的路径（别再试）：
> - `steamcommunity.com/sharedfiles/download/<id>` → 返回登录引导页，无直链
> - `ISteamRemoteStorage/GetPublishedFileDetails` 的 `file_url` → 恒为空（公共 API 不给直链）
> - `ISteamRemoteStorage/GetUGCFileDetails` → 403，需要 publisher key

### 步骤 0c — 🧹 用完即清理（免订阅暂存是临时手段，不是资产）

> **原则：免订阅下载物只是「取 Lua 的临时载体」。一旦 Lua 提取完毕、手法写进指导书，原件即冗余。**
> 重新下载 30 个物品只要 48 秒，留着原件没有价值，只占磁盘。

**清理判定（用 `--purge-check` 自动检查，勿手工判断）**

| 分类 | 判定 | 处置 |
| --- | --- | --- |
| 无 Lua | xml 里没有 `onTick/onDraw` 块 | 可直接删 |
| Lua 已留存 | 其 Lua 的 MD5 已存在于主语料（`_提取暂存/*.lua`）或免订阅批次（`_new/` `_big/`） | **可安全删** |
| ⚠ 有未留存 Lua | 哈希既不在主语料也不在 `_new/_big` | **先提取再删，绝不能直接删** |

```bash
"$PY" "$R" --purge-check        # 输出三类清单与可释放空间；有 ⚠ 项时先补提取
```

**执行清理的正确顺序**
1. 先跑 `--purge-check`，确认 **⚠ 项为 0**；
2. 有 ⚠ 项就先把它们的 Lua 提取进 `_提取暂存/`，再复查；
3. 确认无误后删除「无 Lua」+「Lua 已留存」两类的目录；
4. **保留** SteamCMD 本体（`<WS>\_tools\steamcmd`），后续下载还要用；
5. **保留** `_提取暂存/`（规程第 6 节：中间产物不清理，用户可能复核）。

> ⚠ **清理前必须做的一次性核对**（2026-08-31 实测踩到的坑）：
> 曾有一版检查脚本因「循环内变量未初始化」把「有 Lua 但仅重复」的物品误显示成「无 Lua」，
> 差点误删。**务必用哈希比对确认「每一个 Lua 块都能在留存区找到」，而不是只看目录里有没有对应文件。**

> ⚠ **写文档时的引用约定**（清理后发现的连带问题）：
> 指导书里**禁止**引用 `_tools/steamcmd/steamapps/...` 下的暂存路径——它们会被本步骤清理，链接必然失效。
> 应改为引用下列**不会被清理**的目标：
> - 已提取的脚本：`../../../AI相关/_提取暂存/<id>_*.lua` 或 `_new/`、`_big/`（中间产物，不清理）
> - 作品页 URL：`https://steamcommunity.com/sharedfiles/filedetails/?id=<id>`
> - 已订阅物品的 xml：`<STEAM_LIB>\...\573090\<id>\`（用户自有，不会变）
>
> 清理后必跑一次链接校验，抓出失效引用。

### 步骤 2 — 读取物品描述页（id → 网页）

> 🟢 **首选：Steam Web API（实测最稳，2026-08 验证）**
> 抓 HTML 会拿到两种页面（旧版 `detailsStatRight` / 新版 React SSR 空壳），且易触发限流返回 429。
> **直接 POST 拿 JSON，一次可取多个 id，字段最全**：
>
> ```
> POST https://api.steampowered.com/ISteamRemoteStorage/GetPublishedFileDetails/v1/
> form: itemcount=20  publishedfileids[0]=<id>  publishedfileids[1]=<id> ...
> ```
>
> 返回字段：`title` / `description` / `time_created` / `time_updated` / `tags[]` /
> `views` / `subscriptions` / `favorited` / `preview_url`。
> 现成脚本：`<WS>\AI相关\_scripts\fetch_meta.py`（批量 20 个一组、结果写 `_meta/items.json`）。
> 描述里的 BBCode 需自行清洗（`\[/?[a-z0-9=*\-\s"'/.:]+\]` → 空格）。

- （HTML 兜底）对每个待处理 id，打开 `https://steamcommunity.com/sharedfiles/filedetails/?id=<id>`。
  用 curl 且 UA 仅 `Mozilla/5.0 (Windows NT 10.0; Win64; x64)` 可稳定拿到**旧版**结构；
  带 `Accept-Language` 的完整 UA 反而会拿到 React SSR 空壳（无数据）。
- **🕒 注意更新时间**：页面上的「更新于（Last Updated）」/「发布于」时间是**重要元数据**，务必记录（写入示例来源行与索引表）。它决定同类作品的**采信优先级**（见步骤 4「同功能取新」规则），也方便未来读者判断手法时效性。
  用 API 时即 `time_updated`，转 `%Y-%m-%d`。
- **重点读「描述（description）」部分**：作者通常在这里写明这个载具/微控**干什么**（如「自动驾驶仪」「雷达火控」「燃料管理」「HUD」）。
- 描述提供**功能分类线索**与**实现意图**，是步骤 4 分类与写示例说明的依据。抓取失败时（网络/限流）跳过该页、仅标注 id，不要卡住。
- **📝 描述缺失时的信息补救链**（按序尝试，逐级兜底）：
  1. **物品名称（title）**：工坊标题常直接点出功能（如「Advanced Autopilot」「GPS Guided Bomb」），先看名称能推出什么。
  2. **评论区（comments）**：作者或玩家常在评论里补充用法、已知缺陷、版本变更；翻一翻往往能补全描述没写的实现意图。
  3. **🖼️ 调动有识图能力的 AI 读图**：若名称 + 评论仍不足以判断功能/界面布局，则**调用一个具备图像理解能力的 AI**，把该物品页面截图或展示图（HUD 布局、控件排布、接线示意等）交给它识别，从中提取功能线索。注意这些图片在 **E:\ 只读红线之外**（属 steam 网页资源，可正常下载/读取），不涉及对订阅文件的任何改动。
  - 三级都试过仍无信息，则仅在示例来源行标注「描述/名称/评论/图片均未提供足够信息」，照常提取 Lua 本体（代码本身不会骗人），但分类与说明可保守处理。

### 步骤 3 — 分辨并提取载具/微控中的 Lua

- 对 `vehicle.xml` / `microcontroller.xml`：
  - 用 Grep 找 `<object` 含 `script=` 的行，定位每个 Lua 块。
  - 捕获 `script='...'`（或 `"..."`）属性值，**对 XML 实体做反转义**（`html.unescape` 即可）。
  - 每个 `<object script=...>` 产出一份纯 Lua 文本，按 `《id》_《vehicle|microcontroller》_《序号》.lua` 命名，暂存到 `<WS>\AI相关\_提取暂存\`（**不是 E:\**）。
- 分辨原则（对应需求第 3 点）：
  - 文件是 `vehicle.xml` 或 `microcontroller.xml` → 其中 `script=` 块就是载具/微控的 Lua，**保留**。
  - 文件是 `language.*` / 图片 / 其它 → **忽视**，不提取。
  - 一段 Lua 即使只是几行 trivial 的（如仅转发信号）也提取，但步骤 4 决定是否值得写成示例。

> **可选加速器（省时、仍只读 E:\）**：当物品很多时，可运行一个**只读 Python 提取器**——它只 `open(path, encoding="utf-8")` 读取 E:\ 文件、只把提取结果写到 `<WS>\AI相关\_提取暂存\`。**绝不能在该脚本里对任何 E:\ 路径执行写/删**。参考实现见文末附录 A。

### 步骤 3 补充：压缩（minified）Lua 的识别与反压缩

工坊作者常用 PonyIDE 的 **Minify** 按钮（自动化字数压缩，对应 `00_速查 §14.1`）把 Lua 压成单行。提取到的脚本**很可能就是压缩态**，必须会处理——否则既难读又难学，白白消耗注意力。

**识别压缩态**：单行、语句间用 `;`、几乎无空格/注释、局部变量是 `a/b/c` 单字母；但 **`onTick` / `onDraw` / `httpReply` 三个回调名一定保留**（PonyIDE 硬编码不改名），先靠它们定位入口。

**处理流程（省注意力关键）**：
1. **先反压缩（reformat）再读**：把代码恢复成带换行/缩进的可读结构（等于 PonyIDE 的 Unminify / 任意 Lua formatter）。结构可完美恢复。
2. **变量名有损、需语义还原**：Conservative 压缩**不保存原名映射**，原名已丢；Agressive 模式可能在前缀 `--yyy--` 后内嵌 `短名=原名;` 映射（若作者保留可还原，否则当已丢处理）。所以单字母变量（如 `a=input.getNumber(1)`）**只能靠你理解用途重命名**，没有原名叫得回。
3. **写示例时输出「可读版」**：按第 4 节规范，把反压缩 + 语义改名后的清爽代码写进示例文件；**不要把压缩 blob 原样贴出**——这正是「省注意力」的落点，未来读者拿到干净代码而非一行天书。

> 两种模式差异、锚点、有损细节见 `00_速查 §14.1`，本步骤与之呼应，不重复。

### 步骤 4 — 学习、分类、写示例（产出物）

- 逐个读 `<WS>\AI相关\_提取暂存\` 里的 .lua，理解其**在 Stormworks 特殊环境下如何实现某功能**。
- ⚠ 若读到的是**压缩态**（单行、`;` 分隔、单字母变量），先按「步骤 3 补充」反压缩、按语义重命名；写示例时**只输出可读版**，不贴压缩 blob（见第 4 节规范）。
- **只挑值得的写示例**：剔除纯转发/空脚本；保留展示了某个 SW 专属手法的（复合信号编排、屏幕绘图、属性滑块、雷达/传感器解算、坐标换算、PID、字数压缩、触控等）。
- 🕒 **同功能取新（采信优先级）**：若多个物品实现了**相同的功能且手法相近**，整理示例时**倾向于采用更新时间更晚的那个**作为范例来源（更新时间来自步骤 2 记录的「Last Updated」）。理由：较晚的作品通常站在较早者肩膀上，bug 更少、手法更优、对当前版本兼容性更好。仅当「旧作有而新作没有的独特手法」时才保留旧作作补充示例，并明确标注「旧版独有手法」。
- 分类写入 `<WS>\数据库\Lua\Lua示例\`（**平铺，无子目录**），并维护顶层索引（见第 4、5 节）。

---

## 3. 学习时应交叉引用的本工作区知识库（避免重复学、省注意力）

| 资源 | 路径 | 用途 |
| --- | --- | --- |
| **脚本 Lua 与标准 Lua 差异（必读）** | `<WS>\数据库\Lua\lua总体设定\00_速查_SW_Lua与常规Lua差异.md` | 写示例前先核对：双端随机、100ms 丢弃、Y 垂直轴、圈 vs 弧度、`atan2` 缺失、`#`/`ipairs` 避坑、多返回值加括号、仅 ASCII 源码、8192 上限、多人变量不同步、`property`/`map`/screen API（§16） |
| 附加 Lua API 速查 | `<WS>\数据库\Lua\lua总体设定\01_addon_Lua_API速查.md` | 仅作对比；创意工坊脚本**不是**附加 Lua，勿混 |
| 传感器/雷达坐标系与解算 | `<WS>\数据库\方块数据\17_传感器与雷达.md` | 凡涉及 GPS/物理传感器/雷达/声纳的坐标换算与 Lua，先查此册 |
| 现有游戏内 Lua 指导书 + 例题集（风格对齐） | `<WS>\数据库\Lua\Lua示例\`（`README.md` + `00_AI写作指导.md` + `01`~`08`） | 新示例的写法、压缩风格、章节组织以此为准；**先读 `README.md` 的索引与反查表再动手** |
| 术语对照（中文名必须查表） | `<WS>\汉化相关\`（`sw_lookup.py` / `sw_check.py`） | 示例里出现 Stormworks 专有名词的中文时，先查对照表采用既有译法，**禁止臆译** |

> ⚠ 凡涉及 Stormworks 中文专有名词（部件名、UI、信号名），必须先跑 `sw_check.py --auto` 再 `sw_lookup.py "关键词"`，采用表中译法。这条是工作区铁律。

---

## 4. 示例文件编写规范（省注意力核心）

每个示例按此结构，**代码块保持 ASCII**（游戏内 Lua 只能 ASCII，见 00_§13；中文说明放代码外）：

```
### 《示例标题》（功能一句话）
- 来源：steam id <id> · 描述页 <url> · 载具/微控
- 更新时间：<Last Updated 日期，来自步骤 2；用于「同功能取新」采信与时效性判断>
- 用到：<部件/信号，如 雷达 + 复合通道 1-4、属性滑块 Callsign>
- 亮点：<本例展示的 SW 专属手法，1 句>
​```lua
-- 仅标注 SW 特殊点；通用 Lua 不注
function onTick()
  ...
end
​```
- 关联：`00_速查 §16`（screen API）/ `17_传感器与雷达.md`（坐标系）  ← 交叉引用，不重讲
```

硬性要求：
1. **省略通用 Lua 语法讲解**（for/ipairs/string.format 基础等）。只在 SW 特殊处写注释：如 `matrix.position((server.getPlayerPos(id)))` 的双层括号、`math.atan(y,x)` 两参、`property.getText`、`screen.drawText` 等。
2. **坐标/角度约定**不重讲，直接引用 `00_速查 §4` 与 `17_传感器与雷达.md`；代码里出现「圈」单位或 X东/Y上/Z北 时标注即可。
3. **字数压缩**若示例展示，保留缩写风格（如 `M=math S=screen`），呼应 `00_速查 §14`。
4. **中文术语查表**，用对照表译法。
5. 不贴整段冗长脚本；**只摘取展示手法的核心片段**，必要时注明「完整脚本见暂存 _提取暂存/<file>.lua」。
6. 🔴 **示例里不要出现 9 位及以上的裸数字**。
   `ws_reference.py --rebuild` 用「≥9 位数字且不在索引表内」判定 `来源：steam id <id>`，
   代码里的 `100000000` 会被误当成 id 收进已学习清单（2026-09-03 实测踩到：多出一个 `100000000` 假条目）。
   大常数一律写成 `1e8` / `2^24` 之类，或在说明文字里拆开写。

---

## 5. 分类目录与导航索引（让 AI 快速定位）

产出根目录：`<WS>\数据库\Lua\Lua示例\`（**平铺，无子目录**）

- `README.md` —— **顶部导航**，含文件索引表、按功能反查表、按「坑」反查表，AI 按功能直接跳。
- `00_AI写作指导.md` —— 指导书（动手前 5 问、骨架模板、调试、自检清单）。
- 分类文件 `01`~`08`（**固定命名，不要新增编号文件**，新例题追加到对应的那一个）：

| 文件 | 收什么 |
| --- | --- |
| `01_基础惯用法与字数压缩.md` | 三铁律落地、别名压缩、大表搬进属性文本、反压缩、多人同步、批量 IO |
| `02_逻辑IO·状态机·定时.md` | pulse/toggle/timer、有限状态机、延迟事件、PID 接执行器 |
| `03_传感器与雷达解算.md` | 物理传感器姿态、雷达解包、球面→笛卡尔、三角定位、PPI、激光成像 |
| `04_数学·滤波·数据工具.md` | clamp/角差/EMA/卡尔曼、矩阵、贝塞尔、队列、split/dump、单位换算 |
| `05_屏幕绘图与HUD.md` | 点阵字体、负高度条形图、罗盘带、触控按钮、图形原语、HSL、中文渲染 |
| `06_导航制导与自动驾驶.md` | 三轴姿态 PID、自适应巡航、HSI、航路点归航 |
| `07_通信·输入与数据链.md` | 键盘协议、无线电多目标跟踪、TCAS |
| `08_武器火控·引擎仪表.md` | 瞄准门控与开火时序、余弹记账、RPS/升降率告警柱 |

**每往某分类文件加例题，同步更新 `README.md` 的索引表与两张反查表。**

每往某分类文件加示例，同步更新 `README_索引.md` 的对应行。

---

## 6. 收尾

- 全部处理完（或用户叫停）后：
  - 确保指导书 `数据库\Lua\Lua示例\README.md` 的**索引表与两张反查表**完整、准确。
  - 向用户汇报：处理了多少 id、提取多少段 Lua、写成多少示例、分在哪些类别；并点出**最有价值的几个 SW 专属手法**。
  - **不**清理 `<WS>\AI相关\_提取暂存\`（那是中间产物，用户可能要复核）；若用户要求再删。
  - 🧹 **清理免订阅暂存**：跑 `ws_reference.py --purge-check`，⚠ 项为 0 后删掉冗余的下载原件（见步骤 0c）。
    重新下载很快，原件不值得留。**SteamCMD 本体要保留**。
  - 若新写了例题，**重建已学习索引**：`python ws_reference.py --rebuild`。
- 全程牢记：E:\ 只读；产出只在 <WS>\。

---

## 附录 A-2 — 已就绪的工具链（2026-08 建立，直接复用）

> 全部**只从 E:\ 读、只往 D:\ 写**。用受管 Python 跑：
> `"<PY>" <脚本>`

| 脚本 | 作用 | 备注 |
| --- | --- | --- |
| **`AI相关/_scripts/ws_reference.py`** | **步骤 0 查重**：给 id/url 即答「已订阅 / 已暂存 / 已学习 / Lua 已提取」并给建议动作；`--rebuild` 重建已学习索引；`--purge-check` 检查哪些暂存可安全删 | **用户给链接时第一个跑它** |
| `AI相关/_scripts/ws_download.py` | 步骤 0b：SteamCMD 匿名免订阅下载 | 安装路径必须纯 ASCII |
| `AI相关/_scripts/extract_workshop_lua.py` | 附录 A 提取器 + 统计，额外输出 `_manifest.json`（id → 块数/字符数/是否压缩）。**2026-09-03 起支持 `--src DIR`（可重复，多源依次扫描）与 `--out DIR`**；默认仍是订阅目录 + `_提取暂存` | 2308 块 / 542 万字符（2026-08 实测规模） |
| `AI相关/_scripts/fetch_meta.py` | 步骤 2：Steam Web API 批量取元数据 → `_meta/items.json` | 41/41 成功率，优于抓 HTML |
| `AI相关/_scripts/census_lua.py` | **省注意力关键**：对全部 Lua 按 SW 专属 API 加权打分、打功能标签，输出 `_census.json`。**2026-09-03 起支持 `--src DIR`**（只普查某个批次） | 别通读，先普查再挑 |
| `AI相关/_scripts/dedup_pick.py` | 按内容 MD5 去重 + 按类别给推荐精读清单，输出 `_unique.json` | 2308 块 → 1009 唯一（重复率 56%）；SRC 硬编码为主语料，只跑全量 |
| **`AI相关/_scripts/dedup_lua_batch.py`** | **批次版去重**：`--` 传逗号分隔 id 或用位置参数传 id 列表，只对本批去重并打印选题清单 | 口径同 `dedup_pick`（剥头部两行后 MD5） |
| **`AI相关/_scripts/diff_lua_batch.py`** | 🔑 **本批 vs 主语料哈希差分**：剔除「主语料里已经有了」的脚本，只留全新代码 | **每轮必跑**，见下方「批内去重 ≠ 全语料去重」 |
| `AI相关/_scripts/dump_lua.py` | 按文件名批量打印 `_new/` 下的脚本（省一次一个 Read） | `dump_lua.py a.lua b.lua` |
| `AI相关/_scripts/unminify.py` | 步骤 3 补充：Minify 反压缩，`-o` 输出到 `_提取暂存/_readable/` | 保护字符串/注释，结构可完美恢复 |
| **`AI相关/_scripts/ws_rank.py`** | **选题排序**：三维度浏览 + 元数据加权打分，产出待办榜单 `_meta/ws_ranked.json` | 见附录 A-3；批量/自动化时**先跑它**再决定学什么 |

**推荐执行顺序**（省注意力）：

- **用户给链接要参考时**：`ws_reference`（查重）→ 三者皆有则**直接读指导书/对应 xml**，结束；三者皆无才 → `ws_download`。
- **批量扩充语料时（价值优先）**：`ws_rank --crawl N` → `ws_rank --top K` → `ws_download` → `extract` → 与已有语料**做 hash 差分** → `census` → 只精读新脚本 → 压缩态先 `unminify` → 写示例 → `--rebuild` → `--purge-check` → 清理暂存。
- **全量重跑时**：`extract` → `fetch_meta` → `census` → `dedup_pick` → 只精读 `_unique.json` 排名靠前的 20~80 段 → 写示例。

**选题经验**：
- `census` 里 `matrix.` `property.getText` `map.*` `screen.drawTriangle` `string.byte` `math.atan` 是**高价值信号**，命中者基本都值得写示例。
- `dedup_pick` 的 TOP 列表里大量是同一脚本的多副本，**看 `copies` 与 `ids` 字段即可合并**。
- 单段超过 ~5000 字符的往往是综合 HUD，抽取核心片段而非全贴。

**🔴 批内去重 ≠ 全语料去重**（2026-09-03 实测踩坑）

`dedup_lua_batch.py` / `dedup_pick.py` 只告诉你「这一批里有多少份不同的代码」，
**不会**告诉你「这段代码是不是早就被别的作品学过了」。

实测：某轮 12 个作品 156 块 → 批内去重 63 唯一，其中 **5 段与主语料里的
`3167674961_vehicle_98`、`2623064051_vehicle_0` 等逐字节相同**——
即本批有 2 个作品整套搬了已学过的模块（罗盘模块、轮询数据链模块）。
若只做批内去重，会对着已经写进指导书的例题再精读一遍。

**正确顺序**：批内去重 → `diff_lua_batch.py` 差分 → 只对「全新」清单精读。

```bash
"$PY" "$G/dedup_lua_batch.py" -- 3792551514,3792899963          # ① 批内去重
"$PY" "$G/diff_lua_batch.py"  3792551514,3792899963             # ② 与主语料差分
```

> 两边**都必须**先剥离提取头部两行，否则两侧哈希口径不一致，差分结果全是「全新」。

**🔴 去重前必须剥离提取头部**（2026-09-01 实测踩坑）

`extract_workshop_lua.py` 会在每个文件开头写入两行注释：

```
-- source: steam id <id> / vehicle.xml block#<n>
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=<id>
```

**这两行让每个文件的 MD5 都不同**，直接对整个文件做哈希会得出「零重复」的错误结论。
实测三个防空作品 247 个文件：不剥离 → 247 个"唯一"；剥离后 → **72 个唯一**。

正确做法：

```python
body = '\n'.join(txt.split('\n')[2:]) if txt.startswith('-- source') else txt
h = hashlib.md5(body.encode()).hexdigest()
```

> 🔴 **同一个坑还埋在 `ws_reference.py --purge-check` 里**（2026-09-03 实测发现并已修复）：
> 它扫 `_提取暂存/*.lua` 时剥了头部两行，扫 `_new/` `_big/` 时**没剥**，
> 于是刚提取完的一批作品**全部被误判成「⚠ 有未留存 Lua」**，清理流程卡死。
> **凡是跨目录比对 Lua 哈希，两边都必须用同一套剥离口径。**

**大作品尤其要先去重再读**：`3524040776` 有 161 个 Lua 块，
其中单个飞行控制脚本就有 **28 份完全相同的副本**（每枚导弹一份）。
不去重会被同一份代码淹没，浪费大量注意力。

**关键词扫描要避免常见词误命中**：用 `lead` 做制导关键词会把几乎所有脚本都命中；
应改用 `\bmissile\b`、`seeker`、`guidance`、`homing`、`launch`、`ballist` 等带边界的窄词。

---

## 附录 A-3 — 价值排序：先吃高价值作品（2026-09-03 建立）

> **问题**：按 `mostrecent` 硬啃全站，前面几十页常是刚传上来的空壳/试手作品，性价比极低。
> **对策**：用 `ws_rank.py` 把「热度 / 累计订阅 / 更新时间」合成加权分，按分数降序产出待办。

### 双轨策略（自动化/批量时的推荐组织方式）

| 轨 | 排序 | 职责 | 何时跑 |
| --- | --- | --- | --- |
| **价值轨**（主） | `trend` + `totaluniquesubscribers` + `lastupdated` | 决定**先学什么**，每轮吃榜单 TOP K | 每轮优先 |
| **完整性轨**（兜底） | `mostrecent`，游标 `cursor_page` 单调推进 | 保证最终**覆盖全站**，不漏冷门 | 价值榜吃空时 / 有剩余预算时 |

两轨都无待办 → 判定全部学完。进度账本：`AI相关\_meta\ws_scan_progress.json`。

### 评分口径（脚本内置默认，可用 `--weights` 覆盖，脚本会归一化到和为 1）

| 项 | 权重 | 算法 |
| --- | --- | --- |
| `trend` 浏览位次 | 0.28 | `1/页码`（第 1 页满分，长尾衰减；未出现记 0） |
| `totaluniquesubscribers` 浏览位次 | 0.24 | `1/页码` |
| `lastupdated` 浏览位次 | 0.08 | `1/页码`（把老作品翻新过的也捞进来，权重刻意压低以免与新鲜度重复计分） |
| 订阅数绝对值 `pop` | 0.15 | `log10(subs+1) / log10(本批最大 subs+1)`，相对归一，避免绝对阈值过时 |
| 更新时间新鲜度 `fresh` | 0.25 | `0.5 ** (距今天数 / 540)`，半衰期 540 天 |

**成本加成**（同分层里优先吃现成的，省一次下载）：已订阅 `+8` / 已免订阅暂存 `+5` / Lua 已提取 `+3`。

### 常用命令

```bash
R="<WS>/AI相关/_scripts/ws_rank.py"

"$PY" "$R" --crawl 4                      # 三维度各抓前 4 页 → 拉元数据 → 算分 → 存榜
"$PY" "$R" --top 12                       # 输出排名前 12 的「未学习」id（空格分隔，可直接喂 ws_download）
"$PY" "$R" --show 20                      # 打印榜单给人看（加 --all 含已学习的）
"$PY" "$R" --refresh                      # 不重抓浏览页，只刷新状态与分数
"$PY" "$R" --browse mostrecent 37 3       # 完整性轨：从游标页起抓 3 页并打印 id
"$PY" "$R" --crawl 4 --weights trend=0.3,subs=0.25,upd=0.05,pop=0.15,fresh=0.25
```

- 榜单本体 `_meta/ws_ranked.json`，**候选池跨轮累积**，不要每轮重建；元数据超过 7 天才会重拉。
- `steamcommunity.com` 返回 403 → 脚本放弃该维度并记入 `note`，**不重试**；三维度全 403 时转完整性轨。
- 路径不硬编码：优先读 `工作区导航\路径配置.json` → `sw_paths.detect()` → 回退 `ws_reference` 常量。

---

## 附录 A — 可选只读 Python 提取器（只从 E:\ 读、只往 D:\ 写）

> 仅当用户要求处理「全部/大量」物品时使用。脚本**不得包含任何对 E:\ 路径的写/删操作**。

```python
import os, re, html

SRC = r"<SW_WORKSHOP>"   # 只读源
OUT = r"<WS>\AI相关\_提取暂存"                       # 唯一写入目标
os.makedirs(OUT, exist_ok=True)

# 匹配 <object ... script='...' 或 script="..." ；内部因 XML 转义不含裸引号，故安全
pat = re.compile(r"<object\b[^>]*\bscript=(['\"])(.*?)\1", re.S)

count = 0
for tid in sorted(os.listdir(SRC)):
    base = os.path.join(SRC, tid)
    if not os.path.isdir(base):
        continue
    for fn in ("vehicle.xml", "microcontroller.xml"):
        p = os.path.join(base, fn)
        if not os.path.isfile(p):
            continue
        try:
            txt = open(p, encoding="utf-8", errors="ignore").read()  # 仅读
        except Exception:
            continue
        for i, m in enumerate(pat.findall(txt)):
            lua = html.unescape(m[1])            # 反转义还原真 Lua
            if "onTick" not in lua and "onDraw" not in lua:
                continue                         # 非 Lua 脚本块跳过
            out = os.path.join(OUT, f"{tid}_{fn.split('.')[0]}_{i}.lua")
            with open(out, "w", encoding="utf-8") as f:
                f.write(f"-- source: steam id {tid} / {fn} block#{i}\n")
                f.write(lua)
            count += 1
print("extracted", count, "lua blocks ->", OUT)
```

运行（用受管 Python）：
```
<PY> 提取器路径.py
```

---

## 附录 B — 调用方式（给用户）

- 在对话中 **@ 本文件** 并说：「按规程提取创意工坊 Lua / 跑一遍 / 执行」。
- 可加范围限定，例如：「只处理 id 1772155525 和 1832148370」「先只做导航类」「全部跑，分类写入」。
- 随时可说「停」「先汇报进度」；AI 立即停在当前步并汇报。


---

## 附录 C — 云同步与合并纪律（云端分流架构）

> 适用场景：本机离线时，希望 WorkBuddy 云端（小程序「云上模式」）按同一规程代跑，产出投递到资料库，
> 本机上线后再拉取合并。完整云端任务提示词见 `AI相关\_scripts\云端任务规格说明.md`。

### 架构三原则

1. **时间互斥（心跳租约）**：本机每轮结束写账本 `last_seen`（schema 2 字段，UTC+8 当前时间）。
   云端启动先 `ws_sync.py --cloud-check-heartbeat` 读「元数据包」里的 `last_seen`，窗口（2.5h）内则 SKIP。
   两侧**不并行**，靠心跳而非 id 分片。
2. **双写分离**：云端永不直接改本地 md；云端只把「账本快照 + 提取的 Lua」打包成 `sw_out_<UTC>.zip`
   推到资料库队列目录。**本机** `ws_sync.py --pull` 消费：合并账本 + 复制 Lua 到 `_提取暂存\`，
   再由本机正常写例题。md 只由本机写，从源头消除写冲突。
3. **幂等与字段级合并**：`merge_ledger()` 规则——
   `ids_*` 与 `pending_ids` 取**并集**；`completeness.done` 取 **AND**；`cursor_page` 取 **min**（不越级）；
   `last_top_ids` 云端**覆盖**；`ranked_pool_size` 取 **max**。重复 pull 不重复处理
   （`ws_sync_state.json` 记已消费批次），已存在的 Lua 文件不覆盖。

### 关键纪律

- ⚠ **云端所有 `ws_reference.py` 调用必须带 `--index <从元数据包取出的 _workshop_learned.json> --no-build`，
  **禁止 fallback 扫描**——否则云端空目录重建出空索引，会把已学作品全部重下一遍。
- 云端**只做 crawl + 下载 + 提取**，不写例题、不改本地 md（避免写冲突）。写例题由本机 pull 后统一做。
- 资料库 token **不落地**、不进日志；sandbox 模式免 token，client 模式经 `connect_open_platform` 换票后传 `--token-stdin`。
- 单包 ≤100 MiB；zip/json 走 drive 原样存，`.md`/`.csv` 上传会被转格式，勿传。

### 一键验证（无需联网）

`ws_sync.py --self-test` / `--merge-test` / `--round-trip-test` / `--heartbeat-test` 应全绿。

### 本机一次性初始化（桌面端 WorkBuddy 手跑一次）

```
<PY> <WS>\AI相关\_scripts\ws_sync.py --init-anchor     # 建队列目录 SW工坊云同步，写 lib_anchor.json
<PY> <WS>\AI相关\_scripts\ws_sync.py --push            # 首次上传元数据包 sw_pkg_*.zip（记录 pkg_node_id）
<PY> <WS>\AI相关\_scripts\ws_sync.py --pack-scripts    # 打包 sw_scripts_*.zip，上传资料库一次供云端自举
```
之后本机自动化每轮收尾自动 `--push`（原地替换），开场自动 `--pull`（best-effort）。
