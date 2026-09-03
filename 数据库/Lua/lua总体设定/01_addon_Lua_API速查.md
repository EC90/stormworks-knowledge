> **AI 阅读规则（先读这段，先于正文）**
> 本册是**附加 Lua（Addon Lua）** 的 `server.*` 函数族速查。适用前提：你在写任务/模组脚本（有 `server` 全局对象），不是载具脚本方块。
> - 每个函数签名来自 `原始抓取_jp/アドオンLua_*.md`（原文基准 **v1.15.20**）。
> - 返回 `(value, is_success)` 的函数，取单值时**务必加括号**（见 `00_*` 第 11 节）。
> - 位置/朝向一律用 4×4 `matrix`，世界系 **Y=垂直轴**（见 `00_*` 第 4 节）。
> - 枚举常量（OBJECT_TYPE / EQUIPMENT_TYPE / ZONE_TYPE / GAME_SETTING …）原文极长，本册只列最常用的，完整枚举见原始抓取页。

# 附加 Lua · server.* API 分类速查

## 通用约定（General）

- `peer_id`：玩家列表左侧数字；单机恒为 `0`；传 `-1` = 所有连接的 peer。
- `g_savedata` 表：自动存读 `lua_data.xml`，用于跨会话持久化（详见 `00_*` 第 7 节）。
- 全局可用：`pairs / ipairs / next / tostring / tonumber / type` + `math / table / string`（标准库）。
- 沙盒内禁系统调用；总执行上限 1000ms（开发者提醒效率自负）。

```lua
function onCreate(is_world_create) end   -- is_world_create 仅世界首次生成时 true
function onDestroy() end
function onTick(game_ticks) end         -- 同脚本 Lua，但有 server.* 而非 screen
```

## 回调（Callbacks，节选高频）

| 回调 | 签名（节选） | 触发 |
| --- | --- | --- |
| `onCreate` | `(is_world_create)` | 脚本初始化 / 读档加载 |
| `onTick` | `(game_ticks)` | 每物理帧（睡眠时 game_ticks=400） |
| `onDestroy` | `()` | 退出世界 |
| `onCustomCommand` | `(full_message, user_peer_id, is_admin, is_auth, command, args...)` | 聊天框输入 `?xxx` |
| `onChatMessage` | `(peer_id, sender_name, message)` | 任意聊天消息 |
| `onPlayerJoin/Leave/Die/Respawn` | `(steam_id, name, peer_id, is_admin, is_auth)` | 玩家事件 |
| `onVehicleSpawn` | `(vehicle_id, peer_id, x, y, z, group_cost, group_id)` | 载具生成（脚本生成时 peer_id=-1） |
| `onVehicleDespawn/Load/Unload/Teleport/Damaged` | 见原始页 | 载具生命周期/损伤 |
| `onObjectLoad/Unload` | `(object_id)` | 物体（角色/道具/动物）加载 |
| `onButtonPress` | `(vehicle_id, peer_id, button_name, is_pressed)` | 按按钮（锁住的也触发） |
| `onSpawnAddonComponent` | `(id/vehicle_id, component_name, TYPE_STRING, addon_index)` | 脚本生成组件 |
| `httpReply` | `(port, request, reply)` | HTTP 请求返回 |
| `onTornado/Meteor/Tsunami/Whirlpool/Volcano/OilSpill/...` | `(transform[, magnitude])` | 天灾/事件 |

> 完整约 40 个回调签名 → `原始抓取_jp/アドオンLua_Callbacks.md`。

## Game（世界/环境/游戏设置）

