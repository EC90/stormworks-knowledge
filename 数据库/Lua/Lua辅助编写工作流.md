# Lua 辅助编写标准工作流（AI SOP）

> **定位**：AI 辅助用户编写/修改 Stormworks **游戏内 Lua**（脚本 Lua / 微控）的端到端流程。
> 与 `AGENTS.md` §6（硬约束）、`Lua示例\README.md`（知识入口）、`技能库\sw-lua-dev\SKILL.md`（技术管线）配合使用；
> 内容冲突时以 AGENTS.md 与各上游文件为准。
>
> **三条设计原则**（执行中随时自查）：
> ① **范例优先**——先找现成范例照搬/修改，没有合适范例才从零手写；
> ② **工具优先**——能用脚本工具的环节一律用工具，不靠模型记忆与手搓；
> ③ **按需读取**——每阶段只读「最小文件集」，定点读节，不全量读大文件（省 token、防幻觉）。

---

## 流程总览

```
需求 → ①定界 → ②范例检索 ──命中──→ 照搬/修改 ──→ ③验证 ──→ ④交付
                      └─未命中→ ②'按规程编写 → ③验证 → ④交付
```

---

## ① 需求定界（写一行代码前必须完成）

读 `数据库\Lua\Lua示例\00_AI写作指导.md` §1，回答 5 问：**脚本 Lua 还是附加 Lua、
要不要多人同步、要不要画屏、通道怎么分（先列通道表）、角度是圈还是弧度**。

- 产出：**通道规划表**（ASCII，后续写进代码顶部注释）；拿不准的问用户，其余不问。
- 需要与具体部件对接时，**查权威数据，不凭记忆**：
  - 部件规格/逻辑节点：`python "<WS>\数据库\方块数据\脚本\sw_defs.py" get "<部件游戏内英文名>"`
  - 部件下拉选项枚举（属性代号→文本）：`技能库\sw-property-options\`
  - 中英部件名互译：`汉化相关\脚本\sw_lookup.py`（先 `sw_check.py --auto`）
  - Lua API 清单以 `lua总体设定\00_速查_SW_Lua与常规Lua差异.md` §16 为准，**禁止自创/臆造 API**。

## ② 范例检索（先照搬，后手写——按此优先序）

### 2.1 工作区例题库（首选，最快最省）

`数据库\Lua\Lua示例\README.md` 的索引表按「**什么时候查**」列对号入座，
**只打开命中的分类文件、只读命中的 §**（每篇例题 § 标题即手法名）。
命中即照搬/组合修改——例题全部来自工坊实测并已在本工作区校正过。

### 2.2 工坊订阅物（只读红线，只检索不改动）

```bash
# 按 API/关键词搜载具 XML（Lua 在属性里，可能是压缩过的）
rg -l --no-messages "drawTextBox|setMapColor" "<SW_WORKSHOP>" -g "*.xml"
# 按物品名找创意工坊 id：<id>\language.tsv；命中后按 技能库\sw-vehicle-xml 技能解包 Lua 属性
```

读到的工坊压缩代码先按 `Lua示例\01_基础惯用法与字数压缩.md`（反压缩节）还原再改，
不要直接在压缩 blob 上修改。工坊无订阅（目录不存在）时跳过此级。

### 2.3 外部来源（前两级未命中才走）

Fandom wiki 检索走 `技能库\stormworks-fandom-kb\`（本地库，离线）；
外部 GitHub 用代码搜索（`gh search code "stormworks screen.drawText" --language lua` 或 WebSearch）。
社区代码可信度低于 2.1/2.2，照搬前必须过阶段③验证。

**命中 → 携带出处进入阶段③（验证不可省）；未命中 → 进入阶段②'。**

## ②' 编写（无合适范例时）

- 骨架与决策：照 `00_AI写作指导.md` §2 骨架模板起笔（通道表注释在最顶）。
- 硬规则：`技能库\sw-lua-dev\SKILL.md`「领域硬规则」逐条核对
  （仅 ASCII / onTick·onDraw 分离 / atan 两参 / 圈与弧度 / `#`·ipairs 限制 / 多返回值加括号 /
  httpGet 限本机限长 / XML 注入纪律 / 单次 onTick·onDraw ≤16ms 等）。
