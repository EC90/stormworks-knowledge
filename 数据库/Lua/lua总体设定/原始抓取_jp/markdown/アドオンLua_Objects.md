---
wiki: sbarjp
page: アドオンLua/Objects
source_url: https://wikiwiki.jp/sbarjp/%E3%82%A2%E3%83%89%E3%82%AA%E3%83%B3Lua/Objects
last_modified: 2026-08-22
retrieved_at: 2026-08-31T01:11:52+0800
---

# アドオンLua/Objects

|  |
| --- |
| **このページはアドオン Lua のヘルプドキュメントの翻訳です。原文のバージョンは Stormworks v1.15.20（リリース日：2026/8/15）です。アドオン Lua はたびたびアップデートされています。正確な情報は公式のアップデート情報から確認してください。** |

## Player（プレイヤー）

英語原文

Returns a table containing info on all connected players.

```
PLAYER_LIST = server.getPlayers()

	PLAYER_LIST |
	{ [peer_index] = { ["id"] = peer_id, ["name"] = name, ["admin"] = is_admin, ["auth"] = is_auth, ["steam_id"] = steam_id }}
```

Returns the player name of the specified peer as it appears to the server.

```
name, is_success = server.getPlayerName(peer_id)
```

Gets the world position of a specified peer as a matrix.

```
transform_matrix, is_success = server.getPlayerPos(peer_id)
```

Teleports the specified player to the target world position.

```
is_success = server.setPlayerPos(peer_id, transform_matrix)
```

Returns the forward vector of the specified player's camera

```
x, y, z, is_success = server.getPlayerLookDirection(peer_id)
```

接続されているすべてのプレイヤーに関する情報を含むテーブルを返します。  
訳注：object\_id は原文には載っていませんが利用可能です。object\_id は状況によっては nil となるようです。（v1.13.1で確認）

```
PLAYER_LIST = server.getPlayers()

	PLAYER_LIST |
	{ [peer_index] = { ["id"] = peer_id, ["name"] = name, ["admin"] = is_admin, ["auth"] = is_auth, ["steam_id"] = steam_id, ["object_id"] = object_id }}
```

指定されたピアの、サーバーに表示されるプレイヤー名を返します。

```
name, is_success = server.getPlayerName(peer_id)
```

指定したピアのワールド座標を行列で取得します。

```
transform_matrix, is_success = server.getPlayerPos(peer_id)
```

指定されたプレイヤーを対象のワールド座標にテレポートさせます。

```
is_success = server.setPlayerPos(peer_id, transform_matrix)
```

指定されたプレイヤーのカメラの前方ベクトルを返します。

```
x, y, z, is_success = server.getPlayerLookDirection(peer_id)
```

## Objects（オブジェクト）

英語原文

All dynamic objects in Stormworks have an object ID, Player characters have ownership of a dynamic object that can be manipulated with the following functions just like any NPC or physics object. Please note that peer\_id and object\_id are separate systems; the following function can convert from peer id to object id to allow manipulation of player characters.

Get a specified player's character object id.

```
object_id, is_success = server.getPlayerCharacterID(peer_id)
```

Spawn the specified object at the specified world position.

```
object_id, is_success = server.spawnObject(transform_matrix, OBJECT_TYPE)

	OBJECT_TYPE |
	0 = none,
	1 = character,
	2 = crate_small,
	3 = collectable, (Not spawnable)
	4 = basketball,
	5 = television,
	6 = barrel,
	7 = schematic,  (Not spawnable)
	8 = debris,  (Not spawnable)
	9 = chair,
	10 = trolley_food,
	11 = trolley_med,
	12 = clothing,  (Not spawnable)
	13 = office_chair,
	14 = book,
	15 = bottle,
	16 = fryingpan,
	17 = mug,
	18 = saucepan,
	19 = stool,
	20 = telescope,
	21 = log,
	22 = bin,
	23 = book_2,
	24 = loot,
	25 = blue_barrel,
	26 = buoyancy_ring,
	27 = container,
	28 = gas_canister,
	29 = pallet,
	30 = storage_bin,
	31 = fire_extinguisher,
	32 = trolley_tool,
	33 = cafetiere,
	34 = drawers_tools,
	35 = glass,
	36 = microwave,
	37 = plate,
	38 = box_closed,
	39 = box_open,
	40 = desk_lamp,
	41 = eraser_board,
	42 = folder,
	43 = funnel,
	44 = lamp,
	45 = microscope,
	46 = notebook,
	47 = pen_marker,
	48 = pencil,
	49 = scales,
	50 = science_beaker,
	51 = science_cylinder,
	52 = science_flask,
	53 = tub_1,
	54 = tub_2,
	55 = filestack,
	56 = barrel_toxic,
	57 = flare,
	58 = fire,
	59 = animal,
	60 = map_label,  (Not spawnable)
	61 = iceberg,  (Not spawnable)
	62 = gun_flare,
	63 = vehicle_flare,
	64 = ammo_shell,
	65 = binoculars,
	66 = C4,
	67 = grenade,
	68 = vehicle_flare,
	69 = coal/resource,
	70 = meteorite,
	71 = glowstick,
	72 = creature,
	73 = drill_rod,
	74 = fishing_lure,
```

