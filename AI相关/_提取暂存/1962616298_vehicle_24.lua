-- source: steam id 1962616298 / vehicle.xml block#24
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1962616298
function onTick()
	-- Read the touchscreen data from the script's composite input
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)
	ZM = input.getNumber(10)

	-- Check if the player is pressing the rectangle at (10, 10) with width and height of 20px
	isPressingRectangle = isPressed and isPointInRectangle(inputX, inputY, 29, 55, 6, 6)
	isPressingRectangle2 = isPressed and isPointInRectangle(inputX, inputY, 37, 55, 6, 6)
	isPressingRectangle3 = isPressed and isPointInRectangle(inputX, inputY, 13, 55, 6, 6)
	isPressingRectangle4 = isPressed and isPointInRectangle(inputX, inputY, 21, 55, 6, 6)
	isPressingRectangle5 = isPressed and isPointInRectangle(inputX, inputY, 45, 55, 6, 6)
	isPressingRectangle6 = isPressed and isPointInRectangle(inputX, inputY, 53, 55, 6, 6)

	-- Set the composite output, on/off channel 1
	output.setBool(1, isPressingRectangle)
	output.setBool(2, isPressingRectangle2)
	output.setBool(3, isPressingRectangle3)
	output.setBool(4, isPressingRectangle4)
	output.setBool(5, isPressingRectangle5)
	output.setBool(6, isPressingRectangle6)
end

-- Returns true if the point (x, y) is inside the rectangle at (rectX, rectY) with width rectW and height rectH
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	screen.setColor(200, 200, 200)
	screen.drawLine((w/2)+2, h/2, (w/2)+6, h/2)
	screen.drawLine((w/2)-2, h/2, (w/2)-6, h/2)
	screen.drawLine(w/2, (h/2)+2, w/2, (h/2)+6)
	screen.drawLine(w/2, (h/2)-2, w/2, (h/2)-6)
	
	screen.drawRect(29, 55, 6, 6) --Left
		screen.drawTextBox(30, 55, 7, 7, "<", 0, 0)
	screen.drawRect(13, 55, 6, 6) --Up
		screen.drawLine(16, 57, 13, 60)
		screen.drawLine(16, 57, 19, 60)
	screen.drawRect(21, 55, 6, 6) --Down
		screen.drawLine(24, 59, 21, 56)
		screen.drawLine(24, 59, 27, 56)
	screen.drawRect(37, 55, 6, 6) --Right
		screen.drawTextBox(38, 55, 7, 7, ">", 0, 0)
	screen.drawRect(45, 55, 6, 6) --(+)
		screen.drawTextBox(46, 55, 7, 7, "+", 0, 0)
	screen.drawRect(53, 55, 6, 6) --(-)
		screen.drawTextBox(54, 55, 7, 7, "-", 0, 0)
	
	screen.drawLine(2, 4, 2, 60)
	screen.drawLine(2, 4, 4, 4)
	screen.drawLine(2, 60, 4, 60)
		screen.setColor(100, 0, 0)
	screen.drawTriangleF(2, 60-ZM, 8, 63-ZM, 8, 57-ZM)
	

end