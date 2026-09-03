-- source: steam id 3794618673 / vehicle.xml block#26
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794618673

function onTick()
	tf = input.getBool(1)
	td = input.getNumber(1)
	rcr = input.getNumber(2)
	
	rsz = property.getNumber("Radar Shadow Zone")
	tdd = property.getBool("Display Target Distance")
end

function onDraw()
	w = screen.getWidth()				  
	h = screen.getHeight()
	
	cw = w/2
	ch = h/2
	r = (w+h)/4
	
	x2 = cw + r * math.cos(rcr -1.57) 
	y2 = ch + r * math.sin(rcr -1.57)
	
	x3 = cw + r * math.cos(rcr -1.97) 
	y3 = ch + r * math.sin(rcr -1.97)
	
	x4 = cw + td * math.cos(rcr -1.97) 
	y4 = ch + td * math.sin(rcr -1.97)
	
	screen.setColor(0, 10, 0)
	screen.drawCircleF(cw, ch, r)
	
	screen.setColor(0, 255, 0)
	screen.drawCircle(cw, ch, r)
	
	screen.setColor(0, 40, 0)
	screen.drawCircle(cw, ch, r/1.5)
	screen.drawCircle(cw, ch, r/2.5)
	screen.drawCircle(cw, ch, r/6.5)
	
	screen.drawLine(0, h/2, w, h/2)
	screen.drawLine(w/2, 0, w/2, h)
	
	screen.setColor(0, 30, 0)
	screen.drawTriangleF(cw, ch, x2, y2, x3, y3)
	
	screen.setColor(0, 255, 0)
	screen.drawLine(cw, ch, x2, y2)
	
	if tdd == true then
		screen.setColor(0, 255, 20)
		screen.drawText(2, 2, "TD:" .. td)
	end
	
	if tf == true then
		if td >= rsz then
			
			screen.setColor(0, 255, 10)
			screen.drawCircleF(x4, y4, 2)
			
		end
	end
	
end