Spawn a world fire at the specified world position matrix. parent\_vehicle\_id should be 0 if the fire should not move relative to a vehicle. Fires will slowly grow until they reach 1 magnitude.

```
object_id, is_success = server.spawnFire(transform_matrix, fire_size, fire_magnitude, is_lit, is_explosive, parent_vehicle_id, explosion_magnitude)
```

Spawn a character object with an optional outfit at the specified world postion.

```
object_id, is_success = server.spawnCharacter(transform_matrix, (OUTFIT_TYPE))

	OUTFIT_TYPE |
	0 = none,
	1 = worker,
	2 = fishing,
	3 = waiter,
	4 = swimsuit,
	5 = military,
	6 = office,
	7 = police,
	8 = science,
	9 = medical,
	10 = wetsuit,
	11 = civilian
```

Spawn a scenery animal at the specified world postion.

```
object_id, is_success = server.spawnAnimal(transform_matrix, ANIMAL_TYPE, size_multiplier)

	ANIMAL_TYPE |
	0 = shark,
	1 = whale,
	4 = kraken
```

[Requires Industrial Frontier DLC to be enabled] Spawn an animal/creature at the specified world postion.

```
object_id, is_success = server.spawnCreature(transform_matrix, CREATURE_TYPE, size_multiplier)

	CREATURE_TYPE |
	0 = badger_common,
	1 = bear_grizzly,
	2 = bear_black,
	3 = bear_polar,
	4 = chicken_barnevelder,
	5 = chicken_marans,
	6 = chicken_orpington_fowl,
	7 = chicken_sussex_fowl,
	8 = cow_angus,
	9 = cow_hereford,
	10 = cow_highland,
	11 = cow_holstein,
	12 = sasquatch,
	13 = yeti
	14 = deer_red_f,
	15 = deer_red_m,
	16 = deer_sika_f,
	17 = deer_sika_m,
	18 = dog_beagle,
	19 = dog_border_collie,
	20 = dog_boxer,
	21 = dog_corgi,
	22 = dog_dachschund,
	23 = dog_dalmatian,
	24 = dog_dobermann,
	25 = dog_german_shepherd,
	26 = dog_greyhound,
	27 = dog_jack_russell,
	28 = dog_labrador,
	29 = dog_newfoundland,
	30 = dog_pug,
	31 = dog_shiba,
	32 = dog_siberian_husky,
	33 = dog_st_bernard,
	34 = dog_vizsla,
	35 = dog_yorkshire_terrier,
	36 = fox_red,
	37 = fox_arctic,
	38 = goat_alpine,
	39 = goat_bengal,
	40 = goat_oberhasli,
	41 = goat_saanen,
	42 = hare_arctic,
	43 = hare_irish,
	44 = hare_mountain,
	45 = horse_clydesdale,
	46 = horse_friesian,
	47 = horse_haflinger,
	48 = horse_welara,
	49 = muntjac_f,
	50 = muntjac_m,
	51 = penguin_gentoo,
	52 = pig_angeln_saddleback,
	53 = pig_old_spot,
	54 = pig_tamworth,
	55 = pig_yorkshire,
	56 = seal_polar,
	57 = sheep_black_nose,
	58 = sheep_highlander,
	59 = sheep_mule,
	60 = wildcat_scottish,
	61 = wolf_arctic,
	62 = wolf_costal,
	63 = wolf_plains,

	64 = zombie_male,
	65 = zombie_male_a,
	66 = zombie_male_b,
	67 = zombie_male_c,
	68 = zombie_male_d,
	69 = zombie_male_e,
	70 = zombie_male_f,
	71 = zombie_male_g,
	72 = zombie_male_nurse,
	73 = zombie_male_arctic,
	74 = zombie_male_firefighter,
	75 = zombie_male_pilot,
	76 = zombie_male_police,
	77 = zombie_male_ranger,
	78 = zombie_male_scuba,
	79 = zombie_male_tree_surgeon,
	80 = zombie_female,
	81 = zombie_female_a,
	82 = zombie_female_b,
	83 = zombie_female_c,
	84 = zombie_female_d,
	85 = zombie_female_e,
	86 = zombie_female_f,
	87 = zombie_female_arctic,
	88 = zombie_female_firefighter,
	89 = zombie_female_hazmat,
	90 = zombie_female_pilot,
	91 = zombie_female_pirate,
	92 = zombie_female_police,
	93 = zombie_female_safari,
	94 = zombie_female_sar,
	95 = zombie_female_scuba,
	96 = zombie_female_surgeon,
	97 = buffalo,
	98 = sheep_bighorn,
	99 = roadrunner,
    100 = lion_mountain,
    101 = crocodile,
    102 = coyote,
    103 = gila_monster,
    104 = tortoise_desert,
```

