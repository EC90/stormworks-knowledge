-- source: steam id 2793900947 / vehicle.xml block#21
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947
function onDraw()

shape(0,0)

end

function shape(x,y)

screen.setColor(47,0,0)
screen.drawRectF(89+x,11+y,1,3)
screen.drawRectF(87+x,11+y,1,3)
screen.drawRectF(88+x,13+y,1,1)
screen.drawRectF(88+x,11+y,1,1)
screen.drawRectF(87+x,14+y,1,2)
screen.drawRectF(87+x,17+y,4,1)
screen.drawRectF(85+x,11+y,1,6)
screen.drawRectF(86+x,17+y,1,1)
screen.drawRectF(86+x,9+y,5,1)
screen.drawRectF(85+x,10+y,1,1)
screen.drawLine(91+x,10+y,91.25+x,16.25+y)

end