# AGENTS.md — STORMWORKS 工作区 AI 契约（平台无关）

> 本文件是**唯一权威的 AI 契约**，内容不绑定任何平台。
> `CLAUDE.md`、`.github\copilot-instructions.md`、`.cursor\rules\stormworks.mdc`、`CODEBUDDY.md`
> 均为转发/补充层——**改规则一律改本文件**。
> 人类可读的总入口是同目录 `README.md`；详细索引在 `工作区导航\`。

---

## 0. 📌 路径占位符（先解析，再动手）

**本文档与全工作区文档一律用占位符写路径**——`C:\Users\EC90`、`E:\SteamLibrary` 只是**本机值**，
换机器后必然变化（用户名不同、盘符不同、Steam 库位置不同）。

| 占位符 | 含义 | 备注 |
| --- | --- | --- |
| `<WS>` | 工作区根目录（`D:\STORMWORKS`） | 盘符不固定 |
| `<HOME>` | 用户主目录 `C:\Users\<用户名>` | **含用户名，因机器而异** |
| `<STEAM_LIB>` | Steam 库根目录 | **盘符与目录名都不固定** |
| `<SW_GAME>` | `<STEAM_LIB>\steamapps\common\Stormworks` | 🚫 只读 |
| `<SW_DEFS>` | `<SW_GAME>\rom\data\definitions` | 🎮 权威源，只读 |
| `<SW_WORKSHOP>` | `<STEAM_LIB>\steamapps\workshop\content\573090` | 🚫 只读；无订阅时不存在 |
| `<SW_LANG_TSV>` | `<SW_WORKSHOP>\<物品ID>\language.tsv` | 工坊物品 ID 会变，**按文件名搜** |
| `<SW_SAVE>` | `<HOME>\AppData\Roaming\Stormworks`（Win） | ⚠ 改前备份；至少启动过一次游戏才存在 |
| `<PY>` / `<PYX>` | Python 解释器（纯标准库 / 带三方包） | 本机值见下 §8 |

**解析（新环境/新会话第一步）**：

```bash
python "<WS>/工作区导航/脚本/sw_paths.py"           # 打印所有占位符真实值 + OK/MISS
python "<WS>/工作区导航/脚本/sw_paths.py" --json    # 机器可读
python "<WS>/工作区导航/脚本/sw_paths.py" --write   # 刷新 工作区导航/路径配置.json
```

**报 `MISS` 时（硬性流程）**：① 按脚本打印的排查建议人工定位 →
② `sw_paths.py --set <KEY>=<真实路径> --write` 回写配置 →
③ 更新 `工作区导航\04_环境与外部依赖.md` 的 **§7 本机实测值**（全工作区唯一写真路径的地方）→
④ 若是探测逻辑覆盖不到的环境形态，改 `sw_paths.py` 的探测链而不是只在文档打补丁。

完整约定见 `工作区导航\07_路径占位符约定.md`。

---

## 1. 🔴 最高优先级：只读红线（先于一切）

以下两处是 **Steam 托管目录**，**只有读权限**：

| 路径 | 内容 |
| --- | --- |
| `<SW_GAME>\` = `<STEAM_LIB>\steamapps\common\Stormworks\` | 游戏根目录（`rom\data\definitions\*.xml`、`sdk\data\game_constants.xml`、meshes） |
| `<SW_WORKSHOP>\` = `<STEAM_LIB>\steamapps\workshop\content\573090\` | 创意工坊订阅物（载具 / 微控 / 汉化补丁） |

严禁对其中的任何文件执行写入、修改、删除、移动、重命名，也严禁在其下创建临时文件。
破坏可能导致游戏损坏或订阅丢失，且不可挽回。**一切产出只写进 `<WS>`（`D:\STORMWORKS`）**（临时文件也放 `<WS>\_work\` 或系统临时目录）。

⚠ 有条件可写：`<SW_SAVE>\data\vehicles\*.xml`（用户数据，路径随平台变化，见 §0），
**改前必须先备份到 `<WS>\_work\`**。

---

## 2. 📖 Stormworks 术语必须查表

凡涉及 Stormworks 游戏内容的中英互译（部件名、UI、Lua/微控制器、任务剧情、地名生物名），
**必须先查 `<WS>\汉化相关\` 的对照表（8795 条）并采用既有译法，禁止凭语感意译。**

```bash
PY="<PY>"                        # 由 sw_paths.py 给出；没有托管 Python 时系统 python 3.8+ 亦可
G="<WS>/汉化相关/脚本"

