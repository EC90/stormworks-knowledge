---
wiki: sbarjp
page: SENSORS
source_url: https://wikiwiki.jp/sbarjp/SENSORS
last_modified: 2025-05-10
retrieved_at: 2026-08-31T02:35:31+0800
---

# SENSORS

|  |  |  |
| --- | --- | --- |
| - [ALTIMETER](#t63e9b90) - [ANGULAR SPEED SENSOR](#d4a80bea) - [CAMERA GIMBAL](#yf1c0f6d) - [CAMERA MEDIUM](#ud3adad6) - [CAMERA SMALL](#k3dc5c8a) - [CAMERA STABILIZED](#c689743c) - [CLOCK](#u8a7dcac)    - [時間と分を得る方法:](#wf698ebb) - [COMPASS SENSOR](#b48edf9e) - [DISTANCE SENSOR](#u21e0cf4) - [EMERGENCY BEACON](#v7c8d639) - [EMERGENCY BEACON LOCATOR](#zb0dca95) - [FLUID METER](#jb5c9d4e) - [GPS SENSOR](#bcd82a56) - [HUMIDITY SENSOR](#y1fd1e03) - [LASER DISTANCE SENSOR](#x32307b8) - [LASER POINT SENSOR](#o7c04ec2) - [LASER SENSOR (MISSILE)](#f797ade9) - [LINEAR SPEED SENSOR](#ncfecfee) - [MICROPHONE](#v75a08db) - [PHYSICS SENSOR](#t279a986) - [PLAYER SENSOR](#t279a989) - [RADAR(AWACS)](#d81c4d99) - [RADAR(BASIC)](#z8360d11) - [RADAR(DISH)](#z646a642) - [RADAR(MISSILE)](#t8f2065a) - [RADAR(PHALANX)](#h74bc84f) - [（※削除済み）旧RADAR](#xb1b9929) - [（※削除済み）旧RADAR (DISH)](#zf05abec) - [（※削除済み）旧RADAR (HUGE)](#fd4b4f1a) - [（※削除済み）旧RADAR (LARGE)](#n5054f7c) - [RADAR DETECTOR](#e2a93703) - [RAIN SENSOR](#bf4028df) - [SONAR](#q6f143d7) - [TEMPERATURE PROBE](#q907a5a1) - [TILT SENSOR](#p752be15) - [WIND SENSOR](#x64e1e37) |  | [rapture_20190927101758.jpg](https://cdn.wikiwiki.jp/to/w/sbarjp/SENSORS/::attach/rapture_20190927101758.jpg?rev=2d3fef7efd103ddb669effdbc6bb28ee&t=20190927213001 "rapture_20190927101758.jpg") |

## ALTIMETER

高度計：高度センサー。海抜高度をメートル単位で出力します。  
波浪で動揺しない標準海水面からの高度を測定し、海水面から上がプラスの値を出力します。

英語原文

An altitude sensor. Outputs distance above sea-level in meters.

※類似の機能があるパーツに[液量計](#jb5c9d4e)がありますが、あちらは風による波浪で上下するリアルタイムの海水面からの深度を測定し、海水面から下がプラスの値を出力します。  
　出っ張っている部分の向きに関わらず、ブロック部分の高度を測定します。  
価格 $20、サイズ(WxDxH)1x1x2

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Altitude(高度) | 海抜高度[m] |

## ANGULAR SPEED SENSOR

角速度計：現在の角速度を1秒あたりの回転数で出力します。  
パーツの出っ張っている部分を天に向けて設置したとき、時計回りにこのパーツが回ると出力される値が正になります。

英語原文

This sensor outputs its current angular speed in rotations per second.  
allowing you to measure how fast your vehicle is rotating. This sensor outputs the component's y axis.

※パーツの左右が逆になっても常に同じ回転方向を正とした出力をします。  
　ビークル編集画面では、回転方向の正負を示す半円の青矢印が表示されますが、矢印の正負の方向を反転(u,i,oキーで鏡像反転できます)させても実際に出力される値の符号は変わりません。  
　出っ張っている部分を天に向けてビークルに設置した時は、前進中に右に転舵していると正の出力です。  
価格 $20、サイズ(WxDxH)1x1x2

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Angular speed(角速度) | 回転速度[回転/秒] |

※単位の[回転/秒]に現れる1回転は、360度のことです。

## CAMERA GIMBAL

ジンバルカメラ：ビデオ出力を備えたジンバルカメラ。  
赤外線モード、ピボット制御、ズーム機能を備えています。

英語原文

A gimbal camera with video output feed.  
Has infrared mode as well as pivot controls and variable field of view.

※ジンバルは回転台のことで、このカメラには左右旋回と俯仰の2軸の動力付きピボットが備えられています。これらの回転角度には制限があり、ぐるぐると一方向に回し続けることはできません。  
　一方向に回し続けることができる[スタビライズドカメラ](#c689743c)もあります。  
　電力低下で映像にノイズが生じ、電力が無くなると映像が砂嵐になります。  
価格 $5000、サイズ(WxDxH)3x3x3(設置は取り付け部の１マスのみ)

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | mass:50 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Infrared Mode(赤外線モード) | On/Off(赤外線・通常) |
| ◆ Field of View(視野角) | 0～1 カメラのズーム操作 |
| ◆ Rotation Pivot(左右旋回) | -1～1 ０を中心に左右に一回転する |
| ◆ Rotation Pitch(俯仰) | -1～1 ０を中心に上下に120度回転(±0.75が90度) |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Video(映像) | 映像データの出力 |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) | 動作用電源 |

## CAMERA MEDIUM

中型カメラ：ビデオ出力を備えたカメラ。  
赤外線モードとズーム機能を備えています。

英語原文

A camera with bideo output feed.  
Has infrared mode as well as variable field of view.

※電力低下で映像にノイズが生じ、電力が無くなると映像が砂嵐になる  
　視野角は、Field of View = 0のとき2.2rad、Field of View = 1のとき0.025radで、その間は線形に変化します。\*1  
価格 $3000、サイズ(WxDxH)1x2x1(カメラレンズ正面は設置面ではない)

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | mass:10 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Infrared Mode(赤外線モード) | On/Off (赤外線・通常) |
| ◆ Field of View(視野角) | 0～1 カメラのズーム操作 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Video(映像) | 映像データの出力 |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) | 動作用電源 |

## CAMERA SMALL

小型カメラ：ビデオ出力を備えたカメラ。

英語原文

A camera with bideo output feed.

※電力低下で映像にノイズが生じ、電力が無くなると映像が砂嵐になります。  
　視野角は、1.22rad固定です。  
価格 $1000、サイズ(WxDxH)1x1x1(カメラレンズ正面は設置面ではない)

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | mass:5 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Video(映像) | 映像データの出力 |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) | 動作用電源 |

