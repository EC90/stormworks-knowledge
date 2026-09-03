# 部件选项枚举（自动提取自游戏可执行文件）

> 生成：2026-09-03T12:41:04 ｜ 方法：`.text` 代码引用顺序 = 下拉枚举顺序（详见 技能库/sw-property-options/SKILL.md）
> Golden 校验：m_sweep_mode / gear_ratio 已强制比对通过。
> `verified`：auto=自动提取且无矛盾；partial=存在歧义；todo=未解析或需游戏内复核。

## 已解析（有选项序列）

| XML 属性 | UI 标签 | 选项（0→n-1） | n | verified | 载具实测部件 |
| --- | --- | --- | --- | --- | --- |
| `color_mode` | Color Mode | 0=Push Button / 1=Toggle Button | 2 | partial | small_light_rgb |
| `flare_type` | — | 0=Illumination / 1=Smoke / 2=Illumination Parachute / 3=Smoke Parachute / 4=Chaff | 5 | partial | flare_launcher |
| `fluid_type` | Fluid Type | 0=None / 1=Cross / 2=Wreckage / 3=Terminal / 4=Military / 5=Heritage / 6=Oil Rig / 7=Industrial / 8=Hospital / 9=Science / 10=Airport / 11=Coastguard / 12=Lighthouse / 13=Hospital Ship / 14=Refueler Plane / 15=Ore / 16=Ingot / 17=Fish / 18=Dollar | 19 | partial | fluid_tank_small |
| `gear_ratio` | Gear Ratio | 0=1:1 / 1=1:2 / 2=1:4 / 3=1:8 / 4=1:16 / 5=1:32 | 6 | auto | linear_compact_head, multibody_compact_pivot_b, multibody_compact_pivot_robotic_a, multibody_turret_large_a |
| `gear_ratio_1` | — | 0=1:-1 / 1=1:1 / 2=6:5 / 3=3:2 / 4=9:5 / 5=2:1 / 6=5:2 / 7=3:1 | 8 | partial | modular_engine_gearbox_1x1 |
| `gear_ratio_2` | — | 0=1:-1 / 1=1:1 / 2=6:5 / 3=3:2 / 4=9:5 / 5=2:1 / 6=5:2 / 7=3:1 | 8 | partial | modular_engine_gearbox_1x1, torque_clutch |
| `m_sweep_mode` | Sweep Mode | 0=Static / 1=Clockwise / 2=Anticlockwise / 3=Sweep / 4=Manual | 5 | auto | radar_advanced_dish, radar_advanced_missile |
| `ordinance_type` | — | 0=Ordinance / 1=Utility / 2=Fuel / 3=Unguided bomb / 4=Laser Guided Bomb / 5=GPS Guided Bomb / 6=Rocket / 7=Rocket Pod / 8=Laser Guided Missile / 9=GPS Guided Missile / 10=Radar Guided Missile / 11=Torpedo / 12=Cannon | 13 | partial | connector_hardpoint_a, connector_hardpoint_b_round, connector_slider_track |

## 未解析（整型属性但邻域无选项簇）