"$PY" "$G/sw_check.py" --auto                       # ① 新鲜度检查（毫秒级，每次都跑）
"$PY" "$G/sw_lookup.py" "modular engine cylinder"   # ② 英文关键词查询
"$PY" "$G/sw_lookup.py" --zh 螺旋桨                 #    中文反查
"$PY" "$G/sw_lookup.py" --id def_giga_prop_small_name
"$PY" "$G/sw_lookup.py" --cat 引擎与动力 --limit 40
"$PY" "$G/sw_batch.py"  --terms "Motor Small, Wheel 3x3 Suspension"   # 批量，输出 HIT/FUZZY/MISS
"$PY" "$G/sw_find.py"   Motor Rocket --parts-only                     # 同义词兜底
```

- `sw_check.py` 退出码：`0` 最新 / `2` 需更新但未执行 / `3` 失败（**返回 3 仍可查表，但要向用户说明可能过期**）。
- Python 路径不可用时，退化为直接读 `汉化相关\常用术语速查.md` 或 `汉化相关\词典\部件_*.md`。
- **批量命中率低时，多半是 wiki 名 ≠ 游戏内名**（词序相反 / 括号位置不同）。
  三级流程：`sw_batch.py` → `sw_find.py` → 仍无对应才标 `※` 自译。
- 占位符 `###`、`[$[action_xxx]]` 原样保留；同族用词：propeller→螺旋桨、rotor→旋翼/转子、
  thruster→推进器、pivot→枢轴、winch→绞盘、modular engine→模块化引擎、cylinder→气缸、
  crankshaft→曲轴、manifold→歧管、microcontroller→微控制器、composite→复合信号。

完整规则与自检清单见 `<WS>\术语对照指南.md`。

---

## 3. 🎮 数据权威性排序（冲突时取靠前者）

| 级别 | 来源 | 标记 |
| --- | --- | --- |
| ① | 游戏文件 `rom\data\definitions\*.xml`（759 个部件定义）、`sdk\data\game_constants.xml` | `🎮` |
| ② | 游戏内文本（部件描述、编辑器 Help 标签） | `✅` |
| ③ | 日文 wikiwiki.jp `sbarjp` | — |
| ④ | Fandom wiki / biligame（社区维护，常过时） | `⚠` |

**带 `🎮` 的数值不需要再实测。** 查询工具：

```bash
S="<WS>/数据库/方块数据/脚本"

"$PY" "$S/sw_defs.py" get "部件游戏内英文名"   # 权威规格：mass / $ / 尺寸 / 逻辑节点 / 描述
"$PY" "$S/sw_defs.py" cat 7                   # 按分类列全部（7=传感器）
"$PY" "$S/sw_defs.py" check                   # 核对文档里的部件名是否真实存在
```

> `sw_defs.py` 节点方向的 `mode` 语义已用全量定义文件统计校正：**mode=0 → 输出，mode=1 → 输入**。

---

## 4. 先查这几册中文知识库，别凭记忆回答

各册根目录 `README.md` 是入口，**里面「AI 阅读规则」段优先于正文**。

