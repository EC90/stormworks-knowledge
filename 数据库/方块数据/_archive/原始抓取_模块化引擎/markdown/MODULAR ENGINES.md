---
wiki: sbarjp
page: MODULAR ENGINES
source_url: https://wikiwiki.jp/sbarjp/MODULAR%20ENGINES
last_modified: 2023-07-08
retrieved_at: 2026-08-31T02:12:01+0800
---

# MODULAR ENGINES

機能ごとのパーツを組み立てることで自由度の高いエンジン構築が可能となる。  
構築方法などは[クラフトガイド](https://wikiwiki.jp/sbarjp/%E3%82%AF%E3%83%A9%E3%83%95%E3%83%88%E3%82%AC%E3%82%A4%E3%83%89/%E3%82%A8%E3%83%B3%E3%82%B8%E3%83%B3%E7%B3%BB)や[初心者講座](https://wikiwiki.jp/sbarjp/%E3%82%AF%E3%83%A9%E3%83%95%E3%83%88%E3%82%AC%E3%82%A4%E3%83%89/%E3%82%A8%E3%83%B3%E3%82%B8%E3%83%B3%E7%B3%BB/%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%A9%E3%83%BC%E3%82%A8%E3%83%B3%E3%82%B8%E3%83%B3%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7)を参照。

|  |
| --- |
| - [MODULAR ENGINE AIR MAINIFOLD](#e68b5840) - [MODULAR ENGINE ALTERNATOR](#xc5b9771) - [MODULAR ENGINE CLUTCH 1×1](#m3c992ec) - [MODULAR ENGINE CLUTCH 3×3](#i633998a) - [MODULAR ENGINE CLUTCH 5×5](#d39abfbc) - [MODULAR ENGINE COOLANT MANIFOLD](#o09ca726) - [MODULAR ENGINE CRANKSHAFT 1×1](#p103060a) - [MODULAR ENGINE CRANKSHAFT 3×1](#y23b7ea6) - [MODULAR ENGINE CRANKSHAFT 3×3](#i61097c9) - [MODULAR ENGINE CRANKSHAFT 5×5](#x75e0000) - [MODULAR ENGINE CRANKSHAFT CONVERTER 3 TO 1](#ie6ec67c) - [MODULAR ENGINE CRANKSHAFT CONVERTER 5 TO 3](#o27e3487) - [MODULAR ENGINE CYLINDER 1×1](#c969a3a0) - [MODULAR ENGINE CYLINDER 3×3](#n58a0e35) - [MODULAR ENGINE CYLINDER 5×5](#jdb90792) - [MODULAR ENGINE DRIVE BELT 1×1](#d8792515) - [MODULAR ENGINE DRIVE BELT 3×3](#w3512ba1) - [MODULAR ENGINE DRIVE BELT 5×5](#ja40bce7) - [MODULAR ENGINE MANIFOLD(CORNER)](#t02e5046) - [MODULAR ENGINE MANIFOLD(STRAIGHT)](#z31d5051) - [MODULAR ENGINE FLUID PUMP](#q305a55d) - [MODULAR ENGINE FLYWHEEL 1×1](#pb8ccf70) - [MODULAR ENGINE FLYWHEEL 3×3](#l9d3d9e3) - [MODULAR ENGINE FLYWHEEL 5×5](#o23c7b77) - [MODULAR ENGINE FUEL MANIFOLD](#p72b2864) - [MODULAR ENGINE MANIFOLD(CORNER)](#w9501848) - [MODULAR ENGINE MANIFOLD(STRAIGHT)](#d8c11a85) - [MODULAR ENGINE MANIFOLD(T)](#gccdac5a) - [MODULAR ENGINE STARTER](#zc6134a0) - [MODULAR ENGINE TEMPERATURE SENSOR](#ebf42d32) |

## MODULAR ENGINE AIR MAINIFOLD

空気マニホールド。シリンダへ取り付けることで空気を取り入れる。

英語原文

A modular engine air manifold.  
Attach a manifold to a cylinder to provide a connection for air to that cylinder.  
Cylinders that are chained directly adjacent to each other can share a single manifold.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Throttle（スロットル） | 0(閉)～1(開) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Air（吸気） | エンジンへ供給される空気 |

## MODULAR ENGINE ALTERNATOR

オルタネーター。ドライブベルトに設置し、動力から電気を生み出す。

英語原文

A modular engine alternator.  
Alternators convert mechanical energy from a Drive Belt into electric charge.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Clutch Pressure（クラッチ圧） | 0(切断)～1(接続) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 電力出力 |

## MODULAR ENGINE CLUTCH 1×1

クラッチ。1x1クランクシャフトの回転を接続したパイプへ出力する。

英語原文

A modular engine clutch.  
Attach a clutch to a crankshaft block to control the torque made available to the connected system.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Clutch Pressure（クラッチ圧） | 0(切断)～1(接続) 内部で3乗されている |
| CONNECTIONS（接続） | 詳細 |
| ◆ RPS（RPS） | 動力出力 |

## MODULAR ENGINE CLUTCH 3×3

クラッチ。3x3クランクシャフトの回転をエンジン外部のパイプへ出力する。

英語原文

A modular engine clutch.  
Attach a clutch to a crankshaft block to control the torque made available to the connected system.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:9 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Clutch Pressure（クラッチ圧） | 0(切断)～1(接続) 内部で3乗されている |
| CONNECTIONS（接続） | 詳細 |
| ◆ RPS（RPS） | 動力出力 |

## MODULAR ENGINE CLUTCH 5×5

クラッチ。5x5クランクシャフトの回転をエンジン外部のパイプへ出力する。

英語原文

A modular engine clutch.  
Attach a clutch to a crankshaft block to control the torque made available to the connected system.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:25 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Clutch Pressure（クラッチ圧） | 0(切断)～1(接続) 内部で3乗されている |
| CONNECTIONS（接続） | 詳細 |
| ◆ RPS（RPS） | 動力出力 |

## MODULAR ENGINE COOLANT MANIFOLD

モジュラーエンジン用の冷却水マニホールド。  
ポートAとポートBは厳密に入出力が決まっているわけではないが、  
ポートBから吸い込んでポートAに吐き出す方向で流すほうが流量が稼げる。  
また、ポンプを1つだけ使う場合はポートB側につけたほうが流量が稼げる。  
この場合はポンプの吐き出し側(Fluid Out)ポートをマニホールドのBポートに接続する。

英語原文

A modular engine coolant manifold.  
Attach a manifold to a cylinder to provide a connection for coolant to that cylinder.  
Cylinders that are chained directly adjacent to each other can share a single manifold.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Coolant A（液体） | 冷却水の入出力 |
| ◆ Coolant B（液体） | 冷却水の入出力 |

## MODULAR ENGINE CRANKSHAFT 1×1

クランクシャフト1x1。モジュラーエンジンの核となるパーツ。シリンダ1x1から動力を受けて回転する。

英語原文

A modular engine crankshaft block.  
The crankshaft is the core of an engine.  
Attach cylinders to the outer surfaces to generate power.  
Multiple crankshaft blocks can be placed adajcent to each other to form larger engines.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ RPS（RPS） | クランクシャフトの回転数 |

## MODULAR ENGINE CRANKSHAFT 3×1

クランクシャフト3x1。モジュラーエンジンの核となるパーツ。シリンダ1x1から動力を受けて回転する。

英語原文

A modular engine crankshaft block.  
The crankshaft is the core of an engine.  
Attach cylinders to the outer surfaces to generate power.  
Multiple crankshaft blocks can be placed adajcent to each other to form larger engines.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:9 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ RPS（RPS） | クランクシャフトの回転数 |

## MODULAR ENGINE CRANKSHAFT 3×3

クランクシャフト3x3。モジュラーエンジンの核となるパーツ。シリンダ3x3から動力を受けて回転する。

英語原文

A modular engine crankshaft block.  
The crankshaft is the core of an engine.  
Attach cylinders to the outer surfaces to generate power.  
Multiple crankshaft blocks can be placed adajcent to each other to form larger engines.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:27 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ RPS（RPS） | クランクシャフトの回転数 |

## MODULAR ENGINE CRANKSHAFT 5×5

クランクシャフト5x5。モジュラーエンジンの核となるパーツ。シリンダ5x5から動力を受けて回転する。

英語原文

A modular engine crankshaft block.  
The crankshaft is the core of an engine.  
Attach cylinders to the outer surfaces to generate power.  
Multiple crankshaft blocks can be placed adajcent to each other to form larger engines.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:100 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ RPS（RPS） | クランクシャフトの回転数 |

## MODULAR ENGINE CRANKSHAFT CONVERTER 3 TO 1

異なる径のクランクシャフトを接続し、トルクの変換を行う。クランクシャフト1x1と3x3間の変換に対応。

英語原文

A modular engine crankshaft block. The crankshaft is thecore of an engine.  
This component effiently converts torque between different size crankshafts.  
Multiple crankshaft blocks can be placed adajcent to each other to form larger engines.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:9 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ RPS（rps） | クランクシャフトの回転数 |

## MODULAR ENGINE CRANKSHAFT CONVERTER 5 TO 3

異なる径のクランクシャフトを接続し、トルクの変換を行う。クランクシャフト3x3と5x5の変換に対応。

英語原文

A modular engine crankshaft block. The crankshaft is thecore of an engine.  
This component effiently converts torque between different size crankshafts.  
Multiple crankshaft blocks can be placed adajcent to each other to form larger engines.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:27 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ RPS（rps） | クランクシャフトの回転数 |

## MODULAR ENGINE CYLINDER 1×1

シリンダ1x1。クランクシャフトに接続し、エンジンとしての動力を生み出す。マニホールドによって空気・燃料・排気を通す必要がある。  
隣接するシリンダは直接接続され、1つのマニホールドを共有できる。

英語原文

A modular engine cylinder. Attach a cylinder to a crankshafts outer surface to produce power for an engine.  
The cylinder requires a manifold to move air,fuel,and exhaust through the cylinder.  
Cylinders that are chained directly adjacent to each other can share a single manifold.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Composite Data（） | コンポジット出力 |
| Value 1:Air Volume | 空気量の数値を出力 |
| Value 2:Fuel Volume | 燃料噴射量の数値を出力 |
| Value 3:Temperature | 温度の数値を出力 |

## MODULAR ENGINE CYLINDER 3×3

シリンダ3x3。クランクシャフトに接続し、エンジンとしての動力を生み出す。マニホールドによって空気・燃料・排気を通す必要がある。  
隣接するシリンダは直接接続され、1つのマニホールドを共有できる。

英語原文

A modular engine cylinder. Attach a cylinder to a crankshafts outer surface to produce power for an engine.  
The cylinder requires a manifold to move air,fuel,and exhaust through the cylinder.  
Cylinders that are chained directly adjacent to each other can share a single manifold.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:27 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Composite Data（） | コンポジット出力 |
| Value 1:Air Volume | 空気量の数値を出力 |
| Value 2:Fuel Volume | 燃料噴射量の数値を出力 |
| Value 3:Temperature | 温度の数値を出力 |

## MODULAR ENGINE CYLINDER 5×5

シリンダ5x5。クランクシャフトに接続し、エンジンとしての動力を生み出す。マニホールドによって空気・燃料・排気を通す必要がある。  
隣接するシリンダは直接接続され、1つのマニホールドを共有できる。

英語原文

A modular engine cylinder. Attach a cylinder to a crankshafts outer surface to produce power for an engine.  
The cylinder requires a manifold to move air,fuel,and exhaust through the cylinder.  
Cylinders that are chained directly adjacent to each other can share a single manifold.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:100 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Composite Data（） | コンポジット出力 |
| Value 1:Air Volume | 空気量の数値を出力 |
| Value 2:Fuel Volume | 燃料噴射量の数値を出力 |
| Value 3:Temperature | 温度の数値を出力 |

## MODULAR ENGINE DRIVE BELT 1×1

ドライブベルト。クランクシャフト1x1に接続し、スターターやオルタネーター、ポンプのインターフェースとなる。

英語原文

A modular engine drive belt. The drive belt attaches to the crankshaft and provides an interface for starters, alternatores and pumps.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |

## MODULAR ENGINE DRIVE BELT 3×3

ドライブベルト。クランクシャフト3x3に接続し、スターターやオルタネーター、ポンプのインターフェースとなる。

英語原文

A modular engine drive belt. The drive belt attaches to the crankshaft and provides an interface for starters, alternatores and pumps.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:9 |

## MODULAR ENGINE DRIVE BELT 5×5

ドライブベルト。クランクシャフト5x5に接続し、スターターやオルタネーター、ポンプのインターフェースとなる。

英語原文

A modular engine drive belt. The drive belt attaches to the crankshaft and provides an interface for starters, alternatores and pumps.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:27 |

## MODULAR ENGINE MANIFOLD(CORNER)

排気マニホールド。シリンダへ取り付けることで排気を出力する。マニホールド接続面に対し横向きになっているタイプ。

英語原文

A modular engine manifold. Attach a manifold to a cylinder to provide an Exhaust output connection for that cylinder.  
Cylinders that are chained directly adjacent to each other canshare a single manifold.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Exhaust（排気） | エンジンからの燃焼ガス出力 |

## MODULAR ENGINE MANIFOLD(STRAIGHT)

排気マニホールド。シリンダへ取り付けることで排気を出力する。マニホールド面に対し真っすぐになっているタイプ。

英語原文

A modular engine manifold. Attach a manifold to a cylinder to provide an Exhaust output connection for that cylinder.  
Cylinders that are chained directly adjacent to each other canshare a single manifold.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Exhaust（排気） | エンジンからの燃料ガス出力 |

## MODULAR ENGINE FLUID PUMP

流体ポンプ。ドライブベルトに設置し、流体を加圧する。クランクシャフト軸方向から取り入れ、左右方向へ出力する。

英語原文

A modular engine fluid pump. An pump that attaches to a Drive Belt to mechanically push fluid around a system.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Clutch Pressure（クラッチ圧） | 0(切断)～1(接続) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Fluid In（流体入口） | 流体配管の接続 |
| ◆ Fluid Out（流体出口） | 流体配管の接続 |

## MODULAR ENGINE FLYWHEEL 1×1

フライホイール、弾み車。クランクシャフト1x1に接続し、回転モーメントとして動力を保存する。ただし、クランクシャフトの回転数変動が緩やかになり始動が難しくなる。

英語原文

A modular engine crankshaft flywheel.The crankshaft is the core of an engine.  
A flywheel piece sits as part of the crankshaft and acts as a momentum(energy)store for a running engine,  
but also makes the engine harder to start.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:100 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ RPS（rps） | フライホイール回転数 |

## MODULAR ENGINE FLYWHEEL 3×3

フライホイール、弾み車。クランクシャフト3x3に接続し、回転モーメントとして動力を保存する。ただし、クランクシャフトの回転数変動が緩やかになり始動が難しくなる。

英語原文

A modular engine crankshaft flywheel.The crankshaft is the core of an engine.  
A flywheel piece sits as part of the crankshaft and acts as a momentum(energy)store for a running engine,  
but also makes the engine harder to start.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:200 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ RPS（rps） | フライホイール回転数 |

## MODULAR ENGINE FLYWHEEL 5×5

フライホイール、弾み車。クランクシャフト5x5に接続し、回転モーメントとして動力を保存する。ただし、クランクシャフトの回転数変動が緩やかになり始動が難しくなる。

英語原文

A modular engine crankshaft flywheel.The crankshaft is the core of an engine.  
A flywheel piece sits as part of the crankshaft and acts as a momentum(energy)store for a running engine,  
but also makes the engine harder to start.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:300 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ RPS（rps） | フライホイール回転数 |

## MODULAR ENGINE FUEL MANIFOLD

燃料マニホールド。シリンダへ取り付けることで燃料を供給する。

英語原文

A modular engine fuel manifold.  
Attach a manifold to a cylinder to provide a connection for fuel to that cylinder.  
Cylinders that are chained directly adjacent to each other can share a single manifold.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Throttle（スロットル） | 0(閉)～1(開) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Fuel（燃料） | エンジンへ供給される燃料 |

## MODULAR ENGINE MANIFOLD(CORNER)

マニホールドの接続用パーツ。離れたシリンダをこれで接続することにより、シリンダ全体で空気・燃料・排気・冷却マニホールドを共有できるようになる。  
接続面が直角に曲がったタイプ。

英語原文

A modular engine manifold.Attach a manifold to a cylinder to provide connections for air,fuel,and exhaust for that cylinder.  
Cylinders that are chained directly adjacent to each other can share a single manifold.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |

## MODULAR ENGINE MANIFOLD(STRAIGHT)

マニホールドの接続用パーツ。離れたシリンダをこれで接続することにより、シリンダ全体で空気・燃料・排気・冷却マニホールドを共有できるようになる。  
接続面が直線になっているタイプ。~~通称レンコン。~~

英語原文

A modular engine manifold.Attach a manifold to a cylinder to provide connections for air,fuel,and exhaust for that cylinder.  
Cylinders that are chained directly adjacent to each other can share a single manifold.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |

## MODULAR ENGINE MANIFOLD(T)

マニホールドの接続用パーツ。離れたシリンダをこれで接続することにより、シリンダ全体で空気・燃料・排気・冷却マニホールドを共有できるようになる。  
接続面が3面あるタイプ。

英語原文

A modular engine manifold.Attach a manifold to a cylinder to provide connections for air,fuel,and exhaust for that cylinder.  
Cylinders that are chained directly adjacent to each other can share a single manifold.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |

## MODULAR ENGINE STARTER

エンジンスターター。信号によってセルモーターを起動し、ベルトを介してクランクシャフトへ初期回転を与える。

英語原文

A modular engine starter.  
Attach a starter to a Drive Belt component and supply power to apply an inefficient force on the engine to get it started.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Starter（スターター） | ONの間セルモーターが回転する |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 始動用の電力 |

## MODULAR ENGINE TEMPERATURE SENSOR

温度センサー。クランクシャフト1x1または1x3に接続し、エンジン温度を得ることができる。

英語原文

A modular engine temperature sensor.  
Attach to a crankshaft to provide temperature information.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Temperature（温度） | エンジン温度 |
