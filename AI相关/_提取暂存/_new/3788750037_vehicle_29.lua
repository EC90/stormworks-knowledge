-- source: steam id 3788750037 / vehicle.xml block#29
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
function onTick()
inputX = input.getNumber(3)
inputY = input.getNumber(4)
isPressed = input.getBool(1)
Label = input.getBool(2)
Radar = input.getBool(3)
C=input.getNumber(5)
NAV = isPressed and isPointInRectangle(inputX, inputY,3, 18, 28, 15)
FUEL = isPressed and isPointInRectangle(inputX, inputY,34, 18, 28, 15)
CCTV = isPressed and isPointInRectangle(inputX, inputY,51+o, 37, 28, 15)
ENG = isPressed and isPointInRectangle(inputX, inputY,65, 18, 28, 15)
DPTH = isPressed and isPointInRectangle(inputX, inputY,17-o, 37, 28, 15)
Settings = isPressed and isPointInRectangle(inputX, inputY,31,57,36,7)
output.setBool(1, NAV)
output.setBool(2, FUEL)
output.setBool(3, ENG)
output.setBool(4, DPTH)
output.setBool(6, CCTV)
output.setBool(7, Settings)
end
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
function onDraw()
if Radar then
o=14
else
o=0
end
screen.drawRectF(4,35,27,3)
screen.setColor(10,10,13-C)
screen.drawRectF(0,0,96,10)
screen.drawRectF(32,10,32,4)
screen.drawTriangleF(22,10,32,10,32,15)
screen.drawTriangleF(74,10,64,10,64,15)
screen.setColor(8,8,11-C)
screen.drawLine(0,10,23,10)
screen.drawLine(73,10,96,10)
screen.drawLine(23,10,32,14)
screen.drawLine(73,10,64,14)
screen.drawLine(32,14,65,14)
screen.setColor(4,4,4)
screen.drawLine(0,55,96,55)
screen.setColor(100,100,100)
screen.drawText(34,4,"Garmin")

screen.setColor(30,30,30)
screen.drawRectF(18-o,38,27,14)
screen.setColor(20,20,20)
screen.drawCircleF(31-o,38,2)
screen.drawCircle(31-o,38,5)
screen.drawCircle(31-o,38,8)
screen.drawCircle(31-o,38,11)
screen.setColor(14,14,17-C)
screen.drawRectF(18-o,15,27,23)

screen.setColor(60,60,60)
screen.drawRect(3, 18, 28, 15)
screen.drawRect(34, 18, 28, 15)
screen.drawRect(65, 18, 28, 15)
screen.drawRect(17-o, 37, 28, 15)

screen.drawRect(51+o, 37, 28, 15)
screen.setColor(6,6,6)
screen.drawRectF(0,56,96,10)
screen.setColor(30,30,30)

screen.drawRectF(4,19,27,14)
screen.drawRectF(35,19,27,14)
screen.drawRectF(66,19,27,14)
screen.drawRectF(52+o,38,27,14)

screen.setColor(20,20,20)
screen.drawRectF(4,19,7,5)
screen.drawRectF(4,19,10,3)
screen.drawRectF(4,19,5,6)
screen.drawRectF(4,19,11,2)
screen.drawRectF(14,26,13,7)
screen.drawRectF(21,23,10,7)
screen.drawRectF(8,29,13,4)
screen.drawRectF(11,28,13,4)
screen.drawRectF(7,30,13,3)
screen.drawRectF(16,27,13,4)
screen.drawRectF(19,24,3,2)
screen.drawRectF(45,22,7,10)
screen.drawLine(46,20,51,20)
screen.drawRectF(50,21,1,1)
screen.drawRectF(46,21,1,1)
screen.drawRectF(43,23,2,2)

screen.drawRectF(59+o,40,9,9)
screen.drawRectF(68+o,41,1,6)
screen.drawRectF(69+o,40,2,9)

screen.drawLine(72,22,72,28)
screen.drawLine(72,22,81,22)
screen.drawLine(72,28,74,28)
screen.drawLine(74,28,76,30)
screen.drawLine(76,30,76,30)
screen.drawLine(76,30,84,30)
screen.drawLine(81,22,83,24)
screen.drawLine(83,24,84,24)
screen.drawLine(84,24,84,26)
screen.drawLine(84,30,84,28)
screen.drawLine(84,26,86,26)
screen.drawLine(84,28,86,28)
screen.drawLine(86,26,86,24)
screen.drawLine(87,24,88,26)
screen.drawLine(86,28,86,30)
screen.drawLine(87,30,88,28)
screen.drawLine(77,22,77,20)
screen.drawLine(74,20,81,20)
screen.drawLine(72,25,70,25)
screen.drawLine(70,22,70,29)

screen.setColor(15,15,15)
screen.drawRectF(18-o,43,9,9)
screen.drawRectF(27-o,45,9,7)
screen.drawRectF(36-o,46,9,6)
screen.setColor(100,100,100)
screen.drawLine(46,25,51,30)
screen.drawLine(46,29,51,24)
screen.setColor(255,255,255,80)
if Label then
screen.drawText(39,23,"Fuel")
screen.drawText(11,23,"NAV")
screen.drawText(56+o,42,"CCTV")
screen.drawText(22-o,42,"DPTH")
screen.drawText(73,23,"ENG")
end
screen.setColor(100,100,100)
if NAV then
screen.drawRectF(4,19,27,14)
end
if FUEL then
screen.drawRectF(35,19,27,14)
end
if CCTV then
screen.drawRectF(52+o,38,27,14)
end
if ENG then
screen.drawRectF(66, 19, 27, 14)
end
if DPTH then
screen.drawRectF(18-o, 38, 27, 14)
end
screen.setColor(20,20,20)
screen.drawRectF(31,57,36,7)
screen.setColor(100,100,100)
screen.drawText(32,58,"Setting")
screen.setColor(15,15,15)
screen.drawRect(30,56,37,8)
end