-- source: steam id 1962616298 / vehicle.xml block#14
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1962616298
FULLSCALE = -1
RED_LINE = -1
RED_THICK = -1
YELLOW_HI = -1
YELLOW_LO = -1
GREEN_HI = -1
GREEN_LO = -1
WHITE_HI = -1
WHITE_LO = -1
PN = property.getNumber
PI = math.pi
function onTick()
	if FULLSCALE < 0 then FULLSCALE = PN("Full scale speed") end
	if RED_LINE < 0 then RED_LINE = PN("Red Line Speed") end
	if RED_THICK < 0 then RED_THICK = PN("Red Line Thickness") end
	if YELLOW_HI < 0 then YELLOW_HI = PN("Yellow Speed Max") end
	if YELLOW_LO < 0 then YELLOW_LO = PN("Yellow Speed Min") end
	if GREEN_HI < 0 then GREEN_HI = PN("Green Speed Max") end
	if GREEN_LO < 0 then GREEN_LO = PN("Green Speed Min") end
	if WHITE_HI < 0 then WHITE_HI = PN("White Speed Max") end
	if WHITE_LO < 0 then WHITE_LO = PN("White Speed Min") end
end

function SWD(v)
	return -2*PI*v/FULLSCALE
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(0, 0, 0, 255)
	screen.drawClear()
	

	screen.setColor(255, 255, 0, 255)
	ARC(SWD(YELLOW_LO), SWD(YELLOW_HI), w/4, w/3)
	
	screen.setColor(255, 0, 0, 255)
	ARC(SWD(RED_LINE - RED_THICK), SWD(RED_LINE + RED_THICK), w/5, w/2.5)

	screen.setColor(200, 200, 200, 255)
	ARC(SWD(WHITE_LO), SWD(WHITE_HI), w/3.2, w/2.5)
	
	screen.setColor(0, 255, 0, 255)
	ARC(SWD(GREEN_LO), SWD(GREEN_HI), w/4, w/3)
end
	
function ARC(degLO, degHI, inR, outR)
	for deg = degLO, degHI, -math.pi/180 do
		screen.drawLine(w/2 - inR * math.sin(deg),
		 h/2 - inR * math.cos(deg),
		 w/2 - outR * math.sin(deg),
		 h/2 - outR * math.cos(deg))
	end
end