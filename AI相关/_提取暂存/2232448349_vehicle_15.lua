-- source: steam id 2232448349 / vehicle.xml block#15
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2232448349
Compass = 0
HDG = 0

function onTick()
	Compass = input.getNumber(32) * -1
	HDG = math.floor(((360 + Compass) % 1)*360)
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = 30				  -- Get the screen's width and height
	h = 30					
	screen.setColor(0, 0, 0, 255)
	screen.drawRectF(0, 32, 32, 32)
	
	screen.setColor(200, 200, 200, 255)
	
	--mini airplane
	screen.drawLine(w/2,h/2+32-10,w/2,h/2+32+10)
	AHand(0,9,5)
	screen.drawLine(w/2 -3,h/2+32+7,w/2 +4,h/2+32+7)
	screen.drawLine(w/2 -10,h/2+32,w/2 +10,h/2+32)
	

	rMark(math.pi*2*Compass+0.05, 6)
	rMark(math.pi*2*Compass-0.05, 6)
	rMark(math.pi*2*Compass, 6) --north
	
	rMark(math.pi*2*(Compass+0.75), 5) --east
	rMark(math.pi*2*(Compass+0.5), 5) --south
	rMark(math.pi*2*(Compass+0.25), 5) --west
	
	rMark(math.pi*2*(Compass+0.25*1/3), 2) --330
	rMark(math.pi*2*(Compass+0.25*2/3), 2) --300
	
	rMark(math.pi*2*(Compass+0.25+0.25*1/3), 2) --240
	rMark(math.pi*2*(Compass+0.25+0.25*2/3), 2) --210
	
	rMark(math.pi*2*(Compass+0.5+0.25*1/3), 2) --150
	rMark(math.pi*2*(Compass+0.5+0.25*2/3), 2) --120
	
	rMark(math.pi*2*(Compass+0.75+0.25*1/3), 2) --60
	rMark(math.pi*2*(Compass+0.75+0.25*2/3), 2) --30

	screen.drawRectF(w/2 -9, h/2+32 -4, 18, 9)
	screen.setColor(0, 0, 0, 255)
	screen.drawRectF(w/2 -8, h/2+32 -3, 16, 7)
	screen.setColor(200, 200, 200, 255)
	screen.drawTextBox(w/2 -8, h/2+32 -2, 16, 5, string.format("%03.0f", HDG), 0, -1)
	
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
	local deg = math.pi * ALT /5
	width = width/2
	screen.drawTriangleF(w/2 + length * math.sin(deg),
		h/2+32 - length * math.cos(deg),
		w/2 - width * math.cos(deg),
		h/2+32 - width * math.sin(deg),
		w/2 + width * math.cos(deg),
		h/2+32 + width * math.sin(deg))
end