---
wiki: sbarjp
page: アドオンLua/Vehicles
source_url: https://wikiwiki.jp/sbarjp/%E3%82%A2%E3%83%89%E3%82%AA%E3%83%B3Lua/Vehicles
last_modified: 2026-08-22
retrieved_at: 2026-08-31T01:11:38+0800
---

# アドオンLua/Vehicles

|  |
| --- |
| **このページはアドオン Lua のヘルプドキュメントの翻訳です。原文のバージョンは Stormworks v1.15.20（リリース日：2026/8/15）です。アドオン Lua はたびたびアップデートされています。正確な情報は公式のアップデート情報から確認してください。** |

## Vehicles（ビークル）

英語原文

Spawns a vehicle component from a specific addon. See getLocationComponentData() for info on how to get component\_id. group\_vehicles is a table listing all vehicle ids in this group.

```
vehicle_id, is_success, group_vehicles, group_id = server.spawnAddonVehicle(transform_matrix, addon_index, component_id)
```

Spawns a vehicle from local appdata using its file name. group\_vehicles is a table listing all vehicle ids in this group.

```
vehicle_id, is_success, group_vehicles, group_id = server.spawnVehicle(transform_matrix, save_name)
```

Sets a vehicle to despawn when out of a player's range. If is\_instant the vehicle will instantly despawn no matter the player's proximity.

```
is_success = server.despawnVehicle(vehicle_id, is_instant)
```

Sets a all vehicles in a vehicle group to despawn when out of a player's range. If is\_instant the vehicles will instantly despawn no matter the player's proximity.

```
is_success = server.despawnVehicleGroup(group_id, is_instant)
```

Gets the world position of the center of a vehicle's main body. Optionally passing a voxel position will return the world position of the specified voxel on the vehicle.

```
transform_matrix, is_success = server.getVehiclePos(vehicle_id, [voxel_x, voxel_y, voxel_z])
```

Converts a world transform to an astronomy transform. Used for navigating in Space.

```
astronomy_transform_matrix = server.getAstroPos(transform_matrix)
```

Teleports the specified vehicle to the target world position. The vehicle is unloaded and reloaded.

```
is_success = server.setVehiclePos(vehicle_id, transform_matrix)
```

Teleports the specified vehicle to the target world position. The vehicle is unloaded and reloaded. The vehicle is displaced by other vehicles at the arrival point.

```
is_success, result_matrix = server.setVehiclePosSafe(vehicle_id, transform_matrix)
```

Teleports all vehicles in the group to the target world position. The vehicle is unloaded and reloaded.

```
is_success = server.setGroupPos(group_id, transform_matrix)
```

Teleports all vehicles in the group to the target world position. The vehicle is unloaded and reloaded. The vehicle is displaced by other vehicles that are not in the group at the arrival point.

```
is_success, result_matrix = server.setGroupPosSafe(group_id, transform_matrix)
```

Moves the specified vehicle to the target world position.

```
is_success = server.moveVehicle(vehicle_id, transform_matrix)
```

Moves the specified vehicle to the target world position. The vehicle is displaced by other vehicles at the arrival point.

```
is_success, result_matrix = server.moveVehicleSafe(vehicle_id, transform_matrix)
```

Moves all vehicles in the group to the target world position.

```
is_success = server.moveGroup(group_id, transform_matrix)
```

Moves all vehicles in the group to the target world position. The vehicle is displaced by other vehicles that are not in the group at the arrival point.

```
is_success, result_matrix = server.moveGroupSafe(group_id, transform_matrix)
```

Checks if a zone of size xyz is clear of vehicles at the provided transform.

```
is_success = server.isLocationClear(transform_matrix, x, y, z)
```

Reloads the vehicle as if spawning from a workbench, refreshing damage and inventories etc.

```
is_success = server.resetVehicleState(vehicle_id)
```

Cleans up all player spawned vehicles.

```
server.cleanVehicles()
```

Cleans up all fallout zones.

```
server.clearRadiation()
```

Returns a table of vehicle ids in the vehicle group.

```
{ [i] = vehicle_id }, is_success = server.getVehicleGroup(group_id)
```

Returns a table of vehicle ids that match the name set by a map-icon-block.

```
{ [i] = vehicle_id }, is_success = server.getVehiclesByName(name)
```

