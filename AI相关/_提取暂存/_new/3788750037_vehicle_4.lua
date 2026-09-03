-- source: steam id 3788750037 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
function onTick()
Distance=input.getNumber(15)
ETA=input.getNumber(16)
L=input.getNumber(17)
APB=input.getNumber(19)
WP=input.getNumber(20)
C=input.getNumber(18)
end

function onDraw()
screen.setColor(10,10,13-C)
screen.drawRectF(76+APB,20,20,38)
screen.setColor(8,8,11-C)
screen.drawRectF(76+APB,20,20,8)
screen.drawRectF(76+APB,40,20,8)
screen.setColor(15,15,15)
screen.drawLine(76+APB,57,76+APB,19)
screen.drawLine(76+APB,40,96+APB,40)
screen.setColor(100,100,100)
screen.drawText(80+APB,22,"DST")
screen.drawText(80+APB,42,"ETA")
screen.drawText(80+APB,32,string.format("%.00fk",Distance))
screen.drawText(80+APB,51,string.format("%.0fM",ETA))
screen.setColor(20,20,20)
screen.drawText(64+APB,47,string.format("%.0fW",WP))
end