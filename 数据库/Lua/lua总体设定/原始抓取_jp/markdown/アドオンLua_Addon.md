---
wiki: sbarjp
page: アドオンLua/Addon
source_url: https://wikiwiki.jp/sbarjp/%E3%82%A2%E3%83%89%E3%82%AA%E3%83%B3Lua/Addon
last_modified: 2026-08-22
retrieved_at: 2026-08-31T01:10:31+0800
---

# アドオンLua/Addon

|  |
| --- |
| **このページはアドオン Lua のヘルプドキュメントの翻訳です。原文のバージョンは Stormworks v1.15.20（リリース日：2026/8/15）です。アドオン Lua はたびたびアップデートされています。正確な情報は公式のアップデート情報から確認してください。** |

## Addon（アドオン）

英語原文

Get the internal index of this addon.

```
addon_index, is_success = server.getAddonIndex()
```

Get the internal index of an active addon by its name (useful if you want to spawn components from another active addon). Returns -1 on failure.

```
addon_index, is_success = server.getAddonIndex(name)
```

Get the internal index of a location in the specified addon by its name (this index is local to the addon). Returns -1 on failure.

```
location_index, is_success = server.getLocationIndex(addon_index, name)
```

Directly spawn a location by name from the current addon, optional world transform parameter - otherwise spawns at first tile of the location type.

```
is_success = server.spawnNamedAddonLocation(name, (transform_matrix))
```

Spawn the specified mission location from the specified mission addon at the specified world coordinates. A transform\_matrix with x,y,z = 0,0,0 will spawn the location at a random location of the tile's type (useful for spawning missions on specific tiles)

```
out_transform_matrix, is_success = server.spawnAddonLocation(transform_matrix, addon_index, location_index)
```

Get the filepath of an addon, is\_rom will only be true for DEV addons stored in the rom folder. Returns "none" on failure

```
path, is_success = server.getAddonPath(addon_name, is_rom)
```

Get a table of all active ENV MOD zones.

```
ZONE_LIST = server.getZones()

	ZONE_LIST = {
		[zone_index] = {
			["tags_full"] = tags,
			["tags"] = { [i] = tag },
			["name"] = name,
			["transform"] = transform_matrix,
			["size"] = {x, y, z},
			["radius"] = radius,
			["type"] = ZONE_TYPE,
			["parent_vehicle_id"] = parent_vehicle_id,
			["parent_relative_transform"] = relative_matrix
		}
	}

	ZONE_TYPE |
	0 = box,
	1 = sphere,
	2 = radius,
```

Get a table of all active ENV MOD zones that match the specified tag(s)

```
ZONE_LIST = server.getZones(tag(s))
```

Returns whether the specified world transform is within any ENV MOD zone that matches the display name. For specific zones, using isInTransformArea may be preferred.

```
is_in_zone, is_success = server.isInZone(transform_matrix, zone_display_name)
```

Get number of active addons.

```
count = server.getAddonCount()
```

Get table of addon data for the specified addon\_index. Returns nil if the addon cannot be found.

```
ADDON_DATA = server.getAddonData(addon_index)

	ADDON_DATA = {
		["name"] = name,
		["path_id"] = folder_path,
		["file_store"] = is_app_data,
		["location_count"] = location_count
	}
```

Get table of location data for the specified location at the specified addon\_index. Returns nil if the location cannot be found.

```
LOCATION_DATA, is_success = server.getLocationData(addon_index, location_index)

	LOCATION_DATA = {
		["name"] = name,
		["tile"] = tile_filename,
		["env_spawn_count"] = spawn_count,
		["env_mod"] = is_env_mod,
		["component_count"] = component_count
	}
```

Get table of component(object/vehicle) data for the specified component at the specified location at the specified addon\_index. Returns nil if the component cannot be found.

```
COMPONENT_DATA, is_success = server.getLocationComponentData(addon_index, location_index, component_index)

	COMPONENT_DATA = {
		["tags_full"] = tags,
		["tags"] = { [i] = tag },
		["display_name"] = display_name,
		["type"] = TYPE_STRING,
		["id"] = component_id,
		["dynamic_object_type"] = OBJECT_TYPE,
		["transform"] = transform_matrix,
		["vehicle_parent_component_id"] = vehicle parent component id,
		["character_outfit_type"] = OUTFIT_TYPE,
		["interactable"] = is_character_interactable,
		["creature_type"] = CREATURE_TYPE,
		["animal_type"] = ANIMAL_TYPE,
	}
```

Spawn the component(object/vehicle) at the specified component index at the specified location at the specified addon\_index. Optional parent\_vehicle\_id param for fire and zone components.

```
COMPONENT, is_success = server.spawnAddonComponent(transform_matrix, addon_index, location_index, component_index, [parent_vehicle_id])

	COMPONENT = {
		["tags_full"] = tags,
		["tags"] = { [i] = tag },
		["display_name"] = display_name,
		["type"] = TYPE_STRING,
		["transform"] = transform_matrix,
		["id"] = object_id/main_vehicle_id
		["object_id"] = object_id/main_vehicle_id
        ["group_id"] = object_id/vehicle_id
        ["vehicle_ids"] = { [i] = vehicle_id }
	}
```

このアドオンの内部インデックスを取得します。

