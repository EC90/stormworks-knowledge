-- source: steam id 3788743617 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788743617
MS_TO_KT = 1.943844

function onTick()
    awa = input.getNumber(1)
    aws = input.getNumber(2)
    sog = input.getNumber(3)

    output.setNumber(1, awa)
    output.setNumber(2, aws)
    output.setNumber(3, sog)
end

function drawArc(cx, cy, r, startDeg, endDeg, red, green, blue)
    screen.setColor(red, green, blue)
    for deg = startDeg, endDeg, 2 do
        local rad = math.rad(deg)
        local x = cx + r * math.sin(rad)
        local y = cy - r * math.cos(rad)
        screen.drawRectF(x, y, 1, 1)
    end
end

function onDraw()
    local w = screen.getWidth()
    local h = screen.getHeight()

    -- Background
    screen.setColor(0, 0, 0)
    screen.drawRectF(0, 0, w, h)

    local cx = 15
    local cy = 10
    local r = 9

    -- outer ring
    drawArc(cx, cy, r, 0, 360, 15, 15, 15)

    -- Starboard
    drawArc(cx, cy, r, 30, 60, 0, 120, 0)

    -- Port
    drawArc(cx, cy, r, 300, 330, 120, 0, 0)

    -- Cardinal ticks
    screen.setColor(100, 100, 100)
    for i = 0, 3 do
        local a = math.rad(i * 90)
        screen.drawLine(
            cx + (r - 1) * math.sin(a),
            cy - (r - 1) * math.cos(a),
            cx + r * math.sin(a),
            cy - r * math.cos(a)
        )
    end


    screen.setColor(100, 100, 100)


    screen.drawLine(cx, cy - 5, cx - 2, cy - 2)
    screen.drawLine(cx - 2, cy - 2, cx - 2, cy + 3)


    screen.drawLine(cx, cy - 5, cx + 2, cy - 2)
    screen.drawLine(cx + 2, cy - 2, cx + 2, cy + 3)






    local a = math.rad(awa or 0)

    local ax = cx + r * math.sin(a)
    local ay = cy - r * math.cos(a)

    local bx = cx + (r - 3) * math.sin(a)
    local by = cy - (r - 3) * math.cos(a)

    screen.setColor(20, 80, 150)

    -- main shaft
    screen.drawLine(ax, ay, bx, by)



    -- arrow head (clean triangular tip)
    local h1 = a + math.rad(150)
    local h2 = a - math.rad(150)

    screen.drawLine(bx, by,
        bx + 2 * math.sin(h1),
        by - 2 * math.cos(h1)
    )

    screen.drawLine(bx, by,
        bx + 2 * math.sin(h2),
        by - 2 * math.cos(h2)
    )

    -- Convert to knots
    local aws_kt = (aws or 0) * MS_TO_KT
    local sog_kt = (sog or 0) * MS_TO_KT

    local aws_str = string.format("W%04.1f", math.min(aws_kt, 99.9))
    local sog_str = string.format("S%04.1f", math.min(sog_kt, 99.9))

    -- Separator lines
    screen.setColor(5, 5, 5)
    screen.drawLine(0, 19, w, 19)
    screen.drawLine(0, 25, w, 25)

    -- Edge lines
    screen.drawLine(0, 0, w - 1, 0)
    screen.drawLine(0, h - 1, w - 1, h - 1)
    screen.drawLine(0, 0, 0, h - 1)
    screen.drawLine(w - 1, 0, w - 1, h - 1)

    -- AWS readout
    screen.setColor(100, 100, 100)
    screen.drawText(1, 20, aws_str)
    screen.setColor(100, 100, 100)
    screen.drawText(26, 20, "k")

    -- SOG readout
    screen.setColor(100, 100, 100)
    screen.drawText(1, 26, sog_str)
    screen.setColor(100, 100, 100)
    screen.drawText(26, 26, "k")
end