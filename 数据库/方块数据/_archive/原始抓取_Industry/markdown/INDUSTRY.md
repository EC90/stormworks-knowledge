---
wiki: sbarjp
page: INDUSTRY
source_url: https://wikiwiki.jp/sbarjp/INDUSTRY
last_modified: 2024-08-15
retrieved_at: 2026-08-31
retrieval_method: WebFetch（wikiwiki_crawl.py 直连被 403 拦截，改用 WebFetch）
note: 日文 wikiwiki.jp 的工业先锋 DLC 部件页。Fandom 的 Industry 无子页面，本页补齐方块数据 00_速查 的 ❌ 缺口。
---

# INDUSTRY（工业先锋 DLC · 日文 wiki）

> 以下为 WebFetch 提取的原文要点（中文名已对照 `<WS>\汉化相关\` 补丁表，详见 `18_工业设备.md`）。

## 设备清单（30 种 / 33 条目含尺寸变体）
- ELECTRIC FURNACE（电热炉）mass220 3x3x5 $900 — Enable(开)/Temperature(数)；Coolant In-Out/Electric
- FIREBOX（煤炉）mass100 5x3x3 $100 — Ignition(开)/Coal level(数)/Temperature(数)；Coolant/Air/Exhaust；烧煤，最高约200℃
- FIREBOX LARGE（煤炉(大)）mass400 7x5x5 $200 — 同煤炉，最高约400℃
- INDUSTRIAL DIESEL FURNACE（工业柴油炉）mass350 7x5x5 $750 — Ignition/Diesel level(数)/Temperature(数)；Diesel In
- MINERAL DUCT（游戏内=输送管 Duct）mass80 3x3x3 $50 容量27 — Mineral level(数)；Coal level 0~100%
- MINERAL DUCT MEDIUM（输送管(中)）mass250 5x5x5 $100 容量125
- MINERAL DUCT LARGE（输送管(大)）mass500 5x9x5 $150 容量225
- MINERAL FUNNEL（游戏内=输送管漏斗 Funnel Duct）mass20 3x3x1 $50 — Open(开)；各矿搬出 On/Off
- LOBSTER POT（龙虾陷阱）mass45 5x5x3 $150 — Release(开)/Fill Level(数)
- MINERAL HOPPER（游戏内=输送管料斗 Hopper）mass80 3x3x3 $50 容量27 — Mineral level(数)
- MINERAL HOPPER MEDIUM（输送管料斗(中)）mass250 5x5x5 $100 容量125
- MINERAL HOPPER LARGE（输送管料斗(大)）mass500 5x9x5 $150 容量225
- NET ANCHOR（渔网锚点）mass3 1x1x3 $15 — Release Catch/Extend/Retract(开)；Net Data(复合)；Net Node
- NUCLEAR CONTROL ROD（核控制棒）mass100 1x1x17 $250 — Insertion Target(数0~1)/Insertion(数)
- NUCLEAR FUEL ASSEMBLY（核燃料总成）mass80 1x1x12 $500 — Release Fuel Rod(开)/Fuel Rod Temperature(数)
- NUCLEAR FUEL ROD（核燃料棒）mass80 1x1x9 $2500 — 裂变产热
- OIL RIG DRILL CLAMP（钻杆夹具）mass30 3x3x2 $100 — Clamp Rod(开)/Slider Velocity(数)/Rod Clamped(开)
- OIL RIG DRILL CLAMP (END)（钻杆夹具(端部)）mass5 1x1x2 $500
- OIL RIG DRILL CONNECTOR（钻杆连接器）mass50 3x7x2 $100 — Connect/Disconnect(开)/Connector Aligned(开)
- OIL RIG DRILL SWIVEL（泥浆喷嘴）mass30 3x3x5 $1000 — Fluid In/Out(流体)
- OIL RIG PUMPJACK（抽油泵）mass200 3x3x21 $1000 — Fluid Out(原油)
- OIL RIG ROD STORAGE（钻杆储存）mass10 1x41x2 $50 — Rod Stored(开)；Spawn Drill Rod
- OIL RIG ROTARY TABLE（钻机旋转台）mass500 7x7x3 $1000 — Clamp(开)/RPS(数)；Torque(动力)
- OIL RIG WELL HEAD（井口装置）mass1000 9x9x25 $5000 — Anchor(开)/Is Anchored/Drill Depth/Well Depth；流体端口
- STEAM BOILER（蒸汽锅炉）mass500 5x7x5 $250 — Fluid Volume/Temperature(100℃+产汽)/Pressure(>10破裂)(数)；Fill 0~100%
- STEAM CONDENSER（蒸汽冷凝器）mass250 3x5x5 $250 — Fluid Volume/Temperature(数)
- STEAM PISTON (SMALL)（蒸汽活塞(小)）mass12 1x1x6 $90 — RPS/Piston Position(-0.5~0.5)(数)；Steam In-Out/RPS(动力)；Rotation Offset
- STEAM PISTON (MEDIUM)（蒸汽活塞(中)）mass120 3x3x9 $600
- STEAM PISTON (LARGE)（蒸汽活塞(大)）mass300 5x5x15 $2400
- STEAM TURBINE（蒸汽轮机）mass500 5x5x9 $250 — Steam In-Out/RPS(动力)

## 说明
- 仅电热炉明确用电；其余为煤/柴油/铀燃料或机械/蒸汽动力。
- 所有逻辑节点已按 开关型/数值型/复合 标注；连接口区分流体/电力/动力/网节点。
- 容量：矿物管道 27/125/225；温度：煤炉200/400℃、锅炉100℃+；压力上限 10。
