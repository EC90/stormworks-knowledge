-- source: steam id 2921661478 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2921661478
function onTick()
	XC=input.getNumber(1)
	YC=input.getNumber(2)
	ZO=input.getNumber(3)
end

function onDraw()
	screen.setMapColorOcean(255,255,255,2)
	screen.setMapColorShallows(255,255,255,18)
	screen.setMapColorLand(255,255,255,40)
	screen.setMapColorGrass(255,255,255,50)
	screen.setMapColorSand(255,255,255,60)
	screen.setMapColorSnow(255,255,255,80)
	screen.drawMap(XC,YC,ZO)
end