| 函数 | 说明 |
| --- | --- |
| `server.spawnTsunami(matrix, mag)` / `spawnWhirlpool(matrix, mag)` | 海啸/漩涡（同时只能 1 个，强者覆盖弱者，mag 0–1） |
| `server.cancelGerstner()` | 取消当前海浪事件 |
| `server.spawnTornado(matrix)` | 生成龙卷风 |
| `server.spawnMeteor(matrix, mag, is_spawn_tsunami)` / `spawnMeteorShower(...)` | 陨石（mag 0–1，主陨石最大 20×） |
| `server.spawnVolcano(matrix)` | 激活最近火山 |
| `server.spawnExplosion(matrix, mag)` | ⚠ 需 Search and Destroy DLC |
| `server.getVolcanos()` → `{x,y,z,tile_x,tile_y}` | 火山数据 |
| `server.getOilSpill(matrix)` / `setOilSpill(matrix, amt)` / `clearOilSpill()` | 油污 |
| `server.setGameSetting(GAME_SETTING, val)` / `getGameSettings()` | 游戏设置（见下枚举） |
| `server.setCurrency(money, rp)` / `getCurrency()` / `getResearchPoints()` | 货币/研究点 |
| `server.getDateValue()` → days / `getDate()` → d,m,y / `getTime()` → `{hour,minute,daylight_factor,percent}` | 游戏内日期时间 |
| `server.getWeather(matrix)` → `{fog,rain,snow,wind,temp}` / `setWeather(fog,rain,wind)` | 天气 |
| `server.setAudioMood(peer_id, AUDIO_MOOD)` | 音频情绪（0=none…4=mission_high；-1 全 peer） |
| `server.getTileTransform(matrix, tile_name[, r])` / `getTile(matrix)` / `getStartTile()` / `getTilePurchased(matrix)` | 地块查询 |
| `server.getTileInventory(matrix)` → coal,uranium,diesel,jet_fuel,solid_propellant / `setTileInventory(...)` | 资源仓库库存 |
| `server.getOceanTransform(matrix, min, max)` / `getOceanFloor(matrix)` / `getOilDeposits()` | 海洋/油矿 |
| `server.isInTransformArea(m_obj, m_zone, sx,sy,sz)` | 点是否在区域内 |
| `server.pathfind(m_start, m_end, req_tags, avoid_tags)` / `pathfindOcean(...)` | 寻路（返回 `{[i]={x,z}}`） |
| `server.getFishData()` / `getFishHotspots()` | 鱼类数据/渔场 |

**GAME_SETTING 枚举（字符串键）**：`third_person` `vehicle_damage` `player_damage` `npc_damage` `sharks` `fast_travel` `teleport_vehicle` `rogue_mode` `auto_refuel` `megalodon` `map_show_players` `map_show_vehicles` `day_length` `infinite_money` `unlock_all_islands` `infinite_fuel` `engine_overheating` `no_clip` `map_teleport` `cleanup_vehicle` `clear_fow` `vehicle_spawning` `photo_mode` `respawning` `unlock_all_components` `override_weather` …（完整 40+ 项见原始页）

## Objects（玩家 / 物体 / 角色 / 装备）

| 函数 | 说明 |
| --- | --- |
| `server.getPlayers()` → `{[peer_index]={id,name,admin,auth,steam_id,object_id}}` | 所有在线玩家 |
| `server.getPlayerName(peer_id)` / `getPlayerPos(peer_id)`→(matrix,ok) / `setPlayerPos(peer_id, matrix)` | 玩家查询/传送 |
| `server.getPlayerLookDirection(peer_id)` → x,y,z,ok | 玩家镜头前向 |
| `server.getPlayerCharacterID(peer_id)` → object_id | peer→object 转换（两套 ID 独立） |
| `server.spawnObject(matrix, OBJECT_TYPE)` / `despawnObject(id, is_instant)` | 生成/销毁物体 |
| `server.spawnCharacter(matrix[, OUTFIT_TYPE])` / `spawnAnimal(matrix, ANIMAL_TYPE, size)` / `spawnCreature(matrix, CREATURE_TYPE, size)` ⚠ 需 Industrial Frontier DLC | 生成角色/动物 |
| `server.spawnFire(matrix, size, mag, lit, explosive, parent_vid, exp_mag)` | 生成火 |
| `server.spawnEquipment(matrix, EQUIPMENT_TYPE, int, float)` | 生成装备/鱼（鱼无 object_id） |
| `server.getObjectPos(id)` / `setObjectPos(id, matrix)` / `getObjectSimulating(id)` | 物体坐标 |
| `server.getObjectData(id)` → `{object_type,hp,incapacitated,dead,interactable,ai,name,creature_type,scale}` | 物体数据 |
| `server.killCharacter(id)` / `reviveCharacter(id)` / `setCharacterData(id,hp,interactable,ai)` | 角色状态 |
| `server.setSeated(object_id, vehicle_id, seat_name|x,y,z)` | 让角色入座 |
| `server.setCharacterItem(id, SLOT, EQUIPMENT_TYPE, active[, int, float])` / `getCharacterItem(id, SLOT)` | 装备槽 |

