-- source: steam id 3788750037 / vehicle.xml block#27
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
function onTick()
PortTA=input.getNumber(8)
StarboardTA=input.getNumber(9)
BritX=input.getNumber(10)
BritBox=input.getNumber(11)
Heading=input.getNumber(12)
Depth=input.getNumber(13)
Speed=input.getNumber(14)
Distance=input.getNumber(15)
ETA=input.getNumber(16)
L=input.getNumber(17)
PT=input.getNumber(21)
ST=input.getNumber(22)
C=input.getNumber(18)
inputX = input.getNumber(3)
inputY = input.getNumber(4)
isPressed = input.getBool(1)
TAon=input.getBool(2)
AutoPon=input.getBool(3)
TAE=input.getBool(4)
OneT=input.getBool(5)
AutoPonP = isPressed and isPointInRectangle(inputX, inputY,77,58,96,64)
output.setBool(1, isPressingRectangle1)
output.setBool(2, isPressingRectangle2)
output.setBool(3, AutoPonP)
end
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
function onDraw()
screen.setColor(10,10,13-C)
screen.drawRectF(0,0, 96,20)
screen.setColor(8,8,11-C)
screen.drawRectF(0,0,96,9)
screen.setColor(15,15,15)
screen.drawLine(0,20,96,20)
screen.setColor(7,7,10-C)
screen.drawLine(19,0,19,20)
screen.drawLine(38,0,38,20)
screen.drawLine(57,0,57,20)
screen.setColor(100,100,100)
screen.drawText(3,2,"HDG")
screen.drawText(22,2,"SPD")
screen.drawText(41,2,"DPT")
screen.drawText(3,12,string.format("%.0f",Heading))
screen.drawText(22,12,string.format("%.0fK",Speed))
screen.drawText(41,12,string.format("%.0fM",Depth))
if TAon and TAE then
screen.drawText(59,11,"auto")
elseif TAE then
screen.drawText(59,11,"man")
end
if TAE then
screen.drawText(59,2,"trim")
else
screen.drawText(59,2,"Fuel lv")
end
if TAE then
screen.drawRect(80,2,5,14)
screen.drawRect(87,2,5,14)
screen.setColor(0,0,55)
screen.drawRectF(81,16,4, -PortTA)
screen.drawRectF(88,16,4, -StarboardTA)
elseif not OneT then
screen.setColor(100,100,100)
screen.drawRect(59,10,16,8)
screen.drawRect(78,10,16,8)
screen.setColor(0,0,55)
screen.drawRectF(60,18,15,PT)
screen.drawRectF(79,18,15,ST)
elseif OneT then
screen.setColor(100,100,100)
screen.drawRect(59,10,35,8)
screen.setColor(0,0,55)
screen.drawRectF(60,18,34,PT)
end


screen.setColor(20,0,0)
screen.drawRectF(77,58,96,64)
screen.setColor(100,100,100)
screen.drawText(83,59,"AP")
if AutoPon then
screen.setColor(170,170,170)
screen.drawRectF(77,58,96,64)
screen.setColor(0,0,0)
screen.drawText(83,59,"ON")
end
end