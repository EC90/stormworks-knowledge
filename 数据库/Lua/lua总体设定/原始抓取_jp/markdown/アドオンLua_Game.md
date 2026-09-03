---
wiki: sbarjp
page: アドオンLua/Game
source_url: https://wikiwiki.jp/sbarjp/%E3%82%A2%E3%83%89%E3%82%AA%E3%83%B3Lua/Game
last_modified: 2026-08-22
retrieved_at: 2026-08-31T01:11:26+0800
---

# アドオンLua/Game

|  |
| --- |
| **このページはアドオン Lua のヘルプドキュメントの翻訳です。原文のバージョンは Stormworks v1.15.20（リリース日：2026/8/15）です。アドオン Lua はたびたびアップデートされています。正確な情報は公式のアップデート情報から確認してください。** |

## Game（ゲーム）

英語原文

Attempts to spawn a tsunami epicentered at the target transform, only one tsunami/whirlpool can be active at a time; stronger events will override weaker ones. Magnitude ranges from 0-1.

```
is_success = server.spawnTsunami(transform_matrix, magnitude)
```

Attempts to spawn a whirlpool near to the target transform, can fail based on ocean depth, only one tsunami/whirlpool can be active at a time; stronger events will override weaker ones. Magnitude ranges from 0-1.

```
is_success = server.spawnWhirlpool(transform_matrix, magnitude)
```

Cancels the active ocean gerstner wave event (tsunami or whirlpool).

```
server.cancelGerstner()
```

Spawns a tornado at the target transform.

```
is_success = server.spawnTornado(transform_matrix)
```

Spawns a meteor to land at the target transform. Magnitude ranges from 0-1 and scales the main meteor up to 20x default size.

```
is_success = server.spawnMeteor(transform_matrix, magnitude, is_spawn_tsunami)
```

Spawns a meteor to land at the target location, preceded by several smaller meteors. Magnitude ranges from 0-1 and scales the main meteor up to 20x default size, this magnitude also increases the number of secondary meteors spawned.

```
is_success = server.spawnMeteorShower(transform_matrix, magnitude, is_spawn_tsunami)
```

Activates the closest volcano if the volcano tile is in simulation range.

```
is_success = server.spawnVolcano(transform_matrix)
```

Get a list of volcano data.

```
VOLCANOS = server.getVolcanos()

	VOLCANOS = {
		x = volcano world x
		y = volcano world y
		z = volcano world z
		tile_x = tile grid x
		tile_y = tile grid z
	}
```

Gets the blended oil amount at the target location.

```
oil_amount = server.getOilSpill(transform_matrix)
```

Sets the oil spill amount at the target location, this amount is blended across nearby tiles.

```
server.setOilSpill(transform_matrix, amount)
```

Completely resets the oil in the world.

```
server.clearOilSpill()
```

[Requires Search and Destroy DLC to be enabled] Spawn an explosion at the specified world position matrix.

```
server.spawnExplosion(transform_matrix, magnitude)
```

Set a game setting.

```
server.setGameSetting(GAME_SETTING, value)
```

Returns a table of the game settings indexed by the GAME\_SETTING string, this can be accessed inline eg. server.getGameSettings().third\_person

```
{[GAME_SETTING] = value} = server.getGameSettings()

	GAME_SETTING |
	"third_person",
	"third_person_vehicle",
	"vehicle_damage",
	"player_damage",
	"npc_damage",
	"sharks",
	"fast_travel",
	"teleport_vehicle",
	"rogue_mode",
	"auto_refuel",
	"megalodon",
	"map_show_players",
	"map_show_vehicles",
	"show_3d_waypoints",
	"show_name_plates",
	"day_length",
	"infinite_money",
	"settings_menu",
	"unlock_all_islands",
	"infinite_batteries",
	"infinite_fuel",
	"engine_overheating",
	"no_clip",
	"map_teleport",
	"cleanup_vehicle",
	"clear_fow", -- clear fog of war
	"vehicle_spawning",
	"photo_mode",
	"respawning",
	"settings_menu_lock",
	"despawn_on_leave", -- despawn player characters when they leave a server
	"unlock_all_components",
	"override_weather",
```

Set game money and research points.

```
server.setCurrency(money, research_points)
```

Get game money.

```
amount = server.getCurrency()
```

Get game research points.

```
amount = server.getResearchPoints()
```

Get number of days since game start.

```
days_survived = server.getDateValue()
```

Get the current game date.

```
d, m, y = server.getDate()
```

