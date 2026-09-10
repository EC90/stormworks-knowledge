# 游戏全量部件清单（权威索引 · 759 项）

> 源：`<SW_DEFS>/*.xml`（lxml 只读解析，759 个定义）
> 中文名来自 `<WS>/汉化相关/数据/sw_glossary.jsonl`（`kind=name`）。`※未收录` = 对照表未收录，用前回查。
> 尺寸为 voxel(x×y×z)，1 voxel=0.25 m；`—` 表示无 voxel 定义（绳节点类或动态活塞）。

## cat[] 其他/管道(no category) （10 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 把手 | Handle | 1 | 5 | — | 1 | handle.xml |
| 管道(3向 边角) | Pipe Angle Corner | 1 | 5 | — | 0 | trans_corner.xml |
| 封闭管道(3向 边角) | Pipe Angle Corner (Enclosed) | 1 | 5 | — | 0 | trans_block_corner.xml |
| 管道(X型) | Pipe Cross | 1 | 5 | — | 0 | trans_cross.xml |
| 管道(5向 边角) | Pipe Cross Corner | 1 | 5 | — | 0 | trans_cross_corner.xml |
| 管道(6向 核心) | Pipe Omni | 1 | 5 | — | 0 | trans_omni.xml |
| 管道(T型) | Pipe T-Piece | 1 | 5 | — | 0 | trans_t.xml |
| 封闭管道(T型) | Pipe T-Piece (Enclosed) | 1 | 5 | — | 0 | trans_block_t.xml |
| 管道(4向  边角) | Pipe T-Piece Corner | 1 | 5 | — | 0 | trans_t_corner.xml |
| ※未收录 | Pivot (Power) | 1 |  | — | 1 | multibody_pivot_torque_b.xml |

## cat[0] B 基础方块 （39 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 方块 | Block | 1.000000 | 2 | 1x1x1 | 0 | 01_block.xml |
| 倒锥形块1x1 | Inverse Pyramid | 0.75 | 2 | 1x1x1 | 0 | 04_invpyramid.xml |
| 倒锥形块1x2 | Inverse Pyramid 1x2 | 1.5 | 2 | 1x1x2 | 0 | 07_invpyramid_2.xml |
| 倒锥形块1x4 | Inverse Pyramid 1x4 | 3 | 4 | 1x1x4 | 0 | 10_invpyramid_4.xml |
| 倒金字塔2x2 | Inverse Pyramid 2x2 | 3 | 4 | 2x1x2 | 0 | 14_invpyramid_2x2.xml |
| 倒金字塔2x4 | Inverse Pyramid 2x4 | 6 | 8 | 2x1x4 | 0 | 15_invpyramid_2x4.xml |
| 倒金字塔4x4 | Inverse Pyramid 4x4 | 12 | 16 | 4x1x4 | 0 | 16_invpyramid_4x4.xml |
| 梯子 | Ladder | 3.000000 | 5 | 3x4x1 | 0 | ladder_small.xml |
| 物理填充块 | Physics Flooder | 1 | 20 | 1x2x1 | 0 | physics_flooder.xml |
| 管道(L型) | Pipe Angle | 1 | 5 | 1x1x1 | 0 | trans_angle.xml |
| 封闭管道(L型) | Pipe Angle (Enclosed) | 1 | 5 | 1x1x1 | 0 | trans_block_angle.xml |
| 封闭管道(X型) | Pipe Cross (Enclosed) | 1 | 5 | 1x1x1 | 0 | trans_block_cross.xml |
| 封闭管道(5向 边角) | Pipe Cross Corner (Enclosed) | 1 | 5 | 1x1x1 | 0 | trans_block_cross_corner.xml |
| 封闭管道(6向 核心) | Pipe Omni (Enclosed) | 1 | 5 | 1x1x1 | 0 | trans_block_omni.xml |
| 管道(I型) | Pipe Straight | 1 | 5 | 1x1x1 | 0 | trans_straight.xml |
| 封闭管道(I型) | Pipe Straight (Enclosed) | 1 | 5 | 1x1x1 | 0 | trans_block_straight.xml |
| 封闭管道(4向 边角) | Pipe T-Piece Corner (Enclosed) | 1 | 5 | 1x1x1 | 0 | trans_block_t_corner.xml |
| 枢轴 | Pivot | 1.000000 | 0 | 1x1x1 | 0 | multibody_pivot_b.xml |
| 锥形块1x1 | Pyramid | 0.25 | 2 | 1x1x1 | 0 | 03_pyramid.xml |
| 锥形块1x2 | Pyramid 1x2 | 0.5 | 2 | 1x1x2 | 0 | 06_pyramid_2.xml |
| 锥形块1x4 | Pyramid 1x4 | 1 | 4 | 1x1x4 | 0 | 09_pyramid_4.xml |
| 金字塔形2x2 | Pyramid 2x2 | 1 | 4 | 2x1x2 | 0 | 11_pyramid_2x2.xml |
| 金字塔形2x4 | Pyramid 2x4 | 2 | 8 | 2x1x4 | 0 | 12_pyramid_2x4.xml |
| 金字塔形4x4 | Pyramid 4x4 | 4 | 16 | 4x1x4 | 0 | 13_pyramid_4x4.xml |
| 机械枢轴b | Robotic Pivot | 1 | 0 | 1x1x1 | 1 | multibody_robotic_pivot_01_b.xml |
| 机械枢轴b | Robotic Pivot | 1 | 0 | 1x1x1 | 1 | multibody_robotic_pivot_01_b_fluid.xml |
| 机械枢轴b | Robotic Pivot | 1 | 0 | 1x1x1 | 0 | multibody_velocity_pivot_b.xml |
| 楼梯踏板 | Stair Step | 6.000000 | 20 | 3x1x2 | 0 | stair_segment.xml |
| 楼梯顶部 | Stair Top | 6 | 20 | 3x1x2 | 0 | stair_top.xml |
| 基准块 | Static Block | 1 | 10 | 1x1x1 | 0 | 01_block_static.xml |
| 炮塔座圈(大) | Turret Ring (Large) | 36 | 0 | 9x1x9 | 0 | multibody_turret_large_b.xml |
| 炮塔座圈(中) | Turret Ring (Medium) | 22 | 0 | 7x1x7 | 0 | multibody_turret_medium_b.xml |
| 炮塔座圈(小) | Turret Ring (Small) | 14 | 0 | 5x1x5 | 0 | multibody_turret_small_b.xml |
| 速度轴 | Velocity Pivot | 1 | 0 | 1x1x1 | 1 | multibody_velocity_pivot_01_b_fluid.xml |
| 速度轴 | Velocity Pivot | 1 | 0 | 1x1x1 | 1 | multibody_velocity_pivot_01_b_torque.xml |
| 楔形块1x1 | Wedge | 0.5 | 2 | 1x1x1 | 0 | 02_wedge.xml |
| 楔形块1x2 | Wedge 1x2 | 1 | 2 | 1x1x2 | 0 | 05_wedge_2.xml |
| 楔形块1x4 | Wedge 1x4 | 2 | 4 | 1x1x4 | 0 | 08_wedge_4.xml |
| 配重块 | Weight Block | 10.000000 | 5 | 1x1x1 | 0 | 01_block_weight.xml |

## cat[1] V 控制面 （67 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 驾驶座椅(紧凑型) | Compact Pilot Seat | 7 | 100 | 3x5x3 | 18 | seat_compact.xml |
| 控制鳍(大) | Control Fin Large | 10 | 350 | 1x3x3 | 2 | control_fin_large.xml |
| 控制鳍(中) | Control Fin Medium | 5 | 150 | 1x2x3 | 2 | control_fin_medium.xml |
| 控制鳍(小) | Control Fin Small | 2 | 50 | — | 2 | control_fin_small.xml |
| 控制器手柄 | Control Handle | 1 | 50 | 3x7x3 | 18 | seat_handle.xml |
| 控制面(大) | Control Surface (Large) | 25 | 500 | — | 2 | control_surface_large.xml |
| 控制面(中) | Control Surface (Medium) | 15 | 250 | — | 2 | control_surface_medium.xml |
| 控制面(小) | Control Surface (Small) | 10 | 150 | — | 2 | control_surface_small.xml |
| 数据记录器(布尔) | Data Logger (Bool) | 1 | 1 | — | 1 | data_logger_bool.xml |
| 数据记录器(数值) | Data Logger (Number) | 1 | 1 | — | 1 | data_logger_number.xml |
| 驾驶座椅 | Driver seat | 10 | 100 | 3x5x4 | 18 | seat_racing.xml |
| 方向舵(鳍型) | Fin Rudder | 5 | 100 | — | 2 | rudder_surface.xml |
| 摩擦块 | Friction Pad | 1 | 15 | 1x1x1 | 0 | friction_block.xml |
| 陀螺仪 | Gyro | 10.000000 | 500 | 5x1x3 | 10 | gyro.xml |
| 驾驶座椅(轮舵) | Helm | 15 | 150 | 3x7x5 | 18 | seat_helm.xml |
| 龙骨(大) | Keel (Large) | 2000 | 2000 | 3x9x25 | 0 | keel_large.xml |
| ※未收录 | Keel (Medium) | 1000 | 1000 | 3x7x15 | 0 | keel_medium.xml |
| ※未收录 | Keel (Small) | 500 | 300 | — | 0 | keel_small.xml |
| 载具保活块 | Keep Active Block | 1 | 100 | — | 0 | no_sleep.xml |
| 起落架轮(大) | Large Landing Wheel | 8 | 50 | — | 2 | wheel_coaster_large.xml |
| 地图标志块 | Map Icon Block | 1 | 100 | — | 0 | map_icon.xml |
| 公路轮(中) | Medium Wheel | 10 | 100 | — | 4 | wheel_medium.xml |
| 驾驶座椅 | Pilot Seat | 24 | 100 | 3x6x4 | 18 | seat.xml |
| 驾驶座椅(HOTAS) | Pilot Seat (HOTAS) | 50 | 250 | 3x6x5 | 64 | seat_hotas.xml |
| 定向天线 | RX Directional | 20 | 5000 | 5x4x5 | 12 | rx_directional.xml |
| 定向天线(大) | RX Directional (Large) | 35 | 8000 | 9x6x9 | 12 | rx_directional_large.xml |
| 巨型无线电接收器 | Radio RX Huge | 20 | 5000 | 1x9x1 | 6 | rx_huge.xml |
| 巨型无线电接收器 | Radio RX Huge | 20 | 3000 | 1x9x1 | 8 | rx_huge_v2.xml |
| 大型无线电RX | Radio RX Large | 12 | 200 | 1x5x1 | 6 | rx_large.xml |
| 大型无线电RX | Radio RX Large | 12 | 1000 | 1x5x1 | 8 | rx_large_v2.xml |
| 无线电接收中等 | Radio RX Medium | 8 | 1000 | 1x4x1 | 6 | rx_med.xml |
| 无线电接收中等 | Radio RX Medium | 8 | 500 | 1x4x1 | 8 | rx_med_v2.xml |
| 小型无线电接收 | Radio RX Small | 5 | 500 | 1x2x1 | 5 | rx_small.xml |
| 小型无线电接收 | Radio RX Small | 5 | 200 | 1x2x1 | 7 | rx_small_v2.xml |
| 无线图传接收端 | Radio Video Recv | 10 | 1000 | 1x4x1 | 4 | rx_video_r.xml |
| 无线图传发射端 | Radio Video Xmit | 10 | 2000 | 1x4x1 | 3 | rx_video_x.xml |
| 方向舵 | Rudder | 10 | 150 | — | 2 | rudder.xml |
| 摩托鞍座 | Saddle Seat | 5 | 75 | — | 18 | seat_saddle.xml |
| 雪橇 | Ski | 12 | 200 | 3x2x13 | 1 | ski.xml |
| 雪橇(小) | Ski (Small) | 8 | 100 | 1x2x9 | 1 | ski_small.xml |
| 公路轮(小) | Small Wheel | 5 | 30 | — | 4 | wheel_small.xml |
| 驾驶座椅(宇航) | Space Seat | 3 | 500 | — | 19 | seat_space.xml |
| 履带主动轮(巨) | Tank Drive Wheel (Huge) | 80 | 450 | — | 2 | wheel_tank_drive_7.xml |
| 履带主动轮(大) | Tank Drive Wheel (Large) | 40 | 350 | — | 2 | wheel_tank_drive_5.xml |
| 履带主动轮(中) | Tank Drive Wheel (Medium) | 30 | 300 | — | 2 | wheel_tank_drive_5_2.xml |
| 履带主动轮(小) | Tank Drive Wheel (Small) | 20 | 200 | — | 2 | wheel_tank_drive_1.xml |
| 履带主动轮(小宽) | Tank Drive Wheel (Small/Wide) | 25 | 250 | — | 2 | wheel_tank_drive_1_wide.xml |
| 履带从动轮(巨) | Tank Wheel (Huge) | 80 | 350 | — | 1 | wheel_tank_7.xml |
| 履带从动轮(大) | Tank Wheel (Large) | 40 | 250 | — | 1 | wheel_tank_5.xml |
| 履带从动轮(中) | Tank Wheel (Medium) | 30 | 200 | — | 1 | wheel_tank_5_2.xml |
| 履带从动轮(小) | Tank Wheel (Small) | 20 | 100 | — | 1 | wheel_tank_1.xml |
| 履带从动轮(小宽) | Tank Wheel (Small/Wide) | 25 | 100 | — | 1 | wheel_tank_1_wide.xml |
| 3x3轮 | Wheel 3x3 | 10 | 100 | — | 4 | wheel_advanced_3.xml |
| 3x3轮(悬挂) | Wheel 3x3 (Suspension) | 15 | 150 | — | 4 | wheel_advanced_3_sus.xml |
| 5x5轮 | Wheel 5x5 | 20 | 150 | — | 4 | wheel_advanced_5.xml |
| 5x5轮(悬挂) | Wheel 5x5 (Suspension) | 30 | 200 | — | 4 | wheel_advanced_5_sus.xml |
| 7x7轮 | Wheel 7x7 | 40 | 200 | — | 4 | wheel_advanced_7.xml |
| 7x7轮(悬挂) | Wheel 7x7 (Suspension) | 60 | 250 | — | 4 | wheel_advanced_7_sus.xml |
| 9x9轮 | Wheel 9x9 | 80 | 250 | — | 4 | wheel_advanced_9.xml |
| 9x9轮(悬挂) | Wheel 9x9 (Suspension) | 120 | 300 | — | 4 | wheel_advanced_9_sus.xml |
| 起落架轮(小) | Wheel Coaster | 4 | 25 | — | 2 | wheel_coaster.xml |
| 机翼前部(小) | Wing Front Section (Small) | 5 | 100 | — | 0 | wing_small_front.xml |
| 机翼面(大) | Wing Section (Large) | 20 | 500 | 3x7x16 | 0 | wing_large.xml |
| 机翼面(中) | Wing Section (Medium) | 15 | 350 | — | 0 | wing_medium.xml |
| 机翼面(小) | Wing Section (Small) | 8 | 150 | — | 0 | wing_small.xml |
| 机翼面(特大) | Wing Section (XLarge) | 30 | 800 | 3x7x22 | 0 | wing_xl.xml |
| 机翼面(超大) | Wing Section (XXLarge) | 50 | 1500 | 3x7x28 | 0 | wing_xxl.xml |

