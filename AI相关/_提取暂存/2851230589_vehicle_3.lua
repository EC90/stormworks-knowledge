-- source: steam id 2851230589 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2851230589
timer=0
out=false
-- Tick function that will be executed every logic tick
function onTick()
	if timer < 5 then
		timer=  timer+1
	else
		timer = 0
		out=not out
	end
	output.setBool(1, out)		-- Write a number to the script's composite output
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(0, 255, 0)			 -- Set draw color to green
	screen.drawCircleF(w / 2, h / 2, 30)   -- Draw a 30px radius circle in the center of the screen
end