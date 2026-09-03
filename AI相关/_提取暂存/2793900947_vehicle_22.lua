-- source: steam id 2793900947 / vehicle.xml block#22
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947
function onDraw()

shape(0,0)

end

function shape(x,y)

screen.setColor(238,56,0)
screen.drawRect(58+x,29+y,2,1)
screen.drawLine(61+x,28+y,61.25+x,31.25+y)
screen.drawLine(62+x,29+y,62.25+x,30.25+y)

end