> OBJECT_TYPE（0–74+）、EQUIPMENT_TYPE（Outfits/Items/Fish 三大类，0–154）、OUTFIT_TYPE、ANIMAL_TYPE、CREATURE_TYPE 完整枚举 → `原始抓取_jp/アドオンLua_Objects.md`（极长，按需查）。

## Vehicles（载具 / 车队）

| 函数 | 说明 |
| --- | --- |
| `server.despawnVehicle(vehicle_id, is_instant)` / `despawnVehicleGroup(group_id, is_instant)` | 销毁载具/车队 |
| `server.getVehiclePos(vehicle_id[, vx,vy,vz])` → matrix,ok | 载具坐标（可指定 voxel 偏移） |
| `server.setVehiclePos(vehicle_id, matrix)` / `moveVehicle(vehicle_id, matrix)` | 设置/移动 |
| `server.setGroupPos(group_id, matrix)` / `moveGroup(group_id, matrix)` | 车队 |
| `server.getVehicleGroup(group_id)` → `{[i]=vehicle_id}` / `getVehiclesByName(name)` | 列车队/按名找 |
| `server.getVehicleData(vehicle_id)` → 见原始页 | 载具数据 |
| `server.getVehicleComponents(vehicle_id)` → 见原始页 | 组件清单 |
| `server.getVehicleTank(id, name\|vx,vy,vz)` / `getVehicleSeat` / `getVehicleButton` / `getVehicleSign` / `getVehicleDial` / `getVehicleHopper` | 各部件数据 |
| `server.isLocationClear(matrix, x,y,z)` / `resetVehicleState(vehicle_id)` | 占位检测/重置 |

## UI（地图 / 弹窗 / 通知）

| 函数 | 说明 |
| --- | --- |
| `server.announce(name, msg[, peer_id=-1])` | 公告（**不作为命令**处理） |
| `server.command(message)` | 直接发命令给其他脚本（到 `onCustomCommand`，peer=-1） |
| `server.notify(peer_id, title, msg, NOTIFICATION_TYPE)` | 弹窗通知（0=new_mission…11=research_complete） |
| `server.getMapID()` → ui_id / `removeMapID(peer_id, ui_id)` | 申请/清理 UI id |
| `server.addMapObject(peer_id, ui_id, POS_TYPE, MARKER_TYPE, x, z, ...)` / `removeMapObject` | 地图标记（2D，无 y） |
| `server.addMapLabel(peer_id, ui_id, LABEL_TYPE, name, x, z[, rgba])` / `removeMapLabel` | 地图标签 |
| `server.addMapLine(peer_id, ui_id, start_m, end_m, width[, rgba])` / `removeMapLine` | 地图连线 |
| `server.setPopup(peer_id, ui_id, name, is_show, text, x,y,z, render_dist[, vpid, opid])` | 世界/屏幕空间 3D 弹窗 |
| `server.setPopupScreen(peer_id, ui_id, name, is_show, text, h_off, v_off)` | 屏幕空间弹窗（偏移 -1,-1~1,1） |

> ⚠ 附加 Lua **没有像素级 `screen.*`**；地图+弹窗是它唯一的「UI」。要画显示器像素图请用脚本 Lua 方块。

## Addon（addon 自身 / 任务地点）

| 函数 | 说明 |
| --- | --- |
| `server.getAddonIndex([name])` → addon_index,ok | 自身/指定 addon 内部索引（失败 -1） |
| `server.getLocationIndex(addon_index, name)` → location_index,ok | 地点索引（addon 内局部） |
| `server.spawnNamedAddonLocation(name[, matrix])` / `spawnAddonLocation(matrix, addon_index, location_index)` | 生成任务地点 |
| `server.getAddonPath(addon_name, is_rom)` → path,ok | addon 路径（DEV 存 rom 时 is_rom=true；失败 "none"） |
| `server.getZones([tag])` → `{[i]={name,tags,transform,size,radius,type,...}}` | ENV MOD 区域（ZONE_TYPE: 0=box,1=sphere,2=radius） |
| `server.isInZone(matrix, zone_display_name)` → is_in_zone,ok | 点是否在命名区域内 |
| `server.getAddonCount()` / `getAddonData(idx)` / `getLocationData(idx,li)` / `getLocationComponentData(idx,li,ci)` | addon/地点/组件元数据 |
| `server.spawnAddonComponent(matrix, addon_index, location_index, component_index[, parent_vehicle_id])` | 生成组件 |

