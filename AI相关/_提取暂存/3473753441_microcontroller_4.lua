-- source: steam id 3473753441 / microcontroller.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3473753441
-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()
	screen.setColor(0,0,0)
	screen.drawLine(h/6+w/2, h/2, h/18+w/2, h/2)
	screen.drawLine(-h/6+w/2, h/2, -h/18+w/2, h/2)
	screen.drawLine(h/18+w/2, h/2, w/2, h/18+h/2)
	screen.drawLine(-h/18+w/2, h/2, 1+w/2, 1+h/18+h/2)
	screen.drawCircleF(w/2, h/2, h/55)
end