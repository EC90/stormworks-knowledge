-- source: steam id 3794583580 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794583580
-- Tick function that will be executed every logic tick
function onTick()
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)

	-- Check if the player is pressing the rectangle at (10, 10) with width and height of 20px
	T1 = isPressed and isPointInRectangle(inputX, inputY, 15, 60, 6, 5)
	
	output.setBool(1, T1)
	
	
	T2 = isPressed and isPointInRectangle(inputX, inputY, 25, 60, 6, 5)
	
	output.setBool(2, T2)



	T3 = isPressed and isPointInRectangle(inputX, inputY, 35, 60, 6, 5)
	
	output.setBool(3, T3)
	
	
	
	T4 = isPressed and isPointInRectangle(inputX, inputY, 45, 60, 6, 5)
	
	output.setBool(4, T4)


end


-- Returns true if the point (x, y) is inside the rectangle at (rectX, rectY) with width rectW and height rectH
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()
						
	screen.setColor(10, 50, 100)			 -- Set draw color to green
	screen.drawRectF(15, 60, 6, 5)
	screen.drawRectF(25, 60, 6, 5) 
	screen.drawRectF(35, 60, 6, 5)
	screen.drawRectF(45, 60, 6, 5)
	
		screen.setColor(5, 5, 6)			 -- Set draw color to green
	screen.drawRect(15, 60, 6, 5)
	screen.drawRect(25, 60, 6, 5) 
	screen.drawRect(35, 60, 6, 5)
	screen.drawRect(45, 60, 6, 5)
		
end
	
