-- source: steam id 2232448349 / vehicle.xml block#13
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2232448349
VSI = 0
strUnit = ""
intVSI = 0

function onTick()
	VSI = input.getNumber(32)
	Unit_Type = property.getNumber("UNIT")
	if Unit_Type == 1 then
		intVSI = VSI * 3.28084 * 60 / 1000
		VSI = VSI * 3.28084 *60 / 2000
		strUnit = "x1000ft/m"
	elseif Unit_Type == 2 then
		intVSI = VSI / 10
		VSI = VSI / 20
		strUnit = "x10m/s"
	end
	VSI = math.max(VSI, -1)
	VSI = math.min(VSI, 1)
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = 30				  -- Get the screen's width and height
	h = 30					
	screen.setColor(0, 0, 0, 255)
	screen.drawRectF(0, 32, 32, 32)
	
	if w > 32 and false then
		screen.setColor(160, 160, 160, 255)
		screen.drawTextBox(0, 8+25, w, 5, "ALT", 0, -1)
		screen.drawTextBox(0, 24+25, w, 5, strUnit, 0, 1)
	end
	screen.setColor(200, 200, 200, 255)

	rMark(math.pi * -0.3, 6) --2
	rMark(math.pi * -0.1, 3) --1.5
	rMark(math.pi * 0.1, 6) --1
	rMark(math.pi * 0.3, 3) --0.5
	rMark(math.pi * 0.5, 6) --0
	rMark(math.pi * 0.7, 3) -- -0.5
	rMark(math.pi * 0.9, 6) -- -1
	rMark(math.pi * 1.1, 3) -- -1.5
	rMark(math.pi * 1.3, 6) -- -2

	screen.drawTextBox(0, h/2+32 -2, w, 5, string.format("%.0f", intVSI), 1, 1)

	AHand(VSI,16,5)
	
	screen.drawCircleF(w/2, h/2+32, 3)
	--screen.setColor(0, 0, 0, 255)
	--screen.drawCircleF(w/2, h/2, 2)
	--screen.setColor(0, 200, 0, 255)
	--screen.drawTextBox(0, 0, w, 5, "H="..H, -1, -1)
	--screen.drawTextBox(0, 6, w, 5, "M="..M, -1, -1)
	--screen.drawTextBox(0, 12, w, 5, "S="..S, -1, -1)
end
	
function rMark(deg, length)
	screen.drawLine(w/2 - w/2 * math.sin(deg), h/2+32 - h/2 * math.cos(deg), w/2 - (w/2 - length) * math.sin(deg), h/2+32 - (h/2 - length) * math.cos(deg))
end
	

function AHand(ALT,length,width)
	local deg = -math.pi * (0.5 - ALT *4/5)
	width = width/2
	screen.drawTriangleF(w/2 + length * math.sin(deg),
		h/2+32 - length * math.cos(deg),
		w/2 - width * math.cos(deg),
		h/2+32 - width * math.sin(deg),
		w/2 + width * math.cos(deg),
		h/2+32 + width * math.sin(deg))
end