-- source: steam id 2395501728 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2395501728
function onTick()
isWR=input.getBool(3)
w=input.getNumber(1)
h=input.getNumber(2)
x1=input.getNumber(8)
y1=input.getNumber(9)
x2=input.getNumber(10)
y2=input.getNumber(11)
x3=input.getNumber(12)
y3=input.getNumber(13)
end
function onDraw()
screen.setColor(255,0,0)
screen.drawTriangle(0.5*w+x1,0.5*h+y1,0.5*w+x2,0.5*h+y2,0.5*w+x3,0.5*h+y3)
if isWR then
screen.drawRectF(0,0,29,8)
screen.setColor(255,255,255)
screen.drawText(2,2,"ERROR")
else
end
end