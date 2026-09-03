---
wiki: sbarjp
page: アドオンLua/General
source_url: https://wikiwiki.jp/sbarjp/%E3%82%A2%E3%83%89%E3%82%AA%E3%83%B3Lua/General
last_modified: 2026-08-22
retrieved_at: 2026-08-31T01:11:28+0800
---

# アドオンLua/General

|  |
| --- |
| **このページはアドオン Lua のヘルプドキュメントの翻訳です。原文のバージョンは Stormworks v1.15.20（リリース日：2026/8/15）です。アドオン Lua はたびたびアップデートされています。正確な情報は公式のアップデート情報から確認してください。** |

## Default Game Commands（デフォルトで使えるコマンド）

英語原文

The following commands can be called at any time and are built into the game:

Autosaves the game and live-reloads all active scripts and mission locations to allow for live debugging and editing of missions

```
?reload_scripts
```

Kicks the associated player from the game.

```
?kick <peer_id>
```

Bans the associated player from the game.

```
?ban <peer_id>
```

Give a player admin status. Authorize a player to use commands and bypass custom menu lock.

```
?add_admin <peer_id>
```

Remove admin status from a player.

```
?remove_admin <peer_id>
```

Give a player auth status. Authorize a player to use workbenches.

```
?add_auth <peer_id>
```

Remove auth status from a player.

```
?remove_auth <peer_id>
```

Dedicated server only, lets you force the dedicated server to save. save\_name parameter is optional and default uses save\_name from server config (If config setting is left blank it will save to autosave\_server.)

```
?save <save_name>
```

下記のコマンドはいつでも呼び出すことができます：

オートセーブ後、すべてのスクリプトとロケーションを再読み込みしてミッションのデバッグと編集を可能にします。

```
?reload_scripts
```

該当するプレイヤーをゲームからキックします。

```
?kick <peer_id>
```

該当するプレイヤーをゲームからBANします。

```
?ban <peer_id>
```

プレイヤーに管理者権限を与えます。コマンドの使用権限が与えられ、カスタムメニューのロックの影響を受けずに設定を触れます。

```
?add_admin <peer_id>
```

プレイヤーの管理者権限を剥奪します。

```
?remove_admin <peer_id>
```

プレイヤーに認証ステータスを与えます。ワークベンチの使用権限が与えられます。

```
?add_auth <peer_id>
```

プレイヤーの認証ステータスを剥奪します。

```
?remove_auth <peer_id>
```

専用サーバー限定コマンド。専用サーバーを強制的にセーブさせることができます。save\_name パラメータは任意であり、デフォルトではサーバー設定の save\_name を使用します（設定されていない場合は autosave\_server に保存されます）。

```
?save <save_name>
```

## Lua scripting overview（Lua スクリプトの概要）

英語原文

Lua scripting gives you the tools to create advanced missions and custom gamemodes. Stormworks provides a number of functions that allow your script to interface with the game.  
This guide outlines the functions that are available but is not a comprehensive tutorial on using the Lua language

Lua スクリプトは、Lua スクリプト言語を使用して高度なミッションやゲームカスタムを作成するためのツールを提供します。Stormworks には、スクリプトとゲームを連動させる機能が多数用意されています。  
このガイドではスクリプトで使用できる機能の概要を説明していますが、Lua 言語の使用に関する包括的なチュートリアルではありません。

## API General Info（API に関する一般事項）

英語原文

peer\_id can be found on the left side of the player list, singleplayer games always use peer\_id 0

The coordinate system uses Y as the vertical axis for matrices and vectors in world space

The functionalities of arguments in CAPS are detailed below the corresponding function

peer\_id can be passed as -1 to send for all connected peers

Any variables saved to a lua table named g\_savedata will be saved out and loaded from a per-save lua\_data.xml, you can use this to make your scripts persistent

For code that you want to run once at the start of the save use onCreate(is\_world\_create) and check is\_world\_create is true

Using server.announce() in onCreate will usually cause the messages to be sent before your client is connected and they will not be received

Remember to avoid the table length operator # and iPairs unless dealing with contiguous tables that start at index 1 (If a table is unexpectedly showing as length 0 this probably means it is not contiguous, the following function can be used for non - standard tables)

```
function tableLength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end
```

peer\_id はプレイヤーリストの左側に表示されます。シングルプレイでは peer\_id は常に 0 となります。

