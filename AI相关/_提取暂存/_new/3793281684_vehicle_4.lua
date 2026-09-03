-- source: steam id 3793281684 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793281684
function onTick()
	value = input.getNumber(1)			 -- Read the first number from the script's composite input
	output.setNumber(1, value * 10)	
	output.setNumber(1, w)
	output.setNumber(2, h)	-- Write a number to the script's composite output
end
function onDraw()
	w = screen.getWidth()				 
	h = screen.getHeight()
	screen.setColor(0, 50, 155)		
	screen.drawCircleF(w/2, h/2, 16)
	screen.setColor(0, 0, 0)
	screen.drawCircleF(w/2, h/2, 5)
end