Gets general data for a vehicle.

```
VEHICLE_DATA, is_success = server.getVehicleData(vehicle_id)
	VEHICLE_DATA = {
		["tags_full"] = tags,
		["tags"] = { [i] = tag },
		["group_id"] = vehicle_group_id,
		["transform"] = transform_matrix,
		["simulating"] = is_simulating,
		["editable"] = is_editable,
		["invulnerable"] = is_invulnerable,
		["static"] = is_static,
		["name"] = map_icon_block_name,
		["authors"] = { [i] = { name = "name", steam_id = steam id } }
```

Gets advanced data for a LOADED vehicle. Including a list of attached character objects.

```
LOADED_VEHICLE_DATA, is_success = server.getVehicleComponents(vehicle_id)
	LOADED_VEHICLE_DATA = {
		["voxels"] = voxel count,
		["mass"] = mass,
		["characters"] = { [i] = char_id },
		["components"] = {
			["signs"] = { [i] = { SIGN_DATA }
			["seats"] = { [i] = { SEAT_DATA },
			["buttons"] = { [i] = { BUTTON_DATA },
			["dials"] = { [i] = { DIAL_DATA }
			["tanks"] = { [i] = { TANK_DATA }
			["batteries"] = { [i] = { BATTERY_DATA }
			["hoppers"] = { [i] = { HOPPER_DATA }
			["guns"] = { [i] = { GUN_DATA }
			["rope_hooks"] = { [i] = { ROPE_HOOK_DATA }
		}
```

Each component contains the following data by default in addition to the type specific data detailed below in their specific get functions

```
VEHICLE_COMPONENT_DATA = {
			["name"],
			["pos"] = {
				["x"] = voxel_x,
				["y"] = voxel_y,
				["z"] = voxel_z
			}
		}
	}
```

Returns the value of the first tank of the specified name or voxel position found on the specified vehicle. Stormworks uses Centi-Litres behind the scenes and as such values here will reflect that (10x Litres).

```
DATA, is_success = server.getVehicleTank(vehicle_id, tank_name)
DATA, is_success = server.getVehicleTank(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		},
		["value"] = current_held_total,
		["values"] = { FLUID_TYPE = amount},
		["capacity"] = total_capacity,
		["fluid_type"] = FLUID_TYPE (set in tank properties),
	}

	FLUID_TYPE |
	0 = fresh water,
	1 = diesel,
	2 = jet fuel,
	3 = air,
	4 = exhaust,
	5 = oil,
	6 = sea water,
	7 = steam,
	8 = slurry,
	9 = saturated slurry,
	10 = oxygen,
	11 = nitrogen,
	12 = hydrogen,
```

Returns the data of the first seat of the specified name or voxel position found on the specified vehicle.

```
DATA, is_success = server.getVehicleSeat(vehicle_id, seat_name)
DATA, is_success = server.getVehicleSeat(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		},
		["seated_id"] = seated_object_id (character or creature),
		["seated_peer_id"] = seated_peer_id (if character is a player),
	}
```

Returns the state of the first button of the specified name or voxel position found on the specified vehicle.

```
DATA, is_success = server.getVehicleButton(vehicle_id, button_name)
DATA, is_success = server.getVehicleButton(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		}
		["on"] = is_on,
	}
```

Returns the voxel position of the first sign of the specified name or voxel position found on the specified vehicle.

```
DATA, is_success = server.getVehicleSign(vehicle_id, sign_name)
DATA, is_success = server.getVehicleSign(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		}
	}
```

Returns the value of the first dial of the specified name or voxel position found on the specified vehicle.

```
DATA, is_success = server.getVehicleDial(vehicle_id, dial_name)
DATA, is_success = server.getVehicleDial(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		},
		["value"] = value_primary,
		["value2"] = value_secondary,
	}
```

Returns the resource data of the first hopper of the specified name or voxel position found on the specified vehicle.

