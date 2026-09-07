# compass_demo — 端到端验收样例

罗盘 HUD：多文件 require + 宽屏适配 + 航向平滑 + onDraw nil 守卫。
源码刻意遵守全部纪律：仅 ASCII、单引号、比较只写 > 方向、无反斜杠。

跑法（见 ../../SKILL.md 标准管线）：

```bash
npx -y storm-lua-minify main.lua -m --runtime-profile stormworks --required-whitespace space
python ../../scripts/sw_lua_xmlsafe.py main.min.lua --strip-map-comment
python ../../scripts/sw_lua_lint.py main.min.xmlsafe.lua --stage final
node ../../harness/sw_sim.js main.min.xmlsafe.lua scenario.json -o report.json --draw-ticks last
python ../../harness/render_drawlist.py report.json --outdir png   # 用 <PYN> 解释器
```

lib.lua 里的 `--@storm export` 注解**不能删**：-m 模式下没有它，模块函数定义会被
storm-lua-minify 0.9.1 的优化器整段删除（调用点改名、运行时 nil）——模拟器会报
`attempt to call a nil value (field 'a')`。
