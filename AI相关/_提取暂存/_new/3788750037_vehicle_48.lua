-- source: steam id 3788750037 / vehicle.xml block#48
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
function clamp(x,m,M)
 return M<x and M or m>x and m or x
end
function onTick()
inputX = input.getNumber(3)
inputY = input.getNumber(4)
isPressed = input.getBool(1)
BoxY = input.getNumber(5)
BoxYc=clamp(BoxY,5,49)
C= input.getNumber(6)
Labels=input.getBool(2)
Sync=input.getBool(3)
BrightnessBar = isPressed and isPointInRectangle(inputX, inputY,68,4,5,46)
Label = isPressed and isPointInRectangle(inputX, inputY,5,12,28,8)
SyncOut = isPressed and isPointInRectangle(inputX, inputY,5,29,28,8)
output.setBool(1, BrightnessBar)
output.setBool(2, Label)
output.setBool(3, SyncOut)
end
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
screen.setColor(15,15,18-C)
screen.drawRectF(0,0,96,64)
screen.setColor(14,14,17-C)
screen.drawLine(0,2,96,2)
screen.drawLine(0,4,96,4)
screen.drawLine(0,6,96,6)
screen.drawLine(0,8,96,8)
screen.drawLine(0,10,96,10)
screen.drawLine(0,12,96,12)
screen.drawLine(0,14,96,14)
screen.drawLine(0,16,96,16)
screen.drawLine(0,18,96,18)
screen.drawLine(0,20,96,20)
screen.drawLine(0,22,96,22)
screen.drawLine(0,24,96,24)
screen.drawLine(0,26,96,26)
screen.drawLine(0,28,96,28)
screen.drawLine(0,30,96,30)
screen.drawLine(0,32,96,32)
screen.drawLine(0,34,96,34)
screen.drawLine(0,36,96,36)
screen.drawLine(0,38,96,38)
screen.drawLine(0,40,96,40)
screen.drawLine(0,42,96,42)
screen.drawLine(0,44,96,44)
screen.drawLine(0,46,96,46)
screen.drawLine(0,48,96,48)
screen.drawLine(0,50,96,50)
screen.drawLine(0,52,96,52)
screen.drawLine(0,54,96,54)
screen.drawLine(0,56,96,56)
screen.drawLine(0,58,96,58)
screen.drawLine(0,60,96,60)
screen.drawLine(0,62,96,62)
screen.setColor(8,8,11-C)
screen.drawRectF(62,0,34,64)
screen.setColor(60,60,60)
--x change all here--
screen.drawLine(68,5,73,5)
screen.drawLine(68,49,73,49)
screen.drawLine(69,27,72,27)
screen.drawLine(70,5,70,49)--ok
screen.setColor(100,100,100)
screen.drawText(75,3,"100%")
screen.drawText(76,25,"50%")
screen.drawText(76,48,"0%")
screen.setColor(30,0,0)
screen.drawRectF(68,BoxYc,5,3)
screen.setColor(40,40,40)
screen.drawLine(61,0,61,64)
screen.setColor(100,100,100)
screen.drawText(5, 5, "Labels:")
screen.drawText(5, 22, "Sync:")
screen.setColor(10,10,10)
screen.drawRectF(5,12,28,8)
screen.drawRectF(5,29,28,8)
screen.setColor(9,9,9)
screen.drawText(6, 14, "off")
screen.drawText(22, 14, "on")
screen.drawText(6, 31, "off")
screen.drawText(22, 31, "on")
screen.setColor(8,8,8)
screen.drawRect(5,12,28,8)
screen.drawRect(5,29,28,8)
if Labels then
b1=0
else
b1=14
end
if Sync then
b2=0
else
b2=14
end
screen.setColor(20,0,0)
screen.drawRectF(5+b1,12,15,9)
screen.drawRectF(5+b2,29,15,9)
screen.setColor(15,0,0)
screen.drawLine(8+b1, 14, 8+b1, 19)
screen.drawLine(11+b1, 14, 11+b1, 19)
screen.drawLine(8+b2, 31, 8+b2, 38)
screen.drawLine(11+b2, 31, 11+b2, 38)
end