## cat[2] V 载具控制/仪表 （74 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 离合器 | Clutch | 2 | 50 | 1x2x1 | 4 | torque_clutch.xml |
| 直线轨道基座(紧凑型) | Compact Linear Track Base | 2.000000 | 20 | 1x1x1 | 2 | linear_compact_base.xml |
| 直线轨道扩展(紧凑型) | Compact Linear Track Extension | 1.000000 | 20 | 1x1x1 | 0 | linear_compact_module.xml |
| 直线轨头(紧凑型) | Compact Linear Track Head | 3.000000 | 0 | 1x1x1 | 0 | linear_compact_head.xml |
| compact_pivot_b | Compact Pivot | 1.000000 | 0 | 1x1x1 | 0 | multibody_compact_pivot_b.xml |
| 机械枢轴(紧凑 动力型) | Compact Pivot (Power) | 1 | 40 | — | 1 | multibody_compact_pivot_torque_a.xml |
| 机械枢轴(紧凑 动力型) | Compact Pivot (Power) | 1 |  | — | 1 | multibody_compact_pivot_torque_b.xml |
| 机械枢轴(紧凑型) | Compact Robotic Pivot | 1.000000 | 40 | 1x1x1 | 2 | multibody_compact_pivot_robotic_a.xml |
| 速度轴(紧凑型) | Compact Velocity Pivot | 1.000000 | 40 | 1x1x1 | 2 | multibody_compact_pivot_velocity_a.xml |
| 自定义门-门框控制器 | Door Frame Controller | 10 | 100 | 2x1x1 | 2 | door_frame_controller.xml |
| 自定义门-门框转角 | Door Frame Corner | 15 | 50 | 2x2x1 | 0 | door_frame_corner.xml |
| 自定义门-门框边缘 | Door Frame Edge | 5 | 10 | 1x1x1 | 0 | door_frame_straight.xml |
| 自定义门-门板角 | Door Panel Corner | 5 | 20 | 1x1x1 | 0 | door_panel_corner.xml |
| 自定义门-门板边缘 | Door Panel Edge | 5 | 10 | 1x1x1 | 0 | door_panel_straight.xml |
| 连接头(电力) | Electric Connector | 2 | 20 | 1x2x1 | 7 | connector_electric.xml |
| 连接头(流体) | Fluid Connector | 2 | 20 | 1x2x1 | 7 | connector_water.xml |
| 变速箱 | Gearbox | 8 | 100 | 1x2x2 | 4 | torque_gearbox.xml |
| 变速箱 | Gearbox | 8 | 100 | 1x2x2 | 4 | torque_gearbox_2.xml |
| 变速箱1x1 | Gearbox 1x1 | 1 | 50 | 1x1x1 | 4 | modular_engine_gearbox_1x1.xml |
| 变速箱3x3 | Gearbox 3x3 | 9 | 100 | 3x2x3 | 4 | modular_engine_gearbox_3x3.xml |
| 变速箱5x5 | Gearbox 5x5 | 25 | 150 | 5x3x5 | 4 | modular_engine_gearbox_5x5.xml |
| 硬点挂件 | Hardpoint Connector Attachment | 2 | 20 | 1x2x1 | 7 | connector_hardpoint_b.xml |
| 硬点挂件(圆形) | Hardpoint Connector Attachment (Round) | 2 | 20 | 1x2x1 | 7 | connector_hardpoint_b_round.xml |
| 硬点基座 | Hardpoint Connector Body | 2 | 20 | 1x1x3 | 9 | connector_hardpoint_a.xml |
| 连接头(铰接) | Hinge Connector | 3.000000 | 40 | 1x2x3 | 7 | connector_hinge.xml |
| 对接门(大) | Hinged Dock Door | 20 | 300 | 9x5x1 | 10 | door_dock_large.xml |
| 对接门(小) | Hinged Dock Hatch | 15 | 200 | 5x5x1 | 10 | door_dock_small.xml |
| 铰接门 | Hinged Door | 20 | 200 | 7x4x1 | 1 | door_manual_large.xml |
| 铰接舱门 | Hinged Hatch | 15 | 150 | 3x4x1 | 1 | door_manual_small.xml |
| 钥匙开关 | Key Button | 1.000000 | 20 | 1x2x1 | 3 | button_key.xml |
| 连接头(大) | Large Connector | 20 | 50 | 3x2x3 | 13 | connector_large.xml |
| 键盘(大) | Large Keypad | 1 | 40 | 1x2x2 | 5 | button_keypad_large.xml |
| 直线轨道基座 | Linear Track Base | 3 | 40 | 3x2x1 | 6 | linear_base.xml |
| 直线轨道扩展 | Linear Track Extension | 3.000000 | 10 | 3x2x1 | 0 | linear_module.xml |
| 直线轨头 | Linear Track Head | 3 | 0 | 3x1x1 | 2 | linear_head.xml |
| 按钮(可锁定) | Lockable Button | 1.000000 | 20 | 1x2x1 | 3 | button_lock.xml |
| 万能磁头 | Mag All | 5 | 250 | 1x3x1 | 4 | magall.xml |
| 活塞悬挂 | Piston Suspension | 20 | 20 | 1x2x1 | 0 | multibody_piston_suspension_a.xml |
| 活塞悬挂 | Piston Suspension | 20 | 0 | 1x1x1 | 0 | multibody_piston_suspension_b.xml |
| 枢轴 | Pivot | 1 | 20 | 1x2x1 | 0 | multibody_pivot_a.xml |
| ※未收录 | Pivot (Power) | 1 | 20 | — | 1 | multibody_pivot_torque_a.xml |
| 气动活塞 | Pneumatic Piston | 5 | 100 | 1x3x1 | 4 | linear_matic_a.xml |
| 气动活塞 | Pneumatic Piston | 3 | 0 | 1x2x1 | 1 | linear_matic_b.xml |
| 按钮(按压式) | Push Button | 1.000000 | 10 | 1x2x1 | 3 | button_push.xml |
| 按钮(双面按压式) | Push Button (2 Sided) | 1 | 10 | 1x2x1 | 3 | button_push_2side.xml |
| 动量轮 | Reaction Wheel | 15 | 300 | — | 2 | gyroscopic_stabilizer.xml |
| 动量轮(大) | Reaction Wheel (Large) | 80 | 700 | 5x3x5 | 2 | gyroscopic_stabilizer_large.xml |
| 动量轮(小) | Reaction Wheel (Small) | 2 | 150 | — | 2 | gyroscopic_stabilizer_small.xml |
| 自定义门-铰链[主] | Robotic Door Hinge | 3 | 400 | 1x2x3 | 3 | multibody_door_hinge_a.xml |
| 自定义门-铰链[主] | Robotic Door Hinge | 3 | 0 | 1x1x3 | 0 | multibody_door_hinge_b.xml |
| 机械铰链[主] | Robotic Hinge | 3 | 400 | 1x2x3 | 5 | multibody_robotic_hinge_01_a.xml |
| 机械铰链[主] | Robotic Hinge | 3 | 0 | 1x1x3 | 2 | multibody_robotic_hinge_01_b.xml |
| 机械枢轴(流体) | Robotic Pivot (Fluid) | 9 | 200 | 3x1x3 | 4 | multibody_robotic_pivot_01_a_fluid.xml |
| 机械枢轴(动力) | Robotic Pivot (Power) | 9 | 200 | 3x1x3 | 4 | multibody_robotic_pivot_01_a.xml |
| 滑动连接头夹持器 | Sliding Connector Gripper | 2 | 20 | 1x2x1 | 2 | connector_slider_gripper.xml |
| 滑动连接头轨道 | Sliding Connector Track | 2 | 10 | 1x1x1 | 0 | connector_slider_track.xml |
| 滑动门(手动) | Sliding Door | 20 | 50 | 1x7x6 | 1 | door_manual.xml |
| 滑动门(电动) | Sliding Door (Electric) | 20 | 70 | 1x7x6 | 2 | door.xml |
| 滑动舱门(手动) | Sliding Hatch | 20 | 40 | 1x3x6 | 1 | door_manual_sliding_small.xml |
| 滑动舱口(电动) | Sliding Hatch (Electric) | 15 | 50 | 1x3x6 | 2 | hatch.xml |
| 连接头(小) | Small Connector | 2.000000 | 20 | 1x2x1 | 7 | connector_small.xml |
| 键盘(小) | Small Keypad | 1 | 20 | 1x2x1 | 3 | button_keypad_small.xml |
| 悬挂 | Suspension | 5 | 50 | 2x3x3 | 1 | multibody_suspension_a.xml |
| 悬挂 | Suspension | 3 | 0 | 1x1x1 | 1 | multibody_suspension_b.xml |
| 油门推杆 | Throttle Lever | 1 | 30 | 2x2x1 | 4 | button_throttle_lever.xml |
| 按钮(切换式) | Toggle Button | 1.000000 | 10 | 1x2x1 | 3 | button_toggle.xml |
| 按钮(双面切换式) | Toggle Button (2 Sided) | 1 | 10 | 1x2x1 | 3 | button_toggle_2side.xml |
| 动力连接器 | Torque Connector | 2 | 20 | — | 7 | connector_torque.xml |
| 炮塔座圈(大) | Turret Ring (Large) | 36 | 100 | 9x1x9 | 3 | multibody_turret_large_a.xml |
| 炮塔座圈(中) | Turret Ring (Medium) | 22 | 75 | 7x1x7 | 3 | multibody_turret_medium_a.xml |
| 炮塔座圈(小) | Turret Ring (Small) | 14 | 50 | 5x1x5 | 3 | multibody_turret_small_a.xml |
| 速度轴 | Velocity Pivot | 9.000000 | 25 | 3x1x3 | 3 | multibody_velocity_pivot_a.xml |
| 速度轴(流体) | Velocity Pivot (Fluid) | 9 | 200 | — | 4 | multibody_velocity_pivot_01_a_fluid.xml |
| 速度轴(动力) | Velocity Pivot (Power) | 9 | 200 | 3x1x3 | 4 | multibody_velocity_pivot_01_a_torque.xml |