- `ai_type` — 无锚定段（非下拉或需人工复核）
- `animal_type` — 锚定:pool-min=0x28; 仅池距锚定，建议游戏内复核; 存在3个异序候选 无载具实测部件且非比值簇，降级待人工
- `antialiasing_mode` — 锚定:pool-min=0x220; 仅池距锚定，建议游戏内复核 无载具实测部件且非比值簇，降级待人工
- `behavior` — 锚定:pool-min=0x1c0; 仅池距锚定，建议游戏内复核; 存在1个异序候选 无载具实测部件且非比值簇，降级待人工
- `block_type` — 无锚定段（非下拉或需人工复核）
- `blood_level` — 锚定:pool-min=0x2a0; 仅池距锚定，建议游戏内复核; 存在1个异序候选 无载具实测部件且非比值簇，降级待人工
- `button_type` — 无锚定段（非下拉或需人工复核）
- `category` — 锚定:label-nb; 仅池距锚定，建议游戏内复核; 存在3个异序候选 无载具实测部件且非比值簇，降级待人工
- `char_render_mode` — 锚定:pool-min=0x170; 仅池距锚定，建议游戏内复核; 存在3个异序候选 无载具实测部件且非比值簇，降级待人工
- `chest_style` — 无锚定段（非下拉或需人工复核）
- `clothing_mesh` — 无锚定段（非下拉或需人工复核）
- `color_palette` — 锚定:pool-min=0x290; 仅池距锚定，建议游戏内复核; 存在1个异序候选 无载具实测部件且非比值簇，降级待人工
- `component_type` — 锚定:pool-min=0x8; 仅池距锚定，建议游戏内复核; 存在1个异序候选 无载具实测部件且非比值簇，降级待人工
- `composite_type` — 无锚定段（非下拉或需人工复核）
- `connector_type` — 无锚定段（非下拉或需人工复核）
- `constraint_axis` — 无锚定段（非下拉或需人工复核）
- `constraint_type` — 无锚定段（非下拉或需人工复核）
- `convert_type` — 无锚定段（非下拉或需人工复核）
- `coupling_gender` — 无锚定段（非下拉或需人工复核）
- `creature_type` — 锚定:pool-min=0x40; 仅池距锚定，建议游戏内复核; 存在3个异序候选 无载具实测部件且非比值簇，降级待人工
- `custom_door_type` — 无锚定段（非下拉或需人工复核）
- `data_logger_component_type` — 无锚定段（非下拉或需人工复核）
- `electric_type` — 无锚定段（非下拉或需人工复核）
- `engine_module_type` — 无锚定段（非下拉或需人工复核）
- `feet_style` — 无锚定段（非下拉或需人工复核）
- `fish_state` — 锚定:pool-min=0x3e8; 仅池距锚定，建议游戏内复核; 存在3个异序候选 无载具实测部件且非比值簇，降级待人工
- `flare_color` — 锚定:pool-min=0x48; 仅池距锚定，建议游戏内复核 无载具实测部件且非比值簇，降级待人工
- `flare_state` — 锚定:pool-min=0xc; 仅池距锚定，建议游戏内复核 无载具实测部件且非比值簇，降级待人工
- `fps_limit_level` — 锚定:pool-min=0x230; 仅池距锚定，建议游戏内复核 无载具实测部件且非比值簇，降级待人工
- `func_type` — 无锚定段（非下拉或需人工复核）
- `glasses_mesh` — 无锚定段（非下拉或需人工复核）
- `grid_size` — 锚定:pool-min=0x1b0; 仅池距锚定，建议游戏内复核; 存在2个异序候选 无载具实测部件且非比值簇，降级待人工
- `gyro_type` — 无锚定段（非下拉或需人工复核）
- `hair_mesh` — 无锚定段（非下拉或需人工复核）
- `icon` — 锚定:label-run(Icon)+pool-min=0x200; 大簇(>=16项)谨慎采信 无载具实测部件且非比值簇，降级待人工
- `indicator_type` — 无锚定段（非下拉或需人工复核）
- `interact_type` — 无锚定段（非下拉或需人工复核）
- `inventory_class` — 无锚定段（非下拉或需人工复核）
- `jet_engine_component_type` — 无锚定段（非下拉或需人工复核）
- `key` — 锚定:key@func; 存在3个异序候选 无载具实测部件且非比值簇，降级待人工
- `leg_style` — 无锚定段（非下拉或需人工复核）
- `light_type` — 无锚定段（非下拉或需人工复核）
- `logic_gate_type` — 无锚定段（非下拉或需人工复核）
- `loot_type` — 锚定:pool-min=0x1d8; 仅池距锚定，建议游戏内复核 无载具实测部件且非比值簇，降级待人工
- `lower_mesh` — 无锚定段（非下拉或需人工复核）
- `lss_mode` — 无锚定段（非下拉或需人工复核）
- `marker_type` — 无锚定段（非下拉或需人工复核）
- `mask_mesh` — 无锚定段（非下拉或需人工复核）
- `metadata_component_type` — 无锚定段（非下拉或需人工复核）
- `mid_mesh` — 无锚定段（非下拉或需人工复核）
- `mode` — 锚定:key@func; 存在3个异序候选 无载具实测部件且非比值簇，降级待人工
- `mouse` — 锚定:pool-min=0x22c; 仅池距锚定，建议游戏内复核; 存在3个异序候选 无载具实测部件且非比值簇，降级待人工
- `nuclear_component_type` — 无锚定段（非下拉或需人工复核）
- `oil_component_type` — 无锚定段（非下拉或需人工复核）
- `pad` — 锚定:key@func+pool-min=0x1c; 存在3个异序候选 无载具实测部件且非比值簇，降级待人工
- `particles_level` — 锚定:pool-min=0x278; 仅池距锚定，建议游戏内复核; 存在1个异序候选 无载具实测部件且非比值簇，降级待人工
- `physics_material_type` — 锚定:pool-min=0x40; 仅池距锚定，建议游戏内复核; 存在3个异序候选 无载具实测部件且非比值簇，降级待人工
- `radar_type` — 无锚定段（非下拉或需人工复核）
- `rocket_type` — 无锚定段（非下拉或需人工复核）
- `rotation` — 锚定:key@func+pool-min=0x358; 存在3个异序候选 无载具实测部件且非比值簇，降级待人工
- `rudder_type` — 无锚定段（非下拉或需人工复核）
- `seat_pose` — 无锚定段（非下拉或需人工复核）
- `sensor_mode` — 无锚定段（非下拉或需人工复核）
- `sensor_type` — 无锚定段（非下拉或需人工复核）
- `shape` — 锚定:label-nb; 仅池距锚定，建议游戏内复核; 存在3个异序候选 无载具实测部件且非比值簇，降级待人工
- `special_outfit_mesh` — 无锚定段（非下拉或需人工复核）
- `state` — 锚定:pool-min=0x2a0; 仅池距锚定，建议游戏内复核 无载具实测部件且非比值簇，降级待人工
- `steam_component_type` — 无锚定段（非下拉或需人工复核）
- `third_person_camera_mode` — 无锚定段（非下拉或需人工复核）
- `tile_type` — 锚定:pool-min=0x10; 仅池距锚定，建议游戏内复核; 存在2个异序候选 无载具实测部件且非比值簇，降级待人工
- `tire_type` — 无锚定段（非下拉或需人工复核）
- `tool_type` — 无锚定段（非下拉或需人工复核）
- `torque_component_type` — 无锚定段（非下拉或需人工复核）
- `trans_conn_type` — 无锚定段（非下拉或需人工复核）
- `trans_type` — 无锚定段（非下拉或需人工复核）
- `tsunami_type` — 无锚定段（非下拉或需人工复核）
- `type` — 锚定:key@func; 存在3个异序候选 无载具实测部件且非比值簇，降级待人工
- `upper_mesh` — 无锚定段（非下拉或需人工复核）
- `use_case` — 无锚定段（非下拉或需人工复核）
- `water_component_type` — 无锚定段（非下拉或需人工复核）
- `weapon_belt_type` — 无锚定段（非下拉或需人工复核）
- `weapon_class` — 无锚定段（非下拉或需人工复核）
- `weapon_type` — 无锚定段（非下拉或需人工复核）
- `wheel_type` — 无锚定段（非下拉或需人工复核）
- `window_mode` — 锚定:pool-min=0x2c8; 仅池距锚定，建议游戏内复核; 存在1个异序候选 无载具实测部件且非比值簇，降级待人工
- `zone_type` — 无锚定段（非下拉或需人工复核）

