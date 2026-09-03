-- source: steam id 2551954944 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2551954944


function onTick()
isP1 = input.getBool(1)
isP2 = input.getBool(2)

in1X = input.getNumber(3)
in1Y = input.getNumber(4)
in2X = input.getNumber(5)
in2Y = input.getNumber(6)

end

function onDraw()

setC(0,0,0)
screen.drawRectF(0,0,64,13)
setC(96,96,96)
screen.drawRectF(3,3,58,7)
setC(0,0,0)
screen.drawTextBox(0, 0, 64, 13, "A-10 ", 0, 0)

setC(0,0,0)
screen.drawRectF(0,13,64,13)
setC(96,96,96)
screen.drawRectF(2,15,60,9)
setC(0,0,0)
screen.drawTextBox(0, 13, 64, 13, "System", 0, 0)

setC(0,0,0)
screen.drawRectF(18,32,46,13)
setC(49,62,72)
screen.drawRectF(21,35,40,7)
setC(0,0,0)
screen.drawTextBox(18, 32, 46, 13, "Cams1-7", 0, 0)

setC(0,0,0)
screen.drawRectF(0,45,64,3)
setC(96,96,96)
screen.drawRectF(3,48,58,-3)
setC(0,0,0)
screen.drawTextBox(0, 45, 64, 3, "", 0, 0)
end

function setC(r,g,b,a)
if a==nil then a=255 end
screen.setColor(r,g,b,a)
end