## cat[3] P 推进 （68 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 飞机螺旋桨 | Aircraft Propeller | 2 | 125 | 11x2x11 | 2 | aircraft_propeller.xml |
| 方位推进器 | Azimuth Thruster | 4 | 150 | 3x3x4 | 1 | azimuth_thruster.xml |
| 船用螺旋桨(大) | Giant Propeller | 100 | 500 | 9x3x9 | 1 | giga_prop_small.xml |
| 重型大螺旋桨 | Heavy Large Rotor | 20 | 1450 | 37x4x37 | 4 | heavy_rotor_large.xml |
| 重型螺旋桨 | Heavy Rotor | 10 | 850 | 25x4x25 | 4 | heavy_rotor.xml |
| 巨型螺旋桨 | Huge Rotor | 20 | 250 | 33x3x33 | 4 | huge_rotor.xml |
| 涵道风扇(大) | Large Ducted Fan | 10 | 100 | 7x1x7 | 1 | fan_large.xml |
| 电动机(大) | Large Electric Motor | 400 | 5000 | 5x5x5 | 3 | motor_large.xml |
| 发动机(大型) | Large Engine | 400 | 3000 | 5x8x11 | 12 | engine_diesel.xml |
| 变距螺旋桨(大) | Large Pitchable Propeller | 100 | 600 | 19x5x19 | 2 | propeller_pitch_large.xml |
| 船用螺旋桨(中) | Large Propeller | 20 | 250 | 5x2x5 | 1 | large_propeller.xml |
| 大螺旋桨 | Large Rotor | 10 | 150 | 33x3x33 | 4 | large_rotor.xml |
| 液体火箭发动机 | Liquid Fuel Rocket | 60 | 4500 | 5x9x5 | 6 | liquid_rocket.xml |
| 液体火箭发动机(大) | Liquid Fuel Rocket (Large) | 80 | 6500 | 7x13x7 | 6 | liquid_rocket_large.xml |
| 液体火箭发动机(小) | Liquid Fuel Rocket (Small) | 40 | 2500 | 3x7x3 | 6 | liquid_rocket_small.xml |
| 电动机(中) | Medium Electric Motor | 100 | 1500 | 3x3x3 | 3 | motor_medium.xml |
| 发动机(中型) | Medium Engine | 80 | 1000 | 3x4x7 | 12 | aircraft_engine.xml |
| 变距螺旋桨(中) | Pitchable Propeller | 40 | 300 | 11x3x11 | 2 | propeller_pitch.xml |
| 旋翼(大) | Rotor (Large) | 20 | 1050 | — | 5 | rotor_coaxial_large.xml |
| 旋翼(轻) | Rotor (Light) | 4 | 150 | — | 5 | rotor_coaxial_light.xml |
| 旋翼(小) | Rotor (Small) | 10 | 250 | — | 5 | rotor_coaxial_small.xml |
| 尾桨 | Rotor (Tail) | 4 | 100 | 11x2x11 | 2 | tail_rotor.xml |
| 旋翼末端(轻) | Rotor End (Light) | 4 | 150 | — | 4 | rotor_coaxial_light_end.xml |
| 旋翼推进器(大) | Rotor Propeller (Large) | 30 | 1850 | — | 5 | rotor_coaxial_prop.xml |
| 旋翼推进器(小) | Rotor Propeller (Small) | 20 | 850 | — | 5 | rotor_coaxial_prop_small.xml |
| 旋翼末端(大) | Rotor Propeller End (Large) | 30 | 1850 | 31x3x31 | 4 | rotor_coaxial_prop_end.xml |
| 旋翼推进器末端(小) | Rotor Propeller End (Small) | 20 | 850 | 21x3x21 | 4 | rotor_coaxial_prop_small_end.xml |
| 涵道风扇(小) | Small Ducted Fan | 6 | 50 | 5x1x5 | 1 | fan_small.xml |
| 电动机(小) | Small Electric Motor | 5 | 450 | 1x1x1 | 3 | motor_small.xml |
| 发动机(小型) | Small Engine | 30 | 400 | 3x3x3 | 11 | engine.xml |
| 变距螺旋桨(小) | Small Pitchable Propeller | 10 | 75 | — | 2 | propeller_pitch_small.xml |
| 船用螺旋桨(小) | Small Propeller | 3 | 75 | 1x3x1 | 1 | propeller.xml |
| 固体火箭助推器(巨) | Solid Rocket Booster (Huge) | 50 | 2000 | 7x4x7 | 2 | solid_rocket_nozzle_huge.xml |
| 固体火箭助推器(大) | Solid Rocket Booster (Large) | 30 | 800 | 5x4x5 | 2 | solid_rocket_nozzle_large.xml |
| 固体火箭助推器(中) | Solid Rocket Booster (Medium) | 20 | 300 | 3x4x3 | 2 | solid_rocket_nozzle_medium.xml |
| 固体火箭助推器(小) | Solid Rocket Booster (Small) | 5 | 100 | 1x1x1 | 1 | solid_rocket_nozzle_small.xml |
| 固体火箭燃料(巨) | Solid Rocket Fuel (Huge) | 50 | 500 | 7x3x7 | 0 | solid_rocket_huge.xml |
| 固体火箭燃料(巨)(弹翼) | Solid Rocket Fuel (Huge) (Fins) | 50 | 1000 | 7x3x7 | 2 | solid_rocket_huge_fins.xml |
| 固体火箭燃料(大) | Solid Rocket Fuel (Large) | 30 | 400 | 5x3x5 | 0 | solid_rocket_large.xml |
| 固体火箭燃料(大)(弹翼) | Solid Rocket Fuel (Large) (Fins) | 30 | 800 | 5x3x5 | 2 | solid_rocket_large_fins.xml |
| 固体火箭燃料(中) | Solid Rocket Fuel (Medium) | 20 | 200 | 3x3x3 | 0 | solid_rocket_medium.xml |
| 固体火箭燃料(中)(弹翼) | Solid Rocket Fuel (Medium) (Fins) | 20 | 400 | 3x3x3 | 2 | solid_rocket_medium_fins.xml |
| 固体火箭燃料(小) | Solid Rocket Fuel (Small) | 5 | 100 | 1x1x1 | 0 | solid_rocket_small.xml |
| 固体火箭燃料(小)(弹翼) | Solid Rocket Fuel (Small) (Fins) | 5 | 200 | 1x1x1 | 2 | solid_rocket_small_fins.xml |
| 手摇曲柄 | Torque Crank | 4 | 25 | — | 1 | torque_crank.xml |
| 扭矩计 | Torque Meter | 4 | 25 | 1x2x1 | 3 | torque_meter.xml |
| 火车轮总成(旧版) | Train Wheel Assembly Classic | 400 | 100 | — | 5 | train_wheels.xml |
| 有轮缘轮轴总成A | Train Wheel Assembly Flanged A | 200 | 50 | — | 3 | train_wheels_dynamic_flanged.xml |
| 有轮缘轮轴总成B | Train Wheel Assembly Flanged B | 200 | 50 | — | 3 | train_wheels_dynamic_flanged_b.xml |
| 有轮缘轮轴总成C | Train Wheel Assembly Flanged C | 200 | 50 | — | 3 | train_wheels_dynamic_flanged_c.xml |
| 有轮缘轮轴总成D | Train Wheel Assembly Flanged D | 200 | 50 | — | 3 | train_wheels_dynamic_flanged_d.xml |
| 转向架总成(中) | Train Wheel Assembly Medium | 200 | 50 | — | 4 | train_wheels_dynamic_steam_basic_mid.xml |
| 列车动轮总成(小) | Train Wheel Assembly Small | 200 | 50 | — | 4 | train_wheels_dynamic_steam_small_basic.xml |
| 蒸汽机车动轮A(大) | Train Wheel Assembly Steam Large A | 400 | 100 | — | 3 | train_wheels_dynamic_steam_large.xml |
| 蒸汽机车动轮B(大) | Train Wheel Assembly Steam Large B | 400 | 100 | — | 3 | train_wheels_dynamic_steam_large_b.xml |
| 蒸汽机车动轮A(中) | Train Wheel Assembly Steam Medium A | 200 | 50 | — | 3 | train_wheels_dynamic_steam_mid.xml |
| 蒸汽机车动轮B(中) | Train Wheel Assembly Steam Medium B | 200 | 50 | — | 3 | train_wheels_dynamic_steam_mid_b.xml |
| 蒸汽机车动轮A(小) | Train Wheel Assembly Steam Small A | 200 | 50 | — | 3 | train_wheels_dynamic_steam_small.xml |
| 蒸汽机车动轮B(小) | Train Wheel Assembly Steam Small B | 200 | 50 | — | 3 | train_wheels_dynamic_steam_small_b.xml |
| 列车转向架总成(带悬挂) x1 | Train Wheel Assembly x1 | 200 | 50 | — | 4 | train_wheels_dynamic_x1.xml |
| 列车转向架总成(带悬挂) x1(小) | Train Wheel Assembly x1 Small | 200 | 50 | — | 4 | train_wheels_dynamic_x1_small.xml |
| 列车转向架总成 x1(小)(紧凑型) | Train Wheel Assembly x1 Small (Compact) | 150 | 50 | — | 4 | train_wheels_dynamic_x1_xsmall.xml |
| 列车转向架总成(带悬挂) x2 | Train Wheel Assembly x2 | 350 | 100 | — | 5 | train_wheels_dynamic_x2.xml |
| 列车转向架总成(带悬挂) x3 | Train Wheel Assembly x3 | 450 | 150 | — | 5 | train_wheels_dynamic_x3.xml |
| 蒸汽机车驱动活塞(大) | Train Wheel Drive Piston Large | 600 | 600 | — | 5 | train_wheels_piston_large.xml |
| 蒸汽机车驱动活塞(中) | Train Wheel Drive Piston Medium | 400 | 400 | — | 5 | train_wheels_piston_mid.xml |
| 蒸汽机车驱动活塞(小) | Train Wheel Drive Piston Small | 300 | 300 | — | 5 | train_wheels_piston.xml |
| 涡轮发动机 | Turbine Engine | 45 | 150 | 3x3x7 | 4 | turbine.xml |