Get the current game time.

```
CLOCK = server.getTime()
	CLOCK = {
		["hour"] = hour (24),
		["minute"] = minute (60),
		["daylight_factor"] = midday factor (0-1),
		["percent"] = day_cycle_percent (0-1),
	}
```

Get the current game weather at a location.

```
WEATHER = server.getWeather(transform_matrix)
	WEATHER = {
		["fog"] = fog factor (0-1),
		["rain"] = rain factor (0-1),
		["snow"] = snow factor (0-1),
		["wind"] = wind factor (0-1),
		["temp"] = temp factor (0-1),
	}
```

Sets the custom weather override values (0-1).

```
server.setWeather(fog, rain, wind)
```

Sets the target audio mood. Mood tracks naturally decrease over time. -1 for all peers.

```
server.setAudioMood(peer_id, AUDIO_MOOD)
	AUDIO_MOOD |
		0 = none,
		1 = main_menu,
		2 = mood_normal,
		3 = mood_mission_mid,
		4 = mood_mission_high,
```

Returns the world position of a random ocean tile within the selected search range. Returns 0,0,0 on failure.

```
transform_matrix, is_success = server.getOceanTransform(transform_matrix, min_search_range, max_search_range)
```

Returns the generated ocean floor height offset of a tile. This is not terrain height and does not include mesh height. It is advised to only use this for ocean tiles. Example return value: -375

```
height = server.getOceanFloor(transform_matrix)
```

Returns the world position of a random tile of type tile\_name closest to the supplied location. Optional search radius defaults to 50000.

```
transform_matrix, is_success = server.getTileTransform(transform_matrix, tile_name, [search_radius])
```

Returns the data for the tile at the specified location.

```
TILE_DATA, is_success = server.getTile(transform)

	TILE_DATA = {
		["name"] = tile_name,
		["sea_floor"] = sea_floor_height,
		["cost"] = purchase_cost,
		["purchased"] = is_purchased,
	}
```

Returns the data for the tile selected as the start tile in the game settings.

```
TILE_DATA = server.getStartTile()

	TILE_DATA = {
		["name"] = tile_name,
		["x"] = tile_x,
		["y"] = tile_y,
		["z"] = tile_z,
	}
```

Returns whether the tile at the given world coordinates is player owned.

```
is_purchased = server.getTilePurchased(transform_matrix)
```

Returns the current inventory amounts for the tile resource depot.

```
coal, uranium, diesel, jet_fuel, solid_propellant = server.getTileInventory(transform_matrix)
```

Sets the inventory amounts for the tile resource depot.

```
server.setTileInventory(transform_matrix, coal, uranium, diesel, jet_fuel, solid_propellant)
```

Returns whether matrix\_object is within zone\_size of matrix\_zone.

```
is_in_area = server.isInTransformArea(matrix_object, matrix_zone, zone_size_x, zone_size_y, zone_size_z)
```

Returns a table of waypoints that form a path from start to end, matching the required tags, tags should be separated by commas with no spaces.

```
{ [i] = {x = world_x, z = world_z} } = server.pathfind(matrix_start, matrix_end, required_tags, avoided_tags)
```

Returns a table of waypoints tagged with ocean\_path, that form a path from start to end. This function is the same as passing 'ocean\_path' to the function above.

```
{ [i] = {x = world_x, z = world_z} } = server.pathfindOcean(matrix_start, matrix_end)
```

Returns a table of underground oil deposit positions.

```
{ [i] = {x = world_x, y = world_y, z = world_z, r = radius, oil = current_oil} } = server.getOilDeposits()
```

対象座標を中心とした津波をスポーンさせようと試みます。津波・渦潮は一度に 1 つしか発生しません；強いイベントは弱いイベントより優先されます。マグニチュードの範囲は 0 ～ 1 です。

```
is_success = server.spawnTsunami(transform_matrix, magnitude)
```

対象座標の近くで渦潮をスポーンさせようとします。海の深さによっては失敗することがあります。津波・渦潮は一度に 1 つしか発生しません；強いイベントは弱いイベントより優先されます。マグニチュードの範囲は 0 ～ 1 です。

```
is_success = server.spawnWhirlpool(transform_matrix, magnitude)
```

発生中の海洋ゲルストナー波イベント（津波または渦潮）をキャンセルします。

```
server.cancelGerstner()
```

対象座標に竜巻を発生させます。

```
is_success = server.spawnTornado(transform_matrix)
```

