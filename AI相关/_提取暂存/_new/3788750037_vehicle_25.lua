-- source: steam id 3788750037 / vehicle.xml block#25
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037

function onTick()
inputX = input.getNumber(3)
inputY = input.getNumber(4)
isPressed = input.getBool(1)
rng = input.getNumber(5)
a = input.getNumber(6)
del = input.getNumber(7)
TargetsAmount = input.getNumber(8)
Sx = input.getNumber(9)
Sy = input.getNumber(10)
Color = input.getNumber(32)
rad=input.getBool(18)

rdrA=(a*360)*math.pi/180

add = isPressed and isPointInRectangle(inputX, inputY,1,1,5,5)
sub = isPressed and isPointInRectangle(inputX, inputY,7,1,5,5)
Radar = isPressed and isPointInRectangle(inputX, inputY,43,2,8,7)
output.setBool(1, add)
output.setBool(2, sub)
output.setBool(3, Radar)
output.setNumber(4, rdrA)
xl=26+25*math.cos(-1.58+rdrA)
yl=27+25*math.sin(-1.58+rdrA)
end
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
function onDraw()
rdrC=rng/2
rdrCS=25/rdrC
screen.setColor(18,18,18+Color)
screen.drawRectF(0,0,96,64)
for i=0,96,4
do
screen.setColor(17,17,17+Color)
screen.drawRectF(0,i-1,96,2)
end
screen.setColor(8,8,8+Color)
screen.drawRectF(0,0,54,64)
screen.setColor(5,5,5)
screen.drawCircleF(26, 27, 25)
screen.drawCircle(26, 27, 25)
screen.setColor(6,6,6)
screen.drawLine(26,2,26,53)
screen.drawLine(9,10,44,45)
screen.drawLine(9,44,44,9)
screen.drawLine(1,27,52,27)
for b=0,25,rdrCS
do
screen.drawCircle(26,27,b)
end
screen.setColor(30,30,30)
screen.drawLine(53,0,53,64)
screen.setColor(40,40,40)
screen.drawRectF(1, 1, 5, 5)
screen.drawRectF(7, 1, 5, 5)
screen.setColor(30,0,0)
--screen.drawRectF(44,1,7,7)
screen.drawCircleF(47, 5, 4)
screen.setColor(25,0,0)
screen.drawCircle(47, 5, 4)
screen.setColor(50,50,50)
-- +
screen.drawLine(3,2,3,5)
screen.drawLine(2,3,5,3)
-- -
screen.drawLine(8,3,11,3)
-- start circle
screen.drawCircle(47, 5, 2)
screen.drawTextBox(1, 46, 10, 6,string.format("%.0f",rng), -1, 0)
screen.drawTextBox(1, 52, 10, 6,"km", 0, 0)
screen.setColor(30,0,0)
screen.drawLine(46,3,49,3)
screen.setColor(50,50,50)
screen.drawLine(47,5,47,2)
screen.setColor(0,255,0)
--screen.drawLine(26,27,xl,yl)

if rad==false then
else
for k=1.58,2.8,0.0174533 do
	screen.setColor(0,255-(k*30),0,10)
	xtr=26+25*math.cos(-k+rdrA)
	ytr=27+25*math.sin(-k+rdrA)
	screen.drawLine(26,27,xtr,ytr)
end
end

screen.setColor(9,9,9+Color)
screen.drawRectF(57, 3, 36, 23)
screen.setColor(50,50,50)
screen.drawTextBox(57, 4, 36, 29, "Targets Found:", 0, -1)
screen.drawTextBox(57, 19, 36, 13,string.format("%.0f",TargetsAmount), 0, -1)
screen.setColor(70,70,70)
screen.drawTextBox(56, 34, 12, 5, "X:", -1, 0)
screen.drawTextBox(56, 44, 12, 5, "Y:", -1, 0)
screen.drawTextBox(65, 34, 30, 5, string.format("%.1f",Sx), -1, 0)
screen.drawTextBox(65, 44, 30, 5, string.format("%.1f",Sy), -1, 0)

screen.setColor(250,250,250,50)
if add then
screen.drawRectF(1, 1, 5, 5)
end
if sub then
screen.drawRectF(7, 1, 5, 5)
end
if Radar then
screen.drawCircleF(47, 5, 4)
screen.setColor(60,60,60)
screen.drawCircle(47, 5, 4)
end
end