-- source: steam id 3603910667 / vehicle.xml block#22
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
-- Tick function that will be executed every logic tick
function onTick()
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)

	-- Check if the player is pressing the rectangle at (10, 10) with width and height of 20px
	nav = isPressed and isPointInRectangle(inputX, inputY, 2, 1, 28, 5)
	nuc = isPressed and isPointInRectangle(inputX, inputY, 2, 7, 28, 5)
	tow = isPressed and isPointInRectangle(inputX, inputY, 2, 13, 28, 5)
	ram = isPressed and isPointInRectangle(inputX, inputY, 2, 19, 28, 5)
	anc = isPressed and isPointInRectangle(inputX, inputY, 2, 25, 28, 5)

	-- Set the composite output, on/off channel 1
	output.setBool(2, nav)
	output.setBool(3, nuc)
	output.setBool(4, tow)
	output.setBool(5, ram)
	output.setBool(6, anc)
end
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(2, 2, 2)			 -- Set draw color to green
	screen.drawClear()
		if nav then
	screen.setColor(5, 5, 5)
	else
	screen.setColor(0, 0, 0)
	end
	screen.drawRectF(2, 1, 28, 5)
		if nuc then
	screen.setColor(5, 5, 5)
	else
	screen.setColor(0, 0, 0)
	end
	screen.drawRectF(2, 7, 28, 5)
		if tow then
	screen.setColor(5, 5, 5)
	else
	screen.setColor(0, 0, 0)
	end
	screen.drawRectF(2, 13, 28, 5)
		if ram then
	screen.setColor(5, 5, 5)
	else
	screen.setColor(0, 0, 0)
	end
	screen.drawRectF(2, 19, 28, 5)
		if anc then
	screen.setColor(5, 5, 5)
	else
	screen.setColor(0, 0, 0)
	end
	screen.drawRectF(2, 25, 28, 5)
end
	

	
