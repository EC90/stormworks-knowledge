-- source: steam id 2372828168 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2372828168
function onTick()
rps=input.getNumber(1) -- engine 1
temp=input.getNumber(2)
pres=input.getNumber(3)

rps2=input.getNumber(4) -- engine 2 (optional)
temp2=input.getNumber(5)
pres2=input.getNumber(6)

batt=input.getNumber(7)
fuel=input.getNumber(8)

end

function onDraw()

screen.setColor(100,100,100)
screen.drawText(6,1, "ENG1")
screen.drawText(40,1, "ENG2")
screen.drawText(4,37, "R")
screen.drawText(13,37, "T")
screen.drawText(22,37, "P")

screen.drawText(38,37, "R")
screen.drawText(47,37, "T")
screen.drawText(56,37, "P")

screen.setColor(100,160,0) 
screen.drawRectF(5,7,2,28)
screen.drawRectF(14,7,2,28)
screen.drawRectF(23,7,2,28)

screen.drawRectF(39,7,2,28)
screen.drawRectF(48,7,2,28)
screen.drawRectF(57,7,2,28)

screen.setColor(170,20,10)
screen.drawRectF(5,7,2,5)
screen.drawRectF(14,7,2,5)
screen.drawRectF(23,7,2,5)

screen.drawRectF(39,7,2,5)
screen.drawRectF(48,7,2,5)
screen.drawRectF(57,7,2,5)

screen.setColor(20,130,10,130)
screen.drawRectF(5,17,2,18)
screen.drawRectF(14,17,2,18)
screen.drawRectF(23,17,2,18)

screen.drawRectF(39,17,2,18)
screen.drawRectF(48,17,2,18)
screen.drawRectF(57,17,2,18)

screen.setColor(150,150,150)
screen.drawLine(3, -(rps*27)+35, 9, -(rps*27)+35) -- RPS E1
screen.drawLine(3, -(rps*27)+34, 9, -(rps*27)+34)   

screen.drawLine(12, -(temp*27)+35, 18, -(temp*27)+35)  -- Temp E1
screen.drawLine(12, -(temp*27)+34, 18, -(temp*27)+34)

screen.drawLine(21, -(pres*27)+35, 27, -(pres*27)+35)  -- Pressure E1
screen.drawLine(21, -(pres*27)+34, 27, -(pres*27)+34)

 screen.drawLine(37, -(rps2*27)+35, 43, -(rps2*27)+35) -- RPS E2
 screen.drawLine(37, -(rps2*27)+34, 43, -(rps2*27)+34)   

 screen.drawLine(46, -(temp2*27)+35, 52, -(temp2*27)+35)  -- Temp E2
 screen.drawLine(46, -(temp2*27)+34, 52, -(temp2*27)+34)

 screen.drawLine(55, -(pres2*27)+35, 61, -(pres2*27)+35)  -- Pressure E2
 screen.drawLine(55, -(pres2*27)+34, 61, -(pres2*27)+34)
 
screen.drawLine(0,44,64,44)
screen.setColor(100,200,10,150)
screen.drawText(4,46, "BATT:")
screen.drawText(4,53, "FUEL:")

screen.drawText(28,46,string.format("%.1f", batt))
screen.drawText(28,53,string.format("%.0f", fuel))
end