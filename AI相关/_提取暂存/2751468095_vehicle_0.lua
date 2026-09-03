-- source: steam id 2751468095 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2751468095

	si=math.sin
	co=math.cos
	pi=math.pi
	pi2=pi*2
	BRT = 200
	s=screen

function onTick()
	zoom = input.getNumber(3)
	mapX = input.getNumber(1)
	mapY = input.getNumber(2)
	GREY = input.getBool(1)
	TR = property.getNumber("TextR")
	TG = property.getNumber("TextG")
	TB = property.getNumber("TextB")
	compass=input.getNumber(4)*pi2*-1
	BR = property.getNumber("BackroundR")
	BG = property.getNumber("BackroundG")
	BB = property.getNumber("BackroundB")
	BRT = input.getNumber(5)
end
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()					
	CPX, CPY = map.mapToScreen(mapX, mapY, zoom, w, h, mapX, mapY)
	
	s.setMapColorOcean(0,10,0)
	s.setMapColorShallows(0,15,0)
	s.setMapColorLand(0,50,0)
	s.setMapColorGrass(0,70,0)
	s.setMapColorSand(0,60,0)
	s.setMapColorSnow(0,60,0)

	screen.drawMap(mapX, mapY, zoom)
	
	screen.setColor(0, 0, 0, BRT)
	drawPointer(CPX,CPY,10,compass)

	
	screen.setColor(5, 5, 5)			
	screen.drawRectF(0, 0, w, 2)
	screen.drawRectF(0, 0, 2, h)
	screen.drawRectF(0, h-2, w, 2)
	screen.drawRectF(w-2, 0, 2, h)
	
end
function drawPointer(x,y,s,r,...)
a=...
a=(a or 30)*pi/360
x=x+s/2*si(r)
y=y-s/2*co(r)

screen.drawTriangleF(x,y,x-s*si(r+a),y+s*co(r+a),x-s*si(r-a),y+s*co(r-a))
end