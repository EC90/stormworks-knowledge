-- source: steam id 3788743617 / vehicle.xml block#14
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788743617
tick = 0

wind = 0
speed = 0
depth = 0
temp = 0
humidity = 0
MS_TO_KT = 1.94384


------------------------------------------------
-- Temperature Color Function
------------------------------------------------

function temperatureColor(t)

    local r,g,b

    if t < 0 then

        -- Dark blue -> Cyan

        local p = (t + 20) / 20
        p = math.max(0, math.min(1,p))

        r = 0
        g = 45 + (70 - 45) * p
        b = 90 - (90 - 70) * p


    elseif t < 15 then

        -- Cyan -> Green

        local p = t / 15

        r = 0
        g = 70 - (10 * p)
        b = 70 - (40 * p)


    elseif t < 30 then

        -- Green -> Orange

        local p = (t - 15) / 15

        r = 90 * p
        g = 60 - (15 * p)
        b = 30 - (25 * p)


    else

        -- Orange -> Red

        local p = (t - 30) / 15
        p = math.min(1,p)

        r = 90 + (10 * p)
        g = 45 - (40 * p)
        b = 5

    end

    return r,g,b

end

------------------------------------------------
-- Input Reading
------------------------------------------------

function onTick()

    wind = input.getNumber(1) or 0
    speed = input.getNumber(2) or 0
    depth = input.getNumber(3) or 0
    temp = input.getNumber(4) or 0
    humidity = input.getNumber(5) or 0

end


------------------------------------------------
-- Drawing
------------------------------------------------

function onDraw()

    local w = screen.getWidth()
    local h = screen.getHeight()


    ------------------------------------------------
    -- Gradient Background
    ------------------------------------------------

    for y = 0, h - 1 do

        local t = y / (h - 1)

        local r1,g1,b1 = 1,3,5
        local r2,g2,b2 = 0,0,0

        local r = math.floor(r1 + (r2-r1)*t)
        local g = math.floor(g1 + (g2-g1)*t)
        local b = math.floor(b1 + (b2-b1)*t)

        screen.setColor(r,g,b)
        screen.drawLine(0,y,w,y)

    end


    ------------------------------------------------
    -- Divider
    ------------------------------------------------
	screen.setColor(5,8,10)
    screen.drawLine(0,0,w,0)
    
    screen.setColor(5,7,8)
    screen.drawLine(0,19,w,19)
    
    screen.setColor(5,5,5)
    screen.drawLine(0,31,w,31)



    ------------------------------------------------
    -- Right Alignment Function
    ------------------------------------------------

    function rightText(y,text,offset)

        local width = string.len(text) * 4

        screen.drawText(
            w - width - 1 - offset,
            y,
            text
        )

    end



    ------------------------------------------------
-- Wind & Speed
------------------------------------------------

screen.setColor(100,100,100)

rightText(1,
    string.format("W%4.1fk", wind * MS_TO_KT),5)


rightText(7,
    string.format("S%4.1fk", speed * MS_TO_KT),5)
    ------------------------------------------------
    -- Depth
    ------------------------------------------------

    screen.setColor(100,100,100)

    rightText(14,
        string.format("D%4.1fm", depth),5)



    ------------------------------------------------
    -- Temperature
    ------------------------------------------------

    local tr,tg,tb = temperatureColor(temp)

    screen.setColor(tr,tg,tb)

    rightText(20,
        string.format("T%3.0fC", temp),4)



    ------------------------------------------------
    -- Rain / Humidity
    ------------------------------------------------

    screen.setColor(40,90,100)

    rightText(26,
        string.format("R%3.0f%%", humidity*100),4)


end