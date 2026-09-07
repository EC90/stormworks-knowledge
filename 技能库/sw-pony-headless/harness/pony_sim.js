#!/usr/bin/env node
'use strict';
/*
 * sw-pony-headless · Pony IDE 无头模拟渲染器
 *
 * 复用 Pony IDE 快照的 paint.js（游戏同款渲染）+ stormworks_lua_api.js（API 语义）
 * + lua_emulator.js（沙盒/超时/bluescreen），在 Node 里跑 onTick/onDraw 并把
 * 屏幕绘制结果编码为 PNG。不依赖浏览器、不需要前台标签页。
 *
 * 用法：
 *   node pony_sim.js <script.lua> [--check] [<scenario.json>] [-o report.json]
 *       [--draw-ticks last|all|1,5,9] [--monitor 288x160|9x5|5x3|...] [--ticks N]
 *       [--zoom 3] [--ide-src <editor-master/src/scripts>] [--png-dir <dir>] [--quiet]
 *
 * 场景 JSON 与 sw-lua-dev 的 sw_sim.js 对齐：
 *   { ticks, tick_ms, monitors:[{w,h}] | monitor:"9x5", properties:{},
 *     inputs:[ {numbers:{"1":0.25}, bools:{"3":true}} ], }
 *   async.httpGet 走原实现（直连本机端口），不提供罐头应答。
 */
const fs = require('fs');
const path = require('path');
const vm = require('vm');
const { createCanvas, loadImage } = require('@napi-rs/canvas');
const { buildSandbox } = require('./stubs');

// ---------- CLI ----------
const argv = process.argv.slice(2);
function argVal(name) {
  const i = argv.indexOf(name);
  return i >= 0 && i + 1 < argv.length ? argv[i + 1] : undefined;
}
const scriptPath = argv.find((a) => !a.startsWith('--') && path.extname(a) === '.lua');
if (!scriptPath || argv.includes('--help') || argv.includes('-h')) {
  console.error('usage: node pony_sim.js <script.lua> [--check] [<scenario.json>] [-o report.json]\n' +
    '  [--draw-ticks last|all|1,5,9] [--monitor 288x160|9x5|...] [--ticks N] [--zoom 3]\n' +
    '  [--ide-src <editor-master/src/scripts>] [--png-dir <dir>] [--quiet]');
  process.exit(2);
}
const checkOnly = argv.includes('--check');
const scenarioPath = checkOnly ? undefined : argv.find((a) => !a.startsWith('--') && path.extname(a) === '.json');
const outReport = argVal('-o') || argVal('--out');
const drawTicksArg = argVal('--draw-ticks') || 'last';
const monitorArg = argVal('--monitor');
const ticksArg = argVal('--ticks');
const zoomArg = parseInt(argVal('--zoom') || '3', 10);
const pngDirArg = argVal('--png-dir');
const quiet = argv.includes('--quiet');
const ideSrcArg = argVal('--ide-src') || process.env.PONY_IDE_SRC;

// ---------- 定位 Pony IDE 快照源文件 ----------
function findIdeSrc() {
  if (ideSrcArg) return path.resolve(ideSrcArg);
  // 默认：<WS>/pony IDE/editor-master/src/scripts（本工具位于 <WS>/技能库/sw-pony-headless/harness）
  const guess = path.resolve(__dirname, '..', '..', '..', 'pony IDE', 'editor-master', 'src', 'scripts');
  return guess;
}
const ideSrc = findIdeSrc();
const needFiles = ['paint.js', 'stormworks_lua_api.js', 'lua_emulator.js'];
for (const f of needFiles) {
  if (!fs.existsSync(path.join(ideSrc, f))) {
    console.error(`ERROR: 找不到 Pony IDE 源文件 ${f}\n  ide-src = ${ideSrc}\n` +
      '  用 --ide-src 或环境变量 PONY_IDE_SRC 指向 editor-master/src/scripts');
    process.exit(2);
  }
}
const assetsDir = path.resolve(ideSrc, '..', '..'); // editor-master/
const fontPath = path.join(assetsDir, 'fonts', 'CG_pixel_4x5_mono.ttf');
const mapPath = path.join(assetsDir, 'images', 'map.png');

