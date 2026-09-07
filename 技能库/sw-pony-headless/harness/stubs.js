'use strict';
/*
 * sw-pony-headless · DOM 中间层 stub
 *
 * 为 Pony IDE 快照（editor-master/src/scripts）的 paint.js、stormworks_lua_api.js、
 * lua_emulator.js 提供无浏览器运行环境。渲染语义与 API 语义全部来自原文件，
 * 本文件只实现它们依赖的中间层对象（CANVAS/CONSOLE/ENGINE/INPUT/OUTPUT/PROPERTY/
 * LOADER/EDITORS/UTIL/假 jQuery/假 document）。
 *
 * CANVAS 用 @napi-rs/canvas 实现；字体以 "Screen Mono" family 名注册，
 * 命中 paint.js 里 `FONT = 'px "Screen Mono", ...'` 的字体串（游戏同款点阵字体）。
 */
const { createCanvas, GlobalFonts } = require('@napi-rs/canvas');
const fengariRaw = require('fengari');
const fengariInterop = require('fengari-interop');
const fs = require('fs');

function buildSandbox(opts) {
  const { monitorW, monitorH, zoom, scenario, fontPath, mapImage, quiet } = opts;
  const inputsArr = Array.isArray(scenario.inputs) && scenario.inputs.length
    ? scenario.inputs : [{}];
  const props = scenario.properties || {};

  // 运行期共享状态（driver 与 stub 之间）
  const state = {
    idx: 0,            // 当前 tick（1 起）
    errorStopped: false,
    infiniteLoopWarned: false,
    paused: false,
    luaError: null,    // {line, err}
    alerts: [],
  };

  // ---- 字体 ----
  GlobalFonts.registerFromPath(fontPath, 'Screen Mono');

  // ---- CANVAS（@napi-rs/canvas）----
  const frameCanvas = createCanvas(monitorW * zoom, monitorH * zoom);
  const ctx = frameCanvas.getContext('2d');
  const CANVAS = {
    ctx: () => ctx,
    top: () => 0,
    left: () => 0,
    width: () => monitorW,
    height: () => monitorH,
    realWidth: () => frameCanvas.width,
    realHeight: () => frameCanvas.height,
    reset: () => {
      ctx.setTransform(1, 0, 0, 1, 0, 0);
      ctx.clearRect(0, 0, frameCanvas.width, frameCanvas.height);
    },
    refresh: () => {},
    resetTouchpoints: () => {},
    mouseIsOverMonitor: () => false,
  };

  // ---- INPUT / OUTPUT / PROPERTY ----
  const devInputs = { numbers: {}, bools: {} };
  const INPUT = {
    getNumberValue: (i) => {
      const cur = inputsArr[Math.min(state.idx, inputsArr.length - 1)] || {};
      const v = (cur.numbers || {})[String(Math.round(i))];
      return typeof v === 'number' ? v : 0;
    },
    getBoolValue: (i) => {
      const cur = inputsArr[Math.min(state.idx, inputsArr.length - 1)] || {};
      return !!(cur.bools || {})[String(Math.round(i))];
    },
    setNumber: (i, v) => { devInputs.numbers[Math.round(i)] = v; },
    setBool: (i, v) => { devInputs.bools[Math.round(i)] = v; },
  };

  const OUTPUT = {
    setNumber: (i, v) => { opts.onOutput && opts.onOutput(state.idx, Math.round(i), 'number', v); },
    setBool: (i, v) => { opts.onOutput && opts.onOutput(state.idx, Math.round(i), 'bool', v); },
  };

  const lookupProp = (label) => {
    if (typeof label === 'number') {
      return Array.isArray(props) ? props[Math.round(label) - 1] : props[String(Math.round(label))];
    }
    return props[label];
  };
  const PROPERTY = {
    getNumber: (label) => {
      const v = lookupProp(label);
      if (typeof v === 'number') return v;
      if (typeof v === 'string') { const f = parseFloat(v); return isNaN(f) ? 0 : f; }
      return 0;
    },
    getBool: (label) => !!lookupProp(label),
    getText: (label) => {
      const v = lookupProp(label);
      return typeof v === 'string' ? v : '';
    },
  };

  // ---- CONSOLE（收集 + stderr）----
  const consoleLines = [];
  const CONSOLE = {
    COLOR: { WARNING: 'warning', ERROR: 'error', SPECIAL: 'special', DEBUG: 'debug' },
    print: (text, color) => {
      consoleLines.push({ tick: state.idx, color: color || null, text: String(text) });
      if (!opts.quiet) process.stderr.write('[console] ' + String(text) + '\n');
    },
    setPrintColor: () => {},
    reset: () => { consoleLines.length = 0; },
    notifiyTickOrDrawOver: () => {},
  };
  CONSOLE.lines = consoleLines;

  // ---- ENGINE / EDITORS / UTIL ----
  const ENGINE = {
    pauseScript: () => { state.paused = true; },
    errorStop: () => { state.errorStopped = true; },
    notifyInfiniteLoopDetected: () => {
      if (!state.infiniteLoopWarned) {
        state.infiniteLoopWarned = true;
        CONSOLE.print('Warning: possible infinite loop detected (500 calls in one callback)', CONSOLE.COLOR.WARNING);
      }
    },
  };
  const EDITORS = {
    getActiveEditor: () => ({
      markError: (line, err) => { state.luaError = { line: line || null, err: String(err) }; },
    }),
  };
  const UTIL = { alert: (msg) => { state.alerts.push(String(msg)); console.error('[UTIL.alert]', msg); } };

  // ---- LOADER（手动 fire PAGE_READY，解耦三个源文件的加载顺序依赖）----
  const LOADER = {
    EVENT: {
      PAGE_READY: 'PAGE_READY',
      LUA_EMULATOR_READY: 'LUA_EMULATOR_READY',
      STORMWORKS_LUA_API_READY: 'STORMWORKS_LUA_API_READY',
    },
    _cbs: {},
    on(ev, cb) { (this._cbs[ev] = this._cbs[ev] || []).push(cb); },
    done() {},
    fire(ev) { (this._cbs[ev] || []).slice().forEach((cb) => { try { cb(); } catch (e) { throw e; } }); },
  };

  // ---- 假 jQuery / 假 document（map.js 的 $('#map') 与 createElement('canvas')）----
  // mapImage 必须是已 await loadImage(map.png) 的同步 Image 实例（driver 注入 sandbox.$ 前已备好）
  const jQuery = function (sel) {
    if (sel === '#map' && mapImage) {
      return { get: () => mapImage };
    }
    const chain = { get: () => null, prop: () => chain, on: () => chain, each: () => chain, addClass: () => chain };
    return chain;
  };
  const documentStub = {
    createElement(tag) {
      if (tag === 'canvas') return createCanvas(64, 64);
      return {};
    },
    getElementById: () => null,
  };

  // ---- fengari 包装（主包 + interop + 便捷 L）----
  const fengari = Object.assign({}, fengariRaw, { interop: fengariInterop });
  if (!fengari.L) fengari.L = fengari.lauxlib.luaL_newstate();

  const sandbox = {
    window: null, // 下面指回自身
    jQuery,
    $: jQuery,
    document: documentStub,
    performance: globalThis.performance,
    TextDecoder: globalThis.TextDecoder,
    setTimeout: globalThis.setTimeout,
    clearTimeout: globalThis.clearTimeout,
    // 跨 realm 关键：Pony IDE 源码在 vm 里跑，而 fengari/stub 对象来自 host realm。
    // 不注入 host 内建的话，源码里的 `x instanceof Uint8Array/Array/Object` 全部失配
    // （fengari 的 lua string 会被 luaToString 当成数字键对象打成字节串）。
    Uint8Array: globalThis.Uint8Array,
    Array: globalThis.Array,
    Object: globalThis.Object,
    Date: globalThis.Date,
    RegExp: globalThis.RegExp,
    JSON: globalThis.JSON,
    Math: globalThis.Math,
    isNaN: globalThis.isNaN,
    parseInt: globalThis.parseInt,
    parseFloat: globalThis.parseFloat,
    // Pony IDE 源码内部的 console 噪声（"reseting lua vm..." 等）全部走 stderr，保持 stdout 纯 JSON
    console: { log: (...a) => process.stderr.write('[ide] ' + a.join(' ') + '\n'),
               error: (...a) => process.stderr.write('[ide:error] ' + a.join(' ') + '\n'),
               warn: (...a) => process.stderr.write('[ide:warn] ' + a.join(' ') + '\n') },
    fengari,
    LOADER,
    CANVAS,
    CONSOLE,
    ENGINE,
    EDITORS,
    UTIL,
    INPUT,
    OUTPUT,
    PROPERTY,
  };
  sandbox.window = sandbox;
  sandbox.global = sandbox;

  return {
    sandbox, state, CANVAS, CONSOLE, LOADER, frameCanvas,
    devInputs,
  };
}

module.exports = { buildSandbox };
