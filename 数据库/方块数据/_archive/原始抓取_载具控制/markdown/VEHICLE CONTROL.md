---
wiki: sbarjp
page: VEHICLE CONTROL
source_url: https://wikiwiki.jp/sbarjp/VEHICLE%20CONTROL
last_modified: 2025-03-15
retrieved_at: 2026-08-31T02:25:54+0800
---

# VEHICLE CONTROL

フィン、タイヤ、翼、ジャイロなどのマシンを制御するパーツと操舵輪、シートなどのマシンをコントロールするパーツ群

|  |
| --- |
| - [COMPACT PILOT SEAT](#kf41a008) - [CONTROL FIN LARGE](#y035fddd) - [CONTROL FIN MEDIUM](#g81f7fd9) - [CONTROL FIN SMALL](#f5ab8dbd) - [CONTROL HANDLE](#wedbb044) - [CONTROL SURFACE (LARGE)](#ke282ed1) - [CONTROL SURFACE (MEDIUM)](#tc3d73fa) - [CONTROL SURFACE (SMALL)](#va1a51a0) - [DRIVER SEAT](#ka0796f6) - [FIN RUDDER](#n0a0b3a9) - [FRICTION PAD](#ke269746) - [GYRO](#g5a7d42a) - [HELM](#y448f746) - [KEEL (LARGE)](#cc3bf2e5) - [KEEL (MEDIUM)](#y99d899a) - [KEEL (SMALL)](#i6d10b4d) - [KEEP ACTIVE BLOCK](#s88cbffd) - [LARGE LANDING WHEEL](#hfe94565) - [MEDIUM WHEEL](#h3ed2011) - [PILOT SEAT](#c47d1d97) - [PILOT SEAT (HOTAS)](#z7e5ffd8) - [RADIO RX HUGE](#r2d31fc3) - [RADIO RX LARGE](#m7204e5d) - [RADIO RX MEDIUM](#cf087a9c) - [RADIO RX SMALL](#w3e1ebc9) - [RADIO VIDEO RECV](#y3ca520a) - [RADIO VIDEO XMIT](#a4f64557) - [RUDDER](#v9c42aa3) - [RX DIRECTIONAL](#uadb7060) - [RX DIRECTIONAL (LARGE)](#c5df99d9) - [SKI](#va08c237) - [SKI (SMALL)](#e705b7e5) - [SMALL WHEEL](#p99c047f) - [SPACE SEAT](#jc372e14) - [TANK DRIVE WHEEL (HUGE)](#l50251d1) - [TANK DRIVE WHEEL (LARGE)](#k06ce910) - [TANK DRIVE WHEEL (MIDIUM)](#t6a14a51) - [TANK DRIVE WHEEL (SMALL)](#bcfdd005) - [TANK WHEEL (HUGE)](#a4dfc132) - [TANK WHEEL (LARGE)](#ja139c1c) - [TANK WHEEL (MEDIUM)](#gcbe056f) - [TANK WHEEL (SMALL)](#n553ccf7) - [WHEEL 3X3](#lace1a26) - [WHEEL 3X3 (SUSPENSION)](#efbc4c33) - [WHEEL 5X5](#pba09d42) - [WHEEL 5X5 (SUSPENSION)](#f974d127) - [WHEEL 7X7](#jfc07933) - [WHEEL 7x7 (SUSPENSION)](#g6721e38) - [WHEEL 9X9](#rf349e70) - [WHEEL 9X9 (SUSPENSION)](#r8146c82) - [WHEEL COASTER](#od5e9673) - [WING FRONT SECTION (SMALL)](#p6e21c50) - [WING SECTION (LARGE)](#b121ef0f) - [WING SECTION (MEDIUM)](#cf9856a9) - [WING SECTION (SMALL)](#lcc1cf83) - [WING SECTION (XLARGE)](#bb9fa977) - [WING SECTION (XXLARGE)](#gc106e3b) |

仮：制御翼一覧表

FIN RUDDER  
RUDDER  
CONTROL FIN SMALL  
CONTROL FIN MEDIUM  
CONTROL FIN LARGE  
CONTROL SURFACE (SMALL)  
CONTROL SURFACE (MEDIUM)  
CONTROL SURFACE (LARGE)

仮：車輪一覧表

WHEEL COASTER  
LARGE LANDING WHEEL  
SMALL WHEEL  
MEDIUM WHEEL  
WHEEL 3X3  
WHEEL 3X3 (SUSPENSION)  
WHEEL 5X5  
WHEEL 5X5 (SUSPENSION)  
WHEEL 7X7  
WHEEL 7x7 (SUSPENSION)  
WHEEL 9X9  
WHEEL 9X9 (SUSPENSION)  
TANK WHEEL (SMALL)  
TANK DRIVE WHEEL (SMALL)  
TANK WHEEL (MEDIUM)  
TANK DRIVE WHEEL (MEDIUM)  
TANK WHEEL (LARGE)  
TANK DRIVE WHEEL (LARGE)  
SKI  
SKI (SMALL)

## COMPACT PILOT SEAT

小型操縦席：コンパクトパイロットシートを使用すると、キーボードプレスをロジックコンポーネントを制御できる出力信号に変換できます。  
－1～1の範囲の標準値を生成する4つの数値出力と、6つのオン/オフ出力を提供します。  
コンパクトパイロットシートは、[f]を使用して操作することにより、乗降できます。

英語原文

The Compact pilot seat lets you translate keyboard presses into output signals that can control logic components.  
It provides 4 number outputs that produce a standard value ranging from -1 to 1, and 6 on/off outputs.  
You can get in and out of the compact pilot seat by interacting with it using[f].

※複数の操作を制御信号に変換する座席、見た目は座席に操縦桿が付いただけのシンプルな構造、操縦席の中で最軽量。  
　内容は形状と重量以外PILOT SEATと同じ。  
価格 $100、サイズ（WxDxH）3x3x5（設置判定の前方下部に操縦桿部のくびれがある座席、底面に凸型７マス分の設置面がある）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:7 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Headset Audio（音声） | オーディオデータの入力 |
| ◆ Headset Video（映像） | HMDにビデオUIオーバーレイを表示 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Occupied（使用中） | 座席に誰かが座っているとオン信号を出力する |
| ◆ Trigger[space]（トリガー） | On/Offを出力 |
| ◆ Look X（水平視線方向） | -0.35（左）～0.35（右）（-126°～126°）座っているプレイヤーの水平視線方向 |
| ◆ Look Y（垂直視線方向） | -0.2（下）～0.2（上）（-72°～72°）座っているプレイヤーの垂直視線方向 |
| ◆ Axis 1 [a]/[d]（軸１） | -1～1 [a]で数値下降、[d]で数値上昇 |
| ◆ Axis 2 [w]/[s]（軸２） | -1～1 [s]で数値下降、[w]で数値上昇 |
| ◆ Axis 3 [←]/[→]（軸３） | -1～1 [←]で数値下降、[→]で数値上昇 |
| ◆ Axis 4 [↑]/[↓]（軸４） | -1～1 [↓]で数値下降、[↑]で数値上昇 |
| ◆ Hotkey 1[1]（ホットキー１） | On/Offを出力 |
| ◆ Hotkey 2[2]（ホットキー２） | On/Offを出力 |
| …中略… | |
| ◆ Hotkey 6[6]（ホットキー６） | On/Offを出力 |
| ◆ Seat data（座席情報） | 操作情報を複合データで出力 |
| ・Number channel 1～4 | Axis 1～4の数値を出力 |
| ・Number channel 9 | Look Xの数値を出力 |
| ・Number channel 10 | Look Yの数値を出力 |
| ・On/Off channel 1～6 | Hotkey1～6のオンオフ信号を出力 |
| ・On/Off channel 31 | Triggerのオンオフ信号を出力 |
| ・On/Off channel 32 | Occupiedのオンオフ信号を出力 |

SELECT選択設定項目

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称記入欄 | カーソルを合わせた時に表示される名称 |
| CONTROLS | | |
| Axis 1 [a]/[d]（軸１） | プルダウン設定 | 内容 |
| ・Label（表示名） | 名称の記入 | 着席時のヘルプに表示される名称 |
| ・Mode（モード） | Reset / Sticky | 非操作時に出力値を0に戻す[Reset]か維持するか[Sticky]の選択 |
| ・Sensitivity（感度） | 1～100％ | 操作時の数値の変動する速さ |
| Axis 2 [w]/[s]（軸２） | プルダウン設定 | 内容はAxis 1と同じ |
| Axis 3 [←]/[→]（軸３） | プルダウン設定 | 内容はAxis 1と同じ |
| Axis 4 [↑]/[↓]（軸４） | プルダウン設定 | 内容はAxis 1と同じ |
| Hotkey 1[1]（ホットキー１） | プルダウン設定 | 内容 |
| ・Label（表示名） | 名称の記入 | 着席時のヘルプに表示される名称 |
| ・Mode（モード） | Toggle / Push | 出力信号を切替え[Toggle]か押しボタン[Push]にするかの選択 |
| Hotkey 2[2]（ホットキー２） | プルダウン設定 | 内容はHotkey1と同じ |
| …中略… | | |
| Hotkey 6[6]（ホットキー６） | プルダウン設定 | 内容はHotkey1と同じ |
| TRIM | | |
| Trim Axis 1（トリム軸１） | 数値入力 | Axis 1の出力に補正値を入れる |
| Trim Axis 2（トリム軸２） | 数値入力 | Axis 2の出力に補正値を入れる |
| Trim Axis 3（トリム軸３） | 数値入力 | Axis 3の出力に補正値を入れる |
| Trim Axis 4（トリム軸４） | 数値入力 | Axis 4の出力に補正値を入れる |

※トリムの設定値は、乗り物を操作する際のAlt＋軸操作でするトリム操作と同じもの。  
　ここで入力された値は乗り物をフィールドに出した際にトリム値が入力された状態になる。

## CONTROL FIN LARGE

制御フィン 大型：フィンは、車両の表面に取り付けてその動きを方向付けることができます。  
フィンの回転の両極端を表す、-1と1の間の数値入力を受け取ります。

英語原文

The fin can be attached to the surface of a vehicle to direct its motion.  
It takes a number input between-1 and 1 that represent the two extremes of the fin's rotation.

※設置面に対して水平方向に全体が可動する翼。  
　動作角度は目測で±15度ほど、翼面に対して水や空気、風の影響を受ける。  
価格 $350、サイズ（WxDxH）1x3x3（台形をした翼、設置面は根本側の面３マスのみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:10 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotation（回転） | -1～1 目標角度の設定値(0が中心で±15度) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## CONTROL FIN MEDIUM

制御フィン 中型：フィンは、車両の表面に取り付けてその動きを方向付けることができます。  
フィンの回転の両極端を表す、-1と1の間の数値入力を受け取ります。

英語原文

The fin can be attached to the surface of a vehicle to direct its motion.  
It takes a number input between-1 and 1 that represent the two extremes of the fin's rotation.

※設置面に対して水平方向に全体が可動する翼。  
　動作角度は目測で±15度ほど、翼面に対して水や空気、風の影響を受ける。  
価格 $150、サイズ（WxDxH）1x3x2（台形をした翼、設置面は根本側の面３マスのみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotation（回転） | -1～1 目標角度の設定値(0が中心で±15度) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## CONTROL FIN SMALL

制御フィン 小型：フィンは、車両の表面に取り付けてその動きを方向付けることができます。  
フィンの回転の両極端を表す、-1と1の間の数値入力を受け取ります。

英語原文

The fin can be attached to the surface of a vehicle to direct its motion.  
It takes a number input between-1 and 1 that represent the two extremes of the fin's rotation.

※設置面に対して水平方向に全体が可動する翼。  
　動作角度は目測で±15度ほど、翼面に対して水や空気、風の影響を受ける。  
価格 $50、サイズ（WxDxH）1x1x1（台形をした翼、設置面は根本側の面１マスのみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotation（回転） | -1～1 目標角度の設定値(0が中心で±15度) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## CONTROL HANDLE

コンパクトなコントロールハンドル。[f]を使用して操作することにより、乗降できます。

英語原文

A compact control handle. You can get in and out of the position by interacting with it using [f]

※複数の操作を制御信号に変換するアイテム、内容は形状と重量以外PILOT SEATと同じ。  
価格 $50、サイズ（WxDxH）3x3x7（占有範囲3x2x7。中央高さ5にハンドル。）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Headset Audio（音声） | 音声データの入力 |
| ◆ Headset Video（映像） | HMDにビデオUIオーバーレイを表示 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Occupied（使用中） | 座席に誰かが座っているとオン信号を出力する |
| ◆ Trigger[space]（トリガー） | On/Offを出力 |
| ◆ Look X（水平視線方向） | -0.35（左）～0.35（右）（-126°～126°）座っているプレイヤーの水平視線方向 |
| ◆ Look Y（垂直視線方向） | -0.2（下）～0.2（上）（-72°～72°）座っているプレイヤーの垂直視線方向 |
| ◆ Axis 1 [a]/[d]（軸１） | -1～1 [a]で数値下降、[d]で数値上昇 |
| ◆ Axis 2 [w]/[s]（軸２） | -1～1 [s]で数値下降、[w]で数値上昇 |
| ◆ Axis 3 [←]/[→]（軸３） | -1～1 [←]で数値下降、[→]で数値上昇 |
| ◆ Axis 4 [↑]/[↓]（軸４） | -1～1 [↓]で数値下降、[↑]で数値上昇 |
| ◆ Hotkey 1[1]（ホットキー１） | On/Offを出力 |
| ◆ Hotkey 2[2]（ホットキー２） | On/Offを出力 |
| …中略… | |
| ◆ Hotkey 6[6]（ホットキー６） | On/Offを出力 |
| ◆ Seat data（座席情報） | 操作情報を複合データで出力 |
| ・Number channel 1～4 | Axis 1～4の数値を出力 |
| ・Number channel 9 | Look Xの数値を出力 |
| ・Number channel 10 | Look Yの数値を出力 |
| ・On/Off channel 1～6 | Hotkey1～6のオンオフ信号を出力 |
| ・On/Off channel 31 | Triggerのオンオフ信号を出力 |
| ・On/Off channel 32 | Occupiedのオンオフ信号を出力 |

SELECT選択設定項目

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称記入欄 | カーソルを合わせた時に表示される名称 |
| CONTROLS | | |
| Axis 1 [a]/[d]（軸１） | プルダウン設定 | 内容 |
| ・Label（表示名） | 名称の記入 | 着席時のヘルプに表示される名称 |
| ・Mode（モード） | Reset / Sticky | 非操作時に出力値を0に戻す[Reset]か維持するか[Sticky]の選択 |
| ・Sensitivity（感度） | 1～100％ | 操作時の数値の変動する速さ |
| Axis 2 [w]/[s]（軸２） | プルダウン設定 | 内容はAxis 1と同じ |
| Axis 3 [←]/[→]（軸３） | プルダウン設定 | 内容はAxis 1と同じ |
| Axis 4 [↑]/[↓]（軸４） | プルダウン設定 | 内容はAxis 1と同じ |
| Hotkey 1[1]（ホットキー１） | プルダウン設定 | 内容 |
| ・Label（表示名） | 名称の記入 | 着席時のヘルプに表示される名称 |
| ・Mode（モード） | Toggle / Push | 出力信号を切替え[Toggle]か押しボタン[Push]にするかの選択 |
| Hotkey 2[2]（ホットキー２） | プルダウン設定 | 内容はHotkey1と同じ |
| …中略… | | |
| Hotkey 6[6]（ホットキー６） | プルダウン設定 | 内容はHotkey1と同じ |
| TRIM | | |
| Trim Axis 1（トリム軸１） | 数値入力 | Axis 1の出力に補正値を入れる |
| Trim Axis 2（トリム軸２） | 数値入力 | Axis 2の出力に補正値を入れる |
| Trim Axis 3（トリム軸３） | 数値入力 | Axis 3の出力に補正値を入れる |
| Trim Axis 4（トリム軸４） | 数値入力 | Axis 4の出力に補正値を入れる |

※トリムの設定値は、乗り物を操作する際のAlt＋軸操作でするトリム操作と同じもの。  
　ここで入力された値は乗り物をフィールドに出した際にトリム値が入力された状態になる。

## CONTROL SURFACE (LARGE)

制御面(大型)：制御面を車両の表面に取り付けて、空気または水がその上を流れるときに力を加えることができます。  
フィンの回転の両極端を表す-1から1までの数値入力を受け取ります。

英語原文

The control surface can be attached to a surface of the vehicle to apply force as air or water is flowing over it.  
It takes a number input between -1 and 1 that represent the two extremes of the fin's rotation.

※設置面に対して垂直方向に可動する翼。  
　動作角度は目測で±45度ほど、翼面に対して水や空気、風の影響を受ける。  
価格 $500、サイズ（WxDxH）1x5x17（長方形の翼、設置面は長い辺の片面）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:25 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotation（回転） | -1～1 目標角度の設定値(0が中心で±45度) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

|  |  |
| --- | --- |
| [20190326224224_1.jpg](https://cdn.wikiwiki.jp/to/w/sbarjp/VEHICLE%20CONTROL/::attach/20190326224224_1.jpg?rev=a6ec821a92d48126a77b10ef78c1d947&t=20190327002053 "20190326224224_1.jpg") | CONTROL SURFACE (LARGE) |
| CONTROL SURFACE (MEDIUM) |
| CONTROL SURFACE (SMALL) |
| FIN RUDDER |

## CONTROL SURFACE (MEDIUM)

制御面(中型)：制御面を車両の表面に取り付けて、空気または水がその上を流れるときに力を加えることができます。  
フィンの回転の両極端を表す-1から1までの数値入力を受け取ります。

英語原文

The control surface can be attached to a surface of the vehicle to apply force as air or water is flowing over it.  
It takes a number input between -1 and 1 that represent the two extremes of the fin's rotation.

※設置面に対して垂直方向に可動する翼。  
　動作角度は目測で±45度ほど、翼面に対して水や空気、風の影響を受ける。  
価格 $250、サイズ（WxDxH）1x4x11（長方形の翼、設置面は長い辺の片面）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:15 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotation（回転） | -1～1 目標角度の設定値(0が中心で±45度) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## CONTROL SURFACE (SMALL)

制御面(小型)：制御面を車両の表面に取り付けて、空気または水がその上を流れるときに力を加えることができます。  
フィンの回転の両極端を表す-1から1までの数値入力を受け取ります。

英語原文

The control surface can be attached to a surface of the vehicle to apply force as air or water is flowing over it.  
It takes a number input between -1 and 1 that represent the two extremes of the fin's rotation.

※設置面に対して垂直方向に可動する翼。  
　動作角度は目測で±45度ほど、翼面に対して水や空気、風の影響を受ける。  
価格 $150、サイズ（WxDxH）1x3x7（長方形の翼、設置面は長い辺の片面）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:10 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotation（回転） | -1～1 目標角度の設定値(0が中心で±45度) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## DRIVER SEAT

運転席：ドライバーシートでは、キーボードプレスをロジックコンポーネントを制御できる出力信号に変換できます。  
－1～1の範囲の標準値を生成する4つの数値出力と、6つのオン/オフ出力を提供します。  
コンパクトパイロットシートは、[f]を使用して操作することにより、乗降できます。

英語原文

The Driver seat lets you translate keyboard presses into output signals that can control logic components.  
It provides 4 number outputs that produce a standard value ranging from -1 to 1, and 6 on/off outputs.  
You can get in and out of the compact pilot seat by interacting with it using[f].

※複数の操作を制御信号に変換する座席、見た目はハンドルの付いた座席。  
　内容は形状と重量以外PILOT SEATと同じ。  
価格 $100、サイズ（WxDxH）3x4x5（設置判定の前方下部にハンドル基部が飛びだした座席、底面に凸型８マス分の設置面がある）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:10 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Headset Audio（音声） | オーディオデータの入力 |
| ◆ Headset Video（映像） | HMDにビデオUIオーバーレイを表示 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Occupied（使用中） | 座席に誰かが座っているとオン信号を出力する |
| ◆ Trigger[space]（トリガー） | On/Offを出力 |
| ◆ Look X（水平視線方向） | -0.35（左）～0.35（右）（-126°～126°）座っているプレイヤーの水平視線方向 |
| ◆ Look Y（垂直視線方向） | -0.2（下）～0.2（上）（-72°～72°）座っているプレイヤーの垂直視線方向 |
| ◆ Axis 1 [a]/[d]（軸１） | -1～1 [a]で数値下降、[d]で数値上昇 |
| ◆ Axis 2 [w]/[s]（軸２） | -1～1 [s]で数値下降、[w]で数値上昇 |
| ◆ Axis 3 [←]/[→]（軸３） | -1～1 [←]で数値下降、[→]で数値上昇 |
| ◆ Axis 4 [↑]/[↓]（軸４） | -1～1 [↓]で数値下降、[↑]で数値上昇 |
| ◆ Hotkey 1[1]（ホットキー１） | On/Offを出力 |
| ◆ Hotkey 2[2]（ホットキー２） | On/Offを出力 |
| …中略… | |
| ◆ Hotkey 6[6]（ホットキー６） | On/Offを出力 |
| ◆ Seat data（座席情報） | 操作情報を複合データで出力 |
| ・Number channel 1～4 | Axis 1～4の数値を出力 |
| ・Number channel 9 | Look Xの数値を出力 |
| ・Number channel 10 | Look Yの数値を出力 |
| ・On/Off channel 1～6 | Hotkey1～6のオンオフ信号を出力 |
| ・On/Off channel 31 | Triggerのオンオフ信号を出力 |
| ・On/Off channel 32 | Occupiedのオンオフ信号を出力 |

SELECT選択設定項目

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称記入欄 | カーソルを合わせた時に表示される名称 |
| CONTROLS | | |
| Axis 1 [a]/[d]（軸１） | プルダウン設定 | 内容 |
| ・Label（表示名） | 名称の記入 | 着席時のヘルプに表示される名称 |
| ・Mode（モード） | Reset / Sticky | 非操作時に出力値を0に戻す[Reset]か維持するか[Sticky]の選択 |
| ・Sensitivity（感度） | 1～100％ | 操作時の数値の変動する速さ |
| Axis 2 [w]/[s]（軸２） | プルダウン設定 | 内容はAxis 1と同じ |
| Axis 3 [←]/[→]（軸３） | プルダウン設定 | 内容はAxis 1と同じ |
| Axis 4 [↑]/[↓]（軸４） | プルダウン設定 | 内容はAxis 1と同じ |
| Hotkey 1[1]（ホットキー１） | プルダウン設定 | 内容 |
| ・Label（表示名） | 名称の記入 | 着席時のヘルプに表示される名称 |
| ・Mode（モード） | Toggle / Push | 出力信号を切替え[Toggle]か押しボタン[Push]にするかの選択 |
| Hotkey 2[2]（ホットキー２） | プルダウン設定 | 内容はHotkey1と同じ |
| …中略… | | |
| Hotkey 6[6]（ホットキー６） | プルダウン設定 | 内容はHotkey1と同じ |
| TRIM | | |
| Trim Axis 1（トリム軸１） | 数値入力 | Axis 1の出力に補正値を入れる |
| Trim Axis 2（トリム軸２） | 数値入力 | Axis 2の出力に補正値を入れる |
| Trim Axis 3（トリム軸３） | 数値入力 | Axis 3の出力に補正値を入れる |
| Trim Axis 4（トリム軸４） | 数値入力 | Axis 4の出力に補正値を入れる |

※トリムの設定値は、乗り物を操作する際のAlt＋軸操作でするトリム操作と同じもの。  
　ここで入力された値は乗り物をフィールドに出した際にトリム値が入力された状態になる。

## FIN RUDDER

翼舵：フィンラダーは、ボートのキールに取り付けてヨーを制御できます。  
左右に操縦できます。  
フィンの回転の両極端を表す-1から1までの数値入力を受け取ります。

英語原文

The fin rudder can be attached to the keel of a boat to control its yaw.  
allowing you to steer left and right.  
It takes a number input between -1 and 1 that represent the two extremes of the fin's rotation.

※３マスの台に可動する翼の付いた形状、台が有る分いろんな角度で設置出来ます。  
　動作角度は目測で±45度ほど、翼面に対して水や空気、風の影響を受ける。つまり航空機の稼働翼としても使用可。  
価格 $100、サイズ（WxDxH）1x2x3（設置面は翼の台になっている３マス）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotation（回転） | -1～1 目標角度の設定値(0が中心で±45度) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## FRICTION PAD

摩擦パッド：あらゆるものに吸着する高摩擦パッド。滑り止め。

英語原文

Friction pad that grips to surfaces.High friction pad that grips any it touches.

価格 $15、サイズ（WxDxH）1x1x1（設置面は根本1マス）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Grip（グリップ力） | 1～100％ | グリップ力の強さを設定 |

## GYRO

ジャイロ：ジャイロスコープは、ヘリコプターの目的のヨー、ピッチ、ロール、垂直運動を表す4つの標準値信号を受け取ります。  
それはローターとエンジンに送ることができる安定化された値を出力して、それらをはるかに制御しやすくします。  
オン/オフ入力により、内部の自動ホバー回路をアクティブおよび非アクティブにすることができます。  
自動ホバーが有効な場合、ジャイロスコープはヘリコプターを安定させようとします。

英語原文

The gyroscope takes 4 standard value signals representing the desired yaw, pitch, roll and vertical motion of a helicopter.  
It outputs stabilised values that can be sent to rotors and engines to make them much easier to control.  
An on/off input allows you to activate and deactivate the internal auto-hover circuit.  
When auto-hover is enabled, the gyroscope will attempt to keep your helicopter steady.

※４軸の補正をして乗り物を安定化させるためのパーツ。  
[![20190326225256_2.jpg](https://cdn.wikiwiki.jp/to/w/sbarjp/VEHICLE%20CONTROL/::ref/20190326225256_2.jpg.webp?rev=b3a75ad49d1a9d9fdbc835fd07fae485&t=20190327005151 "20190326225256_2.jpg")](https://cdn.wikiwiki.jp/to/w/sbarjp/VEHICLE%20CONTROL/::attach/20190326225256_2.jpg?rev=b3a75ad49d1a9d9fdbc835fd07fae485&t=20190327005151 "20190326225256_2.jpg")  
価格 $500、サイズ（WxDxH）3x5x1（マイコンのように下面に設置面のある板）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:10 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Roll（ロール） | -1～1 目標ロール速度を入力 |
| ◆ Pitch（ピッチ） | -1～1 目標ピッチ速度を入力 |
| ◆ Yaw（ヨー） | -1～1 目標ヨー速度を入力 |
| ◆ Up/Down（上昇下降） | -1～1 目標垂直速度を入力 |
| ◆ Auto-hover（自動ホバー） | オン信号を入力している間、自動ホバー回路を有効 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Stabilised Roll（ロール） | -1～1 安定したロール速度値を出力 |
| ◆ Stabilised Pitch（ピッチ） | -1～1 安定したピッチ速度値を出力 |
| ◆ Stabilised Yaw（ヨー） | -1～1 安定したヨー速度値を出力 |
| ◆ Stabilised Up/Down（上昇下降） | 0～1 安定した上昇速度値を出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Min Throttle（最少スロットル） | 1～100％ | スロットルの最小値を設定 |
| Max Throttle（最大スロットル） | 1～100％ | スロットルの最大値を設定 |
| Roll（ロール） | 1～100％ | 回転方向補正の強さを設定 |
| Pitch（ピッチ） | 1～100％ | 垂直方向補正の強さを設定 |
| Yaw（ヨー） | 1～100％ | 水平方向補正の強さを設定 |

## HELM

舵：舵輪付き操舵。  
[f]を使用して操作することで、ポジションに出入りできます。  
救助された生存者は、[f]を押しながら運ぶことで、どの位置にでも置くことができます。

英語原文

A steering helm with steering wheel.  
You can get in and out of the position by interacting with it using [f].  
You can place a rescued survivor in any position by using [f] while carrying them.

※複数の操作を制御信号に変換する座席、見た目は船でよく使われている舵輪。  
　ストームワークス初期からある基本的な操舵輪。内容は形状と重量以外PILOT SEATと同じ。  
価格 $150、サイズ（WxDxH）3x5x7（見た目は3x4の台と3x5の舵輪だが、3x3x7の立ち位置に必要な空間がある）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:15 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Headset Audio（音声） | オーディオデータの入力 |
| ◆ Headset Video（映像） | HMDにビデオUIオーバーレイを表示 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Occupied（使用中） | 舵輪を誰かが使用しているとオン信号を出力する |
| ◆ Trigger[space]（トリガー） | On/Offを出力 |
| ◆ Look X（水平視線方向） | -0.35（左）～0.35（右）（-126°～126°）座っているプレイヤーの水平視線方向 |
| ◆ Look Y（垂直視線方向） | -0.2（下）～0.2（上）（-72°～72°）座っているプレイヤーの垂直視線方向 |
| ◆ Axis 1 [a]/[d]（軸１） | -1～1 [a]で数値下降、[d]で数値上昇 |
| ◆ Axis 2 [w]/[s]（軸２） | -1～1 [s]で数値下降、[w]で数値上昇 |
| ◆ Axis 3 [←]/[→]（軸３） | -1～1 [←]で数値下降、[→]で数値上昇 |
| ◆ Axis 4 [↑]/[↓]（軸４） | -1～1 [↓]で数値下降、[↑]で数値上昇 |
| ◆ Hotkey 1[1]（ホットキー１） | On/Offを出力 |
| ◆ Hotkey 2[2]（ホットキー２） | On/Offを出力 |
| …中略… | |
| ◆ Hotkey 6[6]（ホットキー６） | On/Offを出力 |
| ◆ Seat data（座席情報） | 操作情報を複合データで出力 |
| ・Number channel 1～4 | Axis 1～4の数値を出力 |
| ・Number channel 9 | Look Xの数値を出力 |
| ・Number channel 10 | Look Yの数値を出力 |
| ・On/Off channel 1～6 | Hotkey1～6のオンオフ信号を出力 |
| ・On/Off channel 32 | Occupiedのオンオフ信号を出力 |

SELECT選択設定項目

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称記入欄 | カーソルを合わせた時に表示される名称 |
| CONTROLS | | |
| Axis 1 [a]/[d]（軸１） | プルダウン設定 | 内容 |
| ・Label（表示名） | 名称の記入 | 着席時のヘルプに表示される名称 |
| ・Mode（モード） | Reset / Sticky | 非操作時に出力値を0に戻す[Reset]か維持するか[Sticky]の選択 |
| ・Sensitivity（感度） | 1～100％ | 操作時の数値の変動する速さ |
| Axis 2 [w]/[s]（軸２） | プルダウン設定 | 内容はAxis 1と同じ |
| Axis 3 [←]/[→]（軸３） | プルダウン設定 | 内容はAxis 1と同じ |
| Axis 4 [↑]/[↓]（軸４） | プルダウン設定 | 内容はAxis 1と同じ |
| Hotkey 1[1]（ホットキー１） | プルダウン設定 | 内容 |
| ・Label（表示名） | 名称の記入 | 着席時のヘルプに表示される名称 |
| ・Mode（モード） | Toggle / Push | 出力信号を切替え[Toggle]か押しボタン[Push]にするかの選択 |
| Hotkey 2[2]（ホットキー２） | プルダウン設定 | 内容はHotkey1と同じ |
| …中略… | | |
| Hotkey 6[6]（ホットキー６） | プルダウン設定 | 内容はHotkey1と同じ |
| TRIM | | |
| Trim Axis 1（トリム軸１） | 数値入力 | Axis 1の出力に補正値を入れる |
| Trim Axis 2（トリム軸２） | 数値入力 | Axis 2の出力に補正値を入れる |
| Trim Axis 3（トリム軸３） | 数値入力 | Axis 3の出力に補正値を入れる |
| Trim Axis 4（トリム軸４） | 数値入力 | Axis 4の出力に補正値を入れる |

※トリムの設定値は、乗り物を操作する際のAlt＋軸操作でするトリム操作と同じもの。  
　ここで入力された値は乗り物をフィールドに出した際にトリム値が入力された状態になる。

|  |  |
| --- | --- |
| [20190326230936_1.jpg](https://cdn.wikiwiki.jp/to/w/sbarjp/VEHICLE%20CONTROL/::attach/20190326230936_1.jpg?rev=c422e9c0644846b71c031229201bda14&t=20190327002133 "20190326230936_1.jpg") | 左→HELM |
| 中央→PILOT SEAT(HOTAS) |
| 右→PILOT SEAT |

## KEEL (LARGE)

キール（大型）：セーリングに使用される大型船舶用キール。  
キールは水中で横揺れの力に抵抗し、船を直立させて安定させる役割を果たします。  
また、キールは横方向の滑り力にも抵抗し、船の動きの大部分がキール軸の方向に向かうようにします。  
これがセールによって提供される力と組み合わさることで、帆船は横風の中でも、さらには向かい風の中でも前進することができます。

英語原文

A large boat keel used for sailing.

The keel resists rolling forces while submerged, helping to keep a boat upright and stable. The keel also resists lateral sliding forces, causing the majority of a boats movement to be in the direction of the keel axis. When combined with the force provided by a sail, this allows a sailboat to move forward in a crosswind, or even upwind.

価格 $2000、サイズ（WxDxH）3x25x9

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass）、出力（power） | mass:2000 |

## KEEL (MEDIUM)

キール（中型）：セーリングに使用される中型船舶用キール。  
キールは水中で横揺れの力に抵抗し、船を直立させて安定させる役割を果たします。  
また、キールは横方向の滑り力にも抵抗し、船の動きの大部分がキール軸の方向に向かうようにします。  
これがセールによって提供される力と組み合わさることで、帆船は横風の中でも、さらには向かい風の中でも前進することができます。

英語原文

A large boat keel used for sailing.

The keel resists rolling forces while submerged, helping to keep a boat upright and stable. The keel also resists lateral sliding forces, causing the majority of a boats movement to be in the direction of the keel axis. When combined with the force provided by a sail, this allows a sailboat to move forward in a crosswind, or even upwind.

価格 $1000、サイズ（WxDxH）3x15x7

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass）、出力（power） | mass:1000 |

## KEEL (SMALL)

キール（小型）：セーリングに使用される中型船舶用キール。  
キールは水中で横揺れの力に抵抗し、船を直立させて安定させる役割を果たします。  
また、キールは横方向の滑り力にも抵抗し、船の動きの大部分がキール軸の方向に向かうようにします。  
これがセールによって提供される力と組み合わさることで、帆船は横風の中でも、さらには向かい風の中でも前進することができます。

英語原文

A large boat keel used for sailing.

The keel resists rolling forces while submerged, helping to keep a boat upright and stable. The keel also resists lateral sliding forces, causing the majority of a boats movement to be in the direction of the keel axis. When combined with the force provided by a sail, this allows a sailboat to move forward in a crosswind, or even upwind.

価格 $300、サイズ（WxDxH）1x9x5

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass）、出力（power） | mass:500 |

## KEEP ACTIVE BLOCK

キープアクティブブロック：キープアライブマーキングブロック。  
車両に乗っているとき、範囲外のときは車両はデスポーンしません。

英語原文

A keep alive marking block.  
When on a vehicle, the vehicle will not despown when out of range.

※プレイヤーキャラクターが離れても乗り物を維持する。  
価格 $100、サイズ（WxDxH）1x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |

## LARGE LANDING WHEEL

大型ランディングホイール：エンジン出力を必要とせず、自由に回転する大きな着陸ホイール。  
このホイールの正逆回転を制御することはできませんが、ブレーキ入力にオン信号を送信することにより、ホイールを所定の位置にロックできます。

英語原文

Large landing wheel that requires no engine power and spins freely.  
You cannot control the forward and backward rotation of this wheel, but it can be locked into place by sending an on signal to the brake input.

※無動力のシンプルな車輪です。ブレーキのみが付いています。可変ブレーキは入力値で強さを調節できます。  
価格 $50、サイズ（WxDxH）3x3x4（中央フレームに車輪が二つ付いた形状、設置面は１マスのみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:8 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |
| ◆ Variable brake（可変ブレーキ） | 0～1 可変ブレーキの強さの設定値 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |

|  |  |
| --- | --- |
| [20190326233308_1.jpg](https://cdn.wikiwiki.jp/to/w/sbarjp/VEHICLE%20CONTROL/::attach/20190326233308_1.jpg?rev=eeee5507cb2639c8169e8cc04060306a&t=20190327002141 "20190326233308_1.jpg") | 左→LARGE LANDING WHEEL |
| 右→WHEEL COASTER |

## MEDIUM WHEEL

中型車輪：エンジンで操作できる中型ホイール。  
接続されているエンジンから受け取った動力に応じて、ホイールは前後に回転します。  
ステアリング入力に番号信号を送信することにより、左右に回転させることができます。  
また、ブレーキ入力にオン信号を送信することにより、所定の位置にロックすることもできます。

英語原文

Medium wheel that can be controlled using an engine.  
The wheel will rotate forwards and backwards depending on power received from a connected engine.  
It can be rotated left and right by sending a number signal to the steering input.  
It can also be locked into place by sending an on signal to the brake input.

※駆動、制動、舵取りができます。駆動には動力源からの動力接続が必要です。  
価格 $100、サイズ（WxDxH）5x7x7（幅４マスの車輪と1x1x1の軸で構成された車輪、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:10 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |
| ◆ Variable brake（可変ブレーキ） | 0～1 可変ブレーキの強さの設定値 |
| ◆ Steering（操舵） | -1～1 車輪の目標角度の設定値(0が中央) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 車輪駆動用の動力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |

|  |  |
| --- | --- |
| [20190326235533_1.jpg](https://cdn.wikiwiki.jp/to/w/sbarjp/VEHICLE%20CONTROL/::attach/20190326235533_1.jpg?rev=750c765a9e3d137059baf06828b644f5&t=20190327002220 "20190326235533_1.jpg") | 奥→MEDIUM WHEEL |
| 手前→SMALL WHEEL |
| [20190326235620_1.jpg](https://cdn.wikiwiki.jp/to/w/sbarjp/VEHICLE%20CONTROL/::attach/20190326235620_1.jpg?rev=f68f3738a302a0598e7e29fa49dd37b8&t=20190327002251 "20190326235620_1.jpg") | このパーツ単体でステアリングします。 |

## PILOT SEAT

操縦席：パイロットシートでは、キーボードプレスをロジックコンポーネントを制御できる出力信号に変換できます。  
－1～1の範囲の標準値を生成する4つの数値出力と、6つのオン/オフ出力を提供します。  
コンパクトパイロットシートは、[f]を使用して操作することにより、乗降できます。

英語原文

The pilot seat lets you translate keyboard presses into output signals that can control logic components.  
It provides 4 number outputs that produce a standard value ranging from -1 to 1, and 6 on/off outputs.  
You can get in and out of the compact pilot seat by interacting with it using[f].

※複数の操作を制御信号に変換する座席、見た目は台の付いた操縦席。  
　ストームワークス初期からある基本的な操縦席。  
価格 100$、サイズ（WxDxH）3x4x6（設置判定の前方下部に操縦桿基部が飛びだした座席、前方と下部の台に広い設置面がある）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:24 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Headset Audio（音声） | オーディオデータの入力 |
| ◆ Headset Video（映像） | HMDにビデオUIオーバーレイを表示 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Occupied（使用中） | 座席に誰かが座っているとオン信号を出力する |
| ◆ Trigger[space]（トリガー） | On/Offを出力 |
| ◆ Look X（水平視線方向） | -0.35（左）～0.35（右）（-126°～126°）座っているプレイヤーの水平視線方向 |
| ◆ Look Y（垂直視線方向） | -0.2（下）～0.2（上）（-72°～72°）座っているプレイヤーの垂直視線方向 |
| ◆ Axis 1 [a]/[d]（軸１） | -1～1 [a]で数値下降、[d]で数値上昇 |
| ◆ Axis 2 [w]/[s]（軸２） | -1～1 [s]で数値下降、[w]で数値上昇 |
| ◆ Axis 3 [←]/[→]（軸３） | -1～1 [←]で数値下降、[→]で数値上昇 |
| ◆ Axis 4 [↑]/[↓]（軸４） | -1～1 [↓]で数値下降、[↑]で数値上昇 |
| ◆ Hotkey 1[1]（ホットキー１） | On/Offを出力 |
| ◆ Hotkey 2[2]（ホットキー２） | On/Offを出力 |
| …中略… | |
| ◆ Hotkey 6[6]（ホットキー６） | On/Offを出力 |
| ◆ Seat data（座席情報） | 操作情報を複合データで出力 |
| ・Number channel 1～4 | Axis 1～4の数値を出力 |
| ・Number channel 9 | Look Xの数値を出力 |
| ・Number channel 10 | Look Yの数値を出力 |
| ・On/Off channel 1～6 | Hotkey1～6のオンオフ信号を出力 |
| ・On/Off channel 31 | Triggerのオンオフ信号を出力 |
| ・On/Off channel 32 | Occupiedのオンオフ信号を出力 |

SELECT選択設定項目

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称記入欄 | カーソルを合わせた時に表示される名称 |
| CONTROLS | | |
| Axis 1 [a]/[d]（軸１） | プルダウン設定 | 内容 |
| ・Label（表示名） | 名称の記入 | 着席時のヘルプに表示される名称 |
| ・Mode（モード） | Reset / Sticky | 非操作時に出力値を0に戻す[Reset]か維持するか[Sticky]の選択 |
| ・Sensitivity（感度） | 1～100％ | 操作時の数値の変動する速さ |
| Axis 2 [w]/[s]（軸２） | プルダウン設定 | 内容はAxis 1と同じ |
| Axis 3 [←]/[→]（軸３） | プルダウン設定 | 内容はAxis 1と同じ |
| Axis 4 [↑]/[↓]（軸４） | プルダウン設定 | 内容はAxis 1と同じ |
| Hotkey 1[1]（ホットキー１） | プルダウン設定 | 内容 |
| ・Label（表示名） | 名称の記入 | 着席時のヘルプに表示される名称 |
| ・Mode（モード） | Toggle / Push | 出力信号を切替え[Toggle]か押しボタン[Push]にするかの選択 |
| Hotkey 2[2]（ホットキー２） | プルダウン設定 | 内容はHotkey1と同じ |
| …中略… | | |
| Hotkey 6[6]（ホットキー６） | プルダウン設定 | 内容はHotkey1と同じ |
| TRIM | | |
| Trim Axis 1（トリム軸１） | 数値入力 | Axis 1の出力に補正値を入れる |
| Trim Axis 2（トリム軸２） | 数値入力 | Axis 2の出力に補正値を入れる |
| Trim Axis 3（トリム軸３） | 数値入力 | Axis 3の出力に補正値を入れる |
| Trim Axis 4（トリム軸４） | 数値入力 | Axis 4の出力に補正値を入れる |

※トリムの設定値は、乗り物を操作する際のAlt＋軸操作でするトリム操作と同じもの。  
　ここで入力された値は乗り物をフィールドに出した際にトリム値が入力された状態になる。

解説文

操縦席です。近づいて[f]キーで使用します。プレイヤーのキーボードもしくはゲームパッド操作を各種の入力信号にしてくれます。  
自由に設定できる数値軸を4軸とオンオフ出力を6個持ちます。  
名前を設定すると使用した際左下にヒントボックスとして表示されます。  
軸設定は手を離した際に中立位置に戻るのがReset、数値を保持するのがStickyです。  
キー設定は押すたびにオンオフを切り替えるのがToggle、押してる間だけオンなのがPushです。  
軸トリムは乗り込んでaltキーで設定も可。ちなみに軸はデフォルトであればas←↓が-1、wd→↑が1です。

## PILOT SEAT (HOTAS)

操縦席(HOTAS)：パイロットシートでは、キーボードプレスをロジックコンポーネントを制御できる出力信号に変換できます。  
－1～1の範囲の標準値を生成する8つの数値出力と、48のオン/オフ出力を提供します。  
コンパクトパイロットシートは、[f]を使用して操作することにより、乗降できます。  
フライトスティック用に設計されています。

英語原文

The pilot seat lets you translate keyboard presses into output signals that can control logic components.  
It provides 8 number outputs that produce a standard value ranging from -1 to 1, and 48 on/off outputs.  
You can get in and out of the compact pilot seat by interacting with it using[f].  
Designed for use with HOTAS controllers.

※複数の操作を制御信号に変換する座席、見た目は黒いフレームの付いた操縦席、重量が重い。  
　フライトスティックに対応した複数軸複数ボタンの操縦席。ストームワークス初期からある。  
価格 $250、サイズ（WxDxH）3x5x6（設置判定の前方下部に操縦桿基部が飛びだした座席、前方と下部の台に広い設置面がある）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:50 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Headset Audio（音声） | オーディオデータの入力 |
| ◆ Headset Video（映像） | HMDにビデオUIオーバーレイを表示 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Occupied（使用中） | 座席に誰かが座っているとオン信号を出力する |
| ◆ Trigger[space]（トリガー） | On/Offを出力 |
| ◆ Look X（水平視線方向） | -0.35（左）～0.35（右）（-126°～126°）座っているプレイヤーの水平視線方向 |
| ◆ Look Y（垂直視線方向） | -0.2（下）～0.2（上）（-72°～72°）座っているプレイヤーの垂直視線方向 |
| ◆ Axis 1 [a]/[d]（軸１） | -1～1 [a]で数値下降、[d]で数値上昇 |
| ◆ Axis 2 [w]/[s]（軸２） | -1～1 [s]で数値下降、[w]で数値上昇 |
| ◆ Axis 3 [←]/[→]（軸３） | -1～1 [←]で数値下降、[→]で数値上昇 |
| ◆ Axis 4 [↑]/[↓]（軸４） | -1～1 [↓]で数値下降、[↑]で数値上昇 |
| ◆ Axis 5（軸５） | -1～1 ※ |
| ◆ Axis 6（軸６） | -1～1 ※ |
| ◆ Axis 7（軸７） | -1～1 ※ |
| ◆ Axis 8（軸８） | -1～1 ※ |
| ◆ Hotkey 1[1]（ホットキー１） | On/Offを出力 |
| ◆ Hotkey 2[2]（ホットキー２） | On/Offを出力 |
| …中略… | |
| ◆ Hotkey 48[]（ホットキー４８） | On/Offを出力 ※ |
| ◆ Seat data（座席情報） | 操作情報を複合データで出力 |
| ・Number channel 1～8 | Axis 1～8の数値を出力 |
| ・Number channel 9 | Look Xの数値を出力 |
| ・Number channel 10 | Look Yの数値を出力 |
| ・On/Off channel 1～6 | Hotkey1～31のオンオフ信号を出力 |
| ・On/Off channel 31 | Triggerのオンオフ信号を出力 |
| ・On/Off channel 32 | Occupiedのオンオフ信号を出力 |

※Axis5～8、Hotkey7～48の使用にはOPTIONで設定が必要です。  
　コンポジット出力のOn/Offchannel 32についてはOccupiedの信号出力と被る為確認不可。  
　また、On/Offchannel 33～48については信号出力されているかもしれないがマイコン側のチャンネルが足りず認識する手段がない。  
　その為、使用する場合はロジック出力からマイコンなどへ繋げる等の方法が必要です。

SELECT選択設定項目

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称記入欄 | カーソルを合わせた時に表示される名称 |
| CONTROLS | | |
| Axis 1 [a]/[d]（軸１） | プルダウン設定 | 内容 |
| ・Label（表示名） | 名称の記入 | 着席時のヘルプに表示される名称 |
| ・Mode（モード） | Reset / Sticky | 非操作時に出力値を0に戻す[Reset]か維持するか[Sticky]の選択 |
| ・Sensitivity（感度） | 1～100％ | 操作時の数値の変動する速さ |
| Axis 2 [w]/[s]（軸２） | プルダウン設定 | 内容はAxis 1と同じ |
| Axis 3 [←]/[→]（軸３） | プルダウン設定 | 内容はAxis 1と同じ |
| Axis 4 [↑]/[↓]（軸４） | プルダウン設定 | 内容はAxis 1と同じ |
| Axis 5（軸５） | プルダウン設定 | 内容 |
| ・Label（表示名） | 名称の記入 | 着席時のヘルプに表示される名称 |
| ・Mode（モード） | Reset / Sticky | 非操作時に出力値を0に戻す[Reset]か維持するか[Sticky]の選択 |
| Axis 6（軸６） | プルダウン設定 | 内容はAxis 5と同じ |
| Axis 7（軸７） | プルダウン設定 | 内容はAxis 5と同じ |
| Axis 8（軸８） | プルダウン設定 | 内容はAxis 5と同じ |
| Hotkey 1[1]（ホットキー１） | プルダウン設定 | 内容 |
| ・Label（表示名） | 名称の記入 | 着席時のヘルプに表示される名称 |
| ・Mode（モード） | Toggle / Push | 出力信号を切替え[Toggle]か押しボタン[Push]にするかの選択 |
| Hotkey 2[2]（ホットキー２） | プルダウン設定 | 内容はHotkey1と同じ |
| …中略… | | |
| Hotkey 48[]（ホットキー４８） | プルダウン設定 | 内容はHotkey1と同じ |
| TRIM | | |
| Trim Axis 1（トリム軸１） | 数値入力 | Axis 1の出力に補正値を入れる |
| Trim Axis 2（トリム軸２） | 数値入力 | Axis 2の出力に補正値を入れる |
| Trim Axis 3（トリム軸３） | 数値入力 | Axis 3の出力に補正値を入れる |
| Trim Axis 4（トリム軸４） | 数値入力 | Axis 4の出力に補正値を入れる |

※トリムの設定値は、乗り物を操作する際のAlt＋軸操作でするトリム操作と同じもの。  
　ここで入力された値は乗り物をフィールドに出した際にトリム値が入力された状態になる。

## RADIO RX HUGE

ラジオアンテナ巨大：無線データ送信機および受信機。  
指定された頻度でデータを送受信します。  
送信モードのデフォルトは受信です。

英語原文

A radio data transmitter and receiver.  
Sends and receives data on the specified frequency.  
Transmit mode defaults to receive.

※音声や複合信号を送受信する無線アンテナ。  
価格 $3000、サイズ（WxDxH）1x1x9（1x1x1のブロックにアンテナが立っている）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:20 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Audio Send（音声送信） | 送信する音声データの入力 |
| ◆ Data Send（データ送信） | 送信する複合信号の入力 |
| ◆ Frequency（周波数） | 送受信する周波数の設定値 |
| ◆ Transmit Mode（送信モード） | On/Off(送信/受信) |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Audio Recv（音声受信） | 受信した音声データの出力 |
| ◆ Data Recv（データ受信） | 受信した複合信号の出力 |
| ◆ Signal Strength（信号強度） | 受信した信号の強さ |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

※無線アンテナについて  
・アンテナ部分は根元からバネのように揺れる。  
・TransmitModeで受信(OFF)と送信(ON)の切り替え。送信に設定している間は受信出来ず、受信中は送信できない。  
・Frequencyで送受信する周波数帯を設定。周波数が一致していないと送受信できない。  
・送受信するデータはコンポジット信号と音声信号の二つ。  
・無線信号の届く距離はアンテナの大きさ、電力に応じる？（要検証）

## RADIO RX LARGE

ラジオアンテナ大型：無線データ送信機および受信機。  
指定された頻度でデータを送受信します。  
送信モードのデフォルトは受信です。

英語原文

A radio data transmitter and receiver.  
Sends and receives data on the specified frequency.  
Transmit mode defaults to receive.

※音声や複合信号を送受信する無線アンテナ。  
価格 $1000、サイズ（WxDxH）1x1x5（1x1x1のブロックにアンテナが立っている）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:12 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Audio Send（音声送信） | 送信する音声データの入力 |
| ◆ Data Send（データ送信） | 送信する複合信号の入力 |
| ◆ Frequency（周波数） | 送受信する周波数の設定値 |
| ◆ Transmit Mode（送信モード） | On/Off(送信/受信) |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Audio Recv（音声受信） | 受信した音声データの出力 |
| ◆ Data Recv（データ受信） | 受信した複合信号の出力 |
| ◆ Signal Strength（信号強度） | 受信した信号の強さ |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## RADIO RX MEDIUM

ラジオアンテナ中型：無線データ送信機および受信機。  
指定された頻度でデータを送受信します。  
送信モードのデフォルトは受信です。

英語原文

A radio data transmitter and receiver.  
Sends and receives data on the specified frequency.  
Transmit mode defaults to receive.

※音声や複合信号を送受信する無線アンテナ。  
価格 $500、サイズ（WxDxH）1x1x4（1x1x1のブロックにアンテナが立っている）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:8 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Audio Send（音声送信） | 送信する音声データの入力 |
| ◆ Data Send（データ送信） | 送信する複合信号の入力 |
| ◆ Frequency（周波数） | 送受信する周波数の設定値 |
| ◆ Transmit Mode（送信モード） | On/Off(送信/受信) |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Audio Recv（音声受信） | 受信した音声データの出力 |
| ◆ Data Recv（データ受信） | 受信した複合信号の出力 |
| ◆ Signal Strength（信号強度） | 受信した信号の強さ |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## RADIO RX SMALL

ラジオアンテナ小型：無線データ送信機および受信機。  
指定された頻度でデータを送受信します。  
送信モードのデフォルトは受信です。

英語原文

A radio data transmitter and receiver.  
Sends and receives data on the specified frequency.  
Transmit mode defaults to receive.

※音声や複合信号を送受信する無線アンテナ。  
価格 $200、サイズ（WxDxH）1x1x2（1x1x1のブロックにアンテナが立っている）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Audio Send（音声送信） | 送信する音声データの入力 |
| ◆ Data Send（データ送信） | 送信する複合信号の入力 |
| ◆ Frequency（周波数） | 送受信する周波数の設定値 |
| ◆ Transmit Mode（送信モード） | On/Off(送信/受信) |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Audio Recv（音声受信） | 受信した音声データの出力 |
| ◆ Data Recv（データ受信） | 受信した複合信号の出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## RADIO VIDEO RECV

無線ビデオ受信機：ビデオ信号を受信するためのラジオ受信機。  
指定された周波数でビデオ信号を受信します。

英語原文

A radio receiver for receiving video siganls.  
Receives a video signal on the frequency specified.

※映像信号を受信する無線アンテナ。  
価格 $1---、サイズ（WxDxH）1x1x4（1x1x1のブロックにアンテナが立っている）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:10 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Frequency（周波数） | 受信する周波数の設定値 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Video Recv（映像受信） | 受信したビデオデータの出力 |
| ◆ Signal Strength（信号強度） | 受信した信号の強さ |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## RADIO VIDEO XMIT

無線ビデオ送信機：ビデオ信号を送信するための無線送信機。  
指定された周波数でビデオ信号を送信します。(最大有効範囲 : 10000m)

英語原文

A radio transmitter for sending video siganls.  
Sends a video signal on the frequency specified. (Max Effective Range : 10000m)

※映像信号を送信する無線アンテナ。  
価格 $2000、サイズ（WxDxH）1x1x4（1x1x1のブロックにアンテナが立っている）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:10 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Video Send（映像送信） | 送信するビデオデータの出力 |
| ◆ Frequency Send（送信周波数） | 送信する周波数の設定値 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## RUDDER

ラダー：ラダーをボートの下側に取り付けて、ヨーを制御できます。  
左右に操縦できます。  
ラダーの回転の両極端を表す-1と1の間の数値入力を受け取ります。

英語原文

The rudder can be attached to the underside of a boat to control its yaw.  
allowing you to steer left and right.  
It takes a number input between -1 and 1 that represent the two extremes of the rudder's rotation.

※3x3の台にＴ字型に可動翼の付いた形状、台が有る分いろんな角度で設置出来る。  
　動作角度は目測で±45度ほど、翼面に対して水や空気、風の影響を受ける。  
[![20190326233925_1.jpg](https://cdn.wikiwiki.jp/to/w/sbarjp/VEHICLE%20CONTROL/::ref/20190326233925_1.jpg.webp?rev=442630f865f7baad2a144d6c560b3772&t=20190327002149 "20190326233925_1.jpg")](https://cdn.wikiwiki.jp/to/w/sbarjp/VEHICLE%20CONTROL/::attach/20190326233925_1.jpg?rev=442630f865f7baad2a144d6c560b3772&t=20190327002149 "20190326233925_1.jpg")  
価格 $150、サイズ（WxDxH）3x3x4（設置面は翼の台になっている3x3マス）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:10 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Rotation（回転） | -1～1 目標角度の設定値(0が中心で±45度) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## RX DIRECTIONAL

指向性レシーバー：強力な指向性無線・映像信号送信および受信機。  
指定された周波数でデータを送受信します。  
送信モードのデフォルトは受信です。(地上での最大有効範囲：8000km)

英語原文

A powerful directional radio and video data transmitter and receiver.  
Must be pointed at the target RX device. Sends and receives data on the specified frequency. Transmit Mode defaults to receive. (Max effective range at ground level : 8000km)

※音声や映像、複合信号を送受信する指向性アンテナ。土台に2軸の回転軸がある、天頂に向けることで地上↔宇宙・月面間の通信も可能。  
価格 $5000、サイズ（WxDxH）5x5x4（設置面の付いた1x1x1のジンバル付き土台に予約ボクセルに包まれたパラボラアンテナが立っている）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:20 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Audio Send（音声送信） | 送信する音声データの入力 |
| ◆ Data Send（データ送信） | 送信する複合信号の入力 |
| ◆ Frequency（周波数） | 送受信する周波数の設定値 |
| ◆ Transmit Mode（送信モード） | On/Off(送信/受信) |
| ◆ Target Pitch（目標ピッチ） | -1～1 アンテナの目標角度の設定値(0が中心で±45度) |
| ◆ Target Yaw（目標ヨｰ） | -?～? アンテナの目標角度の設定値(0を中心に±1で360度) |
| ◆ Video Send（映像送信） | 送信するビデオデータの出力 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Audio Recv（音声受信） | 受信した音声データの出力 |
| ◆ Data Recv（データ受信） | 受信した複合信号の出力 |
| ◆ Signal Strength（信号強度） | 受信した信号の強さ |
| ◆ Video Recv（映像受信） | 受信したビデオデータの出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## RX DIRECTIONAL (LARGE)

指向性レシーバー(大型)：強力な指向性無線・映像信号送信および受信機。  
指定された周波数でデータを送受信します。  
送信モードのデフォルトは受信です。(地上での最大有効範囲：10000km)

英語原文

A powerful directional radio and video data transmitter and receiver.  
Must be pointed at the target RX device. Sends and receives data on the specified frequency. Transmit Mode defaults to receive. (Max effective range at ground level : 10000km)

※音声や映像、複合信号を送受信する指向性アンテナ。土台に2軸の回転軸がある、天頂に向けることで地上↔宇宙・月面間の通信も可能。  
価格 $8000、サイズ（WxDxH）9x9x6（設置面の付いた1x1x1のジンバル付き土台に予約ボクセルに包まれたパラボラアンテナが立っている）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:35 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Audio Send（音声送信） | 送信する音声データの入力 |
| ◆ Data Send（データ送信） | 送信する複合信号の入力 |
| ◆ Frequency（周波数） | 送受信する周波数の設定値 |
| ◆ Transmit Mode（送信モード） | On/Off(送信/受信) |
| ◆ Target Pitch（目標ピッチ） | -1～1 アンテナの目標角度の設定値(0が中心で±45度) |
| ◆ Target Yaw（目標ヨー） | -?～? アンテナの目標角度の設定値(0を中心に±1で360度) |
| ◆ Video Send（映像送信） | 送信するビデオデータの出力 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Audio Recv（音声受信） | 受信した音声データの出力 |
| ◆ Data Recv（データ受信） | 受信した複合信号の出力 |
| ◆ Signal Strength（信号強度） | 受信した信号の強さ |
| ◆ Video Recv（映像受信） | 受信したビデオデータの出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

## SKI

スキー：ワイドヒンジスキー。  
このコンポーネントは、その長さに沿って動く摩擦が少ないですが、横方向にグリップします。

英語原文

A wide hinged ski.  
This component has low friction moving along its length, but grips laterally.

※DirectionArrows(青い矢印)の前後方向に滑り、横方向にはグリップ力がある。

|  |  |
| --- | --- |
| [20190326234559_1.jpg](https://cdn.wikiwiki.jp/to/w/sbarjp/VEHICLE%20CONTROL/::attach/20190326234559_1.jpg?rev=8affe7f0b5f76196a435918e581ac865&t=20190327002159 "20190326234559_1.jpg") | 奥→ SKI |
| 手前→ SKI (SMALL) |

価格 $200、サイズ（WxDxH）3x13x2（幅３マスのスキー板と1x1x1の軸で構成されたスキー、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:12 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Steering（操舵） | -1～1 スキー板の左右角度の設定値(0が中央) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Spring Strength（バネ強さ） | 0～100％(デフォルト値25％) | ヒンジ部バネの強さを設定 |

## SKI (SMALL)

スキー(小)：小さなワイドヒンジスキー。  
このコンポーネントは、その長さに沿って動く摩擦が少ないですが、横方向にグリップします。

英語原文

A small hinged ski.  
This component has low friction moving along its length, but grips laterally.

価格 $100、サイズ（WxDxH）1x9x2（幅１マスのスキー板と1x1x1の軸で構成されたスキー、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:8 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Steering（操舵） | -1～1 スキー板の左右角度の設定値(0が中央) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Spring Strength（バネ強さ） | 0～100％(デフォルト値25％) | ヒンジ部バネの強さを設定 |

## SMALL WHEEL

小型車輪：エンジンで操作できる小型ホイール。  
接続されているエンジンから受け取った動力に応じて、ホイールは前後に回転します。  
ステアリング入力に番号信号を送信することにより、左右に回転させることができます。  
また、ブレーキ入力にオン信号を送信することにより、所定の位置にロックすることもできます。

英語原文

Small wheel that can be controlled using an engine.  
The wheel will rotate forwards and backwards depending on power received from a connected engine.  
It can be rotated left and right by sending a number signal to the steering input.  
It can also be locked into place by sending an on signal to the brake input.

※駆動、制動、舵取りができます。駆動には動力源からの動力接続が必要です。  
価格 $30、サイズ（WxDxH）4x3x3（幅３マスの車輪と1x1x1の軸で構成された車輪、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |
| ◆ Variable brake（可変ブレーキ） | 0～1 可変ブレーキの強さの設定値 |
| ◆ Steering（操舵） | -1～1 車輪の目標角度の設定値(0が中央) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 車輪駆動用の動力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |

## SPACE SEAT

宇宙用操縦席：コンパクトなコントロールハンドル。[f]を使用して操作することにより、乗降できます。

英語原文

A compact control handle. You can get in and out of the position by interacting with it using [f].

※複数の操作を制御信号に変換する座席、見た目はスラスラや燃料タンクのない有人操縦ユニット(MMU)。当たり判定が無い。  
　吸気口に酸素ないしはAirを供給して宇宙服を装備した状態で座ると宇宙服の酸素の消費を肩代りしてくれる。  
価格 $500、サイズ（WxDxH）3x3x7（背面の設置判定に吸気口がある座席、吸気口を囲むように3x3の設置面がある。）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:3 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Headset Audio（音声） | オーディオデータの入力 |
| ◆ Headset Video（映像） | HMDにビデオUIオーバーレイを表示 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Occupied（使用中） | 座席に誰かが座っているとオン信号を出力する |
| ◆ Trigger[space]（トリガー） | On/Offを出力 |
| ◆ Look X（水平視線方向） | -0.35（左）～0.35（右）（-126°～126°）座っているプレイヤーの水平視線方向 |
| ◆ Look Y（垂直視線方向） | -0.2（下）～0.2（上）（-72°～72°）座っているプレイヤーの垂直視線方向 |
| ◆ Axis 1 [a]/[d]（軸１） | -1～1 [a]で数値下降、[d]で数値上昇 |
| ◆ Axis 2 [w]/[s]（軸２） | -1～1 [s]で数値下降、[w]で数値上昇 |
| ◆ Axis 3 [←]/[→]（軸３） | -1～1 [←]で数値下降、[→]で数値上昇 |
| ◆ Axis 4 [↑]/[↓]（軸４） | -1～1 [↓]で数値下降、[↑]で数値上昇 |
| ◆ Hotkey 1[1]（ホットキー１） | On/Offを出力 |
| ◆ Hotkey 2[2]（ホットキー２） | On/Offを出力 |
| …中略… | |
| ◆ Hotkey 6[6]（ホットキー６） | On/Offを出力 |
| ◆ Seat data（座席情報） | 操作情報を複合データで出力 |
| ・Number channel 1～4 | Axis 1～4の数値を出力 |
| ・Number channel 9 | Look Xの数値を出力 |
| ・Number channel 10 | Look Yの数値を出力 |
| ・On/Off channel 1～6 | Hotkey1～6のオンオフ信号を出力 |
| ・On/Off channel 31 | Triggerのオンオフ信号を出力 |
| ・On/Off channel 32 | Occupiedのオンオフ信号を出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Fluid In（流体入口） | 着席時宇宙服に酸素を供給 |

SELECT選択設定項目

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称記入欄 | カーソルを合わせた時に表示される名称 |
| CONTROLS | | |
| Axis 1 [a]/[d]（軸１） | プルダウン設定 | 内容 |
| ・Label（表示名） | 名称の記入 | 着席時のヘルプに表示される名称 |
| ・Mode（モード） | Reset / Sticky | 非操作時に出力値を0に戻す[Reset]か維持するか[Sticky]の選択 |
| ・Sensitivity（感度） | 1～100％ | 操作時の数値の変動する速さ |
| Axis 2 [w]/[s]（軸２） | プルダウン設定 | 内容はAxis 1と同じ |
| Axis 3 [←]/[→]（軸３） | プルダウン設定 | 内容はAxis 1と同じ |
| Axis 4 [↑]/[↓]（軸４） | プルダウン設定 | 内容はAxis 1と同じ |
| Hotkey 1[1]（ホットキー１） | プルダウン設定 | 内容 |
| ・Label（表示名） | 名称の記入 | 着席時のヘルプに表示される名称 |
| ・Mode（モード） | Toggle / Push | 出力信号を切替え[Toggle]か押しボタン[Push]にするかの選択 |
| Hotkey 2[2]（ホットキー２） | プルダウン設定 | 内容はHotkey1と同じ |
| …中略… | | |
| Hotkey 6[6]（ホットキー６） | プルダウン設定 | 内容はHotkey1と同じ |
| TRIM | | |
| Trim Axis 1（トリム軸１） | 数値入力 | Axis 1の出力に補正値を入れる |
| Trim Axis 2（トリム軸２） | 数値入力 | Axis 2の出力に補正値を入れる |
| Trim Axis 3（トリム軸３） | 数値入力 | Axis 3の出力に補正値を入れる |
| Trim Axis 4（トリム軸４） | 数値入力 | Axis 4の出力に補正値を入れる |

※トリムの設定値は、乗り物を操作する際のAlt＋軸操作でするトリム操作と同じもの。  
　ここで入力された値は乗り物をフィールドに出した際にトリム値が入力された状態になる。

## TANK DRIVE WHEEL (HUGE)

戦車駆動輪(巨大)：無限軌道車用の大きな駆動輪。  
ホイールは、同じボディに同じサイズと向きで配置された同じサイズと向きの他のホイールと一緒にトラックを形成します。

英語原文

Large drive wheel for tracked vehicles.  
The wheel will form a track with other wheels of the same size and orientation that are placed in line and on the same body.

価格 $450、サイズ（WxDxH）5x7x7（幅４マスの車輪と1x1x1の軸で構成された起動輪、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:80 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 車輪駆動用の動力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |
| Track Tension（軌道の張り） | 1～100％ | 張り強さの設定 |

- 無限軌道について  
  車輪部分にしか判定が無い為、通常の車輪と似たような扱い。転輪を離れた位置から起動輪で回す事が出来る車輪という感じ。  
  もちろん各車輪一つ一つは操舵できない。左右の駆動力の差で操向しよう。

  接地判定の方向がある。まっすぐな矢印が向いている方向が地面になるように付けよう。  
  [仮説]これ以外の方向にはグリップしない。例えばトンネルの天井にグリップしたい時(!?)にビークルエディットで矢印が上向きになるように付けてもグリップしない。(ここまでは相手が天井ではなく同ビークルの別パーツだが確認済み。垂直面でも同様にグリップしない。) ビークルエディット中は下向きになるように作った上で、スポーンさせた後にヒンジなどで上向きに変えるとよい(?要検証)

  MERGEで確認した時に別パーツになっている場合は繋がらない。つまり、独立懸架はできない。~~実車ではできるのに…~~  
  また、各々の回転する面がずれている場合、他と異なる接地判定方向を向いている場合、そして大きさ(履帯の幅)が違うTank Wheel同士も繋がらない。  
  全ての繋がることができるホイールの一番外側を履帯が通る。一番外側の環より完全に内側に入るホイールには繋がらない。

  [仮説]一つの履帯の環を構成する車輪に二つ以上の起動輪があって、それが異なる駆動力で回転した場合、厳密に同じ速度で回転する。(?要検証)  
  [仮説]一つのエンジンの出力を異なる変速比のギアボックスを介して一つの履帯の環を構成する二つの起動輪に伝達した場合、回転せずエンジンストールする。(?要検証)

## TANK DRIVE WHEEL (LARGE)

戦車駆動輪(大型)：無限軌道車用の中型駆動輪。  
ホイールは、同じボディに同じサイズと向きで配置された同じサイズと向きの他のホイールと一緒にトラックを形成します。

英語原文

Medium drive wheel for tracked vehicles.  
The wheel will form a track with other wheels of the same size and orientation that are placed in line and on the same body.

価格 $350、サイズ（WxDxH）3x5x5（幅２マスの車輪と1x1x1の軸で構成された起動輪、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:40 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 車輪駆動用の動力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さの設定 |
| Track Tension（軌道の張り） | 1～100％ | 張り強さの設定 |

## TANK DRIVE WHEEL (MIDIUM)

戦車駆動輪(中型)：無限軌道車用の中型駆動輪。  
ホイールは、同じボディに同じサイズと向きで配置された同じサイズと向きの他のホイールと一緒にトラックを形成します。

英語原文

Medium drive wheel for tracked vehicles.  
The wheel will form a track with other wheels of the same size and orientation that are placed in line and on the same body.

※TANK DRIVE WHEEL (LARGE)と内径は一緒だが幅が狭い。  
価格 $300、サイズ（WxDxH）3x5x5（幅２マスの車輪と1x1x1の軸で構成された起動輪、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:30 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 車輪駆動用の動力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さの設定 |
| Track Tension（軌道の張り） | 1～100％ | 張り強さの設定 |

## TANK DRIVE WHEEL (SMALL)

戦車駆動輪(小型)：無限軌道車用の小さな駆動輪。  
ホイールは、同じボディに同じサイズと向きで配置された同じサイズと向きの他のホイールと一緒にトラックを形成します。

英語原文

Small drive wheel for tracked vehicles.  
The wheel will form a track with other wheels of the same size and orientation that are placed in line and on the same body.

価格 $200、サイズ（WxDxH）2x3x3（幅１マスの車輪と1x1x1の軸で構成された起動輪、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:20 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 車輪駆動用の動力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |
| Track Tension（軌道の張り） | 1～100％ | 張り強さの設定 |

## TANK WHEEL (HUGE)

戦車輪(巨大)：無限軌道車用の巨大ホイール。  
接続されたトラックを回転させるには、駆動輪が必要です。  
ホイールは、同じボディに並んで配置された方向を持つトラックを形成します。

英語原文

Large wheel for tracked vehicles.  
A drive wheel is required to rotate the connected track.  
The wheel will form a track with orientation that are placed in line and on the same body.

価格 $350、サイズ（WxDxH）5x7x7（幅４マスの車輪と1x1x1の軸で構成された転輪、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:80 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |
| Track Tension（軌道の張り） | 1～100％ | 張り強さの設定 |

## TANK WHEEL (LARGE)

戦車輪(大型)：無限軌道車用の中型ホイール。  
接続されたトラックを回転させるには、駆動輪が必要です。  
ホイールは、同じボディに並んで配置された方向を持つトラックを形成します。

英語原文

Medium wheel for tracked vehicles.  
A drive wheel is required to rotate the connected track.  
The wheel will form a track with orientation that are placed in line and on the same body.

価格 $250、サイズ（WxDxH）3x5x5（幅２マスの車輪と1x1x1の軸で構成された転輪、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:40 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |
| Track Tension（軌道の張り） | 1～100％ | 張り強さの設定 |

## TANK WHEEL (MEDIUM)

戦車輪(大型)：無限軌道車用の中型ホイール。  
接続されたトラックを回転させるには、駆動輪が必要です。  
ホイールは、同じボディに並んで配置された方向を持つトラックを形成します。

英語原文

Medium wheel for tracked vehicles.  
A drive wheel is required to rotate the connected track.  
The wheel will form a track with orientation that are placed in line and on the same body.

※TANK WHEEL (LARGE)と内径は一緒だが幅が狭い。  
価格 $200、サイズ（WxDxH）3x5x5（幅２マスの車輪と1x1x1の軸で構成された転輪、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:30 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |
| Track Tension（軌道の張り） | 1～100％ | 張り強さの設定 |

## TANK WHEEL (SMALL)

戦車輪(小型)：無限軌道車用の小型ホイール。  
接続されたトラックを回転させるには、駆動輪が必要です。  
ホイールは、同じボディに並んで配置された方向を持つトラックを形成します。

英語原文

Small wheel for tracked vehicles.  
A drive wheel is required to rotate the connected track.  
The wheel will form a track with orientation that are placed in line and on the same body.

価格 $100、サイズ（WxDxH）2x3x3（幅１マスの車輪と1x1x1の軸で構成された転輪、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:20 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |
| Track Tension（軌道の張り） | 1～100％ | 張り強さの設定 |

## WHEEL 3X3

車輪３ｘ３：動力接続とブレーキが付いた小さな操縦可能なホイール。  
ホイールは、受け取った電力に応じて前後に回転します。  
ステアリング入力に番号信号を送信することにより、左右に回転させることができます。  
また、ブレーキ入力にオン信号を送信することにより、所定の位置にロックすることもできます。

英語原文

Small steerable wheel with power connection and braking.  
The wheel will rotate forwards and backwards Depending on power received.  
It can be rotated left and right by sending a number signal to the steering input.  
It can also be locked into place by sending an on signal to the brake input.

価格 $100、サイズ（WxDxH）2x3x3（幅１マスの車輪と1x1x1の軸で構成された車輪、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:10 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |
| ◆ Variable brake（可変ブレーキ） | 0～1 可変ブレーキの強さの設定値 |
| ◆ Steering（操舵） | -1～1 車輪の目標角度の設定値(0が中央) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 車輪駆動用の動力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Tyre Tread（タイヤ種類） | All Round / Hgih Speed / Hgih Grip | タイヤの種類を設定 |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |
| Tyre Pressure（タイヤ圧） | 1～100％ | タイヤ空気圧を設定 |

## WHEEL 3X3 (SUSPENSION)

車輪３ｘ３(サスペンション)：サスペンション、動力接続、ブレーキ機能を備えた小型の操縦可能なホイール。  
ホイールは、受け取った電力に応じて前後に回転します。  
ステアリング入力に番号信号を送信することにより、左右に回転させることができます。  
また、ブレーキ入力にオン信号を送信することにより、所定の位置にロックすることもできます。

英語原文

Small steerable wheel with suspension, power connection and braking.  
The wheel will rotate forwards and backwards depending on power received.  
It can be rotated left and right by sending a number signal to the steering input.  
It can also be locked into place by sending an on signal to the brake input.

価格 $150、サイズ（WxDxH）3x3x3（幅１マスの車輪と2x1x2Ｌ字サスペンション軸で構成された車輪、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:15 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |
| ◆ Variable brake（可変ブレーキ） | 0～1 可変ブレーキの強さの設定値 |
| ◆ Steering（操舵） | -1～1 車輪の目標角度の設定値(0が中央) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 車輪駆動用の動力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Tyre Tread（タイヤ種類） | All Round / Hgih Speed / Hgih Grip | タイヤの種類を設定 |
| Stiffness（剛性） | 1～100％(デフォルト値40) | サスペンションの硬さを設定 |
| Damping（制動） | 1～100％(デフォルト値11) | サスペンションの張りを設定 |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |
| Tyre Pressure（タイヤ圧） | 1～100％ | タイヤ空気圧を設定 |

## WHEEL 5X5

車輪５ｘ５：動力接続とブレーキ機能を備えた中型の操縦可能なホイール。  
ホイールは、受け取った電力に応じて前後に回転します。  
ステアリング入力に番号信号を送信することにより、左右に回転させることができます。  
また、ブレーキ入力にオン信号を送信することにより、所定の位置にロックすることもできます。

英語原文

Medium steerable wheel with power connection and braking.  
The wheel will rotate forwards and backwards Depending on power received.  
It can be rotated left and right by sending a number signal to the steering input.  
It can also be locked into place by sending an on signal to the brake input.

価格 $160、サイズ（WxDxH）3x5x5（幅２マスの車輪と1x1x1の軸で構成された車輪、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:20 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |
| ◆ Variable brake（可変ブレーキ） | 0～1 可変ブレーキの強さの設定値 |
| ◆ Steering（操舵） | -1～1 車輪の目標角度の設定値(0が中央) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 車輪駆動用の動力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Tyre Tread（タイヤ種類） | All Round / Hgih Speed / Hgih Grip | タイヤの種類を設定 |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |
| Tyre Radius（タイヤ半径） | 0.00～1.00 | タイヤ半径を設定 |
| Tyre Pressure（タイヤ圧） | 1～100％ | タイヤ空気圧を設定 |

## WHEEL 5X5 (SUSPENSION)

車輪５ｘ５(サスペンション)：サスペンション、動力接続、ブレーキ機能を備えた中型の操縦可能なホイール。  
ホイールは、受け取った電力に応じて前後に回転します。  
ステアリング入力に番号信号を送信することにより、左右に回転させることができます。  
また、ブレーキ入力にオン信号を送信することにより、所定の位置にロックすることもできます。

英語原文

Medium steerable wheel with suspension, power connection and braking.  
The wheel will rotate forwards and backwards depending on power received.  
It can be rotated left and right by sending a number signal to the steering input.  
It can also be locked into place by sending an on signal to the brake input.

価格 $200、サイズ（WxDxH）5x5x5（幅２マスの車輪と3x1x3Ｌ字サスペンション軸で構成された車輪、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:30 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |
| ◆ Variable brake（可変ブレーキ） | 0～1 可変ブレーキの強さの設定値 |
| ◆ Steering（操舵） | -1～1 車輪の目標角度の設定値(0が中央) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 車輪駆動用の動力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Tyre Tread（タイヤ種類） | All Round / Hgih Speed / Hgih Grip | タイヤの種類を設定 |
| Stiffness（剛性） | 1～100％(デフォルト値40) | サスペンションの硬さを設定 |
| Damping（制動） | 1～100％(デフォルト値11) | サスペンションの張りを設定 |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |
| Tyre Radius（タイヤ半径） | 0.00～1.00 | タイヤ半径を設定 |
| Tyre Pressure（タイヤ圧） | 1～100％ | タイヤ空気圧を設定 |

## WHEEL 7X7

車輪７ｘ７：動力接続とブレーキ機能を備えた大型の操縦可能なホイール。  
ホイールは、受け取った電力に応じて前後に回転します。  
ステアリング入力に番号信号を送信することにより、左右に回転させることができます。  
また、ブレーキ入力にオン信号を送信することにより、所定の位置にロックすることもできます。

英語原文

Large steerable wheel with power connection and braking.  
The wheel will rotate forwards and backwards Depending on power received.  
It can be rotated left and right by sending a number signal to the steering input.  
It can also be locked into place by sending an on signal to the brake input.

価格 $200、サイズ（WxDxH）4x7x7（幅３マスの車輪と1x1x1の軸で構成された車輪、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:40 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |
| ◆ Variable brake（可変ブレーキ） | 0～1 可変ブレーキの強さの設定値 |
| ◆ Steering（操舵） | -1～1 車輪の目標角度の設定値(0が中央) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 車輪駆動用の動力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Tyre Tread（タイヤ種類） | All Round / Hgih Speed / Hgih Grip | タイヤの種類を設定 |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |
| Tyre Radius（タイヤ半径） | 0.00～1.00 | タイヤ半径を設定 |
| Tyre Pressure（タイヤ圧） | 1～100％ | タイヤ空気圧を設定 |

## WHEEL 7x7 (SUSPENSION)

車輪７ｘ７(サスペンション)：サスペンション、動力接続、ブレーキ機能を備えた大型の操縦可能なホイール。  
ホイールは、受け取った電力に応じて前後に回転します。  
ステアリング入力に番号信号を送信することにより、左右に回転させることができます。  
また、ブレーキ入力にオン信号を送信することにより、所定の位置にロックすることもできます。

英語原文

Large steerable wheel with suspension, power connection and braking.  
The wheel will rotate forwards and backwards depending on power received.  
It can be rotated left and right by sending a number signal to the steering input.  
It can also be locked into place by sending an on signal to the brake input.

価格 250$、サイズ（WxDxH）6x7x7（幅３マスの車輪と3x3x4Ｌ字サスペンション軸で構成された車輪、設置面は軸部３マスのみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:60 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |
| ◆ Variable brake（可変ブレーキ） | 0～1 可変ブレーキの強さの設定値 |
| ◆ Steering（操舵） | -1～1 車輪の目標角度の設定値(0が中央) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 車輪駆動用の動力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Tyre Tread（タイヤ種類） | All Round / Hgih Speed / Hgih Grip | タイヤの種類を設定 |
| Stiffness（剛性） | 1～100％(デフォルト値40) | サスペンションの硬さを設定 |
| Damping（制動） | 1～100％(デフォルト値11) | サスペンションの張りを設定 |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |
| Tyre Radius（タイヤ半径） | 0.00～1.00 | タイヤ半径を設定 |
| Tyre Pressure（タイヤ圧） | 1～100％ | タイヤ空気圧を設定 |

## WHEEL 9X9

車輪９ｘ９：動力接続とブレーキ機能を備えたＸラージの操縦可能なホイール。  
ホイールは、受け取った電力に応じて前後に回転します。  
ステアリング入力に番号信号を送信することにより、左右に回転させることができます。  
また、ブレーキ入力にオン信号を送信することにより、所定の位置にロックすることもできます。

英語原文

XLarge steerable wheel with power connection and braking.  
The wheel will rotate forwards and backwards Depending on power received.  
It can be rotated left and right by sending a number signal to the steering input.  
It can also be locked into place by sending an on signal to the brake input.

価格 $250、サイズ（WxDxH）5x9x9（幅４マスの車輪と1x1x1の軸で構成された車輪、設置面は軸部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:80 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |
| ◆ Variable brake（可変ブレーキ） | 0～1 可変ブレーキの強さの設定値 |
| ◆ Steering（操舵） | -1～1 車輪の目標角度の設定値(0が中央) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 車輪駆動用の動力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Tyre Tread（タイヤ種類） | All Round / Hgih Speed / Hgih Grip | タイヤの種類を設定 |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |
| Tyre Radius（タイヤ半径） | 0.00～1.00 | タイヤ半径を設定 |
| Tyre Pressure（タイヤ圧） | 1～100％ | タイヤ空気圧を設定 |

## WHEEL 9X9 (SUSPENSION)

車輪９ｘ９(サスペンション)：サスペンション、動力接続、ブレーキ機能を備えたＸラージの操縦可能なホイール。  
ホイールは、受け取った電力に応じて前後に回転します。  
ステアリング入力に番号信号を送信することにより、左右に回転させることができます。  
また、ブレーキ入力にオン信号を送信することにより、所定の位置にロックすることもできます。

英語原文

XLarge steerable wheel with suspension, power connection and braking.  
The wheel will rotate forwards and backwards depending on power received.  
It can be rotated left and right by sending a number signal to the steering input.  
It can also be locked into place by sending an on signal to the brake input.

価格 $300、サイズ（WxDxH）8x9x9（幅４マスの車輪と4x3x5Ｌ字サスペンション軸で構成された車輪、設置面は軸部3x2マスのみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:120 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |
| ◆ Variable brake（可変ブレーキ） | 0～1 可変ブレーキの強さの設定値 |
| ◆ Steering（操舵） | -1～1 車輪の目標角度の設定値(0が中央) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Power（動力） | 車輪駆動用の動力 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Tyre Tread（タイヤ種類） | All Round / Hgih Speed / Hgih Grip | タイヤの種類を設定 |
| Stiffness（剛性） | 1～100％(デフォルト値40) | サスペンションの硬さを設定 |
| Damping（制動） | 1～100％(デフォルト値11) | サスペンションの張りを設定 |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |
| Tyre Radius（タイヤ半径） | 0.00～1.00 | タイヤ半径を設定 |
| Tyre Pressure（タイヤ圧） | 1～100％ | タイヤ空気圧を設定 |

## WHEEL COASTER

ホイールコースター：エンジン出力を必要とせず、自由に回転するシンプルな小型ホイール。  
このホイールの正逆回転を制御することはできませんが、ブレーキ入力にオン信号を送信することにより、ホイールを所定の位置にロックできます。

英語原文

Simple small wheel that requires no engine power and spins freely.  
You cannot control the forward and backward rotation of this wheel, but it can be locked into place by sending an on signal to the brake input.

※無動力のシンプルな車輪です。ブレーキのみが付いています。可変ブレーキは入力値で強さを調節できます。  
価格 $25、サイズ（WxDxH）3x3x3（中央フレームに車輪が二つ付いた形状、設置面は１マスのみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:4 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Brake（ブレーキ） | オンで車輪を固定する |
| ◆ Variable brake（可変ブレーキ） | 0～1 可変ブレーキの強さの設定値 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Grip（摩擦） | 1～100％ | 車輪の滑り難さを設定 |

## WING FRONT SECTION (SMALL)

前面部翼(小型)：翼の前面は、その表面の平らな面に対する動きに抵抗しながら、空気を通り抜けます。  
翼セクションも揚力を提供します。翼表面は揚力を提供し、空気を通り抜けます。

英語原文

The wing front surface cuts through the air while resisting movement against the flat plane of its surface.  
the aerofoil section also provides lift. wing surface to provide lift and cut through the air.

※翼面に対して水や空気、風の影響を受ける軽量なパーツ。翼の前面に使用するような形状。  
価格 $100、サイズ（WxDxH）7x3x1（前方の曲面には設置出来ない）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:5 |

|  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- |
| [20190327001219_1.jpg](https://cdn.wikiwiki.jp/to/w/sbarjp/VEHICLE%20CONTROL/::attach/20190327001219_1.jpg?rev=356dbac5f1269232ce0918d89e3043e0&t=20190327002300 "20190327001219_1.jpg") | 名称 | 全長 | 横幅 | 高さ | 重量 |
| WING SECTION (XXLARGE) | 28 | 7 | 3 | 50 |
| WING SECTION (XLARGE) | 22 | 7 | 3 | 30 |
| WING SECTION (LARGE) | 16 | 7 | 3 | 20 |
| WING SECTION (MEDIUM) | 10 | 3 | 2 | 15 |
| WING SECTION (SMALL) | 6 | 3 | 2 | 8 |
| WING FRONT SECTION (SMALL) | 3 | 7 | 1 | 5 |

※上下逆でもバックでも飛ぶ。性質については要検証

## WING SECTION (LARGE)

翼部(大型)：翼の表面は、その平面の平面に対する動きに抵抗しながら、空気を通り抜けます。  
翼セクションも揚力を提供します。  
翼表面は揚力を提供し、空気を通り抜けます。

英語原文

The wing surface cuts through the air while resisting movement against the flat plane of its surface.  
the aerofoil section also provides lift.  
Wing surface to provide lift and cut through the air.

※翼面に対して水や空気、風の影響を受ける軽量なパーツ。翼の前面に使用するような形状。  
価格 $500、サイズ（WxDxH）7x16x3（前方および後方の傾斜面には設置出来ない）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:20 |

## WING SECTION (MEDIUM)

翼部(中型)：翼の表面は、その平面の平面に対する動きに抵抗しながら、空気を通り抜けます。  
翼セクションも揚力を提供します。  
翼表面は揚力を提供し、空気を通り抜けます。

英語原文

The wing surface cuts through the air while resisting movement against the flat plane of its surface.  
the aerofoil section also provides lift.  
Wing surface to provide lift and cut through the air.

※翼面に対して水や空気、風の影響を受ける軽量なパーツ。翼断面のような形状。  
価格 $350、サイズ（WxDxH）3x10x2（前方の曲面および後方の傾斜面には設置出来ない）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:15 |

## WING SECTION (SMALL)

翼部(小型)：翼の表面は、その平面の平面に対する動きに抵抗しながら、空気を通り抜けます。  
翼セクションも揚力を提供します。  
翼表面は揚力を提供し、空気を通り抜けます。

英語原文

The wing surface cuts through the air while resisting movement against the flat plane of its surface.  
The aerofoil section also provides lift.  
Wing surface to provide lift and cut through the air.

※翼面に対して水や空気、風の影響を受ける軽量なパーツ。翼断面のような形状。  
価格 $150、サイズ（WxDxH）3x6x2（前方の曲面および後方の傾斜面には設置出来ない）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:8 |

## WING SECTION (XLARGE)

翼部(Xラージ)：翼の表面は、その平面の平面に対する動きに抵抗しながら、空気を通り抜けます。  
翼セクションも揚力を提供します。  
翼表面は揚力を提供し、空気を通り抜けます。

英語原文

The wing surface cuts through the air while resisting movement against the flat plane of its surface.  
The aerofoil section also provides lift.  
Wing surface to provide lift and cut through the air.

※翼面に対して水や空気、風の影響を受ける軽量なパーツ。翼断面のような形状。  
価格 $800、サイズ（WxDxH）7x22x3（前方および後方の傾斜面には設置出来ない）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:30 |

## WING SECTION (XXLARGE)

翼部(X Xラージ)：翼の表面は、その平面の平面に対する動きに抵抗しながら、空気を通り抜けます。  
翼セクションも揚力を提供します。  
翼表面は揚力を提供し、空気を通り抜けます。

英語原文

The wing surface cuts through the air while resisting movement against the flat plane of its surface.  
The aerofoil section also provides lift.  
Wing surface to provide lift and cut through the air.

※翼面に対して水や空気、風の影響を受ける軽量なパーツ。翼断面のような形状。  
価格 $1500、サイズ（WxDxH）7x28x3（前方および後方の傾斜面には設置出来ない）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:50 |
