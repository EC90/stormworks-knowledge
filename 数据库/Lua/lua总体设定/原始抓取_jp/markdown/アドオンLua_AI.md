---
wiki: sbarjp
page: アドオンLua/AI
source_url: https://wikiwiki.jp/sbarjp/%E3%82%A2%E3%83%89%E3%82%AA%E3%83%B3Lua/AI
last_modified: 2026-08-22
retrieved_at: 2026-08-31T01:10:29+0800
---

# アドオンLua/AI

|  |
| --- |
| **このページはアドオン Lua のヘルプドキュメントの翻訳です。原文のバージョンは Stormworks v1.15.20（リリース日：2026/8/15）です。アドオン Lua はたびたびアップデートされています。正確な情報は公式のアップデート情報から確認してください。** |

## AI

英語原文

Lua AI can be run on any character, and their resulting actions are dictated by their state and the AI Type of the seat they are attached to.

Gun components and Camera components can be linked to a seat by naming them identically.

Sets the AI state for a character object.

```
server.setAIState(object_id, AI_STATE)

	SEAT TYPE = Ship Pilot
		AI_STATE |
		0 = none,
		1 = path to destination,

	SEAT TYPE = Helicopter Pilot
		AI_STATE |
		0 = none,
		1 = path to destination,
		2 = path to destination accurate (smaller increments for landing/takeoff),
		3 = gun run (Fly at target and press the trigger hotkey when locked on),

	SEAT TYPE = Plane Pilot
		AI_STATE |
		0 = none,
		1 = path to destination,
		2 = gun run (Fly at target and press the trigger hotkey when locked on),

	SEAT TYPE = Gunner
		AI_STATE |
		0 = none,
		1 = fire at target (Accounts for bullet drop / effective range when pulling the trigger),

	SEAT TYPE = Designator
		AI_STATE |
		0 = none,
		1 = aim at target (Pulls the trigger when looking directly at target),
```

Seat Outputs:

```
	SEAT TYPE = Ship Pilot
		Hotkey 1 = Engine On
		Hotkey 2 = Engine Off
		Axis W = Throttle
		Axis D = Steering

	SEAT TYPE = Helicopter Pilot
		Hotkey 1 = Engine On
		Hotkey 2 = Engine Off
		Axis W = Pitch
		Axis D = Roll
		Axis Up = Collective
		Axis Right = Yaw
		Trigger = Shoot

	SEAT TYPE = Plane Pilot
		Hotkey 1 = Engine On
		Hotkey 2 = Engine Off
		Axis W = Pitch
		Axis D = Roll
		Axis Up = Throttle
		Axis Right = Yaw
		Trigger = Shoot

	SEAT TYPE = Gunner
		Axis W = Pitch
		Axis D = Yaw
		Trigger = Shoot

	SEAT TYPE = Designator
		Axis W = Pitch
		Axis D = Yaw
		Trigger = Designate
```

Sets the target destination for an AI.

```
server.setAITarget(object_id, matrix_destination)
```

Gets the target destination for an AI. Returns nil on failure.

```
TARGET_DATA = server.getAITarget(object_id)

	TARGET_DATA = {
		["character"] = target character object id,
		["vehicle"] = target vehicle id,
		["x"] = target_x,
		["y"] = target_y,
		["z"] = target_z,
	}
```

Sets the target character for an AI. Different AIs use this data for their unique tasks.

```
server.setAITargetCharacter(object_id, target_object_id)
```

Sets the target vehicle for an AI. Different AIs use this data for their unique tasks.

```
server.setAITargetVehicle(object_id, target_vehicle_id)
```

Lua AI はどのキャラクターでも実行することができ、その結果得られる行動は、そのキャラクターの状態や、座っているシートの AI タイプによって決定されます。

機関銃コンポーネントとカメラコンポーネントは、同じ名前を付けることでシートにリンクさせることができます。

キャラクターオブジェクトの AI ステートを設定します。