```
DATA, is_success = server.getVehicleHopper(vehicle_id, hopper_name)
DATA, is_success = server.getVehicleHopper(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		},
		["values"] = { RESOURCE_TYPE = amount},
		["capacity"] = total_capacity,
	}

RESOURCE_TYPE |
	0 = coal,
	1 = iron,
	2 = aluminium,
	3 = gold,
	4 = gold_dirt,
	5 = uranium,
	6 = ingot_iron,
	7 = ingot_steel,
	8 = ingot_aluminium,
	9 = ingot_gold_impure,
	10 = ingot_gold,
	11 = ingot_uranium,
	12 = solid_propellant,
	13 = anchovie,
	14 = anglerfish,
	15 = arctic_char,
	16 = ballan_lizardfish,
	17 = ballan_wrasse,
	18 = barreleye_fish,
	19 = black_bream,
	20 = black_dragonfish,
	21 = clown_fish,
	22 = cod,
	23 = dolphinfish,
	24 = gulper_eel,
	25 = haddock,
	26 = hake,
	27 = herring,
	28 = john_dory,
	29 = labrus,
	30 = lanternfish,
	31 = mackerel,
	32 = midshipman,
	33 = perch,
	34 = pike,
	35 = pinecone_fish,
	36 = pollock,
	37 = red_mullet,
	38 = rockfish,
	39 = sablefish,
	40 = salmon,
	41 = sardine,
	42 = scad,
	43 = sea_bream,
	44 = sea_halibut,
	45 = sea_piranha,
	46 = seabass,
	47 = slimehead,
	48 = snapper,
	49 = snapper_gold,
	50 = snook,
	51 = spadefish,
	52 = trout,
	53 = tubeshoulders_fish,
	54 = viperfish,
	55 = yellowfin_tuna,
	56 = blue crab,
	57 = brown_box_crab,
	58 = coconut_crab,
	59 = dungeness_crab,
	60 = furry_lobster,
	61 = homarus_americanus, (Atlantic Lobster)
	62 = homarus_gammarus, (Common Lobster)
	63 = horseshoe_crab,
	64 = jasus_edwardsii, (Red Rock Lobster)
	65 = jasus_lalandii, (Cape Rock Lobster)
	66 = jonah_crab,
	67 = king_crab,
	68 = mud_crab,
	69 = munida_lobster,
	70 = ornate_rock_lobster,
	71 = panulirus_interruptus,
	72 = red_king_crab,
	73 = reef_lobster,
	74 = slipper_lobster,
	75 = snow_crab,
	76 = southern_rock_lobster,
	77 = spider_crab,
	78 = spiny_lobster,
	79 = stone_crab
```

Returns the data of the first battery of the specified name or voxel position found on the specified vehicle.

```
DATA, is_success = server.getVehicleBattery(vehicle_id, battery_name)
DATA, is_success = server.getVehicleBattery(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		},
		["charge"] = current_charge,
	}
```

Returns the data of the first weapon component of the specified name or voxel position found on the specified vehicle.

```
DATA, is_success = server.getVehicleWeapon(vehicle_id, name)
DATA, is_success = server.getVehicleWeapon(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		},
		["ammo"] = current_ammo,
		["capacity"] = total_ammo_capacity,
	}
```

Returns the data of the first rope anchor component of the specified name or voxel position found on the specified vehicle.

```
DATA, is_success = server.getVehicleRopeHook(vehicle_id, name)
DATA, is_success = server.getVehicleRopeHook(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		}
	}
```

Applies a set fluid action to the first tank of the specified name or voxel position found on the specified vehicle. Fluid of the same state(gas or liquid) as the target type will be cleared when this function is triggered, therefore to fully clear a tank call this function twice, one for gases and one for liquids. Stormworks uses Centi-Litres behind the scenes and as such values here should reflect that (10x Litres).

```
server.setVehicleTank(vehicle_id, tank_name, amount, FLUID_TYPE)
server.setVehicleTank(vehicle_id, voxel_x, voxel_y, voxel_z, amount, FLUID_TYPE)
```

Override the inputs to the first seat of the specified name or voxel position found on the specified vehicle. A seated player will prevent overrides.

```
server.setVehicleSeat(vehicle_id, seat_name, axis_w, axis_d, axis_up, axis_right, button1, button2, button3, button4, button5, button6, trigger)
server.setVehicleSeat(vehicle_id, voxel_x, voxel_y, voxel_z, axis_w, axis_d, axis_up, axis_right, button1, button2, button3, button4, button5, button6, trigger)
```

Applies a press action to the first button of the specified name or voxel position found on the specified vehicle.

