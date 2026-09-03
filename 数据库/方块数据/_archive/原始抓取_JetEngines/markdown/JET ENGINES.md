---
wiki: sbarjp
page: JET ENGINES
source_url: https://wikiwiki.jp/sbarjp/JET%20ENGINES
last_modified: 2022-03-14
retrieved_at: 2026-08-31
retrieval_method: WebFetch（wikiwiki_crawl.py 直连被 403 拦截，改用 WebFetch）
note: 日文 wikiwiki.jp 的模块化喷气引擎部件页。Fandom 的 Jet Engines 无子页面，本页补齐方块数据 00_速查 的 ❌ 缺口。
---

# JET ENGINES（模块化喷气引擎 · 日文 wiki）

> 组装顺序：1 进气口 → 2 压气机 → 3 燃烧室 → 4 涡轮 → 5 喷口（气道在中间插入延展）。

## 部件清单
- SMALL JET INTAKE（喷气式进气道(小)）mass5 3x1x3 — Air Pressure/RPS(数)
- LARGE JET INTAKE（喷气式进气道(大)）mass10 7x2x7 — Air Pressure/RPS(数)；涡轮风扇额外推力
- JET COMPRESSOR（喷气引擎压气机）mass20 3x5x3 — Compressor(开)；Air Pressure/Temperature/RPS(数)；Electric
- JET COMBUSTION CHAMBER（喷气燃烧室）mass20 3x3x3 — Throttle(数0~1)/Fuel；Air Pressure/Temperature/RPS(数)；内压足够高时燃烧
- JET DUCT STRAIGHT（喷气引擎气道(直型)）mass3 3x1x3
- JET DUCT ANGLE（气道(L型)）mass5 3x3x3
- JET DUCT T（气道(T型)）mass5 3x3x3
- JET DUCT CROSS（气道(十字型)）mass5 3x3x3
- JET DUCT DIAGONAL（气道(斜型)）mass5 4x3x3
- JET EXHAUST BASIC（喷气口(基础型)）mass5 3x2x3 — Thrust Spoiler(数0~1)；Air Pressure/Temperature(数)；推力∝内部RPS
- JET EXHAUST AFTERBURNER（喷气口(加力型)）mass10 3x5x3 — Thrust Spoiler/Afterburner(开)/Fuel；加力增推力费油、极速增益极小
- JET EXHAUST ROTATING（喷气口(旋转式)）mass10 3x4x3 — Thrust Spoiler/Rotation Target(-0.5~0.5圈)；内置机械枢轴矢量推力
- JET TURBINE SMALL（喷气涡轮(小)）mass15 3x2x3 — Air Pressure/Temperature/RPS(数)；Electric(输出)
- JET TURBINE MEDIUM（喷气涡轮(中)）mass20 3x3x3 — Air Pressure/Temperature/RPS(数)；Power(动力)/Electric(输出)

## 说明
- 所有部件原文标 power:1000（相同，疑模板默认值，忽略）。价格栏原文为空（$）。
- 推力正比于引擎内部 RPS；燃烧室需内压足够才开始燃烧。
- 旋转喷口 Rotation Target 取 -0.5~0.5 圈，与枢轴角度约定（圈非度）一致。
