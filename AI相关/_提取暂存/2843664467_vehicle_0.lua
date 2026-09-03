-- source: steam id 2843664467 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2843664467

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(0, 250, 0)			 -- Set draw color to green
screen.drawLine(w/2-10, h/2, w/2+10, h/2)
screen.drawLine(w/2, h/2-10, w/2, h/2+10)
end