メテオをスポーンさせて、対象座標に着弾させます。マグニチュードは 0 ～ 1 の範囲で、メインのメテオはデフォルトの 20 倍まで拡大されます。

```
is_success = server.spawnMeteor(transform_matrix, magnitude, is_spawn_tsunami)
```

メテオをスポーンさせて、目標地点に着弾させます。その前に、いくつかの小さなメテオが発生します。マグニチュードは 0 ～ 1 の範囲で、メインのメテオはデフォルトの 20 倍まで拡大されます。このマグニチュードはスポーンさせる副メテオの数も増加させます。

```
is_success = server.spawnMeteorShower(transform_matrix, magnitude, is_spawn_tsunami)
```

火山タイルがシミュレーション範囲内にある場合、最も近い火山を噴火させます。

```
is_success = server.spawnVolcano(transform_matrix)
```

火山データの一覧を取得します。

```
VOLCANOS = server.getVolcanos()

	VOLCANOS = {
		x = volcano world x
		y = volcano world y
		z = volcano world z
		tile_x = tile grid x
		tile_y = tile grid z
	}
```

対象座標の石油流出量を取得します。

```
oil_amount = server.getOilSpill(transform_matrix)
```

対象座標の石油流出量を設定します。この石油は近隣のタイルに拡散します。

```
server.setOilSpill(transform_matrix, amount)
```

ワールド内の石油を完全にリセットします。

```
server.clearOilSpill()
```

[Search and Destroy DLC を有効化する必要があります] 指定されたワールド座標行列で爆発をスポーンさせます。

```
server.spawnExplosion(transform_matrix, magnitude)
```

ゲームを設定します。

```
server.setGameSetting(GAME_SETTING, value)
```

GAME\_SETTING 文字列でインデックス化されたゲーム設定のテーブルを返します。これはインラインでアクセスすることができます。例：server.getGameSettings().third\_person

```
{[GAME_SETTING] = value} = server.getGameSettings()

	GAME_SETTING |
	"third_person",
	"third_person_vehicle",
	"vehicle_damage",
	"player_damage",
	"npc_damage",
	"sharks",
	"fast_travel",
	"teleport_vehicle",
	"rogue_mode",
	"auto_refuel",
	"megalodon",
	"map_show_players",
	"map_show_vehicles",
	"show_3d_waypoints",
	"show_name_plates",
	"day_length",
	"infinite_money",
	"settings_menu",
	"unlock_all_islands",
	"infinite_batteries",
	"infinite_fuel",
	"engine_overheating",
	"no_clip",
	"map_teleport",
	"cleanup_vehicle",
	"clear_fow", -- clear fog of war（マップの未開放領域を解放する）
	"vehicle_spawning",
	"photo_mode",
	"respawning",
	"settings_menu_lock",
	"despawn_on_leave", -- サーバーから退出したときにそのプレイヤーキャラクターをデスポーンさせる
	"unlock_all_components",
	"override_weather",
```

資金とリサーチポイントを設定します。

```
server.setCurrency(money, research_points)
```

資金を取得します。

```
amount = server.getCurrency()
```

リサーチポイントを取得します。

```
amount = server.getResearchPoints()
```

ゲーム開始からの日数を取得します。

```
days_survived = server.getDateValue()
```

現在のゲーム上の日付を取得します。

```
d, m, y = server.getDate()
```

現在のゲーム上の時刻を取得します。

```
CLOCK = server.getTime()
	CLOCK = {
		["hour"] = hour (24),
		["minute"] = minute (60),
		["daylight_factor"] = midday factor (0-1),
		["percent"] = day_cycle_percent (0-1),
	}
```

指定された位置における現在のゲーム上の天気を取得します。

```
WEATHER = server.getWeather(transform_matrix)
	WEATHER = {
		["fog"] = fog factor (0-1),
		["rain"] = rain factor (0-1),
		["snow"] = snow factor (0-1),
		["wind"] = wind factor (0-1),
		["temp"] = temp factor (0-1),
	}
```

カスタム天候オーバーライドの値（0 ～ 1）を設定します。

```
server.setWeather(fog, rain, wind)
```

目標とするオーディオのムードを設定します。ムードトラックは時間の経過とともに自然に減少します。すべてのピアに適用するには、-1を指定してください。

```
server.setAudioMood(peer_id, AUDIO_MOOD)
	AUDIO_MOOD |
		0 = none,
		1 = main_menu,
		2 = mood_normal,
		3 = mood_mission_mid,
		4 = mood_mission_high,
```

