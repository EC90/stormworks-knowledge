-- source: steam id 2645485379 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2645485379
-- Tick function that will be executed every logic tick
function onTick()
	Zoomed = input.getBool(1)
	GPSAttack = input.getBool(2)
	X1 = input.getNumber(21)
	Y1 = input.getNumber(22)
	Z1 = input.getNumber(23)
--	X2 = input.getNumber(24)
--	Y2 = input.getNumber(25)
--	Z2 = input.getNumber(26)
	Distance = input.getNumber(27)
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					

	
	if GPSAttack  then
		screen.setColor(0, 0, 0,150)	
		screen.drawRectF(0, 0, w, h)
	end
	
	screen.setColor(0, 255, 0,150)	
	if GPSAttack  then
		screen.drawText(1, 1, "GPS Targeting")
		screen.drawText(1, 6, "Distance: "..math.floor(Distance).."m")
--		screen.drawText(1, 6, math.floor(X2)..","..math.floor(Y2)..","..math.floor(Z2))
	else

		if Zoomed then
			screen.drawCircle(w / 2, h / 2, 3)   -- Draw a 30px radius circle in the center of the screen
		else
			screen.drawCircle(w / 2, h / 2, 1)   -- Draw a 30px radius circle in the center of the screen
		end
	end
end