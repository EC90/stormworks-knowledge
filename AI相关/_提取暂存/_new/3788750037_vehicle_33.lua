-- source: steam id 3788750037 / vehicle.xml block#33
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
function onTick()
inputX = input.getNumber(3)
inputY = input.getNumber(4)
isPressed = input.getBool(1)
isPressingRectangle2 = isPressed and isPointInRectangle(inputX, inputY, 3, 3, 9, 5)
isPressingRectangle1 = isPressed and isPointInRectangle(inputX, inputY, 83, 2, 10, 6)
output.setBool(1, isPressingRectangle1)
output.setBool(2, isPressingRectangle2)
end
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
function onDraw()
screen.setColor(50,50,50)
screen.drawRect(83, 2, 10, 6)
screen.drawRect(2, 2, 10, 6)
screen.setColor(200, 200, 200, 40)
screen.drawRectF(84, 3, 9, 5)
screen.drawRectF(3, 3, 9, 5)
screen.setColor(120, 120, 120, 255)
screen.drawRectF(85, 5, 4, 1)
screen.drawRectF(7, 5, 4, 1)
screen.drawTriangleF(89, 4, 89, 8, 92, 6)
screen.drawTriangleF(4, 6, 7, 8, 7, 4)
screen.drawRectF(5, 4, 1, 1)
screen.drawRectF(5, 6, 1, 1)
end