## cat[4] M 机械 （115 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 床 | Bed | 20 | 250 | 3x4x7 | 1 | seat_bed.xml |
| ※未收录 | Buoyancy Float Block | 1 | 50 | 4x4x4 | 0 | buoyancy_float_block.xml |
| ※未收录 | Buoyancy Float Pyramid | 1 | 50 | 4x4x4 | 0 | buoyancy_float_pyramid.xml |
| ※未收录 | Buoyancy Float Wedge | 1 | 50 | 4x4x4 | 0 | buoyancy_float_wedge.xml |
| 摄像头云台 | Camera Gimbal | 50 | 5000 | 3x3x3 | 6 | camera_gimbal.xml |
| 摄像头(中型) | Camera Medium | 10 | 3000 | — | 5 | camera_med.xml |
| 摄像头(小型) | Camera Small | 5 | 1000 | — | 3 | camera_small.xml |
| 自稳定云台摄像机 | Camera Stabilized | 60 | 50000 | 3x3x3 | 12 | camera_gimbal_laser.xml |
| 电缆滑轮(U型) | Electric Cable Pulley | 25 | 250 | — | 4 | winch_pulley_cable.xml |
| 电缆滑轮(L型) | Electric Cable Pulley (Corner) | 25 | 250 | — | 4 | winch_pulley_cable_corner.xml |
| 电缆锚 | Electrical Cable Anchor | 1 | 15 | — | 10 | rope_hook_composite.xml |
| 装备架[手榴弹] | Equipment Inventory (Hand Grenade) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_grenade.xml |
| 装备架[手枪弹药] | Equipment Inventory (Pistol Ammo) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_pistol_ammo.xml |
| 装备架(望远镜) | Equipment inventory (Binoculars) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_binoculars.xml |
| 装备架[C4起爆器] | Equipment inventory (C4 Detonator) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_c4_detonator.xml |
| 装备架[C4炸药] | Equipment inventory (C4 Explosive) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_c4.xml |
| 装备架(电缆) | Equipment inventory (Cable) | 3 | 200 | 1x1x3 | 1 | inventory_equipment_cable.xml |
| 装备架(指南针) | Equipment inventory (Compass) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_compass.xml |
| 装备架(除颤器) | Equipment inventory (Defibrillator) | 3 | 200 | 1x1x3 | 1 | inventory_equipment_defibrillator.xml |
| 装备架(狗哨) | Equipment inventory (Dog Whistle) | 1 | 50 | — | 1 | inventory_equipment_dog_whistle.xml |
| 装备架(灭火器) | Equipment inventory (Fire Extinguisher) | 3 | 200 | 1x1x3 | 1 | inventory_equipment_fire_extinguisher.xml |
| 装备架(急救包) | Equipment inventory (First Aid Kit) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_first_aid.xml |
| 装备架(鱼竿) | Equipment inventory (Fishing Rod) | 3 | 200 | 1x1x3 | 1 | inventory_equipment_fishing_rod.xml |
| 装备架(手持燃烧照明棒) | Equipment inventory (Flare) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_flare.xml |
| 装备架(信号弹枪弹药) | Equipment inventory (Flaregun Ammo) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_flaregun_ammo.xml |
| 装备架(信号弹枪) | Equipment inventory (Flaregun) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_flaregun.xml |
| 装备架(手电筒) | Equipment inventory (Flashlight) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_flashlight.xml |
| 装备架(荧光棒) | Equipment inventory (Glowstick) | 1 | 50 | — | 1 | inventory_equipment_glowstick.xml |
| 装备架(软管) | Equipment inventory (Hose) | 3 | 200 | 1x1x3 | 1 | inventory_equipment_hose.xml |
| 装备架(夜视望远镜) | Equipment inventory (Night Vision Binoculars) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_night_vision_binoculars.xml |
| 装备架(氧气面罩) | Equipment inventory (Oxygen Mask) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_oxygen_mask.xml |
| 装备架[手枪] | Equipment inventory (Pistol) | 1 | 200 | 1x1x1 | 1 | inventory_equipment_pistol.xml |
| 装备架(辐射指示器) | Equipment inventory (Radiation Detector) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_geiger_counter.xml |
| 装备架(无线电信号定位器) | Equipment inventory (Radio Signal Locator) | 3 | 200 | 1x1x3 | 1 | inventory_equipment_radio_signal_locator.xml |
| 装备架(无线电) | Equipment inventory (Radio) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_radio.xml |
| 装备架(远程控制单元) | Equipment inventory (Remote Control Unit) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_remote_control.xml |
| 装备架[步枪弹药] | Equipment inventory (Rifle Ammo) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_rifle_ammo.xml |
| 装备架[步枪] | Equipment inventory (Rifle) | 3 | 200 | 1x1x3 | 1 | inventory_equipment_rifle.xml |
| 装备架(绳索) | Equipment inventory (Rope) | 3 | 200 | 1x1x3 | 1 | inventory_equipment_rope.xml |
| 装备架[冲锋枪弹药] | Equipment inventory (SMG Ammo) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_smg_ammo.xml |
| 装备架[冲锋枪] | Equipment inventory (SMG) | 3 | 200 | 1x1x3 | 1 | inventory_equipment_smg.xml |
| 装备架(鱼叉枪弹药) | Equipment inventory (Speargun Ammo) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_speargun_ammo.xml |
| 装备架[鱼叉枪] | Equipment inventory (Speargun) | 3 | 200 | 1x1x3 | 1 | inventory_equipment_speargun.xml |
| 装备架(频闪灯) | Equipment inventory (Strobe Light) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_strobe_light.xml |
| 装备架(红外频闪灯) | Equipment inventory (Strobe Light, Infrared) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_strobe_light_infrared.xml |
| 装备架(应急信标) | Equipment inventory (Transponder) | 1 | 50 | 1x1x1 | 1 | inventory_equipment_transponder.xml |
| 装备架(水下火旱枪) | Equipment inventory (Underwater Welding Torch) | 3 | 200 | 1x1x3 | 1 | inventory_equipment_underwater_welding_torch.xml |
| 装备架(火旱枪) | Equipment inventory (Welding Torch) | 3 | 200 | 1x1x3 | 1 | inventory_equipment_welding_torch.xml |
| 信号弹发射器 | Flare Launcher | 1 | 10 | 1x2x1 | 2 | flare_launcher.xml |
| 水炮云台 | Fluid Cannon | 11 | 100 | 3x3x3 | 4 | watercannon.xml |
| 流体软管锚 | Fluid Hose Anchor | 1 | 15 | — | 2 | rope_hook_fluid.xml |
| 流体软管滑轮(U型) | Fluid Hose Pulley | 25 | 250 | — | 6 | winch_pulley_hose.xml |
| 流体软管滑轮(L型) | Fluid Hose Pulley (Corner) | 25 | 250 | — | 6 | winch_pulley_hose_corner.xml |
| 水炮喷嘴 | Fluid Nozzle | 1 | 100 | 1x2x1 | 3 | water_nozzle.xml |
| 雾号 | Foghorn | 5 | 200 | 4x3x3 | 2 | foghorn.xml |
| 安全带 | Harness | 20 | 150 | 3x6x3 | 9 | seat_harness.xml |
| 加热器 | Heater | 3 | 50 | 1x1x3 | 2 | heater.xml |
| 软管 | Hose | 25 | 100 | 3x4x3 | 5 | water_hose.xml |
| 绞车(巨) | Huge Winch | 400 | 5000 | — | 16 | rope_hook_winch_huge.xml |
| 绞车(巨) | Huge Winch | 400 | 5000 | 9x7x7 | 5 | winch_huge_a.xml |
| 着陆浮子 | Landing Float | 1 | 50 | 3x3x9 | 0 | landing_float.xml |
| 绞车(大) | Large Winch | 100 | 800 | — | 16 | rope_hook_winch_large.xml |
| 绞车(大) | Large Winch | 100 | 800 | 3x4x3 | 5 | winch_large_a.xml |
| 空装备架1x3 | Large equipment inventory (Empty) | 3 | 50 | 1x1x3 | 1 | inventory_medium.xml |
| 灯 | Light | 1 | 20 | 1x2x1 | 2 | small_light.xml |
| 灯(RGB) | Light (RGB) | 1 | 50 | 1x2x1 | 2 | small_light_rgb.xml |
| 病床 | Medical Bed | 40 | 2500 | 3x4x7 | 1 | seat_medical.xml |
| 绞车(中) | Medium Winch | 20 | 250 | — | 15 | rope_hook_winch.xml |
| 绞车(中) | Medium Winch | 20 | 250 | 3x2x1 | 5 | winch_a.xml |
| 扩音器(大) | Megaphone Speaker (Large) | 10 | 1000 | 3x3x5 | 3 | speaker_large.xml |
| 扩音器(小) | Megaphone Speaker (Small) | 3 | 500 | 1x1x2 | 3 | speaker_medium.xml |
| 采矿钻头 | Mineral Drill | 110 | 20000 | 3x6x3 | 1 | mineral_drill.xml |
| 按钮触手 | Mounted End-Effector | 10 | 1000 | — | 2 | vehicle_tool_interact.xml |
| 电焊机 | Mounted Welder | 10 | 1000 | — | 2 | vehicle_tool_welder.xml |
| 装备架(极地) | Outfit Inventory (Arctic) | 9 | 500 | 3x3x1 | 1 | inventory_outfit_arctic.xml |
| 装备架(防弹背心) | Outfit Inventory (Armor Vest) | 9 | 1500 | 3x3x1 | 1 | inventory_outfit_wep_armor_vest.xml |
| 装备架(黑鹰防弹背心) | Outfit Inventory (Black Hawk Vest) | 9 | 500 | 3x3x1 | 1 | inventory_outfit_wep_black_hawk_vest.xml |
| 装备架(拆弹防护服) | Outfit Inventory (Bomb Disposal) | 9 | 1500 | 3x3x1 | 1 | inventory_outfit_wep_bomb_disposal.xml |
| 装备架(胸挂) | Outfit Inventory (Chest Rig) | 9 | 500 | 3x3x1 | 1 | inventory_outfit_wep_chest_rig.xml |
| 装备架(潜水) | Outfit Inventory (Diving) | 9 | 2000 | — | 2 | inventory_outfit_diving.xml |
| 空装备架3x3 | Outfit Inventory (Empty) | 9 | 50 | 3x3x1 | 1 | inventory_outfit.xml |
| 装备架(呼吸器消防服) | Outfit Inventory (Firefighter SCBA) | 9 | 1000 | 3x3x1 | 2 | inventory_outfit_firefighter_scba.xml |
| 装备架(消防服) | Outfit Inventory (Firefighter) | 9 | 500 | 3x3x1 | 1 | inventory_outfit_firefighter.xml |
| 装备架(防化服) | Outfit Inventory (Hazmat) | 9 | 500 | 3x3x1 | 1 | inventory_outfit_hazmat.xml |
| 装备架(降落伞) | Outfit Inventory (Parachute) | 9 | 500 | 3x3x1 | 1 | inventory_outfit_parachute.xml |
| 装备架(插板胸挂) | Outfit Inventory (Plate Vest) | 9 | 800 | 3x3x1 | 1 | inventory_outfit_wep_plate_vest.xml |
| 装备架(水肺) | Outfit Inventory (Scuba) | 9 | 500 | — | 2 | inventory_outfit_scuba.xml |
| 装备架(探索型航天服) | Outfit Inventory (Space Exploration) | 9 | 10000 | — | 2 | inventory_outfit_space_suit_exploration.xml |
| 装备架(航天服) | Outfit Inventory (Space) | 9 | 5000 | — | 2 | inventory_outfit_space_suit.xml |
| 软垫座椅 | Padded Seat | 2 | 25 | 2x4x2 | 1 | seat_padded.xml |
| 乘客座椅 | Passenger Seat | 20 | 50 | 3x5x3 | 1 | passenger_seat.xml |
| 乘客座椅 | Passenger Seat | 6 | 50 | 3x5x3 | 1 | seat_passenger.xml |
| RCS推进器 | RCS Thruster | 1 | 140 | — | 3 | rcs_thruster.xml |
| 绳锚 | Rope Anchor | 1 | 15 | — | 2 | rope_hook.xml |
| 绳索滑轮(U型) | Rope Pulley | 25 | 250 | — | 4 | winch_pulley.xml |
| 绳索滑轮(L型) | Rope Pulley (Corner) | 25 | 250 | — | 4 | winch_pulley_corner.xml |
| 旋转警灯 | Rotating Light | 1 | 50 | — | 2 | rotating_light.xml |
| 乘客鞍座 | Saddle Passenger Seat | 3 | 25 | — | 1 | seat_saddle_passenger.xml |
| 船帆锚点 | Sail Anchor | 3 | 50 | — | 2 | rope_hook_sail.xml |
| 探照灯 | Search Light | 20 | 30 | 3x3x3 | 3 | searchlight.xml |
| 汽笛 | Siren | 5 | 200 | 3x3x5 | 2 | siren.xml |
| 小聚光灯(块) | Small Spotlight (Block) | 1 | 20 | — | 3 | searchlight_small.xml |
| 小聚光灯(挂载) | Small Spotlight (Mounted) | 1 | 20 | — | 3 | searchlight_small_2.xml |
| 绞车(小) | Small Winch | 10 | 100 | — | 5 | rope_hook_winch_small.xml |
| 绞车(小) | Small Winch | 10 | 100 | 1x2x1 | 4 | winch_electric.xml |
| 空装备架1x1 | Small equipment inventory (Empty) | 1 | 50 | 1x1x1 | 1 | inventory_small.xml |
| 声纳干扰器 | Sonar Noisemaker | 1 | 250 | — | 2 | sonar_jammer.xml |
| 担架 | Stretcher | 80 | 250 | 3x3x7 | 1 | seat_stretcher.xml |
| 应急信标 | Transponder | 1 | 20 | 1x1x1 | 2 | transponder.xml |
| 载具降落伞 | Vehicle Parachute | 5 | 500 | 3x1x3 | 1 | parachute.xml |
| 绞车终端 | winch end | 20 | 0 | 1x1x1 | 1 | water_hose_b.xml |
| 绞车终端 | winch end | 20 | 0 | 1x1x1 | 1 | winch_b.xml |
| 绞车终端 | winch end | 20 | 0 | 1x1x1 | 1 | winch_electric_b.xml |
| 绞车终端 | winch end | 20 | 0 | 1x1x1 | 1 | winch_huge_b.xml |
| 绞车终端 | winch end | 20 | 0 | 1x1x1 | 1 | winch_large_b.xml |

