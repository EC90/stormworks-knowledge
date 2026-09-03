-- source: steam id 2232448349 / vehicle.xml block#34
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2232448349
function onTick()
	z = input.getNumber(4)
	gpsx = input.getNumber(20)
	gpsy = input.getNumber(21)
	ctr1=input.getBool(4)
	if ctr1 then
		ctr=not ctr
	end
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	a = h/2
	b = w/2
	if not ctr or w<63 then
		screen.setMapColorOcean(1, 123, 146)
		screen.setMapColorShallows(0, 255, 255)
		screen.setMapColorLand(50, 50, 50)
		screen.setMapColorGrass(34, 139, 34)
		screen.setMapColorSand(252, 221, 118)
		screen.setMapColorSnow(255, 250, 250)
		screen.drawMap(gpsx, gpsy, z)
	end
end