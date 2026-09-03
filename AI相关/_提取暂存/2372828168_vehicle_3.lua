-- source: steam id 2372828168 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2372828168
-- Tick function that will be executed every logic tick
function onTick()

end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	screen.setColor(200, 200, 0)
	screen.drawRectF(16, 16, 1, 1)
	screen.drawLine(5, 16, 14, 16)
	screen.drawLine(18, 16, 28, 16)
	screen.drawLine(14, 16, 14, 18)
	screen.drawLine(18, 16, 18, 18)
end