```
server.pressVehicleButton(vehicle_id, button_name)
server.pressVehicleButton(vehicle_id, voxel_x, voxel_y, voxel_z)
```

Applies a set number action to the first keypad of the specified name or voxel position found on the specified vehicle.

```
server.setVehicleKeypad(vehicle_id, keypad_name, value, (value2))
server.setVehicleKeypad(vehicle_id, voxel_x, voxel_y, voxel_z, value, (value2))
```

Sets the number of a specific type of resource object inside a hopper of the specified name or voxel position found on the specified vehicle.

```
server.setVehicleHopper(vehicle_id, hopper_name, amount, RESOURCE_TYPE)
server.setVehicleHopper(vehicle_id, voxel_x, voxel_y, voxel_z, amount, RESOURCE_TYPE)
```

Applies a set charge action to the first battery of the specified name or voxel position found on the specified vehicle. 0 to 1 range.

```
server.setVehicleBattery(vehicle_id, battery_name, amount)
server.setVehicleBattery(vehicle_id, voxel_x, voxel_y, voxel_z, amount)
```

Applies a set ammo action to the first weapon component of the specified name or voxel position found on the specified vehicle. 0 to 1 range.

```
server.setVehicleWeapon(vehicle_id, name, amount)
server.setVehicleWeapon(vehicle_id, voxel_x, voxel_y, voxel_z, amount)
```

Spawns a rope between two rope anchors on the specified vehicles at the provided rope hook component voxel positions. Length will be clamped to at least the distance between voxels. Length of 0 will spawn the rope at the clamped minimum. Currently does not fully support pulleys second rope slot.

```
server.spawnVehicleRope(vehicle_id_1, voxel_x_1, voxel_y_1, voxel_z_1, vehicle_id_2, voxel_x_2, voxel_y_2, voxel_z_2, length, ROPE_TYPE)
	ROPE_TYPE |
	0 = rope,
	1 = hose,
	2 = electric cable,
	3 = N/A
	4 = suspension cable,
	5 = N/A,
	6 = Fishing line,
```

Get the number of burning surfaces on a specified vehicle.

```
surface_count, is_success = server.getVehicleFireCount(vehicle_id)
```

Set the default block tooltip of a vehicle to display some text. Blocks with unique tooltips (e.g. buttons) will override this tooltip.

```
is_success = server.setVehicleTooltip(vehicle_id, text)
```

Applies impact damage to a vehicle at the specified voxel location. Damage maxiumum is 100. Radius is in meters. Negative damage values will instead repair the area.

```
is_success = server.addDamage(vehicle_id, damage, voxel_x, voxel_y, voxel_z, radius)
```

Returns whether the specified vehicle has finished loading and is simulating.

```
is_simulating, is_success = server.getVehicleSimulating(vehicle_id)
```

Returns whether the specified vehicle is loading, simulating or unloading.

```
is_local, is_success = server.getVehicleLocal(vehicle_id)
```

Sets a vehicle's global transponder to active. (All vehicles have a global transponder that can be active even if a vehicle is not loaded).

```
is_success = server.setVehicleTransponder(vehicle_id, is_active)
```

Sets a vehicle to be editable by players. If a vehicle is spawned by a script it will not have a parent workbench until edited by one (Edit vehicle in zone).

```
is_success = server.setVehicleEditable(vehicle_id, is_editable)
```

Sets a vehicle to be invulnerable to damage.

```
is_success = server.setVehicleInvulnerable(vehicle_id, is_invulnerable)
```

Sets a vehicle to show on the map.

```
is_success = server.setVehicleShowOnMap(vehicle_id, is_show_on_map)
```

特定のアドオンからビークルコンポーネントをスポーンさせます。component\_id の取得方法については、getLocationComponentData() を参照してください。group\_vehicles は、このグループに含まれる全ての vehicle\_id をリスト化したテーブルです。

```
vehicle_id, is_success, group_vehicles, group_id = server.spawnAddonVehicle(transform_matrix, addon_index, component_id)
```

ローカルの appdata から、ファイル名指定でビークルをスポーンさせます。group\_vehicles は、このグループに含まれる全ての vehicle\_id をリスト化したテーブルです。

```
vehicle_id, is_success, group_vehicles, group_id = server.spawnVehicle(transform_matrix, save_name)
```

