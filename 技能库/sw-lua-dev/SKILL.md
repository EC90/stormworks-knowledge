---
name: sw-lua-dev
description: 写/改 Stormworks 载具 Lua（MC 微控制器与脚本方块）的游戏外开发链：源码编写约定、字符压缩构建（storm-lua-minify）、静态检查（sw_lua_lint）、XML 属性安全化（sw_lua_xmlsafe）、无头模拟（Fengari）与屏幕渲染核对。当用户要写游戏内 Lua、报字符超限、要在进游戏前验证 onTick/onDraw 行为或核对 HUD 画面时使用。
agent_created: true
---

# sw-lua-dev · Stormworks 载具 Lua 游戏外开发链

> 📌 **路径占位符（因机器而异，先解析再用）**：
> `<WS>` = 工作区根（`D:\STORMWORKS`）、`<HOME>` = 用户主目录（**含用户名**）、
> `<PY>` = 纯标准库 Python、`<PYN>` = numpy/PIL 解释器（值见 `工作区导航\04_环境与外部依赖.md` §7，
> 或 `python "<WS>/工作区导航/脚本/sw_paths.py"` 解析）。
> 本技能根目录 = `<WS>\技能库\sw-lua-dev\`，下文称 `<SK>`。

## 定位

VS Code 的 LifeBoatAPI 扩展证明了「游戏外写 Lua → 工具压缩 → 进游戏」这条路的正确性，
但它绑定 VS Code，agent 用不了。本技能把同样（以及更多）的能力做成**命令行工具**，供任何
vibecoding harness 调用：

| LifeBoatAPI 功能 | 本技能等价物 |
| --- | --- |
| IntelliSense / API 提示 | 工作区知识册 `数据库\Lua\`（00_速查、01_addon 速查、Lua示例 10 篇）——写码前先读，本技能不重复 |
| Minimizer（压缩到字符上限） | `npx storm-lua-minify`（v0.9.1，MIT，独立 CLI） |
| Combiner（require 多文件） | 同上（默认内联展开，`-m` 接近原生 Lua 语义） |
| 调试器 / 模拟器 | `<SK>\harness\`：Fengari 无头跑 tick + 绘制指令渲染成 PNG 供 agent 目检 |
| —（LifeBoat 没有的） | `sw_lua_lint.py`：游戏沙盒特有错误 + 本工作区 XML 注入纪律的静态检查 |

## 适用场景

- 要写新的载具 Lua（MC 微控制器组件或脚本方块），从源码到可粘贴/可注入产物
- 现有脚本超字符上限，需要自动压缩
- 进游戏前想验证逻辑（喂输入序列跑 N tick）或核对屏幕画面（渲染 PNG 目检）
- 读到工坊压缩 Lua 想改：先重建源码工程，改完再压缩

## 领域硬规则（写码前核对，违者基本是隐蔽 bug）

> 全部细节与出处见 `数据库\Lua\lua总体设定\00_速查_SW_Lua与常规Lua差异.md`，此处只列必查项。

1. **源码仅 ASCII**：中文/日文/全角字符乃至**反斜杠 `\` 都非法**（注释也算）。换行用
   `string.char(10)`，特殊字符用 `string.char(n)`。中文上屏走 unicode 后端（05_屏幕绘图 §7）。
2. **字符上限**：MC 微控制器 **4096**；脚本方块 **8192**。lint 默认按 4096 卡，脚本方块传 `--limit 8192`。
3. **onTick 与 onDraw 严格互斥**：onTick 只碰 `input/output`，onDraw 只碰 `screen`；
   数据用脚本级变量中转；onDraw 开头做 nil 守卫（首帧 onTick 可能还没跑）。
4. **`math.atan2` 不存在**；`math.atan` 支持 1 或 2 参数（两参等价 atan2）。工坊惯用 `M=math`
   别名，lint 按「任意标识符.atan2」抓。
5. **角度单位红线**（AGENTS.md §6）：物理传感器复合输出 ch4-6 欧拉角是**弧度**（直接喂
   sin/cos）；雷达方位/仰角等是**圈**（须 ×2π）。matrix.rotationX/Y/Z 用弧度。
6. **多人不同步**：脚本级变量在 server/client 各跑一份，状态记忆必须走复合信号或 Memory 方块；
   `math.random()` 双端不同序列。
7. **`#`/`ipairs` 只对 1 起始连续表安全**：遍历 SW API 返回表用 `pairs` + 计数函数。
8. **多返回值加括号**：`(f(x))` 只取首值，否则布尔污染后续参数。
9. **HTTP 仅本机**：`async.httpGet(port, url)` + `httpReply(port, request, reply)`，
   URL 以 `/` 开头、长度 <4000（超约 4096 游戏崩溃），每 tick 只发 1 个。
