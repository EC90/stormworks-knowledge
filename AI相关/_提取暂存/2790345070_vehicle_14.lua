-- source: steam id 2790345070 / vehicle.xml block#14
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2790345070
function onTick()
	isPressed = input.getBool(1)
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	freq = input.getNumber(7)
	strength = input.getNumber(8)
	counter = input.getNumber(9)
	
	isPressingRectangle = isPressed and isPointInRectangle(inputX, inputY, 14, 14, 16, 16)
	
	output.setBool(1, isPressingRectangle)
end


function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end


function onDraw()
	screen.setColor(10, 10, 10)
	screen.drawRectF(0, 0, 32, 7)
	screen.setColor(100, 100, 100)
	screen.drawText(4, 1, "Radio")
	
	screen.setColor(255, 0, 0)
	screen.drawText(1, 8, "CH:")
	screen.drawTextBox(12, 8, 20, 5, string.format("%.0f", freq), 0, 0)
	
	--Signal Strength
	if strength > 0 then
		screen.setColor(255, 255, 0)
	else
		screen.setColor(10, 10, 10)
	end
	screen.drawRectF(1, 27, 2, 3)
	
	if strength > 0.25 then
		screen.setColor(255, 255, 0)
	else
		screen.setColor(10, 10, 10)
	end
	screen.drawRectF(4, 25, 2, 5)
	
	if strength > 0.5 then
		screen.setColor(255, 255, 0)
	else
		screen.setColor(10, 10, 10)
	end
	screen.drawRectF(7, 23, 2, 7)
	
	if strength > 0.75 then
		screen.setColor(255, 255, 0)
	else
		screen.setColor(10, 10, 10)
	end
	screen.drawRectF(10, 21, 2, 9)
	
	--Push to Talk
	screen.setColor(10, 10, 10)
	screen.drawRect(14, 14, 16, 16)
	screen.setColor(50, 50, 50)
	screen.drawRectF(15, 15, 15, 15)
	
	if isPressingRectangle == true then
	screen.setColor(255, 255, 0)
	else
	screen.setColor(10, 10, 10)
	end
	screen.drawTriangleF(15, 23, 29, 23, 22, 29)
	screen.drawRectF(20, 27, 5, 2)
	
	if isPressingRectangle == true and counter > 1 and counter <= 4 then
	screen.setColor(255, 255, 0)
	else
	screen.setColor(10, 10, 10)
	end
	--1st Arc
	screen.drawLine(21, 20, 24, 20)
	screen.drawLine(21, 20, 19, 22)
	screen.drawLine(23, 20, 25, 22)
	
	if isPressingRectangle == true and counter > 2 and counter <= 4 then
	screen.setColor(255, 255, 0)
	else
	screen.setColor(10, 10, 10)
	end
	--2nd Arc
	screen.drawLine(20, 18, 25, 18)
	screen.drawLine(20, 18, 17, 21)
	screen.drawLine(24, 18, 27, 21)
	
	if isPressingRectangle == true and counter > 3 and counter <= 4 then
	screen.setColor(255, 255, 0)
	else
	screen.setColor(10, 10, 10)
	end
	--3rd Arc
	screen.drawLine(19, 16, 26, 16)
	screen.drawLine(19, 16, 15, 20)
	screen.drawLine(25, 16, 29, 20)
end