-- source: steam id 2793900947 / vehicle.xml block#23
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947
function onDraw()

shape(0,0)

end

function shape(x,y)

screen.setColor(238,56,0)
screen.drawRect(35+x,29+y,2,1)
screen.drawLine(34+x,28+y,34.25+x,31.25+y)
screen.drawLine(33+x,29+y,33.25+x,30.25+y)

end