```
addon_index, is_success = server.getAddonIndex()
```

アクティブなアドオンの内部インデックスをその名前で取得します（別のアクティブなアドオンからコンポーネントをスポーンさせる場合に便利です）。失敗した場合は -1 を返します。

```
addon_index, is_success = server.getAddonIndex(name)
```

指定されたアドオン内にあるロケーションの内部インデックスをその名前で取得します（このインデックスはアドオン内のローカルなものです）。失敗した場合は -1 を返します。

```
location_index, is_success = server.getLocationIndex(addon_index, name)
```

現在のアドオンから名前で直接ロケーションをスポーンさせます。任意でワールド座標パラメータを指定でき、指定しなかった場合はそのロケーションタイプの最初のタイルでスポーンします。

```
is_success = server.spawnNamedAddonLocation(name, (transform_matrix))
```

指定されたワールド座標で、指定されたミッションアドオンから指定されたミッションロケーションをスポーンさせます。transform\_matrix が x,y,z = 0,0,0 である場合、ロケーションとタイプが一致するランダムなタイルにそのロケーションをスポーンさせます（特定のタイルにミッションをスポーンさせるのに便利です）。

```
out_transform_matrix, is_success = server.spawnAddonLocation(transform_matrix, addon_index, location_index)
```

アドオンのファイルパスを取得します。is\_rom は rom フォルダに格納されている DEV アドオンに対してのみ真となります。失敗した場合は "none" を返します。

```
path, is_success = server.getAddonPath(addon_name, is_rom)
```

すべてのアクティブな ENV MOD ゾーンのテーブルを取得します。

```
ZONE_LIST = server.getZones()

	ZONE_LIST = {
		[zone_index] = {
			["tags_full"] = tags,
			["tags"] = { [i] = tag },
			["name"] = name,
			["transform"] = transform_matrix,
			["size"] = {x, y, z},
			["radius"] = radius,
			["type"] = ZONE_TYPE,
			["parent_vehicle_id"] = parent_vehicle_id,
			["parent_relative_transform"] = relative_matrix
		}
	}

	ZONE_TYPE |
	0 = box,
	1 = sphere,
	2 = radius,
```

指定されたタグに一致するすべてのアクティブな ENV MOD ゾーンのテーブルを取得します。

```
ZONE_LIST = server.getZones(tag(s))
```

指定されたワールド座標が、指定された表示名と一致するいずれかの ENV MOD ゾーン内にあるかどうかを返します。特定のゾーンについては、isInTransformArea を使用することが望ましいかもしれません。

```
is_in_zone, is_success = server.isInZone(transform_matrix, zone_display_name)
```

アクティブなアドオンの数を取得します。

```
count = server.getAddonCount()
```

指定した addon\_index に対応するアドオンデータのテーブルを取得します。アドオンが見つからない場合は nil を返します。

```
ADDON_DATA = server.getAddonData(addon_index)

	ADDON_DATA = {
		["name"] = name,
		["path_id"] = folder_path,
		["file_store"] = is_app_data,
		["location_count"] = location_count
	}
```

指定された addon\_index にある指定されたロケーションのロケーションデータのテーブルを取得します。ロケーションが見つからない場合は nil を返します。

```
LOCATION_DATA, is_success = server.getLocationData(addon_index, location_index)

	LOCATION_DATA = {
		["name"] = name,
		["tile"] = tile_filename,
		["env_spawn_count"] = spawn_count,
		["env_mod"] = is_env_mod,
		["component_count"] = component_count
	}
```

指定された addon\_index の指定されたロケーションにある指定されたコンポーネント（オブジェクト/ビークル）のコンポーネントデータのテーブルを取得します。コンポーネントが見つからない場合は nil を返します。

```
COMPONENT_DATA, is_success = server.getLocationComponentData(addon_index, location_index, component_index)

	COMPONENT_DATA = {
		["tags_full"] = tags,
		["tags"] = { [i] = tag },
		["display_name"] = display_name,
		["type"] = TYPE_STRING,
		["id"] = component_id,
		["dynamic_object_type"] = OBJECT_TYPE,
		["transform"] = transform_matrix,
		["vehicle_parent_component_id"] = vehicle parent component id,
		["character_outfit_type"] = OUTFIT_TYPE,
		["interactable"] = is_character_interactable,
		["creature_type"] = CREATURE_TYPE,
		["animal_type"] = ANIMAL_TYPE,
	}
```

指定された addon\_index の指定されたロケーションにある指定されたコンポーネントインデックスのコンポーネント（オブジェクト/ビークル）をスポーンさせます。任意の parent\_vehicle\_id パラメータは fire と zone コンポーネントのために用意されています。

```
COMPONENT, is_success = server.spawnAddonComponent(transform_matrix, addon_index, location_index, component_index, [parent_vehicle_id])

	COMPONENT = {
		["tags_full"] = tags,
		["tags"] = { [i] = tag },
		["display_name"] = display_name,
		["type"] = TYPE_STRING,
		["transform"] = transform_matrix,
		["id"] = object_id/main_vehicle_id
		["object_id"] = object_id/main_vehicle_id
        ["group_id"] = object_id/vehicle_id
        ["vehicle_ids"] = { [i] = vehicle_id }
	}
```
