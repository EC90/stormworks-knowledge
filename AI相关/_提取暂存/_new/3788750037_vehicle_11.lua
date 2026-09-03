-- source: steam id 3788750037 / vehicle.xml block#11
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
function onTick()
Dpt1=input.getNumber(4)
Dpt2=input.getNumber(5)
Dpt3=input.getNumber(6)
Dpt4=input.getNumber(7)
Dpt5=input.getNumber(8)
Dpt6=input.getNumber(9)
Dpt7=input.getNumber(10)
Dpt8=input.getNumber(11)
Dpt9=input.getNumber(12)
Dpt10=input.getNumber(13)
Dpt11=input.getNumber(14)
Dpt12=input.getNumber(15)
Dpt13=input.getNumber(16)
Dpt14=input.getNumber(17)
Dpt15=input.getNumber(18)
Dpt16=input.getNumber(19)
Dpt=input.getNumber(20)
SDpt1=input.getBool(2)
SDpt2=input.getBool(3)
SDpt3=input.getBool(4)
SDpt4=input.getBool(5)
SDpt5=input.getBool(6)
SDpt6=input.getBool(7)
DptL=input.getBool(8)
DptVL=input.getBool(9)
DptLV=input.getBool(10)
end
function onDraw()
screen.setColor(40,5,0)
screen.drawRectF(90,14+Dpt1,6,4)
screen.drawRectF(84,14+Dpt2,6,4)
screen.drawRectF(78,14+Dpt3,6,4)
screen.drawRectF(72,14+Dpt4,6,4)
screen.drawRectF(66,14+Dpt5,6,4)
screen.drawRectF(60,14+Dpt6,6,4)
screen.drawRectF(54,14+Dpt7,6,4)
screen.drawRectF(48,14+Dpt8,6,4)
screen.drawRectF(42,14+Dpt9,6,4)
screen.drawRectF(36,14+Dpt10,6,4)
screen.drawRectF(30,14+Dpt11,6,4)
screen.drawRectF(24,14+Dpt12,6,4)
screen.drawRectF(18,14+Dpt13,6,4)
screen.drawRectF(12,14+Dpt14,6,4)
screen.drawRectF(6,14+Dpt15,6,4)
screen.drawRectF(0,14+Dpt16,6,4)
screen.setColor(0,0,0)
screen.drawRectF(90,60+Dpt1,6,64)
screen.drawRectF(84,60+Dpt2,6,64)
screen.drawRectF(78,60+Dpt3,6,64)
screen.drawRectF(72,60+Dpt4,6,64)
screen.drawRectF(66,60+Dpt5,6,64)
screen.drawRectF(60,60+Dpt6,6,64)
screen.drawRectF(54,60+Dpt7,6,64)
screen.drawRectF(48,60+Dpt8,6,64)
screen.drawRectF(42,60+Dpt9,6,64)
screen.drawRectF(36,60+Dpt10,6,64)
screen.drawRectF(30,60+Dpt11,6,64)
screen.drawRectF(24,60+Dpt12,6,64)
screen.drawRectF(18,60+Dpt13,6,64)
screen.drawRectF(12,60+Dpt14,6,64)
screen.drawRectF(6,60+Dpt15,6,64)
screen.drawRectF(0,60+Dpt16,6,64)
screen.setColor(180,180,180)
if DptL and DptLV then
screen.drawText(70,3,string.format("%.1fM",Dpt))
end
if DptL and DptVL then
screen.drawText(75,3,string.format("%.0fM",Dpt))
end
screen.drawLine(3,12,3,54)
screen.drawLine(3,12,6,12)
screen.drawLine(3,33,5,33)
if SDpt1 then
screen.drawText(7,52,"10m")
end
if SDpt2 then
screen.drawText(7,52,"20m")
end
if SDpt3 then
screen.drawText(7,52,"50m")
end
if SDpt4 then
screen.drawText(7,52,"100m")
end
if SDpt5 then
screen.drawText(7,52,"250m")
end
if SDpt6 then
screen.drawText(7,52,"500m")
end
screen.setColor(60,0,0)
screen.drawLine(3,54,6,54)
end
