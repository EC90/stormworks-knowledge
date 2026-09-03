-- source: steam id 2021358468 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2021358468


function onTick()
isP1 = input.getBool(1)
isP2 = input.getBool(2)

in1X = input.getNumber(3)
in1Y = input.getNumber(4)
in2X = input.getNumber(5)
in2Y = input.getNumber(6)

end

function onDraw()

setC(0,96,0)
screen.drawLine(0, 15, 170, 15)

setC(0,96,0)
screen.drawLine(15, 100, 15, 0)
end

function setC(r,g,b,a)
if a==nil then a=155 end
screen.setColor(r,g,b,a)
end
