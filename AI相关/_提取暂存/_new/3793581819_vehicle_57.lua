-- source: steam id 3793581819 / vehicle.xml block#57
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819
-- Constants
local MUZZLE_VELOCITY = 250
local RAD_TO_DEG = 180 / math.pi
local DEG_TO_RAD = math.pi / 180
local ROT_LEAD_SCALE = 0.5  -- tweak this up or down to tune response

function onTick()
    local dist = input.getNumber(1)
    local xDeg = input.getNumber(2)
    local yDeg = input.getNumber(3)
    local dt = input.getNumber(4)
    local rotX = input.getNumber(5)  -- m/s, positive right
    local rotY = input.getNumber(6)  -- m/s, positive up

    if dist <= 0 or dt <= 0 then
        output.setNumber(1, 0)
        output.setNumber(2, 0)
        return
    end

    -- Convert to radians
    local azimuth = xDeg * DEG_TO_RAD
    local elevation = yDeg * DEG_TO_RAD

    -- Convert radar to 3D Cartesian point
    local tx = dist * math.cos(elevation) * math.sin(azimuth)
    local ty = dist * math.sin(elevation)
    local tz = dist * math.cos(elevation) * math.cos(azimuth)

    -- Estimate projectile flight time
    local travelTime = dist / MUZZLE_VELOCITY

    -- Predict additional lead from turret rotation
    local leadAngleX = rotX * ROT_LEAD_SCALE * travelTime  -- radians
    local leadAngleY = rotY * ROT_LEAD_SCALE * travelTime  -- radians

    -- Add to radar angles
    local azimuthLead = azimuth + leadAngleX
    local elevationLead = elevation + leadAngleY

    -- Output setpoints
    output.setNumber(1, azimuthLead * RAD_TO_DEG)   -- yaw
    output.setNumber(2, elevationLead * RAD_TO_DEG) -- pitch
end