プレイヤーの範囲外に出たときに、ビークルがデスポーンするように設定します。is\_instant の場合、プレイヤーの距離に関係なく即座にデスポーンします。

```
is_success = server.despawnVehicle(vehicle_id, is_instant)
```

プレイヤーの範囲外に出たときに、ビークルグループ内の全ビークルがデスポーンするように設定します。is\_instant の場合、プレイヤーの距離に関係なく即座にデスポーンします。

```
is_success = server.despawnVehicleGroup(group_id, is_instant)
```

ビークルの赤マージの中心のワールド座標を取得します。任意でボクセル座標を渡すと、ビークル上の指定されたボクセルのワールド座標を返します。

```
transform_matrix, is_success = server.getVehiclePos(vehicle_id, [voxel_x, voxel_y, voxel_z])
```

ワールド座標を天文学的座標に変換します。宇宙空間でのナビゲーションに使用します。

```
astronomy_transform_matrix = server.getAstroPos(transform_matrix)
```

指定されたビークルを対象のワールド座標にテレポートさせます。ビークルはアンロードおよびリロードされます。

```
is_success = server.setVehiclePos(vehicle_id, transform_matrix)
```

指定されたビークルを対象のワールド座標にテレポートさせます。ビークルはアンロードおよびリロードされます。到着地点に別のビークルがある場合は、到着地点をずらします。

```
is_success, result_matrix = server.setVehiclePosSafe(vehicle_id, transform_matrix)
```

グループ内の全ビークルを対象のワールド座標にテレポートさせます。ビークルはアンロードおよびリロードされます。

```
is_success = server.setGroupPos(group_id, transform_matrix)
```

グループ内の全ビークルを対象のワールド座標にテレポートさせます。ビークルはアンロードおよびリロードされます。同じグループに属さない別のビークルが到着地点にある場合は、到着地点をずらします。

```
is_success, result_matrix = server.setGroupPosSafe(group_id, transform_matrix)
```

指定されたビークルを対象のワールド座標に移動します。

```
is_success = server.moveVehicle(vehicle_id, transform_matrix)
```

指定されたビークルを対象のワールド座標に移動します。到着地点に別のビークルがある場合は、到着地点をずらします。

```
is_success, result_matrix = server.moveVehicleSafe(vehicle_id, transform_matrix)
```

グループ内の全ビークルを対象のワールド座標に移動します。

```
is_success = server.moveGroup(group_id, transform_matrix)
```

グループ内の全ビークルを対象のワールド座標に移動します。同じグループに属さない別のビークルが到着地点にある場合は、到着地点をずらします。

```
is_success, result_matrix = server.moveGroupSafe(group_id, transform_matrix)
```

指定された座標で、サイズ xyz の領域内にビークルが存在しないことを確認します。

```
is_success = server.isLocationClear(transform_matrix, x, y, z)
```

ワークベンチからスポーンさせるのと同じようにビークルを再ロードし、ダメージやインベントリなどをリフレッシュします。

```
is_success = server.resetVehicleState(vehicle_id)
```

プレイヤーがスポーンさせたビークルをすべて片付けます。

```
server.cleanVehicles()
```

すべての放射性降下物ゾーンを浄化します。

```
server.clearRadiation()
```

ビークルグループ内の vehicle\_id のテーブルを返します。

```
{ [i] = vehicle_id }, is_success = server.getVehicleGroup(group_id)
```

map-icon-block によって設定された名前と一致する vehicle\_id のテーブルを返します。

```
{ [i] = vehicle_id }, is_success = server.getVehiclesByName(name)
```

ビークルの汎用データを取得します。

```
VEHICLE_DATA, is_success = server.getVehicleData(vehicle_id)
	VEHICLE_DATA = {
		["tags_full"] = tags,
		["tags"] = { [i] = tag },
		["group_id"] = vehicle_group_id,
		["transform"] = transform_matrix,
		["simulating"] = is_simulating,
		["editable"] = is_editable,
		["invulnerable"] = is_invulnerable,
		["static"] = is_static,
		["name"] = map_icon_block_name,
		["authors"] = { [i] = { name = "name", steam_id = steam id } }
```

**ロードされている**ビークルの詳細データを取得します。アタッチされているキャラクターオブジェクトのリストが含まれます。  
（訳注：1実行当たり0.5msほどかかるため、複数のビークルを取得する際は負荷に注意）

