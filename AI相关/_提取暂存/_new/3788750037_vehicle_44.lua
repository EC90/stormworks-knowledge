-- source: steam id 3788750037 / vehicle.xml block#44
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
function onTick()
PBat=input.getNumber(12)
SBat=input.getNumber(13)
PTrim=input.getNumber(14)
STrim=input.getNumber(15)
T3=input.getNumber(16)
inputX = input.getNumber(3)
inputY = input.getNumber(4)
isPressed = input.getBool(1)
Max=input.getNumber(9)
C=input.getNumber(17)
BtoT = isPressed and isPointInRectangle(inputX, inputY, 2, 28, 25,30)
output.setBool(1,BtoT)
TwoEng = input.getBool(4)
TrimPresentandOn= input.getBool(5)
end
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
function onDraw()
screen.setColor(60,60,60)
screen.drawTextBox(69,28,25,8,"Temp",0,1)

screen.setColor(60,60,60)
screen.drawLine(48,45,48+((7)*math.cos(((T3/1)-2.02)*2.3)), 44+((7)*math.sin(((T3/1)-2.02)*2.3)))
screen.drawLine(48,43,48+((7)*math.cos(((T3/1)-2.02)*2.3)), 44+((7)*math.sin(((T3/1)-2.02)*2.3)))
screen.drawLine(47,44,47+((7)*math.cos(((T3/1)-2.02)*2.3)), 44+((7)*math.sin(((T3/1)-2.02)*2.3)))
screen.drawLine(49,44,49+((7)*math.cos(((T3/1)-2.02)*2.3)), 44+((7)*math.sin(((T3/1)-2.02)*2.3)))
screen.setColor(90,90,90)
screen.drawLine(48,44,48+((7)*math.cos(((T3/1)-2.02)*2.3)), 44+((7)*math.sin(((T3/1)-2.02)*2.3)))

if TrimPresentandOn then
screen.setColor(60,60,60)
screen.drawTextBox(2,28,25,8,"Trim",0,1)
screen.setColor(0,30,0)
screen.drawLine(10,46,10+((6)*math.cos(((STrim/1)-4.96)*4.575)), 47+((6)*math.sin(((STrim/1)-4.96)*4.575)))
screen.drawLine(10,48,10+((6)*math.cos(((STrim/1)-4.96)*4.575)), 47+((6)*math.sin(((STrim/1)-4.96)*4.575)))
screen.drawLine(9,47,10+((6)*math.cos(((STrim/1)-4.96)*4.575)), 47+((6)*math.sin(((STrim/1)-4.96)*4.575)))
screen.drawLine(11,47,10+((6)*math.cos(((STrim/1)-4.96)*4.575)), 47+((6)*math.sin(((STrim/1)-4.96)*4.575)))

screen.setColor(0,70,0)
screen.drawLine(10,47,10+((6)*math.cos(((STrim/1)-4.96)*4.575)), 47+((6)*math.sin(((STrim/1)-4.96)*4.575)))

screen.setColor(30,0,0)
screen.drawLine(10,46,10+((6)*math.cos(((PTrim/1)-4.96)*4.575)), 47+((6)*math.sin(((PTrim/1)-4.96)*4.575)))
screen.drawLine(10,48,10+((6)*math.cos(((PTrim/1)-4.96)*4.575)), 47+((6)*math.sin(((PTrim/1)-4.96)*4.575)))
screen.drawLine(9,47,10+((6)*math.cos(((PTrim/1)-4.96)*4.575)), 47+((6)*math.sin(((PTrim/1)-4.96)*4.575)))
screen.drawLine(11,47,10+((6)*math.cos(((PTrim/1)-4.96)*4.575)), 47+((6)*math.sin(((PTrim/1)-4.96)*4.575)))

screen.setColor(70,0,0)
screen.drawLine(10,47,10+((6)*math.cos(((PTrim/1)-4.96)*4.575)), 47+((6)*math.sin(((PTrim/1)-4.96)*4.575)))
else
end
if TwoEng and not TrimPresentandOn then
screen.setColor(0,30,0)
screen.drawLine(10,46,10+((6)*math.cos(((SBat/1)-4.96)*4.575)), 47+((6)*math.sin(((SBat/1)-4.96)*4.575)))
screen.drawLine(10,48,10+((6)*math.cos(((SBat/1)-4.96)*4.575)), 47+((6)*math.sin(((SBat/1)-4.96)*4.575)))
screen.drawLine(9,47,10+((6)*math.cos(((SBat/1)-4.96)*4.575)), 47+((6)*math.sin(((SBat/1)-4.96)*4.575)))
screen.drawLine(11,47,10+((6)*math.cos(((SBat/1)-4.96)*4.575)), 47+((6)*math.sin(((SBat/1)-4.96)*4.575)))

screen.setColor(0,70,0)
screen.drawLine(10,47,10+((6)*math.cos(((SBat/1)-4.96)*4.575)), 47+((6)*math.sin(((SBat/1)-4.96)*4.575)))
end
if not TrimPresentandOn then
screen.setColor(60,60,60)
screen.drawTextBox(2,28,25,8,"Bat",0,1)
screen.setColor(30,0,0)
screen.drawLine(10,46,10+((6)*math.cos(((PBat/1)-4.96)*4.575)), 47+((6)*math.sin(((PBat/1)-4.96)*4.575)))
screen.drawLine(10,48,10+((6)*math.cos(((PBat/1)-4.96)*4.575)), 47+((6)*math.sin(((PBat/1)-4.96)*4.575)))
screen.drawLine(9,47,10+((6)*math.cos(((PBat/1)-4.96)*4.575)), 47+((6)*math.sin(((PBat/1)-4.96)*4.575)))
screen.drawLine(11,47,10+((6)*math.cos(((PBat/1)-4.96)*4.575)), 47+((6)*math.sin(((PBat/1)-4.96)*4.575)))

screen.setColor(70,0,0)
screen.drawLine(10,47,10+((6)*math.cos(((PBat/1)-4.96)*4.575)), 47+((6)*math.sin(((PBat/1)-4.96)*4.575)))
end
if Max<.1 then
screen.setColor(0,0,0,200)
screen.drawRectF(0, 0, 96, 64)
screen.setColor(0,100,0)
screen.drawTextBox(0, 0,96,64,"Input Max Engine RPM in Microcontroller Settings", 0, 0)
end
end