// ---------- 场景 ----------
const scriptAbs = path.resolve(scriptPath);
const luaCode = fs.readFileSync(scriptAbs, 'utf8');
const scenario = scenarioPath
  ? JSON.parse(fs.readFileSync(path.resolve(scenarioPath), 'utf8'))
  : {};
const MONITOR_SIZES = {
  '1x1': [32, 32], '2x1': [64, 32], '2x2': [64, 64], '3x1': [96, 32], '3x2': [96, 64],
  '3x3': [96, 96], '5x3': [160, 96], '8x6': [256, 192], '9x5': [288, 160],
};
let monitorW = 288, monitorH = 160;
if (monitorArg) {
  if (MONITOR_SIZES[monitorArg]) { [monitorW, monitorH] = MONITOR_SIZES[monitorArg]; }
  else { const m = monitorArg.split('x'); monitorW = +m[0]; monitorH = +m[1]; }
} else if (scenario.monitor && MONITOR_SIZES[scenario.monitor]) {
  [monitorW, monitorH] = MONITOR_SIZES[scenario.monitor];
} else if (Array.isArray(scenario.monitors) && scenario.monitors.length) {
  [monitorW, monitorH] = [scenario.monitors[0].w, scenario.monitors[0].h];
}
const ticks = checkOnly ? 0 : (ticksArg ? parseInt(ticksArg, 10) : (scenario.ticks || 1));
const zoom = Math.max(1, Math.min(10, zoomArg || 3));

// ---------- 组装沙盒并加载 Pony IDE 源文件 ----------
const outputsByTick = new Map(); // tick -> {numbers:{}, bools:{}}
const { sandbox, state, CANVAS, CONSOLE, LOADER, frameCanvas } = buildSandbox({
  monitorW, monitorH, zoom, scenario,
  quiet,
  fontPath,
  onOutput: (tick, ch, kind, v) => {
    const o = outputsByTick.get(tick) || { numbers: {}, bools: {} };
    o[kind === 'bool' ? 'bools' : 'numbers'][ch] = v;
    outputsByTick.set(tick, o);
  },
});

(async function main() {
  // 地图图片需同步可用：先 await loadImage 再注入假 jQuery（map.js 的 $('#map').get(0)）
  const mapImage = fs.existsSync(mapPath) ? await loadImage(mapPath) : null;
  sandbox.$ = makeJQuery(mapImage);
  sandbox.jQuery = sandbox.$;

  const context = vm.createContext(sandbox);
  for (const f of needFiles) {
    const src = fs.readFileSync(path.join(ideSrc, f), 'utf8');
    vm.runInContext(src, context, { filename: f });
  }
  const LUA_EMULATOR = sandbox.LUA_EMULATOR;
  const fengari = sandbox.fengari;

  // 网页版由 ENGINE 调 reset()：newstate + openlibs + 沙盒删库 + init()（注册 print 与全部游戏 API）
  await LUA_EMULATOR.reset();
  const L = LUA_EMULATOR.l();
  sandbox.PAINT.setZoomFactor(zoom); // 放大绘制坐标到物理画布（paint.js 模块级变量）

  // 注入用户代码（等价于网页版 engine.js 的 fengari.load + pcall）
  const loadErr = loadUserCode(L, fengari, luaCode);
  if (loadErr) {
    reportAndExit({ ok: false, stage: 'load', error: loadErr });
  }
  if (checkOnly) {
    console.error('✔ 编译通过（Fengari / Lua 5.3）');
    process.exit(0);
  }

  // 主循环：每 tick 一次 onTick + 一次 onDraw（对齐 Pony IDE / 游戏 交替语义）
  const drawTicks = parseDrawTicks(drawTicksArg, ticks);
  const pngDir = pngDirArg ? path.resolve(pngDirArg) : path.join(path.dirname(scriptAbs), 'pony_sim_out');
  fs.mkdirSync(pngDir, { recursive: true });
  const frames = [];
  let stoppedAtTick = null;

  for (let t = 1; t <= ticks; t++) {
    state.idx = t;
    LUA_EMULATOR.tick();
    if (state.errorStopped) { stoppedAtTick = t; break; }
    LUA_EMULATOR.draw();
    if (state.errorStopped) { stoppedAtTick = t; break; }
    if (drawTicks.has(t)) {
      frames.push(await saveFrame(pngDir, t));
    }
  }
  // 错误蓝屏由 500ms setTimeout 画出；等它完成再截最终帧
  if (state.errorStopped) {
    await new Promise((r) => setTimeout(r, 700));
    frames.push(await saveFrame(pngDir, 'bluescreen'));
  }

  reportAndExit({
    ok: !state.errorStopped,
    script: scriptAbs,
    scenario: scenarioPath ? path.resolve(scenarioPath) : null,
    monitor: `${monitorW}x${monitorH}@${zoom}x`,
    ticks: ticks,
    stoppedAtTick,
    errors: state.luaError ? [state.luaError] : [],
    prints: CONSOLE.lines,
    outputs: Array.from(outputsByTick.entries())
      .sort((a, b) => a[0] - b[0])
      .map(([tick, o]) => ({ tick, ...o })),
    frames,
  });
})().catch((e) => { console.error('FATAL:', e); process.exit(3); });