```
server.setAIState(object_id, AI_STATE)

	SEAT TYPE = Ship Pilot（船舶操縦士）
		AI_STATE |
		0 = なし,
		1 = 目的地へ移動,

	SEAT TYPE = Helicopter Pilot（ヘリコプター操縦士）
		AI_STATE |
		0 = なし,
		1 = 目的地へ移動,
		2 = 目的地へ移動（高精度：着陸/離陸時の増減をより小さくする）,
		3 = 射撃と移動（ターゲットに向かって飛行し、ロックオンしたらトリガーホットキーを押す）,

	SEAT TYPE = Plane Pilot（飛行機操縦士）
		AI_STATE |
		0 = なし,
		1 = 目的地へ移動,
		2 = 射撃と移動（ターゲットに向かって飛行し、ロックオンしたらトリガーホットキーを押す）,

	SEAT TYPE = Gunner（砲手）
		AI_STATE |
		0 = なし,
		1 = 目標射撃（トリガーを引いた際の弾丸の落下/有効射程距離を考慮）,

	SEAT TYPE = Designator（目標指示装置）
		AI_STATE |
		0 = なし,
		1 = 照準を合わせる（ターゲットを真っ直ぐ狙ってトリガーを引く）,
```

シートの出力：

```
	SEAT TYPE = Ship Pilot（船舶操縦士）
		Hotkey 1 = エンジン ON
		Hotkey 2 = エンジン OFF
		Axis W = スロットル
		Axis D = ステアリング

	SEAT TYPE = Helicopter Pilot（ヘリコプター操縦士）
		Hotkey 1 = エンジン ON
		Hotkey 2 = エンジン OFF
		Axis W = ピッチ
		Axis D = ロール
		Axis Up = コレクティブ
		Axis Right = ヨー
		Trigger = 射撃

	SEAT TYPE = Plane Pilot（飛行機操縦士）
		Hotkey 1 = エンジン ON
		Hotkey 2 = エンジン OFF
		Axis W = ピッチ
		Axis D = ロール
		Axis Up = スロットル
		Axis Right = ヨー
		Trigger = 射撃

	SEAT TYPE = Gunner（砲手）
		Axis W = ピッチ
		Axis D = ヨー
		Trigger = 射撃

	SEAT TYPE = Designator（目標指示装置）
		Axis W = ピッチ
		Axis D = ヨー
		Trigger = 目標指示
```

AI の目標地点を設定します。

```
server.setAITarget(object_id, matrix_destination)
```

AI の目標地点を取得します。失敗した場合は nil を返します。

```
TARGET_DATA = server.getAITarget(object_id)

	TARGET_DATA = {
		["character"] = target character object id,
		["vehicle"] = target vehicle id,
		["x"] = target_x,
		["y"] = target_y,
		["z"] = target_z,
	}
```

AI のターゲットキャラクターを設定します。さまざまな AI がこのデータを固有のタスクに使用します。

```
server.setAITargetCharacter(object_id, target_object_id)
```

AI のターゲットビークルを設定します。さまざまな AI がこのデータを固有のタスクに使用します。

```
server.setAITargetVehicle(object_id, target_vehicle_id)
```

## AI Teams（AIチーム）

英語原文

Characters and vehicles can be assigned to teams. Characters with AI enabled can be set to target certain teams, which will allow a character with handheld weapons equipped to automatically shoot at the targeted teams.

A team is an index between 0(default) and 30.

Default Teams:  
0 - Default  
29 - Prey Creatures  
28 - Predator Creatures  
27 - Zombies  
1 - Used by default scripts for player team  
2 - Used by default scripts for enemy AI

Set team value for a character. 0 to 29.

```
server.setAICharacterTeam(character_id, team)
```

Set team value for a vehicle. 0 to 29.

```
server.setAIVehicleTeam(vehicle_id, team)
```

Set if a character should target a team. 0 to 29.

```
server.setAICharacterTargetTeam(character_id, team, is_target)
```

キャラクターとビークルはチームに割り当てることができます。AI 有効のキャラクターは特定のチームをターゲットに設定でき、これにより手持ち武器を装備したキャラクターがターゲットチームに自動的に発砲できるようになります。

チームは0（デフォルト）から30までのインデックスです。

デフォルトチーム：  
0 - デフォルト  
29 - 獲物生物  
28 - 捕食者生物  
27 - ゾンビ  
1 - プレイヤーチーム用のデフォルトスクリプトで使用  
2 - 敵AI用のデフォルトスクリプトで使用

キャラクターのチーム値を設定します。0から29。

```
server.setAICharacterTeam(character_id, team)
```

ビークルのチーム値を設定します。0から29。

```
server.setAIVehicleTeam(vehicle_id, team)
```

キャラクターがチームをターゲットにするかどうかを設定します。0から29。

```
server.setAICharacterTargetTeam(character_id, team, is_target)
```
