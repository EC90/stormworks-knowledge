-- source: steam id 3790163661 / vehicle.xml block#11
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3790163661
-- Tick function that will be executed every logic tick
function onTick()
	inVal = input.getNumber(1)
	x = input.getNumber(2)
	y = input.getNumber(3)
	min = input.getNumber(4)
	max = input.getNumber(5)
	rad = input.getNumber(6)
	Humd = (input.getNumber(7)*100)
	fac = factor()
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()

	w= screen.getWidth()
	h = screen.getHeight()
	cx = x
	cy = y + rad
	screen.setColor(100, 100, 100)
	screen.drawClear()
		screen.setColor(0, 0, 200) --green
			screen.drawTriangleF(cx, cy, 2, cy, 4, 8)
		screen.setColor(0, 200, 0) --blue
			screen.drawTriangleF(cx, cy, 4, 8, 10, 3)
			screen.drawTriangleF(cx, cy, 15, 2, 10, 4)
			screen.drawTriangleF(cx, cy, 20, 4, 15, 2)
			screen.drawTriangleF(cx, cy, 20, 3, 26, 8)
		screen.setColor(200, 0, 0) --red
			screen.drawTriangleF(cx, cy, 29, cy, 26, 8)
	
	screen.setColor(5, 5, 5)
	drawDialFace()
	
	screen.setColor(5, 5, 5)
	angle = math.pi * (1 - fac)
	p0x = cx + math.cos(angle) * rad * 0.9
	p0y = cy - math.sin(angle) * rad * 0.9
	screen.drawLine(cx, cy, p0x, p0y)
	
	screen.setColor(5, 5, 5)		
	screen.drawLine(0, 18, 32, 18)
	screen.drawLine(16, 18, 16, 32)
	screen.drawTextBox(0, 19, 16, 8, "T", 0, 0)
	screen.drawTextBox(w/2, 19, 16, 8, "H", 0, 0)
	screen.drawTextBox(1, 25, 16, 8,  string.format("%01.0fc", inVal), -1, 0)
	screen.drawTextBox(w/2, 25, 16, 8,  string.format("%01.0f%%", Humd), 0, 0)
	
end
	
function drawDialFace()
	screen.drawLine(x + rad, y + rad, x - rad, y + rad)
	
	angle = 0
	step = math.pi / 4
	
	for i = 0, 3, 1 do
		p0x = cx + math.cos(angle) * rad
		p0y = cy - math.sin(angle) * rad
		p1x = cx + math.cos(angle + step) * rad
		p1y = cy - math.sin(angle + step) * rad
		
		screen.drawLine(p0x, p0y, p1x, p1y)
		angle = angle + step
	end
end
function factor()
	range = max - min
	
	if range > 0 then
		return (inVal - min) / (max - min)
	else
		return 0
	end
end		