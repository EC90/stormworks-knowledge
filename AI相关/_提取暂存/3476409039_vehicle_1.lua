-- source: steam id 3476409039 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3476409039
-- Input/Output Initialization | 
local i, o = input, output
local gn, sn = i.getNumber, o.setNumber
local gb, sb = i.getBool, o.setBool

-- Math Utils | 
local m = math
local abs, min, max = m.abs, m.min, m.max
local clamp = function(v, lo, hi) return max(lo, min(v, hi)) end
local safe_divide = function(a, b) return b ~= 0 and a/b or 0 end

-- Configuration | 
local CONFIG = {
    Engine = {
        IdleRPM = 350,      -- Idle RPM threshold | 
        StartRPM = 300,     -- Starter activation RPM | 
        MaxClutchRPM = 600  -- Max RPM for clutch engagement | 
    },
    Vehicle = {
        MaxFwdKph = property.getNumber("MaxFwdKph") + 20,  -- Maximum forward speed | 
        MaxRevKph = property.getNumber("MaxRevKph"),       -- Maximum reverse speed | 
        SteerSpeedThreshold = 20,    -- Speed threshold for steering assist | 
        BrakeSpeedFactor = 0.005     -- Brake force speed factor | 
    },
    Transmission = {
        ReverseThreshold = 0.02,     -- Reverse gear threshold | 
        ClutchRPMWeight = 0.8,       -- Clutch RPM factor weight | 
        ClutchSpeedWeight = 0.2      -- Clutch speed factor weight | 
    }
}

-- Global State | 
local State = {
    last_reverse = false,
    reverse_smooth = 0,
    starter = false
}

--[[ Main Control Functions |  ]]--

-- Update Reverse State | 
local function updateReverseState(seatz)
    local is_reverse = seatz < 0
    if is_reverse ~= State.last_reverse then
        State.reverse_smooth = clamp(State.reverse_smooth + (is_reverse and 0.2 or -0.2), 0, 1)
    else
        State.reverse_smooth = is_reverse and 1 or 0
    end
    State.last_reverse = is_reverse
    return State.reverse_smooth
end

-- Calculate Engine Power | 
local function calculatePower(rpm, raw_kph, seatz, sta, batt)
    -- Calculate idle power | 
    local idle = safe_divide(CONFIG.Engine.IdleRPM - rpm, rpm) + safe_divide(1 - batt, batt)
    
    -- Check starter condition | 
    State.starter = rpm <= CONFIG.Engine.StartRPM and sta
    
    -- Calculate power based on direction | 
    if abs(seatz) <= CONFIG.Transmission.ReverseThreshold or not sta then
        return idle
    end
    
    local maxRPM = seatz > 0 
        and safe_divide(rpm, abs(raw_kph)) * CONFIG.Vehicle.MaxFwdKph
        or safe_divide(rpm, abs(raw_kph)) * abs(CONFIG.Vehicle.MaxRevKph)
    
    return safe_divide(maxRPM - rpm, rpm) + safe_divide(maxRPM, maxRPM + rpm) * abs(seatz)
end

-- Calculate Clutch Engagement | 
local function calculateClutch(rpm, raw_kph, seatz)
    local rpmFactor = clamp(rpm / CONFIG.Engine.MaxClutchRPM, 0, 1)
    local kphFactor = clamp(raw_kph / CONFIG.Vehicle.MaxFwdKph, 0, 1)
    return clamp(
        rpmFactor * CONFIG.Transmission.ClutchRPMWeight + 
        kphFactor * CONFIG.Transmission.ClutchSpeedWeight, 
        0, 1
    ) * abs(seatz)
end

-- Calculate Brake Force | 
local function calculateBrakes(raw_kph, seatx, seatz, power, idle)
    local LB, RB = 0, 0
    
    --  | Auto brake: when throttle is near neutral
    if abs(seatz) < 0.1 then
        --  | Reduce brake force as speed increases for smoother braking
        local speedFactor = clamp(1 - (abs(raw_kph) * 0.01), 0.2, 1)
        local autoBrake = clamp(0.8 * speedFactor * (1 - abs(seatz) * 10), 0, 1)
        return autoBrake, autoBrake
    end
    
    if power == idle then
        -- Static brake | 
        local brake = clamp(1 - m.sqrt(abs(raw_kph)) * 0.1, 0, 1)
        return brake, brake
    else
        -- Dynamic brake | 
        local brk = clamp(abs(raw_kph) * CONFIG.Vehicle.BrakeSpeedFactor, 0, 0.3)
        if abs(seatx) > CONFIG.Transmission.ReverseThreshold then
            if seatx > 0 then
                RB = brk * (seatx - CONFIG.Transmission.ReverseThreshold) / 0.85
            else
                LB = brk * (abs(seatx) - CONFIG.Transmission.ReverseThreshold) / 0.85
            end
        end
        return LB, RB
    end
end

-- Calculate Steering | 
local function calculateSteering(raw_kph, seatx)
    if abs(raw_kph) >= CONFIG.Vehicle.SteerSpeedThreshold then
        return seatx * clamp(1 / m.sqrt(abs(raw_kph) * 0.5), -1, 1)
    end
    return seatx
end

-- Main Tick Function | 
function onTick()
    -- Get Inputs | 
    local sta = gb(1)
    local seatx = gn(1)
    local seatz = gn(2)
    local rps = gn(3)
    local airp = gn(4)
    local batt = gn(5)
    local raw_kph = gn(9) * 3.6
    local rpm = rps * 60

    -- Process Controls | 
    local reverse_smooth = updateReverseState(seatz)
    local power = calculatePower(rpm, raw_kph, seatz, sta, batt)
    local clutch = calculateClutch(rpm, raw_kph, seatz)
    local airth = clamp((0.4 * -(0.98^airp) + 0.9) * power, 0, 1)
    local LB, RB = calculateBrakes(raw_kph, seatx, seatz, power, idle) -- seatz
    local steering = calculateSteering(raw_kph, seatx)

    -- Set Outputs | 
    sb(1, reverse_smooth > 0.5)
    sb(2, State.starter)
    sn(1, airth)
    sn(2, 0.5 * airth)
    sn(3, steering)
    sn(4, raw_kph)
    sn(5, clamp(LB, 0, 1))
    sn(6, clamp(RB, 0, 1))
    sn(7, clutch)
end