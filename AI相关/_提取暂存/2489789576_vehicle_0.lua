-- source: steam id 2489789576 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2489789576
z=0.5
function onTick()
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)
	x = input.getNumber(5)
	y = input.getNumber(6)
	x1 = input.getNumber(7)
	y1 = input.getNumber(8)
	x2 = input.getNumber(9)
	y2 = input.getNumber(10)
	x3 = input.getNumber(11)
	y3 = input.getNumber(12)
	isPlus = isPressed and isPointInRectangle(inputX, inputY, 0, 7, 8, 8)
	isMinus = isPressed and isPointInRectangle(inputX, inputY, 0, 16, 8, 8)
end
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
function onDraw()
	if isMinus then
	z=z*1.02
	end
	if isPlus then
	z=z*0.98
	end
	screen.drawMap(x, y, z)
	width = screen.getWidth()
	height = screen.getHeight()
	screen.setColor(255, 0, 0)
	screen.drawTriangle(width/2+x1, height/2+y1, width/2+x2, height/2+y2, width/2+x3, height/2+y3)
	screen.drawText(1, 7, "+")
	screen.drawText(1, 16, "-")
	--screen.drawText(6, 1, z)
end