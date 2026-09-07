#!/usr/bin/env node
/*
 * sw_sim.js — Stormworks 载具 Lua 无头模拟器（Fengari = 纯 JS 的 Lua 5.3 VM）。
 *
 * 用法：
 *   node sw_sim.js <script.lua> --check
 *   node sw_sim.js <script.lua> <scenario.json> [-o report.json]
 *                [--draw-ticks last|all|1,5,9] [--budget N]
 *
 * 沙盒语义（与游戏对齐的部分）：
 *   - Lua 5.3；math/table/string + base 安全子集；删除 io/os/package/loadfile/dofile。
 *   - print 仅模拟器有（记入报告，游戏内不可用）。
 *   - input/output/property/screen/map/async/g_time 语义见 SKILL.md「模拟器的语义与假设」。
 *   - 每个 tick 回调有指令预算（--budget，默认 2e8），超限报 SIM_BUDGET。
 *   - 未定义全局变量读取记入 warnings（抓拼写错）。
 *
 * 退出码：0 通过；1 有错误（编译失败 / 回调报错 / 预算超限）。
 */
'use strict';
const fs = require('fs');
const path = require('path');
const { lua, lauxlib, lualib, to_luastring, to_jsstring } = require('fengari');

// ---------- CLI ----------
const argv = process.argv.slice(2);
function argVal(flag) {
  const i = argv.indexOf(flag);
  return i >= 0 ? argv[i + 1] : undefined;
}
const scriptPath = argv[0];
if (!scriptPath) { console.error('usage: node sw_sim.js <script.lua> [--check | <scenario.json>] [-o out.json]'); process.exit(2); }
const checkOnly = argv.includes('--check');
const scenarioPath = checkOnly ? undefined : argv[1];
const outPath = argVal('-o');
const drawTicksArg = argVal('--draw-ticks') || 'last';
const budget = Number(argVal('--budget') || 2e8);

const src = fs.readFileSync(scriptPath, 'utf8');

// ---------- Lua state ----------
const L = lauxlib.luaL_newstate();
lualib.luaL_openlibs(L);
for (const g of ['io', 'os', 'package', 'loadfile', 'dofile', 'require']) {
  lua.lua_pushnil(L);
  lua.lua_setglobal(L, to_luastring(g));
}

// ---------- 场景 ----------
const scenario = scenarioPath
  ? JSON.parse(fs.readFileSync(path.resolve(scenarioPath), 'utf8'))
  : { ticks: 1, monitors: [{ w: 128, h: 64 }] };
const ticks = scenario.ticks || 1;
const tickMs = scenario.tick_ms || 1000 / 60;
const monitors = scenario.monitors && scenario.monitors.length ? scenario.monitors : [{ w: 128, h: 64 }];
const props = scenario.properties || {};
const inputsArr = Array.isArray(scenario.inputs) && scenario.inputs.length ? scenario.inputs : [{}];
const mapCfg = Object.assign({ scale: 1.0, flip_y: true }, scenario.map || {});
const httpRules = Array.isArray(scenario.http) ? scenario.http : [];

// ---------- 运行时记录 ----------
const report = { ok: true, script: path.resolve(scriptPath), ticks, errors: [], warnings: [], prints: [], outputs: [], http: [], draw_frames: [] };
const httpQueue = [];
let curMonitor = monitors[0];
let curColor = [255, 255, 255, 255];
let curOps = null;          // 当前显示器的绘制指令列表（null = 不记录）
const missingGlobals = new Set(['onTick', 'onDraw', 'httpReply']);
let budgetLeft = budget;

// ---------- 指令预算 hook ----------
const HOOK_COUNT = 100000;
try {
  lua.lua_sethook(L, function (Ls) {
    budgetLeft -= HOOK_COUNT;
    if (budgetLeft <= 0) {
      lauxlib.luaL_error(Ls, to_luastring('SIM_BUDGET: callback exceeded instruction budget (--budget ' + budget + ')'));
    }
  }, lua.LUA_MASKCOUNT, HOOK_COUNT);
} catch (e) {
  report.warnings.push('lua_sethook unavailable, budget guard disabled: ' + e.message);
}