[Requires Industrial Frontier DLC to be enabled] Set the next target position for a creature to path towards.

```
is_success = server.setCreatureMoveTarget(object_id, transform_matrix)
```

Spawns an equipment item dynamic object or fish. Fish do not retain an object\_id as they are spawned as part of the wildlife system.

```
object_id, is_success = server.spawnEquipment(transform_matrix, EQUIPMENT_TYPE, int, float)

	EQUIPMENT_TYPE |
Outfits
	0 = none,
	1 = diving,
	2 = firefighter,
	3 = scuba,
	4 = parachute, [int = {0 = deployed, 1 = ready}]
	5 = arctic,
	29 = hazmat,
	74 = bomb_disposal,
	75 = chest_rig,
	76 = black_hawk_vest
	77 = plate_vest,
	78 = armor_vest,
	79 = space_suit,
	80 = space_suit_exploration,
	149 = firefighter_scba
Items
	6 = binoculars,
	7 = cable,
	8 = compass,
	9 = defibrillator, [int = charges]
	10 = fire_extinguisher, [float = ammo]
	11 = first_aid, [int = charges]
	12 = flare, [int = charges]
	13 = flaregun, [int = ammo]
	14 = flaregun_ammo, [int = ammo]
	15 = flashlight, [float = battery]
	16 = hose, [int = {0 = hose off, 1 = hose on}]
	17 = night_vision_binoculars, [float = battery]
	18 = oxygen_mask, [float = oxygen]
	19 = radio, [int = channel] [float = battery]
	20 = radio_signal_locator, [float = battery]
	21 = remote_control, [int = channel] [float = battery]
	22 = rope, [int = {0 = default length, 1 = 1m, 2 = 2m, 3 = 4m, 4 = 8m, 5 = 16m}]
	23 = strobe_light, [int = {0 = off, 1 = on}] [float = battery]
	24 = strobe_light_infrared, [int = {0 = off, 1 = on}] [float = battery]
	25 = transponder, [int = {0 = off, 1 = on}] [float = battery]
	26 = underwater_welding_torch, [float = charge]
	27 = welding_torch, [float = charge]
	28 = coal/ore/ingot,
	30 = radiation_detector, [float = battery]
	31 = c4, [int = ammo]
	32 = c4_detonator,
	33 = speargun, [int = ammo]
	34 = speargun_ammo,
	35 = pistol, [int = ammo]
	36 = pistol_ammo,
	37 = smg, [int = ammo]
	38 = smg_ammo,
	39 = rifle, [int = ammo]
	40 = rifle_ammo,
	41 = grenade, [int = ammo]
	42 = machine_gun_ammo_box_k,
	43 = machine_gun_ammo_box_he,
	44 = machine_gun_ammo_box_he_frag,
	45 = machine_gun_ammo_box_ap,
	46 = machine_gun_ammo_box_i,
	47 = light_auto_ammo_box_k,
	48 = light_auto_ammo_box_he,
	49 = light_auto_ammo_box_he_frag,
	50 = light_auto_ammo_box_ap,
	51 = light_auto_ammo_box_i,
	52 = rotary_auto_ammo_box_k,
	53 = rotary_auto_ammo_box_he,
	54 = rotary_auto_ammo_box_he_frag,
	55 = rotary_auto_ammo_box_ap,
	56 = rotary_auto_ammo_box_i,
	57 = heavy_auto_ammo_box_k,
	58 = heavy_auto_ammo_box_he,
	59 = heavy_auto_ammo_box_he_frag,
	60 = heavy_auto_ammo_box_ap,
	61 = heavy_auto_ammo_box_i,
	62 = battle_shell_k,
	63 = battle_shell_he,
	64 = battle_shell_he_frag,
	65 = battle_shell_ap,
	66 = battle_shell_i,
	67 = artillery_shell_k,
	68 = artillery_shell_he,
	69 = artillery_shell_he_frag,
	70 = artillery_shell_ap,
	71 = artillery_shell_i,
	72 = glowstick,
	73 = dog_whistle,
	81 = fishing_rod
	150 = machine_gun_ammo_box_k_large,
	151 = machine_gun_ammo_box_he_large,
	152 = machine_gun_ammo_box_he_frag_large,
	153 = machine_gun_ammo_box_ap_large,
	154 = machine_gun_ammo_box_i_large,
Fish
	82 = anchovie, [int = fish_state {0 = idle, 1 = flee, 2 = flop, 3 = dead}]
	83 = anglerfish,
	84 = arctic_char,
	85 = ballan_lizardfish,
	86 = ballan_wrasse,
	87 = barreleye_fish,
	88 = black_bream,
	89 = black_dragonfish,
	90 = clown_fish,
	91 = cod,
	92 = dolphinfish,
	93 = gulper_eel,
	94 = haddock,
	95 = hake,
	96 = herring,
	97 = john_dory,
	98 = labrus,
	99 = lanternfish,
	100 = mackerel,
	101 = midshipman,
	102 = perch,
	103 = pike,
	104 = pinecone_fish,
	105 = pollack,
	106 = red_mullet,
	107 = rockfish,
	108 = sablefish,
	109 = salmon,
	110 = sardine,
	111 = scad,
	112 = sea_bream,
	113 = sea_halibut,
	114 = sea_piranha,
	115 = seabass,
	116 = slimehead,
	117 = snapper,
	118 = snapper_gold,
	119 = snook,
	120 = spadefish,
	121 = trout,
	122 = tubeshoulders_fish,
	123 = viperfish,
	124 = yellowfin_tuna,
	125 = blue crab,
	126 = brown_box_crab,
	127 = coconut_crab,
	128 = dungeness_crab,
	129 = furry_lobster,
	130 = homarus_americanus, (Atlantic Lobster)
	131 = homarus_gammarus, (Common Lobster)
	132 = horseshoe_crab,
	133 = jasus_edwardsii, (Red Rock Lobster)
	134 = jasus_lalandii, (Cape Rock Lobster)
	135 = jonah_crab,
	136 = king_crab,
	137 = mud_crab,
	138 = munida_lobster,
	139 = ornate_rock_lobster,
	140 = panulirus_interruptus,
	141 = red_king_crab,
	142 = reef_lobster,
	143 = slipper_lobster,
	144 = snow_crab,
	145 = southern_rock_lobster,
	146 = spider_crab,
	147 = spiny_lobster,
	148 = stone_crab,
```

