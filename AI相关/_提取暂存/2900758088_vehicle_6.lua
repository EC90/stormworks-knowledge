-- source: steam id 2900758088 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2900758088
function onTick()
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)

	BRT = isPressed and isPointInRectangle(inputX, inputY, 9, 25, 13, 6)
	LEFT = isPressed and isPointInRectangle(inputX, inputY, 0, 25, 9, 6)
	RIGHT = isPressed and isPointInRectangle(inputX, inputY, 22, 25, 9, 6)
	
	HEAD = input.getNumber(10)

	output.setBool(1, BRT)
	output.setBool(2, LEFT)
	output.setBool(3, RIGHT)
end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
	w = screen.getWidth()				 
	h = screen.getHeight()					
	
	screen.setColor(0, 0, 0)
	screen.drawRectF(0, 25, 32, 10)
	screen.drawRectF(0, 0, 18, 8)
	
	if LEFT then
	screen.setColor(0, 0, 0)
	else
	screen.setColor(2, 2, 2)
	end
		screen.drawRect(0, 25, 9, 6)
	
	if BRT then
	screen.setColor(0, 0, 0)
	else
	screen.setColor(2, 2, 2)
	end	
		screen.drawRect(9, 25, 13, 6)
	
	if RIGHT then
	screen.setColor(0, 0, 0)
	else
	screen.setColor(2, 2, 2)
	end
		screen.drawRect(22, 25, 9, 6)
	
	screen.drawRect(0, h, 1, -2)	
	screen.drawRect(w, h, -2, -2)
	
	screen.setColor(200, 200, 200, 200)
	screen.drawTextBox(2, 25, 8, 7, "+", 0, 0)
	screen.drawTextBox(11, 25, 12, 7, "+-", 0, 0)
	screen.drawTextBox(23, 25, 8, 7, "-", 0, 0)
	screen.drawTextBox(0, 1, 16, 7, string.format("%.0f", HEAD), 1, 0)
	screen.drawTextBox(1, -3, 18, 7, ".", 1, 0)

	
	screen.setColor(5, 5, 5)
	screen.drawRect(0, 0, 18, 8)
end