// ---------- 帮助函数 ----------
function argNum(Ls, i, dflt) { return lua.lua_isnumber(Ls, i) ? Number(lua.lua_tonumber(Ls, i)) : dflt; }
function argStr(Ls, i, dflt) { return lua.lua_isstring(Ls, i) ? lua.lua_tojsstring(Ls, i) : dflt; }

function propLookup(Ls, kind, dflt) {
  const a = lua.lua_type(Ls, 1) === lua.LUA_TNUMBER ? String(Math.round(lua.lua_tonumber(Ls, 1))) : lua.lua_tojsstring(Ls, 1);
  const t = props[kind] || {};
  return a in t ? t[a] : dflt;
}

function recordOp(name) {
  return function (Ls) {
    const n = lua.lua_gettop(Ls);
    const args = [];
    for (let i = 1; i <= n; i++) {
      const t = lua.lua_type(Ls, i);
      if (t === lua.LUA_TNUMBER) args.push(Number(lua.lua_tonumber(Ls, i)));
      else if (t === lua.LUA_TSTRING) args.push(lua.lua_tojsstring(Ls, i));
      else if (t === lua.LUA_TBOOLEAN) args.push(!!lua.lua_toboolean(Ls, i));
      else args.push(null);
    }
    if (curOps) curOps.push({ fn: name, color: curColor.slice(), args });
    return 0;
  };
}
function pushRecorder(Ls, key) {
  lua.lua_pushcfunction(Ls, recordOp(key));
  return 1;
}

// ---------- 游戏对象 ----------
function libSet(name, funcs) {
  lua.lua_createtable(L, 0, Object.keys(funcs).length + 1);
  for (const [k, f] of Object.entries(funcs)) {
    lua.lua_pushcfunction(L, f);
    lua.lua_setfield(L, -2, to_luastring(k));
  }
  lua.lua_setglobal(L, to_luastring(name));
}

libSet('input', {
  getNumber: Ls => {
    const i = String(Math.round(argNum(Ls, 1, 1)));
    const cur = inputsArr[Math.min(tickIdx, inputsArr.length - 1)] || {};
    lua.lua_pushnumber(Ls, (cur.numbers || {})[i] || 0);
    return 1;
  },
  getBool: Ls => {
    const i = String(Math.round(argNum(Ls, 1, 1)));
    const cur = inputsArr[Math.min(tickIdx, inputsArr.length - 1)] || {};
    lua.lua_pushboolean(Ls, !!(cur.bools || {})[i]);
    return 1;
  },
});

libSet('output', {
  setNumber: Ls => {
    const i = String(Math.round(argNum(Ls, 1, 1)));
    const v = argNum(Ls, 2, 0);
    curOutputs.numbers[i] = v;
    return 0;
  },
  setBool: Ls => {
    const i = String(Math.round(argNum(Ls, 1, 1)));
    const v = !!(lua.lua_type(Ls, 2) === lua.LUA_TBOOLEAN && lua.lua_toboolean(Ls, 2));
    curOutputs.bools[i] = v;
    return 0;
  },
});

libSet('property', {
  getNumber: Ls => { lua.lua_pushnumber(Ls, propLookup(Ls, 'numbers', 0)); return 1; },
  getBool: Ls => { lua.lua_pushboolean(Ls, !!propLookup(Ls, 'bools', false)); return 1; },
  getText: Ls => { lua.lua_pushstring(Ls, to_luastring(propLookup(Ls, 'texts', ''))); return 1; },
});

// screen：已知函数 + __index 兜底录制任意未知 draw*
{
  lua.lua_createtable(L, 0, 14);
  const setf = (k, f) => { lua.lua_pushcfunction(L, f); lua.lua_setfield(L, -2, to_luastring(k)); };
  setf('getWidth', Ls => { lua.lua_pushnumber(Ls, curMonitor.w); return 1; });
  setf('getHeight', Ls => { lua.lua_pushnumber(Ls, curMonitor.h); return 1; });
  setf('setColor', Ls => {
    curColor = [argNum(Ls, 1, 0), argNum(Ls, 2, 0), argNum(Ls, 3, 0), argNum(Ls, 4, 255)];
    return 0;
  });
  setf('drawClear', Ls => { if (curOps) curOps.push({ fn: 'drawClear', color: curColor.slice(), args: [] }); return 0; });
  for (const k of ['drawLine', 'drawRect', 'drawRectF', 'drawCircle', 'drawCircleF',
    'drawTriangle', 'drawTriangleF', 'drawText', 'drawTextBox']) setf(k, recordOp(k));
  // __index：未知名一律当绘制函数录制（游戏新增 API 不至于让模拟器崩）
  lua.lua_createtable(L, 0, 1);
  lua.lua_pushcfunction(L, pushRecorder);
  lua.lua_setfield(L, -2, to_luastring('__index'));
  lua.lua_setmetatable(L, -2);
  lua.lua_setglobal(L, to_luastring('screen'));
}