## 载具 XML 实测属性清单（38 项）

- `ac`：部件 02_wedge, 05_wedge_2, battery_small, button_keypad_small, button_push, button_toggle；实测值 [141414, 454545, 455233, 969696]
- `bc`：部件 02_wedge, 05_wedge_2, battery_small, button_key, button_keypad_large, button_keypad_small；实测值 [141414, 454545, 455233, 969696]
- `bc2`：部件 microprocessor, seat_padded, window_2x1；实测值 [969696]
- `bc3`：部件 microprocessor, seat_padded, window_1x1；实测值 [969696]
- `burn_rate`：部件 solid_rocket_nozzle_small；实测值 [0]
- `color_mode`：部件 small_light_rgb；实测值 [1]
- `control_mode_3`：部件 seat_handle；实测值 [1]
- `fin_factor`：部件 solid_rocket_small_fins；实测值 [-1]
- `flare_type`：部件 flare_launcher；实测值 [1]
- `fluid_filter`：部件 air_exchanger, air_exchanger_5_2, catalytic_converter, fluid_exhaust, fluid_pressure, fluid_radiator_electric；实测值 [4294967295]
- `fluid_type`：部件 fluid_tank_small；实测值 [0]
- `fuel_factor`：部件 solid_rocket_nozzle_small；实测值 [1500]
- `gear_ratio`：部件 linear_compact_head, multibody_compact_pivot_b, multibody_compact_pivot_robotic_a, multibody_turret_large_a, multibody_turret_large_b, multibody_velocity_pivot_a；实测值 [0, 2, 5]
- `gear_ratio_1`：部件 modular_engine_gearbox_1x1；实测值 [4, 5, 7]
- `gear_ratio_2`：部件 modular_engine_gearbox_1x1, torque_clutch；实测值 [0, 1, 7]
- `grip_factor`：部件 wheel_advanced_5, wheel_tank_1, wheel_tank_drive_1；实测值 [0]
- `hold_duration`：部件 button_key, button_keypad_large, button_keypad_small, button_push, button_toggle, button_toggle_2side；实测值 [0, 1]
- `hotkey_0`：部件 seat_racing, seat_saddle；实测值 [1]
- `hotkey_1`：部件 seat_saddle；实测值 [1]
- `hotkey_3`：部件 seat_saddle；实测值 [1]
- `input_velocity`：部件 linear_compact_base, linear_compact_head, multibody_compact_pivot_b, multibody_compact_pivot_robotic_a, multibody_turret_large_a, multibody_turret_large_b；实测值 [1, 5]
- `m_fov_x`：部件 radar_advanced_dish, radar_advanced_missile；实测值 [0]
- `m_fov_y`：部件 radar_advanced_dish, radar_advanced_missile；实测值 [0]
- `m_sweep_mode`：部件 radar_advanced_dish, radar_advanced_missile；实测值 [0]
- `max_force_scalar`：部件 multibody_velocity_pivot_a；实测值 [0]
- `max_force_scale`：部件 water_pump；实测值 [1]
- `muzzle_velocity`：部件 flare_launcher；实测值 [20]
- `ordinance_type`：部件 connector_hardpoint_a, connector_hardpoint_b_round, connector_slider_track；实测值 [1]
- `property_ammo_damage`：部件 gun_belt_flex, gun_belt_loader, gun_belt_straight_l, gun_drum_small, gun_drum_xsmall, gun_l；实测值 [1, 3, 4, 5]
- `property_ammo_type`：部件 gun_drum_xsmall；实测值 [6]
- `rcs_threshold`：部件 rcs_thruster；实测值 [1]
- `rotation_speed`：部件 rotating_light；实测值 [0]
- `sc`：部件 01_block_weight, 02_wedge, 03_pyramid, 04_invpyramid, 05_wedge_2, 06_pyramid_2；实测值 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
- `timer_scalar_1`：部件 clock, gate_bool_constant, gate_float_constant, gate_function_small, linear_speed_sensor, mic；实测值 [0]
- `timer_scalar_2`：部件 clock, gate_bool_constant, gate_float_constant, gate_function_small, linear_speed_sensor, mic；实测值 [0]
- `tire_type`：部件 wheel_advanced_5；实测值 [0]
- `trigger`：部件 seat_compact, seat_handle, seat_racing, seat_saddle；实测值 [1]
- `wheel_size`：部件 wheel_advanced_5；实测值 [0]
