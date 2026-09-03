---
wiki: sbarjp
page: アドオンLua/Callbacks
source_url: https://wikiwiki.jp/sbarjp/%E3%82%A2%E3%83%89%E3%82%AA%E3%83%B3Lua/Callbacks
last_modified: 2026-08-22
retrieved_at: 2026-08-31T01:10:33+0800
---

# アドオンLua/Callbacks

|  |
| --- |
| **このページはアドオン Lua のヘルプドキュメントの翻訳です。原文のバージョンは Stormworks v1.15.20（リリース日：2026/8/15）です。アドオン Lua はたびたびアップデートされています。正確な情報は公式のアップデート情報から確認してください。** |

## Callback Functions（コールバック関数）

英語原文

Listed below are callback functions that can be added to a script and are automatically called when their specific conditions are met, the simplest callback function is onTick which is automatically called every game tick.

Called every game tick. game\_ticks refers to the number of ticks that have passed this frame (normally 1, while sleeping 400).

```
function onTick(game_ticks)
```

onCreate is called when the script is initialized (whenever creating or loading a world. is\_world\_create is true only on world generate (first load).

```
function onCreate(is_world_create)
```

onDestroy is called whenever the world is exited.

```
function onDestroy()
```

onCustomCommand is called when a command is typed into chat. full\_message contains the entire message including spaces, command contains the first parameter including the ? e.g. ?teleport, args ... represents the variadic arguments of the command (can also be explicitly declared, see example below)

```
function onCustomCommand(full_message, user_peer_id, is_admin, is_auth, command, args ...)
```

onChatMessage is called when a chat message is posted.

```
function onChatMessage(peer_id, sender_name, message)
```

onPlayerJoin is called when a player joins the game.

```
function onPlayerJoin(steam_id, name, peer_id, is_admin, is_auth)
```

onPlayerSit is called when a player sits in a seat.

```
function onPlayerSit(peer_id, vehicle_id, seat_name)
```

onPlayerUnsit is called when a player gets out of a seat.

```
function onPlayerUnsit(peer_id, vehicle_id, seat_name)
```

onCharacterSit is called when any character (including players) sits in a seat.

```
function onCharacterSit(object_id, vehicle_id, seat_name)
```

onCharacterUnsit is called when a any character (including players)gets out of a seat.

```
function onCharacterUnsit(object_id, vehicle_id, seat_name)
```

onCharacterPickup is called when a character object picks up a character.

```
function onCharacterPickup(object_id_actor, object_id_target)
```

onCreatureSit is called when any creature sits in a seat.

```
function onCreatureSit(object_id, vehicle_id, seat_name)
```

onCreatureUnsit is called when a any creature gets out of a seat.

```
function onCreatureUnsit(object_id, vehicle_id, seat_name)
```

onCreaturePickup is called when a character object picks up a creature.

```
function onCreaturePickup(object_id_actor, object_id_target, CREATURE_TYPE)
```

onEquipmentPickup is called when a character object picks up an equipment Item.

```
function onEquipmentPickup(object_id_actor, object_id_target, EQUIPMENT_TYPE)
```

onEquipmentDrop is called when a character object drops an equipment Item.

```
function onEquipmentDrop(object_id_actor, object_id_target, EQUIPMENT_TYPE)
```

onPlayerRespawn is called when a player respawns.

```
function onPlayerRespawn(peer_id)
```

onPlayerLeave is called when a player leaves the game.

```
function onPlayerLeave(steam_id, name, peer_id, is_admin, is_auth)
```

onToggleMap is called when a player opens/closes the map. is\_open represents whether their map is open.

```
function onToggleMap(peer_id, is_open)
```

onPlayerDie is called when a player dies.

```
function onPlayerDie(steam_id, name, peer_id, is_admin, is_auth)
```

onGroupSpawn is called when a vehicle group is spawned. If group is spawned by a script peer\_id will be -1. All vehicles in a group must still load locally so they can begin simulating for players. Cost is currently only calculated for player spawned vehicle groups. x, y, z are the group's spawn coordinates in world space.

```
function onGroupSpawn(group_id, peer_id, x, y, z, group_cost)
```

onVehicleSpawn is called when a vehicle is spawned. If vehicle is spawned by a script peer\_id will be -1. Spawned vehicles must still load locally so they can begin simulating for players. Cost is currently only calculated for player spawned vehicle groups. x, y, z are the group's spawn coordinates in world space. For physics-accurate sub-grid transform values the vehicles must be loaded to initialize their physics which then acts as their new base transform; Until the physics is created unloaded vehicles always treat their group origin as their position.

```
function onVehicleSpawn(vehicle_id, peer_id, x, y, z, group_cost, group_id)
```

onVehicleDespawn is called when a vehicle is despawned. If vehicle is despawned by a script peer\_id will be -1.

```
function onVehicleDespawn(vehicle_id, peer_id)
```

onVehicleLoad is called when a vehicle has loaded and is ready to simulate.

```
function onVehicleLoad(vehicle_id)
```

onVehicleUnload is called when a vehicle has unloaded and is no longer simulating.

```
function onVehicleUnload(vehicle_id)
```

onVehicleTeleport is called when a vehicle is teleported or returned to workbench. If vehicle is teleported by a script peer\_id will be -1. x,y,z are the destination coordinates in world space.

```
function onVehicleTeleport(vehicle_id, peer_id, x, y, z)
```

onObjectLoad is called when an object (character/prop/animal) has loaded and is ready to simulate.

```
function onObjectLoad(object_id)
```

onObjectUnload is called when an object (character/prop/animal) has unloaded and is no longer simulating.

```
function onObjectUnload(object_id)
```

onButtonPress is called when a button is interacted with (still triggers on locked buttons). To get a button's current state please use getVehicleButton()

```
function onButtonPress(vehicle_id, peer_id, button_name, is_pressed)
```

onSpawnAddonComponent is called when a vehicle or object is spawned by a script. addon\_index is the internal index of the addon the object was spawned from (see mission functions below)

```
function onSpawnAddonComponent(object_id/vehicle_id, component_name, TYPE_STRING, addon_index)

	TYPE_STRING |
	"zone",
	"object",
	"character",
	"vehicle",
	"flare",
	"fire",
	"loot",
	"button",
	"animal"
	"ice"
```

onVehicleDamaged is called when a vehicle is damaged or repaired. Damage amount will be negative if the component is repaired. The voxel parameters refer to the voxel position on the vehicle that sustained the damage relative to the origin of the vehicle. body\_index is 0 for the main vehicle body, checking this parameter may be helpful for vehicles with sub bodies such as missiles that should be ignored.

```
function onVehicleDamaged(vehicle_id, damage_amount, voxel_x, voxel_y, voxel_z, body_index)
```

httpReply is called when a HTTP request has returned. The callback details the request and the received reply.

```
function httpReply(port, request, reply)
```

onFireExtinguished is called when a fire is extinguished. The returned coordinates represent the fire's world coordinates.

```
function onFireExtinguished(fire_x, fire_y, fire_z)
```

onForestFireSpawned is called when 5 or more trees are detected to be on fire within a small radius. The returned coordinates represent the fire's world coordinates. The objective ID is used to track separate forest fire events.

```
function onForestFireSpawned(fire_objective_id, fire_x, fire_y, fire_z)
```

onForestFireExtinguished is called when all trees within a forest fire objective have been extinguished. The returned coordinates represent the fire's world coordinates. The objective ID is used to track separate forest fire events.

```
function onForestFireExtinguished(fire_objective_id, fire_x, fire_y, fire_z)
```

Called when a tornado is spawned.

```
function onTornado(transform)
```

Called when a meteor is spawned.

```
function onMeteor(transform, magnitude)
```

Called when a tsunami is spawned.

```
function onTsunami(transform, magnitude)
```

Called when a whirlpool is spawned.

```
function onWhirlpool(transform, magnitude)
```

Called when a volcano is triggered.

```
function onVolcano(transform)
```

Called when an oil spill is updated, with the change (positive or negative) and the resulting total oil amount. Vehicle id is -1 for script command or oil tick updates.

```
function onOilSpill(tile_x, tile_y, delta, total, vehicle_id)
```

Called when oil is fully cleared via clearOilSpill or the creative menu button.

```
function onClearOilSpill()
```

以下に挙げるのは、スクリプトに追加して、特定の条件が満たされたときに自動的に呼び出されるコールバック関数です。最も単純なコールバック関数は onTick で、ゲームのティックごとに自動的に呼び出されます。

ゲームのティックごとに呼び出されます。game\_ticks は、このフレームで経過したティック数（通常は 1、睡眠中は400）を指します。

```
function onTick(game_ticks)
```

onCreate はスクリプトが初期化されたとき（ワールドの生成やロードのとき）に呼び出されます。is\_world\_create はワールド生成（最初のロード）のときだけ真になります。

```
function onCreate(is_world_create)
```

onDestroy はワールドが終了するたびに呼び出されます。

```
function onDestroy()
```

onCustomCommand はチャットにコマンドが入力されたときに呼び出されます。full\_message はスペースを含むメッセージ全体です。command は "?" を含む最初のパラメータです（例："?teleport"）。args ... はコマンドの可変引数です（明示的に宣言することもできます。以下の例を参照してください）。

```
function onCustomCommand(full_message, user_peer_id, is_admin, is_auth, command, args ...)
```

onChatMessage はチャットメッセージが投稿されたときに呼び出されます。

```
function onChatMessage(peer_id, sender_name, message)
```

onPlayerJoin はプレイヤーがゲームに参加したときに呼び出されます。

```
function onPlayerJoin(steam_id, name, peer_id, is_admin, is_auth)
```

onPlayerSit はプレイヤーがシートに座ったときに呼び出されます。

```
function onPlayerSit(peer_id, vehicle_id, seat_name)
```

onPlayerUnsit はプレイヤーがシートから降りたときに呼び出されます。

```
function onPlayerUnsit(peer_id, vehicle_id, seat_name)
```

onCharacterSit は任意のキャラクター（プレイヤーを含む）がシートに座ったときに呼び出されます。

```
function onCharacterSit(object_id, vehicle_id, seat_name)
```

onCharacterUnsit は任意のキャラクター（プレイヤーを含む）がシートから降りたときに呼び出されます。

```
function onCharacterUnsit(object_id, vehicle_id, seat_name)
```

onCharacterPickup は、キャラクターオブジェクトがキャラクターを担いだときに呼び出されます。

```
function onCharacterPickup(object_id_actor, object_id_target)
```

onCreatureSit は、任意の生き物がシートに座ったときに呼び出されます。

```
function onCreatureSit(object_id, vehicle_id, seat_name)
```

onCreatureUnsit は、任意の生き物がシートから降りたときに呼び出されます。

```
function onCreatureUnsit(object_id, vehicle_id, seat_name)
```

onCreaturePickup は、キャラクターオブジェクトが生き物を担いだときに呼び出されます。

```
function onCreaturePickup(object_id_actor, object_id_target, CREATURE_TYPE)
```

onEquipmentPickup は、キャラクターオブジェクトが装備品アイテムを拾ったときに呼び出されます。

```
function onEquipmentPickup(object_id_actor, object_id_target, EQUIPMENT_TYPE)
```

onEquipmentDrop は、キャラクターオブジェクトが装備品アイテムを捨てたときに呼び出されます。

```
function onEquipmentDrop(object_id_actor, object_id_target, EQUIPMENT_TYPE)
```

onPlayerRespawn はプレイヤーがリスポーンしたときに呼び出されます。

```
function onPlayerRespawn(peer_id)
```

onPlayerLeave はプレイヤーがゲームから退出するときに呼び出されます。

```
function onPlayerLeave(steam_id, name, peer_id, is_admin, is_auth)
```

onToggleMap はプレイヤーがマップを開いたり閉じたりするときに呼び出されます。is\_open はマップが開かれたかどうかを表します。

```
function onToggleMap(peer_id, is_open)
```

onPlayerDie はプレイヤーが死亡したときに呼び出されます。

```
function onPlayerDie(steam_id, name, peer_id, is_admin, is_auth)
```

onGroupSpawn はビークルグループがスポーンしたときに呼び出されます。グループがスクリプトによってスポーンされた場合、peer\_id は -1 になります。グループ内の全ビークルはスポーンした時点ではまだシミュレーションされていません。ローカルでビークルがロードされることで、初めてシミュレーションが開始できるようになります。コストは現在、プレイヤーがスポーンさせたビークルグループに対してのみ計算されます。x, y, z は、ワールド空間におけるグループのスポーン座標です。

```
function onGroupSpawn(group_id, peer_id, x, y, z, group_cost)
```

onVehicleSpawn はビークルがスポーンしたときに呼び出されます。ビークルがスクリプトによってスポーンされた場合、peer\_id は -1 になります。ビークルはスポーンした時点ではまだシミュレーションされていません。ローカルでビークルがロードされることで、初めてシミュレーションが開始できるようになります。コストは現在、プレイヤーがスポーンさせたビークルグループに対してのみ計算されます。x, y, z は、ワールド空間におけるグループのスポーン座標です。物理的に正確なサブマージ座標値を得るためには、ビークルがロードされ、物理演算が初期化される必要があります。この初期化された物理演算が、新しい基底座標として機能します。つまり、物理演算が生成されるまでは、ロードされていないビークルは常にグループの原点を自身の座標として扱います。

```
function onVehicleSpawn(vehicle_id, peer_id, x, y, z, group_cost, group_id)
```

onVehicleDespawn はビークルがデスポーンしたときに呼び出されます。スクリプトによってビークルがデスポーンされた場合、peer\_id は -1 となります。

```
function onVehicleDespawn(vehicle_id, peer_id)
```

onVehicleLoad は、ビークルがロードされ、シミュレーションの準備ができたときに呼び出されます。

```
function onVehicleLoad(vehicle_id)
```

onVehicleUnload は、ビークルがアンロードされ、シミュレーションが終了したときに呼び出されます。

```
function onVehicleUnload(vehicle_id)
```

onVehicleTeleport はビークルがテレポートされたとき、またはワークベンチに戻ったときに呼び出されます。ビークルがスクリプトによってテレポートされた場合、peer\_id は -1 になります。x, y, z はワールド空間における移動先の座標です。

```
function onVehicleTeleport(vehicle_id, peer_id, x, y, z)
```

onObjectLoad は、オブジェクト（キャラクター/小道具/動物）がロードされ、シミュレーションの準備ができたときに呼び出されます。

```
function onObjectLoad(object_id)
```

onObjectUnload は、オブジェクト（キャラクター/小道具/動物）がアンロードされ、シミュレーションが終了したときに呼び出されます。

```
function onObjectUnload(object_id)
```

onButtonPress はボタンが操作されたときに呼び出されます（ロックされたボタンでもトリガーされます）。ボタンの現在の状態を取得するには、getVehicleButton() を使用してください。

```
function onButtonPress(vehicle_id, peer_id, button_name, is_pressed)
```

onSpawnAddonComponent はビークルやオブジェクトがスクリプトによってスポーンされたときに呼び出されます。addon\_index はそのオブジェクトが格納されているアドオンの内部インデックスです（以下のミッション関数を参照）。

```
function onSpawnAddonComponent(object_id/vehicle_id, component_name, TYPE_STRING, addon_index)

	TYPE_STRING |
	"zone",
	"object",
	"character",
	"vehicle",
	"flare",
	"fire",
	"loot",
	"button",
	"animal"
	"ice"
```

onVehicleDamaged はビークルが損傷または修理されたときに呼び出されます。コンポーネントを修復した場合、ダメージ量はマイナスになります。ボクセルパラメータは、ビークルの原点を基準として、ダメージを受けたビークル上のボクセル座標を指します。body\_index は赤マージの場合 0 となります。ミサイルのようなサブマージへのダメージを無視するべき場合は、このパラメータを確認するとよいでしょう。

```
function onVehicleDamaged(vehicle_id, damage_amount, voxel_x, voxel_y, voxel_z, body_index)
```

httpReply は HTTP リクエストが返されたときに呼び出されます。このコールバックにはリクエストと受信したリプライの詳細が渡されます。

```
function httpReply(port, request, reply)
```

onFireExtinguished は火災が消火されたときに呼び出されます。渡される座標は火災のワールド座標を表しています。

```
function onFireExtinguished(fire_x, fire_y, fire_z)
```

onForestFireSpawned は小さな半径内で 5 本以上の木が燃えていることが検出されたときに呼び出されます。渡される座標は火災のワールド座標を表します。objective ID は個別の森林火災イベントを追跡するために使用されます。

```
function onForestFireSpawned(fire_objective_id, fire_x, fire_y, fire_z)
```

onForestFireExtinguished は森林火災対象内のすべての木が消火されたときに呼び出されます。渡される座標は火災のワールド座標を表します。objective ID は個別の森林火災イベントを追跡するために使用されます。

```
function onForestFireExtinguished(fire_objective_id, fire_x, fire_y, fire_z)
```

竜巻がスポーンしたときに呼び出されます。

```
function onTornado(transform)
```

メテオがスポーンしたときに呼び出されます。

```
function onMeteor(transform, magnitude)
```

津波がスポーンしたときに呼び出されます。

```
function onTsunami(transform, magnitude)
```

渦潮がスポーンしたときに呼び出されます。

```
function onWhirlpool(transform, magnitude)
```

噴火が発生したときに呼び出されます。

```
function onVolcano(transform)
```

石油の流出が更新されたときに、変化量（正または負）とその結果の総石油量とともに呼び出されます。スクリプトによる更新もしくはティック毎の変化の場合、vehicle\_id は -1 となります。

```
function onOilSpill(tile_x, tile_y, delta, total, vehicle_id)
```

clearOilSpill またはクリエイティブメニューボタンによって石油が完全に除去されたときに呼び出されます。

```
function onClearOilSpill()
```