libSet('map', {
  mapToScreen: Ls => {
    const mx = argNum(Ls, 1, 0), mz = argNum(Ls, 2, 0), wx = argNum(Ls, 3, 0), wz = argNum(Ls, 4, 0);
    const s = mapCfg.scale, fy = mapCfg.flip_y ? -1 : 1;
    lua.lua_pushnumber(Ls, curMonitor.w / 2 + (wx - mx) * s);
    lua.lua_pushnumber(Ls, curMonitor.h / 2 + (wz - mz) * s * fy);
    return 2;
  },
  screenToMap: Ls => {
    const mx = argNum(Ls, 1, 0), mz = argNum(Ls, 2, 0), sx = argNum(Ls, 3, 0), sy = argNum(Ls, 4, 0);
    const s = mapCfg.scale || 1, fy = mapCfg.flip_y ? -1 : 1;
    lua.lua_pushnumber(Ls, mx + (sx - curMonitor.w / 2) / s);
    lua.lua_pushnumber(Ls, mz + (sy - curMonitor.h / 2) / (s * fy));
    return 2;
  },
});

libSet('async', {
  httpGet: Ls => {
    const port = Math.round(argNum(Ls, 1, 80));
    const url = argStr(Ls, 2, '');
    httpQueue.push({ port, url });
    return 0;
  },
});

// print：仅模拟器可用（游戏内没有，报告里标注）
lua.lua_pushcfunction(L, function (Ls) {
  const n = lua.lua_gettop(Ls);
  const parts = [];
  for (let i = 1; i <= n; i++) parts.push(lua.lua_tojsstring(Ls, i));
  report.prints.push('t' + tickIdx + ': ' + parts.join('\t'));
  return 0;
});
lua.lua_setglobal(L, to_luastring('print'));

// 未定义全局读取 → warnings（抓拼写错）
{
  lua.lua_getglobal(L, to_luastring('_G'));
  lua.lua_createtable(L, 0, 1);
  lua.lua_pushcfunction(L, function (Ls) {
    const key = lua.lua_tojsstring(Ls, 2);
    if (!missingGlobals.has(key)) {
      const msg = '读取了未定义全局变量 ' + key + '（nil）——检查拼写';
      if (!report.warnings.includes(msg)) report.warnings.push(msg);
    }
    lua.lua_pushnil(Ls);
    return 1;
  });
  lua.lua_setfield(L, -2, to_luastring('__index'));
  lua.lua_setmetatable(L, -2);
  lua.lua_pop(L, 1);
}

// ---------- 编译 ----------
// 🔴 栈序铁律：错误处理器先压（栈底=索引1），被调函数后压（栈顶）——pcall(L,n,r,1)
//    pcall 永远调用「栈顶 - nargs」处的函数，msgh 只是绝对索引。
lua.lua_pushcfunction(L, function (Ls) {
  lua.lua_getglobal(Ls, to_luastring('debug'));
  lua.lua_getfield(Ls, -1, to_luastring('traceback'));
  lua.lua_pushvalue(Ls, 1);
  lua.lua_call(Ls, 1, 1);
  return 1;
});
const MSGH = 1; // 此后 msgh 常驻栈底（callGlobal 时函数与参数压在其上）
const chunkName = path.basename(scriptPath);
const code = to_luastring(src);
const loadr = lauxlib.luaL_loadbufferx(L, code, code.length, to_luastring(chunkName), null);
if (loadr !== lua.LUA_OK) {
  const msg = lua.lua_tojsstring(L, -1);
  if (outPath) fs.writeFileSync(outPath, JSON.stringify({ ok: false, stage: 'compile', error: msg }, null, 2));
  console.error('✘ 编译失败: ' + msg);
  process.exit(1);
}
if (checkOnly) {
  if (outPath) fs.writeFileSync(outPath, JSON.stringify({ ok: true, stage: 'compile' }, null, 2));
  console.log('✔ 编译通过（' + chunkName + '）');
  process.exit(0);
}