Despawn the specified object when it is out of a player's range. is\_instant will instantly despawn the object.

```
is_success = server.despawnObject(object_id, is_instant)
```

Get the world position of a specified object. is\_success returns false if the object cannot be found.

```
transform_matrix, is_success = server.getObjectPos(object_id)
```

Get the simulating state of a specified object. is\_success returns false if the object cannot be found.

```
is_simulating, is_success = server.getObjectSimulating(object_id)
```

Set the world position of a specified object. is\_success returns false if the object cannot be found.

```
is_success = server.setObjectPos(object_id, transform_matrix)
```

Set data for an existing world fire using its object\_id.

```
server.setFireData(object_id, is_lit, is_explosive)
```

Get data for a world fire using its object\_id.

```
is_lit, is_success = server.getFireData(object_id)
```

Kills the target character.

```
server.killCharacter(object_id)
```

Revives the target character.

```
server.reviveCharacter(object_id)
```

Sets the target character (or sit-able creature) to be seated in the first seat with the specified name found on the specified vehicle. Aliases: setCharacterSeated, setCreatureSeated

```
server.setSeated(object_id, vehicle_id, seat_name)
```

Sets the target character (or sit-able creature) to be seated in the seat with the specified voxel position found on the specified vehicle. Aliases: setCharacterSeated, setCreatureSeated

```
server.setSeated(object_id, vehicle_id, x, y, z)
```

Get character data for a specified character object. Returns a table if successful and nil upon failure. (Aliased to getCharacterData())

```
OBJECT_DATA = server.getObjectData(object_id)

	OBJECT_DATA = {
		["object_type"] = OBJECT_TYPE
		["hp"] = hp,
		["incapacitated"] = is_incapacitated,
		["dead"] = is_dead,
		["interactable"] = is_interactable,
		["ai"] = is_ai,
		["name"] = name,
		["creature_type"] = CREATURE_TYPE,
		["scale"] = scale,
	}
```

Get the current vehicle\_id for a specified character object.

```
vehicle_id, is_success = server.getCharacterVehicle(object_id)
```

Set character data for a specified character object. Non-interactable characters are frozen in place and cannot be moved. is\_interactable has no effect on Player characters.

