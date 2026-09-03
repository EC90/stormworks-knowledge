-- source: steam id 3792693533 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792693533
mapDarkON=property.getBool("Map Color Mode")

panSpeed=0.001*8

mapX=0
mapY=0

function onTick()
	--data import
	trgX=input.getNumber(9) or 0
	trgY=input.getNumber(10) or 0
	zoom=input.getNumber(15)
	mapZoom=zoom*0.001
	
	--control import
	pUP=input.getBool(3)
	pDOWN=input.getBool(4)
	pLEFT=input.getBool(5)
	pRIGHT=input.getBool(6)
	
	trgPOS=input.getBool(9)
	
	if trgPOS then
		mapX=trgX
		mapY=trgY
	end
	
	if pUP then
		mapY = mapY + zoom*panSpeed
	end
	if pDOWN then
		mapY = mapY - zoom*panSpeed
	end
	if pRIGHT then
		mapX = mapX + zoom*panSpeed
	end
	if pLEFT then
		mapX = mapX - zoom*panSpeed
	end
	
	
	output.setNumber(13,mapX)
	output.setNumber(14,mapY)
end
function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()					
	screen.drawMap(mapX,mapY,mapZoom)
	
	screen.setMapColorOcean(35, 65, 115)
    screen.setMapColorShallows(60, 90, 140)
    screen.setMapColorLand(190, 170, 130)
    screen.setMapColorGravel(190, 170, 130)
    screen.setMapColorGrass(180, 160, 120)
    screen.setMapColorSand(170, 150, 110)
    screen.setMapColorSnow(205, 185, 145)
    screen.setMapColorRock(200, 180, 140)

end