10. **XML 注入纪律**（AGENTS.md §6）：产物若经 `sw-vehicle-xml` 直接写进载具 XML 属性，
    禁 `" < &`（`<` 连注释都不能有，比较一律写 `>` 方向）；仅经游戏内编辑器粘贴则不受此限。
    两个目的地决定 lint 的 `--dest` 参数。
11. **screen API 名称是 Stormworks 专有的**（通用 LLM 不认识）：`setColor(r,g,b[,a])`（第 4 参
    alpha）、`getWidth/getHeight`（每帧在 onDraw 内取，尺寸勿写死）、`drawClear`、`drawLine`、
    `drawRect/drawRectF`、`drawCircle/drawCircleF`、`drawTriangle/drawTriangleF`、`drawText`、
    `drawTextBox`。屏幕 Y 轴向下。全部清单见 00_速查 §16。
12. **超时**：onTick/onDraw 单次 >16ms 拖慢游戏、>100ms 该次被丢弃；重活分 tick 做。

## 标准管线（新脚本从零到进游戏）

```bash
SK="<WS>/技能库/sw-lua-dev"
PY="<PY>"                    # 纯标准库解释器即可

# 0) 工程约定：源码放 <WS>\_work\lua\<项目>\src\（多文件 + require 随意，开发期不受 XML 纪律约束）

# 1) 写码时随手检查（源码阶段；--dest paste 时 < " & 不算错）
"$PY" "$SK/scripts/sw_lua_lint.py" <src/main.lua> --stage source

# 2) 语法兜底（Fengari 编译级校验，比正则强；见下「模拟器」节）
node "$SK/harness/sw_sim.js" <src/main.lua> --check

# 3) 压缩构建（首跑需联网下载包；产物生成在源文件旁：*.min.lua + *.lua.map）
npx -y storm-lua-minify <src/main.lua> --runtime-profile stormworks \
    --required-whitespace space --source-mapping-url-style line
#    多文件工程：入口写 require('./mod')，加 -m 让 require 以函数语义运行（更接近原生 Lua）

# 4) XML 属性安全化（引号归一 + 删 map 注释）；残留 < & 会报错并要求回源码修
"$PY" "$SK/scripts/sw_lua_xmlsafe.py" <src/main.min.lua> --strip-map-comment

# 5) 终检（final 阶段 + XML 纪律 + 字符上限闸；MC=4096 / 脚本方块=8192 传 --limit）
"$PY" "$SK/scripts/sw_lua_lint.py" <src/main.min.xmlsafe.lua> --stage final --json

# 6) 无头模拟（场景 JSON 喂输入，跑 N tick，导出输出时序 + 绘制指令）
node "$SK/harness/sw_sim.js" <main.min.xmlsafe.lua> <scenario.json> -o report.json

# 7) 画面核对（渲染 PNG 后用 Read 工具目检——agent 版「看屏幕」）
"$PYN" "$SK/harness/render_drawlist.py" report.json --outdir <png目录>

# 8) 进游戏：粘贴到游戏内编辑器；或经 sw-vehicle-xml 技能注入载具 XML（先备份到 _work\，改后必须 grep 复核）
```

多文件工程模板（entry 按需换名）：

```bash
cd "<WS>/_work/lua/<项目>/src"
npx -y storm-lua-minify main.lua -m --runtime-profile stormworks --required-whitespace space
```

## 工具明细

### sw_lua_lint.py（纯标准库）

`python sw_lua_lint.py <file.lua>... [--stage source|final] [--dest xml|paste]
[--limit 4096] [--margin N] [--strict] [--json]`