```
server.setCharacterData(object_id, hp, is_interactable, is_ai)
```

Sets the display name for a non-player character or creature.

```
is_success = server.setCharacterTooltip(object_id, display_name)
is_success = server.setCreatureTooltip(object_id, display_name)
```

Set the item slot data for a specified character object. Certain equipments hold data that can be initialized as detailed below.

```
is_success = server.setCharacterItem(object_id, SLOT_NUMBER, EQUIPMENT_TYPE, is_active, [integer_value], [float_value])

    SLOT_NUMBER |
    1 = Large Equipment Slot,
    2, 3, 4, 5, 6, 7, 8, 9 = Small Equipment Slot,
    10 = Outfit Slot
```

Get the item in the specified slot for a specified character object.

```
EQUIPMENT_TYPE, is_success = server.getCharacterItem(object_id, SLOT_NUMBER)
```

Stormworks のすべての動的オブジェクトには、オブジェクト ID が設定されています。プレイヤーキャラクターは動的オブジェクトの所有権を持っており、この動的オブジェクトは NPC や物理オブジェクトと同様に以下の関数で操作することができます。なお、peer\_id と object\_id は別のシステムです。以下の関数で peer\_id から object\_id に変換し、プレイヤーキャラクターを操作できるようにすることが可能です。

指定されたプレイヤーのキャラクターオブジェクト ID を取得します。

```
object_id, is_success = server.getPlayerCharacterID(peer_id)
```

指定されたオブジェクトを指定されたワールド座標にスポーンさせます。

```
object_id, is_success = server.spawnObject(transform_matrix, OBJECT_TYPE)

	OBJECT_TYPE |
	0 = none,
	1 = character,
	2 = crate_small,
	3 = collectable, （スポーン不可）
	4 = basketball,
	5 = television,
	6 = barrel,
	7 = schematic,  （スポーン不可）
	8 = debris,  （スポーン不可）
	9 = chair,
	10 = trolley_food,
	11 = trolley_med,
	12 = clothing,  （スポーン不可）
	13 = office_chair,
	14 = book,
	15 = bottle,
	16 = fryingpan,
	17 = mug,
	18 = saucepan,
	19 = stool,
	20 = telescope,
	21 = log,
	22 = bin,
	23 = book_2,
	24 = loot,
	25 = blue_barrel,
	26 = buoyancy_ring,
	27 = container,
	28 = gas_canister,
	29 = pallet,
	30 = storage_bin,
	31 = fire_extinguisher,
	32 = trolley_tool,
	33 = cafetiere,
	34 = drawers_tools,
	35 = glass,
	36 = microwave,
	37 = plate,
	38 = box_closed,
	39 = box_open,
	40 = desk_lamp,
	41 = eraser_board,
	42 = folder,
	43 = funnel,
	44 = lamp,
	45 = microscope,
	46 = notebook,
	47 = pen_marker,
	48 = pencil,
	49 = scales,
	50 = science_beaker,
	51 = science_cylinder,
	52 = science_flask,
	53 = tub_1,
	54 = tub_2,
	55 = filestack,
	56 = barrel_toxic,
	57 = flare,
	58 = fire,
	59 = animal,
	60 = map_label,  （スポーン不可）
	61 = iceberg,  （スポーン不可）
	62 = gun_flare,
	63 = vehicle_flare,
	64 = ammo_shell,
	65 = binoculars,
	66 = C4,
	67 = grenade,
	68 = vehicle_flare,
	69 = coal/resource,
	70 = meteorite,
	71 = glowstick,
	72 = creature,
	73 = drill_rod,
	74 = fishing_lure,
```

指定されたワールド座標行列でワールド火災をスポーンさせます。火災がビークルに対して相対的に移動してはならない場合、parent\_vehicle\_id は 0 であるべきです。火災は 1 マグニチュードになるまでゆっくりと成長します。

```
object_id, is_success = server.spawnFire(transform_matrix, fire_size, fire_magnitude, is_lit, is_explosive, parent_vehicle_id, explosion_magnitude)
```

指定されたワールド座標で、任意の衣装を着たキャラクターオブジェクトをスポーンさせます。

```
object_id, is_success = server.spawnCharacter(transform_matrix, (OUTFIT_TYPE))

	OUTFIT_TYPE |
	0 = none,
	1 = worker,
	2 = fishing,
	3 = waiter,
	4 = swimsuit,
	5 = military,
	6 = office,
	7 = police,
	8 = science,
	9 = medical,
	10 = wetsuit,
	11 = civilian
```

指定されたワールド座標にシーン動物をスポーンさせます。

```
object_id, is_success = server.spawnAnimal(transform_matrix, ANIMAL_TYPE, size_multiplier)

	ANIMAL_TYPE |
	0 = shark,
	1 = whale,
	4 = kraken
```