| 册 | 位置 | 回答什么 |
| --- | --- | --- |
| 基本设定 | `数据库\stormworks基本设定\` | 机制原理：浮力、流体、电力、绳索、Lua（14 篇） |
| 部件册 | `数据库\方块数据\` | 部件名称、规格、参数、接口、逻辑通道（**21 册** + `00_速查_部件总表.md`；第 21 册是 `.mesh` 二进制实测几何） |
| PID 册 | `数据库\PID控制与调试.md` | PID 调参方法论、振荡过冲排查 |

**写代码前必读**：

| 要做什么 | 先读 |
| --- | --- |
| 弹道计算机、火炮解算 | `数据库\方块数据\16_武器与弹药.md` + `弹道计算参考\` |
| 雷达/声纳解算、制导、物理传感器 | `数据库\方块数据\17_传感器与雷达.md` |
| 雷达噪声表征、摄像头稳像、座圈调参（**本机实测**） | `数据库\方块数据\雷达与摄像头稳定_阶段总结.md`；可直抄 Lua 在 `数据库\Lua\Lua示例\03_传感器与雷达解算.md` §10 |
| 模块化引擎调参 / 控制 / 实测 | `数据库\方块数据\模块化引擎实测_阶段总结.md` + `数据库\Lua\模块化引擎控制_Lua参考手册.md` |
| 写游戏内 Lua | **端到端流程先查 `数据库\Lua\Lua辅助编写工作流.md`**；知识入口 `数据库\Lua\Lua示例\`（10 篇）+ `数据库\Lua\lua总体设定\00_速查_SW_Lua与常规Lua差异.md` |

⚠ 各册源于社区维护的 wiki，**数值可能已被版本更新推翻**。要精确数值先查 `sw_defs.py`，查不到才实测。

---

## 5. 技能库（`<WS>\技能库\`）

| 技能 | 何时用 |
| --- | --- |
| `sw-vehicle-xml` | 读/改载具 XML 与微控制器内部接线（含组件 type 语义表与编辑纪律） |
| `sw-modular-engine-bench` | 模块化引擎示波器 CSV → 标准化归档文档（18 轮经验固化） |
| `stormworks-fandom-kb` | Fandom wiki 抓取 + 本地检索（纯标准库，本地库 737 页） |
| `stormworks-update-check` | 游戏更新检查（四态结论） |
| `stormworks-wiki-to-book` | 日文 wikiwiki.jp 抓取 → 知识册（需 requests/bs4） |
| `sw-mesh-tools` | 解析 `.mesh` 二进制 → 部件真实几何（实测 AABB/三角数/可涂色）；格式漂移校验 |
| `sw-lua-dev` | 载具 Lua 游戏外开发链：静态检查（字符上限/XML 纪律/沙盒陷阱）+ storm-lua-minify 压缩 + Fengari 无头模拟与屏幕渲染核对 |

**非具备技能加载能力的平台**：直接读 `技能库\<名称>\SKILL.md`，按其中步骤手工执行即可，
里面写的是完整的领域约定与命令，不依赖任何平台能力。

---

## 6. 写代码前的硬约束

### 微控制器 Lua（会直接破坏 XML）

- 脚本以属性形式序列化：**禁用双引号**；`<`、`&` **绝对禁止**（`>` 合法）。
  比较一律写成 `>` 方向（`if a>10`、`if DEAD>math.abs(e)`）或用 `math.min/max`；
  **注释里也不得出现半角 `<`**（用「低于 / 大于 / ≤」替代）。
- MC Lua 上限约 4096 字符/脚本；`math.atan` 单参数（atan2 用 `at(x/y)` 且 y>0 代替）。
- 编辑后 `python -c "import xml.etree.ElementTree as ET; ET.parse(path)"` 验 well-formed。
- 同一载具多个 Lua 块可有同名函数但语义不同，清理/替换**按 object id 精确限定作用域**。

### 批量数据上传

凡用 `async.httpGet` 上传批量数据，**URL 长度必须 < ~4000 字符**（超约 4096 游戏崩溃）。
控制手段：减小批量 tick 数、降低数值精度、减少通道数。

### 载具 XML

- 改前备份到 `<WS>\_work\`；Edit 报告成功后**必须重新 grep 复核**。
- 载具 XML 不是合法 XML（矩阵属性名以数字开头），用 `sw_vehicle.py`/Python 解析，勿裸用 ElementTree。
- 大文件（0.5 MB+ 单行）禁止 Read 全文，用 Python/grep 定点提取。
- 坐标解算改动：先用 Python 复刻 Lua 做**离线数值仿真**再交付。

### 传感器与坐标

- 🔴 **物理传感器复合输出 ch4-6（欧拉角）单位是「弧度 rad」，值域 -π~+π，不是圈**——直接喂 `math.sin/cos`，**勿再 ×2π**。雷达方位/仰角等其他角度仍以「圈」计，须 ×2π。
- GPS 系（X东/Y北/Z高）与物理传感器系（X东/Y上/Z北）**Y 与 Z 互换**；欧拉角 Z-Y-X 序。
- 雷达误差：距离 ±1%、角度 ±0.001 圈；滤波用 **ABF(α-β)**（β≈α/10），加在算完的坐标上。

### 游戏二进制资源（.mesh）

- 解析走技能 **`sw-mesh-tools`**（纯标准库，只读）；🔴 **必须排除 `back up/` 镜像**（3613 个，与 `rom/` 完全重复），
  排除逻辑集中在 `sw_mesh.iter_game_meshes()`，禁止各自实现。
- **指针闭合**（`bytes_consumed == file_size`）是最强断言，当前 **3653/3653** 通过。
  游戏更新后先跑 `sw_mesh.py verify`，失败即格式漂移，须更新规格再重建索引。
- 顶点 **28 B = f32[3]pos + u8[4]RGBA + f32[3]normal**，**无 UV**（设计如此），法线是单位向量，
  可涂色基色 **RGB(255,125,0)**。头部 14 字节（**5 个 u16**，社区文档误写 6 个）。
- 部件**不使用 .phys**（碰撞体在定义 XML 的 `physics_shape` / `<surface>`）；`.phys` 仅地形/建筑/门使用。
- **实测几何 ≠ 占位格数**：占位来自 `<voxel_min>/<voxel_max>`（独立数据源），558 条可比对中 92.3% 吻合；
  超出者多为**可动部件烘焙了极限姿态**（如气动活塞实测 1×5.10×1 格）。
- 社区格式文档**一律先经全量指针闭合复核再采信**，不得直接照抄（已实测修正三处错误）。

---

## 7. 收工：写记忆

- 追加到 `<WS>\.workbuddy\memory\YYYY-MM-DD.md`（**只追加，不覆盖**）。
  只记有跨会话价值的内容：技术选型、踩坑、实测结论、用户偏好。
- 长期结论蒸馏进 `<WS>\工作区导航\05_项目长期知识.md`，
  并在 `.workbuddy\memory\MEMORY.md` 留摘要 + 指针（该文件 ≤3000 字符）。
- 跨项目/个人偏好写到 `<HOME>\.workbuddy\MEMORY.md`（**含用户名，因机器而异**）。

---

## 8. 环境速查

```bash
PY="<PY>"    # <HOME>/.workbuddy/binaries/python/versions/<版本>/python.exe        纯标准库，默认用它
PYX="<PYX>"  # <HOME>/.workbuddy-ai/binaries/python/envs/default/Scripts/python.exe  requests/bs4/lxml/PIL
PYN="<HOME>/.workbuddy/binaries/python/envs/ocr-light/Scripts/python.exe"           numpy/PIL
```

- 三个解释器的**真实值由 `sw_paths.py` 探测**（`PY` / `PYX` 两项；`PYN` 按上式在 `<HOME>` 下找）。
  本机值另见 `工作区导航\04_环境与外部依赖.md` §7。
- **没有 WorkBuddy 托管 Python 也能工作**：标注「依赖：无」的脚本用系统 Python 3.8+ 即可。
- 基础解释器**无任何第三方包**；报 `ModuleNotFoundError` 时先换 venv，不要 `pip install` 污染全局。
- 两个 `.workbuddy` / `.workbuddy-ai` 前缀的解释器是同一份二进制，历史文档里的旧路径仍可用。
- 术语表由 Windows 定时任务 `StormworksGlossarySync`（每天 10:00）自动同步，**不依赖任何 AI 平台**。
- 管理定时任务用 PowerShell `*-ScheduledTask` cmdlet（`schtasks.exe` 被本机安全策略拦截）。
- 完整环境说明：`工作区导航\04_环境与外部依赖.md`。

---

## 9. GitHub 共建（2026-09-03 起）

- 本工作区已公开于 **GitHub `EC90/stormworks-knowledge`**（[`README.md`](README.md) 顶部有入口），
  许可 **CC BY-NC-SA 4.0**（[`LICENSE`](LICENSE)），共建流程见 [`CONTRIBUTING.md`](CONTRIBUTING.md)。
- **版本库即 `<WS>` 本体**（`.git` 在 `<WS>` 根）：日常改动走
  `git add -A && git commit -m "中文一句话说明" && git push origin main`。
- **提交前纪律**：
  - `.gitignore` 排除集**不得 force-add 绕过**：`_tools\`、`pony IDE\`、`.workbuddy\`（记忆日志/自动化）、
    `.workbuddy-ai\`、`工作区导航\路径配置.json`（本机实测路径）、`_work\`、`*.dmp`、`*.lnk`。
  - 文档与脚本**只写占位符**（§0），禁止提交带本机用户名/盘符的绝对路径；个人实测值记录在
    `工作区导航\04_环境与外部依赖.md` §7（全工作区唯一写真路径处）。
  - §7 的记忆日志与工作记录是**本机私有**，不入库；克隆端协作者在自己的 `.workbuddy\` 各记各的。
- **远端维护**：不对 `main` force push；协作者经 fork + PR 合入（分支保护按需在 GitHub 开启）。
- 首次推送/重新认证：`gh auth login`（或见 §8 下解释器说明外，gh CLI 放 `<WS>\_tools\gh-cli\`，已在排除集）。

**回复语言：简体中文。**