// ---------- 工具函数 ----------
function makeJQuery(mapImage) {
  return function (sel) {
    if (sel === '#map' && mapImage) return { get: () => mapImage };
    const chain = { get: () => null, prop: () => chain, on: () => chain, each: () => chain, addClass: () => chain };
    return chain;
  };
}

function loadUserCode(L, fengari, code) {
  const { lua, lauxlib, to_luastring } = fengari;
  lua.lua_settop(L, 0);
  const chunk = to_luastring(code);
  const rc = lauxlib.luaL_loadbuffer(L, chunk, chunk.length, to_luastring('=<user_script>'));
  if (rc !== 0) {
    return { line: firstLine(lua.lua_tostring(L, -1)), err: fengari.to_jsstring(lua.lua_tostring(L, -1)) };
  }
  if (lua.lua_pcall(L, 0, 0, 0) !== 0) {
    return { line: firstLine(lua.lua_tostring(L, -1)), err: fengari.to_jsstring(lua.lua_tostring(L, -1)) };
  }
  lua.lua_settop(L, 0);
  return null;
}

function firstLine(msg) {
  const m = String(msg).match(/:(\d+):/);
  return m ? parseInt(m[1], 10) : null;
}

function parseDrawTicks(arg, ticks) {
  if (arg === 'all') return new Set(Array.from({ length: ticks }, (_, i) => i + 1));
  if (arg === 'last' || !arg) return new Set([ticks]);
  return new Set(arg.split(',').map((s) => parseInt(s.trim(), 10)).filter((n) => n >= 1 && n <= ticks));
}

async function saveFrame(pngDir, tick) {
  const out = createCanvas(frameCanvas.width, frameCanvas.height);
  const octx = out.getContext('2d');
  octx.fillStyle = '#000';           // 游戏内屏幕黑底（画布上未绘制区域是透明的）
  octx.fillRect(0, 0, out.width, out.height);
  octx.drawImage(frameCanvas, 0, 0);
  const file = path.join(pngDir, `frame_${tick}.png`);
  fs.writeFileSync(file, out.toBuffer('image/png'));
  return { tick, file };
}

function reportAndExit(result) {
  const payload = JSON.stringify(result, null, 2);
  if (outReport) {
    fs.writeFileSync(path.resolve(outReport), payload);
    if (!quiet) console.error(`✔ 报告 → ${path.resolve(outReport)}`);
  } else {
    console.log(payload);
  }
  if (!quiet && result.frames) {
    console.error(`✔ 帧 ${result.frames.length} 张 → ${path.dirname(result.frames[0]?.file || '.')}`);
  }
  process.exit(result.ok ? 0 : 1);
}