## Matrices（矩阵工具，共 11 个）

`matrix.multiply(a,b)` `invert(a)` `transpose(a)` `identity()`
`rotationX/Y/Z(radians)` `translation(x,y,z)` `position(m)→x,y,z` `distance(a,b)`
`multiplyXYZW(m,x,y,z,w)→x,y,z,w` `rotationToFaceXZ(x,z)→rotation`

- 旋转用**弧度**（不是圈）。世界系 **Y=垂直轴**。
- 大多数 `server.*` 函数把 `matrix` 当位置/朝向参数。

## Examples（官方示例要点）

- `onCustomCommand` 拆分 `?` 命令、显式声明 `arg1..arg4`。
- 多返回值加括号取首值：`(server.getPlayerPos(id))`（**高频坑，见 `00_*` 第 11 节**）。
- `onSpawnAddonComponent(id, name, type, addon_index)` 监听脚本生成的组件。
- 从父 addon 生成任务地点的最短写法见原始页 `Examples`。

---

## 补充：官方汉化手册带来的增量（v1.15.x，非日文 wiki 覆盖的部分）

> 以下来自 `StormworksLuaAPI.docxStormworks官方Lua API手册汉化.docx`（游戏内 addon 编辑器说明文档的中文翻译）。
> 与日文 wiki 抓取相比，这部分函数/回调在现有章节里**缺漏**，且均为 Stormworks 专属（非 Lua 通识），补于此。

### AI（角色自动驾驶，scriptable）

| 函数 | 说明 |
| --- | --- |
| `server.setAIState(object_id, AI_STATE)` | 设角色 AI 状态 |
| `server.setAITarget(object_id, matrix_dest)` | 设 AI 目的地世界坐标 |
| `server.getAITarget(object_id)` → `target_x, target_y, target_z` | 取 AI 目的地 |

`AI_STATE` 按座位类型不同：

- **船/车驾驶员**：`0=无` `1=导航至目的地`
- **直升机驾驶员**：`0=无` `1=导航至目的地` `2=精确导航（更低起降高度）`
- **固定翼驾驶员**：`0=无` `1=导航至目的地`

座舱轴映射（让 AI 能驾驶，须在对应座位接好）：

| 座位类型 | Hotkey1 | Hotkey2 | Axis W | Axis D | Axis Up | Axis Right |
| --- | --- | --- | --- | --- | --- | --- |
| 船/车 | 引擎 On | 引擎 Off | 油门 | 方向 | — | — |
| 直升机 | 引擎 On | 引擎 Off | 俯仰 | 横滚 | 桨距 | 偏航 |
| 固定翼 | 引擎 On | 引擎 Off | 俯仰 | 横滚 | 油门 | 偏航 |

### DLC / 开发者 / 节日（任务插件开发常用）

| 函数 | 说明 |
| --- | --- |
| `server.dlcWeapons()` → is_dlc | 是否启用 Search and Destroy 武器 DLC |
| `server.dlcArid()` → is_dlc | 是否启用 Industrial Frontier（工业先锋）DLC |
| `server.isDev()` → is_dev | 主机是否为开发者 |
| `server.getSeasonalEvent()` → EVENT_ID | `0=无` `1=万圣节` `2=圣诞节` |
| `server.getTutorial()` → tutorial_completed | 官方教程是否已完成（官方任务生成前会检查） |
| `server.setTutorial(active)` | 强制设教程状态；激活时官方任务插件不启动（可做自定义教程） |
| `server.getVideoTutorial()` → completed | 玩家是否关了视频教程通知（专用服恒 true） |

### Vehicles 补全（01 上文 Vehicles 节漏列的）

