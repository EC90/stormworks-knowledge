-- source: steam id 2046605849 / vehicle.xml block#18
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2046605849
local TargetX = 0
local TargetY = 0
local lockB = false

function onTick()
isP1 = input.getBool(1)
isP2 = input.getBool(2)

in1X = input.getNumber(3)
in1Y = input.getNumber(4)
in2X = input.getNumber(5)
in2Y = input.getNumber(6)

LockMode = input.getBool(10)
ExtGPS = input.getBool(11)

if LockMode==false then
	lockB = false
end

focalAlt = input.getNumber(12)
planeX = input.getNumber(13)
planeY = input.getNumber(14)
planeAlt = input.getNumber(15)
planeDisX = math.floor((planeX+0.5)*10)/10
planeDisY = math.floor((planeY+0.5)*10)/10

pivotIn = input.getNumber(16)
pitchIn = input.getNumber(17)

compassS = input.getNumber(18)
altDis = input.getNumber(19)
compassDeg = compassS * 360

altDif = planeAlt - focalAlt

pitchrad = math.rad((((pitchIn-0.25)/1.5)+0.5)*-90)
pivotrad = math.rad((pivotIn*-360)+compassDeg)

distance = altDif * (math.tan(pitchrad))
yOffset = distance * (math.cos(pivotrad))
TY = planeY + yOffset

xOffset = distance * (math.sin(pivotrad))
TX = planeX + xOffset

TDisY = math.floor((TY+0.005)*100)/100
TDisX = math.floor((TX+0.005)*100)/100

if LockMode and (lockB == false) then
	TargetX = TX
	TargetY = TY
	lockB = true
end

if ExtGPS then
	TargetX = input.getNumber(10)
	TargetY = input.getNumber(11)
end
TargetDisX = math.floor((TargetX+0.005)*100)/100
TargetDisY = math.floor((TargetY+0.005)*100)/100

difX = planeX - TargetX
difY = planeY - TargetY
toPivotRad = math.atan(difX/difY)
toPivotDeg = math.deg(toPivotRad)
if difY > 0 then
	pivotOut = (toPivotDeg+180+compassDeg)/-360
else
	pivotOut = (toPivotDeg+0+compassDeg)/-360	
end
output.setNumber(1, pivotOut)

tDis = difY/math.cos(toPivotRad)
toPitchRad = math.atan(tDis/(altDif/2))
toPitchDeg = math.deg(toPitchRad)
pitchOut = (math.abs(((toPitchDeg-90)/-90)-0.5)*1.5)+0.0225
if pitchOut > 1.5 then
	pitchOut = (math.abs(((toPitchDeg)/-90)-0.5)*1.5)+0.0225
end
	
output.setNumber(2, pitchOut)

output.setNumber(3, toPivotRad)
end

function onDraw()
w = screen.getWidth()
h = screen.getHeight()

setC(0,255,0,100)
screen.drawRect((w/2)-5, (h/2)-5, 10, 10)

setC(0,96,0)

setC(0,0,0)

setC(0,96,0)


setC(0,96,0)

setC(0,0,0)

setC(0,96,0)


setC(0,96,96)
screen.drawRectF(100,8.5,60,8.25)
setC(0,0,0)
screen.drawRectF(101,9.5,58,6.25)
if LockMode == false then
	setC(0,96,96)
	screen.drawTextBox(100, 8.5, 60, 8.25, "CY:"..TDisY, 0, 0)
else
	setC(96,0,0)
	screen.drawTextBox(100, 8.5, 60, 8.25, "LY:"..TargetDisY, 0, 0)
end

setC(0,96,96)
screen.drawRectF(99.75,0,60.25,8.75)
setC(0,0,0)
screen.drawRectF(100.75,1,58.25,6.75)
if LockMode == false then
	setC(0,96,96)
	screen.drawTextBox(99.75, 0, 60.25, 8.75, "CX:"..TDisX, 0, 0)
else
	setC(96,0,0)
	screen.drawTextBox(99.75, 0, 60.25, 8.75, "LX:"..TargetDisX, 0, 0)
end
end

function setC(r,g,b,a)
if a==nil then a=255 end
screen.setColor(r,g,b,a)
end