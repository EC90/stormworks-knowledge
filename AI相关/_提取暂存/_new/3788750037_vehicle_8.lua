-- source: steam id 3788750037 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
	si=math.sin
	co=math.cos
	pi=math.pi
	pi2=pi*2

function onTick()
	GPSX = input.getNumber(17)
	GPSY = input.getNumber(18)
	zoom = input.getNumber(19)
	MAPX = input.getNumber(20)
	MAPY = input.getNumber(21)	
	WPX8 = input.getNumber(2)
	WPY8 = input.getNumber(1)
	WPX7 = input.getNumber(4)
	WPY7 = input.getNumber(3)
	WPX6 = input.getNumber(6)
	WPY6 = input.getNumber(5)
	WPX5 = input.getNumber(8)
	WPY5 = input.getNumber(7)
	WPX4 = input.getNumber(10)
	WPY4 = input.getNumber(9)
	WPX3 = input.getNumber(12)
	WPY3 = input.getNumber(11)
	WPX2 = input.getNumber(14)
	WPY2 = input.getNumber(13)
	WPX1 = input.getNumber(16)
	WPY1 = input.getNumber(15)
	
	WPA1 = input.getBool(1)
	WPA2 = input.getBool(2)
	WPA3 = input.getBool(3)
	WPA4 = input.getBool(4)
	WPA5 = input.getBool(5)
	WPA6 = input.getBool(6)
	WPA7 = input.getBool(7)
	WPA8 = input.getBool(8)
	MPC = input.getBool(9)
	
	WPNUM = input.getNumber(22)
	compass=input.getNumber(23)*pi2*-1
end


function onDraw()
	w = screen.getWidth()				  
	h = screen.getHeight()
	

	screen.setColor(0, 0, 0)
		
	if MPC then
	screen.setColor(200, 200, 200)
	else
	screen.setColor(0, 0, 50)
	end				
	CPX, CPY = map.mapToScreen(MAPX, MAPY, zoom, w, h, GPSX, GPSY)
	WP1PX, WP1PY = map.mapToScreen(MAPX, MAPY, zoom, w, h, WPX1, WPY1)
	WP2PX, WP2PY = map.mapToScreen(MAPX, MAPY, zoom, w, h, WPX2, WPY2)
	WP3PX, WP3PY = map.mapToScreen(MAPX, MAPY, zoom, w, h, WPX3, WPY3)
	WP4PX, WP4PY = map.mapToScreen(MAPX, MAPY, zoom, w, h, WPX4, WPY4)
	WP5PX, WP5PY = map.mapToScreen(MAPX, MAPY, zoom, w, h, WPX5, WPY5)
	WP6PX, WP6PY = map.mapToScreen(MAPX, MAPY, zoom, w, h, WPX6, WPY6)
	WP7PX, WP7PY = map.mapToScreen(MAPX, MAPY, zoom, w, h, WPX7, WPY7)
	WP8PX, WP8PY = map.mapToScreen(MAPX, MAPY, zoom, w, h, WPX8, WPY8)
	
	drawPointer(CPX,CPY,10,compass)	
	if WPA1 then
	screen.drawLine(CPX, CPY, WP1PX, WP1PY)
	screen.drawTextBox(WP1PX, WP1PY, 7, 7,"1", 0, 1)	
	end
	if WPA2 then
	screen.drawLine(WP1PX, WP1PY, WP2PX, WP2PY)
	screen.drawTextBox(WP2PX, WP2PY, 7, 7,"2", 0, 1)	
	end
	if WPA3 then
	screen.drawLine(WP2PX, WP2PY, WP3PX, WP3PY)
	screen.drawTextBox(WP3PX, WP3PY, 7, 7,"3", 0, 1)	
	end
	if WPA4 then
	screen.drawLine(WP3PX, WP3PY, WP4PX, WP4PY)	
	screen.drawTextBox(WP4PX, WP4PY, 7, 7,"4", 0, 1)
	end
	if WPA5 then
	screen.drawLine(WP4PX, WP4PY, WP5PX, WP5PY)
	screen.drawTextBox(WP5PX, WP5PY, 7, 7,"5", 0, 1)	
	end
	if WPA6 then
	screen.drawLine(WP5PX, WP5PY, WP6PX, WP6PY)	
	screen.drawTextBox(WP6PX, WP6PY, 7, 7,"6", 0, 1)
	end
	if WPA7 then
	screen.drawLine(WP6PX, WP6PY, WP7PX, WP7PY)
	screen.drawTextBox(WP7PX, WP7PY, 7, 7,"7", 0, 1)	
	end
	if WPA8 then
	screen.drawLine(WP7PX, WP7PY, WP8PX, WP8PY)	
	screen.drawTextBox(WP8PX, WP8PY, 7, 7,"8", 0, 1)
	end
--	screen.setColor(2, 2, 2)
--	screen.drawRectF(4, 30, 5, 5)	
--	screen.drawRectF(11, 30, 5, 5)	
--	screen.drawRectF(18, 30, 6, 5) --TOP	
--	screen.drawRectF(25, 30, 6, 5) --BOTTOM
--	screen.drawRectF(32, 30, 5, 5) --LEFT	
--	screen.drawRectF(39, 30, 5, 5) --RIGHT
--	screen.drawRectF(46, 30, 6, 5) --RESET
--	screen.drawRectF(53, 30, 6, 5) --CLEAR
	
	if MPC then
	screen.setColor(200, 200, 200)
	else
	screen.setColor(100,100,100)
	end
	screen.setColor(20,20,20)
	screen.drawTextBox(1, 26, 5, 5, "+", 0, 0)
	screen.drawTextBox(1, 31, 5, 5, "-", 0, 0)
	screen.drawTextBox(6, 22, 5, 5, "U", 0, 0)
	screen.drawTextBox(12, 22, 5, 5, "D", 0, 0)
	screen.drawTextBox(18, 22, 5, 5, "<", 0, 0)
	screen.drawTextBox(24, 22, 5, 5, ">", 0, 0)
	screen.drawTextBox(1, 37, 5, 5, "R", 0, 0)
	screen.drawTextBox(1, 45, 5, 5, "c", 0, 0)
end
function drawPointer(x,y,s,r,...)
a=...
a=(a or 30)*pi/360
x=x+s/2*si(r)
y=y-s/2*co(r)
x2=x+100*si(r)
y2=y-100*co(r)
screen.setColor(10,10,10)
screen.drawTriangleF(x,y,x-s*si(r+a),y+s*co(r+a),x-s*si(r-a),y+s*co(r-a))
screen.drawLine(x,y, x2, y2)
end