## cat[5] L 逻辑 （38 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 绝对值(Abs) | Abs | 1 | 20 | 1x1x2 | 2 | gate_float_abs.xml |
| 加(Add) | Add | 1.000000 | 20 | 2x1x2 | 3 | gate_float_add.xml |
| 与(And) | And | 1.000000 | 20 | 2x1x2 | 3 | gate_bool_and.xml |
| 闪烁开关 | Blinker | 1.000000 | 20 | 1x1x2 | 2 | gate_bool_blink.xml |
| 电容器 | Capacitor | 1 | 20 | 1x1x2 | 2 | gate_bool_capacitor.xml |
| Clamp函数 | Clamp | 1.000000 | 20 | 1x1x2 | 2 | gate_float_clamp.xml |
| 常数 | Constant Number | 1.000000 | 20 | 1x1x1 | 1 | gate_float_constant.xml |
| 恒定ON信号 | Constant On Signal | 1.000000 | 20 | 1x1x1 | 1 | gate_bool_constant.xml |
| 计数器 | Counter | 1.000000 | 20 | 1x1x2 | 2 | gate_float_counter.xml |
| 计数器(振荡) | Counter (Ping Pong) | 1.000000 | 20 | 1x1x2 | 2 | gate_float_counter_ping_pong.xml |
| 延迟 | Delay | 1.000000 | 20 | 1x1x2 | 2 | gate_bool_delay.xml |
| 除 | Divide | 1 | 20 | 2x1x2 | 4 | gate_float_divide.xml |
| 指数 | Exponent | 1 | 20 | 1x1x2 | 2 | gate_float_exponent.xml |
| 函数(1个输入) | Function (1 input) | 1 | 80 | 1x1x2 | 2 | gate_function_small.xml |
| 函数(3个输入) | Function (3 inputs) | 1 | 100 | 2x1x2 | 4 | gate_function_large.xml |
| 大于 | Greater-than | 1 | 20 | 2x1x2 | 3 | gate_float_greater_than.xml |
| JK触发器 | JK Flip-Flop | 1 | 20 | 2x1x2 | 4 | gate_jk_flipflop.xml |
| 小于 | Less-Than | 1.000000 | 20 | 2x1x2 | 3 | gate_float_less_than.xml |
| 存储寄存器 | Memory Register | 1.000000 | 20 | 2x1x2 | 4 | gate_float_register.xml |
| 微处理器 | Microprocessor | 1 | 100 | 1x1x1 | 0 | microprocessor.xml |
| 模(Modulo) | Modulo | 1.000000 | 20 | 2x1x2 | 3 | gate_float_modulo.xml |
| 乘 | Multiply | 1.000000 | 20 | 2x1x2 | 3 | gate_float_multiply.xml |
| 非(Not) | Not | 1.000000 | 20 | 1x1x2 | 2 | gate_bool_not.xml |
| 数字取反器 | Numerical Inverter | 1.000000 | 20 | 1x1x2 | 2 | gate_float_invert.xml |
| 数字输出节点 | Numerical Junction | 1.000000 | 20 | 2x1x2 | 4 | gate_float_switch.xml |
| 数字信号选择器 | Numerical Switchbox | 1.000000 | 20 | 2x1x2 | 4 | gate_float_switch_input.xml |
| 或(Or) | Or | 1.000000 | 20 | 2x1x2 | 3 | gate_bool_or.xml |
| PID控制器 | PID Controller | 1.000000 | 100 | 2x1x2 | 4 | gate_pid_controller.xml |
| 动力加和(Power Add) | Power Add | 1 | 20 | 2x1x2 | 1 | gate_torque_add.xml |
| 功率计(Power Meter) | Power Meter | 1 | 20 | 2x1x2 | 1 | gate_torque_multimeter.xml |
| 按压-切换 | Push to Toggle | 1.000000 | 20 | 1x1x2 | 2 | gate_push_to_toggle.xml |
| SR锁存器 | SR Latch | 1 | 20 | 2x1x2 | 4 | gate_sr_latch.xml |
| 减去 | Subtract | 1.000000 | 20 | 2x1x2 | 3 | gate_float_subtract.xml |
| 阈值门 | Threshold Gate | 1.000000 | 20 | 1x1x2 | 2 | gate_float_threshold.xml |
| 铁路交叉口控制器 | Train Junction Controller | 1 | 20 | 1x1x2 | 2 | gate_train_junction.xml |
| 三角函数 | Trigonometry | 1 | 20 | 1x1x2 | 2 | gate_float_sin.xml |
| 上/下 | Up/Down | 1.000000 | 20 | 2x1x2 | 3 | gate_up_down.xml |
| 异或(Xor) | Xor | 1.000000 | 20 | 2x1x2 | 3 | gate_bool_xor.xml |

## cat[6] U 显示 （25 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 水平仪 | Artificial Horizon | 1.000000 | 20 | 1x1x1 | 2 | artificial_horizon.xml |
| 蜂鸣器 | Buzzer | 1 | 100 | 1x1x1 | 2 | buzzer.xml |
| 时钟 | Clock | 1 | 100 | 1x2x1 | 3 | clock.xml |
| 指南针球 | Compass Ball | 1.000000 | 20 | 1x1x1 | 2 | compass.xml |
| 刻度表 | Dial | 1.000000 | 20 | 1x2x1 | 3 | dial.xml |
| 数字显示器 | Digital Display | 2.000000 | 20 | 1x1x2 | 3 | digital_display.xml |
| 仪表显示 | Gauge Display | 2.000000 | 20 | 1x2x2 | 4 | gauge_display.xml |
| HUD(大) | HUD Large | 18 | 10000 | 3x1x3 | 4 | monitor_hud_3.xml |
| HUD(小) | HUD Small | 2 | 2000 | 1x1x1 | 4 | monitor_hud_1.xml |
| 指示灯 | Indicator Light | 1.000000 | 20 | 1x1x1 | 2 | indicator.xml |
| 指示灯(RGB) | Indicator Light (RGB) | 1 | 50 | 1x1x1 | 2 | indicator_rgb.xml |
| 仪表板 | Instrument Panel | 1 | 200 | 1x2x1 | 4 | instrument_display.xml |
| 激光信标 | Laser Beacon | 1 | 5 | 1x2x1 | 3 | laser_beacon.xml |
| 显示器1x1 | Monitor 1x1 | 4 | 500 | 1x1x1 | 4 | monitor_1.xml |
| 显示器1x2 | Monitor 1x2 | 8 | 1000 | 2x1x1 | 4 | monitor_1x2.xml |
| 显示器1x3 | Monitor 1x3 | 12 | 1500 | 3x1x1 | 4 | monitor_1x3.xml |
| 显示器 2x2 | Monitor 2x2 | 16 | 2000 | 2x1x2 | 4 | monitor_2.xml |
| 显示器 2x3 | Monitor 2x3 | 24 | 3000 | 3x1x2 | 4 | monitor_2x3.xml |
| 显示器3x3 | Monitor 3x3 | 36 | 4500 | 3x1x3 | 4 | monitor_3.xml |
| 显示器5x3 | Monitor 5x3 | 60 | 7500 | 5x1x3 | 4 | monitor_5.xml |
| 显示器9x5 | Monitor 9x5 | 180 | 20000 | 9x1x5 | 4 | monitor_9.xml |
| 可涂标志(带背光) | Paintable Indicator | 2 | 100 | 1x1x1 | 2 | sign.xml |
| 可涂标志 | Paintable Sign | 1 | 50 | — | 0 | sign_na.xml |
| 扬声器(小) | Speaker (Small) | 1 | 250 | 1x2x1 | 3 | speaker.xml |
| 观瞄镜 | Viewing Scope | 5 | 2000 | — | 3 | viewing_scope.xml |

## cat[7] S 传感器 （41 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 高度计 | Altimeter | 1 | 20 | 1x1x1 | 1 | altimeter.xml |
| 角速度传感器 | Angular Speed Sensor | 1 | 20 | 1x1x1 | 1 | angular_speed_sensor.xml |
| 天文传感器 | Astronomy Sensor | 1 | 150 | — | 1 | astronomy_sensor.xml |
| 气压计 | Barometer | 1 | 20 | — | 1 | barometer.xml |
| 罗盘传感器 | Compass Sensor | 1.000000 | 20 | 1x2x1 | 3 | compass_sensor.xml |
| 压力传感器 | Contact Sensor | 1 | 20 | 1x2x1 | 1 | pressure_sensor.xml |
| 距离传感器 | Distance Sensor | 1.000000 | 20 | 1x2x1 | 2 | distance_sensor.xml |
| 鱼群探测仪 | Fishfinder | 10 | 500 | — | 3 | fish_finder.xml |
| GPS传感器 | GPS Sensor | 1.000000 | 20 | 1x1x2 | 3 | gps_sensor.xml |
| 气体量测量仪 | Gas Meter | 1 | 20 | 1x2x1 | 3 | gas_measure.xml |
| 湿度传感器 | Humidity Sensor | 1 | 400 | 1x2x1 | 1 | humidity_sensor.xml |
| 冲击传感器 | Impact Sensor | 1 | 20 | 1x1x1 | 1 | impact_sensor.xml |
| 激光距离传感器 | Laser Distance Sensor | 1 | 100 | — | 5 | laser_distance_sensor.xml |
| 激光点传感器 | Laser Point Sensor | 2 | 100 | 1x3x1 | 3 | laser_point_sensor.xml |
| 激光传感器(导弹) | Laser Sensor (Missile) | 5 | 800 | — | 5 | radar_advanced_missile_laser.xml |
| 线性速度传感器 | Linear Speed Sensor | 1.000000 | 20 | 1x1x1 | 1 | linear_speed_sensor.xml |
| 液位测量仪 | Liquid Meter | 1 | 20 | 1x2x1 | 3 | water_measure.xml |
| 话筒 | Microphone | 1 | 250 | 1x2x1 | 4 | mic.xml |
| 多功能物理传感器 | Physics Sensor | 1.000000 | 20 | 1x1x1 | 2 | physics_sensor.xml |
| 玩家传感器 | Player Sensor | 1 | 50 | 1x2x1 | 2 | player_sensor.xml |
| 雷达 | Radar | 10 | 1000 | 3x1x3 | 7 | radar.xml |
| 雷达(预警机) | Radar (AWACS) | 1100 | 10000 | 37x5x37 | 5 | radar_advanced_awacs.xml |
| 雷达(基础) | Radar (Basic) | 10 | 1000 | 3x1x3 | 5 | radar_advanced.xml |
| 雷达(抛物面天线) | Radar (Dish) | 550 | 5000 | 19x10x20 | 5 | radar_advanced_dish.xml |
| 雷达(抛物面天线) | Radar (Dish) | 150 | 3000 | 21x10x11 | 6 | radar_dish.xml |
| 雷达(巨) | Radar (Huge) | 1100 | 10000 | 37x5x37 | 4 | radar_huge.xml |
| 雷达(大) | Radar (Large) | 300 | 5000 | 7x16x7 | 9 | radar_large.xml |
| 雷达(导弹) | Radar (Missile) | 5 | 800 | 1x2x1 | 5 | radar_advanced_missile.xml |
| 雷达(密集阵) | Radar (Phalanx) | 55 | 2000 | 3x3x3 | 5 | radar_advanced_phalanx.xml |
| 雷达告警接收机 | Radar Detector | 1 | 1000 | 1x2x1 | 1 | radar_detector.xml |
| 辐射探测器 | Radiation Detector | 1 | 250 | 1x1x1 | 1 | radiation_detector.xml |
| 雨量传感器 | Rain Sensor | 1 | 180 | 1x2x1 | 1 | rain_sensor.xml |
| 声纳(大) | Sonar (Large) | 25 | 1000 | 7x2x7 | 7 | radar_sonar.xml |
| 声纳(大) | Sonar (Large) | 200 | 4000 | 7x5x7 | 4 | sonar_advanced_7.xml |
| 声纳(中) | Sonar (Medium) | 50 | 2000 | 5x3x5 | 4 | sonar_advanced_5.xml |
| 声纳(小) | Sonar (Small) | 10 | 1000 | 3x1x3 | 7 | radar_sonar_small.xml |
| 声纳(小) | Sonar (Small) | 10 | 1000 | — | 5 | sonar_advanced.xml |
| 温度探头 | Temperature Probe | 1 | 250 | 1x1x1 | 1 | temperature_probe.xml |
| 倾斜传感器 | Tilt Sensor | 1.000000 | 20 | 1x1x1 | 1 | rotation_sensor.xml |
| 应急信标定位器 | Transponder Locator | 1 | 20 | 1x2x1 | 3 | transponder_locator.xml |
| 风力传感器 | Wind Sensor | 1 | 200 | 1x2x1 | 2 | wind_sensor.xml |

## cat[8] D 装饰 （17 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 旗帜(大) | Flag (Large) | 3 | 100 | — | 0 | flag_large.xml |
| 旗帜(中) | Flag (Medium) | 2 | 75 | — | 0 | flag_medium.xml |
| 旗帜(小) | Flag (Small) | 1 | 25 | — | 0 | flag_small.xml |
| 大轮胎 | Large Tyre | 12 | 20 | 5x2x5 | 0 | tyre_large.xml |
| 栏杆段转角 | Railing Segment Corner | 2 | 30 | 1x4x1 | 0 | railing_segment_corner.xml |
| 栏杆段角对角线 | Railing Segment Corner Diagonal | 2 | 30 | 1x4x1 | 0 | railing_segment_corner_diag.xml |
| 栏杆段曲线 | Railing Segment Curve | 5 | 40 | 3x4x3 | 0 | railing_segment_curve.xml |
| 栏杆段端 | Railing Segment End | 2 | 30 | 1x4x1 | 0 | railing_segment_end.xml |
| 栏杆段端对角线 | Railing Segment End Diagonal | 2 | 30 | 1x4x1 | 0 | railing_segment_end_diag.xml |
| 栏杆段端部倾斜 | Railing Segment End Incline | 2 | 30 | 1x5x1 | 0 | railing_segment_angle_end.xml |
| 栏杆段延伸 | Railing Segment Extension | 2 | 30 | 1x4x1 | 0 | railing_segment_extension.xml |
| 斜栏杆段延伸 | Railing Segment Extension Diagonal | 2 | 30 | 1x4x1 | 0 | railing_segment_extension_diag.xml |
| 栏杆段延伸斜面 | Railing Segment Extension Incline | 2 | 30 | 1x4x1 | 0 | railing_extension_angle.xml |
| 栏杆段倾斜 | Railing Segment Incline | 2 | 30 | 1x5x1 | 0 | railing_segment_angle.xml |
| 栏杆段中间 | Railing Segment Middle | 2 | 30 | 1x4x1 | 0 | railing_segment_middle.xml |
| 栏杆段中对角线 | Railing Segment Middle Diagonal | 2 | 30 | 1x4x1 | 0 | railing_segment_middle_diag.xml |
| 小轮胎 | Small Tyre | 4 | 15 | 3x1x3 | 0 | tyre_small.xml |

