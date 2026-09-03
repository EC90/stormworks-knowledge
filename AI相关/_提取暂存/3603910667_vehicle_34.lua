-- source: steam id 3603910667 / vehicle.xml block#34
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
-- Tick function that will be executed every logic tick
function onTick()
	value = input.getNumber(1)			 -- Read the first number from the script's composite input
	output.setNumber(1, value * 10)		-- Write a number to the script's composite output
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(0, 255, 0)			 -- Set draw color to green
	screen.drawLine(0, 16, 14, 16)
	screen.drawLine(19, 16, 33, 16)
	screen.drawLine(16, 0, 16, 14)
	screen.drawLine(16, 19, 16, 33)
	
	
end