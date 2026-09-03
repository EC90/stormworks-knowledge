-- source: steam id 3788743617 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788743617
tick = 0

function onTick()

    channel = input.getNumber(1)
    ptt = input.getBool(2)

    -- Time (0-1)

    local dayTime = input.getNumber(3)
    local totalMinutes = math.floor(dayTime * 1440)

    hour = math.floor(totalMinutes / 60) % 24
    minute = totalMinutes % 60

    -- Signal Strength (0-1)

    local strength = math.max(0, math.min(1, input.getNumber(4)))

    local scaled = strength * 4.5

    -- Number of solid bars
    signal = math.floor(scaled)

    -- Determine if the next bar should blink
    blinkSignal = false

    if signal == 0 then
        -- Blink first bar whenever there's any signal at all
        blinkSignal = strength > 0
    else
        -- Blink next bar halfway to the next level
        blinkSignal = (scaled - signal) >= 0.5
    end

    -- Blink Timer

    tick = tick + 1
    blink = (math.floor(tick / 30) % 2) == 0

end

function onDraw()

    local w = screen.getWidth()

-- Gradient Background

local w = screen.getWidth()
local h = screen.getHeight()

for y = 0, h - 1 do
    local t = y / (h - 1)

    -- Top color
    local r1, g1, b1 = 1, 3, 5

    -- Bottom color
    local r2, g2, b2 = 0, 0, 0

    local r = math.floor(r1 + (r2 - r1) * t)
    local g = math.floor(g1 + (g2 - g1) * t)
    local b = math.floor(b1 + (b2 - b1) * t)

    screen.setColor(r, g, b)
    screen.drawLine(0, y, w , y)
end

    -- Signal Bars

    local x = 1
    local y = 2

    -- Background bars
    screen.setColor(0,0,1)
    screen.drawRectF(x+0, y+6, 2,2)
    screen.drawRectF(x+3, y+4, 2,4)
    screen.drawRectF(x+6, y+2, 2,6)
    screen.drawRectF(x+9, y+0, 2,8)

    -- Solid bars
    screen.setColor(37,100,0)

    if signal >= 1 then screen.drawRectF(x+0, y+6, 2,2) end
    if signal >= 2 then screen.drawRectF(x+3, y+4, 2,4) end
    if signal >= 3 then screen.drawRectF(x+6, y+2, 2,6) end
    if signal >= 4 then screen.drawRectF(x+9, y+0, 2,8) end

    -- Blinking bar
    if blinkSignal and blink then
        if signal == 0 then
            screen.drawRectF(x+0, y+6, 2,2)
        elseif signal == 1 then
            screen.drawRectF(x+3, y+4, 2,4)
        elseif signal == 2 then
            screen.drawRectF(x+6, y+2, 2,6)
        elseif signal == 3 then
            screen.drawRectF(x+9, y+0, 2,8)
        end
    end

    -- PTT

    if ptt then
        screen.setColor(37,100,0)
    else
        screen.setColor(0,0,1)
    end

    screen.drawText(w-14,5,"PTT")

    -- Divider


    screen.setColor(5,6,8)
    screen.drawLine(0,12,w,12)
	screen.setColor(5,7,9)
    screen.drawLine(0,0,w,0)

    -- Frequency

    screen.setColor(100,100,100)
    screen.drawText(2,15,string.format("%06.2f",channel))

    -- Divider


    screen.setColor(5,5,6)
    screen.drawLine(0,23,w,23)
    screen.setColor(5,5,5)
    screen.drawLine(0,31,w,31)

    -- Clock

    local timeText

    if blink then
        timeText = string.format("%02d:%02d",hour,minute)
    else
        timeText = string.format("%02d %02d",hour,minute)
    end

    screen.setColor(100,100,100)
    screen.drawText(7,25,timeText)

end