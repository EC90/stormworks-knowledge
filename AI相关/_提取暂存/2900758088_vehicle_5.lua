-- source: steam id 2900758088 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2900758088

	si=math.sin
	co=math.cos
	pi=math.pi
	pi2=pi*2
	BRT = 200

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



-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	CPX, CPY = map.mapToScreen(mapX, mapY, zoom, w, h, mapX, mapY)
	
	screen.setMapColorOcean(BR, BG, BB)
	screen.setMapColorShallows(BR-5, BG-5, BB-5)
	screen.setMapColorLand(BR-10, BG-10, BB-10)
	screen.setMapColorGrass(BR-15, BG-15, BB-15)
	screen.setMapColorSand(BR-20, BG-20, BB-20)
	screen.setMapColorSnow(BR-25, BG-25, BB-25)

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