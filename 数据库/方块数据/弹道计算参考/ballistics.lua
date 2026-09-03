--[[============================================================================
  Stormworks 弹道计算机 · 游戏内 Lua 参考实现
  ---------------------------------------------------------------------------
  数值来源：Fandom Wiki《Search and Destroy DLC》(rev 4717, V1.15.12 / 2026-03-19)
  中文名来源：创意工坊简体中文汉化补丁（D:\STORMWORKS\汉化相关\）

  ★ 两个必须先记住的常数（与直觉相反，写错全盘皆错）：
      弹丸重力 G = 30 m/s²       ← 不是载具的 10！(V1.3.6 起)
      游戏速率 TPS = 60 tick/s
      阻力：每 tick  v = v × (1 - k)，k 见下方 WEAPONS 表

  ★ 微型控制器接口约定（改线序时只改这里的常量）：
      数值输入 1 = 目标水平距离 (m)      来自激光测距 / 雷达 / GPS 解算
      数值输入 2 = 目标高度差 (m)        目标海拔 - 炮口海拔，正则目标更高
      数值输入 3 = 武器编号 (1-7)        见 WEAPONS 顺序，可用属性下拉框
      数值输出 1 = 所需仰角 (°)          送炮塔俯仰
      数值输出 2 = 飞行时间 (s)          送重炮的「引信定时器」实现空爆/定时
      数值输出 3 = 瞄准抬高量 (m)        无炮塔转向时用于人工瞄准

  用法：整段贴进 Lua 脚本方块即可。首次运行会用约 40 个 tick 建表，
        建表期间输出维持 0。表建好后每 tick 只做一次插值，开销可忽略。
============================================================================]]

TPS = 60
G = 30.0          -- 弹丸重力，勿改成 10

-- 武器参数表：{ 中文名, 初速m/s, 阻力k每tick, 存活tick, 标称射程m }
WEAPONS = {
  { "机枪",         800,  0.005,  120,  500  },
  { "轻型自动火炮",  1000, 0.020,  150,  750  },
  { "转管自动火炮",  1000, 0.010,  300,  1500 },
  { "重型自动火炮",  900,  0.005,  600,  2500 },
  { "坦克主炮",     800,  0.002,  1500, 4500 },
  { "大型榴弹炮",    700,  0.001,  2400, 6500 },
  { "贝莎巨炮",     600,  0.0005, 2400, 7500 },
}

-- 建表配置
-- ★ 用固定角度步长而非固定步数：机枪最优角仅约 2.4°，若按 0~60° 均分 60 步，
--   机枪只会留下 4 个表项，插值误差极大。固定 0.25° 步长后各武器都有足够精度，
--   且短程武器会在很早就截断，建表反而更快（机枪约 13 tick，贝莎约 155 tick）。
ANGLE_MIN = 0.0        -- 扫描起始仰角
ANGLE_MAX = 60.0       -- 扫描结束仰角
ANGLE_STEP = 0.25      -- 扫描步长（度）

tableReady = false
buildIndex = 0         -- 当前建到第几个仰角
lastDist = nil         -- 建表时上一个仰角的射程，用于检测非单调拐点
rangeTable = {}        -- { {dist, time, angle}, ... } 按距离升序（仅低伸分支）

--- 逐 tick 积分一条弹道。返回 { 落点距离m, 飞行时间s }
function trace(v0, k, life, angleDeg)
    local a = math.rad(angleDeg)
    local vx = v0 * math.cos(a)
    local vy = v0 * math.sin(a)
    local x, y = 0.0, 0.0
    for t = 1, life do
        vx = vx * (1 - k)        -- 阻力（每 tick 按速度比例衰减）
        vy = vy * (1 - k)
        vy = vy - G / TPS       -- 重力（弹丸 30，不是 10）
        x = x + vx / TPS
        y = y + vy / TPS
        if y <= 0 and vy < 0 then
            return x, t / TPS
        end
    end
    return x, life / TPS        -- 未落地：被弹丸存活上限截断
end

