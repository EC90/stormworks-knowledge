---
wiki: sbarjp
page: アドオンLua/UI
source_url: https://wikiwiki.jp/sbarjp/%E3%82%A2%E3%83%89%E3%82%AA%E3%83%B3Lua/UI
last_modified: 2026-08-22
retrieved_at: 2026-08-31T01:12:26+0800
---

# アドオンLua/UI

|  |
| --- |
| **このページはアドオン Lua のヘルプドキュメントの翻訳です。原文のバージョンは Stormworks v1.15.20（リリース日：2026/8/15）です。アドオン Lua はたびたびアップデートされています。正確な情報は公式のアップデート情報から確認してください。** |

## Chat（チャット）

英語原文

Sends a chat message. peer\_id is optional and defaults to -1 for all peers. Announce messages are not handled as commands.

```
server.announce(name, message, (peer_id))
```

Sends a command message directly to all other scripts. Uses peer id -1 when arriving in the onCustomCommand callback.

```
server.command(message)
```

Sends a pop up notification to the specified peer(s)

```
server.notify(peer_id, title, message, NOTIFICATION_TYPE)

	NOTIFICATION_TYPE |
	0 = new_mission,
	1 = new_mission_critical,
	2 = failed_mission,
	3 = failed_mission_critical,
	4 = complete_mission,
	5 = network_connect,
	6 = network_disconnect,
	7 = network_info,
	8 = chat_message,
	9 = rewards,
	10 = network_info_critical,
	11 = research_complete,
```

チャットメッセージを送信します。peer\_id は任意で、デフォルトは -1（すべてのピアに送信）です。アナウンスメッセージがコマンドとして扱われることはありません。

```
server.announce(name, message, (peer_id))
```

他のすべてのスクリプトに直接コマンドメッセージを送信します。onCustomCommand コールバックに到着するとき、peer id -1 を使用します。

```
server.command(message)
```

指定されたピアにポップアップ通知を送信します。

```
server.notify(peer_id, title, message, NOTIFICATION_TYPE)

	NOTIFICATION_TYPE |
	0 = new_mission,
	1 = new_mission_critical,
	2 = failed_mission,
	3 = failed_mission_critical,
	4 = complete_mission,
	5 = network_connect,
	6 = network_disconnect,
	7 = network_info,
	8 = chat_message,
	9 = rewards,
	10 = network_info_critical,
	11 = research_complete,
```

## Map & World（マップ＆ワールド）

英語原文

Returns a unique UI id number for use with all other UI functions, The UI ID can be used to track, edit and clean UI elements up.

```
ui_id = server.getMapID()
```

Removes all UI with the specified UI ID for the specified peer(s)

```
server.removeMapID(peer_id, ui_id)
```

Add a map marker for the specified peer(s). x, z represent the worldspace location of the marker, since the map is 2D a y coordinate is not required. If POSITION\_TYPE is set to 1 or 2 (vehicle or object) then the marker will track the object/vehicle of object\_id/vehicle\_id and offset the position by parent\_local\_x, parent\_local\_z. Custom color defaults to red (0-255).

```
server.addMapObject(peer_id, ui_id, POSITION_TYPE, MARKER_TYPE, x, z, parent_local_x, parent_local_z, vehicle_id, object_id, label, radius, hover_label)
server.addMapObject(peer_id, ui_id, POSITION_TYPE, MARKER_TYPE, x, z, parent_local_x, parent_local_z, vehicle_id, object_id, label, radius, hover_label, r, g, b, a)

	POSITION_TYPE |
	0 = fixed,
	1 = vehicle,
	2 = object

	MARKER_TYPE |
	0 = delivery_target,
	1 = survivor,
	2 = object,
	3 = waypoint,
	4 = tutorial,
	5 = fire,
	6 = shark,
	7 = ice,
	8 = search_radius
	9 = flag_1
	10 = flag_2
	11 = house
	12 = car
	13 = plane
	14 = tank
	15 = heli
	16 = ship
	17 = boat
	18 = attack
	19 = defend
```

Removes a map object with the specified UI ID for the specified peer(s)

```
server.removeMapObject(peer_id, ui_id)
```

Add a map label for the specified peer(s). x, z represent the worldspace location of the marker. Map labels appear under fog of war. Custom color defaults to black (0-255).

```
server.addMapLabel(peer_id, ui_id, LABEL_TYPE, name, x, z)
server.addMapLabel(peer_id, ui_id, LABEL_TYPE, name, x, z, r, g, b, a)

	LABEL_TYPE |
	0 = none,
	1 = cross,
	2 = wreckage,
	3 = terminal,
	4 = military,
	5 = heritage,
	6 = rig,
	7 = industrial,
	8 = hospital,
	9 = science,
	10 = airport,
	11 = coastguard,
	12 = lighthouse,
	13 = fuel,
	14 = fuel_sell,
	15 = hospital_ship,
	16 = refuel_plane,
	17 = ore,
	18 = ingot,
	19 = fish,
	20 = dollar,
```

Removes a map label with the specified UI ID for the specified peer(s)

```
server.removeMapLabel(peer_id, ui_id)
```

Adds a map line between two world space matrices with the specified UI ID for the specified peer(s). Custom color defaults to red.

