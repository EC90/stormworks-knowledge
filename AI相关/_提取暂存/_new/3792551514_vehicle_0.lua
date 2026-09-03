-- source: steam id 3792551514 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792551514
local thr = 0.0
local comp = 0.0

function onTick()
	gear = input.getNumber(1)
	spd = input.getNumber(2)
	rps = input.getNumber(3)
	fuel = input.getNumber(4)
	temp = input.getNumber(5)
	batt = input.getNumber(6)
	thr = input.getNumber(7)
	comp = input.getNumber(8)
	thr2 = input.getNumber(9)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	
	screen.setColor(0, 0, 0)
	screen.drawClear()

	screen.setColor(17,8,0)
	screen.drawRect(0, 0, 95, 31)
	
	screen.setColor(82,53,6)
	screen.drawRect(1, 1, 93, 29)

	
	screen.setColor(180, 120, 20)
	screen.drawRect((w/2)-19, 0, 36, 31)
	
	screen.setColor(110, 60, 4)
	screen.drawRect((w/2)-18, 1, 34, 29)
	
	screen.setColor(26, 26, 26)
		
	screen.drawTextBox((w/2)-48, 9, 32, 5, "RPS", 0, 0)
		
	screen.drawTextBox((w/2)+16, 9, 33, 5, "FUEL", 0, 0)		
		
	screen.drawTextBox((w/2)-58, 17, 31, 5, "B", 0, 0)	
		
	screen.drawTextBox((w/2)-58, 23, 31, 5, "T", 0, 0)	
	
	

	
	    -- Set the filling bar color
    screen.setColor(200, 140, 5)

    -- Calculate the height of the filling bar
    local fillHeight = math.floor(thr * 24)  -- Scale the throttle value to the bar height

    -- Calculate the Y coordinate for the filling bar
    local fillY = 28 - fillHeight

    -- Draw the filling bar
    screen.drawRectF(33, fillY, 2, fillHeight)

    -- Draw the outline for the filling bar
    screen.setColor(26, 26, 26)
    screen.drawRect(32, 3, 3, 25)	
		
	
	if thr2 == 1 and thr == 1 then
        screen.setColor(25, 200, 10)
		screen.drawRectF(33, 4, 2, 24)
	elseif thr2 < 0 and thr < 0.1 then
        screen.setColor(200, 5, 5)
		screen.drawRectF(33, 4, 2, 24)
	else     	
	end
	
   local direction = ""
    if comp >= -0.0625 and comp < 0.0625 then
        direction = "N"
    elseif comp >= 0.0625 and comp < 0.1875 then
        direction = "NW"
    elseif comp >= 0.1875 and comp < 0.3125 then
        direction = "W"
    elseif comp >= 0.3125 and comp < 0.4375 then
        direction = "SW"
    elseif (comp >= 0.4375 and comp <= 0.5) or (comp >= -0.5 and comp < -0.4375) then
        direction = "S"
    elseif comp >= -0.4375 and comp < -0.3125 then
        direction = "SE"
    elseif comp >= -0.3125 and comp < -0.1875 then
        direction = "E"
    elseif comp >= -0.1875 and comp < -0.0625 then
        direction = "NE"
    else
        direction = "ERR"
    end

    screen.setColor(10, 10, 10)
	screen.drawTriangleF((w/2)-10, (h/2+10), (w/2), h/2+3, (w/2)+10, (h/2+10))

    screen.setColor(60, 60, 60)
    screen.drawTextBox((w/2-7), 20, 14, 5, direction,0,0)

		
	screen.setColor(60, 60, 60)	
		
	screen.drawTextBox((w/2)-48, 3, 32, 5, string.format("%.0f", rps), 0, 0)

	
	screen.drawTextBox((w/2)+15, 3, 32, 5, string.format("%.0f", fuel)..'%', 0, 0)

	screen.drawTextBox((w/2)-46, 17, 32, 5, string.format("%.0f", batt)..'%', 0, 0)

	screen.drawTextBox((w/2)-46, 23, 32, 5, string.format("%.0f", temp)..'C', 0, 0)

	screen.setColor(180, 120, 20)
	screen.drawTextBox((w/2)-14, 4, 32, 5, string.format("%.0f", spd), 0, 0)
	screen.drawTextBox((w/2)-14, 10, 32, 5, "KTS", 0, 0)
	
		
end