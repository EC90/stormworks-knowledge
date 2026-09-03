---
wiki: sbarjp
page: MECHANICS
source_url: https://wikiwiki.jp/sbarjp/MECHANICS
last_modified: 2025-06-23
retrieved_at: 2026-08-31T01:28:27+0800
---

# MECHANICS

|  |
| --- |
| - [CLUTCH](#y3eabeee) - [COMPACT LINEAR TRACK BASE](#q89cc341) - [COMPACT LINEAR TRACK EXTENSION](#ac7e519e) - [COMPACT PIVOT (POWER)](#sc481126) - [COMPACT ROBOTIC PIVOT](#i9ed433e) - [COMPACT VELOCITY PIVOT](#hf8e2b47) - [DOOR FRAME CONTROLLER](#w7e959dd) - [DOOR FRAME CORNER](#sd2e7ca3) - [DOOR FRAME EDGE](#q7e1052c) - [DOOR PANEL CORNER](#c6c46dba) - [DOOR PANEL EDGE](#x22b34d5) - [ELECTRIC CONNECTOR](#n8aecdf8) - [FLUID CONNECTOR](#cd47d22b) - [GEARBOX](#ybe58133) - [GEARBOX 1×1](#ed63793b) - [GEARBOX 3×3](#k578f2df) - [GEARBOX 5×5](#sea966b0) - [HARDPOINT CONNECTOR ATTACHIMENT](#pbf1cddb) - [HARDPOINT CONNECTOR ATTACHIMENT(ROUND)](#z66fff17) - [HARDPOINT CONNECTOR BODY](#h98c6201) - [HINGE CONNECTOR](#o7bccbb1) - [HINGED DOCK DOOR](#f8176ab3) - [HINGED DOCK HATCH](#h9ff86f1) - [HINGED DOOR](#ubfc65bb) - [HINGED HATCH](#b49a5a22) - [KEY BUTTON](#n8d27e93) - [LARGE CONNECTOR](#x28fc4c0) - [LARGE KEYPAD](#v7157e24) - [LINEAR TRACK BASE](#w504a3b6) - [LINEAR TRACK EXTENSION](#xc2e0222) - [LOCKABLE BUTTON](#n09a6af6) - [MAG ALL](#e4d308d5) - [PISTON SUSPENSION](#fe591ff8) - [PIVOT](#v839b208) - [PIVOT (POWER)](#t0d90d2d) - [PNEUMATIC PISTON](#m7cdda50) - [PUSH BUTTON](#b06934b8) - [PUSH BUTTON (2 SIDED)](#j1946a8d) - [ROBOTIC DOOR HINGE](#i221b498) - [ROBOTIC HINGE](#j8b75662) - [ROBOTIC PIVOT (FLUID)](#tefb15d9) - [ROBOTIC PIVOT (POWER)](#ne304417) - [SLIDING CONNECTOR GRIPPER](#k2daf283) - [SLIDING CONNECTOR TRACK](#t8c29237) - [SLIDING DOOR](#h793f71b) - [SLIDING DOOR(ELECTRIC)](#f5d2aadf) - [SLIDING HATCH](#fdde683e) - [SLIDING HATCH(ELECTRIC)](#s378f9a2) - [SMALL CONNECTOR](#j2e4328e) - [SMALL KEYPAD](#s844d25d) - [SUSPENTION](#fbdc1420) - [THROTTLE LEVER](#z2567a94) - [TOGGLE BUTTON](#f4e273c2) - [TOGGLE BUTTON (2 SIDED)](#a908ddc7) - [TORQUE CONNECTOR](#l279a48e) - [TURRET RING(LARGE)](#t3b6e446) - [TURRET RING(MEDIUM)](#f7b9cc20) - [TURRET RING(SMALL)](#y6813dc5) - [VELOCITY PIVOT](#raab09c0) |

仮：コネクタ一覧表

| 名称 | 体積(マス数) | 重量 | 通す物 | 引力(距離) | 消費電力 |
| --- | --- | --- | --- | --- | --- |
| MAG ALL | 3 | 5 | 無し | 弱い(接触) | 無し |
| ELECTRIC CONNECTOR | 2 | 2 | 複合 映像 | 普通(0.75m) | 接続先と平均化 |
| FLUID CONNECTOR | 2 | 2 | 複合 映像 流体 | なし(0.75m) | 無し |
| SMALL CONNECTOR | 2 | 2 | 複合 映像 | なし(1m) | 引き合う間 |
| HINGE CONNECTOR | 6 | 3 | 複合 映像 | 普通(1m) | 引き合う間 |
| LARGE CONNECTOR | 18 | 20 | オンオフ 数値 複合 映像 動力 流体 | 強い(1m) | 引き合う間 |
| DOOR DOCK SMALL | 25 | 15 | オンオフ 数値 複合 | 弱い(1m) | 引き合う間 |
| DOOR DOCK LARGE | 45 | 20 | オンオフ 数値 複合 | 弱い(1m) | 引き合う間 |
| SLIDING CONNECTOR GRIPPER | 2 | 2 | 無し | なし(0.125m) | 無し |

距離については目算(v1.2.12にて確認)

## CLUTCH

クラッチ：2つのノード間の動力伝達を管理するためのクラッチ。  
数値入力は、伝わる動力の量を制御します。

英語原文

A clutch for managing the transmission of power between two nodes.  
The number input controls the amount of power transmitted.

※PowerAとPowerBの間で動力ラインのつながりを繋いだり離したりする装置です（どちら向きでもよい）  
　数値を入力することでつながりの強さを調節できます。デフォルト圧は0で切り離し状態、1が直結状態です。  
※クラッチ圧には0.3ほどの遊びがある。0～0.3までは伝達せず0.3～1.0で徐々に伝達量が増える。  
価格 -$、サイズ（WxDxH）1x2x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Clutch Pressure（クラッチ圧） | 0～1 動力の伝達量 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power A（動力Ａ） | 動力配管を接続 |
| ◆ Power B（動力Ｂ） | 動力配管を接続 |
| ◆ Electric（電力） | クラッチ圧の制御用電力 |

## COMPACT LINEAR TRACK BASE

小型リニアトラックベース(基部)：モジュラーリニアトラックに沿って動くコンパクトなスライダー。  
Compact Linear Track Extensionコンポーネントを使用して直線路を構築できます。  
スライダーの速度は、数値入力を使用して設定できます。

英語原文

A compact slider that moves along a modular linear track.  
You can build the track using the Compact Linear Track Extension component.  
The speed of the slider can be set using its number input.

※レール上を移動する台車で、レール部１マスと台車部１マスで構成されています。それぞれ別のパーツ扱いです（MERGE画面を参照）  
　レール部分にCOMPACT LINEAR TRACK EXTENSIONのレールを繋げるように配置することで、レール上に台車を移動させることができます。

|  |  |
| --- | --- |
| [20190327022255_1.jpg](https://cdn.wikiwiki.jp/to/w/sbarjp/MECHANICS/::attach/20190327022255_1.jpg?rev=e094db20e3946555aa220da5f2ff6941&t=20190327031827 "20190327022255_1.jpg") | [20190327032012_1.jpg](https://cdn.wikiwiki.jp/to/w/sbarjp/MECHANICS/::attach/20190327032012_1.jpg?rev=2184bafde724c3aa18643704e77747ee&t=20190327032052 "20190327032012_1.jpg") |
| パーツは赤色の部分 | MERGE画面 |

※大きな力が掛かると動作が阻害される事があります。  
　電力が供給されない場合、重力などの外力で容易に動きます。  
価格 -$、サイズ（WxDxH）1x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass）、動力（motor）、速度（motorspeed） | mass:2、motor:10000、motorspeed:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Slider Speed（スライダー速度） | -1～1 スライダーの移動速度設定値、0で停止 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | スライダー動作用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Max Power（最大出力） | 0～100％ | トルクの設定 |
| Gear Ratio（ギア比） | 1:1 / 1:2 / 1:4 / 1:8 / 1:16 / 1:32 | ギア比の選択 |

## COMPACT LINEAR TRACK EXTENSION

小型リニアトラックエクステンション(拡張)：直線路を構築するために使用できる拡張部品。  
リニアトラックベースを機能させるには、トラックに沿ってどこかに取り付ける必要があります。

英語原文

An extension piece that can be used to build linear tracks.  
A Linear Track Base must be attached somewhere along the track for it to function.

※COMPACT LINEAR TRACK BASE用のレールです、スリットが繋がるように並べてください（上記 BASE画像の青い部分を参照）  
価格 -$、サイズ（WxDxH）1x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |

## COMPACT PIVOT (POWER)

小型動力ピボット：軸を中心に自由に回転できる小型ピボット。

英語原文

A small pivot that can rotate freely about its axis.

価格 $40、サイズ（WxDxH）1x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 機械的エネルギー伝達のための動力接続（親） |
| ◆ Power（動力） | 機械的エネルギー伝達のための動力接続（子） |

## COMPACT ROBOTIC PIVOT

小型機械的ピボット：その動きの範囲内で入力値の方向を向く小さなロボットピボット。  
ピボットは、両方向に0.25回転の可動範囲を持っています。標準入力値は、ピボットの動作範囲内のターゲット方向を設定します。  
ピボットの速度は、選択ツールでピボットを選択して構成できます。

英語原文

A small robotic pivot that will orientate towards the input value within its range of motion.  
The pivot has a range of motion of 0.25 turns in both directions.  
A standard input value sets the target orientation within the pivot's range of motion.  
The pivot's speed can be configured by selecting it with the select tool.

|  |  |
| --- | --- |
| [20190327032503_1.jpg](https://cdn.wikiwiki.jp/to/w/sbarjp/MECHANICS/::attach/20190327032503_1.jpg?rev=b6122f26d3c76637a6e9ae0acd77b17d&t=20190327032551 "20190327032503_1.jpg") | |
| 左がROBOTIC | 右がVELOCITY |

※COMPACT ROBOTIC PIVOTは基本位置0から±90度ずつ180度の範囲で入力した数値の角度に向かって動きます。  
※大きな力が加わると角度を維持できず動作角度(180度)の範囲以上に回転したり軸がズレる事もあります。  
　電力が供給されない場合でもある程度の保持力があります。  
価格 -$、サイズ（WxDxH）1x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass）、動力（motor）、速度（motorspeed） | mass:2、motor:200、motorspeed:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotation Target（目標角度） | -1～1 目標角度の設定値(0を中心に±90度) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Speed（速度） | 0.1～5.0(デフォルト値は1.0) | 速度の設定 |
| Max Power（最大出力） | 0～100％ | トルクの設定 |
| Gear Ratio（ギア比） | 1:1 / 1:2 / 1:4 / 1:8 / 1:16 / 1:32 | ギア比の選択 |

## COMPACT VELOCITY PIVOT

小型速度ピボット：設定された入力速度で連続的に回転する小さなピボット。  
Oの値を入力すると、停止します。

英語原文

A small pivot that will continuously rotate at a set input speed.  
Inputting a value of O will cause it to stop.

※COMPACT VELOCITY PIVOTは入力された数値の速度で一定方向へ回転し続けます。  
※大きな力が掛かると動作が阻害されたり軸がズレる事もあります。  
　電力が供給されない場合、重力などの外力で容易に動きます。  
価格 -$、サイズ（WxDxH）1x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass）、動力（motor）、速度（motorspeed） | mass:1、motor:100、motorspeed:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotation Speed（回転速度） | -1～1 軸回転速度の設定値(0で停止、＋正転、－逆転) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Max Power（最大出力） | 0～100％ | トルクの設定 |
| Gear Ratio（ギア比） | 1:1 / 1:2 / 1:4 / 1:8 / 1:16 / 1:32 | ギア比の選択 |

## DOOR FRAME CONTROLLER

ドアフレーム制御装置：ドアフレームシール用コントローラーユニット。  
コントローラをドアフレームの一部として配置すると、閉じたときにドアをロックし、ドアがシールを形成するのに十分に閉じているかどうかを確認できます。  
制御したいフレームごとに1つのコントローラーのみを配置する必要があります。

英語原文

Controller unit for sealing door frames.  
Placing the controller as part of a door frame will let you lock the door when closed, and check whether the door is closed enough to be forming a seal.  
Only one controller shuld be placed per frame.

※カスタムドアの密閉を制御するパーツ、Seal Lock(密閉)されたドアは外力が加わっても開かない。  
価格 -$、サイズ（WxDxH）2x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:10 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Seal Lock（密閉） | オンで扉を密閉、オフで解除 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Seal State（密閉状態） | 密閉されている時はオンを出力 |

※カスタムドアについて  
カスタムドアを作る際のアイテム群は６種類あります(画像参照)

|  |  |
| --- | --- |
| [20190327041914_1.jpg](https://cdn.wikiwiki.jp/to/w/sbarjp/MECHANICS/::attach/20190327041914_1.jpg?rev=62c6a27c29940b7604d66693a249ff9c&t=20190327042048 "20190327041914_1.jpg") | 赤→DOOR FRAME CONTROLLER |
| 青→DOOR FRAME CORNER |
| 黄→DOOR FRAME EDGE |
| 緑→ROBOTIC DOOR HINGE |
| オレンジ→DOOR PANEL CORNER |
| 紺→DOOR PANEL EDGE |

・自由な大きさの四角い密閉扉が作れる。  
・ROBOTIC DOOR HINGEを使わずに、他の様々な方法で開閉することも可能。  
・フレームとパネルは必ず閉じた状態で設置する。それぞれ別の場所(開いた状態)に設置した場合、閉じても密閉することは出来ず水を通してしまう。

## DOOR FRAME CORNER

ドアフレームコーナー(隅)：密閉された流体コンパートメントへの開口部を構築するためのコーナー部品。  
有効なフレームを作成するには、一貫した方向でフレームパーツの連続ループがありフレーム内に他のパーツがないことが必要です。

英語原文

A corner piece for building openings to sealed fluid compartments.  
To create a valid frame, there must be a continuous loop of frame parts in a consistent orientation with no other parts inside the frame.

※カスタムドアの四隅用パーツ、DOOR FRAME EDGEと合わせて外側のフレームを構成する。  
価格 -$、サイズ（WxDxH）2x2x1（Ｌ字形状）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:15 |

## DOOR FRAME EDGE

ドアフレームエッジ(縁)：密封された流体コンパートメントへの開口部を構築するための直線エッジ。  
有効なフレームを作成するには、一貫した方向でフレームパーツの連続ループがありフレーム内に他のパーツがないことが必要です。

英語原文

A corner piece for building openings to sealed fluid compartments.  
To create a valid frame, there must be a continuous loop of frame parts in a consistent orientation with no other parts inside the frame.

※カスタムドアの縁用パーツ、DOOR FRAME CORNERと合わせて外側のフレームを構成する。  
価格 -$、サイズ（WxDxH）1x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:5 |

## DOOR PANEL CORNER

ドアパネルコーナー(角)：ドアパネルを構築するためのコーナー部品。  
外面と同じ高さのブロックで満たされた有効なドアパネル片。  
ドアパネルは、ドアフレームを埋めフレーム内を閉じた位置に構築する必要もあります。

英語原文

A corner piece for building door panels.  
A valid door panel pieces, filled with blocks flush to the outer face.  
Door panels must also fill a door frame and be built in their closed position within the frame to be valid.

※カスタムドアを構成する四つ角用パーツ、DOOR PANEL EDGEと合わせて内側のパネルを構成する。  
価格 -$、サイズ（WxDxH）1x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:5 |

## DOOR PANEL EDGE

ドアパネルエッジ(端)：ドアパネルを構築するためのストレートエッジピース。  
外面と同じ高さのブロックで満たされた有効なドアパネル片。  
ドアパネルは、ドアフレームを埋めフレーム内を閉じた位置に構築する必要もあります。

英語原文

A straight edge piece for building door panels.  
A valid door panel can be created with a loop of door panel pieces, filled with blocks flush to the outer face.  
Door panels must also fill a door frame and be built in their closed position within the frame to be valid.

※カスタムドアの端用パーツ、DOOR PANEL CORNERと合わせて内側のパネルを構成する。  
価格 -$、サイズ（WxDxH）1x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:5 |

## ELECTRIC CONNECTOR

電気コネクター：車両間で電気エネルギーを転送するために使用できる小さな電気コネクター。  
2つの電気コネクタが近接している場合は接続されます。  
接続すると、電気エネルギーがコネクタ間を自由に流れます。

英語原文

A small electric connector that can be used to transfer electric energy between vehicles.  
Two electric connectors will attach when they are within close proximity.  
when connected, electric energy will flow freely between the connectors.

※電気系統を外部とつなぐためのコネクタ、[e][q]キーで手に持つことができる。(接続中に掴んで外す事が出来る)  
※コネクターによって接続したバッテリーの量は容量の割合で平均化される。  
例：残量0.5と1.0のSmallBatteryを繋げると残量はどちらも0.75になる。  
　　残量0.5のSmallBatteryと1.0のMediumBatteryを繋げると残量はどちらも0.944になる。  
価格 -$、サイズ（WxDxH）1x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Connector Release（接続解除） | オンで解除、オフで接続 |
| ◆ Composite Data Send（複合データ送信） | 接続先に送信する複合データの入力 |
| ◆ Video Data Send（映像データ送信） | 接続先に送信する映像データの入力 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Connected（接続） | 接続されている時にオンを出力 |
| ◆ Composite Data Receive（複合データ受信） | 接続先から受信する複合データの出力 |
| ◆ Video Data Receive（映像データ受信） | 接続先から受信する映像データの出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 接続先と電気を共有する |

## FLUID CONNECTOR

流体コネクター：車両間で流体を移送するために使用できる流体コネクタ。  
2つの流体コネクタが近接している場合は接続されます。  
接続すると、流体はコネクタ間を自由に流れます。

英語原文

A fluid connector that can be used to transfer fluid between vehicles.  
Two fluid connectors will attach when they are within close proximity.  
When connected, fluid will flow freely between the connectors.

※流体系統を外部とつなぐためのコネクタ、[e][q]キーで手に持つことができる。(接続中に掴んで外す事が出来る)  
※流体コネクターで二つのタンクを接続するとそれぞれの設置された高さや内容量、圧力の高い方から低い方へ流体が流れる。流体の流れは複雑なので要検証。  
価格 -$、サイズ（WxDxH）1x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Connector Release（接続解除） | オンで解除、オフで接続 |
| ◆ Composite Data Send（複合データ送信） | 接続先に送信する複合データの入力 |
| ◆ Video Data Send（映像データ送信） | 接続先に送信する映像データの入力 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Connected（接続） | 接続されている時にオンを出力 |
| ◆ Composite Data Receive（複合データ受信） | 接続先から受信する複合データの出力 |
| ◆ Video Data Receive（映像データ受信） | 接続先から受信する映像データの出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作に電力は必要ない※ |

※ReleaseやConnectedの動作、信号のやり取りなど電力を接続しなくても動作する。

## GEARBOX

ギアボックス：接続した動力全体のトルクと速度を変更するためのギアボックス。  
比率は、プロパティで設定できる2つの値の間で切り替えることができます。

英語原文

Gearbox for changing the torque and speed across power connections.  
The ratio can be toggled between two values which can be set in the properties.

※ADVANCED VEHICLES専用パーツ  
※Power AとPower Bの間で動力系の回転数とトルクを変更する装置です。  
　設定できるギア比は、Aの方が大きい値のみで、A:B=1:-1と1:1から3:1までのいくつかの整数比が選べます。\*1  
　A:B=2:1に設定し、Aを入力(エンジン側)、Bを出力(例えばプロペラ側)とすれば、Aが2回転するとBが1回転するので、回転数は半分になりトルクは2倍になります。  
※設置する向きによって減速/増速を変える事ができます。  
　側面に書かれている青い三角印を見て、末広がりになっている方のPower Aをエンジンからの入力にすると減速ギア、逆にそれを出力にすると増速ギアとなります。  
　[![WIKI_573090_20190921105649_1_GEARBOX_33_0.png](https://cdn.wikiwiki.jp/to/w/sbarjp/FAQ/::ref/WIKI_573090_20190921105649_1_GEARBOX_33_0.png.webp?rev=99c0f203a37d398559447539cb3ffd8e&t=20190921113134 "WIKI_573090_20190921105649_1_GEARBOX_33_0.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/FAQ/::attach/WIKI_573090_20190921105649_1_GEARBOX_33_0.png?rev=99c0f203a37d398559447539cb3ffd8e&t=20190921113134 "WIKI_573090_20190921105649_1_GEARBOX_33_0.png")  
※設定できるギア比が2組あり、Gear Switch入力によってどちらのギア比を使うか切り替えられます。オフの時がRatio 1。  
※ギア比の切り替えのみならず、Ratio 1のみを使う場合でもギア比の設定を有効にするには電力供給が必要です。  
　電力がないと設定値に関わらず1:1でしか伝達されません。  
※この装置1つにつき5%の動力伝達損失があります。何段も直列に繋ぐのは損です。  
価格 -$、サイズ（WxDxH）1x2x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Gear Switch（ギア切替え） | 設定されたギア比を切り替える(Off=Ratio 1 / On=Ratio 2) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power A（動力Ａ） | 動力配管を接続 |
| ◆ Power B（動力Ｂ） | 動力配管を接続 |
| ◆ Electric（電力） | ギア変更の動作用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Ratio 1（ギア比１） | -1:1 / 1:1 / 6:5 / 3:2 / 9:5 / 2:1 / 5:2 / 3:1 | ギア比の選択(A:B) |
| Ratio 2（ギア比２） | -1:1 / 1:1 / 6:5 / 3:2 / 9:5 / 2:1 / 5:2 / 3:1 | ギア比の選択(A:B) |

## GEARBOX 1×1

※複数のサイズがあるが、性能は同じである(2022/06/24現在)

英語原文

Gearbox for changing the torque and speed across power connections.  
The ratio can be toggled between two values which can be set in the properties.

## GEARBOX 3×3

※複数のサイズがあるが、性能は同じである(2022/06/24現在)

英語原文

Gearbox for changing the torque and speed across power connections.  
The ratio can be toggled between two values which can be set in the properties.

## GEARBOX 5×5

※複数のサイズがあるが、性能は同じである(2022/06/24現在)

英語原文

Gearbox for changing the torque and speed across power connections.  
The ratio can be toggled between two values which can be set in the properties.

## HARDPOINT CONNECTOR ATTACHIMENT

A hardpoint connector for building detachable vehicle sections.  
A hardpoint body will connect to a hardpoint attachment when correctly aligned,  
fixing the two components in place while transferring logic and fluid.

※バッテリーを内蔵しているので電力供給が可能

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆Composite Data Send（複合データ送信） | 接続先に送信する複合データの入力 |
| ◆Video Data Send（映像データ送信） | 接続先に送信する映像データの入力 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Launched（） | 接続先のLaunchがオンになった時、オン信号を出力する |
| ◆ Composite Data Receive（複合データ受信） | 接続先から受信する複合データの出力 |
| ◆ Video Data Receive（映像データ受信） | 接続先から受信する映像データの出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ fluid（流体） | 接続先とやり取りする流体配管の接続 |
| ◆ Electric（電力） | 動作用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Ordinance（） | Utility / Fuel / Unguided Bomb / Laser Guided Bomb / GPS Guided Bomb / Rocket / Rocket Pod / Laser Guided Missile / GPS Guided Missile / Radar Guided Missile / Torpedo / Cannon | 選択したOrdinanceに対応した数値がHARDPOINT CONNECTOR BODYのOrdinance Typeに出力される |

Ordinance Type表

| Ordinance Type | Ordinance |
| --- | --- |
| 1 | Utility |
| 2 | Fuel |
| 3 | Unguided Bomb |
| 4 | Laser Guided Bomb |
| 5 | GPS Guided Bomb |
| 6 | Rocket |
| 7 | Rocket Pod |
| 8 | Laser Guided Missile |
| 9 | GPS Guided Missile |
| 10 | Radar Guided Missile |
| 11 | Torpedo |
| 12 | Cannon |

## HARDPOINT CONNECTOR ATTACHIMENT(ROUND)

SOLID ROCKET FUEL(SMALL)のような外見のハードポイント

## HARDPOINT CONNECTOR BODY

A hardpoint connector for building detachable vehicle sections.  
A hardpoint body will connect to a hardpoint attachment when correctly aligned,  
fixing the two components in place while transferring logic and fluid.  
The hardpoint body can release the connection by receiving an on/off input signal.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Release（） | 切り離し |
| ◆ Launch（） | 接続先のLaunchedをオンにして切り離し |
| ◆Composite Data Send（複合データ送信） | 接続先に送信する複合データの入力 |
| ◆Video Data Send（映像データ送信） | 接続先に送信する映像データの入力 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Ordinance Type（） | 接続先のOrdinance Typeを出力 |
| ◆ Composite Data Receive（複合データ受信） | 接続先から受信する複合データの出力 |
| ◆ Video Data Receive（映像データ受信） | 接続先から受信する映像データの出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ fluid（流体） | 接続先とやり取りする流体配管の接続 |
| ◆ Electric（電力） | 動作用電力 |

Ordinance Type表

| Ordinance Type | Ordinance |
| --- | --- |
| 0 | 未接続時 |
| 1 | Utility |
| 2 | Fuel |
| 3 | Unguided Bomb |
| 4 | Laser Guided Bomb |
| 5 | GPS Guided Bomb |
| 6 | Rocket |
| 7 | Rocket Pod |
| 8 | Laser Guided Missile |
| 9 | GPS Guided Missile |
| 10 | Radar Guided Missile |
| 11 | Torpedo |
| 12 | Cannon |

## HINGE CONNECTOR

ヒンジコネクター：2つ以上の車両を一緒に取り付けるために使用できる小さな磁気コネクター。  
2つのコネクタが近接していて、両方のスイッチがオンになっている場合に接続されます。それらは長辺に沿って接続し、この軸に沿って曲がります。  
オン/オフ出力により、このコネクタが現在何かに接続されているかどうかを確認できます。

英語原文

A small magnetic connector that can be used to attach two or more vehicles together.  
Two connectors will attach when they are within close proximity and both are switched on. They will connect along their long edge and hinge along this axis.  
An on/off output allows you to check whether or not this connector is currently attached to anything.

※接続中に揺れる方向を制限できるコネクター、[e][q]キーで手に持つことができる(接続中は掴んで外す事は出来ない)  
　コネクター同士の向きが合っていないと非常に接続しにくい。  
価格 -$、サイズ（WxDxH）3x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:3 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Magnet Toggle（磁気切替え） | On/Off(起動／解除) |
| ◆ Composite Data Send（複合データ送信） | 接続先に送信する複合データの入力 |
| ◆ Video Data Send（映像データ送信） | 接続先に送信する映像データの入力 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Connected（接続） | 接続されている時にオンを出力 |
| ◆ Composite Data Receive（複合データ受信） | 接続先から受信する複合データの出力 |
| ◆ Video Data Receive（映像データ受信） | 接続先から受信する映像データの出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

※電力はコネクター同士が引き合う際に消費し接続中には消費しない。引き合う距離は約１ｍ(4ブロック)(v1.2.12にて確認)

## HINGED DOCK DOOR

ヒンジドックドア：オン/オフ信号を使用して開閉できるヒンジドア。（旧：DOOR DOCK LARGE）

英語原文

Hinged door that can be opened and closed using an on/off signal.

※大型のドッキングハッチ。片面がコネクターになっており同じHINGED DOCK DOORと接続し開閉することができる。  
ロジック例：「On/Off Received」を開閉用ボタン(TOGGLE BUTTON)の「Extarnal Input」へ  
　開閉用ボタンの出力「Toggled」を「On/Off Sent」と「Door Open/Close」へ繋げると、接続した扉同士で開閉が可能になる。  
※電力が供給されない場合、重力などの外力で容易に開閉します。  
　電力の有無に関わらず、開いている場合は水を通し閉じている場合は水を通しません。  
価格 -$、サイズ（WxDxH）5x9x1（マグネット側の面と扉開閉部以外が設置面になっている）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:20 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Door Open/Close（扉開閉） | オンで扉を開きオフで閉じる |
| ◆ Magnet Toggle（磁気切替え） | On/Off(起動／解除) |
| ◆ On/Off Sent（送信するオンオフ信号） | 接続したドアに送信する信号 |
| ◆ Number Sent（送信する数値） | 接続したドアに送信する数値 |
| ◆ Composite input（複合入力） | コンポジット入力 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Connected（接続） | 接続されている時にオンを出力 |
| ◆ On/Off Received（受信したオンオフ信号） | 接続したドアから受信した信号 |
| ◆ Number Received（受信した数値） | 接続したドアから受信した数値 |
| ◆ Composite output（複合出力） | コンポジット出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

※電力は消費しないが各動作には電力の接続が必要。引き合う距離は約１ｍ(4ブロック)(v1.2.12にて確認)

## HINGED DOCK HATCH

ヒンジドックハッチ：オン/オフ信号を使用して開閉できるヒンジドア。（旧：DOOR DOCK SMALL）

英語原文

Hinged door that can be opened and closed using an on/off signal.

※小型のドッキングハッチ。片面がコネクターになっており同じHINGED DOCK HATCHと接続し開閉することができる。  
ロジック例：「On/Off Received」を開閉用ボタン(TOGGLE BUTTON)の「Extarnal Input」へ  
　開閉用ボタンの出力「Toggled」を「On/Off Sent」と「Door Open/Close」へ繋げると、接続した扉同士で開閉が可能になる。  
※電力が供給されない場合、重力などの外力で容易に開閉します。  
　電力の有無に関わらず、開いている場合は水を通し閉じている場合は水を通しません。  
価格 -$、サイズ（WxDxH）5x5x1（マグネット側の面と扉開閉部以外が設置面になっている）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:15 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Door Open/Close（扉開閉） | オンで扉を開きオフで閉じる |
| ◆ Magnet Toggle（磁気切替え） | On/Off(起動／解除) |
| ◆ On/Off Sent（送信するオンオフ信号） | 接続したドアに送信する信号 |
| ◆ Number Sent（送信する数値） | 接続したドアに送信する数値 |
| ◆ Composite input（複合入力） | コンポジット入力 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Connected（接続） | 接続されている時にオンを出力 |
| ◆ On/Off Received（受信したオンオフ信号） | 接続したドアから受信した信号 |
| ◆ Number Received（受信した数値） | 接続したドアから受信した数値 |
| ◆ Composite output（複合出力） | コンポジット出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

※電力は消費しないが各動作には電力の接続が必要。引き合う距離は約１ｍ(4ブロック)(v1.2.12にて確認)

## HINGED DOOR

ヒンジドア：手で開閉し、オン/オフ信号を使用してロックできるヒンジ付きドア。

英語原文

Hinged door that can be opened and closed using an on/off signal.

※電気が無くとも開閉可能な扉  
価格 -$、サイズ（WxDxH）4x7x1（ヒンジ軸の柱部分が設置面になっている）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:20 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Lock（ロック） | オンで扉をロック |

## HINGED HATCH

ヒンジハッチ：手で開閉し、オン/オフ信号を使用してロックできるヒンジ付きドア。

英語原文

Hinged door that can be opened and closed by hand and locked using an on/off signal.

※電気が無くとも開閉可能な扉  
価格 -$、サイズ（WxDxH）4x3x1（ヒンジ軸の柱部分が設置面になっている）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:15 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Lock（ロック） | オンで扉をロック |

## KEY BUTTON

キーボタン：アクティブ化する前に、設定された期間押し続ける必要があるボタン。  
一度アクティブにすると、ボタンをもう一度押すとすぐに非アクティブになります。  
選択ツールでこのコンポーネントを選択することにより、保持期間をカスタマイズできます。  
外部入力は、別のコンポーネントの出力を使用してダウンできます。ボタンのデフォルト状態は、selectコンポーネントでボタンを選択することで構成できます。

英語原文

A button that must be held down for a set duration before activating.  
Once activated, pressing the button again will deactivate it instantly.  
The hold duration can be custamised by selecting this component with the select tool.  
The External input can down using the output of another component. The button's default state can be configured by selecting it with the select component.

※[e][q]キー又は外部入力信号で操作できるボタン。  
　設定した長さ以上押す事でオンになるトグルボタン。オフにする際は直ぐ切り替わる。  
価格 -$、サイズ（WxDxH）1x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ External Input（外部入力） | 設定した時間オン信号を受けるとオンになる |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Activated（起動） | ボタンのオンオフ状態を出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称記入欄 | カーソルを合わせた時に表示される名称 |
| Default State（初期状態） | Off / On | ボタンの初期状態を設定 |
| Hold Duration（ホールド時間） | 0.1～5.0(sec)（デフォルト値1.0sec） | オンになるまでのホールド時間の設定 |

## LARGE CONNECTOR

大型コネクター：2つ以上の車両を一緒に取り付けるために使用できる磁気コネクタ。  
2つの大きなコネクタが近接していて、両方がオンになっている場合に接続されます。  
追加の入力と出力により、接続された2つの磁石間で電力と信号を送受信できるため、リンクされた車両を制限付きで制御できます。  
追加のオン/オフ出力により、このコネクタが現在何かに接続されているかどうかを確認できます。

英語原文

A magnetic connector that can be used to attach two or more vehicles together.  
Two large connectors will attach when they are within close proximity and both are switched on.  
The additional inputs and outputs allowyou to send and receive power and signals between two connected magnets, giving you a limited amount of control over a linked vehicle.  
An additional on/off output allows you to check whether or not this connector is currently attached to anything.

※動力や流体などを伝える大型コネクター、[e][q]キーで手に持つことができる(接続中は掴んで外す事は出来ない)  
　一度接続すると基本的には回転したりせず向きは固定される。  
　ただし、ブロック側面の面(４面)がそろうように接続する為、動力と流体の接続部が同じ方向で接続するとは限らない。  
価格 -$、サイズ（WxDxH）3x3x2（3x3の接続部があり、側面に動力と流体用の接続がある）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:20 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Magnet Toggle（磁気切替え） | On/Off(起動／解除) |
| ◆ On/Off Sent（オンオフ送信） | 接続先に送信するオンオフ信号を入力 |
| ◆ Number Sent（数値送信） | 接続先に送信する数値を入力 |
| ◆ Composite Data Send（複合データ送信） | 接続先に送信する複合データの入力 |
| ◆ Video Data Send（映像データ送信） | 接続先に送信する映像データの入力 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Number Received（数値受信） | 接続先から受信した数値の出力 |
| ◆ Connected（接続） | 接続されている時にオンを出力 |
| ◆ On/Off Received（オンオフ受信） | 接続先から受信したオンオフ信号の出力 |
| ◆ Composite Data Receive（複合データ受信） | 接続先から受信した複合データの出力 |
| ◆ Video Data Receive（映像データ受信） | 接続先から受信した映像データの出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 接続先とやり取りする動力配管の接続 |
| ◆ Electric（電力） | 動作用電力 |
| ◆ Fluid（流体） | 接続先とやり取りする流体配管の接続 |

※電力はコネクター同士が引き合う際に消費し接続中には消費しない。引き合う距離は約１ｍ(4ブロック)(v1.2.12にて確認)

## LARGE KEYPAD

大きなキーパッド：2つの数字を入力できるキーパッド。  
キーパッドを押すと、2つの数値を入力できるメニューとウェイポイントの座標をすばやく入力するためのボタンが表示されます。  
確認ボタンをクリックすると、キーパッドのパルスノードから短いパルスが発生し、保存されている数値が他の出力ノードから継続的に出力されます。  
オン/オフ信号は、キーパッドのバックライトを有効にするかどうかを制御します。

英語原文

A keypad that allows 2 numbers to be input.  
Pressing the keypad will show a menu where the 2 numbers can be entered, along with a button for quickly inputting waypoint coordinates.  
A short pulse will be emitted from the keypad's pulse node when the confirm button is clicked and the stored numbers will be continuously output from the other output nodes.  
An on/off signal controls whether or not the keypad's backlight is enabled.

※２つの数値を入力できるキーボード、[e][q]キーで入力画面を開くことができる。  
　入力画面にはOutputA、OutputBが現在出力している値、OutputA、OutputBそれぞれへの入力欄  
　入力画面を閉じるボタン、ウェイポイント座標を入力欄に入力するボタン、入力した数値を反映するボタンがある。  
※入力画面を開いていてもキャラクターの移動や座席の乗り降りが可能なので操作ミスに注意。  
価格 -$、サイズ（WxDxH）2x1x2（2x1x1の本体、キーボードの面以外が設置面になっている）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Backlight（バックライト） | On/Off(点灯／消灯) |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Output A（出力値Ａ） | 入力された数値Ａの出力 |
| ◆ Output B（出力値Ｂ） | 入力された数値Ｂの出力 |
| ◆ Pulse（パルス） | 数値が入力されると短いパルスを出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | バックライト及びパルス発信用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称記入欄 | カーソルを合わせた時に表示される名称 |
| Output A Label（出力Ａ名称） | 名称記入欄 | 数値入力画面に表示される名称 |
| Output B Label（出力Ｂ名称） | 名称記入欄 | 数値入力画面に表示される名称 |

## LINEAR TRACK BASE

リニアトラックベース(基部)：モジュラーリニアトラックに沿って移動するスライダー。  
Linear Track Extensionコンポーネントを使用して直線路を作成できます。  
この基本コンポーネントは、構築可能な3つのブロックを提供します。  
一対のオン/オフ信号により、スライダーの上下運動を制御でき、数値出力により、スライダーの開始位置からのオフセットを測定できます。  
複数のスライダーベースを同じトラックに沿って走らせることができます。  
上昇/下降速度は選択ツールで設定できます。

英語原文

A slider that moves along a modular linear track.  
You can build the track using the Linear Track Extension component.  
This base component provides 3 blocks that can be built on.  
A pair of on/off signals allow you to control the up and down motion of the slider, and a numerical output lets you measure the slider's offset from its starting position.  
Multiple slider bases can run along the same track.  
The up/down speed can be configured by select tool.

※レール上を移動する台車でレール部3x2マスと台車部3マスで構成されています。それぞれ別のパーツ扱いです。  
　レール部分にLINEAR TRACK EXTENSIONのレールを繋げるように配置することで、レール上に台車を移動させることができます。  
※大きな力が掛かると動作が阻害される事があります。  
　電力が供給されない場合でもある程度の保持力があります。  
※レール側と台車側それぞれに動力と流体を通す接続部があります。  
　また、同じレール上に複数のベースを設置しても動力や流体はそれぞれに流れ、共有することはありません。  
※Down/Up、ともにオンの時は停止する。操作状態にかかわらず停止している時は電力を消費しない。  
価格 -$、サイズ（WxDxH）3x1x3

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass）、動力（motor）、速度（motorspeed） | mass:3、motor:20000、motorspeed:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Down（下がる） | オンで－方向へ動作 |
| ◆ Up（上がる） | オンで＋方向へ動作 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Slider Position（スライダー位置） | レール上のスライダー位置、初期位置が0 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | スライダー動作用電力 |
| ◆ Power（動力） | レール側と台車側に接続された配管の動力を通す |
| ◆ Fluid（流体） | レール側と台車側に接続された配管の流体を通す |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Speed（速度） | 0.1～5.0(デフォルト値は1.0) | 台車の移動速度設定 |
| Max Power（最大出力） | 0～100％ | トルクの設定 |
| Gear Ratio（ギア比） | 1:1 / 1:2 / 1:4 / 1:8 / 1:16 / 1:32 | ギア比の選択 |

## LINEAR TRACK EXTENSION

リニアトラックエクステンション(拡張)：直線路を構築するために使用できる拡張部品。  
リニアトラックベースを機能させるには、トラックに沿ってどこかに取り付ける必要があります。

英語原文

An extension piece that can be used to build linear tracks.  
A Linear Track Base must be attached somewhere along the track for it to function.

※LINEAR TRACK BASE用のレールです、スリットが繋がるように並べてください。  
価格 -$、サイズ（WxDxH）3x1x2（見た目は３マスですがレールの部分が少し出ていて見た目より高さがある）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:3 |

## LOCKABLE BUTTON

ロックボタン：ロック解除時にのみ操作できるトグルボタン。  
プレーヤーの操作を許可するには、ボタンのロック解除ノードにオン信号を送信する必要があります。  
ボタンのデフォルト状態は、selectコンポーネントでボタンを選択することで構成できます。

英語原文

A toggle button that can only be interacted with when unlocked.  
An on signal must be sent to the button's unlock node to allow player interaction.  
The button's default state can be configured by selecting it with the select component.

※外部入力信号でロックを解除後に[e][q]キーで操作できるボタン。  
価格 -$、サイズ（WxDxH）1x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Unlock（ロック解除） | オン信号を受けている間ボタンのロックが解除される |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Toggled（切替え） | ボタンのオンオフ状態を出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称記入欄 | カーソルを合わせた時に表示される名称 |
| Default State（初期状態） | Off / On | ボタンの初期状態を設定 |

## MAG ALL

マグオール：ほとんどの表面に取り付けられる小さなコネクター。  
コネクタがアクティブな間、端は光り接触するほとんどの表面にくっつきます。  
十分な応力（200）がかかると、接続が切断されます。

英語原文

A Small connector that will attach to most surfaces.  
While the connector is active the end will glow and it will stick to most surfaces that it touches.  
The connection will break if enough stress (200) is applied.

※様々な物をくっつける為のコネクタ、[e][q]キーで手に持つことができる(接続中は掴んで外す事が出来ない)  
　Forceの出力値が200を超える(高い負荷が掛かった)場合、接続が切断されます。  
価格 -$、サイズ（WxDxH）1x1x3（見た目は他の小型コネクターと同じ大きさ、ロジックノードの関係か設置判定は３マス分）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Magnet Toggle（磁気切替え） | On/Off(起動／解除) |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Connected（接続） | 接続されている時にオンを出力 |
| ◆ Force（負荷） | 接続部にかかる負荷値の出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

※電力は消費しないが各動作には電力の接続が必要。(v0.10.15にて確認)

## PISTON SUSPENSION

ピストンサスペンション：衝撃を抑える油圧式スプリングピストン。  
陸上車両の取り回しを改善するために使用できるショックアブソーバー。

英語原文

A shock absorber that can be used to improve handling of land-based vehicles.  
A dampened hydraulic sprung piston.

※設置時は３マス、フィールドに出すと４マス分の長さに伸びて衝撃を緩和する。  
　想定される衝撃の強さや載せる重量に合わせてMaxPowerを調整する。  
価格 -$、サイズ（WxDxH）1x1x3（見た目は３マス、垂直方向の２面に設置出来る）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:20 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Max Power（最大出力） | 0～100％ | スプリングの強さ |

## PIVOT

ピボット：自由に動くことができる基本的な軸。  
軸は両方向に0.25回転できます。

英語原文

A basic pivot that can move freely.  
The pivot can rotate to 0.25 turns in both directions.

※動力の無いフリーな軸、説明には±0.25(180度)とあるが実際にはもう少し曲がる。  
　また大きな力が掛かると見た目以上に曲がったり軸がズレる事もあります。  
価格 -$、サイズ（WxDxH）1x1x3（真ん中の１マスを軸に曲がる）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |

## PIVOT (POWER)

動力ピボット：自由に動くことができる基本的な軸。  
軸は両方向に0.25回転できます。

英語原文

A basic pivot that can move freely.  
The pivot can rotate to 0.25 turns in both directions.

価格 $20、サイズ（WxDxH）1x1x3

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 機械的エネルギー伝達のための動力接続（親） |
| ◆ Power（動力） | 機械的エネルギー伝達のための動力接続（子） |

## PNEUMATIC PISTON

空気式ピストン：伸縮可能な空気式ピストン。  
標準値入力は、ピストンロッドが移動する目標位置を設定します。ロッドの現在位置を測定するための出力もあります。  
ピストンは1メートルの長さで拡張でき、拡張すると合計2.25m（9ブロック）収縮すると1.25m（5ブロック）になります。  
ピストンの速度は、選択ツールで選択することにより構成できます。

英語原文

A pneumatic piston that can be expanded and contracted.  
A standard value input sets the target position that the piston rod should move to. There is also an output for taking a measurement of the rod's current position.  
The piston can expand by a length of 1 metre, making it a total of 2.25m(9 blocks)tall when expanded and 1.25m(5 blocks)tall when contracted.  
The piston's speed can be configured by selecting it with the select tool.

※設置時は７マス、伸縮させて５～９マスの長さになる。  
※大きな力が掛かると動作範囲以上に伸縮したり軸がズレる事もあります。  
　電力が供給されない場合でもある程度の保持力があります。  
価格 -$、サイズ（WxDxH）1x1x9（垂直方向の２面に設置出来る）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass）、動力（motor）、速度（motorspeed） | mass:5、motor:200000、motorspeed:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Piston Rod Target Position（ピストンロッド目標位置） | -1～1 目標位置の設定(0を中心に±２マス) |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Piston Rod Position（ピストンロッド位置） | -0.5～0.5 ピストンロッドの位置(初期位置が0) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | スライダー動作用電力 |
| ◆ Fluid（流体） | 軸受け側と先端側に接続された配管の流体を通す |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Speed（速度） | 0.1～5.0(デフォルト値は1.0) | 速度の設定 |
| Max Power（最大出力） | 0～100％ | トルクの設定 |
| Gear Ratio（ギア比） | 1:1 / 1:2 / 1:4 / 1:8 / 1:16 / 1:32 | ギア比の選択 |

## PUSH BUTTON

押しボタン：[e]か[q]を押したときに、オンまたはオフの信号の送信を切り替えるボタン。  
外部オン/オフ信号を使用して、ボタンが押されているかどうかを制御することもできます。これにより、複数のボタンを連結して出力を統一できます。  
ボタンのデフォルト状態は、selectコンポーネントでボタンを選択することで構成できます。

英語原文

A button that toggles between sending an on or off signal when you press [e] on it.  
An external on/off signal can also be used to control whether or not the button is pressed, allowing you to chain multiple buttons together to unify their outputs.  
The button's default state can be configured by selecting it with the select component.

※[e][q]キーや外部入力信号で操作できる押しボタン。  
　押している間、又はオン信号を維持している間はオン信号を出力します。  
※ボタンの意匠が見えない裏側や側面からでも操作は可能。  
価格 -$、サイズ（WxDxH）1x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ External Input（外部入力） | オン信号を受けている間オンになる |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Toggled（切替え） | ボタンのオンオフ状態を出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称記入欄 | カーソルを合わせた時に表示される名称 |

※説明文にボタンのデフォルト状態を選択可能とあるが、そのような設定は無い。

## PUSH BUTTON (2 SIDED)

押しボタン両面：[e]か[q]を押したときに、オンまたはオフの信号の送信を切り替えるボタン。  
外部オン/オフ信号を使用して、ボタンが押されているかどうかを制御することもできます。これにより、複数のボタンを連結して出力を統一できます。  
ボタンのデフォルト状態は、selectコンポーネントでボタンを選択することで構成できます。

英語原文

A button that toggles between sending an on or off signal when you press [e] on it.  
An external on/off signal can also be used to control whether or not the button is pressed, allowing you to chain multiple buttons together to unify their outputs.  
The button's default state can be configured by selecting it with the select component.

※[e][q]キーや外部入力信号で操作できる押しボタン。裏側にもボタンの意匠がある。  
　押している間、又はオン信号を維持している間はオン信号を出力します。  
※ボタンの意匠が見えない側面からでも操作は可能。  
価格 -$、サイズ（WxDxH）1x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ External Input（外部入力） | オン信号を受けている間オンになる |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Toggled（切替え） | ボタンのオンオフ状態を出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称記入欄 | カーソルを合わせた時に表示される名称 |

※説明文にボタンのデフォルト状態を選択可能とあるが、そのような設定は無い。

## ROBOTIC DOOR HINGE

機械的ドアヒンジ：密閉可能なカスタムドア用の電動ロボットヒンジ。  
ヒンジの可動範囲は、一方向に0.25回転です。  
標準入力値は、ピボットの動作範囲内のターゲット方向を設定します。  
ヒンジの測定された回転は、その出力から読み取ることができます。  
選択ツールで選択することにより、ヒンジの速度を構成できます。

英語原文

A powered robotic hinge for custom sealable doors.  
The hinge has a range of motion of 0.25 turns in one direction.  
A standard input value sets the target orientation within the pivot's range of motion.  
The measured rotation of the hinge can be read from its output.  
The hinge's speed can be configured by selecting it with the select tool.

※大きな力が掛かると動作範囲以上に伸縮したり軸がズレる事もあります。  
　電力が供給されない場合でもある程度の保持力があります。  
価格 -$、サイズ（WxDxH）3x1x3（真ん中の１列を軸に曲がる）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass）、動力（motor）、速度（motorspeed） | mass:3、motor:400、motorspeed:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotation Target（角度目標） | -1～1 目標角度の設定値(0を中心に±90度) |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Curent Rotation（現在角度） | -0.25～0.25 現在のヒンジ角度(初期位置が0) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | スライダー動作用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Speed（速度） | 0.1～5.0(デフォルト値は1.0) | 速度の設定 |
| Max Power（最大出力） | 0～100％ | トルクの設定 |
| Gear Ratio（ギア比） | 1:1 / 1:2 / 1:4 / 1:8 / 1:16 / 1:32 | ギア比の選択 |

## ROBOTIC HINGE

機械的ヒンジ：動作範囲内で入力値の方向を向く、動力を備えたロボットヒンジ。  
ヒンジは、両方向に0.25回転の可動範囲を持っています。  
標準入力値は、ピボットの動作範囲内のターゲット方向を設定します。  
ヒンジの測定された回転は、その出力から読み取ることができます。  
選択ツールで選択することにより、ヒンジの速度を構成できます。

英語原文

A powered robotic hinge that will orientate towards the input value within its range of motion.  
The hinge has a range of motion of 0.25 turns in both direction.  
A standard input value sets the target orientation within the pivot's range of motion.  
The measured rotation of the hinge can be read from its output.  
The hinge's speed can be configured by selecting it with the select tool.

※大きな力が掛かると動作範囲以上に伸縮したり軸がズレる事もあります。  
　電力が供給されない場合でもある程度の保持力があります。  
価格 -$、サイズ（WxDxH）3x1x3（真ん中の１列を軸に曲がる）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass）、動力（motor）、速度（motorspeed） | mass:3、motor:400、motorspeed:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotation Target（角度目標） | -1～1 目標角度の設定値(0を中心に±90度) |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Curent Rotation（現在角度） | -0.25～0.25 現在のヒンジ角度(初期位置が0) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | スライダー動作用電力 |
| ◆ Power（動力） | ヒンジの両側に接続された配管の動力を通す |
| ◆ Fluid（流体） | ヒンジの両側に接続された配管の流体を通す |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Speed（速度） | 0.1～5.0(デフォルト値は1.0) | 速度の設定 |
| Max Power（最大出力） | 0～100％ | トルクの設定 |
| Gear Ratio（ギア比） | 1:1 / 1:2 / 1:4 / 1:8 / 1:16 / 1:32 | ギア比の選択 |

## ROBOTIC PIVOT (FLUID)

機械的ピボット(流体)：動作範囲内で入力値の方向を向くロボットピボット。  
ピボットは、両方向に0.25回転の可動範囲を持っています。標準入力値は、ピボットの動作範囲内のターゲット方向を設定します。  
ピボットの測定された回転は、その出力から読み取ることができます。  
ピボットの速度は、選択ツールでピボットを選択して構成できます。

英語原文

A robotic pivot that will orientate towards the input value within its range of motion.  
The pivot has a range of motion of 0.25 turns in both directions. A standard input value sets the target orientation within the pivot's range of motion.  
The measured rotation of the pivot can be read from its output.  
The pivot's speed can be configured by selecting it with the select tool.

※ROBOTIC PIVOTは基本位置0から±90度ずつ180度の範囲で入力した数値の角度に向かって動きます。  
　SELECT設定や外からの力次第では設定した角度を維持できずに回る事があります。  
※大きな力が掛かると動作角度(180度)の範囲以上に回転したり軸がズレる事もあります。  
　電力が供給されない場合でもある程度の保持力があります。  
※通常配管は動力と流体を同じ配管内で共有する事が出来るが、このピボットは流体以外を通さない。  
価格 -$、サイズ（WxDxH）3x3x2（3x3の台に1マスの回転軸が付いた形状、台側面と軸に配管接続部がある）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass）、動力（motor）、速度（motorspeed） | mass:9、motor:200、motorspeed:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotation Target（角度目標） | -1～1 目標角度の設定値(0を中心に±90度) |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Curent Rotation（現在角度） | -0.25～0.25 現在の角度(初期位置が0) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |
| ◆ Fluid（流体） | ピボットの両側に接続された配管の流体を通す |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Speed（速度） | 0.1～5.0(デフォルト値は1.0) | 速度の設定 |
| Max Power（最大出力） | 0～100％ | トルクの設定 |
| Gear Ratio（ギア比） | 1:1 / 1:2 / 1:4 / 1:8 / 1:16 / 1:32 | ギア比の選択 |

## ROBOTIC PIVOT (POWER)

機械的ピボット(動力)：動作範囲内で入力値の方向を向くロボットピボット。  
ピボットは、両方向に0.25回転の可動範囲を持っています。標準入力値は、ピボットの動作範囲内のターゲット方向を設定します。  
ピボットの測定された回転は、その出力から読み取ることができます。  
ピボットの速度は、選択ツールでピボットを選択して構成できます。

英語原文

A robotic pivot that will orientate towards the input value within its range of motion.  
The pivot has a range of motion of 0.25 turns in both directions. A standard input value sets the target orientation within the pivot's range of motion.  
The measured rotation of the pivot can be read from its output.  
The pivot's speed can be configured by selecting it with the select tool.

※ROBOTIC PIVOTは基本位置0から±90度ずつ180度の範囲で入力した数値の角度に向かって動きます。  
　SELECT設定や外からの力次第では設定した角度を維持できずに回る事があります。  
※大きな力が掛かると動作角度(180度)の範囲以上に回転したり軸がズレる事もあります。  
　電力が供給されない場合でもある程度の保持力があります。  
※通常配管は動力と流体を同じ配管内で共有する事が出来るが、このピボットは動力以外を通さない。  
価格 -$、サイズ（WxDxH）3x3x2（3x3の台に1マスの回転軸が付いた形状、台側面と軸に配管接続部がある）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass）、動力（motor）、速度（motorspeed） | mass:9、motor:200、motorspeed:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotation Target（角度目標） | -1～1 目標角度の設定値(0を中心に±90度) |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Curent Rotation（現在角度） | -0.25～0.25 現在の角度(初期位置が0) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |
| ◆ Power（動力） | ヒンジの両側に接続された配管の動力を通す |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Speed（速度） | 0.1～5.0(デフォルト値は1.0) | 速度の設定 |
| Max Power（最大出力） | 0～100％ | トルクの設定 |
| Gear Ratio（ギア比） | 1:1 / 1:2 / 1:4 / 1:8 / 1:16 / 1:32 | ギア比の選択 |

## SLIDING CONNECTOR GRIPPER

スライドコネクター グリッパー：コネクタトラックに接続し、それに沿ってスライドするコネクタ。  
グリッパーは、整列して十分に接近するとトラックに接続し、端からスライドするか、コネクターのリリース入力へのオン信号を受信すると分離します。  
ブレーキを有効にして、グリッパーがトラックに沿ってスライドするのを防ぐことができます。  
最初にブレーキを作動させるとき、少量の電力が消費されます。

英語原文

A connector that will attach to and slide along a connector track.  
The gripper will attach to a track when they are aligned and close enough, and will detach when it slides off the end or receives an on signal to the connector release input.  
The brake can be enabled to prevent the gripper from sliding along the track.  
A small amount of electrical power will be consumed when initially activating the brake.

※SLIDING CONNECTOR TRACKで作ったレールを掴むグリッパー。  
　LINEAR TRACKのようにレールの上を移動するが、Release信号でレールとグリッパーを切り離すことも出来る。  
　Brake信号がオフの時は、外力が加わるとレール上を容易に移動する。  
価格 -$、サイズ（WxDxH）1x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Connector Release（接続解除） | オンで解除、オフで接続 |
| ◆ Brake（ブレーキ） | オンでブレーキがかかる |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作に電力は必要ない※ |

※ReleaseやConnectedの動作は電力を接続しなくても動作する。

## SLIDING CONNECTOR TRACK

スライドコネクター トラック：グリッパーを取り付けるトラックを構築するために使用できるコネクター。  
グリッパーコネクタは、位置を合わせて十分近づけるとトラックに取り付けられ、端からスライドすると外れます。

英語原文

A connector that can be used to build a track for grippers to attach to.  
Gripper connectors will attach to the track when aligned and close enough, and will detach when they slide off the end.

※SLIDING CONNECTOR GRIPPERで接続することが出来るパーツです。レールが繋がるように並べてください。  
価格 -$、サイズ（WxDxH）1x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |

## SLIDING DOOR

スライドドア：手で開閉でき、オン/オフ信号でロックできる引き戸。

英語原文

Sliding door that can be opened and closed by hand and locked using an on/off signal.

※電気が無くとも開閉可能な扉  
価格 -$、サイズ（WxDxH）6x1x7（設置面は扉が開かない面と側面のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:20 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Lock（ロック） | オンで扉をロック |

## SLIDING DOOR(ELECTRIC)

電動スライドドア：オン/オフ信号で開閉できる引き戸。（旧：DOOR）

英語原文

Sliding door that can be opened and closed using an on/off signal.

※電力が供給されない場合、重力などの外力で容易に開閉します。  
　電力の有無に関わらず、開いている場合は水を通し閉じている場合は水を通しません。  
価格 -$、サイズ（WxDxH）6x1x7（設置面は扉が開かない面と側面のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:20 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Door Open/Close（扉開閉） | オンで扉を開きオフで閉じる |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## SLIDING HATCH

スライドハッチ：手で開閉でき、オン/オフ信号でロックできる引き戸。

英語原文

Sliding door that can be opened and closed by hand and locked using an on/off signal.

※電気が無くとも開閉可能な扉  
価格 -$、サイズ（WxDxH）6x1x3（設置面は扉が開かない面と側面のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:20 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Lock（ロック） | オンで扉をロック |

## SLIDING HATCH(ELECTRIC)

電動スライドハッチ：オン/オフ信号を使用して開閉できるスライド式ハッチ。（旧：HATCH）

英語原文

Sliding hatch that can be opened and closed using an on/off signal.

※電力が供給されない場合、重力などの外力で容易に開閉します。  
　電力の有無に関わらず、開いている場合は水を通し閉じている場合は水を通しません。  
価格 -$、サイズ（WxDxH）6x1x3（設置面は扉が開かない面と側面のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:15 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Door Open/Close（扉開閉） | オンで扉を開きオフで閉じる |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## SMALL CONNECTOR

小型コネクター：2つ以上の車両を一緒に取り付けるために使用できる小さな磁気コネクター。  
2つの小さなコネクタが近接していて、両方のスイッチがオンになっている場合に接続されます。  
オン/オフ出力により、このコネクタが現在何かに接続されているかどうかを確認できます。

英語原文

A small magnetic connector that can be used to attach two or more vehicles together.  
Two small connectors will attach when they are within close proximity and both are switched on.  
An on/off output allows you to check whether or not this connector is currently attached to anything.

※同じ小型コネクター同士をつなぐためのコネクタ、[e][q]キーで手に持つことができる。(接続中に掴んで外す事が出来ない)  
※ミッションで運搬する物(リサーチドローンやコンテナなど)によく使われている。  
価格 -$、サイズ（WxDxH）1x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Magnet Toggle（磁気切替え） | On/Off(起動／解除) |
| ◆ Composite Data Send（複合データ送信） | 接続先に送信する複合データの入力 |
| ◆ Video Data Send（映像データ送信） | 接続先に送信する映像データの入力 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Connected（接続） | 接続されている時にオンを出力 |
| ◆ Composite Data Receive（複合データ受信） | 接続先から受信する複合データの出力 |
| ◆ Video Data Receive（映像データ受信） | 接続先から受信する映像データの出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

※電力はコネクター同士が引き合う際に消費し接続中には消費しない。引き合う距離は約１ｍ(4ブロック)(v1.2.12にて確認)

## SMALL KEYPAD

大きなキーパッド：数字を入力できるキーパッド。  
キーパッドを押すと、数値を入力できるメニューが表示されます。  
保存された番号は、他の出力ノードから継続的に出力されます。  
オン/オフ信号は、キーパッドのバックライトを有効にするかどうかを制御します。

英語原文

A keypad that allows a number to be input.  
Pressing the keypad will show a menu where the number can be entered.  
The stored numbers will be continuously output from the other output node.  
An on/off signal controls whether or not the keypad's backlight is enabled.

※数値を入力できるキーボード、[e][q]キーで入力画面を開くことができる。  
　入力画面にはOutputが現在出力している値、Outputへの入力欄  
　入力画面を閉じるボタン、入力した数値を反映するボタンがある。  
※入力画面を開いていてもキャラクターの移動や座席の乗り降りが可能なので操作ミスに注意。  
価格 -$、サイズ（WxDxH）2x1x2（2x1x1の本体、キーボードの面以外が設置面になっている）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Backlight（バックライト） | On/Off(点灯／消灯) |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Output（出力値） | 入力された数値の出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | バックライト用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称記入欄 | カーソルを合わせた時に表示される名称 |
| Output Label（出力名称） | 名称記入欄 | 数値入力画面に表示される名称 |

## SUSPENTION

サスペンション：陸上車両の取り扱いを改善するために使用できるショックアブソーバー。  
サスペンションを介して動力を伝達することができ、最後にホイールを取り付けて制御することができます。

英語原文

A shock absorber that can be used to improve handling of land-based vehicles.  
Power can be passed through the suspension, allowing you to attach and control a wheel at the end.

※設置時は軸が水平になっているが、フィールドに出すと１マス分下がり衝撃を緩和する。  
　想定される衝撃の強さや載せる重量に合わせてMaxPowerを調整する。  
※形状について、可動するフレームが３本、動力軸が１本付いています。フレームは水平方向２本、垂直方向１本となっている。  
　フィールドに出した際、水平方向２本(動力軸を合わせて３本並んでいる)の側に１マス下がるようになっている。  
価格 -$、サイズ（WxDxH）3x1x3（形状は複雑、設置判定は固定側にＴ字が３列分と可動側に１マス、設置面は軸接続部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:5 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 両側に接続された配管の動力を通す |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Max Power（最大出力） | 0～100％ | スプリングの強さ |

## THROTTLE LEVER

スロットルレバー：1つの数値出力を制御する2つのボタンとして機能するスロットルレバー。  
出力の範囲は-1から1で、操作するレバーの半分に応じて増減します。  
2つのオン/オフ入力を使用して、異なるボタンで外部からレバーを制御できます。  
レバーの速度は、選択ツールでこのコンポーネントを選択することによって構成できます。

英語原文

A throttle lever that acts as two buttons controlling one number output.  
The output ranges from -1 to 1, and will increase/ decrease depending on which half of the lever you interact with.  
The two on/off inputs can be used to control the lever externally with different buttons.  
The speed of the lever can be configured by selecting this component with the select tool.

※出力値を変動できるレバー。  
価格 -$、サイズ（WxDxH）1x2x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Up（上げる） | オンの時出力値を上げる |
| ◆ Down（下げる） | オンの時出力値を下げる |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Throttle（スロットル） | 設定値の範囲でレバー位置に応じた数値を出力する |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称記入欄 | カーソルを合わせた時に表示される名称 |
| Sensitivity（感度） | 1～100％ | レバー操作時の数値の変動する速さ |
| Min Value（最小値） | 数値を入力(デフォルト値0) | レバーを下げた際の最小値 |
| Max Value（最大値） | 数値を入力(デフォルト値1) | レバーを上げた際の最大値 |
| Start Value（初期値） | 数値を入力(デフォルト値0) | フィールドに出した際の初期値 |

## TOGGLE BUTTON

切替えボタン：[e]か[q]を押したときに、オンまたはオフの信号の送信を切り替えるボタン。  
外部オン/オフ信号を使用して、ボタンが押されているかどうかを制御することもできます。これにより、複数のボタンを連結して出力を統一できます。  
ボタンのデフォルト状態は、selectコンポーネントでボタンを選択することで構成できます。

英語原文

A button that toggles between sending an on or off signal when you press [e] on it.  
An external on/off signal can also be used to control whether or not the button is pressed, allowing you to chain multiple buttons together to unify their outputs.  
The button's default state can be configured by selecting it with the select component.

※[e][q]キーや外部入力信号で操作できる切替えボタン。  
　一度押した後オン信号を維持し、もう一度押すとオフになる。  
　ExternalInputへのオンオフ信号は手動操作と違い、オンの時はオン、オフの時はオフになる。  
※ボタンの意匠が見えない裏面や側面からでも操作は可能。  
価格 -$、サイズ（WxDxH）1x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ External Input（外部入力） | オン信号を受けるとオンになる |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Toggled（切替え） | ボタンのオンオフ状態を出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称記入欄 | カーソルを合わせた時に表示される名称 |
| Default State（初期状態） | Off / On | ボタンの初期状態を設定 |

## TOGGLE BUTTON (2 SIDED)

切替えボタン両面：[e]か[q]を押したときに、オンまたはオフの信号の送信を切り替えるボタン。  
外部オン/オフ信号を使用して、ボタンが押されているかどうかを制御することもできます。これにより、複数のボタンを連結して出力を統一できます。  
ボタンのデフォルト状態は、selectコンポーネントでボタンを選択することで構成できます。

英語原文

A button that toggles between sending an on or off signal when you press [e] on it.  
An external on/off signal can also be used to control whether or not the button is pressed, allowing you to chain multiple buttons together to unify their outputs.  
The button's default state can be configured by selecting it with the select component.

※[e][q]キーや外部入力信号で操作できる切替えボタン。裏側にもボタンの意匠がある。  
　一度押した後オン信号を維持し、もう一度押すとオフになる。  
　ExternalInputへのオンオフ信号は手動操作と違い、オンの時はオン、オフの時はオフになる。  
※ボタンの意匠が見えない側面からでも操作は可能。  
価格 -$、サイズ（WxDxH）1x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ External Input（外部入力） | オン信号を受けるとオンになる |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Toggled（切替え） | ボタンのオンオフ状態を出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称記入欄 | カーソルを合わせた時に表示される名称 |
| Default State（初期状態） | Off / On | ボタンの初期状態を設定 |

## TORQUE CONNECTOR

トルクコネクタ：車両間で機械的エネルギーを伝達するために使用できる小型トルクコネクタ。  
2つのトルクコネクタは、互いに近接すると接続されます。接続されると、コネクタ間で機械的エネルギーが伝達されます。

英語原文

A small torque connector that can be used to transfer mechanical energy between vehicles.  
Two torque connectors will attach when they are within close proximity. When connected, mechanical energy will be transferred between the connectors.

価格 $20、サイズ（WxDxH）1x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Release Connector（コネクタ解除） | オン信号を受信するとコネクタを解除します。 |
| ◆ Composite Data Send（コンポジットデータ送信） | 接続されたコネクタに送信するコンポジットデータ。 |
| ◆ Video Data Send（ビデオデータ送信） | 接続されたコネクタに送信するビデオデータ。 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Connected（接続済み） | コネクタが別のコネクタに接続されている場合にオン信号を出力します。 |
| ◆ Composite Data Receive（コンポジットデータ受信） | 接続されたコネクタから受信するコンポジットデータ。 |
| ◆ Video Data Receive（ビデオデータ受信） | 接続されたコネクタから受信するビデオデータ。 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 機械的エネルギー伝達のための動力接続。 |

## TURRET RING(LARGE)

A large turret ring that can rotate continuously.  
A turret ring rotates in the same way as a velocity pivot.  
The gap inside the turret ring creates a door seal, and can be used to extend a sealed volume through the turret ring.  
※操作はVELOCITY PIVOTと同じ速度制御式

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass）、動力（motor）、速度(motorspeed) | mass:36、motor:2000、motorspeed:0(0.5) |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotational Speed（回転速度） | 詳細内容 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Curent Rotation（現在角度） | 範囲 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## TURRET RING(MEDIUM)

A medium turret ring that can rotate continuously.  
A turret ring rotates in the same way as a velocity pivot.  
The gap inside the turret ring creates a door seal, and can be used to extend a sealed volume through the turret ring.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass）、動力（motor）、速度(motorspeed) | mass:22、motor:1000、motorspeed:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotational Speed（回転速度） | 詳細内容 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Curent Rotation（現在角度） | 範囲 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## TURRET RING(SMALL)

A small turret ring that can rotate continuously.  
A turret ring rotates in the same way as a velocity pivot.  
The gap inside the turret ring creates a door seal, and can be used to extend a sealed volume through the turret ring.

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass）、動力（motor）、速度(motorspeed) | mass:14、motor:500、motorspeed:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotational Speed（回転速度） | 詳細内容 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Curent Rotation（現在角度） | 範囲 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## VELOCITY PIVOT

速度ピボット：設定された入力速度で連続的に回転するピボット。値0を入力すると停止します。  
ピボットの現在の回転は、その出力から読み取ることができます。  
1の出力は1回転に対応し、-1は反対方向の1回転に対応します。

英語原文

A pivot that will continuously rotate at a set input speed. Inputting a value of 0 will cause it to stop.  
The pivot's current rotation can be read from its output.  
An output of 1 corresponds to one full turn and -1 to a full turn in the opposite direction.

※VELOCITY PIVOTは入力された数値の速度で一定方向へ回転し続けます。  
※大きな力が掛かると動作が阻害されたり軸がズレる事もあります。  
　電力が供給されない場合、重力などの外力で容易に動きます。  
価格 -$、サイズ（WxDxH）3x3x2（3x3の台に1マスの回転軸が付いた形状、台側面と軸に配管接続部がある）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass）、動力（motor）、速度（motorspeed） | mass:9、motor:1000、motorspeed:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotation Speed（回転速度） | -1～1 軸回転速度の設定値(0で停止、＋正転、－逆転) |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Curent Rotation（現在角度） | 0～ 現在の角度(0を中心1回転あたり1)※注 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

※CurentRotationの数値は一方向に回転させ続けると数値は１回転あたり１ずつ正転なら増加、逆転なら減少し続けていく。

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Max Power（最大出力） | 0～100％ | トルクの設定 |
| Gear Ratio（ギア比） | 1:1 / 1:2 / 1:4 / 1:8 / 1:16 / 1:32 | ギア比の選択 |
