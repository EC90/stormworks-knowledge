-- source: steam id 2046605849 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2046605849
CPx = {}
for i = 1, 60 do
	CPx[i] = 0
end
Slip = 0
function onTick()
	CP_1 = input.getNumber(31)
	Slip = input.getNumber(32)
	
	CP_1 = CP_1 * -360
	CP_1 = math.max(CP_1, -0.2)
	CP_1 = math.min(CP_1, 0.2)
	Slip = math.max(Slip, -10)
	Slip = math.min(Slip, 10)
	
	for i = 60, 2, -1 do
		CPx[i] = CPx[i-1]
	end
	CPx[1] = CP_1
	
	CP = 0
	for i = 60, 1, -1 do
		CP = CP + CPx[i]
	end
	CP = CP / 60
	
	
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()				
	screen.setColor(0, 0, 0, 255)
	screen.drawClear()
		
	screen.setColor(200, 200, 200, 255)
	screen.drawRect(w/2 -8, h-6, 16, 6)
	screen.drawCircleF(w/2 + Slip*8/10, h-3, 2)
	
	
	rMark(math.pi * 0.5, 3)	
	rMark(math.pi * 0.6, 3)	
	rMark(math.pi * 1.4, 3)
	rMark(math.pi * 1.5, 3)		
	
	--mini airplane
	AHand(0.5 +CP,5,27)
	AHand(0 +CP,5,3)
	--screen.drawLine(w/2+1 -4 * math.cos(math.pi*(CP+0.1)),
	--	h/2 -4 * math.sin(math.pi*(CP+0.1)),
	--	w/2+1 +4 * math.cos(math.pi*(CP-0.1)),
	--	h/2 +4 * math.sin(math.pi*(CP-0.1)))
	
	--screen.drawText(1, 1, CP*180)
end
	
function AHand(NUM,length,width)
	local deg = math.pi * 2 * NUM
	width = width/2
	screen.drawTriangleF(w/2 + length * math.sin(deg),
		h/2 - length * math.cos(deg),
		w/2 - width * math.cos(deg),
		h/2 - width * math.sin(deg),
		w/2 + width * math.cos(deg),
		h/2 + width * math.sin(deg))
end
		
function rMark(deg, length)
	screen.drawLine(w/2 - w/2 * math.sin(deg), h/2 - h/2 * math.cos(deg), w/2 - (w/2 - length) * math.sin(deg), h/2 - (h/2 - length) * math.cos(deg))
end