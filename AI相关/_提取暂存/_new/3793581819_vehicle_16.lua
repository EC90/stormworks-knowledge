-- source: steam id 3793581819 / vehicle.xml block#16
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819
function onTick()
    -- === Inputs ===
    local gpsX = input.getNumber(1)
    local gpsY = input.getNumber(2)
    local gpsZ = input.getNumber(3)
    local yawNorm = input.getNumber(4)    -- -0.5 to 0.5
    local pitchNorm = input.getNumber(5)  -- -0.5 to 0.5

    -- === Convert normalized to radians ===
    local yawRad = -yawNorm * 2 * math.pi  -- Invert because Stormworks yaw is clockwise
    local pitchRad = pitchNorm * math.pi

    -- === Forward vector in ENU space ===
    local forwardX = math.cos(pitchRad) * math.sin(yawRad)
    local forwardY = math.cos(pitchRad) * math.cos(yawRad)
    local forwardZ = -math.sin(pitchRad)

    -- === Distance to project ===
    local distance = 50

    -- === Projected GPS coordinate ===
    local projX = gpsX + forwardX * distance
    local projY = gpsY + forwardY * distance
    local projZ = gpsZ + forwardZ * distance

    -- === Outputs ===
    output.setNumber(1, projX)
    output.setNumber(2, projY)
    output.setNumber(3, projZ)
end