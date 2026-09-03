---
wiki: sbarjp
page: Luaスクリプト/初心者向けLua回路講座
source_url: https://wikiwiki.jp/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7
last_modified: 2020-12-09
retrieved_at: 2026-08-31T01:13:09+0800
---

# Luaスクリプト/初心者向けLua回路講座

|  |
| --- |
| **このページは現在更新を保留しています** |

[Pony IDE](https://lua.flaffipony.rocks/)などの開発者であり、公式wikiの管理者（正確には元管理者、後継者を探しているが今はいない）でもあるPony氏が、開発側の不誠実な対応を機に、ゲームを辞められました。  
あくまできっかけの一つであり、根本的な原因は、長く続くStormworks開発チームの抱える問題の蓄積と、それが改善される見込みがないことへの不満、危機感です。  
他にも「正しいが不都合な指摘」をしたユーザーが、Stormworks開発チームの知識不足と不誠実さによりアカウント停止される等の問題が起きています。  
Stormworks開発チームが、これらの問題に誠実に対処する意思を見せるまで、このページは更新されません。  
問題の詳細の「一部」は[Pony IDE](https://lua.flaffipony.rocks/)から読むことができます。

|  |
| --- |
| **このページは工事中です** |

このページは、

- 2020年11月現在、[Lua初心者講座](/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/Lua%E5%88%9D%E5%BF%83%E8%80%85%E8%AC%9B%E5%BA%A7 "Luaスクリプト/Lua初心者講座")が一年以上書きかけの状態で放置されており
- 追記するにもページのゴールがわからない等の理由で難しい

という感じなので、新設する形で書き始めたものです。  
ページがある程度の完成度に到達するまで、~~二日～三日~~三日～四日に一度、一項目程の追記とページ全体の構成の見直し等を繰り返し行う予定です。編集者が病気で体が悪いため、もっと不定期になるかもしれません。  
計算通りいけば（絶対いきませんね） 5 ～ 6 万文字程度になると思います。プログラミングとプログラミング言語とその書き方を一から丁寧に教えてたら 5 万文字で済むわけがなく、なんなら一冊本が書けると思うのですが、何とかして上手く省いていきたい…そんななので完成は遠いです。11月末現在、楽観的に見て進捗は 3 割弱。なんとか説明省いて読者への宿題にできる箇所はないかということに頭を悩ませ続けています。そうしないと本当に本が出来上がってしまいます…  
一月以上更新が無かったら失踪したと判断して下さい。一週間程度だったら前述の通り病人なので恐らく体調不良です。  
前提読者とゴールは明確にしておくので、失踪した際は引き継げる人がいたら引き継いでもらえると助かります。失踪しないようにしますが一応…

> 目次
>
> - [はじめに](#y6b873b1)
> - [プログラミング言語Lua](#g16c13b6)
> - [Lua回路とは](#ub75712a)
> - [最初の一歩](#na0d1b50)
> - [初めてのLua回路](#j1f5746e) 
>   - [前準備：ブロックとロジック](#t05769ea)
>   - [初めてのStormworks Luaプログラミング](#s7a23653)
> - [プログラミング環境](#oa66edde)
> - [Pony IDE](#q4e52815) 
>   - [エディタ画面](#yc47e313)
> - [Luaプログラミング](#qd5e2e46) 
>   - [序論](#hc70dd19)
>   - [プログラムの実行順](#hc545a59)
>   - [コメント](#yd2b67f8)
>   - [四則演算](#m6d8bb7c)
>   - [余剰、累乗](#n2741f01)

## はじめに

ここは『プログラミング初心者』が『簡単なLua回路の作成』を目標に、LuaやLua回路について学ぶページです。現在、v1.0.21時点の情報が記述されています。  
詳細で網羅的な説明が必要な方は、他のページやドキュメントを参照してください。  
最低限の前提知識として初歩的な数学の知識と、[コンポジット信号](/sbarjp/%E3%82%B3%E3%83%B3%E3%83%9D%E3%82%B8%E3%83%83%E3%83%88%E4%BF%A1%E5%8F%B7%E3%81%A8%E3%81%AF "コンポジット信号とは")、[マイクロコントローラー](/sbarjp/%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%B3%E3%83%B3%E3%83%88%E3%83%AD%E3%83%BC%E3%83%A9%E3%83%BC "マイクロコントローラー")を要します。  
*Advanced Topic*と書かれた折り畳みは、最初は基本的に無視して構いません。『簡単なLua回路の作成』のために必須ではないが、より深く知りたい読者向けの説明等が含まれています。ある程度理解が進んで気が向いた時にでも読んでみてください。

## プログラミング言語Lua

そもそもLuaとは何なのでしょう。[公式サイトのAboutページ](http://www.lua.org/about.html)より、一部引用します。

```
Lua is a powerful, efficient, lightweight, embeddable scripting language.
```

英語が苦手な人向けに[DeepL翻訳](https://www.deepl.com/ja/translator#en/ja/Lua%20is%20a%20powerful%2C%20efficient%2C%20lightweight%2C%20embeddable%20scripting%20language.%20)の結果。

```
Luaは、パワフルで効率的、軽量、埋め込み可能なスクリプト言語です。
```

要するに「ソフトウェアに組み込みやすいプログラミング言語」ということです。  
MMORPGの「World of Warcraft」、国産なら「Final Fantasy XIV」、動画編集の「aviutl」、新しめの物だとVRツールの「VirtualCast」等等…多くのプロダクトで採用実績のある言語です。  
Stormworksでは振る舞いをカスタマイズ可能な回路の記述で利用されます。\*1  
その回路、Lua回路をある程度作れるようになるのが、このページの目標です。

*Advanced Topic: 英語とプログラミング*

プログラミング言語を学ぶ上で英語、特にリーディングは避けては通れません。プログラミングをしていると、様々なところで英語に出くわします。  
しかしStormworksはそもそも、多少なりとも英語のリーディングが必要なゲームです。Stormworksが遊べているのなら大丈夫…なはずです。  
どうしてもわからない時は、Google翻訳やDeepL翻訳等の便利なツールの力をどんどん借りましょう。  
[プログラマの三大美徳](https://ja.m.wikipedia.org/wiki/%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9E#%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9E%E3%81%AE%E4%B8%89%E5%A4%A7%E7%BE%8E%E5%BE%B3)と呼ばれるものがありますが、出来るプログラマほど、プログラムが出来ることはプログラムにやらせるものです。  
~~それはそれとして出来るプログラマは英語も大抵出来る。~~

## Lua回路とは

Function回路は「数式」を記述することで様々な「計算」ができる回路です。  
Lua回路は「Luaプログラム」を記述することで様々な「処理」ができる回路です。  
「数式」か「Luaプログラム」か。それだけの違いと考えれば単純です。  
ではLua回路の強みとは何なのか、何故Lua回路が使われるのか。  
一番は、出力にビデオ信号を持つことです。モニタやHUDへの描画処理は、Lua回路のみが持つ特権です。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/lua_script.png?rev=811e36059aac910060ac70c22451500e&t=20201110104012 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/lua_script.png?rev=811e36059aac910060ac70c22451500e&t=20201110104012 "noaround")

*Advanced Topic: META FROM THE DEVS*

説明書をしっかり読むタイプの人なら、Lua回路エディット画面のHelpタブ最下部にある[開発者からのメッセージ](/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88#i69aafc4 "Luaスクリプト")を見つけるかもしれません（v1.0.20現在）。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/meta_from_the_devs.png?rev=16892f985ff552cd7bcfe3f06470eb0e&t=20201108140253 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/meta_from_the_devs.png?rev=16892f985ff552cd7bcfe3f06470eb0e&t=20201108140253 "noaround")

「実行時間に気を付けてね」とか「マルチでは同期ズレが起きることがあるよ」とか、Lua回路を書く上で気を付けるべきことが色々と書いてあります。  
が、初心者の内はそういった事を気にすることも、メッセージの内容を正確に読み取ることも難しいと思います。  
LuaのことやStormworksのマルチの同期について詳しくなってから、必要な場合だけ対策すればいいと思います。  
つまりこのページを読んでいる間はあまり気にしなくていいということです。

## 最初の一歩

そろそろ説明にも飽きてきた頃でしょうか、兎に角Luaプログラムを動かしてみましょう。  
処理系のインストールなどの面倒な作業は不要です。ブラウザ上からプログラムを実行できるウェブサービスを利用します。  
今回はwandboxを利用させてもらいましょう。[wandboxでのコード例](https://wandbox.org/permlink/KmVz063x743rOhGs)を開いてください。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/wandbox_lua.png?rev=d829080c0e7fc3ed73ba61d3f02ecb6b&t=20201108142833 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/wandbox_lua.png?rev=d829080c0e7fc3ed73ba61d3f02ecb6b&t=20201108142833 "noaround")

画像のようなページが表示されたでしょうか。ページ下部の「RUN (or Ctrl+Enter)」ボタンを押すことで、プログラムを実行できます。  
適当にプログラムの一部を書き換えて実行し、出力結果を変えてみましょう。

*Advanced Topic: エラーメッセージ*

プログラムを書き換えて実行したら、エラーメッセージが表示されてしまった人もいると思います。以下はエラーメッセージの例です。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/wandbox_error.png?rev=b5214beaa4ec3706da40c6b9eb421061&t=20201108144354 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/wandbox_error.png?rev=b5214beaa4ec3706da40c6b9eb421061&t=20201108144354 "noaround")

エラーメッセージは、プログラミングを学ぶ初心者の躓きポイントの一つです。  
一番悪く、また一番多いのは「エラーメッセージを無視する」ことです。読める読めない以前に、読もうとしない…プログラミングが上達しない人の多くに共通する事です。  
エラーメッセージは、プログラムの誤りを修正するための情報を示す大事なものです。必ず読みましょう。  
とはいえ、最初はエラーメッセージが何を伝えようとしているのか分からないことも多いと思います。初心者が踏みがちなエラーの実例をいくつか後の項目で取り上げる予定です。

## 初めてのLua回路

### 前準備：ブロックとロジック

次はStormworksでLua回路を動かしてみましょう。  
まずはマイコンです。適当に新規作成して保存したものを設置しましょう。設置したらSELECTでマイコンをクリックし、マイコン編集画面に移動します。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/select.png?rev=8f4ae065103cedf7222de29bb19a7333&t=20201110113509 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/select.png?rev=8f4ae065103cedf7222de29bb19a7333&t=20201110113509 "noaround")

NameやDescriptionは適当で構いません。今回必要なのはモニターに描画するためのVIDEO出力が一つだけです。Logicタブから、VIDEO出力を追加しましょう。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/mc_logic.png?rev=b684abe8a0d924fab1348325b716241e&t=20201110113749 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/mc_logic.png?rev=b684abe8a0d924fab1348325b716241e&t=20201110113749 "noaround")

マイコンの中身はLua回路と先ほど追加したVIDEO出力を繋ぐだけです。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/lua_mic_circuit.png?rev=da8a9dc3c030680998b0fc35eac38ae3&t=20201108134826 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/lua_mic_circuit.png?rev=da8a9dc3c030680998b0fc35eac38ae3&t=20201108134826 "noaround")

Lua回路の中身は一旦後回しにし、左上の「×」ボタンからVehicle編集画面に戻ります。  
戻ったら、モニター、マイコン、バッテリー、モニターを有効にするためのCONSTANT ON SIGNAL。最低限必要なブロックを配置します。  
CONSTANT ON SIGNALは、モニターにON信号さえ送ることができればTOGGLE BUTTON等の他のブロックでも構いません。モニターのサイズもどれでも大丈夫です。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/blocks.png.webp?rev=1ae238137f693076517f45a01018f6e1&t=20201110102941 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/blocks.png?rev=1ae238137f693076517f45a01018f6e1&t=20201110102941 "noaround")

次はロジックです。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/data.png.webp?rev=42a574424bc757bc16f5daea1545c006&t=20201110103337 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/data.png?rev=42a574424bc757bc16f5daea1545c006&t=20201110103337 "noaround")

DATAに、

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/electric.png.webp?rev=0ea816d22e27331d0fbbf17ff2b55ed1&t=20201110103343 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/electric.png?rev=0ea816d22e27331d0fbbf17ff2b55ed1&t=20201110103343 "noaround")

ELECTRICに、

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/video.png.webp?rev=4efc870bc14bad9ae95beef7d258d42c&t=20201110103350 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/video.png?rev=4efc870bc14bad9ae95beef7d258d42c&t=20201110103350 "noaround")

VIDEO。  
これでロジックも終わりです。数値やon/off等の入出力を扱う場合はCOMPOSITEも必要ですが、今回はモニターに適当な描画を行うだけなので必要ありません。  
ここまでがLuaプログロムを書くまでの前準備です。Small Engineを動くようにするよりは簡単だと思います。

### 初めてのStormworks Luaプログラミング

あとはLuaプログラムを書くだけです。あと少しです、頑張りましょう。  
Lua回路をクリックすると、画面左上にEdit Scriptというボタンが表示されます。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/edit.png?rev=fc59a127f90007abb79c5317527d889a&t=20201110104915 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/edit.png?rev=fc59a127f90007abb79c5317527d889a&t=20201110104915 "noaround")

ボタンをクリックすると、以下のような画面が表示されます。この画面がLuaプログラムを記述する画面です。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/editor.png?rev=4486ca5287a7172e5c35e5798503fef2&t=20201110105737 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/editor.png?rev=4486ca5287a7172e5c35e5798503fef2&t=20201110105737 "noaround")

最初からエディットボックスに書かれているのは、サンプルのLuaプログラムです。全部消してしまって、以下のように書きましょう。コピーアンドペーストでも構いません。

```
function onDraw()
	screen.drawText(0, 0, "TEST")
end
```

文法上のミスがないか、画面左下のボタンでチェックすることができます。初心者のうちは文法を間違えることも多いと思うので、クリックする癖をつけておきましょう。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/check_errors.png?rev=ba985d53896d6444b68f950cab50c115&t=20201110115423 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/check_errors.png?rev=ba985d53896d6444b68f950cab50c115&t=20201110115423 "noaround")

書き終えたら右下のDoneボタンをクリックすれば、Lua回路内部のLuaプログラムが書き換えられます。  
書き換えたら、忘れずにUPDATEでマイコンを更新します。必要ならセーブも上書きしておきましょう。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/update.png?rev=b2e18a7ded62fd4d732ae00783875308&t=20201110115725 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/update.png?rev=b2e18a7ded62fd4d732ae00783875308&t=20201110115725 "noaround")

あとはSPAWNして実際に動かすだけです。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/spawned.png.webp?rev=bc9e027f3958adfec61ca7246f585c8d&t=20201110121151 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/spawned.png?rev=bc9e027f3958adfec61ca7246f585c8d&t=20201110121151 "noaround")

モニターを見てみましょう。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/success.png.webp?rev=01b5bcb27ed46453dea199d5b4ed4775&t=20201110122402 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/success.png?rev=01b5bcb27ed46453dea199d5b4ed4775&t=20201110122402 "noaround")

このように表示されていれば成功です。  
まだLuaプログラミングについて学ぶ必要はありますが、Lua回路を作る手順については一先ずこれでお終いです。お疲れさまでした。

*Advanced Topic: サンプルプログラム*

消してしまったサンプルプログラムを一応読んでみましょう。鍵カッコは編集者の付け加えた意訳です。  
Stormworksはマルチバイト文字に対応していないので、実際はエディットボックスに日本語等を記述することはできません。初心者は日本語でコメント書ければ、幾分か楽になるのではと思うのですが…  
~~もう令和なんだからさすがに対応して。~~

```
-- Tick function that will be executed every logic tick「毎チック実行されるTick関数」
	value = input.getNumber(1)			 -- Read the first number from the script's composite input「スクリプトのコンポジット入力から最初の数値を読み込む」
	output.setNumber(1, value * 10)		-- Write a number to the script's composite output「スクリプトのコンポジット出力へ数値を書きだす」
end
-- Draw function that will be executed when this script renders to a screen「スクリーン（モニターやHUD）に描画する際に実行されるDraw関数」
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height「スクリーンの幅と高さの取得」
	h = screen.getHeight()
	screen.setColor(0, 255, 0)			 -- Set draw color to green「描画色を緑にセット」
	screen.drawCircleF(w / 2, h / 2, 30)   -- Draw a 30px radius circle in the center of the screen「スクリーン中央に半径30ピクセルの円を描画」
end
```

このサンプルプログラムがどういうものなのかは後の項目で分かるように説明していきますが、おおよそ意訳に書いた通りです。  
論理回路としては、コンポジット信号の入力から一番目の数値を取り出し、それを十倍したものをコンポジット信号の出力の一番目に設定して出力する。  
描画処理としては、モニターやHUDの中央に半径30ピクセルの緑色の円を描画する。1x1のモニターだと表示しきれませんね。

## プログラミング環境

Stormworksのエディット画面はプログラミング環境としては非常に貧弱です。

- Undo（やり直す）ができない、当然Redo（元に戻す）もできない。
- デバッグ手段がない（スクリーンに描画するしか無い）\*2
- シンタックスハイライト等のプログラムを読みやすいようにする機能が弱い。

実際に書き始めれば分かると思うのですが、「Luaプログラムを書く→マイコンを更新する→VehicleをSPAWNする→動かしてみる→おかしかったら直す→...」というトライアンドエラーの繰り返しにかなり時間がかかります。  
トライアンドエラーは素早くできた方が良い、というのはStormworksで乗り物を作る際にもいえる、モノ作り全般に共通する事として理解して貰えると思います。  
要するに代替手段を検討した方がいいということです。しかし具体的に、どういう選択肢があるでしょうか。  
高機能なエディター、IDE（統合開発環境）等、プログラマ向けのツールは多くあります。しかし、初心者向けのツールというのはなかなかありません。IDE等は慣れたプログラマには便利なのですが、初心者には多機能すぎて、使いこなすのはなかなか大変です。~~世の中のプログラマもIDEの機能をフルに使えてる方が少数派です。~~  
なにより、欲をいえばStormworks向きの機能が欲しい。そんな欲張りな要求にこたえてくれるツールが…  
実はあります。[Pony IDE](https://lua.flaffipony.rocks/)です。StormworksプレイヤーであるCrazyFluffyPonyさんの作った、ブラウザ上で使えるStormworksのLua回路を作るためのツールです。単なるエディタではなく、Lua回路の開発を支援するための以下のような機能があります。

- ブラウザからの実行
- 一時停止、再開
- COMPOSITE入力とプロパティのサポート
- デバッグ出力等の開発用APIの追加
- Stormworks APIのシミュレーション
- スクリーンシミュレーター
- その他様々な便利機能（UI Builder等）

要約すると**「ブラウザ上で快適にLua回路の開発ができる」**ということです。  
Luaプログラムを書いたその場ですぐに実行できるので、トライアンドエラーのサイクルが速くなり、開発効率はよくなります。  
使わない手はないので、ここから先はPony IDEを使う前提で進めます。  
具体的な進め方としては「Pony IDEを使ってLua回路を書く→ある程度形になったらStormworksのエディット画面にコピーアンドペースト\*3→実環境で試す」という流れになります。

## Pony IDE

前項で説明したとおりの、Lua回路を作る上で便利なツールです。以下は、実際に使っている様子です。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/pony_ide.png?rev=c41f95e57445f410660ada4c684afcdd&t=20201119152248 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/pony_ide.png?rev=c41f95e57445f410660ada4c684afcdd&t=20201119152248 "noaround")

画面いっぱいの英語で、苦手な人はぐえっとなるかもしれませんが、普通に使う分には特に難しいことはありません。  
Pony IDEは「左上のエディタ画面」「左下のコンソール画面」「右上の多目的画面」「右下のスクリーンシミュレーター画面」の四つの画面で構成されています。  
以下で簡単に各画面の説明をします。なんとなく見たらわかった、という人は各画面についての項目は読み飛ばしても構いません。

### エディタ画面

簡単に説明していきます。まずは最上部のメニューから。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/pony_menu.png?rev=400d880ac4000c217f23e03b5825b2ad&t=20201119154054 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/pony_menu.png?rev=400d880ac4000c217f23e03b5825b2ad&t=20201119154054 "noaround")

1. プログラムを保存します。時間経過やプログラムの実行等色々なタイミングで自動的に保存されるので、あまり気にしなくても大丈夫です。
2. エディターの内容をクリアします。間違えて押しても確認ダイアログが表示されます。
3. プログラムを実行します。画像では実行中なのでボタンが無効になっています。ゲーム同様60FPSでLua回路の実行と描画処理が行われます。\*4
4. 一時停止（Pause）もしくは再開（Resume）ボタンです。画像は一時停止中なので再開ボタンが表示されています。名前の通りです。
5. ステップ実行ボタンです。1フレームだけ実行します。便利そうであまり使わない、デバッガじゃないしなあ…
6. 停止ボタンです。プログラムを停止します。
7. 共有ボタンです。プログラムを共有するためのURLを発行することができます。他の人にプログラムを見てもらいたい際等に使います。

重要なのは「３」の実行ボタンと「６」の停止ボタンです。他は使わなくても大丈夫です、少なくとも編集者は滅多に使いません。

次はタブ一覧なのですが…

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/pony_tab.png?rev=b71a6faf0687a22b643370d22b58365a&t=20201119160538 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/pony_tab.png?rev=b71a6faf0687a22b643370d22b58365a&t=20201119160538 "noaround")

初心者の内はエディタータブ以外使うことはないと思うので省略します。間違えて別の画面を表示してしまったら、一番左のエディタータブをクリックしてエディター画面に戻すことだけ覚えておきましょう。

最後は肝心要のエディターです。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/pony_editor.png?rev=57366803f4baad0caee7896e317853e9&t=20201119161036 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/pony_editor.png?rev=57366803f4baad0caee7896e317853e9&t=20201119161036 "noaround")

エディットボックス内がプログラムを記述するエディターなのは見た通りなので分かると思います。他の部分について説明します。  
左上のボタンとメニューはMifinierタブ関連のものです、無視して構いません。  
その下の欄の左側にカーソル位置の表示、中央に補完方法の表示、右側に最大文字数と現在の文字数の表示、となっています。  
この中では文字数が一番重要です。とはいえ、初心者の内から文字数制限に引っかかる規模のプログラムを書くことはない（書けたら初心者卒業か、余程書き方が悪いかのどちからです）と思うので、例によって最初は気にする必要はありません。  
エディター右上の「－」「＋」でエディターのフォントサイズを変更できます。四方に矢印が向いたボタンは最大化ボタンです。ディスプレイの解像度が足りていれば使う機会は無いと思います。  
あとはエディットボックスにプログラムを書くだけです。

TODO: ほかの画面について書く  
TODO: なんでこんなにエディターの使い方を丁寧に説明してるのか書く  
TODO: 更新頻度が遅すぎて Pony IDE が更新されて機能追加されたので対応…

*Advanced Topic: Pony IDEの限界*

Pony IDEはよく出来ていますが、完全なシミュレーターというわけではないため、Stormworksと挙動が異なる場合があります。  
例えばスクリーンへの描画は、現状完璧なシミュレーションは行われていないため、描画結果が一致しないことがあります。左がPony IDEで描いた円、右がStormworksで実際に描かれた円です。

[![pony_circle.png](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/pony_circle.png?rev=5801d3ff5fc8dc22ea53cf6a73dbb38c&t=20201119120502 "pony_circle.png")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/pony_circle.png?rev=5801d3ff5fc8dc22ea53cf6a73dbb38c&t=20201119120502 "pony_circle.png")

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/sw_circle.png.webp?rev=5ecf6591ecc5a96fdd676edeaf992f90&t=20201119120454 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/sw_circle.png?rev=5ecf6591ecc5a96fdd676edeaf992f90&t=20201119120454 "noaround")

また、Pony IDEは「StormworksのスクリーンとLua回路のシミュレーター」としては非常に便利ですが、エディターとして特別他より優れているわけではありません。  
自分のお気に入りのエディターやIDEでLuaプログラムを書き、Pony IDEで動作確認し、ある程度形になったらStormworksで実際に動かす、という風に進めるのもいいでしょう。

## Luaプログラミング

### 序論

ここからは、実際にプログラミング言語としてのLuaについて学んでいきます。  
Luaは他のプログラミング言語に比べれば少なめとはいえ、それでもプログラミング初心者にとっては多くの機能があります。最初からそれらを文法まで含めて完全に覚えようとする必要はありません。  
そもそも、プログラミング初心者がプログラミング言語を学ぶというのは、実際の所「プログラミング」と「プログラミング言語」の二つを並行して学習する、ということです。最初から完璧を目指してしまうと大抵の人は恐らく先に心が折れます。  
どのような機能があり、どのようなことが出来るかを把握しておき、文法を思い出せなかった時にこのページや他のドキュメントで文法を確認して書く、という風に書いていければ大丈夫です。  
そうやって何度も書いていくうちに、文法は自然と身に付くはずです。それはつまるところ、手を動かさないと身に付かないという意味でもあります。

以下、Luaの言語機能について一つずつ順番に説明していきます。Aを知る上でBを知っておく必要がある、といった場合に、BよりAの説明が先になるようにできるだけ構成しています。上から下へ順に読んで貰えば大丈夫です。

### プログラムの実行順

プログラミング言語も、このページのように基本的には上から下に読みます。それはプログラムを実行するコンピューターも同じで、原則としてプログラムは上から下に解釈されて実行されます。  
何を当たり前な、と思われるかもしれませんが大事なことです。

### コメント

```
-- 一行コメント。二つのハイフン「-」以降は改行までコメントになり、プログラムの実行結果に影響を及ぼさない
--[[
  複数行コメント。一行コメントほど使用頻度は高くない
  二つの角括弧が付く場合は、閉じ角括弧が二つ表れるまで改行も含めてコメントになり、プログラムの実行結果に影響を及ぼさない
  一時的にプログラムの一部を実行させないようにしたい時などに使えるが、エディターやIDEの複数行コメントアウト機能で代替されがち
]]
1 --[[ * 2 ]] * 3 -- 「 * 2」 がコメントとして無視され「1 * 2 * 3」ではなく「1 * 3」と解釈される。
```

一時的にプログラムの一部をコメントにすることを「コメントアウト」と呼びます。  
Pony IDEなら「Ctrl+/」で、選択中の行を全てコメントアウトすることができます。コメントアウトされている行を選択して「Ctrl+/」で、逆にコメントアウトを解除することもできます。  
何も計算しませんが、プログラムの一部に説明を加えたり、バグの原因箇所を絞り込むのに使えたりと、便利な機能です。  
TODO 画像  
Lua回路には文字数制限がありますが、コメントも文字数としてきっちりカウントされる点には気を付ける必要があります。

### 四則演算

整数の四則演算は、数学におけるそれと同じです。Function回路で書く数式と変わりません。

```
1 + 2 --> 3
10 - 3 --> 7
2 * 5 --> 10
-15 / 3 --> -5
```

「+」「-」「\*」「/」等を「演算子」と呼びます。演算子には優先順位がありますが、四則演算については矢張り数学におけるそれと同じです。

```
5 * 6 + 2 -- (5 * 6) + 2 として解釈される
```

実数の四則演算もまた、数学におけるそれと**「殆ど」**同じです。  
しかし実数は、正確にコンピューターで扱うのが非常に困難な数です。循環小数を思い浮かべて貰えば、無理数等を扱うことの難しさが分かって貰えると思います。  
例えば以下の計算は、人間には0.001となることがすぐに分かりますが、Luaで計算すると、僅かですが誤差が生じます。

```
111.111 - 111.110 --> 0.0010000000000047748
```

誤差を考慮してプログラムを正しく書くのは難しいです。幸い、殆どのプログラムでは誤差が無視できます。少なくとも初心者のうちに書くプログラムで誤差が問題になることはないでしょう。  
「実数の計算には誤差が生じることがある」ということだけ頭の片隅に入れておきましょう。  
また「1」と「1.0」は、数値としては同じですが、前者は「整数」、後者は「実数」として、内部的には区別されています。例えばスクリーンに数値を描画する際、「1」と「1.0」とでは描画結果が異なります。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/number.png.webp?rev=0743cc6d13ff02cb4227997412d0fb81&t=20201119115712 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/number.png?rev=0743cc6d13ff02cb4227997412d0fb81&t=20201119115712 "noaround")

センサー等の数値出力を持つブロックは基本的に実数を出力します。整数のつもりで計算していたら実数だったため、画面に小数点等が描画されてしまった…とならないよう気を付けましょう。

*Advanced Topic: Stormworksと実数*

Stormworksも実数を扱っている以上、開発言語が異なるとはいえ様々な場所に誤差は存在します。  
vehicle editorのSPWANにカーソルをあわせた際に表示される機体の重さが、画像のようになっている時は誤差によるものです。重さが実数で示されるブロックが存在するために起こります。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/spawn_diff.png?rev=ad8ffbc7061a1622229cb2dbe7c3171f&t=20201124185822 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/spawn_diff.png?rev=ad8ffbc7061a1622229cb2dbe7c3171f&t=20201124185822 "noaround")

機体の重さに誤差があったところで害はないのですが、誤差によりプログラムに問題が生じることは[現実に起こり得ること](https://www.jpcert.or.jp/sc-rules/c-flp00-c.html)です。  
しかし本文で書いた通り、実際に問題になることは殆どの状況ではないです\*5。  
実数をコンピューターで、つまり0と1の列で表現する方法として浮動小数点数があります。浮動小数点数を正しく理解するのは難しく、理解せずとも初歩的なLua回路を書くことは可能なため、本文では説明を省いています。  
浮動小数点数の多くはIEEE 754という標準規格に従います。プログラミング初心者には難しいかもしれませんが、気になる人は調べてみてください。

### 余剰、累乗

数値に対する演算子は四則演算の他に、余剰と累乗があります。「MODULO」と「EXPONENT」です。

```
5 % 3 --> 2
2 ^ 10 --> 1024.0
```

基本的には四則演算と同じです。四則演算と違い記号に見慣れないかもしれませんが、Function回路でも使えるので覚えておきましょう。

[![noaround](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::ref/FUNCTION_Operators.png?rev=101c528c97561d1908311da0957a4ecd&t=20201124204034 "noaround")](https://cdn.wikiwiki.jp/to/w/sbarjp/Lua%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91Lua%E5%9B%9E%E8%B7%AF%E8%AC%9B%E5%BA%A7/::attach/FUNCTION_Operators.png?rev=101c528c97561d1908311da0957a4ecd&t=20201124204034 "noaround")

TODO: 他の最低限知っておくべき言語機能についてまとめる
