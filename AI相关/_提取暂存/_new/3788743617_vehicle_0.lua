-- source: steam id 3788743617 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788743617

	si=math.sin
	co=math.cos
	pi=math.pi
	pi2=pi*2
	zoom = 1

function onTick()	
	zoom = input.getNumber(1)
	compass=input.getNumber(2)*pi2*-1
	gpsx = input.getNumber(3)			 
	gpsy = input.getNumber(4)
	if zoom==0 then zoom=defaultZoom end
			
end
	
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
						
	screen.drawMap(gpsx, gpsy, zoom)
	screen.setMapColorOcean(100, 140, 160,200)
	screen.setMapColorShallows(30, 80, 120, 200)
	screen.setMapColorSand(20, 120, 30, 200)
	screen.setMapColorLand(170, 100, 30, 200)
	pixelX, pixelY = map.mapToScreen(gpsx, gpsy, zoom, w, h)					
	cpX, cpY = map.mapToScreen(mapX, mapY, zoom, w, h, mapX, mapY)
		
	screen.setColor(255, 0, 0)
	drawPointer(cpX,cpY,7,compass)	
end
	

function drawPointer(x,y,s,r,...)
a=...
a=(a or 40)*pi/360
x=x+s/2*si(r)
y=y-s/2*co(r)
screen.drawTriangleF(x,y,x-s*si(r+a),y+s*co(r+a),x-s*si(r-a),y+s*co(r-a))
end
