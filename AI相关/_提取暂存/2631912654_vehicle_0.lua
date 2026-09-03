-- source: steam id 2631912654 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2631912654
function onTick()
	x = input.getNumber(1)
	y = input.getNumber(2)
end
function onDraw()
	screen.drawMap(x, y,0.2)
end