## cat[9] F 流体 （55 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 气体过滤端口 | Air Filter | 1 | 50 | 1x1x1 | 1 | air_filter.xml |
| 气体接口 | Air Ram | 1 | 50 | 1x1x1 | 1 | modular_engine_air_ram.xml |
| 流体力学进气口 1x1 | Air Scoop Intake 1x1 | 1 | 30 | 1x1x1 | 1 | scoop_intake_2.xml |
| 气体热交换器 2x2 | Air-Air Heat Exchanger 2x2 | 4 | 30 | — | 6 | heat_exchanger_2_2.xml |
| 气体热交换器 2x5 | Air-Air Heat Exchanger 2x5 | 10 | 70 | — | 6 | heat_exchanger_5_5.xml |
| 气体热交换器 3x9 | Air-Air Heat Exchanger 3x9 | 27 | 100 | 3x9x9 | 6 | heat_exchanger_9_9.xml |
| 气-液热交换器 1x2 | Air-Liquid Heat Exchanger 1x2 | 2 | 15 | — | 6 | air_exchanger.xml |
| 气-液热交换器 5x2 | Air-Liquid Heat Exchanger 5x2 | 7 | 30 | — | 6 | air_exchanger_5_2.xml |
| 气-液热交换器 5x3 | Air-Liquid Heat Exchanger 5x3 | 45 | 50 | 3x3x5 | 6 | air_exchanger_5_3.xml |
| 气-液热交换器 9x3 | Air-Liquid Heat Exchanger 9x3 | 81 | 80 | 3x3x9 | 6 | air_exchanger_9_3.xml |
| 气-液热交换器 9x5 | Air-Liquid Heat Exchanger 9x5 | 225 | 150 | 5x5x9 | 6 | air_exchanger_9_5.xml |
| 催化器 | Catalytic Converter | 1 | 100 | 1x1x1 | 2 | catalytic_converter.xml |
| 离心分离机 | Centrifugal Separator | 80 | 480 | 5x9x5 | 4 | separator.xml |
| 制冷器 | Cryo Cooler | 4 | 30 | — | 8 | cryo_cooler.xml |
| 海水淡化器 | Desalinator | 5 | 400 | 1x5x1 | 2 | desalinator.xml |
| 排液(气)口 | Fluid Exhaust | 1 | 100 | 1x2x1 | 1 | fluid_exhaust.xml |
| 流体过滤器 | Fluid Filter | 5 | 400 | — | 3 | fluid_filter.xml |
| 流体过滤器 | Fluid Filter | 5 | 400 | — | 2 | fluid_filter_v2.xml |
| 单向阀 | Fluid Flow Valve | 4 | 100 | 1x2x1 | 3 | fluid_valve_flow.xml |
| 流体散热器 | Fluid Heat Radiator | 10 | 200 | 3x3x1 | 2 | fluid_radiator.xml |
| 液体风冷散热器 3x3 | Fluid Heat Radiator 3x3 (Electric) | 10 | 400 | 3x1x3 | 5 | fluid_radiator_electric.xml |
| 液体风冷散热器 5x5 | Fluid Heat Radiator 5x5 (Electric) | 25 | 700 | 5x1x5 | 5 | fluid_radiator_electric_5.xml |
| 流体散热器 | Fluid Heat Sink | 18 | 300 | 5x3x1 | 2 | fluid_heat_sink.xml |
| 进液口 | Fluid Intake | 1 | 100 | 3x2x1 | 1 | fluid_intake.xml |
| 喷水推进器 | Fluid Jet | 10 | 3000 | — | 6 | water_jet.xml |
| 流体开关阀 | Fluid On/Off Valve | 4 | 100 | 2x2x1 | 5 | fluid_valve_on_off.xml |
| 流体开关阀(手动) | Fluid On/Off Valve (Manual) | 1 | 100 | — | 3 | fluid_valve_on_off_manual.xml |
| 流体接口 | Fluid Port | 1 | 50 | 1x2x1 | 1 | water_inlet.xml |
| 流体接口 | Fluid Port | 1 | 50 | 1x2x1 | 1 | water_outlet.xml |
| 流体末端接口 | Fluid Port End | 1 | 50 | — | 1 | fluid_port_end.xml |
| 液压传感器 | Fluid Pressure Sensor | 4 | 100 | 1x2x1 | 2 | fluid_pressure.xml |
| 电动流体泵(小) | Fluid Pump | 4 | 100 | 3x1x1 | 5 | water_pump.xml |
| 流体泵(手动) | Fluid Pump (Manual) | 4 | 100 | — | 3 | water_pump_manual.xml |
| 流体进出端口 | Fluid Slot Port | 12 | 100 | 3x2x4 | 1 | water_suction_duct.xml |
| 液体生成器 | Fluid Spawner | 1 | 20 | 1x2x1 | 0 | water_spawner.xml |
| 油箱(大) | Fluid Tank Large | 22 | 20 | 3x3x5 | 4 | fluid_tank_large.xml |
| 油箱(中) | Fluid Tank Medium | 6 | 20 | 2x2x3 | 4 | fluid_tank_medium.xml |
| 油箱(小) | Fluid Tank Small | 1 | 20 | 1x1x2 | 4 | fluid_tank_small.xml |
| 流体变量阀 | Fluid Variable Valve | 4 | 100 | 2x2x1 | 5 | fluid_valve_variable.xml |
| 分馏出口 | Fractional Distillation Port | 36 | 80 | 3x5x3 | 1 | distillation_tray.xml |
| 气阀 | Gas Relief Valve | 2 | 150 | — | 3 | relief_valve_gas.xml |
| 气罐(巨) | Gas Tank (Huge) | 22 | 20 | 5x9x5 | 3 | fluid_tank_compressed_gas_5_9.xml |
| 气罐(大) | Gas Tank (Large) | 12 | 20 | 3x7x3 | 3 | fluid_tank_compressed_gas_3_7.xml |
| 气罐(中) | Gas Tank (Medium) | 5 | 20 | — | 3 | fluid_tank_compressed_gas_1_7.xml |
| 气罐(小) | Gas Tank (Small) | 2 | 20 | — | 3 | fluid_tank_compressed_gas_1_3.xml |
| 水电解槽 | Hydrogen Electrolyser | 16 | 575 | — | 4 | electrolyser.xml |
| 氢燃料电池 | Hydrogen Fuel Cell | 50 | 800 | 3x5x3 | 4 | hydrogen_fuel_cell.xml |
| 机械流体泵 | Impeller Pump | 9 | 50 | 3x1x3 | 4 | turbocharger.xml |
| 机械流体泵(小) | Impeller Pump (Small) | 1 | 40 | 1x1x1 | 4 | turbocharger_small.xml |
| 电动流体泵(大) | Large Fluid Pump | 10 | 200 | 2x2x2 | 5 | water_pump_large.xml |
| 液阀 | Liquid Relief Valve | 2 | 150 | — | 3 | relief_valve_liquid.xml |
| 液体热交换器 2x2 | Liquid-Liquid Heat Exchanger 2x2 | 4 | 30 | 1x2x2 | 6 | intercooler.xml |
| 液体热交换器 5x5 | Liquid-Liquid Heat Exchanger 5x5 | 16 | 50 | — | 6 | intercooler_large.xml |
| 泥浆稀释器 | Slurry Filter | 140 | 320 | 5x15x9 | 4 | slurry_filter.xml |
| 蒸汽汽笛 | Steam Whistle | 4 | 50 | 1x4x1 | 2 | steam_whistle.xml |

## cat[10] E 电力 （11 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 电池(大) | Electric Battery Large | 800 | 10000 | 7x5x5 | 2 | battery_large.xml |
| 电池(中) | Electric Battery Medium | 60 | 1200 | 3x2x2 | 2 | battery_medium.xml |
| 电池(小) | Electric Battery Small | 10 | 150 | 2x1x1 | 2 | battery_small.xml |
| 充电器 | Electric Charger | 1 | 100 | 1x1x2 | 2 | electric_diode.xml |
| 断路器 | Electric Circuit Breaker | 1 | 100 | 1x2x1 | 2 | electric_curcuit_breaker.xml |
| 电力继电器 | Electric Relay | 1 | 100 | 3x1x1 | 3 | electric_relay.xml |
| 发电机(大) | Large Generator | 400 | 12000 | 5x5x5 | 3 | generator_large.xml |
| 太阳能电池(大) | Large Solar Cell | 40 | 8000 | — | 1 | solar_large.xml |
| 发电机(中) | Medium Generator | 100 | 2000 | 3x3x3 | 3 | generator_medium.xml |
| 发电机(小) | Small Generator | 5 | 600 | 1x1x1 | 3 | generator_small.xml |
| 太阳能电池 | Solar Cell | 2 | 400 | — | 1 | solar.xml |

## cat[11] J 喷气引擎 （14 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 喷气燃烧室 | Jet Combustion Chamber | 20 | 200 | 3x3x3 | 5 | jet_engine_combustion_chamber.xml |
| 喷气引擎压气机 | Jet Compressor | 20 | 200 | 3x5x3 | 5 | jet_engine_compressor.xml |
| 喷气引擎气道(L型) | Jet Duct Angle | 5 | 50 | 3x3x3 | 0 | jet_engine_duct_angle.xml |
| 喷气引擎气道(X型) | Jet Duct Cross | 5 | 50 | 3x3x3 | 0 | jet_engine_duct_cross.xml |
| 喷气引擎气道(斜面型) | Jet Duct Diagonal | 5 | 50 | 3x3x4 | 0 | jet_engine_duct_diagonal.xml |
| 喷气引擎气道(直型) | Jet Duct Straight | 3 | 30 | 3x1x3 | 0 | jet_engine_duct_straight.xml |
| 喷气引擎气道(T型) | Jet Duct T | 5 | 50 | 3x3x3 | 0 | jet_engine_duct_t.xml |
| 喷气口(基础型) | Jet Exhaust | 5 | 500 | 3x2x3 | 3 | jet_engine_exhaust_basic.xml |
| 喷气口(加力型) | Jet Exhaust Afterburner | 10 | 750 | 3x5x3 | 5 | jet_engine_exhaust_afterburner.xml |
| 喷气口(旋转式) | Jet Exhaust Rotating | 10 | 800 | 3x4x3 | 5 | jet_engine_exhaust_rotating.xml |
| 喷气涡轮(中) | Jet Turbine Medium | 20 | 200 | 3x3x3 | 5 | jet_engine_turbine_medium.xml |
| 喷气涡轮(小) | Jet Turbine Small | 15 | 150 | 3x2x3 | 4 | jet_engine_turbine_small.xml |
| 喷气式进气道(大) | Large Jet Intake | 10 | 500 | 7x2x7 | 2 | jet_engine_intake_large.xml |
| 喷气式进气道(小) | Small Jet Intake | 5 | 250 | 3x1x3 | 2 | jet_engine_intake_small.xml |

