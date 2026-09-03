-- source: steam id 1962616298 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1962616298
function onTick()
	CH = input.getNumber(1)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(0, 0, 0, 255)
	screen.drawClear()
	screen.setColor(160, 160, 160, 255)			 
	screen.drawText(1, 1, "SD100G")
	screen.drawText(1, 7, "MARINE")
	screen.drawText(3, 14,"RADIO")
	screen.drawText(1, 24,"CH:"..CH)
	screen.drawLine(1, 21, 100, 21)
end