## CAMERA STABILIZED

スタビライズドカメラ：スタビライザー付きのビデオ出力を備えたジンバルカメラ。  
赤外線モード、ジンバル制御、ズーム機能、安定モード、追跡モードの機能があります。

英語原文

A stabilized gimbal camera with video output feed.  
Has an infrared mode, variable field of view, stabilized and tracking modes.

※[ジンバルカメラ](#yf1c0f6d)とは違い、二つの回転軸は共に360度を超えて回転できる速度制御方式です。  
　コンポジット出力からレーザー光点の位置情報を取得できます。  
　レーザーは、自身で照射する他に[レーザー距離センサー](#x32307b8)によっても照射でき、追跡モードで利用できます。  
　また、[レーザービーコン](/sbarjp/DISPLAYS#xdb1397e "DISPLAYS")はそれ自身がレーザー光点になります。  
　電力低下で映像にノイズが生じ、電力が無くなると映像が砂嵐になります。  
価格 $50000、サイズ(WxDxH)3x3x3(設置は取り付け部の１マスのみ)

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | mass:60 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Infrared Mode(赤外線モード) | On/Off(赤外線/通常) これはカメラの赤外線モード切替です。レーザーの赤外線モードは設計中にのみ変更できます。 |
| ◆ Enable Laser(レーザー有効) | On/Off(レーザーの照射/停止) |
| ◆ Field of View(視野角) | 0～1 カメラのズーム操作 |
| ◆ Pivot Rotation(左右旋回) | 0.1～? 回転する速度 |
| ◆ Pitch Rotation(俯仰) | 0.1～? 回転する速度 |
| ◆ Stabilizer Mode(安定化モード) | On/Off 現在の方向を指向し続ける |
| ◆ Tracker Mode(追跡モード) | On/Off レーザー光点の地点をカメラが追跡する |
| ◆ Laser Wavelength(レーザー光波長) | レーザー光の波長(整数) |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Camera Feed(映像) | ビデオデータの出力 |
| ◆ Laser Distance(レーザー距離) | レーザー光で測定された距離(0～4000ｍ) |
| ◆ Composite Output(複合出力) | コンポジット出力 |
| ・On/Off channel 1 | レーザー光点の検出でオン信号を出力 |
| ・Number channel 1 | レーザー光点の座標X |
| ・Number channel 2 | レーザー光点の高度 |
| ・Number channel 3 | レーザー光点の座標Y |
| ・Number channel 4 | 部品の回転ピッチ（単位：turns） |
| ・Number channel 5 | 部品の回転ヨー（単位：turns） |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) | 動作用電源 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Infrared(赤外線) | チェックボックス | チェックを入れるとレーザー光線と光点が肉眼では見えなくなり、赤外線モードのカメラでのみ見えるようになります |

## CLOCK

時計：時刻を表す数値を出力するアナログ時計ディスプレイ。  
時計には、時刻を視覚化するディスプレイがあります。12時の位置は、ディスプレイの表面にある白い矢印です。

英語原文

An analogue clock display that outputs a number value representing the time of day.  
The clock has a display to visualise the time of day or night.  
The 12 o'clock position is the white arrow on the face of the display.

※カーソルを合わせるとゲーム内時刻を24時間制で分の単位までデジタル表示できます。  
　[Custom Menu](/sbarjp/%E3%82%B2%E3%83%BC%E3%83%A0%E3%83%A2%E3%83%BC%E3%83%89#v0a93134 "ゲームモード")で現在の時間を変更している時、そこで設定した時刻よりこの時計の表示および出力は1分遅いことがあります。1分未満の時間の丸め方がカスタムメニューと異なるのかもしれません。  
価格 $100、サイズ(WxDxH)1x1x2

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Backlight(バックライト) | On/Off(点灯・消灯) |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Time(時間) | 24時間を1としたゲーム内時刻を表す数値を出力する。  深夜0:00が0、午後18:00が0.75、24:00が1になる。時間と分を得る方法は後述。  (正確には次の日の0時になってしまうので1.00が出力されることはない。) |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) |  |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name(表示名称) | 名称記入欄 | カーソルを合わせた時に表示される名称 |

### 時間と分を得る方法:

数値出力 Time を [関数(1入力)](/sbarjp/LOGIC#q4b13bbf "LOGIC")に入力して計算します。計算式は次の通りです。時間と分はそれぞれ別の関数(1入力)が必要です。

|  |  |
| --- | --- |
| 時間(24時間制) | 24\*x-24\*x%1 |
| 分 | 24\*x%1\*60-24\*x%1\*60%1 |

式の中の「%」は剰余を計算する記号です。x%yと書いた場合、x÷yを1の位の答えまで計算した余り。\*2  
剰余%と乗算\*は優先順位が同じなので、前から順に計算されます。もちろん減算の計算は最後です。  
ここでは剰余を使用して計算しましたが、floor()関数でも可能です。[LOGICの数と数式の基本ルール](/sbarjp/LOGIC#cd41a785 "LOGIC")を参考にしてください。  
また、12時間制の時間と秒も計算できます。秒の方は実用にはならないかもしれませんが。

## COMPASS SENSOR

コンパスセンサー：北を向くために必要な角度(時計回りが正)を表す数値を出力するデジタルコンパス。センサーには、北の方向を視覚化するディスプレイがあります。  
測定された出力は、ディスプレイの表面にある白い矢印に関連して取得されます。

英語原文

A digital compass that outputs a number value represeting the turn that must be made for it to face north.  
The sensor has a display to visualise the direction of north.  
The measured output is taken relative to the white arrow on the face of the display.

※[COMPASS BALL](/sbarjp/DISPLAYS#sffee118 "DISPLAYS")と異なり水平は表示できず、ディスプレイが垂直になるような置き方では正常に機能しません。  
価格 $20、サイズ(WxDxH)1x1x2

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Backlight(バックライト) | On/Off(点灯・消灯) |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Compass Reading(読み取り方位) | 測定された方位の値を出力する |
| ±0.00：北、－0.25：東、±0.50：南、＋0.25：西 | |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) |  |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Display Name(表示名称) | 名称記入欄 | カーソルを合わせた時に表示される名称 |

## DISTANCE SENSOR

距離センサー：最大測定範囲500mのレーザー測距儀。  
出力はメートル単位です。

英語原文

A laser distance sensor with a maximum measurement range of 250m.  
The reading can be read from the sensor's numver output and is measured in metres (1 metre = 4 blocks).

※センサー方向(出っ張りのある面)の他のビークル、地面など他の物体までの距離を測定します。  
　水面は測定できません。海の上空で下向きに使用すると海底までの距離を測定します。海水面からの高さを測るには[液量計](#jb5c9d4e)を用います。  
　[レーザー距離センサー](#x32307b8)と異なり、レーザー光線は出ません。  
価格 $20、サイズ(WxDxH)1x1x2

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ distance(距離) | 500mまでの測定結果[m] |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) |  |

## EMERGENCY BEACON

緊急ビーコン：救難信号トランスポンダ。  
アクティブになっている間、トランスポンダロケータによって遠距離からも検出できる電波の救難信号を発信し続けます。

英語原文

An emergency search and rescue transponder.  
When activated, emits a continuous transponder signal that can be detected over great distances by any transponder locator.

※[ビークルに搭載されるトランスポンダロケータ](#zb0dca95)および[ハンドヘルドトランスポンダロケータ](/sbarjp/SPECIALIST%20EQUIPMENT#aad79335 "SPECIALIST EQUIPMENT")で救難信号を検出できます。  
　信号は距離によって減衰し、検出装置は、それを利用してトランスポンダからの電波が弱いと長い、強いと短い間隔でONになって距離を教えてくれます。  
　このトランスポンダそのものは一定の強さの電波を発信しつづけるだけです。  
　同じ救難信号を送出する、[ハンドヘルドトランスポンダ](/sbarjp/SPECIALIST%20EQUIPMENT#u0165817 "SPECIALIST EQUIPMENT")もあります。  
価格 $20、サイズ(WxDxH)1x1x1(半球体、接続面は１面のみ)

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | mass:1 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Active(起動) | 発信のOn/Off |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) | 詳細内容 |

## EMERGENCY BEACON LOCATOR

緊急ビーコン検出装置：救難信号トランスポンダロケータ。  
どんなに遠く離れたトランスポンダの救難信号でも検出できます。  
信号は距離によって減衰するので、それを利用してトランスポンダからの電波が弱いと長い、強いと短い間隔でパルスがONになって距離を教えてくれます。  
複数の発信源がある時は、最も強い信号強度、すなわち最も近いトランスポンダからの信号についての出力をします。

英語原文

An emergency search and rescue transponder locator.  
Detects all transponder signals over great distances.  
Outputs the strongest signal strength detected, transponder signal strengths will decrease with distance.

※パルスの間隔はかなりふわっとしており、間隔が何点何秒だから距離が何メートルと一意に測定できるものではありません。  
　パルスの間隔は、[EMERGENCY BEACONのパルス間隔](/sbarjp/%E6%A4%9C%E8%A8%BC#dcb255ad "検証")の項で詳しく検証されています。  
　パルス出力にはブザーやライト等を接続するとよいでしょう。  
　検出できる救難信号は、[携帯式トランスポンダ](/sbarjp/SPECIALIST%20EQUIPMENT#u0165817 "SPECIALIST EQUIPMENT")と[ビークルに搭載されるタイプの緊急トランスポンダ](#v7c8d639)の両方で、区別は出来ません。  
　同様の検出装置に[ハンドヘルドトランスポンダロケータ](/sbarjp/SPECIALIST%20EQUIPMENT#aad79335 "SPECIALIST EQUIPMENT")もあります。そちらはキャラクターが操作中、パルスの代わりにブザーが鳴ります。  
　[救難ミッション](/sbarjp/%E3%83%9F%E3%83%83%E3%82%B7%E3%83%A7%E3%83%B3%E4%B8%80%E8%A6%A7#mb7bd7ee "ミッション一覧")の救難対象が船舶か航空機の時に、低くはない確率でトランスポンダの信号が送出されるケースがあります。  
価格 $20、サイズ(WxDxH)1x1x2(立方体1ブロックにアンテナ1ブロックが付いた形)

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | mass:1 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Active(起動) | 受信のOn/Off |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Transponder pulse(トランスポンダパルス) | 信号の出力 |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) | 詳細内容 |

## FLUID METER

液量計：密閉された体積内の液体の量をリットル単位で出力します。\*3  
また、密閉された体積の容積も出力できます。  
開放したドアなどで他の密閉された体積と接続しても検査対象の体積は変わらず、設計時の体積に入っている液体の量あるいは容積が出力されます。  
計測面が密閉された体積内にない場合、海水面に対する相対的な深度が得られます。深度は、海水面の上ならマイナス、海水面の**下ならプラス**の値が出力されます。ここで言う海水面は、風による波浪で上下するリアルタイムの海水面です。また、例え地上であっても、もしそこが海だったらあるであろう海水面を測定します。

英語原文

A device to measure how much fluid is within an enclosed volume.  
This will output a quantity in litres and the total capacity in litres.  
If not inside an enclosed volume, it will give the height relative to the water surface.

※密閉された体積 Enclosed Volume とは、Stormworksで浮力を生む船体やカスタムタンク等の外気と繋がっていない空洞のことです。  
　測定できるのは液体である水 Water、ディーゼル燃料 Diesel、ジェット燃料 Jet Fuel、原油 Crude Oilに限られ、気体である空気 Airと排気ガス Exhaustは測定できません。  
　複数の種類の液体が混合されている時は、合計の液量を測定します。  
　類似の機能があるパーツに[高度計](#t63e9b90)がありますが、あちらは波浪で動揺しない標準海水面からの高度を測定し、海水面から上がプラスの値を出力します。  
　このセンサーの計測面(円形部品のある面)が面している密閉された体積内の液量とその容積を出力します。  
　計測面が密閉された体積内にない場合は、計測面の向きに関わらずブロック部分の高度を測定します。  
価格 $20、サイズ(WxDxH)1x1x2

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Fluid Level(液量) | 密閉された体積内の液体の合計[リットル] 開放状態の場合は水面に対する深度[m] |
| ◆ Fluid Capacity(容積) | 密閉された体積の容積[リットル] 開放状態の場合は常に0を出力 |

## GPS SENSOR

GPSセンサー：マップ上の位置に応じてx軸およびy軸のワールド座標を出力します。  
座標は、メートルで測定された世界の中心からのオフセットを表します。  
地図を見れば、任意の場所のワールド座標を確認できます。

英語原文

Outputs its x and y world coordinates according to its location on the map.  
the coordinates represent an offset from the centre of the world, measured in metres.  
You can check the world coordinates of any location by looking at your map.

※この座標情報は[大きなキーパッド](/sbarjp/MECHANICS#v7157e24 "MECHANICS")で入力できるウェイポイント座標と同じです。  
価格 $20、サイズ(WxDxH)1x2x1

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ X Coordinate(x座標) | マップ原点からのX座標(東西・西が－、東が＋) |
| ◆ Y Coordinate(y座標) | マップ原点からのY座標(南北・南が－、北が＋) |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) |  |

## HUMIDITY SENSOR

湿度計：現在の霧と視界気象条件を測定するための湿度センサー。  
現在のゲーム内の霧を0(霧なし)から1(最大の霧)までの値で出力します。

英語原文

A humidity sensor for measuring the current fog and visibility meteorological conditions.  
The reading can be read from the sensor's number output and is measured from 0 (no fog) to 1 (max fog).

※霧 Fog の値は、天気を変更できる設定のゲームの場合に[カスタムメニュー](/sbarjp/%E3%82%B2%E3%83%BC%E3%83%A0%E3%83%A2%E3%83%BC%E3%83%89#hbd573bd "ゲームモード")で0～100%の値に変更可能です。  
価格 $400、サイズ(WxDxH)1x1x2

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Humidity Factor(湿度係数) | 0～1 現在の霧の濃さ |

## LASER DISTANCE SENSOR

レーザー距離センサー：最大測定範囲4000mのレーザー測距儀。  
出力はメートル単位です。

英語原文

A laser distance sensor with a maximum measurement range of 4000m.  
The reading can be read from the sensor's numver output and is measured in metres(1 metre = 4 blocks).

※アクティブになると赤色のレーザーが照射されます。[レーザーポイントセンサー](#o7c04ec2)によって、レーザーが命中している光点を検出できます。  
　また、この光点は[スタビライズドカメラ](#c689743c)を追跡モードで使用する時の追跡対象になります。  
　波長の設定について要調査(受信側であるレーザーポイントセンサーと同じ波長である必要があると思われます)。  
　水面は測定できません。海の上空で下向きに使用すると海底までの距離を測定します。海水面からの高さを測るには[液量計](#jb5c9d4e)を用います。  
　レーザーが出ない[測距儀](#u21e0cf4)もあります。  
価格 $100、サイズ(WxDxH)1x5x1

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Active(起動) | On/Off(レーザーを起動するかどうかの制御) |
| ◆ Wavelength(波長) | 照射するレーザー光の波長(整数) |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Distance(距離) | 4000mまでの測定結果[m] |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) |  |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Infrared(赤外線) | チェックボックス | チェックを入れるとレーザー光線と光点が肉眼では見えなくなり、赤外線モードのカメラでのみ見えるようになります |

## LASER POINT SENSOR

レーザーポイントセンサー：レーザーが命中している光点の相対位置を測定します。  
検出できる位置は、このセンサーの視野内に限られます。  
複数のレーザーによる光点が視野内にある場合、最もこのセンサーに近い光点の位置を測定します。  
コンポジット出力の数値チャンネル1に、相対位置のx座標を、数値チャンネル2に相対位置のy座標が出力されます。  
二つの数値チャンネルに出力される値は-1から1の範囲をとり、センサーの視野角120°内の-cos(0.5)からcos(0.5)に対応します。  
コンポジット出力のOn/Offチャンネル1には光点を視野内に検出するとオンになる信号が出力されます。

英語原文

A sensor that outputs a relative x and y position of a laser point that it can see within its field of view.  
The closest point to the senter of the sensor's field of view will be reported.  
It outputs a value of -1 to 1 on composite numver channel 1 for the x position, and a value of -1 to 1 on composite number channel 2 for the y position.  
Composite on/off channel 1 is set to on when a point is visible.  
The -1 to 1 values map to an fov of -cos(0.5) to cos(0.5) in both the x and y directions.

※レーザー光点は[レーザー距離センサー](#x32307b8)や[スタビライズドカメラ](#c689743c)による照射で地面やビークルの表面に生じます。  
　また、[レーザービーコン](/sbarjp/DISPLAYS#xdb1397e "DISPLAYS")はそれ自身がレーザー光点になります。  
　波長の設定について要調査(送信側であるレーザー距離センサーと同じ波長である必要があると思われます)。  
価格 $100、サイズ(WxDxH)1x3x1

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 2 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Wavelength(波長) | 検出するレーザー光の波長(整数) |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Data Output(データ出力) | コンポジット出力 |
| ・On/Off channel 1 | 光点の検出中、オンを継続 |
| ・Number channel 1, 2 | 検出した光点のX、Y位置(センサー視野は120度、数値は0を中心にして-1～1) |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) |  |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Infrared(赤外線) | チェックボックス | チェックを入れると赤外線レーザーによる光点を検出できるようになります |

## LASER SENSOR (MISSILE)

レーザーセンサー（ミサイル用）：視界内の検出されたレーザーポイントに関する情報を返す短距離センサーです。  
このセンサーはミサイル用に設計されており、Z軸に沿って機能し、最も近いターゲットに向けてリンクされたロケットフィン部品のコース補正にデータを渡す出力ノードを備えています。このセンサーは、検出された最大8つのレーザーポイントのデータも出力します。

英語原文

A short range sensor that returns information about detected laser points within its view.  
This sensor is designed for missiles and acts along the Z axis, with an output node that passes data to course correct linked rocket fin components toward the closest target. The sensor also outputs data for up to 8 detected laser points.

価格 $800、サイズ（WxDxH）1x1x2

| PROPERTIES（特性） | 詳細 |
| --- | --- |
| 重量（mass） | mass:5 |
| LOGIC INPUTS（ロジック入力） | 詳細 |
| ◆ Activate(アクティベート) | レーザーセンサーを有効にする。 |
| ◆ Wavelength(波長) | 検出する特定の光の波長（整数）。 |
| LOGIC OUTPUTS（ロジック出力） | 詳細 |
| ◆ Sensor Data(センサーデータ) | 最大8つのターゲットのデータを出力します。オン/オフ 1-8 : ターゲット1が見つかりました、ターゲット2が見つかりました、など... 値 1-32 : ターゲット1の距離、ターゲット1の方位角、ターゲット1の仰角、ターゲット1の検出からの時間、ターゲット2の距離、ターゲット2の方位角、ターゲット2の仰角、ターゲット2の検出からの時間、など... |
| ◆ Missile Output(ミサイル出力) | 最も近いターゲットのxおよびyデータを出力します。これをロケットフィンの部品に直接リンクします。 |
| CONNECTIONS（接続） | 詳細 |
| ◆ Electric(電力) | 電力接続 |

## LINEAR SPEED SENSOR

リニアスピードセンサー：現在の速度をm/s単位で出力します。  
計測する速度の種類を4つのモードから選択できます。

英語原文

This sensor outputs its current linear speed in m/s, allowing you to measure how fast your vehicle is travelling.  
This sensor outputs the speed of the component in one of 4 modes. Modes can be changed by selecting the sensor.

価格 $20、サイズ(WxDxH)1x1x2

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Linear Speed(線形速度) | 速度[m/s] |

※ここでの(線形)速度とは、物体の位置が変わる速度のことです。物体の向きが変わる速度である角速度は、[角速度計](#d4a80bea)で測定できます。

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Sensor Mode(センサーモード) | Absolute / Directional / Horizontal / Vertical | 計測する速度の種類 |
| ・Absolute(絶対値) | 三次元速度ベクトルの絶対値。前後、左右、上下のそれぞれの速度を三次元的にピタゴラスのアレで足したもの | |
| ・Directional(方向指定) | 突起部品のある方向を前とする速度成分。ビークルの前向きに取り付けると、ビークルの前進後退の速度のみが出力されます | |
| ・Horizontal(水平) | 速度の水平成分。前後と左右方向の速度成分によってできる水平方向の速度ベクトルの絶対値 | |
| ・Vertical(垂直) | 速度の垂直成分。乗り物の上下動に応じた正負の値が出力されます | |

※Directional以外のモードでは、センサー自体の傾きは出力に影響せず、水平、垂直はマップのX-Y平面を基準とした絶対的な水平、垂直を指します。  
　Directionalモードでは、センサーの前向きと直交する平面の速度成分は測定されません。例えばヘリコプターなどセンサーを含めた機体全体が前傾しながら水平飛行しているビークルの場合、真の前進速度×cos(ピッチ角)が出力されます。

速度に関する換算式

速度に関する換算式  
このセンサーが出力する測定値はメートル毎秒なので、km/hやノットに変換したい場合はLOGICのFUNCTION(1 INPUT)やマイクロコントローラーで調整が必要。

|  |  |
| --- | --- |
| x \* 3.6 | km/h |
| x \* 2.236936 | mile/h |
| x \* 1.943844 | ノット |

※ゲーム内でも関数入力の際によく使う変換式(Conversions)として記載されています。

## MICROPHONE

マイクロフォン：プレイヤーの音声データを送信するためのマイク。  
近くのプレーヤーから音声データを拾うシンプルなマイク。(範囲：15)

英語原文

A microphone for transmitting player voice data.  
A simple microphone that picks up voice data from nearby players. (Range : 15)

※ボイスチャットの動作について要検証\*4  
価格 $250、サイズ(WxDxH)1x1x1

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Activate(起動) | On/Off(マイクを起動する) |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Is transmit(送信中) | On/Off(マイクロホンが現在送信中の場合信号を出力) |
| ◆ Audio(音声) | オーディオデータの出力 |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) | 詳細 |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Default to Active(初期 起動状態) | チェックボックス | 初期状態で起動されている状態にするか切り替える |

## PHYSICS SENSOR

物理センサー:いくつかのセンサーを単一のブロックに統合したもの

英語原文

The physics sensor component combines functionality of several other sensors into a convenient single block.

価格 $20、サイズ(WxDxH)1x1x2

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass)、出力(power) | 1 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ composite output() | コンポジット出力 |
| ・Number channel 1 | X座標 |
| ・Number channel 2 | Y座標 |
| ・Number channel 3 | Z座標 |
| ・Number channel 4 | オイラー角X |
| ・Number channel 5 | オイラー角Y |
| ・Number channel 6 | オイラー角Z |
| ・Number channel 7 | X軸速度 |
| ・Number channel 8 | Y軸速度 |
| ・Number channel 9 | Z軸速度 |
| ・Number channel 10 | 角速度X |
| ・Number channel 11 | 角速度Y |
| ・Number channel 12 | 角速度Z |
| ・Number channel 13 | 絶対速度 |
| ・Number channel 14 | 絶対角速度 |
| ・Number channel 15 | ローカルでのZ軸傾き |
| ・Number channel 16 | ローカルでのX軸傾き |
| ・Number channel 17 | コンパスの向き(-0.5～0.5 |

Physics Sensorの座標系について

Physics Sensorから出力される座標やオイラー角を利用するにあたり、このセンサーが採用している座標系について理解する必要がある。

Mマップ画面で右下に表示される座標やGPS Sensorから出力される2次元座標は、東方向をX軸正方向、北方向をY軸正方向に取っている。  
これに加えAltimeterから出力される高度をZ座標として採用するとこの座標系は右手系となる。以下この座標系をGPS座標系と呼ぶ。  
これに対し、Physics SensorやCamera Stabilizedから出力される座標は、東方向をX軸正、鉛直上方向をY軸正、北方向をZ軸正に取った左手系の座標系となっている。  
以下この座標系をPhysics Sensor座標系と呼ぶ。

座標の数値をPhysics Sensor座標系からGPS座標系へ変換したい場合は、古いY座標を新しいZ座標に、Z座標をY座標にそれぞれ読み替えればよい。

Physics Sensor上部に表示されている水色の矢印はセンサー自体の向きを表し、Physics SensorのLocal座標系の基準となる。  
以下Physics SensorのLocal座標系は、水色の大きい矢印をZ軸正、小さい矢印をX軸正に取った左手系の座標であるとする。  
Physics Sensorから出力されるオイラー角は、Physics SensorのLocal座標系とGlobal座標系の向きを一致させ、そこからセンサーをZ軸まわり→Y軸まわり→X軸まわりの順に回転させたときのLocal座標系の姿勢を表すオイラー角となっている（回転の向きは、軸正方向に左ネジが進む向きを正としている）。いわゆるZ-Y-X系のオイラー角である。

この説明や他のオイラー角の解説を読んで分かりにくく感じた場合は、実際にPhysics Sensorを（3個の直交する）ピボットに乗せて回転させ、ピボットの回転角とセンサーの出力値を比較してみる事をオススメする。どのような場合でも両者の値が一致するピボットの設置順は1種類しかないはずだ。

また、GPS座標系から見るとPhysics Sensorからは(-Y)-(-Z)-(-X)系のオイラー角が出力されていることになる（回転向きが反対であることを表すためマイナスを付けた）。他の回転順序を取るオイラー角への変換を行いたい場合、単純な数値の置き換えでは不十分であり、例えばクォータニオンでの姿勢表現を経由した変換計算を行う必要がある。

## PLAYER SENSOR

プレイヤーセンサー：エリア内で検出されたプレイヤーの数を出力するセンサー。  
センサーが密閉された部屋に面している場合は、その部屋の内側にいるプレイヤーだけが検出されます。  
同様に、センサーが外側に配置されていると、例え検出距離内であっても密閉された部屋の内側にいるキャラクターは検出されません。  
検出距離と形状、検出できるキャラクターの種類を変更できます。

英語原文

A sensor that outputs the number of players detected within an area.  
If the sensor is facing into a sealed room, only players in side that room will be detected.  
Likewise, players inside seeled rooms will not be detected if the sensor is placed on the outside.  
The size of the area and types of players to detect can be changed by selecting this component with the select tool.

価格 $50、サイズ(WxDxH)1x1x2

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass)、出力(power) | 1 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Number Detected(検出数) | センサーで検出したプレイヤー数 |
| ◆ Detected(検出) | On/Off(プレイヤーが検出された場合にオン信号を出力) |

| SELECT選択設定項目 | 設定内容 | 補足 |
| --- | --- | --- |
| Type(種類) | Hemisphere / Sphere | 検出範囲の形状の設定。半球/球体 |
| Radius(metres)(半径(メートル)) | 0.25～10.00ｍ | 1～40ブロック分の距離を設定できる |
| Mode(方法) | Detect All / Detect Players / Detect NPCs | 検出する対象の設定。全て/プレイヤーのみ/NPCのみ |

## RADAR(AWACS)

長距離において、視野内に検知した目標についての情報を返すレーダー。  
索敵距離および視野角内の目標に対する、距離と相対角度を出力します。  
レーダーの感度は目標の大きさ、距離およびレーダーの視野角に依存します。

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | ??? |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Activate() | レーダーの有効化 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Radar Rotation（） |  |
| ◆ Radar Data（） | コンポジット出力 |
| ・On/Off channel 1～8 | 目標が現出された場合にオン信号が出力される |
| ・Number channel 1～4 | ターゲット１の相対距離・信号強度・俯仰角・方位角の数値を出力 |
| ・Number channel 5～8 | ターゲット２の相対距離・信号強度・俯仰角・方位角の数値を出力 |
| ・Number channel 9～12 | ターゲット３の…同上… |

以下…同上…

|  |  |
| --- | --- |
| ・Number channel 13～16 | ターゲット４の…同上… |
| ・Number channel 17～20 | ターゲット５の…同上… |
| ・Number channel 21～24 | ターゲット６の…同上… |
| ・Number channel 25～28 | ターゲット７の…同上… |
| ・Number channel 29～32 | ターゲット８の…同上… |

| CONNECTIONS(接続) | 詳細 |
| --- | --- |
| ◆ Electric(電力) |  |

## RADAR(BASIC)

長距離において、視野内に検知した目標についての情報を返すレーダー。  
索敵距離および視野角内の目標に対する、距離と相対角度を出力します。  
レーダーの感度は目標の大きさ、距離およびレーダーの視野角に依存します。

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | ??? |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Activate() |  |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Radar Data（） | コンポジット出力 |
| ◆ Radar Rotation（） |  |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) |  |

## RADAR(DISH)

長距離において、視野内に検知した目標についての情報を返すレーダー。  
索敵距離および視野角内の目標に対する、距離と相対角度を出力します。  
レーダーの感度は目標の大きさ、距離およびレーダーの視野角に依存します。

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | ??? |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Activate() |  |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Radar Data（） | コンポジット出力 |
| ◆ Radar Rotation（） |  |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) |  |

## RADAR(MISSILE)

A short range radar that returns information about a detected object within its view. This sensor outputs the distance and relative angle to a detected object within its range and field of view using radio waves. This sensor is designed for missiles and its radar acts along the Z axis. Sensitivity is based on fov, target size, and distance.

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 5 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ Activate() |  |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Radar Data（） | コンポジット出力 |
| ◆ Missile Output（） | コンポジット出力 |
| ・Number channel 1, 2 | 1:Yaw(X)、2:Pitch(Y) |
| ◆ Radar Rotation（） |  |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) |  |

## RADAR(PHALANX)

A radar that returns information about a detected object within its view. This sensor outputs the distance and relative angle to a detected object within its range and field of view using radio waves. Sensitivity is based on fov, target size, and distance.

## （※削除済み）旧RADAR

レーダー：電波の反射を利用して、その範囲と視野内のターゲットとの相対距離と、ターゲットに対する相対俯仰角を出力します。  
これらの情報からターゲットの絶対位置を計算することができます。(範囲：5000m)(最大視野:0.125)

英語原文

This sensor output its target's distance in metres and angle of the target relative determine the location of the detected object.  
this sensor outputs the distance and angle to a detected object within its range and field of view using radio waves.(Range：5000m)(Max FOV:0.125)

※視野角を狭くして水平向きを操作することでターゲットが存在する方位を得られますが、視野角内にあるかどうかを検出するだけなのでターゲットの方位には範囲ができます。  
　ターゲットとして検出できるのはレーダーとは異なるビークルとキャラクターです。同じビークルの異なる部分(ビークル編集のマージ MERGE 画面で別の色になる部分)も検出されるので、視野内にカスタムドアやクレーンの可動部分があると検出されてしまいます。  
　島や山などの地形は検出できません。  
　縦方向の視野は設置面を0とした上下45°ずつの90°（-0.125～0.125）で固定です。  
価格 $1000、サイズ(WxDxH)3x3x1(参考形状)

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 10 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ FOV(視野角) | 0.01～0.125、センサーの視野 |
| ◆ Facing Yaw(水平向き) | -0.5～0.5、センサーの向き |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Target Distance(目標距離) | ターゲットとの相対距離(範囲：5000m) |
| ◆ Signal Strength(信号強度) | 返ってきた信号の強さ |
| ◆ Elevation Angle(俯仰角) | ターゲットの相対俯仰角(-0.125～0.125) |
| ◆ Target Found(目標発見) | オブジェクトが検出された場合にオン信号が出力される |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) |  |

## （※削除済み）旧RADAR (DISH)

レーダー(皿型)：視野内で検出されたオブジェクトに関する情報を出力する、中距離用固定レーダーです。  
電波の反射を利用して、その範囲と視野内のターゲットとの相対距離と、ターゲットに対する相対俯仰角を出力します。(範囲：20000m)(最大視野:0.125)

英語原文

A medium range, fixed rotation radar thar returns information about a detected object within its view.  
This fixed sensor outputs the distance and angle to a detected object within its range and field of view using radio waves.(Range：20000m)(Max FOV:0.125)

価格 $3000、サイズ(WxDxH)21x11x10(パラボラ型、設置面は5x3、反射部は21x6x9、受信部は5x8x3)

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 150 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ FOV(視野角) | 0.01～0.125、センサーの視野 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Target Distance(目標距離) | ターゲットとの相対距離(範囲：20000m) |
| ◆ Signal Strength(信号強度) | 返ってきた信号の強さ |
| ◆ Elevation Angle(俯仰角) | ターゲットの相対俯仰角 |
| ◆ Target Found(目標発見) | オブジェクトが検出された場合にオン信号が出力される |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) | 詳細 |

## （※削除済み）旧RADAR (HUGE)

レーダー(巨大)：視野内で検出された複数のオブジェクトに関する詳細な情報をコンポジット出力を介して出力する、長距離用マルチターゲットレーダーです。  
電波の反射を利用して、その範囲と視野内で最大8つの検出されたターゲットについて、コンポジット出力を介して相対距離、相対方位、相対俯仰角を出力します。(範囲：50000m)(最大視野:0.125)

英語原文

A long rage, multi-target radar that returns detailed information through composite channels about detected objects within its view.  
This sensor outputs the distance and relative angles to up to 8 detected objects within its range and field of view using radio waves and outputs all detected targets through composite channels.(Range：50000m)(Max FOV:0.125)

価格 $10000、サイズ(WxDxH)37x37x5(巨大な円盤型)

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1100 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ FOV(視野角) | 0.01～0.125、センサーの視野 |
| ◆ Facing Yaw(水平向き) | -0.5～0.5、センサーの向き |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Radar Data(レーダー情報) | コンポジット出力 |
| ・On/Off channel 1～8 | 目標が現出された場合にオン信号が出力される |
| ・Number channel 1～4 | ターゲット１の相対距離・信号強度・俯仰角・方位角の数値を出力 |
| ・Number channel 5～8 | ターゲット２の相対距離・信号強度・俯仰角・方位角の数値を出力 |
| ・Number channel 9～12 | ターゲット３の…同上… |

以下…同上…

|  |  |
| --- | --- |
| ・Number channel 13～16 | ターゲット４の…同上… |
| ・Number channel 17～20 | ターゲット５の…同上… |
| ・Number channel 21～24 | ターゲット６の…同上… |
| ・Number channel 25～28 | ターゲット７の…同上… |
| ・Number channel 29～32 | ターゲット８の…同上… |

| CONNECTIONS(接続) | 詳細 |
| --- | --- |
| ◆ Electric(電力) |  |

## （※削除済み）旧RADAR (LARGE)

レーダー(大型)：視野内で検出されたオブジェクトに関する情報を出力する、高度に設定可能な中距離用レーダーです。  
電波を使用して、その範囲と視野内で検出されたターゲットまでの相対距離、相対方位、相対俯仰角を出力します。  
このセンサーは、他のレーダーと異なりセンサーの指向方向の俯仰角の変更が可能です。(範囲：20000m)(最大視野:0.25)

英語原文

A medium range, highly configurable Radar that returns detailed information about a detected object within its view.  
This sensor outputs the distance and relative angles to a detected object within its range and field of view using radio waves.  
This sensor uniquely allows the changing of it's pitch direction.(Range：20000m)(Max FOV:0.25)

※センサーの指向方向の俯仰角を変更しても、外見上はレドームが傾いたりはしません。  
　小型のRADARと異なり、縦方向の視野角もFOVの値に従って変化します。  
価格 $5000、サイズ(WxDxH)7x7x16(頭の丸い円筒型)

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 300 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ FOV(視野角) | 0.01～0.25、センサーの視野 |
| ◆ Facing Yaw(水平向き) | -0.5～0.5、センサーの水平向き |
| ◆ Facing Pitch(垂直向き) | -0.25～0.25、センサーの俯仰角 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Target Distance(目標距離) | ターゲットとの相対距離(範囲：20000m) |
| ◆ Signal Strength(信号強度) | 返ってきた信号の強さ |
| ◆ Elevation Angle(俯仰角) | Facing Pitchの値に対するターゲットの相対俯仰角 |
| ◆ Azimuth Angle(方位角) | Facing Yawの値に対するターゲットの相対方位角 |
| ◆ Target Found(目標発見) | オブジェクトが検出された場合にオン信号が出力される |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) | 詳細 |

## RADAR DETECTOR

レーダー波検出器：レーダーからの電波を検出するとオン信号を出力します。

英語原文

A sensor that can detect radar waves.  
This Sensor outputs an On signal when it detects a radio wave.

※レーダー波を照射されているかどうかだけが分かります。方角や電波強度は分からないのでパッシブレーダーとして使うことはできません。  
追記:アップデートにより、レーダーとレーダー波検出器の間に障害物（別マージ）が存在する場合、レーダー波が遮られる仕様になりました。  
この仕組みを応用し、特定の方向だけレーダー波を受信するよう配置を工夫すれば、大まかな方角を推測することが可能です。  
価格 $1000、サイズ(WxDxH)1x1x2

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Detected(検出) | レーダー波を検出するとオン信号を出力 |

## RAIN SENSOR

雨量計：現在の気象条件を測定するための雨センサー。  
現在のゲーム内の降水量を0(雨なし)から1(最大雨量)までの値で出力します。

英語原文

A rain sensor for measuring the current meteorological conditions.  
The reading can be read from the sensor's number output and is measured from 0 (no rain) to 1 (max rain).

※降水量 Rain の値は、天気を変更できる設定のゲームの場合に[カスタムメニュー](/sbarjp/%E3%82%B2%E3%83%BC%E3%83%A0%E3%83%A2%E3%83%BC%E3%83%89#hbd573bd "ゲームモード")で0～100%の値に変更可能です。  
価格 $180、サイズ(WxDxH)1x1x2

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Rain Factor(雨係数) | 0～1 現在の降雨量 |

## SONAR

ソナー：視野内で検出された水中オブジェクトに関する情報を返す短距離ソナー。  
音波を使用してその範囲内および視野内で検出された水中物体までの距離と角度を出力します。(範囲：3000m)(最大視野:0.125)

英語原文

A short range Sonar that returns information about a detected underwater object within its view.  
This sensor outputs the distance and angle to a detected underwater object within its range and field of view using sound waves.

価格 $1000、サイズ(WxDxH)7x7x2(四隅の角が取れた形)

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 25 |
| LOGIC INPUTS(ロジック入力) | 詳細 |
| ◆ FOV(視野角) | 0.01～0.125、センサーの視野 |
| ◆ Facing Yaw(水平向き) | -0.5～0.5、センサーの向き |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Target Distance(目標距離) | 目標距離(範囲：5000m) |
| ◆ Signal Strength(信号強度) | 返ってきた信号の強さ |
| ◆ Elevation Angle(仰角) | センサーと目標間のピッチ角 |
| ◆ Target Found(目標発見) | オブジェクトが検出された場合にオンが出力される |
| CONNECTIONS(接続) | 詳細 |
| ◆ Electric(電力) |  |

## TEMPERATURE PROBE

温度プローブ：温度を検知するセンサー。  
現在の周囲気温を摂氏℃の値で出力します。

英語原文

A sensor to determine temperature.  
A sensor that outputs the current ambient air temperature at its location in Celcius.

※昼夜・天候(雨量)・地域・火災などで変化する気温を測定します。  
　海中に沈めるとおそらく海水温と思われる温度を測定します。  
価格 $250、サイズ(WxDxH)1x1x1(接続箇所は一面のみ)

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | mass:1 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Temperature(周囲温度) | 摂氏温度(℃) |

## TILT SENSOR

傾斜計：地平線に対してどれだけ傾いているかを測定します。  
設計中に表示される青矢印が水平線に対してどれだけ傾いているかを、水平線を0、天頂を0.25、天底を-0.25の値で出力します。

英語原文

A sensor that measures how much it has tilted, relative to the horizon.  
The measurement is expressed in terms of turns, with an output range of -0.25 to 0.25 turns.  
A value of zero points towards the horizon.

※取付向きでロールとピッチの傾きを計測できます。ヨー方向の測定は[コンパスセンサー](#b48edf9e)を使用してください。  
価格 $20、サイズ(WxDxH)1x1x2

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Tilt(傾斜) | -0.25～0.25(傾斜量、0が水平) |

## WIND SENSOR

風向風速計：相対風速と相対風向を測定します。  
相対風速[m/s]と、相対風向として設計中のプロペラの向きを現在の方向まで回すのに必要な角度(-0.5～0.5[回転] 時計回りが正)を出力します。  
このセンサーが移動していると、移動速度ベクトルと自然風の合成風が計測されます。また、このセンサーが旋回する平面内の風だけが測定可能です。

英語原文

A wind sensor for measuring relative wind speed and direction.  
The sensor outputs the wind direction relative to the orientation of the base of the sensor (in number of turns from -0.5 to 0.5) and the wind speed in m/s.  
Wind data is relative to the speed of the sensor and only measures wind in the plane of the sensor.

※相対風向とはブロック部分が回転するとそれに応じて出力値が変化することを指します。設計時にプロペラがビークルの前を向くように搭載していれば、絶対風向(例えば北西の風 方位0.125)が一定でもビークルの向き(例えば東向き 方位-0.25)に応じた相対風向(例えば「左後ろからの追い風」方向-0.375)が得られます。\*5  
　絶対風向を知るためには、設計中にこのセンサーのプロペラ側と同じ向きに設置した[コンパスセンサー](#b48edf9e)の出力から、こちらの相対風向を減じてください。

コンパスセンサー同様に-0.5～0.5の範囲になるように変換するには条件分岐や関数を使う必要があります。

コンパスセンサー同様に-0.5～0.5の範囲になるように変換するには条件分岐や関数を使う必要があります。  
作例:

[![wiki_WindDirection.png](https://cdn.wikiwiki.jp/to/w/sbarjp/SENSORS/::ref/wiki_WindDirection.png.webp?rev=0ed34e60c49772cb4660f469035aea2f&t=20210204193444 "wiki_WindDirection.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/SENSORS/::attach/wiki_WindDirection.png?rev=0ed34e60c49772cb4660f469035aea2f&t=20210204193444 "wiki_WindDirection.png")

図の中のFunctionの式: -(1-abs(x))\*sgn(x)によって、-0.5～0.5の範囲を超えていた時の値をその範囲内の値に置き換えます。度数法で言うと、460°を100°に置き換えるのと同じです。  
この例では論理ゲートパーツで作ってありますが、同じロジックゲートがありますのでマイコンにすることもできます。  
また、LESS-THANとGREATER-THAN、2つのスイッチボックスを使って-0.5未満の時と0.5以上の時を別々に計算すれば、関数とABSを使わずに求めることも可能ですし、剰余を使えばスイッチボックスなしに計算だけで求めることもできます。

　コンパスセンサーは「北を向くために必要な角度」ですが、こちらは「現在の方向まで回すのに必要な角度」なので、どちらも時計回りが正なのにも関わらず正負が逆なことに注意してください。  
価格 $200、サイズ(WxDxH)1x1x2(パーツの尾翼部分には判定無し？)

| PROPERTIES(特性) | 詳細 |
| --- | --- |
| 重量(mass) | 1 |
| LOGIC OUTPUTS(ロジック出力) | 詳細 |
| ◆ Wind Speed(風速) | (m/s)相対風速 |
| ◆ Wind Direction(風向) | -0.5～0.5 パーツに対する風の方向 |