```
LOADED_VEHICLE_DATA, is_success = server.getVehicleComponents(vehicle_id)
	LOADED_VEHICLE_DATA = {
		["voxels"] = voxel count,
		["mass"] = mass,
		["characters"] = { [i] = char_id },
		["components"] = {
			["signs"] = { [i] = { SIGN_DATA }
			["seats"] = { [i] = { SEAT_DATA },
			["buttons"] = { [i] = { BUTTON_DATA },
			["dials"] = { [i] = { DIAL_DATA }
			["tanks"] = { [i] = { TANK_DATA }
			["batteries"] = { [i] = { BATTERY_DATA }
			["hoppers"] = { [i] = { HOPPER_DATA }
			["guns"] = { [i] = { GUN_DATA }
			["rope_hooks"] = { [i] = { ROPE_HOOK_DATA }
		}
```

各コンポーネントは、その固有の取得関数にて後述するタイプ固有のデータに加えて、デフォルトで以下のデータを含みます。

```
VEHICLE_COMPONENT_DATA = {
			["name"],
			["pos"] = {
				["x"] = voxel_x,
				["y"] = voxel_y,
				["z"] = voxel_z
			}
		}
	}
```

指定されたビークルで最初に見つかった指定された名前もしくはボクセル座標のタンクの値を返します。Stormworks は内部的にセンチリットルを使用しているため、ここでの値はそれを反映したものになります（リットルの10倍）。

```
DATA, is_success = server.getVehicleTank(vehicle_id, tank_name)
DATA, is_success = server.getVehicleTank(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		},
		["value"] = current_held_total,
		["values"] = { FLUID_TYPE = amount},
		["capacity"] = total_capacity,
		["fluid_type"] = FLUID_TYPE (タンクのプロパティで設定),
	}

	FLUID_TYPE |
	0 = fresh water,
	1 = diesel,
	2 = jet fuel,
	3 = air,
	4 = exhaust,
	5 = oil,
	6 = sea water,
	7 = steam,
	8 = slurry,
	9 = saturated slurry,
	10 = oxygen,
	11 = nitrogen,
	12 = hydrogen,
```

指定されたビークルで最初に見つかった指定された名前もしくはボクセル座標のシートのデータを返します。

```
DATA, is_success = server.getVehicleSeat(vehicle_id, seat_name)
DATA, is_success = server.getVehicleSeat(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		},
		["seated_id"] = seated_object_id (character or creature),
		["seated_peer_id"] = seated_peer_id (if character is a player),
	}
```

指定されたビークルで最初に見つかった指定された名前もしくはボクセル座標のボタンの状態を返します。

```
DATA, is_success = server.getVehicleButton(vehicle_id, button_name)
DATA, is_success = server.getVehicleButton(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		}
		["on"] = is_on,
	}
```

指定されたビークルで最初に見つかった指定された名前もしくはボクセル座標のサインのボクセル座標を返します。

```
DATA, is_success = server.getVehicleSign(vehicle_id, sign_name)
DATA, is_success = server.getVehicleSign(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		}
	}
```

指定されたビークルで最初に見つかった指定された名前もしくはボクセル座標のダイヤルの値を返します。

```
DATA, is_success = server.getVehicleDial(vehicle_id, dial_name)
DATA, is_success = server.getVehicleDial(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		},
		["value"] = value_primary,
		["value2"] = value_secondary,
	}
```

指定されたビークルで最初に見つかった指定された名前もしくはボクセル座標のホッパーの資源データを返します。

