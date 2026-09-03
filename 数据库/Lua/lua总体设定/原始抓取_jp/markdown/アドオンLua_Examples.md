---
wiki: sbarjp
page: アドオンLua/Examples
source_url: https://wikiwiki.jp/sbarjp/%E3%82%A2%E3%83%89%E3%82%AA%E3%83%B3Lua/Examples
last_modified: 2026-08-22
retrieved_at: 2026-08-31T01:10:35+0800
---

# アドオンLua/Examples

|  |
| --- |
| **このページはアドオン Lua のヘルプドキュメントの翻訳です。原文のバージョンは Stormworks v1.15.20（リリース日：2026/8/15）です。アドオン Lua はたびたびアップデートされています。正確な情報は公式のアップデート情報から確認してください。** |

英語原文

The following examples show ways to use the API to accomplish simple tasks. For more advanced examples; the default addon scripts showcase a wide array of lua techniques. Additional help is available in the official discord.

onCustomCommand is a flexible function that detects any chat messages starting with the command prefix ?, and breaks them up for processing. The example below shows how you can use it to set up your own commands with explicitly declared arguments.

```
function onCustomCommand(full_message, user_peer_id, is_admin, is_auth, command, arg1, arg2, arg3, arg4)

	--Only an admin can use this command
	--Example use: ?tp 2000 80 2500
	if command == "?tp" and is_admin == true then
		server.setPlayerPos(user_peer_id, matrix.translation(arg1,arg2,arg3))
	end

	if command == "?hello" then
		name, is_success = server.getPlayerName(user_peer_id)
		server.announce("[Server]", "Hello " .. name)
	end
end
```

The script below shows how to detect when a specific player has finished loading, by detecting when their object has loaded.

```
function onObjectLoad(object_id)
	if object_id == server.getPlayerCharacterID(0) then
		server.announce("Player Loaded: ", object_id)
	end
end
```

The script below shows one example of how you can spawn mission locations from the addon, track and despawn them.

```
spawned_mission_objects = {}

function onCustomCommand(full_message, user_peer_id, is_admin, is_auth, command, arg1, arg2, arg3, arg4)

	--Example use: ?spawnLocation my_boat 50 15 1000
	--Example use: ?spawnLocation my_mission 0 0 0
	if command == "?spawnLocation" and is_admin == true then
		local addon_index = server.getAddonIndex()
		server.spawnAddonLocation(matrix.translation(arg2,arg3,arg4), addon_index, (server.getLocationIndex(addon_index, arg1)))
	end

	if command == "?despawn" and is_admin == true then
		for id, object in pairs(spawned_mission_objects) do
			if(object["type"] == "vehicle")
			then
				server.despawnVehicle(id, true)
			else
				server.despawnObject(id, true)
			end
		end
	end

end

function onSpawnAddonComponent(id, name, type, addon_index)
	if (addon_index == server.getAddonIndex())
	then
		spawned_mission_objects[id] = {["name"] = name, ["type"] = type}
	end
end
```

The following function shows the easiest way to spawn a mission location from the script's parent addon.

```
function onCustomCommand(full_message, user_peer_id, is_admin, is_auth, command, arg1, arg2, arg3, arg4)

	if command == "?spawn_deltars_boat" then
		server.announce("[My_Addon]", "Spawning location named DELTARS_BOAT_SPAWNER")
		server.spawnNamedAddonLocation("DELTARS_BOAT_SPAWNER")
	end
end
```

The following function shows one way of testing if any player is at a location. Please note the extra set of brackets around server.getPlayerPos to capture only the first return variable and ignore the is\_success variable that server.getPlayerPos also returns.

```
function anyPlayerAtPos(posX, posY, posZ)

	local players = server.getPlayers()
	for player_index, player_object in pairs(players) do
		local x, y, z = matrix.position((server.getPlayerPos(player_object.id)))

		local distSQ = ((posX - x) ^ 2) + ((posY - y) ^ 2) + ((posZ - z) ^ 2)
		if(distSQ < 25)
		then
			return true
		end
	end

	return false
end
```

