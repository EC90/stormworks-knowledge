---
wiki: sbarjp
page: Luaスクリプト/Lua初心者講座
source_url: https://wikiwiki.jp/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7
last_modified: 2023-10-17
retrieved_at: 2026-08-31T01:12:30+0800
---

# Luaスクリプト/Lua初心者講座

|  |
| --- |
| - [はじめに](#y8b800fc) - [基礎編：関数](#nf229d4e)    - [onTick関数とonDraw関数](#zeb3f988)      - [onTick関数](#d067008b)     - [onDraw関数](#z9f36d48)   - [Luaの標準関数](#p5780b5d)      - [フォーマット（書式）指定子](#n0c7b01f)   - [ここまででの注意点](#x864300f) - [基礎編：変数と値](#e9855aeb)    - [変数名のルール](#l0b5592b)   - [値(value)の種類](#nc972acc)   - [スコープ](#lf527903)      - [ローカル変数](#g1e51fcf)     - [グローバル変数](#p2a2c509)     - [ローカル変数の使いどころ](#o736e74b)   - [算術演算子](#h8927658)   - [ここまででの注意点](#lffb20ec) - [基礎編：制御構文](#r6fb92f8)    - [分岐処理(if/goto)](#xe5d8b6e)      - [関係演算子](#g98ce252)     - [論理演算子](#wee15d25)     - [演算子の優先順位](#d06fc835)     - [擬似的な三項演算子](#p5ed762b)     - [取扱注意のgoto文](#j030e625)   - [繰り返し処理(for/while/repeat)](#vb8af1e8)      - [for文](#x5c3f9c7)     - [while文](#u3cb772d)     - [repeat文](#vbcbaa33)     - [break文によるループ処理の脱出](#x2966e6b)     - [多重ループ](#l7ef8e4c) - [実践編（基礎）：スクリプトを書いてみよう](#u22369b8)    - [onTick関数編](#bf59148d)      - [計算処理をしてみよう](#z3ffd943)     - [条件分岐でライトを光らせよう](#ece2b4ee)   - [onDraw関数編](#nb0d1837)      - [スクリーン座標系](#ad40ab0f)     - [図形や文字を描画してみよう](#jd42a8f7)     - [エラー画面を知ろう](#jaa66bca)   - [onTick・onDraw関数編](#dde07426)      - [取り込んだ数値をスクリーンに表示させてみよう](#y642739e)     - [ON/OFF信号で表示/非表示を切り替えてみよう](#hcc28dac)     - [複数ページを切り替えてみよう](#b6908be6) - [発展編：関数定義（関数を自作する）](#hb6711ec)    - [関数定義の基本形](#ff3a1cd8)   - [タッチスクリーン座標を調べる自作関数](#oc01f96e) - [発展編：テーブル型](#xbec8213)    - [配列変数としてのテーブル](#t75c56d6)   - [連想配列としてのテーブル](#r549145d)   - [多次元配列（入れ子配列）](#s138b6ea)      - [配列変数の多次元配列](#w3b6f7f7)     - [連想配列の多次元配列](#wf6174a4)   - [長さ演算子](#l35c36af)   - [ここまででの注意点](#mbae2b20) - [発展編：テーブル操作](#k34b730c)    - [インデックスを指定して値を代入する](#n89c1a26)   - [要素を挿入/削除する](#m14b109e)      - [table.insert関数で要素を挿入する](#w3ce8363)     - [table.remove関数で要素を削除する](#ldf8b206)     - [要素の挿入/削除を利用した具体例](#e5e97ee5)   - [イテレータによる繰り返し処理の抽象化](#o9bd9f40) - [番外編：スクリプトの可読性・保守性](#b8ed5e54)    - [コメントを書こう](#y8dc939c)   - [改行・スペース・インデントを入れよう](#j70271b0)   - [マジックナンバーはやめよう](#h7fc622f) |

## はじめに

ここへ来たということはやる気があって来たのだと思います。その気持ちを折らないまでも心の中に留めておいてほしいことがあります。  
一応断りをいれておくと**Luaがあればすごいものができる**と思いがちですが**Luaでできることは論理回路でもできる**という場合が多いです（簡単かどうかは別として）。  
唯一Luaにしかできないのは「LCD（ディスプレイやHUD）に描画情報を出力する」ということだけです\*1。  
また、Luaで繰り返しの処理が多くなればなるほど処理が重たくなることもあります。本当にLuaでやる必要があるのかよく考えてから作りましょう。

## 基礎編：関数

Luaスクリプトブロックを開くとデフォルトで以下のようなコードが書かれている。

```
-- Tick function that will be executed every logic tick
function onTick()
	value = input.getNumber(1)			-- Read the first number from the script's composite input
	output.setNumber(1, value * 10)		-- Write a number to the script's composite output
end
-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				-- Get the screen's width and height
	h = screen.getHeight()
	screen.setColor(0, 255, 0)			-- Set draw color to green
	screen.drawCircleF(w / 2, h / 2, 30)		-- Draw a 30px radius circle in the center of the screen
end
```

--から右側の英文はその部分がなんの役割かを説明しているコメント文である。

英文ほぼそのままの意味だが、日本語で書いてしまうとこの通り。

```
-- 以下は論理tickごとに実行されるtick関数です
function onTick()
	value = input.getNumber(1)			-- コンポジット入力の1番から数値を読み取ってvalueという変数に代入します
	output.setNumber(1, value * 10)		-- コンポジット出力の1番に、変数valueに10を掛けたものを出力します
end
-- 以下はスクリーンに描画処理を行うにあたって実行されるdraw関数です
function onDraw()
	w = screen.getWidth()				-- スクリーンの幅と高さを取得して、それぞれw,hという変数に代入します
	h = screen.getHeight()
	screen.setColor(0, 255, 0)			-- 描画色を緑に指定します
	screen.drawCircleF(w / 2, h / 2, 30)		-- スクリーンの中心に半径30pxの円を描画します
end
```

ここで注目してほしいのが**onTick()**や**onDraw()**の部分だ。  
これがスクリプトのメインとなる部分でmain関数と思ってよい。  
function onTick()～endまでがonTick関数の中身、function onDraw()～endまでがonDraw関数の中身である。

関数は常にfunction ﾎﾆｬﾗﾗ()からendまでがワンセットとなる。  
何を言ってるかサッパリ分からないと思うがとりあえずこの中にコードを書くと思ってもらえればいい。

### onTick関数とonDraw関数

#### onTick関数

onTick関数では主にコンポジット入力の読込・出力や数値の計算などを行うことを公式は推奨している。  
tick（ティック）というのは処理周期のことで、Stormworksにおいては「1tick＝1/60秒」と説明されることが多い。注釈を要確認\*2。  
**1tick経過するごとにもれなく呼び出される関数**、それがonTick関数だ。

```
function onTick()
	○○○○
end
```

上記の〇〇〇〇にコードを書く。例えば〇〇〇〇の箇所に

```
value = input.getNumber(1)
```

と書くと「valueという変数（箱のようなモノ）にコンポジット入力のnumber（数値）の1番目の値が代入される」という意味になる。  
これで60分の1秒毎に、valueにコンポジット入力1番の値が入力されるようになる。

#### onDraw関数

onDraw関数はスクリーンになにか描画するときに使用する。

```
function onDraw()
	○○○○
end
```

onTickのときと同じように〇〇〇〇の箇所にコードを書く。例えば

```
w = screen.getWidth()
h = screen.getHeight()
```

と書けば「w」に接続されているスクリーンの幅が、「h」にスクリーンの高さが代入される。  
これはStormworksだけで使用できるAPI\*3にscreenというグループがあり、  
その中のgetWidth,getHeight関数を呼び出してスクリーンのサイズを取得し、w,hに値として返している。  
次に

```
screen.setColor(0, 255, 0)
screen.drawCircleF(w / 2, h / 2, 30)
```

と書けば**緑色**の半径30ピクセルの塗りつぶされた円がスクリーンのど真ん中に表示される。  
setColor関数はRGB値を指定しており**(0, 255, 0)**の部分がそれぞれの色に相当する。RGB値は0～255の範囲で入力できる。  
drawCircleF関数はw÷2、h÷2した座標（つまりスクリーンの中心）に半径30ピクセルの塗りつぶし円を描画する、という意味合いである。

### Luaの標準関数

前述の話はあくまでStormworks用の関数についての説明であり、その他の様々な処理をするために**Luaに標準で実装されている関数**がある。  
Luaエディタのヘルプタブを見てみると以下の関数が使えると書いてある。（日本語訳）

> 以下に示すLuaのグローバル関数が利用可能:
>
> - [pairs](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-pairs)
> - [ipairs](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-ipairs)
> - [next](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-next)
> - [tostring](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-tostring)
> - [tonumber](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-tonumber)

> また、Luaライブラリを介して以下の関数群も利用可能:
>
> - [math](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#6.7)
> - [table](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#6.6)
> - [string](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#6.4)

これらに加えて[type関数](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-type)というものも使えるが、そうそう使う機会はないので覚えなくてもいい。

math、table、stringあたりはおそらくよく使うことになる。

- **math関数**  
  三角関数、円周率、平方根、乱数など、あらゆる計算にmath関数を使う。

- **table関数**  
  テーブルの操作に必要。テーブルというのはデータを格納できる機能であり、別途解説する。

- **string関数**  
  なかでもstring.formatはディスプレイに数値を表示させるときに数値の書式を整えるのに使う。

#### フォーマット（書式）指定子

string.formatで文字の書式を指定する際に使うフォーマット指定子の一覧。

| **指定子** | **概要** | **詳細** |
| --- | --- | --- |
| %c | 1文字出力 | 整数表現が可能なnumber型を渡すとASCIIコードに対応した文字列が1文字だけ出力される。2文字以上は不可。 |
| %s | 文字列出力 | 値（number、boolean、nilなど）を文字列として出力する。 nilの変数なら「NIL」と表示されたり、「true and false」なら「FALSE」と表示されたりする。 |
| %q | 文字列出力 | %sとほぼ同じ。描画上でも文字列にダブルクォーテーションが表示されるなどの違いがある。 Luaインタプリタ\*4が安全に扱える適切な形式に書式化する（らしい）。 |
| %d, %i | 10進法整数 | 整数を10進数として出力する。整数表現にできない値はエラーになる。 |
| %f | 10進法実数 | 実数を10進数として出力する。小数点以下の桁数はデフォルトでは6。 |
| %e | 指数表記実数 | 実数を指数表記付きの10進数として出力する。 指数表記はE表記とも呼ばれるもので、E±[10進数の指数部]で「10の〇乗」を表す。 |
| %g | %fまたは%e | 実数を10進数または指数表記付き10進数として出力する。 |
| %u | 10進法符号なし整数 | 整数を10進数の符号なし整数として出力する。整数表現にできない値はエラーになる。 負の数を表現できない代わりに、64bit符号なしで表現できる限界の18446744073709551615（約1,845京）まで扱える。 符号あり整数の最大値である9223372036854775807を超える数は、-9223372036854775808～-1で入力する必要がある。 |
| %o | 8進法整数 | 整数を8進数として出力する。整数表現にできない値はエラーになる。 |
| %x | 16進法整数 | 整数を16進数として出力する。整数表現にできない値はエラーになる。 |
| %a | 16進法実数 | 実数を16進数として出力する。整数で表現できない値にも対応できる。 [-]0x[16進数の仮数部]P±[10進数の指数部]という形になる。P±[10進数の指数部]で「2の〇乗」を表す。 |

以下はフォーマット指定子と併せて使うフラグ指定子の一覧。数の表示に関する細かい指定ができる。

| **指定子** | **概要** | **詳細** |
| --- | --- | --- |
| - | 左詰め | デフォルトでは右詰めとなっている。桁数指定の前に-（マイナス）を付けると左詰めにできる。 |
| + | 符号表示 | 正の数のとき+（プラス）を表示させる。左詰めと併用する場合は並べて書く（順不同）。 |
| 0 | ゼロフィル | フィールド幅に合わせてゼロ埋めされる。左詰めとの併用はできず、両方書くとゼロフィルは無視される。 |

### ここまででの注意点

screen.getWidth()やscreen.getHeight()といったscreenで始まる関数はあくまでonDraw関数の中でしか使えない。  
逆にinput.getNumber()やoutput.setNumber()といったinput、outputで始まる関数はonTick関数の中でしか使えない。  
  
  
上でちらっと書いたが、onTick関数では1/60秒ごとに処理が実行されるということも覚えておいていただきたい。  
何を言ってるかまだサッパリだと思うので気にせず次へ読み進んで、またあとでここを読んでもらっても構わない。

例えば下記のようなコードを書いた場合

```
x = 0
function onTick()
	x = x + 1
end
```

下図のような処理が行われていると考えればよい。  
![ontick.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/ontick.png?rev=7dacc690fa2034338308497f2e1b25a2&t=20190710211615 "ontick.png")  
このプログラムが開始するとxという変数が作成され、その後は1/60秒のうちにxに1を加えた数で変数xを上書きしたあとで、onTick関数の頭に戻ってまた同じ処理を繰り返していく。  
これを値に読み替えると1週目ではx=0+1、2週目ではx=1+1、3週目ではx=2+1となっているのである。

## 基礎編：変数と値

変数とは色々なモノ（データ）を入れておくための箱である。  
先ほどvalueと書いたと思うがアレはvalueという名前の箱だし、wも箱、hも箱、xも箱である。  
とにかく何も考えずにアルファベットを並べ立てればそれはもう変数だ。  
例えば

```
x = 1.0
function onTick()
	output.setNumber(1, x)
end
```

と書けばLuaスクリプトの開始時にxという箱の中に1.0という値が入れられる。**この「x」こそが変数である。**  
次のoutput.setNumber(1,x)と書いた部分でコンポジット出力の1番目にx、すなわち1.0を出力する。  
xは最初に1.0と定義しているので、あとからonTick関数内でx=2とかx=yといった形で上書きしない限りはずっと1.0を保持する。

### 変数名のルール

「何も考えずにアルファベットを並べ立てればそれはもう変数だ」と書いたが、いくつか注意点がある。  
これらのルールを守りながら変数名を決めよう。

**１．予約語は変数には使えない**  
「これはあとで使うので予約しておきますね」と事前に設定されたキーワードを**予約語**という。  
以下はLuaの予約語なので変数として使うことができない。

```
and       break     do        else      elseif    end
false     for       function  goto      if        in
local     nil       not       or        repeat    return
then      true      until     while
```

実際に入力してみると文字が赤くなるのですぐわかる。\*5

**２．変数の頭は英字か'\_（アンダースコア）'でなければならない**  
「hogehoge1」はOK。「\_hogehoge」もOK\*6。「1hogehoge」はダメ。

**３．大文字と小文字は区別される**  
たとえばHOGEHOGEとhogehogeはつづりは同じだがそれぞれ別の変数として扱われる。  
予約語のandなんかをAndとかANDとか書いてしまえば、一応それらも変数として宣言できてしまう。  
（あくまで変数の性質をわかってもらうための例であり、ややこしくなるのでそういう変数は使ってはいけない…。）

**cf．変数の命名には作法がある**  
詳しい説明はしないが、興味のある人は「変数　命名規則」などで調べてみよう。  
自分で見返したり、他人が見たりしても意味を把握しやすい変数名の決め方を知っておくと、コードの読みやすさがグッと上がる。

### 値(value)の種類

変数とは色々なモノ（データ）を入れておくための箱である。先ほどもそう書いた。  
では箱の中には何を入れられるのか？答えは**値**なのだが、値にもいくつか種類がある。  
表にまとめると以下のようになる。

| 変数の値 | つまり | 説明 |
| --- | --- | --- |
| number | 数値 | 1.0でも1でも、とにかく数値ならnumber。ロジックの緑入出力もnumberである。 |
| boolean | 真偽 | trueもしくはfalseのこと。ロジックの赤入出力もこれ。 |
| string | 文字列 | ダブルクォーテーション二つで囲んだものは文字列（text）として扱われる。\*7 エスケープシーケンス\*8として\（バックスラッシュ）を使用し特殊な入力ができる。\*9 |
| function | 関数 | 自ら作った関数を変数に入れることも可能。 |
| table | テーブル | 数値や真偽や文字列などを分類ごとに入れたり、配列や行列を作ったりできる。 難しいので今はテーブルというものがあるよ、という認識でいい。 |
| nil | NIL | 値がない、ということを表す。しかし0ではないしnumberでもない。算術演算もできない。 真偽においてはfalse扱いされる。真偽の仲間と考えるべきか。 |

例えばonTick中に

```
x
```

と書けばxという変数が生成され、xにはnilという値が入れられる（強制的）。有効な値を入れてない変数はすべてnilである。

```
x = 1
```

と書けばxには1という値が入る。

```
x = false
y = true
z = x and y
```

と書くとxは偽、yは真、zはxとyのand（論理積）であるからzにはfalseが入っていることになる。

### スコープ

後述するfor文のfor～end、関数定義のfunction～endなどのようなコードのまとまりをブロックという。  
ブロック中に変数を宣言する際、変数の種類を**グローバル変数**と**ローカル変数**の2つから選ぶことができる。

それぞれの特徴は以下のとおりである。

グローバル変数の特徴
:   - 基本的にどこからでもアクセスできる
    - 相対的にアクセスが遅くなる（ゲーム遅延の原因になる）
    - 文字数は圧迫しないがメモリに優しくない ![(--;](https://cdn.wikiwiki.jp/to/w/common/image/face/sad.png?v=4)

ローカル変数の特徴
:   - グローバル変数と比較して高速で読み込める（らしい）
    - 自動的に消えるのでメモリを圧迫しにくい（ガベージコレクタ機能）
    - 代わりに文字数を圧迫する ![(..;](https://cdn.wikiwiki.jp/to/w/common/image/face/oh.png?v=4)
    - ブロックの中にあるローカル変数はブロック外からアクセスすることはできない

スコープというのは**変数の有効範囲**のことである。  
たとえばonTick関数の枠組みで宣言したローカル変数は、onDraw関数からは参照できない。  
あるいはonTick関数の中にあるブロックの中でローカル変数として宣言したものは、たとえ同じonTick関数の中であってもそのブロックより外から参照できない。

#### ローカル変数

変数の頭にlocalと付けられた変数はローカル変数となる。

```
local a=1	--これはローカル変数aとなる
```

#### グローバル変数

何も書かずに変数を作った場合は例外なくグローバル変数となる。

```
a=1		--これはグローバル変数aとなる
```

#### ローカル変数の使いどころ

高速になるならばなんでもローカル変数として宣言しておけばいいと思ってしまうが、  
メモリを圧迫してほしくないような変数に対して使えばガベージコレクタでほんのり軽くなる、というものらしい。  
体感ではわからないレベルなので勝手がわからないうちは全部グローバル変数でまったく問題ない。

ちなみにローカル、グローバル問わず複数の変数への代入を一気に行うこともできるのだが

```
local a,b,c = 1,20,100
```

このように書けばa=1、b=20、c=100をローカル変数として一気に宣言したことになる。  
変数ひとつごとに毎回localと書かなくてよくなるので文字数を節約できる。

### 算術演算子

もう既にチラホラ書いてしまっているがnumber型の値には下記のような算術記号が使える。

```
+: 加算
-: 減算
*: 乗算
/: 浮動小数点数除算
//: 切り捨て除算
%: 剰余（割り算の余り）
^: 累乗
-: 単項マイナス
```

これらの算術演算子はあくまでnumber型の値\*10が入っている変数でしか使えない。  
なので

```
a = true
```

と書いた後で

```
a = -a
```

と書いてもfalseが出てきたりはしない。出るのはエラーだけである。

### ここまででの注意点

もしC言語など他言語を齧ったことのある人ならここで首を傾げているところだろう。筆者も最初に首を傾げた。

```
int x;
x = 1;
```

といったように、C言語ならint型やfloot型といった変数の型を宣言するのが一般的だろう。  
だがLuaに型の宣言は存在しない。しかし型が存在しないのではなく、値自身が型をもつのである。

```
a = 1		--これはnumber型
b = true	--これはboolean型
c = "test"	--これはstring型
d = 3.14	--これもnumber型
e		--これはnil
```

上記のような判断がされていると思ってくれればいい。

## 基礎編：制御構文

制御構文には条件分岐処理と繰り返し処理がある。  
プログラムは原則上から下に命令をこなすのだが、途中で条件分岐文を書いて条件に一致したときだけ発動するプログラムを組むことができる（if文）。  
他にも条件が真である限り処理を繰り返すfor文や、条件が偽になるまで処理を繰り返すwhile文などがある。

### 分岐処理(if/goto)

Luaでの条件分岐（if文）の書き方は以下のようになる。

```
if 条件式 then
	○○○○
end
```

もし条件式が真ならば〇〇〇〇の処理を実行するという意味だ。条件式の部分は真偽を評価できる形で書かなければならない。

ある変数xがboolean型なら条件式のところはxとだけ書けばよい。

```
if x then
	○○○○
end
```

xがtrue（真）の場合に〇〇〇〇の処理が実行される。

ある変数xがnumber型なら、条件式に**関係演算子**を使って「**『xが1より大きい』は真か偽か**」のように真偽を評価できる形で書く必要がある。

```
if x>1 then
	○○○○
end
```

xが1より大きい場合に〇〇〇〇の処理が実行される。

上記の書き方だと条件式が偽である場合はなにも処理されない。  
「条件式が偽ならこういう処理をしろ」であったり「複数の条件分岐を行え」と書きたい場合、elseやelseifを使おう。

```
if x then
	○○○○
else
	□□□□
end
```

このように書けばxが真のとき○○○○を実行、xが真でないときは□□□□を実行するというふうにxが偽のときにしてほしい処理を書ける。

```
if x then
	○○○○
elseif y then
	△△△△
else
	××××
end
```

これはxが真のとき〇〇〇〇を実行、yが真のとき△△△△を実行、それら以外のとき××××を実行となる。  
elseifを増やしていけばさらに複数の条件分岐をすることもできる。  
ちなみに条件式は上から評価されるので、xとyが両方とも真であっても実行されるのはxの真に対応した○○○○の処理だけだ。

#### 関係演算子

条件式にnumber型を用いるときは以下の演算子を使う。  
変数宣言の=（イコール）と関係演算子の==（等しい）は別物なので気をつけよう。

```
==: 等しい
~=: 等しくない
<: より小さい
>: より大きい
<=: 小さいまたは等しい
>=: 大きいまたは等しい
```

#### 論理演算子

論理回路でもよく使う論理積、論理和、論理否定。

```
and: 左項と右項が真のとき真を返す
or: 左項または右項が真のとき真を返す
not: 真(偽)のとき偽(真)を返す
```

#### 演算子の優先順位

演算子には優先順位が設定されている。

|  |
| --- |
| ↑優先順位高い 　　^ 　　not　　-（単項マイナス） 　　\*　　/　　//　　% 　　+　　-（減算） 　　<　　>　　<=　　>=　　~=　　==　　 　　and 　　or ↓優先順位低い |

表に含まれているのは算術演算子、関係演算子、論理演算子。  
まだ出てきてないので省略したが、このほかにビット演算子、文字連結演算子、長さ演算子がある。

#### 擬似的な三項演算子

三項演算子とは条件分岐処理のための演算子のこと。if文を一文で表現できる。  
Luaにはそれ用の「演算子」は用意されていないが、論理演算子を使った慣用表現がある。

```
a = x and ○○○○ or □□□□
```

と書けば、xが真のときaには○○○○が、偽のときはaには□□□□が代入される。  
これをif文で書くと次のようになる。

```
if x then
	a = ○○○○
else
	a = □□□□
end
```

ただし〇〇〇〇がfalseの場合は使えないので注意。

#### 取扱注意のgoto文

**このパートは読まなくてもいいし、できれば読んだ後に忘れてほしい。**  
というのもgoto文はすごく嫌われ者の構文なのだ。

goto文は「gotoを実行したところから、自分で設定した"ラベル"の箇所まで処理をジャンプさせる」というもの。  
勘のいい人なら嫌われている意味がなんとなくわかったと思う。  
そう、「**構造化されたプログラミングを無視して好きなところにジャンプできるなんてけしからん！**」という批判が多いのだ。

例えばこんなコードがあったら…

```
if x then
	goto hogehoge
end
if y then
  	○○○○
end
::hogehoge::
```

gotoが実行されると最後の二重の::（コロン）で囲んだhogehogeというラベルにジャンプしてif y then～の処理は無視される。

Luaにはないけれど他言語ではcontinue文といってcontinue以降の処理をスキップしてループの先頭に戻る構文があるのでその代用として使ったり、  
Luaにおいては二重for文などの多重ループを一発で脱出する「大域脱出」というテクニックに使えたりと、まったく使い道がないわけではない。\*11  
しかしながら処理の流れを断ち切ってしまうというその特性はコードの可読性を大いに損ねてしまうので、使ってはならないのである。

### 繰り返し処理(for/while/repeat)

ふつう、スクリプト中に「ある処理」を書いたらその書いた分しか処理は行われない。  
例えば指定した2つの座標間に線を引くscreen.drawLine(x1,y1,x2,y2)という関数を書いたら書いた分だけが実行される。

ここでいう繰り返し処理とは、「ある処理」について指定した条件を満たすまで繰り返した**“結果”**を即座に反映させるような処理のことである。  
onTick関数における「tickごとに処理を繰り返す」の「繰り返し」と混同しないようにしよう。

[![20210112232858-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210112232858-min.png.webp?rev=1fd4b47504df9fa383242ece85c675fb&t=20210112233333 "20210112232858-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210112232858-min.png?rev=1fd4b47504df9fa383242ece85c675fb&t=20210112233333 "20210112232858-min.png") [![20210112232949-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210112232949-min.png.webp?rev=1b77bef12dd05a6a882b974a2b9aad6d&t=20210112233338 "20210112232949-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210112232949-min.png?rev=1b77bef12dd05a6a882b974a2b9aad6d&t=20210112233338 "20210112232949-min.png")  
drawLine関数を1行書いただけのものと、drawLine関数にfor文での繰り返しを適用させたものの比較。

#### for文

for文は決まった回数を繰り返す処理に使う。  
(,増加値)としたところは省略可能。省略したときの増加値は1。

```
for カウンタ変数 = 初期値, 終了値(, 増加値) do
	○○○○
end
```

変数を仮にiとした時、**iを初期値から終了値まで増加値ごとに繰り返す**処理を行う。  
例えば

```
for i = 1, 10 do
	○○○○
end
```

この場合、iが1から10まで1ずつ増加を繰り返す。  
〇〇〇〇の処理に変数iを用いることで、その処理をiの回数の分だけ複数回実行できる。

```
for i = 0, 10, 2 do
	○○○○
end
```

このように増加値を2にした場合、iは0から2ずつ増加していき0,2,4,6,8,10となる。

変数iはfor文に対してローカルであり、そのfor文ブロックの外側から変数iにアクセスすることはできない。  
つまり変数iの繰り返し処理はそのfor文の中だけで行われるので

```
for i = 1, 10 do
	ある処理A
end
for i = 100, 300, 20 do
	ある処理B
end
```

このようにブロックが違えば変数が同じでも別物として処理される。  
考え方にもよるが、見間違い防止の意味を込めて違う変数を使うのが得策か。

なお、PCスペックにもよるだろうが**繰り返し処理の回数を10万回など極端に多くすると処理が重くなる。**  
普通に使う分には問題にならないので、適切に使おう。

#### while文

while文は条件式が真の間、ブロックの処理を繰り返す。

```
while 条件式 do
	繰り返す処理
end
```

while文は**処理を何回繰り返すかがわかっていないもの**に使うとよい。

```
i = 0
while i < x do
	○○○○
	i = i + 1
end
```

このように書くと

```
①iが0からスタートして○○○○の処理を実行する
②iに1を加えた後に条件式i<xを評価する
③i<xが真であればまた○○○○の処理を実行
④iに1を加えた後に条件式i<xを評価する
...
```

この流れを条件評価が真の間（＝偽になるまで）繰り返す。

もう少し具体的な例を見てみよう。drawLine関数でスクリーンに縦線を描画する。  
[![20210113230917-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210113230917-min.png.webp?rev=7f1d1feda7b3cef359a0eb5d2f59c1f3&t=20210113231518 "20210113230917-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210113230917-min.png?rev=7f1d1feda7b3cef359a0eb5d2f59c1f3&t=20210113231518 "20210113230917-min.png")  
これを等間隔で横にズラしていきながら、画面端に達するまで繰り返させたい。

```
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(0, 255, 0)
	i = 0						--iの初期値
	while 5 * i < w do				--5*iが画面幅wより小さい間、以下の処理を実行する
		screen.drawLine(5 * i, 0, 5 * i, h)	--(5*i,0)から(5*i,h)に線を描画する
		i = i + 1				--iに1加算する
	end
end
```

2×2ディスプレイと9×5ディスプレイで同時に実行してみた。どちらも画面の端に達するまで処理が繰り返されている。  
[![20210113231009-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210113231009-min.png.webp?rev=d35e12fb7bf9e2742c3b3dc0afe60dee&t=20210113231523 "20210113231009-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210113231009-min.png?rev=d35e12fb7bf9e2742c3b3dc0afe60dee&t=20210113231523 "20210113231009-min.png")  
**2×2ディスプレイ**の画面幅wは64である。これをもとに条件評価を考えると

```
5 * i < 64
i < 64 / 5
i < 12.8
```

よってiが13になった時点で条件評価がfalseとなりループを脱出した。for文でいうところのiの終了値は12となった。  
2×2のディスプレイでは最初のi=0を含めた計13回、描画が繰り返された。

同様に**9×5ディスプレイ**は画面幅wが288なので

```
5 * i < 288
i < 288 / 5
i < 57.6
```

よってiが58に達した時点で条件評価がfalseとなりループを脱出した。for文でいうところのiの終了値は57となった。  
9×5ディスプレイでは最初のi=0を含めた計58回、描画が繰り返された。

「for文でいうところの」と書いたが、繰り返しの回数がわかっていれば書き換えが可能ということだ。  
2×2ディスプレイなら以下で同じ処理になる。

```
for i = 0, 12 do
...
```

while文の注意点として、条件式は**処理を繰り返した結果どこかしらで偽になってループを脱出できるもの**でないと無限ループに陥りエラーを吐く。  
あるいは意図的に無限ループを作った上で、このあと出てくるbreak文を使ってループの脱出口を用意してやるといった対策が必要。

#### repeat文

repeat文は条件式が偽の場合に処理を繰り返して真でループを終了する。

```
repeat 繰り返す処理
until 条件式
```

repeat文はwhile文に似ており、これも**処理を何回繰り返すかがわかっていないもの**に使うとよい。  
条件評価が文の最後で行われるので、条件式が常に真であっても1度は必ず処理が実行される。

while文のところで出てきた縦線を描画するプログラムをrepeat文で書いてみると次の通り。

```
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(0, 255, 0)
	i=0
	repeat
		screen.drawLine(5 * i, 0, 5 * i, h)
		i = i + 1
	until i * 5 > w
end
```

[![20210114221034-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210114221034-min.png.webp?rev=c9f37e805882a731602165a6d7637051&t=20210114222154 "20210114221034-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210114221034-min.png?rev=c9f37e805882a731602165a6d7637051&t=20210114222154 "20210114221034-min.png")  
画像はwhile文の使いまわしではなく、repeat文で書き換えている。

「i\*5が画面幅wより大きくなるまで」という条件になっているところがポイント。  
これが真になった時にループを終了する。

2×2ディスプレイならばi>12.8なのでiが13になった時点でループを抜ける。

「1度は必ず処理が実行される」ということを確認するため、サンプルコードの条件式を次の通りに変えて実行してみた。

```
until true
```

[![20210114221325-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210114221325-min.png.webp?rev=9d62bf0c558a61a39cf907b26dc18c3d&t=20210114222200 "20210114221325-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210114221325-min.png?rev=9d62bf0c558a61a39cf907b26dc18c3d&t=20210114222200 "20210114221325-min.png")  
1度描画処理を行ってからi=0+1が処理されたものの、条件評価がtrueなのでそのままループ処理は終了となる。

while文と同様に**条件式がいつまでも真にならないと無限ループに陥る**。

#### break文によるループ処理の脱出

break文は各種ループ処理を抜ける命令であり、実行された時点で繰り返し処理は中断される。  
break文はブロックの最後でしか使えない。言い換えるとbreakの直後にendがこないといけない。  
というより、breakとendの間に何か書いても意味がない。

```
while 条件式 do
	繰り返す処理
	if ループを抜ける条件 then
		break
	end
end
```

このようにループを抜けたい位置にif文を使って差し込む。

#### 多重ループ

各種ループ文は入れ子（ネスト）にして多重ループを作ることができる。  
ループ文の中にループ文を書き、最も内側にあるブロック内で複数のループを組み合わせた処理を書く。

```
i = 0
while i < 10 do
	j = 0
	while j < 10 do
		○○○○
		j = j + 1
	end
	i = i + 1
end
```

このとき、外側ループに入ってから内側ループを繰り返し、  
内側ループを抜けたら外側ループを巡回して、また内側ループに入って繰り返し…という流れになっている。  
つまり内側のループは外側ループ1回ごとに最後まで繰り返しを行っている。

ブロック単位で色を付けると下図のようになる。  
[![loopimage-01.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/loopimage-01.png?rev=052ca3785d48eb84105332f854e5761b&t=20210120225022 "loopimage-01.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/loopimage-01.png?rev=052ca3785d48eb84105332f854e5761b&t=20210120225022 "loopimage-01.png")  
if文やfor文などを入れ子にする場合も考え方は同じ。

多重ループを途中でやめる場合はbreak文を使うことになるが、**break文は1つのループしか脱出できない**。  
全部のループを抜けるためにはループの数に応じたbreak文が必要になる。

毎回if文で同じ条件式を設定しなければならない状況においては、**フラグ変数**を作成して他のbreak文を発動させる方法が取られる。  
フラグ（flag）はそのまま「旗」のこと。  
状態のオン/オフを、旗が上がっているか下がっているかに見立ててそのように表現する。

```
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(0, 255, 0)
	for i = 0, 10 do
		for j = 0, 10 do
			screen.drawText(11 * i, 0, i)
			screen.drawText(11 * j, 6, j)
			if j > 5 then
				flag = true	--フラグ変数を作成
				break
			end
		end
		if flag then			--フラグ変数がtrueになったらbreak
			break
		end
	end
end
```

上記コードを実行したのが次の画像。  
[![20210120223112-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210120223112-min.png.webp?rev=8c27f587f2ef76e1349ad4fca132a399&t=20210120224141 "20210120223112-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210120223112-min.png?rev=8c27f587f2ef76e1349ad4fca132a399&t=20210120224141 "20210120223112-min.png")  
j>5で内側のループが終了し、それに伴い外側のループも1回目で強制終了している。  
先ほどの「内側のループは外側ループ1回ごとに最後まで繰り返しを行う」というのはこのことだ。  
外側ループの1回目ではi=0だが、その時の内側のループはbreakが発動するi>5まで繰り返されている。

使ってはいけないと説明したgoto文だが、多重ループの脱出に限っては有用だとする人もいる。  
このあたりは宗教戦争じみてくるので、goto文を使うかどうかは各人の判断に委ねよう。

## 実践編（基礎）：スクリプトを書いてみよう

基礎編の内容はだいたい頭に入ってきただろうか。  
完全に覚えてなくても構わないので、ここからはできれば実際にクラフトしながら読んでほしい。  
各種APIの意味がわからない時は[Luaスクリプト](https://wikiwiki.jp/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88)のページも見てみよう。

### onTick関数編

#### 計算処理をしてみよう

マイコンとデジタルディスプレイ（ダイヤルでも可）を設置する。  
マイコン編集でnumber outputをひとつ作り、計器につないでおく。

[![20210101185241.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210101185241.png.webp?rev=66b5790feca2e49ade25fdbe03d1f9b2&t=20210101231105 "20210101185241.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210101185241.png?rev=66b5790feca2e49ade25fdbe03d1f9b2&t=20210101231105 "20210101185241.png")

[![20210101185247.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210101185247.png.webp?rev=5fd144851b2e9d1f864a85cebffdb7ca&t=20210101231110 "20210101185247.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210101185247.png?rev=5fd144851b2e9d1f864a85cebffdb7ca&t=20210101231110 "20210101185247.png")

マイコンの中身はこんな感じにしておく。  
左側のConstant Numberの2つの数字を計算して出力するプログラムを書いてみよう。  
[![20210101190830.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210101190830.png.webp?rev=6d29fb6bc4893897b3a44a02bf9cf955&t=20210101231116 "20210101190830.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210101190830.png?rev=6d29fb6bc4893897b3a44a02bf9cf955&t=20210101231116 "20210101190830.png")

プログラミングでは処理の内容や手順を言語化するのが大切。  
　**①コンポジット入力を読み込む**  
　**②読み込んだ2つの数字を計算する**  
　**③計算した結果をコンポジット出力する**  
処理の流れを把握したらスクリプトに落とし込もう。

Luaブロックのデフォルトで書かれているコードは全部削除して、まっさらな状態から書いていく。

```
function onTick()
 	--この部分に処理を書いていく
end
```

コードの見やすさのためにインデント（字下げ）を入れていくが、必須ではない。やりたい人は[tab]キーを押すとできる。

**①コンポジット入力を読み込む**  
コンポジット信号にはnumber（数値）とboolean（真偽）の両方が含まれている。  
それらをLuaに取り込むには以下のAPIを使う。

```
input.getNumber(index)	--数値を読み込む
input.getBool(index)		--真偽値を読み込む
```

今回はコンポジットのnumberの1番目、2番目を読み込むので

```
function onTick()
	constantNumber1 = input.getNumber(1)
	constantNumber2 = input.getNumber(2)
end
```

違う書き方もできるけれど、とりあえず変数として宣言してみよう。

**②読み込んだ2つの数字を計算する**  
変数の値はnumber型なので算術演算子が使えるはずだ。  
2つの値を足し合わせて別の変数を作ってみよう。

```
function onTick()
	constantNumber1 = input.getNumber(1)
	constantNumber2 = input.getNumber(2)
	numberSum = constantNumber1 + constantNumber2
end
```

**③計算した結果をコンポジット出力する**  
以下を使えばコンポジット信号としてデータを出力できる。

```
output.setNumber(index, value)	--数値を書きだす
output.setBool(index, value)		--真偽値を書きだす
```

足し合わせた結果をコンポジットの1番に出力しよう。

```
function onTick()
	constantNumber1 = input.getNumber(1)
	constantNumber2 = input.getNumber(2)
	numberSum = constantNumber1 + constantNumber2
	output.setNumber(1,numberSum)
end
```

同じように書けただろうか？  
それでは最初のConstant Numberブロックに適当に数字を入れて、いざスポーン。

[![20210101230607.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210101230607.png.webp?rev=d096c353035f5615136a339dbc7ab91e&t=20210101231122 "20210101230607.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210101230607.png?rev=d096c353035f5615136a339dbc7ab91e&t=20210101231122 "20210101230607.png")

[![20210101230802-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210101230802-min.png.webp?rev=2d15c719b771e2c3a39031a4c901852c&t=20210101231131 "20210101230802-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210101230802-min.png?rev=2d15c719b771e2c3a39031a4c901852c&t=20210101231131 "20210101230802-min.png")

単純な計算ではあったけれど、ぼんやりとLuaの書き方がわかってきたと思う。

ちなみに「違う書き方もできる」と書いたのは

```
function onTick()
	numberSum = input.getNumber(1) + input.getNumber(2)
	output.setNumber(1,numberSum)
end
```

とか

```
function onTick()
	output.setNumber(1,input.getNumber(1)+input.getNumber(2))
end
```

とかでも意味は一緒ということ。上で書いたものと見比べてみよう。

#### 条件分岐でライトを光らせよう

ライト1つとトグルボタン2つを使ってif文の使い方を覚えよう。

[![20210102092518.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210102092518.png.webp?rev=85e3c9f7a1f596dd225ade99fd29e14d&t=20210102120043 "20210102092518.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210102092518.png?rev=85e3c9f7a1f596dd225ade99fd29e14d&t=20210102120043 "20210102092518.png")

[![20210102092524.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210102092524.png.webp?rev=45bfd60451e7dee2b95228f4c6c5e357&t=20210102120050 "20210102092524.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210102092524.png?rev=45bfd60451e7dee2b95228f4c6c5e357&t=20210102120050 "20210102092524.png")

マイコンの中身  
[![20210102115939.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210102115939.png?rev=7bc3fe476964d4fcf917f9cd9a7e9a58&t=20210102120102 "20210102115939.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210102115939.png?rev=7bc3fe476964d4fcf917f9cd9a7e9a58&t=20210102120102 "20210102115939.png")

計算処理の時と同じように、処理の流れをつかんでおく。  
　**①コンポジット入力を読み込む**  
　**②読み込んだ2つの真偽値の片方だけが真なら光らせる**  
　**③真偽値の結果をコンポジット出力する**

**①コンポジット入力を読み込む**  
これも計算処理の時と同じ要領で真偽値を読み込もう。

```
function onTick()
	toggle1 = input.getBool(1)
	toggle2 = input.getBool(2)
end
```

**②読み込んだ2つの真偽値の片方だけが真なら光らせる**  
やりたいことはロジックゲートのXOR（排他的論理和）の挙動だ。

> AとBの片方だけが真なら結果は真。  
> AとBが両方とも真か、両方とも偽なら結果は偽。

論理演算子か関係演算子を使って条件式のところを考えてみよう。  
toggle1とtoggle2がどうなっていればいいだろう？

```
function onTick()
	toggle1 = input.getBool(1)
	toggle2 = input.getBool(2)
	if 条件式 then
		light = true
	else
		light = false
	end
end
```

答え

論理演算子で書いたパターン。他にも書きようはあるけれど一例として…

```
function onTick()
	toggle1 = input.getBool(1)
	toggle2 = input.getBool(2)
	if (toggle1 and not toggle2) or (toggle2 and not toggle1) then
		light = true
	else
		light = false
	end
end
```

わかりやすいようにカッコをつけたが、このケースではなくても挙動は変わらない。  
演算子には優先順位があるため、モノによってはカッコでくくらないといけない。算数で＋より×が優先されるのと同じだ。

関係演算子ならシンプルに書けた。==（等しい）で表現できている。

```
function onTick()
	toggle1 = input.getBool(1)
	toggle2 = input.getBool(2)
	if not (toggle1 == toggle2) then
		light = true
	else
		light = false
	end
end
```

※notを消して~=（等しくない）を使ったり、==はそのままでtrueとfalseを逆にした上でnotを消してもいい。

今回はelseを使って書いたが、elseを使わずに以下のように最初の時点で変数を作る書き方を覚えよう。

```
function onTick()
	light = false		--lightのデフォルトの状態を指定している
	toggle1 = input.getBool(1)
	toggle2 = input.getBool(2)
	if not toggle1 == toggle2 then
		light = true
	end
end
```

このlight=falseがない場合を考えると、if条件が最初に満たされた時に初めてlight=trueとして宣言されるだけになる。  
そうなると今度はif条件を満たさなくなった時にlightをfalseに変える手段がないことになってしまう。  
**変数は代入した時の値を保持する**というのがわかってもらえただろうか？

**③真偽値の結果をコンポジット出力する**  
ここもやはり計算処理の時と同じ要領で、今度はsetBoolを使う。

```
output.setBool(index, value)		--真偽値を書きだす
```

まずは答えを見ないで書いてみよう。

答え

一例しか載せないがsetBoolのところはどのパターンでも共通。

```
function onTick()
	toggle1 = input.getBool(1)
	toggle2 = input.getBool(2)
	if not toggle1 == toggle2 then
		light = true
	else
		light = false
	end
	output.setBool(1,light)
end
```

ボタンのどちらか片方だけがオンになってる時だけライトが付けば成功。  
[![20210102115800-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210102115800-min.png.webp?rev=c0dca1681fbef7974cecd13f1d22df9f&t=20210102120109 "20210102115800-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210102115800-min.png?rev=c0dca1681fbef7974cecd13f1d22df9f&t=20210102120109 "20210102115800-min.png")

**cf．こんな書き方もできる**

変数として名前を付けてあげることで可読性を上げられたり  
その値をスクリプト中に何度も使うなら変数にしてあげた方が文字数的にも優しくなったり、変数を作るのはメリットがある。

しかしながらここでもやはりStormworks Luaの文字数制限でそうも言ってられない状況が出てくるので、  
条件式でgetBoolやgetNumberを直接書いてしまってもいいということも頭の片隅に置いておいてほしい。

```
function onTick()
	light = false
	if not input.getBool(1) == input.getBool(2) then
		light = true
	end
	output.setBool(1,light)
end
```

コンポジット信号が多いと「この〇〇番ってなんの値だっけ…」となるので、慣れないうちは変数を作ることをおススメする。

ちなみに、こんなのでも通る。

```
function onTick()
	output.setBool(1,input.getBool(1) ~= input.getBool(2))
end
```

### onDraw関数編

#### スクリーン座標系

スクリーンの左上が原点座標(0,0)となる。  
wはwidth（幅）、hはheight（高さ）のこと。  
[![20210102233041-01.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210102233041-01.png.webp?rev=66eb56bd7549eb4f6988e827d7f02d0e&t=20210102234123 "20210102233041-01.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210102233041-01.png?rev=66eb56bd7549eb4f6988e827d7f02d0e&t=20210102234123 "20210102233041-01.png")  
普段は気にしなくてよいが、厳密には終端の座標はそれぞれw-1、h-1となる。

| 画面サイズ | 幅（width） | 高さ（height） |
| --- | --- | --- |
| 1×1 | 32 px | 32 px |
| 2×2 | 64 px | 64 px |
| 3×3 | 96 px | 96 px |
| 5×3 | 160 px | 96 px |
| 9×5 | 288 px | 160 px |

#### 図形や文字を描画してみよう

なにかを描画する場合はStormworks Lua専用の描画関数を使う。  
[LuaスクリプトのDRAWING (描画)](https://wikiwiki.jp/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88#e21c1ee6)にある「screen.～～」で始まっているものだけが使える。

ここで「引数（ひきすう）」と「戻り値」について説明を加えておく。  
今までの解説ですでに

```
input.getNumber(index)
screen.drawCircleF(w/2,h/2,30)
```

こんな感じで関数のカッコ内に値が入ったものが出てきていた。  
こういった関数に渡す値のことを**引数（ひきすう）**という。  
引数が複数あるものについては手前から順に第一引数、第二引数…と呼ぶ。

関数の結果として返ってくる値のことは**戻り値**という。併せて覚えよう。

screen関数を使っていろいろ描画してみよう。ここでは2×2ディスプレイを使う。  
マイコンはvideo outputひとつでいいが、別途ディスプレイのオン信号が必要。

[![20210103143816.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210103143816.png.webp?rev=bf044b6aefbd689850cb8bb994a92bc9&t=20210103184453 "20210103143816.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210103143816.png?rev=bf044b6aefbd689850cb8bb994a92bc9&t=20210103184453 "20210103143816.png")

[![20210103143822.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210103143822.png.webp?rev=260418f66ba6e67b0d56c8884fd8e026&t=20210103184458 "20210103143822.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210103143822.png?rev=260418f66ba6e67b0d56c8884fd8e026&t=20210103184458 "20210103143822.png")

ここからは冒頭の説明と重なる部分が少し多いけれど、おさらいのつもりで読んでほしい。

onTick関数編の時と同じように、最初のコードを消してまっさらな状態からonDraw関数だけ書く。

```
function onDraw()
	--この部分に処理を書いていく
end
```

| **画面サイズを取得しよう** |
| --- |

getWidth、getHeight関数でそれぞれスクリーンの幅と高さを取得できる。

```
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
end
```

今回は2×2ディスプレイにつないでいるので、wとhのそれぞれに戻り値として64が返される。  
「〇×〇サイズのディスプレイで使うことしか想定していない」というスクリプトを書く場合は文字数を節約するために

```
w = 64
h = 64
```

このように画面サイズ情報を直接書いてしまっても構わない。  
画面サイズ情報を計算に使わないならこのw,hという変数も不要。

| **描画色を指定しよう** |
| --- |

デフォルトの描画色が設定されていて、色指定をしなくても白色で描画される。おそらくRGB値で(150,150,150)。  
setColor関数でRGB値と、オプションでアルファ値（不透明度）を0～255の範囲で指定することができる。

```
screen.setColor(r, g, b, a)
```

**緑色**で進めるが、好きな色があったらそれでもいい。アルファ値は省略。

```
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(0, 255, 0)
end
```

| **線を引いてみよう** |
| --- |

ためしに画面の中心に真一文字の線を引いてみよう。  
線を引くのにはdrawLine関数が使える。座標(x1,y1)から(x2,y2)に向かって線を引く\*12。

```
screen.drawLine(x1, y1, x2, y2)
```

このようにするにはどんな値を入れればいいだろう？  
[![20210103190229-01.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210103190229-01.png.webp?rev=cb2257479f5cb2b561602fc89d646504&t=20210103190648 "20210103190229-01.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210103190229-01.png?rev=cb2257479f5cb2b561602fc89d646504&t=20210103190648 "20210103190229-01.png")  
一度答えを見ずに書いてみよう。

答え

x軸は左から右までだから、0からwまで引けばいい。y軸は高さhを2で割ろう。

```
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(0, 255, 0)
	screen.drawLine(0, h/2, w, h/2)
end
```

できたかな？  
[![20210103210646-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210103210646-min.png.webp?rev=776c5d25047532ae85d3fe0d3b3a6fce&t=20210103214723 "20210103210646-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210103210646-min.png?rev=776c5d25047532ae85d3fe0d3b3a6fce&t=20210103214723 "20210103210646-min.png")  
円や四角形、三角形といったその他の図形もやることは基本的に一緒だ。  
引数には座標だけでなく円の半径や四角形の幅、高さもあるので、困った時はヘルプやWikiを参照しながら図形を描いていこう。  
APIとして用意されていない図形を描く場合は地道にやるかfor文などを使って工夫して描こう。

| **テキストを表示させてみよう** |
| --- |

使える文字はアルファベット大文字、数字、各種記号。  
drawText関数で書き始めの座標とテキストの内容を指定する。

```
screen.drawText(x, y, text)
```

ここで思い出してほしいのが**アルファベットを適当に並べ立てると変数として扱われてしまう**ということ。  
文字列として認識させるためには"（ダブルクォーテーション）で囲む必要がある。数値はクォーテーションがなくてもそのまま表示してくれる。  
ダブルクォーテーションは[shift]+[2]で打てる。

ありがちだが原点を基準にして「hello,world!」と表示させてみよう。  
関数の使い方は解説した通りなので、これも答えを見ずに書いてみてほしい。

答え

wとhは使ってないので省略している。  
テキストは小文字で入力しても勝手に大文字にされるのでどちらでもよい。

```
function onDraw()
	screen.setColor(0, 255, 0)
	screen.drawText(0, 0, "hello,world!")
end
```

[![20210103211029-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210103211029-min.png.webp?rev=78d931357f5625611e5ad3b8d73e1b74&t=20210103214732 "20210103211029-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210103211029-min.png?rev=78d931357f5625611e5ad3b8d73e1b74&t=20210103214732 "20210103211029-min.png")  
ディスプレイのカドが若干うっとうしいが、これはこういうものなので諦めるしかない。

| **描画の重なり方** |
| --- |

描画は先に書いたコードが下になり、後に書いたものが上に積み重なっていく。

```
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(0, 255, 0) 	 	 	--描画色を緑に指定する
	screen.drawRectF(0, 0, w, h) 	 	 	--四角形を描画する
	screen.setColor(255, 0, 0) 	 	 	--描画色を赤に指定する
	screen.drawText(0, 0, "hello,world!") 	--テキストを描画する
end
```

これを実行すると次のようになるのだが…  
[![20210103211312-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210103211312-min.png.webp?rev=5941a4260505e8af7f4758b86780c9b1&t=20210103214740 "20210103211312-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210103211312-min.png?rev=5941a4260505e8af7f4758b86780c9b1&t=20210103214740 "20210103211312-min.png")

```
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(255, 0, 0) 	 	 	--描画色を赤に指定する
	screen.drawText(0, 0, "hello,world!") 	--テキストを描画する
	screen.setColor(0, 255, 0) 	 	 	--描画色を緑に指定する
	screen.drawRectF(0, 0, w, h) 	 	 	--四角形を描画する
end
```

テキストを先に書くと後から書いた四角形に隠れてしまった。  
[![20210103211403-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210103211403-min.png.webp?rev=5ca7c7295af7f1ff5701aa96d006f430&t=20210103214746 "20210103211403-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210103211403-min.png?rev=5ca7c7295af7f1ff5701aa96d006f430&t=20210103214746 "20210103211403-min.png")

#### エラー画面を知ろう

プログラミングでは通常、エラーが発生した時点でプログラムは止まる。  
Stormworks Luaも例外ではない。エラーが起こらないよう正確に組まなければならない。

| **意図的にエラーを発生させてみる** |
| --- |

デフォルトで書かれている円を描画するコードの順番をいじって

```
function onDraw()
	screen.setColor(0, 255, 0)
	screen.drawCircleF(w/2, h/2, 30)
	w = screen.getWidth()
	h = screen.getHeight()
end
```

画面の幅と高さを取得する関数を下に持ってきた。

書かれてる内容自体は一緒のはずだが、スポーンさせると…

[![20210103211504-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210103211504-min.png.webp?rev=d300bda9ae0235bce5855e898dce0a2c&t=20210103214757 "20210103211504-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210103211504-min.png?rev=d300bda9ae0235bce5855e898dce0a2c&t=20210103214757 "20210103211504-min.png")

[![20210103211525-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210103211525-min.png.webp?rev=2fb244ebc9926243657b532d766412e4&t=20210103214806 "20210103211525-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210103211525-min.png?rev=2fb244ebc9926243657b532d766412e4&t=20210103214806 "20210103211525-min.png")

この通りブルスクを吐いてしまった。  
ツールチップ表示を見るとエラーの内容が確認できる。（エラーが複数あっても表示されるのは最初のひとつだけ）

```
draw error
3: attempt to perform arithmetic on a nil value (global 'w')
```

3という数字はスクリプトの行番号のこと。  
「**3行目でnil値を計算しようとしています（グローバル変数'w'）**」という意味。

3行目の変数wということは「w/2」の部分。  
プログラムは上から順番に実行されるので、**この3行目の時点ではまだw=screen.getWidth()の代入が行われていない**。  
wがまだnilであり、nil/2を計算しようとしたためにエラーとなってしまったというわけだ。

行番号はLuaエディタの左下に表示されている。  
[![20210103220048-01.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210103220048-01.png?rev=947769464a736c5f51c57343b1a3380e&t=20210103221205 "20210103220048-01.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210103220048-01.png?rev=947769464a736c5f51c57343b1a3380e&t=20210103221205 "20210103220048-01.png")

| **どのような状況でエラーが出るのか？** |
| --- |

いくつかエラーの種類を紹介しておくので参考にしてほしい。

- **nil値を使って計算を行おうとしている**  
  nilを使って計算しようとしたらアウト。nil単体だとゼロみたいなものなので一応通ってしまう。

- **構文を間違っている**  
  if文でthenを忘れてしまったり、for文でdoを忘れてしまったり、多重if文のendの数が足りなかったり多かったりいろいろ。

- **テーブルが空っぽなのに値を参照しようとしている**  
  データを格納できるテーブルという機能があるのだが、参照先が空っぽ（nil）だとエラーの要因になる。

- **実行時間が1000ミリ秒を超えてしまった**  
  Stormworks Luaのヘルプで[開発者からのメタ](https://wikiwiki.jp/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88#i69aafc4)のところに書かれている。

| **（最低限の）エラーチェック機能を活用しよう** |
| --- |

完璧なエラーチェック機能はないが、最低限の文法ミスをチェックしてくれる機能はある。  
編集完了ボタンを押す前に左下の**Check Errors**をクリックしてみよう。

たとえばdrawCircleFの第三引数を空にしてチェックしてみるとこのように。  
[![20210103214200.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210103214200.png?rev=8a4c4762b1466eb7780a9e91ef301f60&t=20210103214813 "20210103214200.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210103214200.png?rev=8a4c4762b1466eb7780a9e91ef301f60&t=20210103214813 "20210103214200.png")

```
5: unexpected symbol near ')'
（5行目の閉じカッコ付近に想定外の記号があります）
```

カッコの隣に本来くるはずのないコンマがあったために警告が出た。  
コンマもなく第一、第二引数だけ書かれて適切にカッコが閉じられてしまっていたりするとエラーは出ない。

外部エディタ\*13を使う人やLuaに慣れた人はさておき、文法がわかっていないうちはとりあえず押しておこう。

### onTick・onDraw関数編

onTick関数で値を取り込んでonDraw関数に反映させるという連携をやってみよう。  
onTick・onDrawをひとつずつ使っていた前2編をしっかり理解できていれば難しくない。

#### 取り込んだ数値をスクリーンに表示させてみよう

高度計（Altimeter）を設置して数値を取り込みスクリーンに表示させてみよう。

[![20210108003519.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210108003519.png.webp?rev=439afa32459ea5a1c1b67b128be787a6&t=20210108004548 "20210108003519.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210108003519.png?rev=439afa32459ea5a1c1b67b128be787a6&t=20210108004548 "20210108003519.png")

[![20210108003556.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210108003556.png?rev=093cbc60a3cf9119557a3acb30119949&t=20210108004555 "20210108003556.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210108003556.png?rev=093cbc60a3cf9119557a3acb30119949&t=20210108004555 "20210108003556.png")

**①コンポジット入力を読み込む**  
　**②表示桁数を少数第一位まで（〇〇〇.〇）にして描画する**

**①コンポジット入力を読み込む**

```
function onTick()
	alt = input.getNumber(1)
end
```

**②表示桁数を少数第一位まで（〇〇〇.〇）にして描画する**  
drawText関数はnumber型の値をそのまま描画してしまうので、書式を整えないと画像のようになってしまう。  
[![20210108004332-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210108004332-min.png.webp?rev=3f22eaf658ec913f1d4a5605b3fe7898&t=20210108005130 "20210108004332-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210108004332-min.png?rev=3f22eaf658ec913f1d4a5605b3fe7898&t=20210108005130 "20210108004332-min.png")  
数値の書式を整えるには、Luaの標準関数のところで出てきたstring.formatを使う。  
[![formatsiteisi-01.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/formatsiteisi-01.png?rev=f1baa9fa8c97040e1e701cb98f5dc1c5&t=20210116124144 "formatsiteisi-01.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/formatsiteisi-01.png?rev=f1baa9fa8c97040e1e701cb98f5dc1c5&t=20210116124144 "formatsiteisi-01.png")  
フラグ指定子とフォーマット指定子の意味がわからなくなったら[こちらの表](#n0c7b01f)を見よう。  
フィールド幅で**出力の桁数**を、精度で**小数点以下の桁数**を指定する。ダブルクォーテーションで囲むのを忘れずに。

今回は実数を10進法表記で出力したいので%fを使う。  
テキスト部分は次の通り書けばよいので、残りのonDraw関数部分を書ききってスポーンさせるところまでやってみよう。

```
screen.drawText(0, 5, string.format("%2.1f", alt).."m")
```

※「.."m"」のピリオド2つは**文字連結演算子**といい、文字列と文字列を連結させることができる。単位を分けて記述しなくてもよいので便利。

答え

```
function onTick()
	alt = input.getNumber(1)
end
function onDraw()
	screen.setColor(150, 150, 150)
	screen.drawText(0, 5, string.format("%2.1f", alt).."m")
end
```

※色指定が150なのは255だとまぶしいからで深い意味はない。

[![20210108004447.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210108004447.png.webp?rev=36c070970dcc6215fadee4823282a536&t=20210108004607 "20210108004447.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210108004447.png?rev=36c070970dcc6215fadee4823282a536&t=20210108004607 "20210108004447.png")

#### ON/OFF信号で表示/非表示を切り替えてみよう

先ほどの高度計の値を、トグルボタンを使って描画の表示/非表示を切り替えてみよう。  
on/off inputを追加し、ロジックを画像のように編集する。

[![20210108011822.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210108011822.png.webp?rev=514326fb6601d9c6ccbf8ab40e7f24de&t=20210108011923 "20210108011822.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210108011822.png?rev=514326fb6601d9c6ccbf8ab40e7f24de&t=20210108011923 "20210108011822.png")

[![20210108011849.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210108011849.png?rev=818c6e7139842bc43e5ccfa131436306&t=20210108011929 "20210108011849.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210108011849.png?rev=818c6e7139842bc43e5ccfa131436306&t=20210108011929 "20210108011849.png")

コンポジットライトの順番はnumber、booleanのどちらが先でもいい。  
ロジックゲートをひとつ通過するごとに1tickの遅延が生じてしまうのでtickレベルで管理が必要なときはそれを考慮して順番を決める必要がある。

前項で書いた高度を表示させるスクリプトを流用して、トグルボタンで表示・非表示を切り替えられるようにしてみよう。

答え

```
function onTick()
	alt = input.getNumber(1)
	toggle1 = input.getBool(1)
end
function onDraw()
	screen.setColor(150, 150, 150)
	if toggle1 then
		screen.drawText(0, 5, string.format("%2.1f", alt).."m")
	end
end
```

#### 複数ページを切り替えてみよう

描画の表示/非表示を応用して、複数ページ切り替えを実装してみよう。  
プッシュボタン2つを使って、1～3ページを切り替える形を目指す。  
[![20210108012531.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210108012531.png.webp?rev=49ef2e4710693062a3340286be39536e&t=20210108012621 "20210108012531.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210108012531.png?rev=49ef2e4710693062a3340286be39536e&t=20210108012621 "20210108012531.png")  
処理の流れを整理すると次のようになる。  
　**①初期ページを決める**  
　**②コンポジット入力を読み込む**  
　**③プッシュ1が押されたらページ変数に+1、プッシュ2が押されたらページ変数から-1**  
　**④ページ変数に応じて描画が切り替わるようにする**

**①初期ページを決める**  
最初に表示させるページをonTick関数より前に宣言しておく。

```
page = 1
function onTick()
...
```

こうすることによってプログラムが走り始めた時だけこの変数宣言がなされる。

これがもし

```
function onTick()
page = 1
...
```

このように書かれていると**tickごとにpage=1が宣言されなおす**ので、page=2にした直後のtickで1ページ目に戻されてしまう。  
変数の初期値を宣言する場所には気を付けないといけない。

**②コンポジット入力を読み込む**  
今回は実装が簡単になるようPulse (Toggle to Push)を使ってプッシュボタンのオン信号が1tick分だけ通るようにしておく。  
[![20210108012547.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210108012547.png?rev=be04b91ad1381ff1f40343ba47c81f45&t=20210108012629 "20210108012547.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210108012547.png?rev=be04b91ad1381ff1f40343ba47c81f45&t=20210108012629 "20210108012547.png")

```
page = 1
function onTick()
	push1 = input.getBool(1)
	push2 = input.getBool(2)
end
```

**③プッシュ1が押されたらページ変数に+1、プッシュ2が押されたらページ変数から-1**

- プッシュ1が押されたら数値を1足す
- ページ変数は3を超えない

この2点を考慮して条件式を組むと次のようになる。

```
if push1 and page < 3 then
	page = page + 1
end
```

プッシュ2の条件分岐を書き加えてみよう。

- プッシュ2が押されたら数値を1引く
- ページ変数は1を下回らない

答え

```
if push1 and page < 3 then
	page = page + 1
elseif push2 and page > 1 then
	page = page - 1
end
```

**④ページ変数に応じて描画が切り替わるようにする**  
あとは単純な条件分岐でページを分けるだけ。  
次に示す内容を各ページに入れて残りを書ききってみよう。

```
--1ページ目
screen.setColor(255, 0, 0)
screen.drawCircleF(w/2, h/2, h/2)
--2ページ目
screen.setColor(0, 255, 0)
screen.drawRectF(w/2-10, h/2-10, 20, 20)
--3ページ目
screen.setColor(0, 0, 255)
screen.drawTriangleF(0, h, w/2, 0, w, h)
```

答え

```
page = 1
function onTick()
	push1 = input.getBool(1)
	push2 = input.getBool(2)
	if push1 and page < 3 then
		page = page + 1
	elseif push2 and page >1 then
		page = page - 1
	end
end
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	if page == 1 then
		screen.setColor(255, 0, 0)
		screen.drawCircleF(w/2, h/2, h/2)
	elseif page == 2 then
		screen.setColor(0, 255, 0)
		screen.drawRectF(w/2-10, h/2-10, 20, 20)
	elseif page == 3 then		--ここはelseだけでもよい
		screen.setColor(0, 0, 255)
		screen.drawTriangleF(0, h, w/2, 0, w, h)
	end
end
```

次のようにif文を分けてしまってもいい。

```
if page == 1 then
	screen.setColor(255, 0, 0)
	screen.drawCircleF(w/2, h/2, h/2)
end
if page == 2 then
	screen.setColor(0, 255, 0)
	screen.drawRectF(w/2-10, h/2-10, 20, 20)
end
if page == 3 then
	screen.setColor(0, 0, 255)
	screen.drawTriangleF(0, h, w/2, 0, w, h)
end
```

**赤の丸**、**緑の四角**、**青の三角**を切り替えられるようになったら成功だ。

## 発展編：関数定義（関数を自作する）

関数は自作することができる。  
一連の処理の流れを関数として定義しておくことで、関数を呼び出して値を返させたり描画処理をさせたりできる。

ケーススタディとして、以下のシチュエーションを考えてみよう。

> Stormworks Lua APIには「指定した座標に1ドット描画する」という関数は用意されていない。  
> drawLine関数を使うなどしなければならないが、それだと引数を4つも埋めなければならない。  
> drawPixel(x,y)というシンプルな関数があれば引数2つ入れるだけで済むのに…。

だったらそのdrawPixel関数とやらを作ればいいじゃないかという発想だ。  
drawPixel関数を自作すると以下のようになる。

```
function drawPixel(x,y)
	screen.drawLine(x,y,x+1,y)
end
```

関数の中身に**drawLine関数を使って1ドットだけ描画する**という処理が入っている。  
drawPixel(x,y)と書くだけでこの処理を呼び出せるようになった。

あるいは二点の座標間の距離を求める計算を関数にして…

```
function distBetweenTwo(x1, y1, x2, y2)
	return math.sqrt((x1-x2)^2+(y1-y2)^2)	--二点間の距離を求める
end
```

※math.sqrt(x)は「xの平方根を返す」というLua標準の数学関数。

```
dist1 = distBetweenTwo(100,200,500,-100)
dist2 = distBetweenTwo(200,300,800,300)
```

これでdist1には計算結果の500が代入され、dist2には600が代入される。

以上のようなものは処理の内容がシンプルすぎて自作関数にする意味があまりないようにも思うが

```
math.sqrt((100-500)^2+(200+100)^2)
```

このように数字や計算式がズラっと並ぶのではなく、distBetweenTwoのように**計算に名前が付いていることで一瞬でその処理の内容を把握できる**という点は大きなメリットと言えよう。

### 関数定義の基本形

関数名の命名ルールは変数名と同じなので、わかりやすく、長すぎない関数名をつけよう。  
アルファベット一文字だと関数名が水色の強調表示にならないが、それも一応関数名としては有効。

引数を必要としない場合はカッコの中は空のままでいい。

```
function 関数名(引数)
	処理
end
```

ケーススタディのドット描画処理で使ったのはこの形。  
値を返してほしいわけではないのでreturnは要らない。

```
function 関数名(引数)
	return 戻り値
end
```

計算結果や真偽値など、戻り値として値を返させたいものにはreturnをつける。

```
function 関数名(引数)
	if ○○ then
		return △△
	else
		return ××
	end
end
```

if文で条件分岐をさせたりもできる。

```
function 関数名 (引数1, 引数2, ...)
	処理
end
```

引数の最後に「...」をつけると**可変引数**となる。任意の個数の引数を渡すことができる。

```
function(引数) 処理 end
```

関数名のない**無名関数**を定義することもできる。  
たとえばある数xを2乗する無名関数を変数に代入するのは次のように書ける。

```
square = function(x) return x * x end
...
screen.drawText(0, 0, square(2))
```

値の型の一覧にfunction型とあったが、つまるところfunction型をとる値を変数に代入している。  
関数名を付ける形での関数定義の書き方は、この無名関数の別の書き方（**シンタックスシュガー**、または**糖衣構文**という）である。

```
function square(x)
	return x * x
end
```

↑こちらがシンタックスシュガー

### タッチスクリーン座標を調べる自作関数

Luaのヘルプタブを見ると下記の関数が書かれている。  
これも一種の自作関数であり「指定した四角形の中をタッチしていたらtrueを返す」というもの。

```
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
```

論理演算子andが含まれているので、戻り値はtrueかfalseかの真偽値となる。

```
x > rectX
y > rectY
x < rectX+rectW
y < rectY+rectH
```

これら4つがすべて真であるときにトータルで真になることで、タッチ座標が指定した四角形の中に入っていたら真を返すという処理ができる。

余談だが、isPointInRectangleという関数名は長くて文字数がもったいないのでpRectとかのように関数名を短くする人もいる。

## 発展編：テーブル型

テーブルは値の型のひとつ\*14。配列と呼ぶこともある。  
**複数の値を格納できる箱**とイメージしてほしい。

テーブルは次のように値が波カッコで囲われた形が基本形となる。

```
table1 = {value1, value2, value3}
```

これでtable1には3つの異なる値が格納されていることになる。

また、要素が入っていない空の配列を作成することもできる。

```
table2 = {}
```

テーブルを操作するLuaの標準関数があり、後から要素を追加したり削除したりして使う際にこの宣言が必要になる。

ここでは**配列変数**と**連想配列**という2つの用法に分けて説明する。  
実態はどちらも連想配列だがあまり気にしなくていい（後述）。

### 配列変数としてのテーブル

**単体の値**を格納したデータ構造。たとえば次のように宣言すると

```
hoge = {123, 456, 789}
```

hogeという変数に3つの数字が格納されている。

配列内の要素を参照する時は次のように角カッコに数字を入れて表現する。

```
hoge[1]
```

この数字を**キー(key)**、**添え字**などといい、キーが数値である場合は特に**インデックス**ともいう。  
Luaのテーブルのインデックスは1から始まるので、hoge[1]なら123が参照される。  
同じようにhoge[2]と書けば2番目の要素である456が、hoge[3]と書けば3番目の要素である789が参照される。

**このキーを変数にしてhoge[x]というふうに書けば、xの値を変えることによって参照する値を後から変えられる。**

hoge[0]、hoge[4]、hoge[-1]などはnilを参照することになるので注意。  
エラーの出方についてはシンプルな配列と後述の多次元配列とで少し違いがあったりするが、とりあえず**参照先がnilとなるキーはダメなんだ**と思っておけばいい。

### 連想配列としてのテーブル

**キーと値がペア**になった形で要素を格納したデータ構造。

```
fuga = {aka = "red", midori = "green", ao = "blue"}
```

**キー=文字列**のペアが3組入っているのがわかってもらえるだろうか。

連想配列では数値のインデックスではなく文字列のキーで要素を参照する。  
書き方は2通りある。

```
fuga.aka
fuga["aka"]	--角カッコで書く場合はキーにダブルクォーテーションが必要
```

これでakaに対応した文字列"red"が取り出せる。  
**渡した文字列キーに応じた値を連想する**から**連想**配列ということだ。

次のように書けば任意の数字をキーとすることもできる。

```
fuga = {[10] = "red", [20] = "green", [30] = "blue"}	--キーが数値の場合は角カッコが必要
```

これを参照する場合fuga.10ではダメで**fuga[10]と書かなければならない**。  
数値はそのままでも文字列として見てもらえるのでダブルクォーテーションは要らない。  
数値インデックスと混同しかねないので実際にはやらないほうがいいだろう。

キーをクォーテーションで明確に文字列として記述すれば先頭が数字だったり空白があったりしてもよい。

```
fuga ={["123 abc"] = "red", ["456 def"] = "green", ["789 ghi"] = "blue"}
```

参照する時は最初の例と同じでクォーテーションをつけてfuga["123 abc"]という形になる。

パターンが多くてややこしかったかもしれないが、**キーは文字列である**という共通項に注目すると形を理解しやすいと思う。

### 多次元配列（入れ子配列）

配列そのものを配列の要素にして、多次元配列を作ることができる。  
行と列がある表の構造をとるデータの管理などに重宝する。

#### 配列変数の多次元配列

```
piyo={{111, 222, 333}, {444, 555, 666}, {777, 888, 999}}
```

これは二次元配列となっていて、大きな配列の中に3つの配列が入っている。

これを参照する場合は

```
piyo[i][j]
```

このようにインデックスを指定する。外側の枠組みから順に参照される。

たとえば**piyo[2][3]**なら…  
[2]は一番外側の枠組みでの2番目の要素なので{444, 555, 666}の配列を、  
[3]はその配列内での3番目の要素、すなわち666を参照していることになる。

外側の枠組みから順に参照するというルールは二次元以上の多次元配列でも同じだ。  
では次の三次元配列について、piyopiyo[2][1][2]の参照先はどこになるだろう？考えてみよう。

```
piyopiyo = {{{a, b, c}, {d, e, f}, {g, h, i}}, {{j, k, l}, {m, n, o}, {p, q, r}}}
```

答え

[2] → {{j, k, l}, {m, n, o}, {p, q, r}}  
[1] → {j, k, l}  
[2] → **k**

#### 連想配列の多次元配列

配列変数と考え方はほぼ同じだが、キーを文字列で指定するので比較的わかりやすい。

少しワードを具体的にしてAさん、Bさん、Cさんの3人のデータを管理する二次元配列を考えてみる。

```
hoge = {A = {名="太郎", 年=20, 性="男"}, B = {名="花子", 年=19, 性="女"}, C = {名="次郎", 年=22, 性="男"}}
```

大枠の中にA={}、B＝{}、C＝{}という形で3つの連想配列があり、それぞれにまた連想配列がある。

```
A = {名="太郎", 年=20, 性="男"}
B = {名="花子", 年=19, 性="女"}
C = {名="次郎", 年=22, 性="男"}
```

Cさんの年齢を参照したければ次のように文字列のキーを渡す。

```
hoge.C.年
hoge["C"]["年"]
```

連想配列である以上、数値インデックスでは指定できない。

### 長さ演算子

テーブルの長さを求めるには**長さ演算子（#）**を用いる。

```
#テーブル名
```

このように書くとテーブルに要素がいくつ入っているかを返してくれる。  
たとえば

```
hoge = {123, 456, 789}
screen.drawText(0, 0, #hoge)
```

このようにすれば要素は3つ入っているので「3」と描画される。

長さ演算子は多次元配列に対しても使用できる。

```
fuga = {{123, 456, 789, 123}, {234, 567, 891}, {345, 678, 912}}
```

この場合#fugaは3となる。  
さらに個別の配列について長さを求める場合

```
#fuga[1]
```

このように配列を指定する。#fuga[1]は{123,456,789,123}の配列なので長さは4。

配列の要素にnilを含む場合は気を付けなければならない。

```
piyo = {123, nil, 789}
```

#piyoは3

```
hogera = {123, nil, nil}
```

#hogeraは1

```
hogehoge = {nil, 456, nil}
```

#hogehogeは0

```
fugafuga = {nil, nil, 789}
```

#fugafugaは3  
以上のように要素の始まりや終わりがnilだと正しい長さを取得できない。  
また、この後のテーブル操作での内容の先取りになってしまうが

```
piyopiyo = {}
piyopiyo[1] = 123
piyopiyo[2] = nil
piyopiyo[3] = 789
```

このように値をテーブルに格納した時、上で出てきたpiyoと同じ中身になるはずが、#piyopiyoは1となる。

**配列の要素が飛び飛びになる使い方においては長さ演算子の使用は避けるべきである。**

なお、文字列キーを持つ要素（＝連想配列）は無視される。  
数値インデックスを持つ要素に対してのみ使えると考えてもらえればよい。

### ここまででの注意点

ここまで配列変数と連想配列に分けて説明してきたが、**Luaのテーブルの実態は連想配列**である。  
一般的に「配列」と「連想配列」は別物として扱われる。

配列
:   - 角カッコ[ ]で囲まれて宣言される
    - インデックスは0から始まる

連想配列
:   - 波カッコ{ }で囲まれて宣言される
    - キーは文字列であり、渡したキーに対応した値を参照する

※プログラミング言語によっては当てはまらないものもある。

このページでは用法別に解説したが、配列変数としての使い方は連想配列のキーを省略した形に過ぎない。  
キーを省略して書けば自動的に数値インデックスが対応しているだけ…ということは、次のような配列も作れる。

```
hoge = {123, aka = "red", "hello", midori ="green", 456 ,ao = "blue"}
```

配列変数と連想配列がごちゃ混ぜになっているような感じだ。

この形だと値の参照の仕方がややこしくなる。  
数値インデックスの割り当ては、キーと値のペアをスキップして単体の値のみに順次割り当てが行われる。  
つまり上の例で**単体の値**を抜き出すと123、"hello"、456の3つだが、これらに数値インデックス1～3が割り当てられているということだ。  
456が要素の5番目にあるからと思ってhoge[5]としてもダメで、**456を参照する場合はhoge[3]**になる。  
その一方で**キーと値のペア**の要素に関してはやはり連想配列なので文字列キーを使用しなければならない。

ごちゃ混ぜではなく規則的な配列を作れば可読性の向上に役立つだろう。

```
season = {spring = {3, 4, 5}, summer = {6, 7, 8}, fall = {9, 10, 11}, winter = {12, 1, 2}}
```

**spring={},summer={},fall={},winter={}**の部分は連想配列の形だが、月の数字のところは配列変数の形だ。  
これならば

```
season.summer[3]		--8（月）を参照
season["summer"][3]
season.winter[2]		--1（月）を参照
season["winter"][2]
```

このようにまとまりを持たせることもできる。

グループ化したい変数群を整理するなどの目的ならこうした使い方もあり得るだろう。  
文字列キーを使用すると当然文字数は増えるので、連想配列として使うことを検討する際は文字数制限も意識しよう。

## 発展編：テーブル操作

前編で勉強したテーブル型の応用編となる。  
テーブルに要素を挿入したり、削除したり、順番を入れ替えたりと色々なことができる。  
table関数はここで解説しているもの以外にもある。詳しくは[リファレンスマニュアル](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#6.6)を参照。

なお、テーブルとして操作する以前に波カッコをつけて空の配列か要素が入った配列を作成しておく必要がある。  
「この変数はtable型です、以後よろしく」とすることで初めてテーブルとして操作できるようになる。

### インデックスを指定して値を代入する

インデックスを指定して値を直接代入することができる。

```
hoge = {}	--空の配列を作成
hoge[1] = 123
hoge[3] = 456
hoge[2] = 789
```

こうした結果が次の配列。

```
hoge = {123, 789, 456}
```

インデックスとして有効な数字でなければならず、[0]や[-1]などはダメ。

### 要素を挿入/削除する

Luaの標準関数を使用して値の挿入/削除を行う。  
なおtable関数ではキーの指定に数値インデックスを使う。文字列キーは扱えない。

#### table.insert関数で要素を挿入する

```
table.insert(テーブル名,[挿入する位置,]挿入する値)
```

この関数が呼び出された時、テーブルに値を挿入する。  
挿入する位置は省略が可能。省略した場合はデフォルトで[#テーブル名+1]であり、配列の末尾に付け足していく。

| **挿入する位置を配列の途中に指定する場合** |
| --- |

```
table1 = {1, 2, 3, 4, 5}
...
table.insert(table1, 1, 100)	--table1の1番目に「100」を挿入する
```

このtable.insert関数が1度だけ実行されたとき

```
table1 = {100, 1, 2, 3, 4, 5}
```

後ろにある要素を押し出す。  
こうすればtable1[1]が常に最新のデータになる。

#### table.remove関数で要素を削除する

```
table.remove(テーブル名[,削除する位置])
```

この関数が呼び出された時、指定したテーブル（の指定した位置）から値を削除する。  
削除する位置は省略が可能。省略した場合はデフォルトで[#テーブル名]であり、配列の末尾から消していく。

| **削除する位置を配列の途中に指定する場合** |
| --- |

```
table2 = {1, 2, 3, 4, 5}
...
table.remove(table2, 3)	--table2の3番目から値を削除する
```

このtable.remove関数が1度だけ実行されたとき

```
table2 = {1, 2, 4, 5}
```

消した部分がnilになるのではなく、隙間を埋めるようにそこから後ろの値が配列の1番目の方へ引き入れられる。

#### 要素の挿入/削除を利用した具体例

レーダーが探知した対象までの距離を記録し、要素数が50を超えたら順次削除するプログラムの例。

```
distanceList = {}						--距離の情報を格納する空のテーブル
function onTick()
...
if radarDetectSignal then					--パルス化したレーダーの探知信号
	table.insert(distanceList, 1, radarDistance)	--挿入
end
if #distanceList > 50 then
	table.remove(distanceList)				--削除
end
```

関数は呼び出されるたびに実行されるので、レーダーの探知信号が10tickに及んだら要素が10個追加されることになる。  
このあたりは処理する内容によって変わってくるので臨機応変に。

挿入する位置を配列の先頭にしているので、**distanceList[1]が最新のデータになる**。  
削除する位置はデフォルトなので**配列の末尾（＝最も古いデータ）から消されていく**。

格納した値をうまく使ってその後の処理や描画を行おう。

### イテレータによる繰り返し処理の抽象化

抽象化とは**物事からある要素を抜き出す**という意味である。  
イテレータは反復子ともいい、**配列に対する繰り返し処理の要素を抜き出す**役割をする。  
ここでいう繰り返し処理は基礎編で勉強したfor文による繰り返しとはやや異なる部分もあるものの、イメージとしてはその認識でいい。

すなわちfor文による繰り返し処理の場合は

```
alphabet = {"A", "B", "C", "D", "E"}
function onDraw()
	for i = 1, #alphabet do
		screen.drawText(5 * i, 0, alphabet[i])
	end
end
```

[![20210122235058-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210122235058-min.png.webp?rev=ff77785f68f6286682a70b9e2b289e7b&t=20210122235551 "20210122235058-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210122235058-min.png?rev=ff77785f68f6286682a70b9e2b289e7b&t=20210122235551 "20210122235058-min.png")  
このようにfor文のカウンタ変数iをインデックスにして配列の要素を参照することになる。

イテレータ関数であるipairsを使って繰り返し処理の要素を抜き出すと

```
alphabet = {"A", "B", "C", "D", "E"}
function onDraw()
	for k, v in ipairs(alphabet) do
		screen.drawText(5 * k, 0, v)
	end
end
```

[![20210122235010-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210122235010-min.png.webp?rev=658dec366aa79e2d766a7e951cf47f16&t=20210122235540 "20210122235010-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210122235010-min.png?rev=658dec366aa79e2d766a7e951cf47f16&t=20210122235540 "20210122235010-min.png")  
ひとつ前の例のように要素をインデックスで参照しているわけではなく、**キーに対応した値がそのまま表れている**。  
配列のインデックスと要素を取り出して、kとvという変数を作ってそこに押し込んでいるような形だ。  
kが1のときvは"A"であり、kが2のときvは"B"であり…といった具合。  
kはkey、vはvalueのこと。for文のカウンタ変数と同じで、変数名は自由に決めていい。

値にnilが出現すると、そこを配列の最後と判断して処理が中断される。  
途中でnilが現れてその後ろに値が続いていても自動的にスキップしてくれるわけではないので注意。

文字列キーを持つ連想配列にはipairs関数ではなくpairs関数を使う。  
ディスプレイに描画する場合は描画する座標を計算する必要があるので、単なる連想配列ではなく多次元配列にして数値インデックスを与えよう。

```
fruits = {
 {apple = "ringo"},
 {cherry = "sakuranbo"},
 {sweetpotato = "satsumaimo"}
}
function onDraw()
	for i = 1, 3 do
		for k, v in pairs(fruits[i]) do
			screen.drawText(0, 6 * (i-1), k)	--キーを描画
			screen.drawText(60, 6 * (i-1), v)	--値を描画
		end
	end
end
```

[![20210123132046-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210123132046-min.png.webp?rev=fc30a5cd9fa4992ebbca44069729946f&t=20210123132229 "20210123132046-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210123132046-min.png?rev=fc30a5cd9fa4992ebbca44069729946f&t=20210123132229 "20210123132046-min.png")

以上のようなイテレータを使用したfor文は**ジェネリックfor文**や**汎用for文**などと呼ばれる。

イテレータは人によってはなかなか使う機会が訪れない。  
配列変数としてのテーブルで数値for文を使えば大体は事足りてしまう。

## 番外編：スクリプトの可読性・保守性

この講座でプログラミングを勉強している人は「あくまでStormworksで作りたいものがあったから勉強している」という人がほとんどだろう。  
仕事でプログラミングを使うとかではないから何らかの作法に縛られるわけでもないし、自己流で気の向くままに書ける。

ただしあまりに自己流を貫いてしまうと、時として以下のような問題を引き起こす。

- 数か月後に見直してみたら自分でもどういう意図で書いたか忘れてしまった…
- わからないところを他の人に質問したいのに内容がごちゃごちゃしていて回答してもらえない…

とびきり悪い例として編者が書いたものを見ていただこう。  
[![20210114210629.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210114210629.png.webp?rev=7ef18dbfb395176a2ab0a1e141f89ce1&t=20210114224508 "20210114210629.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210114210629.png?rev=7ef18dbfb395176a2ab0a1e141f89ce1&t=20210114224508 "20210114210629.png")  
想定通り動作してるけれど、可読性・保守性は最悪だ。

スペースも入れず、インデントもなく、変数名は意味がわからずもはや暗号と化している。  
コメントで説明が入っているわけでもなければ、使っちゃダメなgoto文までしれっと使っている。  
これを他人に見せて「**わからないので教えてくれ**」と言っても読む気が失せるということはわかってもらえただろうか。  
それに、後々になって**バグを見つけた**だとか**機能を追加したい**と思っても解読にまた一苦労するのは間違いない。

多数のプログラマが参加するプロジェクトには**コーディング規約**なるものが設けられるほどで、個人用だからといって自由な書き方も度が過ぎるとよくない。  
この編では文字数制限のことは一旦忘れて、コードの読みやすさのために普段からできることを紹介する。

### コメントを書こう

プログラム中に挿入する、処理についての説明文などを**コメント**という。  
記述をコメント化することを**コメントアウト**という。その逆（非コメント化）は**アンコメント**という。

| **1行コメントアウト** |
| --- |

ハイフンを2つ重ねると、改行するまでコメントアウトできる。

```
--1行コメント
```

[![20210114221625.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210114221625.png?rev=55e5194f9e83fc1798e3abc6a949860d&t=20210114222229 "20210114221625.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210114221625.png?rev=55e5194f9e83fc1798e3abc6a949860d&t=20210114222229 "20210114221625.png")

| **複数行コメントアウト** |
| --- |

ハイフン2つにさらに角カッコを2つ付けると、その後に角カッコ2つで閉じるまでをコメントアウトできる。  
複数行をコメントアウトしたり、スクリプトの一部分だけコメントアウトするという使い方ができる。

```
--[[
	複数行コメント
]]
```

[![20210114221704.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210114221704.png?rev=63641e6f5ef240968c16aaeabba2d562&t=20210114222233 "20210114221704.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210114221704.png?rev=63641e6f5ef240968c16aaeabba2d562&t=20210114222233 "20210114221704.png")

| **複数行コメントアウトの小技** |
| --- |

複数行コメントアウトの閉じカッコの前にハイフンを2つ加えると、デバッグに便利。  
数行にわたるコードのコメントアウト/アンコメントもハイフンひとつで切り替えられる。

```
--[[
	複数行コメント
--]]
```

[![20210114221842.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210114221842.png?rev=6b114fee51b70aa6129f509581236567&t=20210114222238 "20210114221842.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210114221842.png?rev=6b114fee51b70aa6129f509581236567&t=20210114222238 "20210114221842.png") [![20210114222008.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210114222008.png?rev=8d9967aac793f5d452dc1c95f4e104a1&t=20210114222243 "20210114222008.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210114222008.png?rev=8d9967aac793f5d452dc1c95f4e104a1&t=20210114222243 "20210114222008.png")

*---[[*と*--]]*がそれぞれ1行コメントとして扱われている。

### 改行・スペース・インデントを入れよう

改行、スペース、インデントは、構文上の問題がなければ入れなくてもいいものだ。  
たとえば次の画像はデフォルトで書かれているスクリプトのコメントだけ削除したものだが  
[![20210123203548-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210123203548-min.png?rev=56be2ad2454b8ab9c1f582a189104ed3&t=20210123212138 "20210123203548-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210123203548-min.png?rev=56be2ad2454b8ab9c1f582a189104ed3&t=20210123212138 "20210123203548-min.png")  
ここからさらに改行・スペース・インデントを削除しても支障はない。  
[![20210123203729-min.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::ref/20210123203729-min.png?rev=4353ab2cbbe3ec1fb100c67d3196884c&t=20210123212143 "20210123203729-min.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7/::attach/20210123203729-min.png?rev=4353ab2cbbe3ec1fb100c67d3196884c&t=20210123212143 "20210123203729-min.png")  
どちらが読みやすいかは一目瞭然。

どこまでやるかは人によるものの、文字が詰まり過ぎないように気を付けるとよい。

- if文のthenのあと、for文のdoのあとなどは改行する
- 値と演算子の間にスペースを入れる
- ネスト（入れ子）が深くなったらインデントを入れる

などなど…

### マジックナンバーはやめよう

プログラム中に書かれている何らかの具体的な数字は「**この数字の意味はわからないけどプログラムはちゃんと動いている。まるで魔法の数字だ**」という皮肉を込めて**マジックナンバー**と呼ばれる。  
よく例として挙げられるのは消費税率だ。

```
price = base_price * 1.10
```

このように1.10とだけ書いてしまうのではなく

```
tax_rate = 1.10
...
price = base_price * tax_rate
```

このように変数として宣言しておいたほうが、税率が変更されたとしても即座に対応できる。  
まして1.10が複数の箇所に書いてあったら余計な手間がかかる。

具体的な数字を入れたらなんでもマジックナンバーだからダメ、というわけではなく

- 将来的に数値が変動する（可能性がある）
- 作成者以外がコードを読んでもその数字の役割がわからない独自の値

このあたりに当てはまるような数字を直接書くのはやめた方がいいかな、くらいに考えておこう。
