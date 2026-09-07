# sw-pony-headless · Pony IDE 无头模拟渲染器

> 📌 路径占位符：`<WS>` = 工作区根（`D:\STORMWORKS`）。
> 本技能根目录 = `<WS>\技能库\sw-pony-headless\`，下称 `<SK>`。

## 定位

把 Pony IDE（`<WS>\pony IDE\editor-master\`，CrazyFluffyPony 的 Stormworks 浏览器端 Lua IDE
快照）的**游戏同款渲染能力**剥离网页前端，做成 AI 直调的命令行工具：

- **输入**：Lua 脚本 + 场景 JSON（输入通道时序、property、显示器尺寸、tick 数）
- **输出**：游戏同款渲染 PNG 帧 + tick 级 output/console/错误报告（JSON）

渲染与 API 语义**原样复用** Pony IDE 快照源码（零改动，只读引用）：
`paint.js`（1.4px 线宽、圆 8/12/16 段折线近似、drawTextBox 换行、游戏同款点阵字体
`CG_pixel_4x5_mono.ttf`）+ `stormworks_lua_api.js`（screen/input/output/property/map/async
全部语义与 onTick/onDraw 上下文守卫）+ `lua_emulator.js`（沙盒删库、指令钩、1000ms 超时、
bluescreen）。`harness/stubs.js` 只实现它们的 DOM 中间层（CANVAS→@napi-rs/canvas、
INPUT/OUTPUT/PROPERTY→场景驱动、假 jQuery/LOADER）。

**与 `sw-lua-dev` 的 `sw_sim.js` 分工**：

| | sw_sim.js（Fengari 无头） | pony_sim.js（本工具） |
| --- | --- | --- |
| 批量验证逻辑/输出时序 | ✅ 主力 | ✅ 同样可用（场景格式对齐） |
| 画面核对可信度 | PIL 近似渲染，非像素真相 | **游戏同款字体/线宽/折线**，构图核对可信 |
| 依赖 | fengari | fengari + fengari-interop + @napi-rs/canvas |
| 浏览器 | 无 | **无**（这是与 Pony IDE 网页版的本质区别） |

## AI 工作流配方（用户提需求 → 呈现 HUD/UI 成图）

```bash
SK="<WS>/技能库/sw-pony-headless"
PY="<PY>"

# 1) 写 HUD/UI Lua 到 <WS>\_work\lua\<项目>\src\，随手过 lint（--dest paste）
"$PY" "<WS>/技能库/sw-lua-dev/scripts/sw_lua_lint.py" <main.lua> --stage source --dest paste

# 2) 语法校验（可选）
node "$SK/harness/pony_sim.js" <main.lua> --check

# 3) 无头模拟 + 出图：场景 JSON 喂输入时序，指定 tick 出帧
node "$SK/harness/pony_sim.js" <main.lua> <scenario.json> --zoom 3 --png-dir <outdir> -o <report.json>

# 4) AI 目检 PNG（Read 工具读图）：构图/溢出/对比度/触屏反馈逐项核对，改码回到 1)
# 5) 交付：把最终帧 PNG 呈现给用户 + 说明已过 lint/模拟、未经游戏内实测
```

## 命令与场景格式

```bash
node pony_sim.js <script.lua> [--check] [<scenario.json>] [-o report.json]
    [--draw-ticks last|all|1,5,9] [--monitor 288x160|9x5|5x3|1x1|2x2|3x3|8x6]
    [--ticks N] [--zoom 1..10（默认 3）] [--png-dir <dir>] [--quiet]
    [--ide-src <editor-master/src/scripts>]   # 或环境变量 PONY_IDE_SRC
```

场景 JSON（与 `sw_sim.js` 对齐，inputs 不足 tick 数时重复末项）：

```json
{
  "ticks": 30,
  "monitor": "9x5",
  "properties": { "Bar Color": 0.5 },
  "inputs": [
    { "numbers": { "5": 0.25, "6": 0.7 }, "bools": {} },
    { "numbers": { "5": 0.25, "6": 0.7, "1": 0.236, "2": 0.906 }, "bools": { "3": true } }
  ]
}
```

- 触屏通道语义：ch1/2 = 触点 x/y（**0..1 归一化**），ch3 = 按下；ch4/5/6 = 第二触点。
- 报告 JSON：`ok / stoppedAtTick / errors[{line,err}] / prints / outputs[{tick,numbers,bools}] / frames`。
- 运行期错误自动截**蓝屏帧**（`frame_bluescreen.png`，蓝底白字带行号，与 Pony IDE 行为一致）。

## 硬规则与坑（继承 AGENTS.md §6 + 实测补充）

1. **语义对齐 Pony IDE/游戏**：每 tick 一次 `onTick` + 一次 `onDraw` 交替；`screen.*` 只能在
   onDraw、`input/output` 只能在 onTick 调用（原版守卫直接生效，违例即 bluescreen）。
2. **沙盒比游戏严**：Pony IDE 模拟器删 `pcall/_G/xpcall/load/error` 等（源码内定），模拟过≠游戏过。
3. **单显示器**：Pony IDE 一次只渲染一台（网页版同款）；多屏脚本用 sw_sim.js 验证。
4. **async.httpGet 直连本机端口**（原版语义），无罐头应答；要 mock 就自己起本地 HTTP 服务。
5. 交付说明必须写「已过 lint+模拟，未经游戏内实测」。
6. ide-src 默认探测 `<WS>/pony IDE/editor-master/src/scripts`；快照移动后用 `--ide-src` 指定。
7. 黑底是导出时垫的（游戏屏幕未点亮即黑）；`drawClear` 前的画面在游戏里同样是黑底透出。

## 依赖与安装

`harness\` 下 `npm install`（fengari + fengari-interop + @napi-rs/canvas，全部预编译无需
编译环境；首装需联网，此后走 npm 缓存）。Node ≥ 18。`node_modules` 不入库。