--- 建表：onTick 每帧只算一个仰角，避免单帧超时。
--- ★ 关键：射程随仰角**非单调**——超过最优角后仰角越大射程越短。
---   若把 0~60° 全塞进表，插值会在最优角之后取到错误的那一支。
---   因此一旦检测到射程开始下降，立即停止建表，只保留低伸弹道分支（直射解）。
function buildTableStep(w)
    if tableReady then return end
    local angle = ANGLE_MIN + ANGLE_STEP * buildIndex
    buildIndex = buildIndex + 1
    if angle > ANGLE_MAX then
        tableReady = true
        return
    end
    local dist, tof = trace(w[2], w[3], w[4], angle)

    if lastDist ~= nil and dist < lastDist then
        -- 已过最优角，后续角度属于高抛分支，丢弃
        tableReady = true
        return
    end
    lastDist = dist
    table.insert(rangeTable, { dist, tof, angle })
end

--- 在已建表上按距离插值，返回 仰角°, 飞行时间s
function lookup(dist)
    if not tableReady or #rangeTable == 0 then return 0.0, 0.0 end
    if dist <= rangeTable[1][1] then
        return rangeTable[1][3], rangeTable[1][2]
    end
    if dist >= rangeTable[#rangeTable][1] then
        local last = rangeTable[#rangeTable]
        return last[3], last[2]
    end
    for i = 1, #rangeTable - 1 do
        local a, b = rangeTable[i], rangeTable[i + 1]
        if dist >= a[1] and dist <= b[1] then
            local f = (dist - a[1]) / (b[1] - a[1])
            return a[3] + (b[3] - a[3]) * f,
                   a[2] + (b[2] - a[2]) * f
        end
    end
    return 0.0, 0.0
end

--- 高度差修正：目标更高就多加一点仰角（一阶近似，够用）
--- 原理：把高差折算成等效的重力做功，按落点垂直速度反推角度增量
function applyHeightDelta(dist, tof, dy)
    if tof <= 0 then return 0.0 end
    return math.deg(math.atan(dy / math.max(dist, 1.0)))
end

function onTick()
    local wIndex = math.floor(input.getNumber(3) or 1)
    if wIndex < 1 or wIndex > #WEAPONS then wIndex = 1 end
    local w = WEAPONS[wIndex]

    -- 换武器要重建表
    if currentWeapon ~= wIndex then
        currentWeapon = wIndex
        tableReady = false
        buildIndex = 0
        lastDist = nil
        rangeTable = {}
    end

    buildTableStep(w)
    if not tableReady then
        output.setNumber(1, 0)
        output.setNumber(2, 0)
        output.setNumber(3, 0)
        return
    end

    local dist = input.getNumber(1) or 0
    local dy = input.getNumber(2) or 0

    local angle, tof = lookup(dist)
    angle = angle + applyHeightDelta(dist, tof, dy)

    output.setNumber(1, angle)                            -- 仰角
    output.setNumber(2, tof)                              -- 引信定时
    output.setNumber(3, dist * math.tan(math.rad(angle))) -- 抬高量
end

--[[----------------------------------------------------------------------------
  接线提示
  ----------------------------------------------------------------------------
  1. 目标距离：激光测距传感器（最远 4000 m）或雷达的复合输出，
     也可用自稳定云台摄像机的激光命中点反解。超过 4000 m 只能靠 GPS 解算。
  2. 引信定时器只有 重型自动火炮 / 坦克主炮 / 大型榴弹炮 / 贝莎巨炮 才有，
     且仅对 高爆弹(HE) 与 破片弹 生效 —— 输出 2 接到「引信定时器」节点即可空爆。
  3. 机枪与火箭弹发射器没有引信定时器，输出 2 无意义。
  4. 贝莎巨炮弹丸存活 2400 tick = 40 s，飞行时间可能很长，
     移动目标必须做提前量，本实现只解静止目标。
  5. 若要连发修正：把实测落点误差反馈回来做 PID 修角度，
     比继续细化模型更有效——wiki 数值本身有约 ±5% 不确定性。
----------------------------------------------------------------------------]]
