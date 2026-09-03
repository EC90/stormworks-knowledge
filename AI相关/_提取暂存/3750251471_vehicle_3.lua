-- source: steam id 3750251471 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3750251471

--       ( )

--  
function clamp(x, minVal, maxVal)
    return math.max(math.min(x, maxVal), minVal)
end

local sin = math.sin
local cos = math.cos
local asin = math.asin
local atan = math.atan
local sqrt = math.sqrt
local log = math.log
local exp = math.exp
local pi = math.pi

--   (  )
G = 30
V = 800
u = 0.002
lifeSpan = 10  --  (600  / 60)
SC=0
--    (drag   1/)
local g = G
local vel = V
local drag = u * 60  --    

--    (  )
function getY(v, t)
    --     
    return -g * t / drag + (g / drag + v) * (1 - exp(-drag * t)) / drag
end

function getTime(v, x)
    --      x
    return -log(1 - drag * x / v) / drag
end

function calc(dist, elv)
    --       
    local w = dist * cos(elv)  --  
    local h = dist * sin(elv)  --  
    local a = elv
    for i = 1, 10 do
        local vx = vel * cos(a)
        local vy = vel * sin(a)
        local t = getTime(vx, w)
        if t > lifeSpan then
            return a, t, false
        end
        local y = getY(vy, t)
        if y >= h - 0.1 then  -- error = 0.1
            return a, t, true
        end
        a = a + elv - atan(y, w)
    end
    return a, 0, false
end

--  
N = 0
Targ = {}
TableTickTarg = 10
TickCompensate = 12

tick = 0
px = 0
py = 0
pz = 0

function onTick()
    if tick < 10 then tick = tick + 1 return end

    local ox = input.getNumber(1)
    local oy = input.getNumber(3)
    local oz = input.getNumber(2)

    local n = input.getNumber(4)
    local o = input.getNumber(5)
    local l = input.getNumber(6)

    if input.getNumber(10) == 1 then
        px = input.getNumber(7)
        py = input.getNumber(9)
        pz = input.getNumber(8)
    end

    targetGiven = px ~= 0

    --   (  )
    local f, m, g = cos(n), cos(o), cos(l)
    local i, k, e = sin(n), sin(o), sin(l)
    local q = f * k * e - i * g
    local pitch = asin(q)
    local yaw = atan(f * m, f * k * g + i * e)
    yaw = -yaw + pi / 2
    if yaw > pi then yaw = yaw - 2 * pi elseif yaw <= -pi then yaw = yaw + 2 * pi end

    local denom = sqrt(1 - q * q)
    local roll = 0
    if denom > 1e-10 then roll = asin(-m * e / denom) end
    if i * k * e + f * g < 0 then
        roll = pi - roll
        if roll > pi then roll = roll - 2 * pi end
    end
    if roll > pi then roll = roll - 2 * pi elseif roll <= -pi then roll = roll + 2 * pi end

    --      
    local dx = px - ox
    local dy = py - oy
    local dz = pz - oz

    --   (  )
    local cx, sx = cos(pitch), sin(pitch)
    local cy, sy = cos(roll), sin(roll)
    local cz, sz = cos(yaw), sin(yaw)

    local r11 = cz * cy + sz * sx * sy
    local r12 = sz * cx
    local r13 = cz * sy - sz * sx * cy
    local r21 = -sz * cy + cz * sx * sy
    local r22 = cz * cx
    local r23 = -sz * sy - cz * sx * cy
    local r31 = -cx * sy
    local r32 = sx
    local r33 = cx * cy

    --      
    local lx = r11 * dx + r21 * dy + r31 * dz
    local ly = r12 * dx + r22 * dy + r32 * dz
    local lz = r13 * dx + r23 * dy + r33 * dz

    --    (     )
    local targetYaw = 0
    local targetPitch = 0

    if targetGiven then
        --  ( )
        targetYaw = -(atan(lx, ly) / (2 * pi)) % 1

        --    
        local dist = sqrt(lx * lx + ly * ly + lz * lz)
        if dist > 0.01 then
            local elv = atan(lz / sqrt(lx * lx + ly * ly))  --    
            local gunElv, flightTime, success = calc(dist, elv)
            if success then
                --    ,   
                targetPitch = (-gunElv / (2 * pi)) % 1
                --   ( )
                output.setNumber(3, (gunElv - elv) / (2 * pi))  -- 
                output.setNumber(4, flightTime * 60)             --   
                output.setBool(1, true)                          -- 
            else
                -- fallback   
                targetPitch = (-elv / (2 * pi)) % 1
                output.setNumber(3, 0)
                output.setNumber(4, 0)
                output.setBool(1, false)
            end
            output.setNumber(5, dist)  -- 
        else
            targetPitch = 0
            output.setNumber(3, 0)
            output.setNumber(4, 0)
            output.setBool(1, false)
        end
    else
        targetYaw = 0
        targetPitch = 0
        output.setNumber(3, 0)
        output.setNumber(4, 0)
        output.setBool(1, false)
    end

Lock=input.getNumber(18)

    if Lock==1 then targetYaw = input.getNumber(19) end

    yawError = (targetYaw + 0.5) % 1 - 0.5
    yawSpeed = clamp(yawError * 5, -1, 1)

    pitchError = (targetPitch + 0.5) % 1 - 0.5
    pitchSpeed = clamp(pitchError * 5, -1, 1)



	if input.getNumber(16)==1 then
		mouseX = input.getNumber(11)
		mouseY = input.getNumber(12)
		SC=0
	else
		if input.getNumber(14) > 0 and SC < 0.24 then SC=SC+0.002 elseif input.getNumber(14) < 0 and SC >-0.1 then SC=SC-0.002 end
		mouseX=0
		mouseY=0
	end
		QE = input.getNumber(13)
		
	if input.getNumber(10) == 1 and input.getNumber(15) == 1 then
		ZALUPA=-pitchSpeed
		ZALUPA1=yawSpeed
	else
		ZALUPA=0
		ZALUPA1=0
	end
	
	if Lock==1 then 
		mouseX=0
		mouseY=0
		ZALUPA=0
		ZALUPA1=yawSpeed
		QE=0
		SC=0
	end
	
    output.setNumber(2, clamp(ZALUPA-mouseY+SC,-0.1,0.24))

	if input.getNumber(17)==1 then output.setNumber(2, 0) end
	
    output.setNumber(1, ZALUPA1+mouseX-QE/6)
end