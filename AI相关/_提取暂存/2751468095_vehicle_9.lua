-- source: steam id 2751468095 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2751468095
function onTick()
r=input.getNumber(1)
g=input.getNumber(2)
b=input.getNumber(3)
a=input.getNumber(4)
end

function onDraw()
x=screen.getWidth()
y=screen.getHeight()
screen.setColor(0,200,105,50)
screen.drawCircleF(x/2, y/2, 19)
end