[Industrial Frontier DLC を有効化する必要があります] 指定されたワールド座標に動物/生き物をスポーンさせます。

```
object_id, is_success = server.spawnCreature(transform_matrix, CREATURE_TYPE, size_multiplier)

	CREATURE_TYPE |
	0 = badger_common,
	1 = bear_grizzly,
	2 = bear_black,
	3 = bear_polar,
	4 = chicken_barnevelder,
	5 = chicken_marans,
	6 = chicken_orpington_fowl,
	7 = chicken_sussex_fowl,
	8 = cow_angus,
	9 = cow_hereford,
	10 = cow_highland,
	11 = cow_holstein,
	12 = sasquatch,
	13 = yeti
	14 = deer_red_f,
	15 = deer_red_m,
	16 = deer_sika_f,
	17 = deer_sika_m,
	18 = dog_beagle,
	19 = dog_border_collie,
	20 = dog_boxer,
	21 = dog_corgi,
	22 = dog_dachschund,
	23 = dog_dalmatian,
	24 = dog_dobermann,
	25 = dog_german_shepherd,
	26 = dog_greyhound,
	27 = dog_jack_russell,
	28 = dog_labrador,
	29 = dog_newfoundland,
	30 = dog_pug,
	31 = dog_shiba,
	32 = dog_siberian_husky,
	33 = dog_st_bernard,
	34 = dog_vizsla,
	35 = dog_yorkshire_terrier,
	36 = fox_red,
	37 = fox_arctic,
	38 = goat_alpine,
	39 = goat_bengal,
	40 = goat_oberhasli,
	41 = goat_saanen,
	42 = hare_arctic,
	43 = hare_irish,
	44 = hare_mountain,
	45 = horse_clydesdale,
	46 = horse_friesian,
	47 = horse_haflinger,
	48 = horse_welara,
	49 = muntjac_f,
	50 = muntjac_m,
	51 = penguin_gentoo,
	52 = pig_angeln_saddleback,
	53 = pig_old_spot,
	54 = pig_tamworth,
	55 = pig_yorkshire,
	56 = seal_polar,
	57 = sheep_black_nose,
	58 = sheep_highlander,
	59 = sheep_mule,
	60 = wildcat_scottish,
	61 = wolf_arctic,
	62 = wolf_costal,
	63 = wolf_plains,

	64 = zombie_male,
	65 = zombie_male_a,
	66 = zombie_male_b,
	67 = zombie_male_c,
	68 = zombie_male_d,
	69 = zombie_male_e,
	70 = zombie_male_f,
	71 = zombie_male_g,
	72 = zombie_male_nurse,
	73 = zombie_male_arctic,
	74 = zombie_male_firefighter,
	75 = zombie_male_pilot,
	76 = zombie_male_police,
	77 = zombie_male_ranger,
	78 = zombie_male_scuba,
	79 = zombie_male_tree_surgeon,
	80 = zombie_female,
	81 = zombie_female_a,
	82 = zombie_female_b,
	83 = zombie_female_c,
	84 = zombie_female_d,
	85 = zombie_female_e,
	86 = zombie_female_f,
	87 = zombie_female_arctic,
	88 = zombie_female_firefighter,
	89 = zombie_female_hazmat,
	90 = zombie_female_pilot,
	91 = zombie_female_pirate,
	92 = zombie_female_police,
	93 = zombie_female_safari,
	94 = zombie_female_sar,
	95 = zombie_female_scuba,
	96 = zombie_female_surgeon,
	97 = buffalo,
	98 = sheep_bighorn,
	99 = roadrunner,
    100 = lion_mountain,
    101 = crocodile,
    102 = coyote,
    103 = gila_monster,
    104 = tortoise_desert,
```

[Industrial Frontier DLC を有効化する必要があります] 生き物が次に向かう目標座標を設定します。

```
is_success = server.setCreatureMoveTarget(object_id, transform_matrix)
```

装備アイテムの動的オブジェクトまたは魚をスポーンさせます。魚は野生生物システムの一部としてスポーンするため、object\_id を保持しません。