```
DATA, is_success = server.getVehicleHopper(vehicle_id, hopper_name)
DATA, is_success = server.getVehicleHopper(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		},
		["values"] = { RESOURCE_TYPE = amount},
		["capacity"] = total_capacity,
	}

RESOURCE_TYPE |
	0 = coal,
	1 = iron,
	2 = aluminium,
	3 = gold,
	4 = gold_dirt,
	5 = uranium,
	6 = ingot_iron,
	7 = ingot_steel,
	8 = ingot_aluminium,
	9 = ingot_gold_impure,
	10 = ingot_gold,
	11 = ingot_uranium,
	12 = solid_propellant,
	13 = anchovie,
	14 = anglerfish,
	15 = arctic_char,
	16 = ballan_lizardfish,
	17 = ballan_wrasse,
	18 = barreleye_fish,
	19 = black_bream,
	20 = black_dragonfish,
	21 = clown_fish,
	22 = cod,
	23 = dolphinfish,
	24 = gulper_eel,
	25 = haddock,
	26 = hake,
	27 = herring,
	28 = john_dory,
	29 = labrus,
	30 = lanternfish,
	31 = mackerel,
	32 = midshipman,
	33 = perch,
	34 = pike,
	35 = pinecone_fish,
	36 = pollock,
	37 = red_mullet,
	38 = rockfish,
	39 = sablefish,
	40 = salmon,
	41 = sardine,
	42 = scad,
	43 = sea_bream,
	44 = sea_halibut,
	45 = sea_piranha,
	46 = seabass,
	47 = slimehead,
	48 = snapper,
	49 = snapper_gold,
	50 = snook,
	51 = spadefish,
	52 = trout,
	53 = tubeshoulders_fish,
	54 = viperfish,
	55 = yellowfin_tuna,
	56 = blue crab,
	57 = brown_box_crab,
	58 = coconut_crab,
	59 = dungeness_crab,
	60 = furry_lobster,
	61 = homarus_americanus, (Atlantic Lobster)
	62 = homarus_gammarus, (Common Lobster)
	63 = horseshoe_crab,
	64 = jasus_edwardsii, (Red Rock Lobster)
	65 = jasus_lalandii, (Cape Rock Lobster)
	66 = jonah_crab,
	67 = king_crab,
	68 = mud_crab,
	69 = munida_lobster,
	70 = ornate_rock_lobster,
	71 = panulirus_interruptus,
	72 = red_king_crab,
	73 = reef_lobster,
	74 = slipper_lobster,
	75 = snow_crab,
	76 = southern_rock_lobster,
	77 = spider_crab,
	78 = spiny_lobster,
	79 = stone_crab
```

指定されたビークルで最初に見つかった指定された名前もしくはボクセル座標のバッテリーのデータを返します。

```
DATA, is_success = server.getVehicleBattery(vehicle_id, battery_name)
DATA, is_success = server.getVehicleBattery(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		},
		["charge"] = current_charge,
	}
```

指定されたビークルで最初に見つかった指定された名前もしくはボクセル座標の武器コンポーネントのデータを返します。

```
DATA, is_success = server.getVehicleWeapon(vehicle_id, name)
DATA, is_success = server.getVehicleWeapon(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		},
		["ammo"] = current_ammo,
		["capacity"] = total_ammo_capacity,
	}
```

指定されたビークルで最初に見つかった指定された名前もしくはボクセル座標のロープアンカーコンポーネントのデータを返します。

```
DATA, is_success = server.getVehicleRopeHook(vehicle_id, name)
DATA, is_success = server.getVehicleRopeHook(vehicle_id, voxel_x, voxel_y, voxel_z)
DATA = {
		["name"],
		["pos"] = {
			["x"] = voxel_x,
			["y"] = voxel_y,
			["z"] = voxel_z
		}
	}
```

指定されたビークルで最初に見つかった指定された名前もしくはボクセル座標のタンクに、流体設定アクションを適用します。この関数をトリガーすると、対象の流体種別と同じ状態（気体 or 液体）の流体がクリアされます。したがって、タンク内を完全に空にするには、この関数を気体用に1回、液体用に1回で計2回呼び出してください。Stormworks は内部的にセンチリットルを使用しているため、ここでの値はそれを反映したものになります（リットルの10倍）。

```
server.setVehicleTank(vehicle_id, tank_name, amount, FLUID_TYPE)
server.setVehicleTank(vehicle_id, voxel_x, voxel_y, voxel_z, amount, FLUID_TYPE)
```

指定されたビークルで最初に見つかった指定された名前またはボクセル座標のシートの入力を上書きします。プレイヤーが座っているシートの入力を上書きすることはできません。

```
server.setVehicleSeat(vehicle_id, seat_name, axis_w, axis_d, axis_up, axis_right, button1, button2, button3, button4, button5, button6, trigger)
server.setVehicleSeat(vehicle_id, voxel_x, voxel_y, voxel_z, axis_w, axis_d, axis_up, axis_right, button1, button2, button3, button4, button5, button6, trigger)
```

