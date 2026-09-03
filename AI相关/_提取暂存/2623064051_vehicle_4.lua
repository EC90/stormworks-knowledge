-- source: steam id 2623064051 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2623064051
-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(0, 255, 0, 150)   -- Set draw color to green
	screen.drawCircle(w/2, h/2-2, 14)   -- Draw a 14px radius circle in the center of the screen
	screen.drawCircle(w/2, h/2-2, 7)   -- Draw a 7px radius circle in the center of the screen
	screen.drawCircle(w/2, h/2-2, 2)   -- Draw a 2px radius circle in the center of the screen
end