-- source: steam id 2409700748 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2409700748
-- Tick function that will be executed every logic tick
function onTick()
	value = input.getNumber(1)			 -- Read the first number from the script's composite input
	output.setNumber(1, value * 10)		-- Write a number to the script's composite output
end


function onDraw()
	w = screen.getWidth()			
	h = screen.getHeight()
	
	screen.setColor(225 ,231 ,39 ,100)
		screen.drawCircleF(h / 2, w / 2, 100)
						
	screen.setColor(0.9, 0.9, 0.9, 255)			 
		screen.drawRect(13, 14, 5, 4)
		screen.drawLine(2, 16, 11, 16)
		screen.drawLine(21, 16, 30, 16)
	

	
	
	
end