ワールド空間の行列やベクトルでは、Y を高さとして扱う座標系が使われます。

大文字（CAPS）で記載されている引数の機能については、対応する関数の下で詳述します。

peer\_id に -1 を指定すると、接続されている全員を指定します。

g\_savedata という名前の Lua テーブルに保存された変数は、セーブデータごとに存在する lua\_data.xml にセーブ/ロードされるので、これを利用してスクリプトを永続化することができます。

セーブデータの初回起動時に一度だけコードを実行したい場合は、onCreate(is\_world\_create) を使用し、is\_world\_create が true であることを確認してください。

onCreate で server.announce() を使用すると、大抵の場合クライアントが接続する前にメッセージが送信され、受信されません。

インデックスが 1 から始まる連続したテーブルを扱う場合を除き、長さ演算子 # と ipairs を避けるのを忘れないようにしましょう（テーブルが予期せず長さ 0 と表示された場合、おそらく連続したテーブルでないことを意味します、標準的ではないテーブルには次の関数を使用できます）。

```
function tableLength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end
```

## LUA FUNCTIONS（Lua 関数）

英語原文

The following global lua functions are available:

- pairs
- ipairs
- next
- tostring
- tonumber

and additional functions are available through the following lua libraries:

- math
- table
- string

For full documentation of the functions provided by these libraries, visit <https://www.lua.org/manual/.>

以下に示す Lua のグローバル関数が利用可能：

- [pairs](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-pairs)
- [ipairs](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-ipairs)
- [next](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-next)
- [tostring](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-tostring)
- [tonumber](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-tonumber)
- [type](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#pdf-type)\*1

また、Lua ライブラリを介して以下の関数群も利用可能：

- [math](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#6.7)
- [table](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#6.6)
- [string](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#6.4)

これらのライブラリで提供されている関数群についての詳細はマニュアル（[公式](https://www.lua.org/manual/5.3/)/[日本語（非公式）](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html)）を参照ください。

## META FROM THE DEVS（開発者からのメタ）

英語原文

This scripting API is very powerful and as such there are some important reminders to take note of:

- Your script has a max execution time of 1000 milliseconds, however it is still possible to create scripts that significantly slow down the game. It is your responsibility to ensure your script runs efficiently.

- peer\_id can be passed as -1 to send for all connected peers

- Any variables saved to a lua table named g\_savedata will be saved out and loaded from a per-save lua\_data.xml, you can use this to make your scripts persistent

- A number of safeguards are in place to sandbox your script, however it is still possible to write scripts that will potentially crash your game. If you crash your game with a script, it's likely that you're doing something (very) wrong. This is your own responsibility. If you suspect you have encountered a legitimate bug, please report it on the Stormworks issue tracker (accessible from the pause-menu).

- Malicious and harmful scripts will not be tolerated on the Stormworks Steam Workshop.

Finally, enjoy the almost limitless possibilities that these scripts provide. This short wiki aims to give a good overview of how scripting in Stormworks works, however if you have any questions that are not covered here, please feel free to join us on Discord (accessible from the pause-menu)!

このスクリプトAPIは非常に強力であるため、重要な注意事項がいくつかあります：

- スクリプトの最大実行時間は 1000 ミリ秒ですが、ゲームを大幅に遅くするスクリプトも作り得ます。スクリプトが効率的に動作するようにするのは、各自の責任で行ってください。

- peer\_id に -1 を指定すると、接続されている全員を指定します。

- g\_savedata という名前の Lua テーブルに保存された変数は、セーブデータごとに存在する lua\_data.xml にセーブ/ロードされるので、これを利用してスクリプトを永続化することができます。

- スクリプトをサンドボックス化するために多くの安全策が講じられていますが、ゲームをクラッシュさせるスクリプトになることもあり得ます。もしスクリプトでゲームをクラッシュさせた場合、何か（大きな）間違いをしている可能性があります。これはあなた自身の責任です。もしゲーム由来のバグに遭遇したのであれば Stormworks issue tracker（ESC キーメニューからアクセス可能）に報告してください。

- 悪意のある有害なスクリプトは Stormworks のワークショップでは許容されません。

最後になりますが、これらのスクリプトが提供する無限の可能性をお楽しみください。この短い wiki は Stormworks でのスクリプトの動作の概要を説明することを目的としています。この概要でカバーできない質問があれば、お気軽に Discord（ESC キーメニューからアクセス可能）にご参加ください！
