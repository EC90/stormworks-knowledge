---
wiki: sbarjp
page: Luaスクリプト
source_url: https://wikiwiki.jp/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88
last_modified: 2023-10-13
retrieved_at: 2026-08-31T01:12:28+0800
---

# Luaスクリプト

|  |
| --- |
| - [Luaとは](#se876f63) - [ヘルプドキュメント](#k2120736)    - [LUA SCRIPTING OVERVIEW (Luaスクリプトの概要)](#aedb1eea)   - [SCRIPT BASICS (スクリプトの基本)](#y981956d)   - [COMPOSITE INPUT/OUTPUT (コンポジット入出力)](#m96216fa)   - [PROPERTIES (プロパティ)](#o3b782c5)   - [DRAWING (描画)](#e21c1ee6)   - [MAP (マップ)](#q8f95d4a)      - [MAP API 詳細説明](#aba21b44)   - [TOUCHSCREEN DATA (タッチスクリーンデータ)](#q4bc8b91)   - [LUA FUNCTIONS (Lua関数)](#y34c16af)   - [HTTP (HTTPアクセス)](#rd5a3f8e)   - [META FROM THE DEVS (開発者からのメタ)](#i69aafc4)   - [隠しAPI(?)](#p94f913a) |

## Luaとは

Luaはプログラミング言語の中でも「スクリプト言語」に分類されるもののひとつ。  
Stormworksではマイコンのロジックと、アドオンの要素として扱うことができる。  
このページはマイコンLuaのヘルプドキュメントの全訳である。アドオンLuaは[こちら](/sbarjp/%E3%82%A2%E3%83%89%E3%82%AA%E3%83%B3Lua "アドオンLua")。

## ヘルプドキュメント

### LUA SCRIPTING OVERVIEW (Luaスクリプトの概要)

> Lua scripting gives you the tools to create advanced logic components using the Lua scripting language. Stormworks provides a number of functions to allow your script to interface with your vehicle's logic system, as well as drawing to in-game monitors.  
>   
> This guide outlines the functions that are available for use in your scripts but it is not a comprehensive tutorial on using the Lua language.

Luaスクリプトは、Luaスクリプト言語を使用して高度なロジックコンポーネントを作成するためのツールを提供します。Stormworksには、スクリプトとビークルの論理回路を接続させたり、ゲーム内モニターに描画したりするための機能が多数用意されています。  
このガイドではスクリプトで使用できる機能の概要を説明していますが、Lua言語の使用に関する包括的なチュートリアルではありません。

### SCRIPT BASICS (スクリプトの基本)

> The tick function will be called once every logic tick and should be used for reading composite data and any required processing. Screen functions will have no effect if called within onTick.

tick関数は論理ティックごとに1回呼び出され、複合データの読み込みと必要な処理に使用する必要があります。onTick関数内で呼び出された場合、Screen関数は影響を受けません。

```
function onTick()
    -- Example that adds two composite channels together and outputs the result
    in1 = input.getNumber(1)
    in2 = input.getNumber(2)
    output.setNumber(1, in1 + in2)
end
```

> The draw function will be called any time this script is drawn by a monitor. Noterthat it can be called multiple times if this microcontrolter is connected to multiple monitors whereas onTick is only called once. Composite Input/output functions Will have no effect If called within onDraw.

このスクリプトがモニタによって描画されるときは常にdraw関数が呼び出されます。このマイクロコントローラが複数のモニタに接続されている場合は複数回呼び出すことができますが、onTick関数は一度しか呼び出されないことに注意してください。onDraw関数内で呼び出された場合、コンポジット入出力関数は影響を受けません。

```
function onDraw()
    -- Example that draws a red circle in the center of the screen with a radius of 20 pixels
    width = screen.getWidth()
    height = screen.getHeight()
    screen.setColor(255, 0, 0)
    screen.drawCircleF(width / 2, height / 2, 20)
end
```

### COMPOSITE INPUT/OUTPUT (コンポジット入出力)

> Read values from the composite input. Index ranges from 1 - 32.

コンポジット入力から値を読み取ります。 インデックスの範囲は1から32です。

```
input.getBool(index)
input.getNumber(index)
```

> Set values on the composite output. Index ranges from 1 - 32.

コンポジット出力に値を設定します。 インデックスの範囲は1から32です。

```
output.setBool(index, value)
output.setNumber(index, value)
```

### PROPERTIES (プロパティ)

> Read the values of property components within this microcontroller directly. The label passed to each function should match the label that has been set for the property you're trying to access (case-sensitive).

同マイクロコントローラ内のプロパティコンポーネントの値を直接読み取ります。各関数に渡されるラベルは、アクセスしようとしているプロパティに設定されているラベルと一致する必要があります（大文字と小文字が区別されます）。  
※ヘルプには書かれていませんが、カッコ内のラベル名はダブルクォーテーション（"label"）で囲まないと読み取られません。

```
property.getNumber(label)
property.getBool(label)
property.getText(label)
```

### DRAWING (描画)

Set the current draw color. Values range from 0 - 255.  
線や文字を描画する際の色を決定する。RGB値で各256色まで対応。

```
screen.setColor(r, g, b)
```

Set the current draw colour and transparency. Values range from 0 - 255.  
アルファ値を追加したタイプ。a値で透明度を決定する。

```
screen.setColor(r, g, b, a)
```

Clear the screen with the current color.  
現在の色でスクリーンを塗りつぶす。  
※この関数が呼び出される時点での指定色でスクリーン全体が塗りつぶされる。アルファ値に関係なく、この関数より前に書かれたスクリプトの描画は完全に見えなくなる。この関数より後に書かれたスクリプトの描画は塗りつぶされず描画される。

```
screen.drawClear()
```

Draw line from (x1, y1) to (x2, y2).  
X1,Y1の座標からX2,Y2の座標に向かって直線を描画する。

```
screen.drawLine(x1, y1, x2, y2)
```

Draw circle at (x, y) with radius.  
x,y座標を中心に半径rの円を描画する。

```
screen.drawCircle(x, y, r)
```

Draw filled circle at (x, y) with radius.  
x,y座標を中心に半径rの円を描画する。円の内側は塗りつぶされる。

```
screen.drawCircleF(x, y, r)
```

Draw rectangle at (x, y) with width and height.  
x,yを基点として四角形を描画する。

```
screen.drawRect(x, y, width, height)
```

Draw filled rectangle at (x, y) with width and height.  
x,yを基点として四角形を描画する。四角形の内側は塗りつぶされる。

```
screen.drawRectF(x, y, width, height)
```

Draw triangle between (x1, y1), (x2, y2) and (x3, y3).  
(x1,y1)、(x2,y2)、(x3,y3)を結ぶ三角形を描画する。

```
screen.drawTriangle(x1, y1, x2, y2, x3, y3)
```

Draw filled triangle between (x1,y1), (x2, y2) and (x3, y3).  
(x1,y1)、(x2,y2)、(x3,y3)を結ぶ三角形を描画する。三角形の内側は塗りつぶされる。

```
screen.drawTriangleF(x1, y1, x2, y2, x3, y3)
```

Draw text at (x, y). Each character is 4 pixels wide and 5 pixels tall.  
x,y座標を基点としてテキストを描画する。1文字は幅4ピクセル、高さ5ピクセル。  
※textの欄はダブルクォーテーションで囲んで文字を入れる必要がある。

```
screen.drawText(x, y, text)
```

Draw text within the rectangle at (x, y) with width and height. Text alignment can be specified using the last two parameters and ranges from -1 to 1 (left to right, top to bottom). If either of the alignment parameters are omitted, the text will be drawn top-left by default. Text will automatically wrap at spaces when possible, and will overflow the top/bottom of the specified rectangle if too large.  
x,y,w,hの四角形の中にテキストを描画する。  
末尾の2つの引数h\_align,v\_alignに-1～1を指定することでテキストの整列を指定できる(-1～1でh\_alignは左～右、v\_alignは上～下)。引数を省略した場合、デフォルトでは左上になっている。  
可能ならば、テキストは四角形に収まるよう自動で折り返され、多すぎるテキストを指定した場合は上下がはみ出す。

```
screen.drawTextBox(x, y, w, h, text, h_align, v_align)
```

Draw the world map centred on map coordinate (x,y) with zoom level ranging from 0.1 to 50.  
x,yを中心とする世界地図を描画する。zoomに0.1～50の範囲でズームレベルを指定する。  
※このx,yは[m]キーで見られる地図やGPSで取得できる世界座標。単位はメートル。  
※zoomは画面横幅に何km表示するかを指定する引数。0.1なら100m、50なら50kmの範囲を表示する。縦横比が1:1でないモニタで描画する際も横幅基準、縦方向の描画範囲が横方向より狭くなる。

```
screen.drawMap(x, y, zoom)
```

Set the colors used for rendering the map. Values range from 0 - 255, alpha is optional. These colors do not apply to the moon map.  
地図を描画する際に使われる色を指定する。色の指定方法はアルファ値（透明度）を省略できる点も含めてscreen.setColor(r,g,b,a)と同じ。これらの色は月面マップには適用されない。

```
screen.setMapColorOcean(r, g, b, a) --海
screen.setMapColorShallows(r, g, b, a) --浅瀬
screen.setMapColorLand(r, g, b, a) --陸地
screen.setMapColorGrass(r, g, b, a) --草地
screen.setMapColorSand(r, g, b, a) --砂浜
screen.setMapColorSnow(r, g, b, a) --雪や氷
screen.setMapColorRock(r, g, b, a) --岩
screen.setMapColorGravel(r, g, b, a) --砂利
```

※それぞれの地形名は電子辞書で調べたまま表記しているため、実際にどこがどのような色になるかはゲームで試すことをおすすめします。

Get the width/height of the screen currently being rendered to.  
現在描画している画面の幅と高さを取得する。

```
screen.getWidth()
screen.getHeight()
```

### MAP (マップ)

Convert pixel coordinates into world coordinates.  
ピクセル座標を世界座標に変換します。

```
worldX, worldY = map.screenToMap(mapX, mapY, zoom, screenW, screenH, pixelX, pixelY)
```

Convert world coordinates into pixel coordinates.  
世界座標をピクセル座標に変換します。

```
pixelX, pixelY = map.mapToScreen(mapX, mapY, zoom, screenW, screenH, worldX, worldY)
```

#### MAP API 詳細説明

世界座標とピクセル座標を変換するには、

- どの程度の解像度のモニタに
- どの座標を中心にどの程度の範囲が描画されているか

といった情報が必要になります。*screenToMap*及び*mapToScreen*の第一～第五引数はそれらのための引数です。第六～第七引数が、変換する世界orピクセル座標になります。

- どの程度の解像度のモニタに

これは*screen.getWidth*及び*screen.getHeight*が使えます

- どの座標を中心にどの程度の範囲が描画されているか

これはマップを描画する際*screen.drawMap*に渡した引数です。

コード例としては以下のようになります。

```
function onTick()
  Width = input.getNumber(1) -- モニタのコンポジット出力の値
  Height = input.getNumber(2) -- モニタのコンポジット出力の値
  PosX = input.getNumber(7) -- GPS sensor などのからの世界座標
  PosY = input.getNumber(8) -- GPS sensor などのからの世界座標
end
function onDraw()
  local Zoom = 5 -- 横方向に5km表示する
  screen.drawMap(PosX, PosY, Zoom)
  local screenX, screenY = map.mapToScreen(PosX, PosY, Zoom, Width, Height, PosX, PosY) -- drawMap と同じ値を渡す
  local mapX, mapY= map.screenToMap(PosX, PosY, Zoom, Width, Height, screenX, screenY) -- drawMap と同じ値を渡す
end
```

描画しているマップとは異なる状態での変換が行いたいことはあまりないので、以下のようなラップ関数を用意しておくと便利です。

```
function drawMap(x, y, zoom)
  screen.drawMap(x, y, zoom)
  X, Y, Z = x, y, zoom
end
function m2s(x, y)
  return map.mapToScreen(X, Y, Z, screen.getWidth(), screen.getHeight(), x, y)
end
function s2m(x, y)
  return map.screenToMap(X, Y, Z, screen.getWidth(), screen.getHeight(), x, y)
end
```

※ピクセル座標系は原点(0, 0)がモニタ左上、モニタ左下ではない。よってy軸はモニタ下方向に向かう、世界座標とはy軸の方向が反対なので注意。

複数モニタの場合

前述のコードは殆どの場合問題なく動作しますが、Lua回路を含むマイコンのvideo出力を複数のモニタに送信している場合、正しく動かない可能性があります。  
何故なら*onDraw*関数が呼ばれるのはモニタが描写を必要としたタイミングであり、モニタの数だけ増えるからです。  
端的に言えば*onDraw*関数の中からグローバル変数への代入は、厳密には行うべきではありません。  
複数モニタの場合を考慮しグローバル変数*X, Y, Z*への代入を取り除いた一例です。

```
function drawMap(x, y, z)
  screen.drawMap(x, y, z)
  return { x = x, y = y, z = z }
end
function m2s(x, y, mapState)
  return map.mapToScreen(mapState.x, mapState.y, mapState.z, screen.getWidth(), screen.getHeight(), x, y)
end
function s2m(x, y, mapState)
  return map.screenToMap(mapState.x, mapState.y, mapState.z, screen.getWidth(), screen.getHeight(), x, y)
end
function onDraw()
  local mapState = drawMap(someX, someY, someZoom)
  m2s(somePosX, somePosY, mapState)
  s2m(somePosX, somePosY, mapState)
end
```

*onTick*関数側で座標変換したくなった…？諦めましょう！

### TOUCHSCREEN DATA (タッチスクリーンデータ)

英語原文

> The composite output from the monitors contains data that can be interpreted in your script to create touchscreens. The layout of the composite data is as follows:
>
> Number Channels  
> 1: monitorResolutionX  
> 2: monitorResolutionY  
> 3: input1X  
> 4: input1Y  
> 5: input2X  
> 6: input2Y
>
> On/Off Channels:  
> 1: islnput1Pressed  
> 2: islnput2Pressed
>
> This is an example of a script that outputs a signal on composite channel 1 if the player is pressing the screen within a specific rectangle:

モニターからのコンポジット出力には、スクリプトでタッチスクリーンを作ることができるデータが含まれている。そのレイアウトは以下の通りである:

数値チャンネル:  
1: モニターのXの解像度(幅)  
2: モニターのYの解像度(高さ)  
3: 1つ目のタッチ座標 X  
4: 1つ目のタッチ座標 Y  
5: 2つ目のタッチ座標 X  
6: 2つ目のタッチ座標 Y

ON/OFFチャンネル:  
1: 1つ目がタッチされているか(ONでタッチ中)  
2: 2つ目がタッチされているか(ONでタッチ中)

※画面のタッチは[e]と[q]どちらのキーでも可能だが、どちらかのキーでタッチ中にもう一方のキーでタッチするとふたつ目の入力が使われる。  
またタッチした位置はタッチ時点で固定され、スライドすることはできない。

以下はプレイヤーが指定した四角形の中をタッチした場合に、コンポジット出力のON/OFFチャンネル1をONにするスクリプトの例である:

```
function onTick()
    -- Read the touchscreen data from the script's composite input
    inputX = input.getNumber(3)
    inputY = input.getNumber(4)
    isPressed = input.getBool(1)
    -- Check if the player is pressing the rectangle at (10, 10) with width and height of 20px
    isPressingRectangle = isPressed and isPointInRectangle(inputX, inputY, 10, 10, 20, 20)
    -- Set the composite output, on/off channel 1
    output.setBool(1, isPressingRectangle)
end
```

```
-- Returns true if the point (x, y) is inside the rectangle at (rectX, rectY) with width rectW and height rectH
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
    return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
```

```
function onDraw()
    -- Draw a rectangle that fills in when the player is pressing it
    if isPressingRectangle then
        screen.drawRectF(10, 10, 20, 20)
    else
        screen.drawRect(10, 10, 20, 20)
    end
end
```

### LUA FUNCTIONS (Lua関数)

英語原文

> The following global lua functions are available:
>
> - pairs
>
> - ipairs
>
> - next
>
> - tostring
>
> - tonumber
>
> and additional functions are available through the following lua libraries:
>
> - math
>
> - table
>
> - string
>
> For full documentation of the functions provided by these libraries, visit <https://www.lua.org/manual> .

以下に示すLuaのグローバル関数が利用可能:

- [pairs](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-pairs)
- [ipairs](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-ipairs)
- [next](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-next)
- [tostring](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-tostring)
- [tonumber](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-tonumber)
- [type](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-type)\*1

また、Luaライブラリを介して以下の関数群も利用可能:

- [math](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#6.7)
- [table](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#6.6)
- [string](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#6.4)

これらの関数に関する詳細はマニュアル([公式](https://www.lua.org/manual/5.3/)/[日本語(非公式)](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html))を参照すること。

### HTTP (HTTPアクセス)

英語原文

> The following global async functions are available:
>
> - httpGet
>
> HTTP requests are sent to the localhost on the specified port. Responses are caught with the httpReply(port, request\_body, response\_body) callback function.
>
> async.httpGet(port, request\_body)
>
> Example of a HTTP request sent to port 80:
>
> ```
> -- a function to send a simple http request to port 80 with some body parameters (body must start with a /)
> async.httpGet(80, "/set_light_mode?index=1&mode=3")
> -- This callback function automatically triggers when a reply is recieved for a http request
> function httpReply(port, request_body, response_body)
> end
> ```

以下の関数を用いることにより、Luaスクリプトから、localhost上のHTTPサーバに対してリクエストを送信することができます。

```
async.httpGet(port, url)
```

portが接続先のポート番号、urlが接続先のurlです。urlは/(スラッシュ)から始まらなくてはなりません。例えばurlに"/hoge.html"を指定した場合、"<http://localhost/hoge.html>"へのリクエストが送信されます。  
async.httpGet関数は、1tickにつき1回しか呼び出すことができず、2回以上呼び出された場合には、2回目以降の呼び出しは順にキューに溜まっていきます\*2。

HTTPサーバからの返答があった場合、以下の引数を持つ"httpReply"という名称の関数が呼び出されます。

```
function httpReply(port, request_body, response_body)
end
```

関数の引数は1つ目から順に

- 返答を返したHTTPサーバのポート番号(すなわち、httpGet関数の"port"に指定した数値)
- HTTPリクエスト(すなわち、返答に対応するhttpGet関数の"url"に指定した文字列)\*3
- HTTPサーバからのレスポンス(文字列型)  
  となります。

### META FROM THE DEVS (開発者からのメタ)

英語原文

> This scripting API is very powerful and as such there are some important reminders to take note of:
>
> - Your script has a max execution time of 1000 milliseconds, however it is still possible to create scripts that significantly slow down the game. It is your responsibility to ensure your script runs efficiently.
>
> - Random number functions are provided by the Lua math library. Use of randomness in your scripts is likely to cause desync in multiplayer, so use these functions at your own risk.
>
> - When your vehicle despawns and respawns, your script will be executed 'fresh' and any state stored within the script will be lost. We recommend keeping your script as stateless as possible, and making use of existing logic components (e.g. memory register) to store values that you wish to persist.
>
> - Your scripts run as a 'black box' with only the logic inputs/outputs being synced in multiplayer. Keep in mind that complex logic in your script may behave differently for different players in a multiplayer session.
>
> - A number of safeguards are in place to sandbox your script, however it is still possible to write scripts that will potentially crash your game. If you crash your game with a script, it's likely that you're doing something (very) wrong. This is your own responsibility. If you suspect you have encountered a legitimate bug, please report it on the Stormworks issue tracker (accessible from the pause-menu).
>
> - Malicious and harmful scripts will not be tolerated on the Stormworks Steam Workshop.
>
> Finally, enjoy the almost limitless possibilities that these scripts provide. This short wiki aims to give a good overview of how scripting in  
> Stormworks works, however if you have any questions that are not covered here, please feel free to join us on Discord (accessible from the  
> pause-menu)!

このスクリプトAPIは非常に強力であるため、重要な注意事項がいくつかあります：

- スクリプトの最大実行時間は1000ミリ秒ですが、ゲームを大幅に遅くするスクリプトも作り得ます。スクリプトが効率的に動作するようにするのは、各自の責任で行ってください。

- 乱数関数はLua mathライブラリで提供されています。スクリプトで乱数を使用してもマルチプレイで同期しない可能性があります。これらの機能は自己責任で使用してください。

- ビークルをデスポーンのちリスポーンすると、スクリプトは新しく実行しなおされ、スクリプト内に保存されていた状態はすべて失われます。スクリプトを可能な限りステートレス\*4に保ち、持続してほしい値を保持するのには既存の論理回路（メモリレジスタなど）を使用するのがおすすめです。

- スクリプトは「ブラックボックス」として実行され、マルチプレイではロジックの入出力のみが同期されます。スクリプト内の複雑なロジックはマルチプレイセッションにおいてプレイヤー間で異なる動作をする可能性があります。

- スクリプトをサンドボックス環境に適用するにあたっては多くの安全策が講じられていますが、ゲームをクラッシュさせるスクリプトになることもあり得ます。もしスクリプトでゲームをクラッシュさせた場合、何か（大きな）間違いをしている可能性があります。これはあなた自身の責任です。もしゲーム由来のバグに遭遇したのであればStormworks issue tracker（ESCキーメニューからアクセス可能）に報告してください。

- 悪意のある有害なスクリプトはStormworksのワークショップでは許容されません。

最後になりますが、これらのスクリプトが提供する無限の可能性をお楽しみください。この短いwikiはStormworksでのスクリプトの動作の概要を説明することを目的としています。この概要でカバーできない質問があれば、お気軽にDiscord（ESCキーメニューからアクセス可能）にご参加ください！

### 隠しAPI(?)

公式の英語アナウンスには記載がありませんが、以下のAPIにより、デバッグログを出力することができるようです。

```
debug.log(str)
```

出力はWindows標準のデバッグ出力に流れるので、[DebugView](https://docs.microsoft.com/ja-jp/sysinternals/downloads/debugview)(Microsoft謹製)等のデバッグツールを  
通じてキャプチャーし、表示したり、ファイルへ保存したりできます。  
モデルから外部にデータを出力する方法として、上記のasync.httpGetとどちらが便利かは微妙ですが…
