---
wiki: sbarjp
page: DISPLAYS
source_url: https://wikiwiki.jp/sbarjp/DISPLAYS
last_modified: 2025-01-18
retrieved_at: 2026-08-31T02:35:30+0800
---

# DISPLAYS

|  |  |  |
| --- | --- | --- |
| - [ARTIFICIAL HORIZON](#zac4613b) - [BUZZER](#l4369eea) - [COMPASS BALL](#sffee118) - [DIAL](#w8c64c6e) - [DIGITAL DISPLAY](#b3495bcb) - [FOGHORN](#u3095d4c) - [GAUGE DISPLAY](#m8316de9) - [HUD LARGE](#m0fd3779) - [HUD SMALL](#m7b5f5c7) - [INDICATOR LIGHT](#r7a675e3) - [INDICATOR LIGHT (RGB)](#yb23e54d) - [INSTRUMENT PANEL](#dec5512c) - [LASER BEACON](#xdb1397e) - [MEGAPHONE SPEAKER (LARGE)](#r4d3af74) - [MEGAPHONE SPEAKER (SMALL)](#w2b971c6) - [MONITOR 1X1](#h6b4b798) - [MONITOR 1X2](#pa6c38b5) - [MONITOR 1X3](#vba2e624) - [MONITOR 2X2](#lf85c99f) - [MONITOR 2X3](#qf9a727e) - [MONITOR 3X3](#a44f4c96) - [MONITOR 5X3](#ea7c679f) - [MONITOR 9X5](#i755e11a) - [PAINTABLE INDICATOR](#r62c7b3d) - [PAINTABLE SIGN](#w5acaaac) - [SPEAKER (SMALL)](#p39103dc) - [VIEWING SCOPE](#q851b133) |  | [Displays.png](https://cdn.wikiwiki.jp/to/w/sbarjp/DISPLAYS/::attach/Displays.png?rev=ec9a78624a0a73074f7eeb41eb92ec00&t=20240515155555 "Displays.png") |

## ARTIFICIAL HORIZON

人工水平器：アーティフィシャルホライゾンは、地平線に対してあなたの乗り物の向きを示します。  
ホライゾンボールはあなたの乗り物のピッチが変化すると上下に回転し、中心線はあなたの乗り物のロールを示します。  
これは、夜間や濃い霧の中で飛ぶのを容易にするためにあなたのヘリコプターなどへ搭載すると便利なコンポーネントです。  
オン／オフ信号を用いてバックライトを切り替えることができます。

英語原文

The artificial horizon shows you the orientation of your vehicle with respect to the horizon line.  
The horizon ball rotates up and down as your vehicle's pitch changes, and the central line gives an indication of your vehicle's roll.  
This is a useful component to have in your helicopter to make it easier to fly at night and in thick fog.  
An on/off signal can be used to toggle the backlight.

※乗り物の傾きを表示する機器  
価格 20$、サイズ（WxDxH）1x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Backlight（バックライト） | On/Off |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | バックライト用電源 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称を記入 | カーソルを合わせた際に表示される名称 |

## BUZZER

ブザー：オフからオンに切り替えたときに選択されたサウンドを再生するブザー。  
選択ツールでこのコンポーネントを選択することで、音の種類、音量、およびピッチをカスタマイズできます。  
可聴範囲は30メートルです。

英語原文

A buzzer that will play a selected sound when toggled from off to on.  
The type of sound, volume, and pitch can be customised by selecting this component with the select tool.  
It has an audible range of 30m.

※ドアの開閉信号を入力して開閉時に音を鳴らすなどの使い方がある。  
価格 100$、サイズ（WxDxH）1x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Buzzer（ブザー） | オフからオンになった際、選択された音を再生する |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電源 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Sound Type（音の種類） | (Warning 1/Warning 2/Warning 3/Beep 1/Beep 2/Seatbelt) | ６種類 |
| Volume（音量） | 0～100％ |  |
| Pitch（音の高さ） | 50～200％(デフォルト値100％) |  |
| Preview（テスト再生） | 再生ボタン | 選択した設定内容で再生する |

## COMPASS BALL

方位磁針：コンパスは地図上で北を指すように回転します。  
これは、視界が悪い状況でナビゲーションを支援するために使用できるツールの1つです。  
オン/オフ信号は、コンパスのバックライトを有効にするかどうかを制御します。

英語原文

The compass rotates to point to north on the map.  
It is one of several tools that can be used to aid navigation in low visibility situations.  
An on/off signal controls whether or not the compass' backlight is enabled.

※補足内容の追記（画像など）  
価格 20$、サイズ（WxDxH）1x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Backlight（バックライト） | On/Off |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | バックライト用電源 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称を記入 | カーソルを合わせた際に表示される名称 |

## DIAL

指針表示盤：数値を表示するための回転針付きダイヤル。  
ダイヤルの文字盤は、デフォルトで-1から1までの範囲の値を表します。  
これは選択ツールで選択することで設定できます。  
この範囲外の値を設定すると、針が折り返されますが、必要に応じて追加の論理コンポーネントを使用して収まるように拡大縮小できます。  
オン／オフ信号を用いてバックライトを切り替えることができます。。

英語原文

A dial with a rotating needle for displaying numerical values.  
The Dial's face represents values ranging from -1 to 1 by default.  
This can be configured by selecting it with the select tool.  
Values out side this range will cause the needle to wrap around, but can be scaled to fit using additional logic components if necessary.  
An on/off signal can be used to toggle the backlight.

※タンク容量などの数値を設定すれば残量を視覚的に把握できるので便利（例：ミディアムタンクなら0～187.5に設定するなど）  
※表示部のメモリは８等分。  
※注：名称を入力しない場合、座席に座った状態で数値の詳細を確認する事が出来ません。  
価格 20$、サイズ（WxDxH）1x2x1（見た目は１ブロック、表示部の前に１ブロックの空間がある）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Value to Display（表示する値） | 表示する数値は任意に設定可能 |
| ◆ Backlight（バックライト） | On/Off |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | バックライト用電源 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称を記入 | カーソルを合わせた際に表示される名称 |
| Min Value（最小値） | 数値を設定 | 表示部のメモリの下限に相当する数値 |
| Max Value（最大値） | 数値を設定 | 表示部のメモリの上限に相当する数値 |

## DIGITAL DISPLAY

デジタル表示盤：5桁（小数点を不使用の6桁）符号付き数値をオプションの小数点付きで表示します。  
小数点の位置は、選択ツールを使用してこのコンポーネントを選択することによって構成できます。これにより、出力内の小数点以下の桁数を制御できます。

英語原文

Displays a 5 digit (6 with decimal point disabled) signed numerical value with optional decimal point.  
The position of the decimal point can be configured by selecting this component with the select tool, allowing you to control the number of decimal places in the output.

※±表示のある、小数点位置を設定可能な５桁の７セグディスプレイ  
※注：名称を入力しない場合、座席に座った状態で数値の詳細を確認する事が出来ません。  
価格 20$、サイズ（WxDxH）2x1x1（２マス分の表示部がある）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Value to Display（表示する値） | 表示する数値は任意に設定可能 |
| ◆ Backlight（バックライト） | On/Off |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | バックライト用電源 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称を記入 | カーソルを合わせた際に表示される名称 |
| Decimal Point Position（小数点位置） | 0.0000～0000.0 / DecimalsDisabled(小数点無しの６桁表示) | 小数点の位置を選択する |

## FOGHORN

霧笛(むてき)：ＯＮシグナルを受信したときに鳴る船の霧笛。  
可聴範囲は500メートルです。

英語原文

A ship's foghorm that will sound when receiving an on signal.  
It has an audible range of 500m.

※霧が濃い時に、船や灯台が鳴らし周囲へ注意を促す汽笛  
価格 200$、サイズ（WxDxH）3x4x3（設置は一面のみ、本体部分は高さ２マス）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Horn（警笛） | オンの時、警笛を鳴らす |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電源 |

## GAUGE DISPLAY

計器表示盤：独立して配置できる2本の針を持つディスプレイ。  
(プライマリ)一次針は白、(セカンダリ)二次針は赤です。  
針の位置は、デフォルトでは-1から1の範囲の値を表します。  
この範囲は選択ツールで表示を選択することで設定できます。

英語原文

A display with two needles that can be positioned independently.  
The primary needle is white and the secondary needle is red.  
The positions of the needles represent values ranging from -1 to 1 by default.  
This range can be configured by selecting the display with the select tool.

※二つの針が重なった時は、白い針が上に表示される。  
※設定値の上下限に針が来ると若干見辛いので上下に余裕のある数値、例えば0～1までを使用する場合-0.166～1.166に設定すると見やすいのでお勧め。  
※表示部のメモリは８等分。  
※注：名称を入力しない場合、座席に座った状態で数値の詳細を確認する事が出来ません。  
価格 20$、サイズ（WxDxH）1x2x2（縦長２マスの表示部があり、手前に２ブロックの空間がある）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Primary Display Value（一次側表示値） | 白い針の位置を設定する数値 |
| ◆ Secondary Display Value（二次側表示値） | 赤い針の位置を設定する数値 |
| ◆ Backlight（バックライト） | On/Off |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | バックライト用電源 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称を記入 | カーソルを合わせた際に表示される名称 |
| Min Value（最小値） | 数値を設定 | 表示部のメモリの下限に相当する数値 |
| Max Value（最大値） | 数値を設定 | 表示部のメモリの上限に相当する数値 |

## HUD LARGE

大型ヘッドアップディスプレイ：投影式の透明なディスプレイ。映像データを表示します。

英語原文

A clear projection heads up display screen. Displays video data.

※カメラからの映像やＬｕａで作成したプログラム(マップ)などを表示します。  
※電力低下で表示が薄くなる。  
※ドットサイズ：(幅x高) 96x96 Pixel  
価格 10000$、サイズ（WxDxH）3x1x3（設置は下部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:18 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Video Signal（映像信号） | 映像信号の入力 |
| ◆ Power Switch（電源スイッチ） | ディスプレイ電源のOn/Off |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Touch Output（タッチ出力） | タッチした座標の出力(ゲーム内でこのノードに関する説明がありません) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電源 |

タッチした座標のコンポジット出力内容

|  |  |
| --- | --- |
| ・Number channel 1 | 画面の幅 |
| ・Number channel 2 | 画面の高さ |
| ・Number channel 3 | ひとつ目にタッチした画面上のX座標 |
| ・Number channel 4 | ひとつ目にタッチした画面上のY座標 |
| ・Number channel 5 | ふたつ目にタッチした画面上のX座標 |
| ・Number channel 6 | ふたつ目にタッチした画面上のY座標 |
| ・On/Off channel 1 | ひとつ目がタッチされているか(ONでタッチ中) |
| ・On/Off channel 2 | ふたつ目がタッチされているか(ONでタッチ中) |

画面のタッチは[e]と[q]どちらのキーでも可能だが、どちらかのキーでタッチ中にもう一方のキーでタッチするとふたつ目の入力が使われる。  
またタッチした位置はタッチ時点で固定され、スライドすることはできない。

## HUD SMALL

小型ヘッドアップディスプレイ：投影式の透明なディスプレイ。映像データを表示します。

英語原文

A clear projection heads up display screen. Displays video data.

※カメラからの映像やＬｕａで作成したプログラム(マップ)などを表示します。  
※電力低下で表示が薄くなる。  
※ドットサイズ：(幅x高) 32x32 Pixel  
価格 2000$、サイズ（WxDxH）1x1x1（設置は下部のみ）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Video Signal（映像信号） | 映像信号の入力 |
| ◆ Power Switch（電源スイッチ） | ディスプレイ電源のOn/Off |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Touch Output（タッチ出力） | タッチした座標の出力(ゲーム内でこのノードに関する説明がありません) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電源 |

※コンポジットの内容は HUD LARGE を参照

## INDICATOR LIGHT

表示灯：論理システムの指標として使用できる単純な照明。

英語原文

A simple light that can be used as an indicator in logic systems.

※周辺を照らすことはできません。  
価格 20$、サイズ（WxDxH）1x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Indicator Light（表示灯） | On/Off |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 点灯用電源 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称を記入 | カーソルを合わせた際に表示される名称 |

## INDICATOR LIGHT (RGB)

表示灯(赤緑青)：マイクロコントローラを使用して制御できる高度なインジケータ。  
コンポジット入力の3つのチャンネルを使用して、0から1までの数字を使用してインディケータの色の赤、緑、青の成分を設定できます。  
ライトはHSVモードでも動作します。3つの入力は、色相、彩度、0から1の間の色の値（明るさ）に対応します。  
カラーモードと入力チャンネルは、選択ツールでこのコンポーネントを選択することでカスタマイズできます。

英語原文

An advanced indicator that can be controlled using a microcontroller.  
Three channels of the composite input can be used to set the red, greem and blue components of the indicator's color using numbers between 0 and 1.  
The light can also operate in HSV mode, where the 3 inputs correspond to the hue, saturation and value (brightness) of the color between 0 and 1.  
The color mode and input channels can be customised by selecting this component with the select tool.

※補足内容の追記（画像など）  
価格 50$、サイズ（WxDxH）1x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Color Data（色情報） | コンポジット入力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 点灯用電源 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称を記入 | カーソルを合わせた際に表示される名称 |
| Color Mode(色設定) | RGB / HSV | 赤緑青または色彩明度 |
| COMPOSITE CHANNELS | | |
| Red/Hue(赤/色相) | チャンネル設定 1～32 | |
| Greem/Sat(緑/彩度) | チャンネル設定 1～32 | |
| Blue/Val(青/明度) | チャンネル設定 1～32 | |

## INSTRUMENT PANEL

計器板：マイクロコントローラからのコンポジット信号によって制御される最大4つの異なる機器を持つことができるカスタマイズ可能なパネル。  
4つの機器はプロパティウィンドウで選択できます。  
機器の種類ごとに、読み書きするコンポジットチャンネルを選択できます。  
コンポジット信号は入力ノードから出力ノードにブリッジされ、ディスプレイを互いにチェーニングすることができます。  
「（オン／オフ）」とマークされた機器は、それらの各セグメントを個別に制御するために複数のオン／オフ信号を必要とする。

英語原文

A customisable panel that can have up to 4 different instruments, contorolled by a composite signal from a microcontroller.  
The 4 instruments can be selected in the properties window.  
Each type of instrument has options for choosing the composite channels that they read from or write to.  
Composite signals are bridged from the input node to the output node to enable displays to be chained together.  
Instruments marked as "(On/Off)" require multiple on/off signals tocontrol each of their segments individually.

価格 200$、サイズ（WxDxH）1x2x1（見た目は１ブロック、表示部の前に１ブロックの空間がある）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Signal In（信号入力） | コンポジット入力 |
| ◆ Backlight（バックライト） | On/Off |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Signal Out（信号出力） | コンポジット出力 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | バックライト用電源 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Instrument 1（機器１） | プルダウン設定 | 左上表示機器の設定、詳細は下記 |
| Instrument 2（機器２） | プルダウン設定 | 右上表示機器の設定、詳細は下記 |
| Instrument 3（機器３） | プルダウン設定 | 左下表示機器の設定、詳細は下記 |
| Instrument 4（機器４） | プルダウン設定 | 右下表示機器の設定、詳細は下記 |

セレクト選択設定項目の詳細

[![rapture_20200114172814.jpg](https://cdn.wikiwiki.jp/to/w/sbarjp/DISPLAYS/::ref/rapture_20200114172814.jpg?rev=ea7569b6778258493727cdc6044364bf&t=20200114172908 "rapture_20200114172814.jpg")](https://cdn.wikiwiki.jp/to/w/sbarjp/DISPLAYS/::attach/rapture_20200114172814.jpg?rev=ea7569b6778258493727cdc6044364bf&t=20200114172908 "rapture_20200114172814.jpg")  
選択できるパネル

- なし
  - 何も表示されません。（パネルの一番右上と一番左上が「なし」を選択した状態）
- ダイヤル
  - バックライトのON/OFF入力に対応。
- インジケータ
- ゲージ
  - バックライトのON/OFF入力に対応。  
    単体のゲージと異なり、主入力値1個のみの表示。
- ボタン
  - トグル動作とプッシュ動作を選べる。  
    単体のトグルボタンやプッシュボタンと異なり、外部入力はできない。
- 矢印ボタン
  - トグル動作とプッシュ動作を選べる。  
    単体のトグルボタンやプッシュボタンと異なり、外部入力はできない。
- フリップスイッチ
  - トグル動作のみ。  
    見た目が似ている単体の電気遮断器と異なり、トグルボタンと同様のON/OFF出力しかできない。
- 7セグメント
  - バックライトのON/OFF入力に対応するか、常時点灯かを選べる。  
    常時点灯ではない場合、バックライト入力がONでなければ何も表示されない。
  - 数値入力とON/OFF入力が選択できる。  
    数値入力の時は、0.0～9.0の値に対応して表示され、負の値の時は「-」(真ん中の横棒のみ)の表示になる。  
    ON/OFF入力の時は7つのセグメントそれぞれの点灯消灯を個別に操作できる。そのためON/OFF入力値が7個必要で、コンポジットのON/OFFチャンネルを7個連続で占有する。  
    上の横棒が最初のチャンネルに対応し、そこから時計回りに6番目のチャンネルまで、真ん中の横棒が7番目のチャンネルで制御される。
- 放射状セグメント
- バーセグメント
  - 数値入力とON/OFF入力が選択できる。  
    数値入力の時は、入力値を整数に、そして二進法に変換した値を表示する。ただし、整数への丸めは不定なときがあるようなので、小数点付きの値の入力は避けた方がよいだろう。  
    たとえば5.67を入力すると、整数の6に丸められた上で二進数の00000110に対応するセグメントが点灯する。  
    負の数値にも対応し、-0.87は-1に丸められた上で11111111すなわち全てが点灯する。  
    ON/OFF入力の時は、8つのセグメントそれぞれの点灯消灯を個別に操作できる。そのためON/OFF入力値が8個必要で、コンポジットのON/OFFチャンネルを8個連続で占有する。  
    Up配置の時なら最も下のセグメントが最初のチャンネルに対応し、順次上へ8番目のチャンネルまでを使って制御される。

## LASER BEACON

レーザービーコン：レーザーの照射点と同様の発光をするライト。[レーザーポイントセンサー](/sbarjp/SENSORS#o7c04ec2 "SENSORS")や[スタビライズドカメラ](/sbarjp/SENSORS#c689743c "SENSORS")で検出できます。

英語原文

A beacon that produces a laser point light, visible by laser point sensors.

価格 5$、サイズ（WxDxH）1x1x2（ライトと同じ形状）

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Beacon Light（ビーコン灯） | On/Off |
| ◆ Wavelength（波長） | 発光の波長(整数) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 点灯用電源 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Infrared（赤外線） | チェックボックス | チェックを入れると赤外線発光になる(肉眼で見えない) |

※Wavelengthはアンテナの周波数と同じ役割で[レーザーポイントセンサー](/sbarjp/SENSORS#o7c04ec2 "SENSORS")などの受信周波数と合わせることで、周波数を合わせたレーザーポイントセンサーがこのビーコンの光を検知できます。

## MEGAPHONE SPEAKER (LARGE)

メガホンスピーカー(大)：範囲内のプレーヤーに音声データを再生できるスピーカー。  
範囲内のプレーヤーに音声データを再生できる大型メガホン。(範囲：1000)

英語原文

A speaker capable of playing audio data to players within its range.  
A large megaphone capable of playing audio data to players within its range. (Range : 1000)

※[SENSORS](/sbarjp/SENSORS "SENSORS")から分類が変更されました。  
※マイクの特性上、プレイヤーや環境音のみが録音されるためブザーの音などを送り  
モールス信号の代わりとして使用することはできません。

価格 $1000、サイズ(WxDxH)3x5x3(ラッパ型、取付面積は1x1)

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 10 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Audio(音声) | オーディオデータの入力 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Is transmit(送信中) | On/Off(スピーカーが現在送信中の場合信号を出力) |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) |  |

## MEGAPHONE SPEAKER (SMALL)

メガホンスピーカー(小)：範囲内のプレーヤーに音声データを再生できるスピーカー。  
範囲内のプレーヤーに音声データを再生できる小型メガホン。(範囲：300)

英語原文

A speaker capable of playing audio data to players within its range.  
A small megaphone capable of playing audio data to players within its range. (Range : 300)

※[SENSORS](/sbarjp/SENSORS "SENSORS")から分類が変更されました。  
※マイクの特性上、プレイヤーや環境音のみが録音されるため、ブザーの音などを送り  
モールス信号の代わりとして使用することはできません。

価格 $500、サイズ(WxDxH)1x2x1(ラッパ型、取付は２面)

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 3 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Audio(音声) | オーディオデータの入力 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Is transmit(送信中) | On/Off(スピーカーが現在送信中の場合信号を出力) |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) |  |

## MONITOR 1X1

モニター1x1：ビデオモニター。映像データを表示します。

英語原文

A video screen. Displays video data.

※カメラからの映像やＬｕａで作成したプログラム(マップ)などを表示します。  
※電力低下で表示が薄くなる。  
※ドットサイズ：(幅x高) 32x32 Pixel  
価格 500$、サイズ（WxDxH）1x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:4 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Video Signal（映像信号） | 映像信号の入力 |
| ◆ Power Switch（電源スイッチ） | ディスプレイ電源のOn/Off |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Touch Output（タッチ出力） | タッチした座標の出力(ゲーム内でこのノードに関する説明がありません) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電源 |

※コンポジットの内容は HUD LARGE を参照

## MONITOR 1X2

モニター1x2：ビデオモニター。映像データを表示します。

英語原文

A video screen. Displays video data.

※カメラからの映像やＬｕａで作成したプログラム(マップ)などを表示します。  
※電力低下で表示が薄くなる。  
※ドットサイズ：(幅x高) 64x32 Pixel  
価格 1000$、サイズ（WxDxH）2x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:8 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Video Signal（映像信号） | 映像信号の入力 |
| ◆ Power Switch（電源スイッチ） | ディスプレイ電源のOn/Off |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Touch Output（タッチ出力） | タッチした座標の出力(ゲーム内でこのノードに関する説明がありません) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電源 |

※コンポジットの内容は HUD LARGE を参照

## MONITOR 1X3

モニター1x3：ビデオモニター。映像データを表示します。

英語原文

A video screen. Displays video data.

※カメラからの映像やＬｕａで作成したプログラム(マップ)などを表示します。  
※電力低下で表示が薄くなる。  
※ドットサイズ：(幅x高) 96x32 Pixel  
価格 1500$、サイズ（WxDxH）3x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:12 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Video Signal（映像信号） | 映像信号の入力 |
| ◆ Power Switch（電源スイッチ） | ディスプレイ電源のOn/Off |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Touch Output（タッチ出力） | タッチした座標の出力(ゲーム内でこのノードに関する説明がありません) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電源 |

※コンポジットの内容は HUD LARGE を参照

## MONITOR 2X2

モニター2x2：ビデオモニター。映像データを表示します。

英語原文

A video screen. Displays video data.

※カメラからの映像やＬｕａで作成したプログラム(マップ)などを表示します。  
※電力低下で表示が薄くなる。  
※ドットサイズ：(幅x高) 64x64 Pixel  
価格 2000$、サイズ（WxDxH）2x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:16 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Video Signal（映像信号） | 映像信号の入力 |
| ◆ Power Switch（電源スイッチ） | ディスプレイ電源のOn/Off |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Touch Output（タッチ出力） | タッチした座標の出力(ゲーム内でこのノードに関する説明がありません) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電源 |

※コンポジットの内容は HUD LARGE を参照

## MONITOR 2X3

モニター2x3：ビデオモニター。映像データを表示します。

英語原文

A video screen. Displays video data.

※カメラからの映像やＬｕａで作成したプログラム(マップ)などを表示します。  
※電力低下で表示が薄くなる。  
※ドットサイズ：(幅x高) 96x64 Pixel  
価格 3000$、サイズ（WxDxH）3x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:24 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Video Signal（映像信号） | 映像信号の入力 |
| ◆ Power Switch（電源スイッチ） | ディスプレイ電源のOn/Off |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Touch Output（タッチ出力） | タッチした座標の出力(ゲーム内でこのノードに関する説明がありません) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電源 |

※コンポジットの内容は HUD LARGE を参照

## MONITOR 3X3

モニター3x3：ビデオモニター。映像データを表示します。

英語原文

A video screen. Displays video data.

※カメラからの映像やＬｕａで作成したプログラム(マップ)などを表示します。  
※電力低下で表示が薄くなる。  
※ドットサイズ：(幅x高) 96x96 Pixel  
価格 4500$、サイズ（WxDxH）3x1x3

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:36 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Video Signal（映像信号） | 映像信号の入力 |
| ◆ Power Switch（電源スイッチ） | ディスプレイ電源のOn/Off |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Touch Output（タッチ出力） | タッチした座標の出力(ゲーム内でこのノードに関する説明がありません) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電源 |

※コンポジットの内容は HUD LARGE を参照

## MONITOR 5X3

モニター5X3：ビデオモニター。映像データを表示します。

英語原文

A video screen. Displays video data.

※カメラからの映像やＬｕａで作成したプログラム(マップ)などを表示します。  
※電力低下で表示が薄くなる。  
※ドットサイズ：(幅x高) 160x96 Pixel（ワイド画面）  
価格 7500$、サイズ（WxDxH）5x1x3

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:60 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Video Signal（映像信号） | 映像信号の入力 |
| ◆ Power Switch（電源スイッチ） | ディスプレイ電源のOn/Off |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Touch Output（タッチ出力） | タッチした座標の出力(ゲーム内でこのノードに関する説明がありません) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電源 |

※コンポジットの内容は HUD LARGE を参照

## MONITOR 9X5

モニター9X5：ビデオモニター。映像データを表示します。

英語原文

A video screen. Displays video data.

※カメラからの映像やＬｕａで作成したプログラム(マップ)などを表示します。  
※電力低下で表示が薄くなる。  
※ドットサイズ：(幅x高) 288x160 Pixel（ワイド画面）  
価格 20000$、サイズ（WxDxH）9x1x5

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:180 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Video Signal（映像信号） | 映像信号の入力 |
| ◆ Power Switch（電源スイッチ） | ディスプレイ電源のOn/Off |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Touch Output（タッチ出力） | タッチした座標の出力(ゲーム内でこのノードに関する説明がありません) |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | 動作用電源 |

※コンポジットの内容は HUD LARGE を参照

## PAINTABLE INDICATOR

塗装表示：塗装詳細を表示するためのバックライト付きインジケーター。  
このブロックには小さなグリッドの正方形を個別に描くことができる塗装可能な面があります。  
バックライトグリッドを描画するために加法的描画モードを使用します。  
バックライトはオン信号を使用して有効にすることができ、名前はプレーヤーがインジケーターを見たときに表示される選択ツールで設定できます。

加法的描画モード変更方法

[![AdditiveMode.png](https://cdn.wikiwiki.jp/to/w/sbarjp/DISPLAYS/::ref/AdditiveMode.png.webp?rev=42f791200ac8aace566e5c75e3688f02&t=20200524081058 "AdditiveMode.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/DISPLAYS/::attach/AdditiveMode.png?rev=42f791200ac8aace566e5c75e3688f02&t=20200524081058 "AdditiveMode.png")

英語原文

A backlit indicator for displaying painted detail.  
This block has a paintable surface where small grid squares can be painted invidually.  
Use additive painting mode to paint the backlight grid.  
the backlight can be enabled by using an on signal and a name can be set with the select tool that will be visible when the indicator is looked at by a player.

※塗装面のサイズは９ｘ９ドット  
※塗装反転ツール(?)（左から3番目）を使用するとそのブロック内の塗装されている同じ色の塗装が全て指定した色に置き換わります。  
価格 -$、サイズ（WxDxH）1x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:2 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Backlight（バックライト） | On/Off |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） | バックライト用電源 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name（表示名称） | 名称を記入 | カーソルを合わせた際に表示される名称 |

## PAINTABLE SIGN

塗装標識：塗装の詳細を表示するためのサインブロック。  
このブロックは小さなグリッドの正方形が個別に塗られることができる塗装可能な表面を持っています。

英語原文

Sign block for Displaying painted detail.  
This block has a paintable surface where small grid squares can be painted individually.

※塗装面のサイズは９ｘ９ドット  
価格 -$、サイズ（WxDxH）1x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:1 |

## SPEAKER (SMALL)

スピーカー(小)：範囲内のプレーヤーに音声データを再生できるスピーカー。  
近くのプレーヤーに音声データを再生できる小さなスピーカー。(範囲：15)

英語原文

A speaker capable of playing audio data to players within its range.  
A small speaker capable of playing audio data to nearby players. (Range : 15)

※[SENSORS](/sbarjp/SENSORS "SENSORS")から分類が変更されました。  
価格 $250、サイズ(WxDxH)1x1x2

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Audio(音声) | オーディオデータの入力 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Is transmit(送信中) | On/Off(スピーカーが現在送信中の場合信号を出力) |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) |  |

## VIEWING SCOPE

スコープ：観測スコープ。  
インタラクトすることで、ビデオデータを詳細に表示します。

英語原文

A viewing scope.  
Interact to display video data at full detail.

価格 $2000、サイズ（WxDxH）1x1x1

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Video Signal（映像信号） |  |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Occupied（使用中） | 誰かがこのスコープ使っているとオン信号を出力する |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric（電力） |  |
