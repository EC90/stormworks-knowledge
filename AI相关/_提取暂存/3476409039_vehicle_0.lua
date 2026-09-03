-- source: steam id 3476409039 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3476409039
-- Constants and function caching | 
local Math, sin, cos, pi = math, math.sin, math.cos, math.pi
local floor, min, rad, deg, abs = Math.floor, Math.min, Math.rad, Math.deg, Math.abs
screen = screen or {}
local Screen, Input = screen, input
local drawLine, drawCircle, drawCircleFill, drawRectFill, drawTextBox, setColor = 
    Screen.drawLine, Screen.drawCircle, Screen.drawCircleF, Screen.drawRectF, Screen.drawTextBox, Screen.setColor
local getNumber = Input.getNumber

-- Configuration | 
local CONFIG = {
    -- Meters configuration |  {label, max_value, scale_factor}
    Meters = {
        {label = "SPD", max = 120, scale = 3.6},  -- Speed meter | 
        {label = "RPM", max = 3600, scale = 60},  -- RPM meter | 
        {label = "TEM", max = 120, scale = 1}     -- Temperature meter | 
    },
    -- Colors configuration | 
    Colors = {
        background = {20, 20, 20, 255},      -- Background color | 
        meterBg = {0, 0, 0, 255},           -- Meter background | 
        scale = {255, 255, 255, 255},       -- Scale color | 
        pointer = {255, 0, 0, 125},         -- Pointer color | 
        shadow = {50, 50, 50, 125},         -- Shadow color | 
        text = {255, 255, 255, 255},        -- Normal text | 
        warning = {255, 165, 0, 255},       -- Warning color | 
        negative = {255, 0, 0, 255}         -- Negative value | 
    }
}

-- Store meter values | 
local meterValues = {0, 0, 0}

-- Update meter values | 
function onTick()
    for i = 1, 3 do 
        meterValues[i] = floor(getNumber(i) * CONFIG.Meters[i].scale) 
    end
end

-- Draw text with alignment | 
---@param x number X position | X
---@param y number Y position | Y
---@param text string Text content | 
---@param verticalOffset number? Vertical offset | 
---@param alignment number? Text alignment (-1:left, 0:center, 1:right) | 
local function drawText(x, y, text, verticalOffset, alignment)
    local width = string.len(text) * 4 + 4
    verticalOffset = verticalOffset or 0
    alignment = alignment or 0
    
    local xPos = x - (
        alignment == 1 and -10 or 
        alignment == -1 and width - 10 or 
        width / 2
    )
    drawTextBox(xPos, y + verticalOffset, width, 5, text, alignment, 0)
end

-- Draw meter | 
---@param x number Center X position | X
---@param y number Center Y position | Y
---@param radius number Meter radius | 
---@param value number Current value | 
---@param maxValue number Maximum value | 
---@param label string Meter label | 
local function drawMeter(x, y, radius, value, maxValue, label)
    local labelWidth = string.len(label) * 4
    local arcStartAngle = deg(Math.asin((labelWidth + 8) / (radius * 2)))
    local startAngle, endAngle = -180 + arcStartAngle, 180 - arcStartAngle
    
    -- Draw meter background | 
    setColor(table.unpack(CONFIG.Colors.meterBg))
    drawCircleFill(x, y, radius * 1.2)
    
    -- Draw scale | 
    setColor(table.unpack(CONFIG.Colors.scale))
    for angle = startAngle, endAngle do
        local rad = rad(angle - 90)
        local cosA, sinA = cos(rad), sin(rad)
        drawLine(
            x + cosA * radius, 
            y + sinA * radius,
            x + cosA * (radius - 1), 
            y + sinA * (radius - 1)
        )
    end
    
    -- Draw pointer | 
    local absValue = abs(value)
    local pointerAngle = rad((min(absValue / maxValue, 1)) * (endAngle - startAngle) + startAngle - 90)
    setColor(table.unpack(CONFIG.Colors.pointer))
    drawLine(x, y, x + cos(pointerAngle) * radius * 0.8, y + sin(pointerAngle) * radius * 0.8)
    drawCircleFill(x, y, 2)
    
    -- Draw value shadow and text | 
    setColor(table.unpack(CONFIG.Colors.shadow))
    drawText(x, y - 5, "0000")
    
    -- Select text color based on value | 
    local textColor = value < 0 and CONFIG.Colors.negative or
                     absValue > maxValue * 0.8 and CONFIG.Colors.warning or
                     CONFIG.Colors.text
    setColor(table.unpack(textColor))
    
    -- Draw value and label | 
    drawText(x, y - 5, string.format("%4d", floor(absValue)), 0, -1)
    drawText(x, y, label, radius * 0.8)
end

-- Main drawing function | 
function onDraw()
    if not(screen and screen.drawLine) then 
        screen = screen or {} 
        return 
    end
    
    local width, height = Screen.getWidth(), Screen.getHeight()
    local spacing = width / 3
    
    -- Draw background | 
    setColor(table.unpack(CONFIG.Colors.background))
    drawRectFill(0, 0, width, height)
    
    -- Draw meters | 
    for i = 1, 3 do
        local meter = CONFIG.Meters[i]
        drawMeter(
            spacing * (i - 0.5),    -- X position | X
            height / 2,             -- Y position | Y
            14,                     -- Radius | 
            meterValues[i],         -- Current value | 
            meter.max,              -- Maximum value | 
            meter.label            -- Label | 
        )
    end
end