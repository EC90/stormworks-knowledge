-- source: steam id 2308050926 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2308050926
s=screen
getN=input.getNumber
gps={x=0,y=0}

function onTick()
	zoom=getN(19)
	gps={x=getN(7),y=getN(8)}
end

function onDraw()
	s.setMapColorOcean(0,0,0)
	s.setMapColorShallows(0,1,25,84)
	s.setMapColorLand(0,1,25,190)
	s.setMapColorGrass(0,0,0,0)
	s.setMapColorSand(0,0,0,0)
	s.setMapColorSnow(0,0,0,0)
	s.drawMap(gps.x,gps.y,zoom)	
end