```
object_id, is_success = server.spawnEquipment(transform_matrix, EQUIPMENT_TYPE, int, float)

	EQUIPMENT_TYPE |
Outfits
	0 = none,
	1 = diving,
	2 = firefighter,
	3 = scuba,
	4 = parachute, [int = {0 = deployed, 1 = ready}]
	5 = arctic,
	29 = hazmat,
	74 = bomb_disposal,
	75 = chest_rig,
	76 = black_hawk_vest
	77 = plate_vest,
	78 = armor_vest,
	79 = space_suit,
	80 = space_suit_exploration,
	149 = firefighter_scba
Items
	6 = binoculars,
	7 = cable,
	8 = compass,
	9 = defibrillator, [int = charges]
	10 = fire_extinguisher, [float = ammo]
	11 = first_aid, [int = charges]
	12 = flare, [int = charges]
	13 = flaregun, [int = ammo]
	14 = flaregun_ammo, [int = ammo]
	15 = flashlight, [float = battery]
	16 = hose, [int = {0 = hose off, 1 = hose on}]
	17 = night_vision_binoculars, [float = battery]
	18 = oxygen_mask, [float = oxygen]
	19 = radio, [int = channel] [float = battery]
	20 = radio_signal_locator, [float = battery]
	21 = remote_control, [int = channel] [float = battery]
	22 = rope, [int = {0 = default length, 1 = 1m, 2 = 2m, 3 = 4m, 4 = 8m, 5 = 16m}]
	23 = strobe_light, [int = {0 = off, 1 = on}] [float = battery]
	24 = strobe_light_infrared, [int = {0 = off, 1 = on}] [float = battery]
	25 = transponder, [int = {0 = off, 1 = on}] [float = battery]
	26 = underwater_welding_torch, [float = charge]
	27 = welding_torch, [float = charge]
	28 = coal/ore/ingot,
	30 = radiation_detector, [float = battery]
	31 = c4, [int = ammo]
	32 = c4_detonator,
	33 = speargun, [int = ammo]
	34 = speargun_ammo,
	35 = pistol, [int = ammo]
	36 = pistol_ammo,
	37 = smg, [int = ammo]
	38 = smg_ammo,
	39 = rifle, [int = ammo]
	40 = rifle_ammo,
	41 = grenade, [int = ammo]
	42 = machine_gun_ammo_box_k,
	43 = machine_gun_ammo_box_he,
	44 = machine_gun_ammo_box_he_frag,
	45 = machine_gun_ammo_box_ap,
	46 = machine_gun_ammo_box_i,
	47 = light_auto_ammo_box_k,
	48 = light_auto_ammo_box_he,
	49 = light_auto_ammo_box_he_frag,
	50 = light_auto_ammo_box_ap,
	51 = light_auto_ammo_box_i,
	52 = rotary_auto_ammo_box_k,
	53 = rotary_auto_ammo_box_he,
	54 = rotary_auto_ammo_box_he_frag,
	55 = rotary_auto_ammo_box_ap,
	56 = rotary_auto_ammo_box_i,
	57 = heavy_auto_ammo_box_k,
	58 = heavy_auto_ammo_box_he,
	59 = heavy_auto_ammo_box_he_frag,
	60 = heavy_auto_ammo_box_ap,
	61 = heavy_auto_ammo_box_i,
	62 = battle_shell_k,
	63 = battle_shell_he,
	64 = battle_shell_he_frag,
	65 = battle_shell_ap,
	66 = battle_shell_i,
	67 = artillery_shell_k,
	68 = artillery_shell_he,
	69 = artillery_shell_he_frag,
	70 = artillery_shell_ap,
	71 = artillery_shell_i,
	72 = glowstick,
	73 = dog_whistle,
	81 = fishing_rod
	150 = machine_gun_ammo_box_k_large,
	151 = machine_gun_ammo_box_he_large,
	152 = machine_gun_ammo_box_he_frag_large,
	153 = machine_gun_ammo_box_ap_large,
	154 = machine_gun_ammo_box_i_large,
Fish
	82 = anchovie, [int = fish_state {0 = idle, 1 = flee, 2 = flop, 3 = dead}]
	83 = anglerfish,
	84 = arctic_char,
	85 = ballan_lizardfish,
	86 = ballan_wrasse,
	87 = barreleye_fish,
	88 = black_bream,
	89 = black_dragonfish,
	90 = clown_fish,
	91 = cod,
	92 = dolphinfish,
	93 = gulper_eel,
	94 = haddock,
	95 = hake,
	96 = herring,
	97 = john_dory,
	98 = labrus,
	99 = lanternfish,
	100 = mackerel,
	101 = midshipman,
	102 = perch,
	103 = pike,
	104 = pinecone_fish,
	105 = pollack,
	106 = red_mullet,
	107 = rockfish,
	108 = sablefish,
	109 = salmon,
	110 = sardine,
	111 = scad,
	112 = sea_bream,
	113 = sea_halibut,
	114 = sea_piranha,
	115 = seabass,
	116 = slimehead,
	117 = snapper,
	118 = snapper_gold,
	119 = snook,
	120 = spadefish,
	121 = trout,
	122 = tubeshoulders_fish,
	123 = viperfish,
	124 = yellowfin_tuna,
	125 = blue crab,
	126 = brown_box_crab,
	127 = coconut_crab,
	128 = dungeness_crab,
	129 = furry_lobster,
	130 = homarus_americanus, (Atlantic Lobster)
	131 = homarus_gammarus, (Common Lobster)
	132 = horseshoe_crab,
	133 = jasus_edwardsii, (Red Rock Lobster)
	134 = jasus_lalandii, (Cape Rock Lobster)
	135 = jonah_crab,
	136 = king_crab,
	137 = mud_crab,
	138 = munida_lobster,
	139 = ornate_rock_lobster,
	140 = panulirus_interruptus,
	141 = red_king_crab,
	142 = reef_lobster,
	143 = slipper_lobster,
	144 = snow_crab,
	145 = southern_rock_lobster,
	146 = spider_crab,
	147 = spiny_lobster,
	148 = stone_crab,
```

