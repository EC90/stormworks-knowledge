-- source: steam id 1962616298 / vehicle.xml block#12
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1962616298
ALT = 0
I_ALT = 0
strUnit = ""
H = 0
M = 0
S = 0
function onTick()
	ALT = input.getNumber(32)
	Unit_Type = property.getNumber("UNIT")
	
	if Unit_Type == 1 then
		I_ALT = math.floor(ALT * 3.28084)
		ALT = ALT * 3.28084 / 100
		strUnit = "x100ft"

	elseif Unit_Type == 2 then
		I_ALT = math.floor(ALT)
		ALT = ALT / 10
		strUnit = "x10m"
	end
	H = math.floor(10 * (ALT % 1000) / 100) / 10
	M = math.floor(10 * (ALT % 100) / 10) / 10
	S = math.floor(10 * (ALT % 10)) / 10
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(0, 0, 0, 255)
	screen.drawClear()
	
	if w > 32 then
		screen.setColor(160, 160, 160, 255)
		screen.drawTextBox(0, 8, w, 5, "ALT", 0, -1)
		screen.drawTextBox(0, 24, w, 5, strUnit, 0, 1)
	end
	
	screen.setColor(200, 200, 200, 255)
	rMark(0, 4)
	rMark(math.pi * 0.2, 4)
	rMark(math.pi * 0.4, 4)
	rMark(math.pi * 0.6, 4)
	rMark(math.pi * 0.8, 4)
	rMark(math.pi, 4)
	rMark(math.pi * 1.2, 4)
	rMark(math.pi * 1.4, 4)
	rMark(math.pi * 1.6, 4)
	rMark(math.pi * 1.8, 4)
	
	--AHand(H,8,6)
	--AHand(M,12,4)
	--AHand(S,16,2)
	AHand(S,16,4)
	
	screen.drawCircleF(w/2, h/2, 3)
	
	screen.setColor(160, 0, 0, 255)
	ATip(S,w/2-4,18,5)
	
	screen.setColor(0, 0, 0, 255)
	screen.drawRectF(w/2 -13, h/2 -3, 26, 8)
	
	screen.setColor(200, 200, 200, 255)
	screen.drawRect(w/2 -14, h/2 -4, 27, 8)
	screen.drawTextBox(w/2 -12, h/2 -2, 25, 7, string.format("%05.0f", I_ALT), -1, -1)
	--screen.drawCircleF(w/2, h/2, 2)
	--screen.setColor(0, 200, 0, 255)
	--screen.drawTextBox(0, 0, w, 5, "H="..H, -1, -1)
	--screen.drawTextBox(0, 6, w, 5, "M="..M, -1, -1)
	--screen.drawTextBox(0, 12, w, 5, "S="..S, -1, -1)
end
	
function rMark(deg, length)
	screen.drawLine(w/2 - w/2 * math.sin(deg), h/2 - h/2 * math.cos(deg), w/2 - (w/2 - length) * math.sin(deg), h/2 - (h/2 - length) * math.cos(deg))
end
	

function AHand(ALT,length,width)
	local deg = math.pi * ALT /5
	width = width/2
	screen.drawTriangleF(w/2 + length * math.sin(deg),
		h/2 - length * math.cos(deg),
		w/2 - width * math.cos(deg),
		h/2 - width * math.sin(deg),
		w/2 + width * math.cos(deg),
		h/2 + width * math.sin(deg))
end
		
function ATip(ALT,arm,length,width)
	local deg = math.pi * ALT /5
	local ddeg = math.pi * width/180
	width = width/2
	screen.drawTriangleF(w/2 + length * math.sin(deg),
		h/2 - length * math.cos(deg),
		w/2 + arm * math.sin(deg+ddeg),
		h/2 - arm * math.cos(deg+ddeg),
		w/2 + arm * math.sin(deg-ddeg),
		h/2 - arm * math.cos(deg-ddeg))
end