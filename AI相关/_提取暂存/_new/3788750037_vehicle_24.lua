-- source: steam id 3788750037 / vehicle.xml block#24
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
function onTick()
inputX = input.getNumber(3)
inputY = input.getNumber(4)
isPressed = input.getBool(1)
label = input.getBool(2)
Radar = input.getBool(3)
C=input.getNumber(5)
RDR= isPressed and isPointInRectangle(inputX, inputY,34, 37, 28, 15)
output.setBool(1, RDR)
end
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
function onDraw()
screen.setColor(14,14,17-C)
screen.drawRectF(0,0,96,64)
if Radar then
screen.setColor(30,30,30)
screen.drawRectF(35, 38, 27, 14)
screen.setColor(20,20,20)
screen.drawCircle(48,45,3)
screen.drawCircle(48,45,6)
screen.drawCircle(48,45,9)
screen.drawCircle(48,45,12)
screen.setColor(60,60,60)
screen.drawRect(34, 37, 28, 15)
if label then
screen.setColor(255,255,255,80)
screen.drawText(42,42,"RDR")
end
if RDR then
screen.setColor(100,100,100)
screen.drawRectF(35, 38, 27, 14)
end
end
screen.setColor(14,14,17-C)
screen.drawRectF(0,0,96,37)
screen.drawRectF(0,53,96,11)
end