| 函数 | 说明 |
| --- | --- |
| `server.spawnAddonVehicle(matrix, addon_index, component_id)` | 从指定 addon 生成其 location 内的载具（component_id 来自 `getLocationComponentData`） |
| `server.setVehicleBattery(vid, name, amount)` / `getVehicleBattery(vid, name\|vx,vy,vz)` → `{name,pos,charge}` | 电池余量（0~1） |
| `server.setVehicleTooltip(vid, text)` | 设载具 tooltip（部分块会覆盖） |
| `server.addDamage(vid, amount, vx, vy, vz)` | 加损伤（0~100，相对车辆原点 voxel 坐标） |
| `server.getVehicleSimulating(vid)` → is_sim,ok | 是否在模拟中 |
| `server.setVehicleTransponder(vid, is_active)` | 全局应急信标（所有车都有，即使没装信标块） |
| `server.setVehicleEditable(vid, is_editable)` | 设是否可由玩家编辑（脚本生成的车无父工作台，直到被编辑） |
| `server.setVehicleShowOnMap(vid, is_show)` | 设地图是否显示 |
| `server.getVehicleWeapon(vid, name\|vx,vy,vz)` → `{name,pos,ammo,capacity}` | 武器信息 |
| `server.getVehicleRopeHook(vid, name\|vx,vy,vz)` → `{name,pos}` | 绳锚信息 |
| `server.getVehicleFireCount(vid)` → surface_count,ok | 正在燃烧的面的数量 |
| `server.setVehicleKeypad(vid, keypad_name, value)` | 设搜索到的第一个键盘的值 |
| `server.setVehicleSeat(vid, seat_name, axis_w, axis_d, axis_up, axis_right, b1..b6)` | 脚本控制第一个匹配座席的轴向/按键（有人则无效） |
| `server.pressVehicleButton(vid, button_name)` | 按下第一个匹配名称的按钮 |

### Objects 补全

| 函数 | 说明 |
| --- | --- |
| `server.getCharacterVehicle(object_id)` → vehicle_id,ok | 角色所乘载具 ID |
| `server.setFireData(object_id, is_lit, is_explosive)` / `getFireData(object_id)` → is_lit | 世界火灾属性 |
| `server.setCreatureMoveTarget(object_id, matrix)` ⚠需 Industrial Frontier DLC | 设生物移动目的地 |

### 其他 / 通用补全

| 函数 | 说明 |
| --- | --- |
| `server.getTimeMillisec()` → system_time | 系统时间戳；**可作随机数种子**（解决双端随机不一致，见 `00_*` 第 1 节） |
| `server.getAddonIndexCurrent()` | 取**当前** addon 的内部索引（无参版；`01` 上文只列了 `getAddonIndex(name)`） |

### 官方示例范式（直接可复用）

**多返回值取首值——双重括号**（比 `00_*` 第 11 节更直观的官方写法）：

```lua
function anyPlayerAtPos(posX, posY, posZ)
    local players = server.getPlayers()
    for _, p in pairs(players) do
        -- 注意 getPlayerPos 外有「两层括号」：内层只取 matrix，外层喂给 matrix.position
        local x, y, z = matrix.position((server.getPlayerPos(p.id)))
        local distSQ = (posX-x)^2 + (posY-y)^2 + (posZ-z)^2
        if distSQ < 25 then return true end
    end
    return false
end
```

**`onSpawnAddonComponent` 按 addon 过滤**（任务区域管理的标准范式）：

```lua
function onSpawnAddonComponent(id, name, type, addon_index)
    if addon_index == server.getAddonIndex() then   -- 只收自己这个 addon 生成的
        spawned_mission_objects[id] = { name = name, type = type }
    end
end
```

**自定义指令（必须显式展开 args）**：

```lua
function onCustomCommand(full, peer, is_admin, is_auth, command, arg1, arg2, arg3, arg4)
    if command == "?tp" and is_admin then
        server.setPlayerPos(peer, matrix.translation(arg1, arg2, arg3))
    end
end
```

---

**来源**：日文 wiki `原始抓取_jp/アドオンLua_*.md`（v1.15.20）+ 官方汉化手册 `StormworksLuaAPI.docxStormworks官方Lua API手册汉化.docx`（游戏内 addon 编辑器说明的中文翻译，补充了 AI/DLC/载具部件读取家族/完整回调集）。签名以游戏内 Help 与官方更新为准。