## cat[12] W 武器/弹药 （79 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 大型榴弹炮 | Artillery Cannon | 200 | 100 | 3x22x3 | 4 | gun_xl.xml |
| 大型榴弹炮炮管加长件 | Artillery Cannon Barrel Extension | 80 | 50 | 3x4x3 | 0 | gun_xl_barrel.xml |
| 大型榴弹炮炮管加长件 | Artillery Cannon Barrel Extension | 80 | 50 | 3x4x3 | 0 | gun_xl_barrel_1.xml |
| 大型榴弹炮炮管加长件 | Artillery Cannon Barrel Extension | 80 | 50 | 3x4x3 | 0 | gun_xl_barrel_2.xml |
| 大型榴弹炮炮管加长件 | Artillery Cannon Barrel Extension | 80 | 50 | 3x4x3 | 0 | gun_xl_barrel_3.xml |
| 大型榴弹炮弹药带(连接器) | Artillery Cannon Belt (Connector) | 4 | 100 | 1x1x4 | 2 | gun_belt_receiver_xl.xml |
| 大型榴弹炮弹药带(内角) | Artillery Cannon Belt (Corner Inner) | 15 | 100 | 1x4x4 | 1 | gun_belt_corner_flat_xl.xml |
| 大型榴弹炮(外角) | Artillery Cannon Belt (Corner Outer) | 15 | 100 | 1x4x4 | 1 | gun_belt_corner_flat_reverse_xl.xml |
| 大型榴弹炮弹药带(拐角) | Artillery Cannon Belt (Corner) | 4 | 100 | 1x1x4 | 1 | gun_belt_corner_xl.xml |
| 大型榴弹炮弹药带(供弹机) | Artillery Cannon Belt (Feeder) | 5 | 100 | 1x1x5 | 3 | gun_belt_loader_xl.xml |
| 大型榴弹炮弹链 | Artillery Cannon Belt (Flexible) | 4 | 100 | — | 1 | gun_belt_flex_xl.xml |
| 大型榴弹炮弹药带(交叉) | Artillery Cannon Belt (Junction) | 4 | 100 | 1x1x4 | 2 | gun_belt_junction_xl.xml |
| 大型榴弹炮弹药带(直) | Artillery Cannon Belt (Straight) | 4 | 100 | 1x1x4 | 1 | gun_belt_straight_xl.xml |
| 大型榴弹炮制退器 | Artillery Cannon Muzzle Brake | 80 | 50 | 3x5x3 | 0 | gun_xl_muzzle.xml |
| 大型榴弹炮制退器 | Artillery Cannon Muzzle Brake | 80 | 50 | 3x5x3 | 0 | gun_xl_muzzle_1.xml |
| 大型榴弹炮制退器 | Artillery Cannon Muzzle Brake | 80 | 50 | 3x5x3 | 0 | gun_xl_muzzle_2.xml |
| 自动火炮弹鼓(大) | Autocannon Ammo Drum (Large) | 40 | 100 | 4x3x4 | 1 | gun_drum_large.xml |
| 自动火炮弹鼓(中) | Autocannon Ammo Drum (Medium) | 20 | 100 | 3x3x3 | 1 | gun_drum_medium.xml |
| 自动火炮弹鼓(小) | Autocannon Ammo Drum (Small) | 10 | 100 | 2x3x2 | 1 | gun_drum_small.xml |
| 自动火炮弹药带(连接器) | Autocannon Belt (Connector) | 3 | 100 | 1x1x3 | 2 | gun_belt_receiver.xml |
| 自动火炮弹药带(平角) | Autocannon Belt (Corner Flat) | 9 | 100 | 1x3x3 | 1 | gun_belt_corner_flat.xml |
| 自动火炮弹药带(拐角) | Autocannon Belt (Corner) | 3 | 100 | 1x1x3 | 1 | gun_belt_corner.xml |
| 自动火炮弹药带(进料器) | Autocannon Belt (Feeder) | 4 | 100 | 1x1x4 | 3 | gun_belt_loader.xml |
| 自动炮弹链 | Autocannon Belt (Flexible) | 3 | 100 | — | 1 | gun_belt_flex.xml |
| 自动火炮弹药带(交叉) | Autocannon Belt (Junction) | 3 | 100 | 1x1x3 | 2 | gun_belt_junction.xml |
| 自动火炮弹药带(直) | Autocannon Belt (Straight) | 3 | 100 | 1x1x3 | 1 | gun_belt_straight.xml |
| 坦克主炮 | Battle Cannon | 100 | 100 | — | 4 | gun_l.xml |
| 坦克主炮炮管加长件 | Battle Cannon Barrel Extension | 40 | 50 | 1x3x1 | 0 | gun_l_barrel.xml |
| 坦克主炮炮管加长件 | Battle Cannon Barrel Extension | 40 | 50 | 3x3x3 | 0 | gun_l_barrel_1.xml |
| 坦克主炮炮管加长件 | Battle Cannon Barrel Extension | 40 | 50 | 1x3x2 | 0 | gun_l_barrel_2.xml |
| 坦克主炮炮管加长件 | Battle Cannon Barrel Extension | 40 | 50 | 3x3x3 | 0 | gun_l_barrel_3.xml |
| 坦克主炮弹药带(连接器) | Battle Cannon Belt (Connector) | 3 | 100 | 1x1x3 | 2 | gun_belt_receiver_l.xml |
| 坦克主炮弹药带(内角) | Battle Cannon Belt (Corner Inner) | 9 | 100 | 1x3x3 | 1 | gun_belt_corner_flat_l.xml |
| 坦克主炮弹药带(外角) | Battle Cannon Belt (Corner Outer) | 9 | 100 | 1x3x3 | 1 | gun_belt_corner_flat_reverse_l.xml |
| 坦克主炮弹药带(拐角) | Battle Cannon Belt (Corner) | 3 | 100 | 1x1x3 | 1 | gun_belt_corner_l.xml |
| 坦克主炮弹药带(供弹机) | Battle Cannon Belt (Feeder) | 4 | 100 | 1x1x4 | 3 | gun_belt_loader_l.xml |
| 坦克炮弹链 | Battle Cannon Belt (Flexible) | 3 | 100 | — | 1 | gun_belt_flex_l.xml |
| 坦克主炮弹药带(交叉) | Battle Cannon Belt (Junction) | 3 | 100 | 1x1x3 | 2 | gun_belt_junction_l.xml |
| 坦克主炮弹药带(直) | Battle Cannon Belt (Straight) | 3 | 100 | 1x1x3 | 1 | gun_belt_straight_l.xml |
| 坦克主炮制退器 | Battle Cannon Muzzle Brake | 40 | 50 | 1x4x1 | 0 | gun_l_muzzle.xml |
| 坦克主炮制退器 | Battle Cannon Muzzle Brake | 40 | 50 | 3x4x1 | 0 | gun_l_muzzle_1.xml |
| 坦克主炮制退器 | Battle Cannon Muzzle Brake | 40 | 50 | 3x4x3 | 0 | gun_l_muzzle_2.xml |
| 贝莎巨炮 | Bertha Cannon | 500 | 100 | 5x30x5 | 4 | gun_xxl.xml |
| 贝莎巨炮炮管加长件 | Bertha Cannon Barrel Extension | 200 | 50 | 3x4x3 | 0 | gun_xxl_barrel.xml |
| 贝莎巨炮弹药带(连接器) | Bertha Cannon Belt (Connector) | 63 | 100 | 3x3x7 | 2 | gun_belt_receiver_xxl.xml |
| 贝莎巨炮弹药带(内角) | Bertha Cannon Belt (Corner Inner) | 138 | 100 | 3x7x7 | 1 | gun_belt_corner_flat_xxl.xml |
| 贝莎巨炮弹药带(外角) | Bertha Cannon Belt (Corner Outer) | 138 | 100 | 3x7x7 | 1 | gun_belt_corner_flat_reverse_xxl.xml |
| 贝莎巨炮弹药带(拐角) | Bertha Cannon Belt (Corner) | 63 | 100 | 3x3x7 | 1 | gun_belt_corner_xxl.xml |
| 贝莎巨炮弹药带(供弹机) | Bertha Cannon Belt (Feeder) | 90 | 100 | 3x3x10 | 3 | gun_belt_loader_xxl.xml |
| 贝莎巨炮弹链 | Bertha Cannon Belt (Flexible) | 63 | 100 | 3x4x7 | 1 | gun_belt_flex_xxl.xml |
| 贝莎巨炮弹药带(交叉) | Bertha Cannon Belt (Junction) | 63 | 100 | 3x3x7 | 2 | gun_belt_junction_xxl.xml |
| 贝莎巨炮弹药带(直) | Bertha Cannon Belt (Straight) | 63 | 100 | 3x3x7 | 1 | gun_belt_straight_xxl.xml |
| 重型自动火炮 | Heavy Autocannon | 50 | 100 | 1x10x1 | 4 | gun_m.xml |
| 重型自动火炮炮管加长件 | Heavy Autocannon Barrel Extension | 20 | 50 | 1x3x1 | 0 | gun_m_barrel.xml |
| 重型自动火炮炮管加长件 | Heavy Autocannon Barrel Extension | 20 | 50 | 1x3x1 | 0 | gun_m_barrel_1.xml |
| 重型自动火炮炮管加长件 | Heavy Autocannon Barrel Extension | 20 | 50 | 1x3x2 | 0 | gun_m_barrel_2.xml |
| 重型自动火炮炮管加长件 | Heavy Autocannon Barrel Extension | 20 | 50 | 1x3x2 | 0 | gun_m_barrel_3.xml |
| 重型自动火炮制退器 | Heavy Autocannon Muzzle Brake | 20 | 50 | 1x4x1 | 0 | gun_m_muzzle.xml |
| 重型自动火炮制退器 | Heavy Autocannon Muzzle Brake | 20 | 50 | 1x4x1 | 0 | gun_m_muzzle_1.xml |
| 重型自动火炮制退器 | Heavy Autocannon Muzzle Brake | 20 | 50 | 1x4x1 | 0 | gun_m_muzzle_2.xml |
| 轻型自动火炮 | Light Autocannon | 25 | 100 | 2x6x1 | 3 | gun_s.xml |
| 轻型自动火炮炮管加长件 | Light Autocannon Barrel Extension | 10 | 50 | 1x3x1 | 0 | gun_s_barrel.xml |
| 轻型自动火炮制退器 | Light Autocannon Muzzle Brake | 3 | 50 | 1x2x1 | 0 | gun_s_muzzle.xml |
| 轻型自动火炮制退器 | Light Autocannon Muzzle Brake | 3 | 50 | 1x2x1 | 0 | gun_s_muzzle_1.xml |
| 轻型自动火炮制退器 | Light Autocannon Muzzle Brake | 3 | 50 | 1x2x1 | 0 | gun_s_muzzle_2.xml |
| 轻型自动火炮制退器 | Light Autocannon Muzzle Brake | 3 | 50 | 1x2x1 | 0 | gun_s_muzzle_3.xml |
| 机枪 | Machine Gun | 10 | 50 | 1x4x1 | 2 | gun_xs.xml |
| 机枪弹药箱 | Machine Gun Ammo Box | 5 | 20 | 1x1x1 | 1 | gun_drum_xsmall.xml |
| 机枪弹药箱(大) | Machine Gun Ammo Box (Large) | 20 | 30 | — | 1 | gun_drum_xsmall_2.xml |
| 火箭弹发射器 | Rocket Launcher | 50 | 100 | 1x8x1 | 3 | gun_rocket_launcher.xml |
| 转管自动火炮 | Rotary Autocannon | 400 | 100 | 4x13x2 | 3 | gun_v.xml |
| 转管自动火炮炮管加长件 | Rotary Autocannon Barrel Extension | 40 | 50 | 1x4x1 | 0 | gun_v_barrel.xml |
| 弹头(EMP) | Warhead (EMP) | 500 | 200 | 5x13x5 | 1 | warhead_emp.xml |
| 弹头(大) | Warhead (Large) | 400 | 100 | 5x9x5 | 1 | warhead_large.xml |
| 弹头(中) | Warhead (Medium) | 80 | 50 | 3x5x3 | 1 | warhead_medium.xml |
| 弹头(小) | Warhead (Small) | 15 | 25 | 1x2x1 | 1 | warhead_small.xml |
| 弹头(大) | Warhead Body (Large) | 400 | 100 | 5x9x5 | 1 | warhead_body_large.xml |
| 弹头(中) | Warhead Body (Medium) | 80 | 50 | 3x5x3 | 1 | warhead_body_medium.xml |
| 弹头(小) | Warhead Body (Small) | 15 | 25 | 1x2x1 | 1 | warhead_body_small.xml |

## cat[13] M 模块化引擎 （30 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 模块化发动机气体歧管 | Modular Engine Air Manifold | 1 | 10 | 1x1x1 | 2 | modular_engine_air_manifold.xml |
| 模块化引擎发电机 | Modular Engine Alternator | 1 | 30 | 1x1x1 | 2 | modular_engine_alternator.xml |
| 模块化发动机离合器(1x1) | Modular Engine Clutch 1x1 | 1 | 15 | 1x1x1 | 2 | modular_engine_clutch.xml |
| 模块化发动机离合器(3x3) | Modular Engine Clutch 3x3 | 9 | 25 | 3x1x3 | 2 | modular_engine_clutch_3x3.xml |
| 模块化发动机离合器(5x5) | Modular Engine Clutch 5x5 | 25 | 50 | 5x1x5 | 2 | modular_engine_clutch_5x5.xml |
| 模块化发动机冷却液歧管 | Modular Engine Coolant Manifold | 1 | 10 | 1x1x1 | 2 | modular_engine_coolant_manifold.xml |
| 模块化发动机曲轴(1x1) | Modular Engine Crankshaft 1x1 | 1 | 50 | 1x1x1 | 1 | modular_engine_crankshaft.xml |
| 模块化发动机曲轴(3x1) | Modular Engine Crankshaft 3x1 | 9 | 50 | 3x1x3 | 1 | modular_engine_crankshaft_3x1.xml |
| 模块化发动机曲轴(3x3) | Modular Engine Crankshaft 3x3 | 27 | 150 | 3x3x3 | 1 | modular_engine_crankshaft_3x3.xml |
| 模块化发动机曲轴(5x5) | Modular Engine Crankshaft 5x5 | 100 | 350 | 5x5x5 | 1 | modular_engine_crankshaft_5x5.xml |
| 模块化发动机曲轴变矩器(3至1) | Modular Engine Crankshaft Converter 3 to 1 | 9 | 75 | 3x1x3 | 1 | modular_engine_crankshaft_converter_3x3.xml |
| 模块化发动机曲轴变矩器(5至3) | Modular Engine Crankshaft Converter 5 to 3 | 27 | 275 | 5x1x5 | 1 | modular_engine_crankshaft_converter_5x5.xml |
| 模块化发动机气缸(1x1) | Modular Engine Cylinder 1x1 | 1 | 50 | 1x1x1 | 1 | modular_engine_cylinder_straight.xml |
| 模块化发动机气缸(3x3) | Modular Engine Cylinder 3x3 | 27 | 100 | 3x3x3 | 1 | modular_engine_piston_3x3.xml |
| 模块化发动机气缸(5x5) | Modular Engine Cylinder 5x5 | 100 | 150 | 5x5x5 | 1 | modular_engine_piston_5x5.xml |
| 模块化发动机传动带1x1 | Modular Engine Drive Belt 1x1 | 1 | 30 | 1x1x1 | 0 | modular_engine_drive_belt.xml |
| 模块化发动机传动带3x3 | Modular Engine Drive Belt 3x3 | 9 | 80 | 3x1x3 | 0 | modular_engine_power_manifold_3x3.xml |
| 模块化发动机传动带 5x5 | Modular Engine Drive Belt 5x5 | 27 | 160 | 5x1x5 | 0 | modular_engine_power_manifold_5x5.xml |
| 模块化发动机排气歧管(拐角) | Modular Engine Exhaust Manifold (Corner) | 1 | 10 | 1x1x1 | 1 | modular_engine_exhaust_manifold_corner.xml |
| 模块化发动机排气歧管(直) | Modular Engine Exhaust Manifold (Straight) | 1 | 10 | 1x1x1 | 1 | modular_engine_exhaust_manifold_straight.xml |
| 模块化发动机流体泵 | Modular Engine Fluid Pump | 1 | 50 | 1x1x1 | 3 | modular_engine_fluid_pump.xml |
| 模块化发动机飞轮1x1 | Modular Engine Flywheel 1x1 | 100 | 450 | 3x1x3 | 1 | modular_engine_flywheel.xml |
| 模块化发动机飞轮3x3 | Modular Engine Flywheel 3x3 | 200 | 650 | 5x1x5 | 1 | modular_engine_flywheel_3x3.xml |
| 模块化发动机飞轮5x5 | Modular Engine Flywheel 5x5 | 300 | 850 | 7x1x7 | 1 | modular_engine_flywheel_5x5.xml |
| 模块化发动机燃油歧管 | Modular Engine Fuel Manifold | 1 | 10 | 1x1x1 | 2 | modular_engine_intake_manifold.xml |
| 模块化发动机歧管(拐角) | Modular Engine Manifold (Corner) | 1 | 10 | 1x1x1 | 0 | modular_engine_manifold_corner.xml |
| 模块化发动机歧管(直) | Modular Engine Manifold (Straight) | 1 | 10 | 1x1x1 | 0 | modular_engine_manifold_straight.xml |
| 模块化发动机歧管(T) | Modular Engine Manifold (T) | 1 | 10 | 1x1x1 | 0 | modular_engine_manifold_t.xml |
| 模块化发动机起动器 | Modular Engine Starter | 1 | 30 | 1x1x1 | 2 | modular_engine_starter.xml |
| 模块化发动机温度传感器 | Modular Engine Temperature Sensor | 1 | 50 | 1x1x1 | 1 | modular_engine_sensor_temperature.xml |