{
  const r = lua.lua_pcall(L, 0, 0, MSGH); // 执行 chunk 主体（定义 onTick 等）
  if (r !== lua.LUA_OK) {
    const msg = lua.lua_tojsstring(L, -1);
    if (outPath) fs.writeFileSync(outPath, JSON.stringify({ ok: false, stage: 'chunk', error: msg }, null, 2));
    console.error('✘ 脚本主体执行失败: ' + msg);
    process.exit(1);
  }
}

// ---------- 主循环 ----------
let tickIdx = 0;           // 0-based
let curOutputs = { numbers: {}, bools: {} };

function callGlobal(name, args) {
  lua.lua_getglobal(L, to_luastring(name));
  if (!lua.lua_isfunction(L, -1)) { lua.lua_pop(L, 1); return null; }
  for (const a of (args || [])) {
    if (typeof a === 'number') lua.lua_pushnumber(L, a);
    else if (typeof a === 'boolean') lua.lua_pushboolean(L, a);
    else lua.lua_pushstring(L, to_luastring(String(a)));
  }
  budgetLeft = budget;
  const r = lua.lua_pcall(L, args ? args.length : 0, 0, MSGH);
  if (r !== lua.LUA_OK) {
    const msg = lua.lua_tojsstring(L, -1);
    lua.lua_pop(L, 1);
    return msg;
  }
  return null;
}

function drawRecordEnabled(t) {
  if (drawTicksArg === 'all') return true;
  if (drawTicksArg === 'last') return true; // 先全记，结束只留最后一份
  return drawTicksArg.split(',').map(Number).includes(t);
}

let keepAllDraw = drawTicksArg === 'all';
let lastFrame = null;

for (let t = 1; t <= ticks; t++) {
  tickIdx = t - 1;
  curOutputs = { numbers: {}, bools: {} };
  // HTTP：每 tick 派发最老 1 个（与游戏限流一致）
  if (httpQueue.length) {
    const req = httpQueue.shift();
    const rule = httpRules.find(x => req.url.startsWith(x.match));
    const reply = rule ? rule.reply : 'connect(): Connection refused';
    report.http.push({ tick: t, port: req.port, url: req.url, reply });
    callGlobal('httpReply', [req.port, req.url, reply]);
  }
  lua.lua_pushnumber(L, t * tickMs);
  lua.lua_setglobal(L, to_luastring('g_time'));
  const err = callGlobal('onTick', []);
  if (err) { report.errors.push({ tick: t, fn: 'onTick', message: err }); break; }
  report.outputs.push({ tick: t, numbers: Object.assign({}, curOutputs.numbers), bools: Object.assign({}, curOutputs.bools) });

  if (drawRecordEnabled(t)) {
    const frame = { tick: t, monitors: [] };
    for (const mon of monitors) {
      curMonitor = mon;
      curOps = [];
      const e = callGlobal('onDraw', []);
      frame.monitors.push({ w: mon.w, h: mon.h, ops: curOps });
      if (e) { report.errors.push({ tick: t, fn: 'onDraw', message: e }); break; }
    }
    curOps = null;
    if (report.errors.length) break;
    if (keepAllDraw) report.draw_frames.push(frame);
    lastFrame = frame;
  }
}
if (!keepAllDraw && lastFrame) report.draw_frames.push(lastFrame);
report.ok = report.errors.length === 0;

const json = JSON.stringify(report, null, 2);
if (outPath) fs.writeFileSync(outPath, json);
else console.log(json);
if (!report.ok) {
  console.error('✘ 模拟出错: ' + report.errors.map(e => 't' + e.tick + ' ' + e.fn + ': ' + e.message).join('; '));
  process.exit(1);
}
console.error('✔ ' + ticks + ' ticks 完成，outputs ' + report.outputs.length + ' 条，draw_frames ' + report.draw_frames.length + ' 帧' +
  (report.warnings.length ? '，warnings ' + report.warnings.length + ' 条' : ''));