指定されたビークルで最初に見つかった指定された名前もしくはボクセル座標のボタンに、押下アクションを適用します。

```
server.pressVehicleButton(vehicle_id, button_name)
server.pressVehicleButton(vehicle_id, voxel_x, voxel_y, voxel_z)
```

指定されたビークルで最初に見つかった指定された名前もしくはボクセル座標のキーパッドに、番号設定アクションを適用します。

```
server.setVehicleKeypad(vehicle_id, keypad_name, value, (value2))
server.setVehicleKeypad(vehicle_id, voxel_x, voxel_y, voxel_z, value, (value2))
```

指定されたビークルで見つかった指定された名前もしくはボクセル座標のホッパー内の特定の種類の資源オブジェクトの数を設定します。

```
server.setVehicleHopper(vehicle_id, hopper_name, amount, RESOURCE_TYPE)
server.setVehicleHopper(vehicle_id, voxel_x, voxel_y, voxel_z, amount, RESOURCE_TYPE)
```

指定されたビークルで最初に見つかった指定された名前もしくはボクセル座標のバッテリーに、残量設定アクションを適用します。範囲は 0 ～ 1 です。

```
server.setVehicleBattery(vehicle_id, battery_name, amount)
server.setVehicleBattery(vehicle_id, voxel_x, voxel_y, voxel_z, amount)
```

指定されたビークルで最初に見つかった指定された名前もしくはボクセル座標の武器コンポーネントに、弾薬セットアクションを適用します。範囲は 0 ～ 1 です。

```
server.setVehicleWeapon(vehicle_id, name, amount)
server.setVehicleWeapon(vehicle_id, voxel_x, voxel_y, voxel_z, amount)
```

指定されたビークルの指定されたロープフックコンポーネントのボクセル位置で、2つのロープアンカー間にロープを生成します。長さは、ボクセル間の距離以上になるように制限されます。長さが0の場合、ロープは最小限の長さで生成されます。現時点では、プーリーの2番目のロープスロットは完全にはサポートされていません。

```
server.spawnVehicleRope(vehicle_id_1, voxel_x_1, voxel_y_1, voxel_z_1, vehicle_id_2, voxel_x_2, voxel_y_2, voxel_z_2, length, ROPE_TYPE)
	ROPE_TYPE |
	0 = rope,
	1 = hose,
	2 = electric cable,
	3 = N/A
	4 = suspension cable,
	5 = N/A,
	6 = Fishing line,
```

指定したビークルの燃焼面の数を取得します。

```
surface_count, is_success = server.getVehicleFireCount(vehicle_id)
```

ビークルのデフォルトブロックツールチップに何らかのテキストを表示するように設定します。固有のツールチップを持つブロック（例：ボタン）はこのツールチップを上書きします。

```
is_success = server.setVehicleTooltip(vehicle_id, text)
```

ビークルの指定したボクセル位置に衝撃ダメージを与えます。ダメージの最大値は100です。半径はメートル単位です。負のダメージ値は、代わりに領域を修復します。

```
is_success = server.addDamage(vehicle_id, damage, voxel_x, voxel_y, voxel_z, radius)
```

指定されたビークルがロード完了して、シミュレーション中であるかどうかを返します。

```
is_simulating, is_success = server.getVehicleSimulating(vehicle_id)
```

指定されたビークルがロード中、シミュレーション中、またはアンロード中かどうかを返します。

```
is_local, is_success = server.getVehicleLocal(vehicle_id)
```

ビークルのグローバルトランスポンダをアクティブに設定します。（すべてのビークルは、ビークルがロードされていない場合でもアクティブにできるグローバルトランスポンダを持っています）。

```
is_success = server.setVehicleTransponder(vehicle_id, is_active)
```

ビークルをプレイヤーが編集できるように設定します。ビークルがスクリプトによってスポーンされた場合、プレイヤーによって編集（Edit vehicle in zone）されるまで親ワークベンチを持ちません。

```
is_success = server.setVehicleEditable(vehicle_id, is_editable)
```

ビークルをダメージに対して無敵になるように設定します。

```
is_success = server.setVehicleInvulnerable(vehicle_id, is_invulnerable)
```

マップ上に表示するビークルを設定します。

```
is_success = server.setVehicleShowOnMap(vehicle_id, is_show_on_map)
```
