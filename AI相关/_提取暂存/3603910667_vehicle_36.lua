-- source: steam id 3603910667 / vehicle.xml block#36
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667

function onTick()
	h1 = input.getBool(1)
	h2 = input.getBool(2)
	h3 = input.getBool(3)
	h4 = input.getBool(4)
	h5 = input.getBool(5)
	h6 = input.getBool(6)
	h7 = input.getBool(7)
	h8 = input.getBool(8)
	h9 = input.getBool(9)
	
	r1 = input.getBool(10)
	r2 = input.getBool(11)
	r3 = input.getBool(12)
	r4 = input.getBool(13)
	r5 = input.getBool(14)
	r6 = input.getBool(15)
	
	w1 = input.getBool(16)
	w2 = input.getBool(17)
	w3 = input.getBool(18)
	w4 = input.getBool(19)
	w5 = input.getBool(20)
	w6 = input.getBool(21)
	w7 = input.getBool(22)
	w8 = input.getBool(23)
	w9 = input.getBool(24)
	w10 = input.getBool(25)
	w11 = input.getBool(26)
	w12 = input.getBool(27)
	w13 = input.getBool(28)
	
	t = input.getNumber(1)
	temp = input.getNumber(2)
	
	tempr = input.getBool(32)
	timer = input.getBool(31)
	timeam = input.getBool(30)
	
	r = input.getNumber(30)
	g = input.getNumber(31)
	b = input.getNumber(32)
	
	br = input.getNumber(27)
	bg = input.getNumber(28)
	bb = input.getNumber(29)
	
	time = math.floor(t) + 0.60*(t-math.floor(t))
end


function onDraw()
	w = screen.getWidth()				
	h = screen.getHeight()					
	screen.setColor(br, bg, bb)			
	screen.drawClear()
	
		
	screen.setColor(r, g, b)
	screen.drawRectF(0, 0, 64, 7)--WEATHER BOX
	if tempr then
	screen.drawText(60, 9, "f")
	else
	screen.drawText(60, 9, "c")	
	end
	
	if timer then
		if timeam then
		screen.drawTextBox(0, 9, 64, 7, string.format("%.2fPM", time), -1, -1)
		else
		screen.drawTextBox(0, 9, 64, 7, string.format("%.2fAM", time), -1, -1)
		end
	else
	screen.drawTextBox(0, 9, 64, 7, string.format("%.2f", time), -1, -1)
	end
		
	
	screen.drawTextBox(0, 9, 60, 7, string.format("%.0f'", temp), 1, -1)
	screen.drawLine(0, 50, 64, 50) --LINE ABOVE VIS
	screen.drawTextBox(1, 52, 64, 7, "VISIBILITY:", 0, -1)
	--humdity
	if h1 then
	screen.drawTextBox(1, 58, 64, 7, "EXCP CLEAR", 0, -1)	
	end
	if h2 then
	screen.drawTextBox(1, 58, 64, 7, "VERY CLEAR", 0, -1)	
	end
	if h3 then
	screen.drawTextBox(1, 58, 64, 7, "CLEAR", 0, -1)	
	end
	if h4 then
	screen.drawTextBox(1, 58, 64, 7, "HAZE", 0, -1)	
	end
	if h5 then
	screen.drawTextBox(1, 58, 64, 7, "THIN FOG", 0, -1)	
	end
	if h6 then
	screen.drawTextBox(1, 58, 64, 7, "LIGHT FOG", 0, -1)	
	end
	if h7 then
	screen.drawTextBox(1, 58, 64, 7, "MODERATE FOG", 0, -1)	
	end
	if h8 then
	screen.drawTextBox(1, 58, 64, 7, "THICK FOG", 0, -1)	
	end
	if h9 then
	screen.drawTextBox(1, 58, 64, 7, "DENSE FOG", 0, -1)	
	end
	--rain
	if r1 then
	screen.drawTextBox(1, 16, 64, 7, "NO RAIN", 0, -1)	
	end
	if r2 then
	screen.drawTextBox(1, 16, 64, 7, "DRIZZLE", 0, -1)	
	end
	if r3 then
	screen.drawTextBox(1, 16, 64, 7, "SHOWER", 0, -1)	
	end
	if r4 then
	screen.drawTextBox(1, 16, 64, 7, "RAIN", 0, -1)	
	end
	if r5 then
	screen.drawTextBox(1, 16, 64, 7, "DOWNPOUR", 0, -1)	
	end
	if r6 then
	screen.drawTextBox(1, 16, 64, 7, "FLOOD", 0, -1)	
	end	

	--wind
	if w1 then
	screen.drawTextBox(1, 23, 64, 7, "CALM", 0, -1)	
	end
	if w2 then
	screen.drawTextBox(1, 23, 64, 7, "LIGHT AIR", 0, -1)	
	end
	if w3 then
	screen.drawTextBox(1, 23, 64, 7, "LIGHT BREEZE", 0, -1)	
	end
	if w4 then
	screen.drawTextBox(1, 23, 64, 7, "GENTLE BREEZE", 0, -1)	
	end
	if w5 then
	screen.drawTextBox(1, 23, 64, 7, "MODERATE BREEZE", 0, -1)	
	end
	if w6 then
	screen.drawTextBox(1, 23, 64, 7, "FRESH BREEZE", 0, -1)	
	end
	if w7 then
	screen.drawTextBox(1, 23, 64, 7, "STRONG BREEZE", 0, -1)	
	end
	if w8 then
	screen.drawTextBox(1, 23, 64, 7, "MODERATE GALE", 0, -1)	
	end
	if w9 then
	screen.drawTextBox(1, 23, 64, 7, "FRESH GALE", 0, -1)	
	end
	if w10 then
	screen.drawTextBox(1, 23, 64, 7, "STRONG GALE", 0, -1)	
	end
	if w11 then
	screen.drawTextBox(1, 23, 64, 7, "WHOLE GALE", 0, -1)	
	end
	if w12 then
	screen.drawTextBox(1, 23, 64, 7, "**STORM**", 0, -1)	
	end
	if w13 then
	screen.drawTextBox(1, 23, 64, 7, "*HURRICANE*", 0, -1)	
	end
	
	screen.setColor(br, bg, bb)
	screen.drawTextBox(0, 1, 64, 7, "WEATHER", 0, -1)
end