```
server.addMapLine(peer_id, ui_id, start_matrix, end_matrix, width)
server.addMapLine(peer_id, ui_id, start_matrix, end_matrix, width, r, g, b, a)
```

Removes a map line with the specified UI ID for the specified peer(s)

```
server.removeMapLine(peer_id, ui_id)
```

Creates a popup to the world/screen with the specified UI ID for the specified peer(s). If render distance is set to 0 then the popup will always render. Optionally Parent to a vehicle or Object, with x,y,z acting as a relative position.

```
server.setPopup(peer_id, ui_id, name, is_show, text, x, y, z, render_distance, [vehicle_parent_id], [object_parent_id])
```

Creates a popup to the screen with the specified UI ID for the specified peer(s). Screen space offset ranges from -1,-1 (Bot Left) to 1,1 (Top Right).

```
server.setPopupScreen(peer_id, ui_id, name, is_show, text, horizontal_offset, vertical_offset)
```

Removes a popup with the specified UI ID for the specified peer(s)

```
server.removePopup(peer_id, ui_id)
```

他のすべての UI 関数で使用するための一意の UI ID 番号を返します。UI ID は、UI 要素の追跡、編集、削除に使用することができます。

```
ui_id = server.getMapID()
```

指定されたピアの指定された UI ID を持つすべての UI を削除します。

```
server.removeMapID(peer_id, ui_id)
```

指定したピアに対してマップマーカーを追加します。x, z はワールド空間におけるマーカーの位置を表し、マップは 2D なので y 座標は必要ありません。POSITION\_TYPE が 1 または 2（ビークルまたはオブジェクト）に設定されている場合、マーカーは object\_id/vehicle\_id のオブジェクト/ビークルを追跡し、座標を parent\_local\_x, parent\_local\_z でオフセットします。カスタムカラーのデフォルトは赤（0-255）です。

```
server.addMapObject(peer_id, ui_id, POSITION_TYPE, MARKER_TYPE, x, z, parent_local_x, parent_local_z, vehicle_id, object_id, label, radius, hover_label)
server.addMapObject(peer_id, ui_id, POSITION_TYPE, MARKER_TYPE, x, z, parent_local_x, parent_local_z, vehicle_id, object_id, label, radius, hover_label, r, g, b, a)

	POSITION_TYPE |
	0 = fixed,
	1 = vehicle,
	2 = object

	MARKER_TYPE |
	0 = delivery_target,
	1 = survivor,
	2 = object,
	3 = waypoint,
	4 = tutorial,
	5 = fire,
	6 = shark,
	7 = ice,
	8 = search_radius
	9 = flag_1
	10 = flag_2
	11 = house
	12 = car
	13 = plane
	14 = tank
	15 = heli
	16 = ship
	17 = boat
	18 = attack
	19 = defend
```

指定されたピアの指定された UI ID を持つマップオブジェクトを削除します。

```
server.removeMapObject(peer_id, ui_id)
```

指定されたピアに対してマップラベルを追加します。x, z はマーカーのワールド空間での位置を表します。マップラベルはマップの未開放領域には表示されません。カスタムカラーのデフォルトは黒（0-255）です。

```
server.addMapLabel(peer_id, ui_id, LABEL_TYPE, name, x, z)
server.addMapLabel(peer_id, ui_id, LABEL_TYPE, name, x, z, r, g, b, a)

	LABEL_TYPE |
	0 = none,
	1 = cross,
	2 = wreckage,
	3 = terminal,
	4 = military,
	5 = heritage,
	6 = rig,
	7 = industrial,
	8 = hospital,
	9 = science,
	10 = airport,
	11 = coastguard,
	12 = lighthouse,
	13 = fuel,
	14 = fuel_sell,
	15 = hospital_ship,
	16 = refuel_plane,
	17 = ore,
	18 = ingot,
	19 = fish,
	20 = dollar,
```

指定されたピアの指定された UI ID を持つマップラベルを削除します。

```
server.removeMapLabel(peer_id, ui_id)
```

指定されたピアに対して、指定された UI ID を持つ、2 つのワールド空間行列間を結ぶマップラインを追加します。カスタムカラーのデフォルトは赤です。

```
server.addMapLine(peer_id, ui_id, start_matrix, end_matrix, width)
server.addMapLine(peer_id, ui_id, start_matrix, end_matrix, width, r, g, b, a)
```

指定されたピアの指定された UI ID を持つマップラインを削除します。

```
server.removeMapLine(peer_id, ui_id)
```

指定されたピアに対して、指定された UI ID を持つ、ワールド/スクリーン上に表示されるポップアップを作成します。レンダリング距離が 0 に設定されている場合、ポップアップは常にレンダリングされます。任意でビークルやオブジェクトを親として設定し、x,y,z を相対座標とすることができます。

```
server.setPopup(peer_id, ui_id, name, is_show, text, x, y, z, render_distance, [vehicle_parent_id], [object_parent_id])
```

指定されたピアに対して、指定された UI ID を持つ、スクリーン上に表示されるポップアップを作成します。スクリーン空間オフセットの範囲は、-1,-1（左下）から 1,1（右上）までです。

```
server.setPopupScreen(peer_id, ui_id, name, is_show, text, horizontal_offset, vertical_offset)
```

指定されたピアの指定された UI ID を持つポップアップを削除します。

```
server.removePopup(peer_id, ui_id)
```
