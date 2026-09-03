-- source: steam id 3792551514 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792551514
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()					
	screen.setColor(0, 0, 0)
    screen.drawClear()

	screen.setColor(6, 6, 6)
	screen.drawTriangleF(1, (h/2+12), w, h/2, (w/2)+8, (h/2))

	screen.setColor(180, 120, 20)
	screen.drawRect(0, 0, 95, 31)
	
	screen.setColor(110, 60, 4)
	screen.drawRect(1, 1, 93, 29)

	screen.setColor(26, 26, 26)
	screen.drawTextBox(1, -5, w, h, "AB", 0, 0)
	screen.drawTextBox(1, 2, w, h, "MARINE", 0, 0)
	

	
	screen.setColor(180, 120, 20)
	screen.drawTextBox(0, -5, w, h, "AB", 0, 0)
	screen.drawTextBox(0, 2, w, h, "MARINE", 0, 0)
	

end

