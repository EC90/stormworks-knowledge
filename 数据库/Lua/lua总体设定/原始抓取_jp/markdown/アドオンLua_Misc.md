---
wiki: sbarjp
page: アドオンLua/Misc
source_url: https://wikiwiki.jp/sbarjp/%E3%82%A2%E3%83%89%E3%82%AA%E3%83%B3Lua/Misc
last_modified: 2026-08-22
retrieved_at: 2026-08-31T01:11:50+0800
---

# アドオンLua/Misc

|  |
| --- |
| **このページはアドオン Lua のヘルプドキュメントの翻訳です。原文のバージョンは Stormworks v1.15.20（リリース日：2026/8/15）です。アドオン Lua はたびたびアップデートされています。正確な情報は公式のアップデート情報から確認してください。** |

## Main Menu Properties（メインメニュープロパティ）

英語原文

The following functions will add editable UI elements to the Addon script selector when starting a new game. These functions will return null unless the game was started through the new game screen, so it is recommended to use them in onCreate while is\_world\_create is true OR in g\_savedata where the nil value will be overwritten with the saved value on subsequent loads of the game.

A simple boolean checkbox.

```
property.checkbox(text, default_value)
```

A slider that is limited between two numbers.

```
property.slider(text, min, max, increment, default_value)
```

以下の関数は、新しいゲームを開始するときに、アドオンスクリプトセレクターに編集可能な UI 要素を追加します。これらの関数は、ゲームが新規ゲーム画面から開始されない限り、null を返します。したがって、is\_world\_create が true のときに onCreate で使用するか、g\_savedata を使用することをお勧めします。g\_savedata を使用する場合、nil 値は次回以降のゲームロード時に保存された値で上書きされます\*1。

シンプルなブール型チェックボックスです。

```
property.checkbox(text, default_value)
```

2 つの数値の間に制限されるスライダーです。

```
property.slider(text, min, max, increment, default_value)
```

## Http

英語原文

Send a Http request.

```
server.httpGet(port, request)
```

HTTP リクエストを送信します。  
（訳注：requestで入力可能な文字数は約4082文字で超過するとクラッシュします。(4096文字からlocalhost:ポート番号の文字数を引いた数?）

```
server.httpGet(port, request)
```

## Admin（管理）

英語原文

Ban a player.

```
server.banPlayer(peer_id)
```

Kick a player.

```
server.kickPlayer(peer_id)
```

Give a player Admin.

```
server.addAdmin(peer_id)
```

Remove Admin from a player.

```
server.removeAdmin(peer_id)
```

Give a player Auth.

```
server.addAuth(peer_id)
```

Remove Auth from a player.

```
server.removeAuth(peer_id)
```

Send a save command for dedicated server, with optional save name parameter.

```
server.save((save_name))
```

プレイヤーを BAN します。

```
server.banPlayer(peer_id)
```

プレイヤーをキックします。

```
server.kickPlayer(peer_id)
```

プレイヤーに管理者権限を与えます。

```
server.addAdmin(peer_id)
```

プレイヤーの管理者権限を剥奪します。

```
server.removeAdmin(peer_id)
```

プレイヤーに認証ステータスを与えます。

```
server.addAuth(peer_id)
```

プレイヤーの認証ステータスを剥奪します。

```
server.removeAuth(peer_id)
```

専用サーバーにセーブコマンドを送信します。任意でセーブ名を指定できます。

```
server.save((save_name))
```

## Misc（その他）

英語原文

Get system time in ms (Can be used for random seeding).

```
system_time = server.getTimeMillisec()
```

システム時間を ms 単位で取得します（ランダムシードに使用可能）。

```
system_time = server.getTimeMillisec()
```

## Developer（開発者）

英語原文

Get whether the game considers the tutorial active (Default missions check this before they spawn).

```
tutorial_completed = server.getTutorial()
```

Sets whether the game considers the tutorial active (useful if you are making your own tutorial).

```
server.setTutorial()
```

Gets whether the player has acknowledged the video tutorials (useful if you are making your own tutorial) Returns true on a dedicated server.

```
video_tutorial_completed = server.getVideoTutorial()
```

Returns true if the host player is a developer of the game.

```
is_dev = server.isDev()
```

Returns true if the server has the Search and Destroy DLC active.

```
is_enabled = server.dlcWeapons()
```

Returns true if the server has the Industrial Frontier DLC active.

```
is_enabled = server.dlcArid()
```

Returns true if the server has the Space DLC active.

```
is_enabled = server.dlcSpace()
```

Returns the ID of the currently active seasonal event.

```
EVENT_ID = server.getSeasonalEvent()

	EVENT_ID = {
		0 = NONE,
		1 = Halloween,
		2 = Christmas,
	}
```

ゲームがチュートリアルをアクティブとみなしているかどうかを取得します（デフォルトのミッションはスポーンする前にこれを確認します）。

```
tutorial_completed = server.getTutorial()
```

ゲームがチュートリアルをアクティブとみなすかどうかを設定します（独自のチュートリアルを作成している場合に便利です）。

```
server.setTutorial()
```

プレイヤーがビデオチュートリアルを認知したかどうかを取得します（独自のチュートリアルを作成している場合に便利です）専用サーバーの場合は true を返します。

```
video_tutorial_completed = server.getVideoTutorial()
```

ホストプレイヤーがゲームの開発者である場合、true を返します。

```
is_dev = server.isDev()
```

サーバーで Search and Destroy DLC が有効な場合、true を返します。

```
is_enabled = server.dlcWeapons()
```

サーバーで Industrial Frontier DLC が有効な場合、true を返します。

```
is_enabled = server.dlcArid()
```

サーバーで Space DLC が有効な場合、true を返します。

```
is_enabled = server.dlcSpace()
```

現在アクティブな季節イベントの ID を返します。

```
EVENT_ID = server.getSeasonalEvent()

	EVENT_ID = {
		0 = NONE,
		1 = Halloween,
		2 = Christmas,
	}
```