- 源码工程放 `<WS>\_work\lua\<项目>\src\`，多文件用 require，开发期不受 XML 字符纪律约束。
- **禁止**：凭记忆写 screen/server API；把中文写进源码；在 onDraw 里做有副作用的计算。

## ③ 验证（按脚本类型选工具；工具链在 `技能库\`）

| 脚本类型 | 必做 | 命令（`<SK>` = `技能库\sw-lua-dev`，`<PH>` = `技能库\sw-pony-headless\harness`） |
| --- | --- | --- |
| 全部 | lint（静态） | `"$PY" "<SK>/scripts/sw_lua_lint.py" <main.lua> --stage source --dest <paste\|xml>` |
| 全部 | 编译校验 | `node "<PH>/pony_sim.js" <main.lua> --check` |
| 逻辑/控制类 | 场景模拟看输出时序 | `node "<SK>/harness/sw_sim.js" <main.lua> <scenario.json> -o report.json` |
| **HUD/触屏 UI/画屏类** | **游戏同款画面出图 + AI 目检** | `node "<PH>/pony_sim.js" <main.lua> <scenario.json> --zoom 3 --png-dir <outdir> -o report.json` → Read PNG 逐项核对（构图/溢出/对比/触屏反馈），改码回炉 |
| 超字符上限 | 压缩 | `npx -y storm-lua-minify <main.lua> --runtime-profile stormworks ...`（MC 4096 / 脚本方块 8192） |
| 坐标/弹道解算 | 离线数值仿真 | 用 Python 复刻 Lua 逻辑多姿态验证（AGENTS.md §6）后再交付 |

- 验证工具的语义边界见各自 SKILL.md；**模拟通过 ≠ 游戏内通过**，交付说明必须带此声明。
- 失败两次同一方案 → 换思路或如实报告（AGENTS.md 执行纪律）。

## ④ 交付（按用户需求二选一）

### A. 贴码模式（默认，用户自行粘进游戏内编辑器）

- 产物为单个 `.lua`（已过 lint `--dest paste`，纯 ASCII 保证可直接粘）；
- 交付说明：通道表 + 需要的 property 清单 + 「已过 lint/模拟，未经游戏内实测」。

### B. XML 注入模式（用户明确要求改载具文件/存档载具）

1. 先读 `技能库\sw-vehicle-xml\SKILL.md`（结构、序列化、编辑纪律）；
2. 备份原文件到 `<WS>\_work\`（存档载具 `<SW_SAVE>\data\vehicles\*.xml` 同规矩）；
3. 产物过 `sw_lua_xmlsafe.py`（双引号归一、`<`/`&` 残留报错回源码修）+ lint `--stage final --dest xml`；
4. 注入后 **ET 验 well-formed + grep 复核**；同一载具多 Lua 块按 **object id 精确限定作用域**，
   严禁按函数名全局替换。

---

## 附：工具速查（目的 → 命令/位置）

| 目的 | 用什么 |
| --- | --- |
| 写前决策/骨架/自检清单/错误速查 | `数据库\Lua\Lua示例\00_AI写作指导.md`（§1/§2/§5/§4） |
| 例题检索 | `数据库\Lua\Lua示例\README.md` 索引表 |
| 部件权威规格 | `数据库\方块数据\脚本\sw_defs.py` |
| 部件下拉枚举 | `技能库\sw-property-options\` |
| 术语互译 | `汉化相关\脚本\sw_check.py --auto` → `sw_lookup.py` |
| 静态检查 | `技能库\sw-lua-dev\scripts\sw_lua_lint.py` |
| XML 安全化 | `技能库\sw-lua-dev\scripts\sw_lua_xmlsafe.py` |
| 逻辑无头模拟 | `技能库\sw-lua-dev\harness\sw_sim.js` |
| 画面无头出图 | `技能库\sw-pony-headless\harness\pony_sim.js` |
| 载具 XML 读写纪律 | `技能库\sw-vehicle-xml\SKILL.md` |
| 附加(addon) Lua | `数据库\Lua\lua总体设定\01_addon_Lua_API速查.md`（本流程的①需先判定） |
