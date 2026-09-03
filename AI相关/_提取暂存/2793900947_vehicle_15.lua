-- source: steam id 2793900947 / vehicle.xml block#15
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947
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
screen.drawCircleF(x/2, y/2, 36)
end