指定されたオブジェクトがプレイヤーの範囲外にあるとき、そのオブジェクトをデスポーンさせます。is\_instant はオブジェクトを即座にデスポーンさせます。

```
is_success = server.despawnObject(object_id, is_instant)
```

指定されたオブジェクトのワールド座標を取得します。is\_success はオブジェクトが見つからない場合 false を返します。

```
transform_matrix, is_success = server.getObjectPos(object_id)
```

指定されたオブジェクトのシミュレーション状態を取得します。is\_success はオブジェクトが見つからない場合 false を返します。

```
is_simulating, is_success = server.getObjectSimulating(object_id)
```

指定されたオブジェクトのワールド座標を設定します。is\_success はオブジェクトが見つからない場合 false を返します。

```
is_success = server.setObjectPos(object_id, transform_matrix)
```

既存のワールド火災のデータを object\_id を使って設定します。

```
server.setFireData(object_id, is_lit, is_explosive)
```

ワールド火災のデータを object\_id を使って取得します。

```
is_lit, is_success = server.getFireData(object_id)
```

対象のキャラクターを死亡させます。

```
server.killCharacter(object_id)
```

対象のキャラクターを復活させます。

```
server.reviveCharacter(object_id)
```

指定されたビークルで最初に見つかった指定された名前のシートに、対象キャラクター（または座れる生き物）を座らせるように設定します。エイリアス：setCharacterSeated, setCreatureSeated

```
server.setSeated(object_id, vehicle_id, seat_name)
```

指定されたビークルで、指定されたボクセル座標のシートに対象キャラクター（または座れる生き物）を座らせるように設定します。エイリアス：setCharacterSeated, setCreatureSeated

```
server.setSeated(object_id, vehicle_id, x, y, z)
```

指定されたキャラクターオブジェクトのキャラクターデータを取得します。成功した場合はテーブルを、失敗した場合は nil を返します。（getCharacterData() のエイリアスです）

```
OBJECT_DATA = server.getObjectData(object_id)

	OBJECT_DATA = {
		["object_type"] = OBJECT_TYPE
		["hp"] = hp,
		["incapacitated"] = is_incapacitated,
		["dead"] = is_dead,
		["interactable"] = is_interactable,
		["ai"] = is_ai,
		["name"] = name,
		["creature_type"] = CREATURE_TYPE,
		["scale"] = scale,
	}
```

指定されたキャラクターオブジェクトの現在の vehicle\_id を取得します。

```
vehicle_id, is_success = server.getCharacterVehicle(object_id)
```

指定されたキャラクターオブジェクトにキャラクターデータを設定します。is\_interactable が false のキャラクターは、その場に固定され、移動することはできません。is\_interactable は、プレイヤーキャラクターには効果がありません。

```
server.setCharacterData(object_id, hp, is_interactable, is_ai)
```

NPCや生き物の表示名を設定します。

```
is_success = server.setCharacterTooltip(object_id, display_name)
is_success = server.setCreatureTooltip(object_id, display_name)
```

指定されたキャラクターオブジェクトのアイテムスロットデータを設定します。一部の装備品には、以下のような初期化可能なデータがあります。

```
is_success = server.setCharacterItem(object_id, SLOT_NUMBER, EQUIPMENT_TYPE, is_active, [integer_value], [float_value])

    SLOT_NUMBER |
    1 = 大きい装備品スロット,
    2, 3, 4, 5, 6, 7, 8, 9 = 小さい装備品スロット,
    10 = 衣装スロット
```

指定されたキャラクターオブジェクトの指定されたスロットにあるアイテムを取得します。

```
EQUIPMENT_TYPE, is_success = server.getCharacterItem(object_id, SLOT_NUMBER)
```
