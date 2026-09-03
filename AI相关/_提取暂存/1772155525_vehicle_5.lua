-- source: steam id 1772155525 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1772155525
IAS = 0
UNIT = 1
function onTick()
	IAS = input.getNumber(32)
	UNIT = property.getNumber("UNIT")
	strIAS = IAS * UNIT
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(200, 200, 200, 255)
	AHand(IAS/18,16,4)
	screen.drawRectF(w/2 -9, 0, 18, 9)
	screen.setColor(0, 0, 0, 255)
	screen.drawRectF(w/2 -8, 1, 16, 7)
	screen.setColor(200, 200, 200, 255)
	screen.drawTextBox(w/2 -7, 2, 15, 5, string.format("%.0f", strIAS), 0, -1)
end
	
function AHand(NUM,length,width)
	local deg = math.pi * NUM
	width = width/2
	screen.drawTriangleF(w/2 + length * math.sin(deg),
		h/2 - length * math.cos(deg),
		w/2 - width * math.cos(deg),
		h/2 - width * math.sin(deg),
		w/2 + width * math.cos(deg),
		h/2 + width * math.sin(deg))
end