選択された検索範囲内のランダムな海洋タイルのワールド座標を返します。失敗した場合は 0,0,0 を返します。

```
transform_matrix, is_success = server.getOceanTransform(transform_matrix, min_search_range, max_search_range)
```

指定されたタイルの、生成された海底の高さのオフセットを返します。これは地形の高さではなく、メッシュの高さも含まれません。これは海タイルにのみ使用することをお勧めします。戻り値の例：-375

```
height = server.getOceanFloor(transform_matrix)
```

与えられた位置に最も近い tile\_name 型のランダムなタイルのワールド座標を返します。任意の検索半径はデフォルトで 50000 です。

```
transform_matrix, is_success = server.getTileTransform(transform_matrix, tile_name, [search_radius])
```

指定された位置のタイルのデータを返します。

```
TILE_DATA, is_success = server.getTile(transform)

	TILE_DATA = {
		["name"] = tile_name,
		["sea_floor"] = sea_floor_height,
		["cost"] = purchase_cost,
		["purchased"] = is_purchased,
	}
```

ゲーム設定でスタートタイルとして選択されているタイルのデータを返します。

```
TILE_DATA = server.getStartTile()

	TILE_DATA = {
		["name"] = tile_name,
		["x"] = tile_x,
		["y"] = tile_y,
		["z"] = tile_z,
	}
```

指定されたワールド座標にあるタイルがプレイヤーの所有物であるかどうかを返します。

```
is_purchased = server.getTilePurchased(transform_matrix)
```

タイルのリソースデポの現在の在庫量を返します。

```
coal, uranium, diesel, jet_fuel, solid_propellant = server.getTileInventory(transform_matrix)
```

タイルのリソースデポの在庫量を設定します。

```
server.setTileInventory(transform_matrix, coal, uranium, diesel, jet_fuel, solid_propellant)
```

matrix\_object が matrix\_zone の zone\_size 以内にあるかどうかを返します。

```
is_in_area = server.isInTransformArea(matrix_object, matrix_zone, zone_size_x, zone_size_y, zone_size_z)
```

必要なタグに一致する、始点から終点までの経路を形成するウェイポイントのテーブルを返します。タグはスペースを入れずにカンマで区切ってください。

```
{ [i] = {x = world_x, z = world_z} } = server.pathfind(matrix_start, matrix_end, required_tags, avoided_tags)
```

ocean\_path でタグ付けされた、始点から終点までの経路を形成するウェイポイントのテーブルを返します。この関数は、上記の関数に "ocean\_path" を渡すのと同じです。

```
{ [i] = {x = world_x, z = world_z} } = server.pathfindOcean(matrix_start, matrix_end)
```

地下油田の位置を表すテーブルを返します。

```
{ [i] = {x = world_x, y = world_y, z = world_z, r = radius, oil = current_oil} } = server.getOilDeposits()
```

## Wildlife（野生生物）

英語原文

Returns the default data for all fish types.

```
FISH_DATA = server.getFishData()

	FISH_DATA = {
		[RESOURCE_TYPE] = {
			["name"] = fish_name,
			["price"] = base_price,
			["resource_type"] = RESOURCE_TYPE,
			["equipment_type"] = EQUIPMENT_TYPE
			["is_net_catchable"] = is_net_catchable
		}
	}
```

Returns a table of high abundance fish zones.

```
FISHING_HOTSPOT_DATA = server.getFishHotspots()

	FISHING_HOTSPOT_DATA = {
		[i] = {
			["x"] = world_x,
			["y"] = world_y,
			["z"] = world_z,
			["resource_type"] = RESOURCE_TYPE,
			["r"] = radius
		}
	}
```

すべての魚の種類のデフォルトデータを取得します。

```
FISH_DATA = server.getFishData()

	FISH_DATA = {
		[RESOURCE_TYPE] = {
			["name"] = fish_name,
			["price"] = base_price,
			["resource_type"] = RESOURCE_TYPE,
			["equipment_type"] = EQUIPMENT_TYPE
			["is_net_catchable"] = is_net_catchable
		}
	}
```

魚が豊富に出現する場所についてのテーブルを返します。

```
FISHING_HOTSPOT_DATA = server.getFishHotspots()

	FISHING_HOTSPOT_DATA = {
		[i] = {
			["x"] = world_x,
			["y"] = world_y,
			["z"] = world_z,
			["resource_type"] = RESOURCE_TYPE,
			["r"] = radius
		}
	}
```
