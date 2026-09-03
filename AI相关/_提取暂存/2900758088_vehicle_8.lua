-- source: steam id 2900758088 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2900758088
-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(0,128,0)   -- Set draw color to green
	screen.drawCircle(w/2, h/2, 14)   -- Draw a 14px radius circle in the center of the screen
	screen.drawCircle(w/2, h/2, 7)   -- Draw a 7px radius circle in the center of the screen
	screen.drawCircle(w/2, h/2, 2)   -- Draw a 2px radius circle in the center of the screen
	screen.drawLine(0, h/2, w, h/2)   -- Draw a horizontal line through the center of the screen
	screen.drawLine(w/2, 0, w/2, h)   -- Draw a vertical line through the center of the screen
end