-- source: steam id 3792235232 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792235232
targets = {} --creates table to store radar targets
targetstime = {} 
pi = math.pi --shorthand for math.pi


function onTick()
	
	BR = property.getNumber("BackroundR")
	BG = property.getNumber("BackroundG")
	BB = property.getNumber("BackroundB")
	TR = property.getNumber("TextR")
	TG = property.getNumber("TextG")
	TB = property.getNumber("TextB")
	TGTR = property.getNumber("TargetR")
	TGTG = property.getNumber("TargetG")
	TGTB = property.getNumber("TargetB")	
	
	w = input.getNumber(2) --user defined screen width
	h = input.getNumber(3) --user defined screen hieght
	r = h/2 --screen radius
	c1 = (r/5)*1 --screen radius
	c2 = (r/5)*2 --screen radius
	c3 = (r/5)*3 --screen radius
	c4 = (r/5)*4 --screen radius
	
	t = input.getBool(11) --target is detected
	d = input.getNumber(6) --distane of target
	rg = input.getNumber(7) --desired radar range
	dad = (d/rg)*r --distance/max*radius
	on = input.getBool(1) --radar on or off
	rdrspd = (100 - input.getNumber(10)) * 6
	
	radarrot = input.getNumber(8) --radar rotation
	
	if on then --only turns and detects if radar is on
		
		angrdr = radarrot*6.2832
	
		x1 = w/2 + r * math.cos(angrdr-1.5708) --finds point to draw radar that rotates
		y1 = h/2 + r * math.sin(angrdr-1.5708)
		
		x10 = w/2 + r * math.cos(angrdr-1.74533) --finds point to draw radar that rotates (Shadow 1)
		y10 = h/2 + r * math.sin(angrdr-1.74533)
		
		x11 = w/2 + r * math.cos(angrdr-1.91986) --finds point to draw radar that rotates (Shadow 2)
		y11 = h/2 + r * math.sin(angrdr-1.91986)		
		
		
		x3 = w/2 + dad * math.cos(angrdr-1.5708) --finds point to draw radar target
		y3 = h/2 + dad * math.sin(angrdr-1.5708)
	
		if t then --adds targets to table for each target found
			if d <= rg then
			time = 0
			targets[x3] = y3 --stores x and y points in table
			targetstime[x3] = time --stores x and y points in table
			end
		end
		
		for x3,time in pairs(targetstime) do
		targetstime[x3] = time + 1
		if time >= rdrspd then
		targets[x3] = nil
		targetstime[x3] = nil
		end
		end
	
	end
end


function onDraw()
	
	screen.setColor(BR, BG, BB)
	screen.drawClear()
	
	screen.setColor(TR, TG, TB) --sets screen color to green			
	screen.drawCircle(w/2, h/2, r) --draws a outside circle the size of the screen
	screen.setColor(TR, TG, TB, 30) --sets screen color to green
	screen.drawCircle(w/2, h/2, c1) --draws a circle 1 the size of the screen
	screen.drawCircle(w/2, h/2, c2) --draws a circle 2 the size of the screen
	screen.drawCircle(w/2, h/2, c3) --draws a circle 3 the size of the screen
	screen.drawCircle(w/2, h/2, c4) --draws a circle 4 the size of the screen
	
	screen.drawLine(w/2-r, h/2, w/2+r, h/2) --draws the line left to right
	screen.drawLine(w/2, h/2-r, w/2, h/2+r) --draws the line top to bottom
	
	
	
	screen.setColor(TR, TG, TB) --sets screen color to green
	screen.drawTextBox(1, 1, 20, 8, string.format("%#0d",rg), -1, -1) --displays the max range of radar
	screen.drawLine(w/2, h/2, x1, y1) --draws the line of radar that rotates
	
	screen.setColor(TR, TG, TB, 150) --sets screen color to green (Shadow 1)
	screen.drawTriangleF(w/2, h/2, x10, y10, x1, y1) --draws the line of radar that rotates
	
	screen.setColor(TR, TG, TB, 100) --sets screen color to green (Shadow 2)
	screen.drawTriangleF(w/2, h/2, x10, y10, x11, y11) --draws the line of radar that rotates
	

	for x4, y4 in pairs(targets) do --reads the table of targets
		screen.setColor(TGTR, TGTG, TGTB) --sets the screen color to red
		screen.drawCircleF(x4,y4,1) --draws a dot/circle at target location on radar
	end
end