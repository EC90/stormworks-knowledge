-- source: steam id 2232448349 / vehicle.xml block#20
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2232448349
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(20, 20, 20)			 -- Set draw color to green
	screen.drawLine(32, 0, 32, 64)   -- Draw a 30px radius circle in the center of the screen
	screen.drawLine(0, 32, 64, 32)
	
	screen.setColor(0, 0, 0)
	screen.drawRectF(33, 33, 32, 32)
end