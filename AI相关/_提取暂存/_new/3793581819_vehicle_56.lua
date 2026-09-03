-- source: steam id 3793581819 / vehicle.xml block#56
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819
-- Tick function that will be executed every logic tick
function onTick()
	r = input.getNumber(1)
	g = input.getNumber(2)
	b = input.getNumber(3)			 -- Read the first number from the script's composite input
			-- Write a number to the script's composite output
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(r, g, b)			 -- Set draw color to green
	screen.drawCircleF(w / 2, h / 2,500)   -- Draw a 30px radius circle in the center of the screen
end