-- source: steam id 1962616298 / vehicle.xml block#15
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1962616298
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
		screen.setMapColorOcean(0, 0, 0)
		screen.setMapColorShallows(10, 10, 10)
		screen.setMapColorLand(20, 20, 20)
		screen.setMapColorGrass(20, 20, 20)
		screen.setMapColorSand(20, 20, 20)
		screen.setMapColorSnow(20, 20, 20)
		screen.drawMap(gpsx, gpsy, z)
	end
end