检查项：非 ASCII、反斜杠、`.atan2`、`os./io.`、final 残留 `require(`、onTick 内调 `screen.*`
与 onDraw 内调 `input/output.*`（按关键字配对做块扫描，启发式）、httpGet URL 长度估算、
字符数门槛、`--dest xml` 时的 `"<&` 纪律、final 尾部 map 注释字符开销。
退出码 0=过 / 1=有 ERROR（`--strict` 时 WARN 也算）。`--json` 供 agent 程序化读取。

### sw_lua_xmlsafe.py（纯标准库）

`python sw_lua_xmlsafe.py <in.lua> [-o out.lua] [--strip-map-comment] [--json]`
双引号字面量→单引号（内容含 `'` 或 `\` 的不动并报告）；可删尾部 sourceMappingURL 注释；
报告残留 `< &`（这两个只能回源码修）。产物默认 `<名>.xmlsafe.lua`。

### harness/sw_sim.js（需要 Node + fengari，见下）

`node sw_sim.js <script.lua> [--check | <scenario.json> [-o report.json] [--draw-ticks last|all|1,5,9] [--budget N]]`

- `--check`：只编译（语法级校验，捕获 lint 抓不到的语法错）。
- 沙盒：白名单全局（base 的安全子集 + math/table/string + 游戏对象），删 io/os/package/loadfile/dofile。
- 指令预算 `--budget`（默认 2e8 条/tick 回调）防死循环挂死。
- 报告 JSON：每 tick 的 output 时序、http 应答、错误（含 Lua 行号）、绘制指令
  （默认只存最后一个 draw tick，`--draw-ticks all` 全存）。

### harness/render_drawlist.py（需要 `<PYN>`，PIL）

`python render_drawlist.py <report.json> [--outdir <目录>] [--tick N] [--scale 4]`
把绘制指令渲染成每显示器一张 PNG（黑底、按 setColor 上色、drawText 用默认位图字体）。
渲染器是**近似**：游戏端反锯齿/字型不同，只用于构图与逻辑核对，不是像素级真相。

## 模拟器的语义与假设（读再用）

| mock 项 | 语义 | 假设/限制 |
| --- | --- | --- |
| `input.getNumber/getBool(i)` | 取自场景 JSON `inputs[]`（不足 tick 数时重复末项） | 通道号从 1 起 |
| `output.setNumber/setBool(i,v)` | 记录进报告时序 | — |
| `property.getNumber/getBool/getText` | 场景 `properties`（按索引或名） | 游戏内是属性滑块 |
| `screen.*` | 全部记录为绘制指令；`getWidth/getHeight` 回当帧显示器尺寸 | 多显示器=每 tick 逐台调用（与游戏一致） |
| `map.mapToScreen/screenToMap` | 线性换算，`scale`/`flip_y` 场景可配 | 真实换算以游戏内地图件为准 |
| `async.httpGet` → `httpReply` | 场景 `http[]` 按 URL 前缀给罐头应答，每 tick 派发 1 个 | 无罐头时回 `connect(): Connection refused`（与游戏一致） |
| `g_time` | tick × 16.67 ms | 近似值，游戏按实际帧率计 |

## 依赖与退化路径

- **npx storm-lua-minify**：首跑需联网；此后走 npm 缓存。离线退化：知识册
  `Lua示例\01_基础惯用法与字数压缩.md` 的手工压缩 + 本技能 lint 仍可用。
- **harness**：`cd <SK>/harness && npm install`（装 fengari 到本地 node_modules，不污染全局；
  node_modules 不入库）。Node 任意近期版本（本机 v24 实测）。
- **渲染**：`<PYN>` 无则跳过目检，仅看报告 JSON。

## 边界（不要越权）

- 本技能管「写得对、放得下、模拟得过」；**数值与部件行为权威性仍归** `sw_defs.py`（🎮）与知识册。
- 模拟通过 ≠ 游戏内实测通过：双端执行、帧率、真实地图/触控行为只能进游戏验证。
  交付说明里要写「已过 lint+模拟，未经游戏内实测」。
- 读工坊压缩 Lua 时先按 00_速查 §14.1 反压缩，不要直接在本技能管线里塞 minified blob。
