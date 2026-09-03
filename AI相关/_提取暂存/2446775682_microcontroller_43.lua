-- source: steam id 2446775682 / microcontroller.xml block#43
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2446775682
function onTick()

	page = input.getNumber(31)
	osb = input.getNumber(32)
	gpsx = input.getNumber(1)
	gpsy = input.getNumber(2)
	mapx = input.getNumber(4)
	mapy = input.getNumber(5)
	zoom = input.getNumber(6)
	wptx = input.getNumber(29)
	wpty = input.getNumber(30)
	line = input.getBool(20)
	pixelX1, pixelY1 = map.mapToScreen(mapx, mapy, zoom, 64, 64, gpsx, gpsy)
	pixelX2, pixelY2 = map.mapToScreen(mapx, mapy, zoom, 64, 64, wptx, wpty)
	
	
	if page==8 and osb==11 then lne=true else lne=false end
	output.setBool(1, lne)
	
end
function onDraw()
if page==8 then

if line==true then
screen.setColor(200,0,200)
screen.drawLine(pixelX1, pixelY1, pixelX2, pixelY2)
end
screen.setColor(0,0,0)
screen.drawRectF(54, 49, 8, 7)
screen.setColor(0,255,0)
screen.drawText(55, 50, "w")
	screen.setColor(0,0,0)
	screen.drawRectF(3, 9, 8, 7)
	screen.drawRectF(3, 19, 7, 7)
	screen.drawRectF(3, 29, 7, 7)
	screen.drawRectF(3, 39, 7, 7)
	screen.drawRectF(3, 49, 7, 7)	
	screen.drawRectF(54, 9, 8, 7)
	screen.drawRectF(54, 19, 8, 7)
	screen.drawRectF(24, 54, 16, 7)

	
	screen.setColor(0,255,0)
	screen.drawText(5, 10, "<")
	screen.drawText(5, 20, ">")
	screen.drawText(5, 30, "/")
	screen.drawText(5, 40, "V")
	screen.drawText(5, 50, "C")
	screen.drawText(55, 10, "+")
	screen.drawText(55, 20, "-")
	screen.drawText(25, 55, "mnu")
end

if page==9 then
screen.setColor(0,255,0)
screen.drawText(5, 39, "x:"..(string.format("%0.0f", gpsx)))
screen.drawText(5, 49, "y:"..(string.format("%0.0f", gpsy)))
end

end