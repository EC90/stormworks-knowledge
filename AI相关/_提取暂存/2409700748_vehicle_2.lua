-- source: steam id 2409700748 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2409700748
-- Tick function that will be executed every logic tick
function onTick()
	value = input.getNumber(1)			 -- Read the first number from the script's composite input
	output.setNumber(1, value * 10)		-- Write a number to the script's composite output
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(4, 4, 4)			 -- Set draw color to green
	screen.drawCircleF(w / 2, h / 2, 30)   -- Draw a 30px radius circle in the center of the screen
end