以下の例では、API を使用して簡単なタスクを実行する方法を紹介します。より高度な例として、デフォルトのアドオンスクリプトでは、様々な Lua のテクニックを紹介しています。その他のヘルプは、公式 Discord で入手できます。

onCustomCommand は、コマンドプレフィックス "?" で始まる任意のチャットメッセージを検出し、処理のためにそれらを分割する柔軟な関数です。以下の例では、明示的に宣言された引数を持つ独自のコマンドを設定するために、それを使用する方法を示しています。

```
function onCustomCommand(full_message, user_peer_id, is_admin, is_auth, command, arg1, arg2, arg3, arg4)

	--管理者権限を持つプレイヤーのみがこのコマンドを使えます
	--使用例：?tp 2000 80 2500
	if command == "?tp" and is_admin == true then
		server.setPlayerPos(user_peer_id, matrix.translation(arg1,arg2,arg3))
	end

	if command == "?hello" then
		name, is_success = server.getPlayerName(user_peer_id)
		server.announce("[Server]", "Hello " .. name)
	end
end
```

以下のスクリプトは、特定のプレイヤーのオブジェクトがロードされたことを検出することで、ロードが終了したことを検出する方法を示しています。

```
function onObjectLoad(object_id)
	if object_id == server.getPlayerCharacterID(0) then
		server.announce("Player Loaded: ", object_id)
	end
end
```

以下のスクリプトは、アドオンからミッションロケーションをスポーンさせて、追跡し、デスポーンさせる方法の一例を示しています。

```
spawned_mission_objects = {}

function onCustomCommand(full_message, user_peer_id, is_admin, is_auth, command, arg1, arg2, arg3, arg4)

	--使用例：?spawnLocation my_boat 50 15 1000
	--使用例：?spawnLocation my_mission 0 0 0
	if command == "?spawnLocation" and is_admin == true then
		local addon_index = server.getAddonIndex()
		server.spawnAddonLocation(matrix.translation(arg2,arg3,arg4), addon_index, (server.getLocationIndex(addon_index, arg1)))
	end

	if command == "?despawn" and is_admin == true then
		for id, object in pairs(spawned_mission_objects) do
			if(object["type"] == "vehicle")
			then
				server.despawnVehicle(id, true)
			else
				server.despawnObject(id, true)
			end
		end
	end

end

function onSpawnAddonComponent(id, name, type, addon_index)
	if (addon_index == server.getAddonIndex())
	then
		spawned_mission_objects[id] = {["name"] = name, ["type"] = type}
	end
end
```

次の関数は、スクリプトの親アドオンからミッションロケーションをスポーンさせる最も簡単な方法を示しています。

```
function onCustomCommand(full_message, user_peer_id, is_admin, is_auth, command, arg1, arg2, arg3, arg4)

	if command == "?spawn_deltars_boat" then
		server.announce("[My_Addon]", "Spawning location named DELTARS_BOAT_SPAWNER")
		server.spawnNamedAddonLocation("DELTARS_BOAT_SPAWNER")
	end
end
```

次の関数は、いずれかのプレイヤーがある場所にいるかどうかを確認する方法の 1 つを示しています。server.getPlayerPos を余分な括弧で囲っているのは、最初の戻り値だけを捕らえ、同時に返される is\_success 変数を無視するためです。

```
function anyPlayerAtPos(posX, posY, posZ)

	local players = server.getPlayers()
	for player_index, player_object in pairs(players) do
		local x, y, z = matrix.position((server.getPlayerPos(player_object.id)))

		local distSQ = ((posX - x) ^ 2) + ((posY - y) ^ 2) + ((posZ - z) ^ 2)
		if(distSQ < 25)
		then
			return true
		end
	end

	return false
end
```
