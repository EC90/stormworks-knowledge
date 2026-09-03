-- source: steam id 1962616298 / vehicle.xml block#13
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1962616298
IAS = 0
UNIT = -1
RED_LINE = -1
RED_THICK = -1
FULLSCALE = -1
function onTick()
	IAS = input.getNumber(32)
	if UNIT < 0 then UNIT = property.getNumber("UNIT") end
	if FULLSCALE < 0 then FULLSCALE = property.getNumber("Full scale speed") end
	if RED_LINE < 0 then RED_LINE = property.getNumber("Red Line Speed") end
	if RED_THICK < 0 then RED_THICK = property.getNumber("Red Line Thickness") end
	sIAS = IAS * UNIT

end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()
	screen.setColor(0, 0, 0, 255)
	AHand(sIAS/FULLSCALE*2,w/2+4,8)			
	screen.setColor(200, 200, 200, 255)
	AHand(sIAS/FULLSCALE*2,w/2,4)
	screen.drawRectF(w/2 -9, 0, 18, 9)
	screen.setColor(0, 0, 0, 255)
	screen.drawRectF(w/2 -8, 1, 16, 7)
	if sIAS >= RED_LINE - RED_THICK then screen.setColor(255, 0, 0, 255) else screen.setColor(200, 200, 200, 255) end
	screen.drawTextBox(w/2 -7, 2, 15, 5, string.format("%.0f", sIAS), 0, -1)
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