## cat[14] I 工业设备 （35 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 输送管 | Duct | 12 | 50 | 3x3x3 | 1 | steam_coal_duct.xml |
| 输送管(大) | Duct Large | 112 | 150 | 5x5x9 | 1 | steam_coal_duct_l.xml |
| 输送管(中) | Duct Medium | 62 | 100 | 5x5x5 | 1 | steam_coal_duct_m.xml |
| 电热炉 | Electric Furnace | 220 | 900 | 3x5x3 | 5 | furnace_electric.xml |
| 煤炉 | Firebox | 100 | 100 | 3x3x5 | 7 | steam_coal_firebox.xml |
| 煤炉(大) | Firebox Large | 400 | 200 | 5x5x7 | 7 | steam_coal_firebox_l.xml |
| 柔性输送管 | Flexible Duct | 20 | 50 | — | 1 | steam_coal_flex.xml |
| 输送管漏斗 | Funnel Duct | 20 | 50 | 3x2x3 | 1 | steam_coal_funnel.xml |
| 输送管料斗 | Hopper | 12 | 50 | 3x3x3 | 1 | steam_coal_hopper.xml |
| 输送管料斗(大) | Hopper Large | 112 | 150 | 5x5x9 | 1 | steam_coal_hopper_l.xml |
| 输送管料斗(中) | Hopper Medium | 62 | 100 | 5x5x5 | 1 | steam_coal_hopper_m.xml |
| 工业柴油炉 | Industrial Diesel Furnace | 350 | 750 | 5x5x7 | 8 | furnace_industrial.xml |
| 龙虾陷阱 | Lobster Pot | 45 | 150 | 5x3x5 | 2 | lobster_pot.xml |
| 矿产转运器 | Mineral Converter | 80 | 250000 | 3x3x3 | 2 | mineral_converter.xml |
| 渔网锚点 | Net Anchor | 3 | 15 | — | 5 | rope_hook_net.xml |
| 核控制棒 | Nuclear Control Rod | 100 | 250 | 1x17x1 | 2 | steam_nuclear_control_rod.xml |
| 核燃料总成 | Nuclear Fuel Assembly | 80 | 500 | 1x12x1 | 2 | steam_nuclear_fuel_assembly.xml |
| 核燃料棒 | Nuclear Fuel Rod | 80 | 2500 | 1x9x1 | 0 | steam_nuclear_fuel_rod.xml |
| 钻杆夹具 | Oil Rig Drill Clamp | 30 | 100 | — | 3 | oil_rig_drill_grabber.xml |
| 钻杆夹具(端头) | Oil Rig Drill Clamp (End) | 5 | 500 | — | 2 | oil_rig_drill_grabber_end.xml |
| 钻杆连接器 | Oil Rig Drill Connector | 50 | 100 | — | 5 | oil_rig_drill_connector.xml |
| 泥浆喷嘴 | Oil Rig Drill Swivel | 30 | 1000 | 3x5x3 | 4 | oil_rig_drill_swivel.xml |
| 抽油泵 | Oil Rig Pumpjack | 200 | 1000 | 3x11x3 | 1 | oil_rig_pumpjack.xml |
| 抽油泵B | Oil Rig Pumpjack B | 500 | 0 | — | 0 | oil_rig_pumpjack_b.xml |
| 钻杆存储器 | Oil Rig Rod Storage | 10 | 50 | — | 1 | oil_rig_drill_storage.xml |
| 钻机旋转台 | Oil Rig Rotary Table | 500 | 1000 | 7x3x7 | 3 | oil_rig_drill_driver.xml |
| 井口装置 | Oil Rig Well Head | 1000 | 5000 | 9x25x9 | 4 | oil_rig_well_head.xml |
| 蒸汽锅炉 | Steam Boiler | 500 | 250 | 5x5x7 | 6 | steam_boiler.xml |
| 蒸汽冷凝器 | Steam Condenser | 250 | 250 | 3x5x5 | 6 | steam_condenser.xml |
| 蒸汽活塞(大) | Steam Piston (Large) | 300 | 2400 | 5x15x5 | 8 | steam_piston_5x5.xml |
| 蒸汽活塞(中) | Steam Piston (Medium) | 120 | 600 | — | 8 | steam_piston_3x3.xml |
| 蒸汽活塞(小) | Steam Piston (Small) | 12 | 90 | — | 8 | steam_piston.xml |
| 蒸汽轮机 | Steam Turbine | 500 | 250 | 5x9x5 | 4 | steam_turbine.xml |
| 输送管吸口 | Vacuum Duct | 20 | 50 | — | 2 | steam_coal_vacuum.xml |
| 矿石脱水机 | Water Extractor | 20 | 100 | 3x3x3 | 3 | water_extractor.xml |

## cat[15] W 窗户 （41 项）

| 中文 | 游戏内英文名 | mass | $ | 尺寸(vox) | 节点 | 文件 |
|---|---|---|---|---|---|---|
| 舷窗(大) | Porthole | 8.000000 | 50 | 1x5x3 | 0 | window_porthole.xml |
| 舷窗(小) | Porthole Small | 6 | 30 | 1x3x3 | 0 | window_port.xml |
| 窗(1x1) | Window 1x1 | 1 | 5 | 1x1x1 | 0 | window_1x1.xml |
| 窗(2x1) | Window 1x2 | 2 | 10 | 1x2x1 | 0 | window_2x1.xml |
| 窗(3x1) | Window 1x3 | 2.000000 | 15 | 1x3x1 | 0 | window_narrow.xml |
| 窗(2x2) | Window 2x2 | 3 | 20 | 1x2x2 | 0 | window_2x2.xml |
| 窗(3x2) | Window 2x3 | 4 | 25 | 1x3x2 | 0 | window_3x2.xml |
| 窗(3x3) | Window 3x3 | 4.000000 | 45 | 1x3x3 | 0 | window_large.xml |
| 窗(1x1 楔形) | Window Angle 1x1x1 | 1 | 5 | 1x1x1 | 0 | window_1x1_wedge.xml |
| 窗角1x2x2 | Window Angle 1x2x2 | 2 | 20 | 2x2x1 | 0 | window_angle_m_1x2x2.xml |
| 窗(3x1 斜窗) | Window Angle 1x3x3 | 2.000000 | 45 | 3x3x1 | 0 | window_narrow_angle.xml |
| 窗角1x4x4 | Window Angle 1x4x4 | 3 | 80 | 4x4x1 | 0 | window_angle_xl_1x4x4.xml |
| 窗角2x1x1 | Window Angle 2x1x1 | 1 | 10 | 1x1x2 | 0 | window_angle_s_1x2.xml |
| 窗角2x2x2 | Window Angle 2x2x2 | 3 | 30 | — | 0 | window_angle_m_2x2x2.xml |
| 窗角2x3x3 | Window Angle 2x3x3 | 4 | 10 | — | 0 | window_angle_l_2x3x3.xml |
| 窗角2x4x4 | Window Angle 2x4x4 | 5 | 160 | 4x4x2 | 0 | window_angle_xl_2x4x4.xml |
| 窗(1x3 斜窗) | Window Angle 3x1x1 | 2.000000 | 15 | 1x1x3 | 0 | window_small_angle.xml |
| 窗角3x2x2 | Window Angle 3x2x2 | 4 | 60 | — | 0 | window_angle_m_3x2x2.xml |
| 窗(3x3 斜窗) | Window Angle 3x3x3 | 5 | 135 | 3x3x3 | 0 | window_large_angle.xml |
| 窗角3x4x4 | Window Angle 3x4x4 | 6 | 240 | 4x4x3 | 0 | window_angle_xl_3x4x4.xml |
| 窗角2x3 | Window Corner 2x3 | 2 | 30 | 1x3x2 | 0 | window_corner_small.xml |
| 角窗(斜面-平面) | Window Corner 3x4 | 4.000000 | 60 | 1x4x3 | 0 | window_corner.xml |
| 窗角满1x1 | Window Corner Full 1x1 | 1 | 5 | 1x1x1 | 0 | window_corner_full_1x1.xml |
| 窗角满2x2 | Window Corner Full 2x2 | 2 | 20 | 1x2x2 | 0 | window_corner_full_small.xml |
| 窗角满3x3 | Window Corner Full 3x3 | 4 | 45 | 1x3x3 | 0 | window_corner_full_medium.xml |
| 窗角满4x4 | Window Corner Full 4x4 | 5 | 80 | 1x4x4 | 0 | window_corner_full_large.xml |
| 菱形窗1x1x2 | Window Diamond 1x1x2 | 1 | 5 | 2x1x1 | 0 | window_diamond_s_1x1.xml |
| 菱形窗1x2x3 | Window Diamond 1x2x3 | 2 | 15 | 3x2x1 | 0 | window_diamond_m_1x2x3.xml |
| 菱形窗1x3x4 | Window Diamond 1x3x4 | 2 | 30 | 4x3x1 | 0 | window_diamond_l_1x3x4.xml |
| 菱形窗1x4x5 | Window Diamond 1x4x5 | 3 | 50 | — | 0 | window_diamond_xl_1x4x5.xml |
| 菱形窗2x2x3 | Window Diamond 2x2x3 | 3 | 30 | 4x2x2 | 0 | window_diamond_m_2x2x3.xml |
| 菱形窗2x3x4 | Window Diamond 2x3x4 | 4 | 60 | 5x3x2 | 0 | window_diamond_l_2x3x4.xml |
| 菱形窗2x4x5 | Window Diamond 2x4x5 | 5 | 100 | 6x4x2 | 0 | window_diamond_xl_2x4x5.xml |
| 菱形窗3x2x3 | Window Diamond 3x2x3 | 4 | 45 | 5x2x3 | 0 | window_diamond_m_3x2x3.xml |
| 菱形窗3x3x4 | Window Diamond 3x3x4 | 5 | 90 | 6x3x3 | 0 | window_diamond_l_3x3x4.xml |
| 菱形窗3x4x5 | Window Diamond 3x4x5 | 5 | 150 | 7x4x3 | 0 | window_diamond_xl_3x4x5.xml |
| 窗(1x1 倒锥形) | Window Inverse Pyramid 1x1 | 1 | 5 | 1x1x1 | 0 | window_1x1_inv_pyramid.xml |
| 窗口倒金字塔2x2x2 | Window Inverse Pyramid 2x2x2 | 2 | 15 | 2x2x2 | 0 | window_2x2_inv_pyramid.xml |
| 窗(1x1 锥形) | Window Pyramid 1x1x1 | 1 | 5 | 1x1x1 | 0 | window_1x1_pyramid.xml |
| 窗口金字塔2x2x2 | Window Pyramid 2x2x2 | 2 | 15 | — | 0 | window_2x2_pyramid.xml |
| 角窗(大) | Window Pyramid 3x3x3 | 4 | 135 | — | 0 | window_corner_2.xml |
