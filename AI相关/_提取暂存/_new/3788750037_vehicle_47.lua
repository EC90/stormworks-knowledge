-- source: steam id 3788750037 / vehicle.xml block#47
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
-- Tick function that will be executed every logic tick
function onTick()
PF=input.getNumber(9)
SF=input.getNumber(10)
OneT = input.getBool(6)
RSF=input.getNumber(14)
PFP=input.getNumber(7)
PPFP = input.getBool(5)
OneT = input.getBool(6)
C=input.getNumber(16)
PC=input.getNumber(17)
SC=input.getNumber(18)
end
function onDraw()
if OneT then
screen.setColor(40,40,40)
screen.drawRect(5, 30, 86,20)
screen.setColor(15,15,18-C)
screen.drawLine(6, 30, 91, 30)
screen.setColor(0, 0,60)
screen.drawRectF(6, 50, 85, PF)
screen.setColor(0, 0,56)
screen.drawRectF(6, 50, 85, PF+2)
screen.setColor(0, 0,52)
screen.drawRectF(6, 50, 85, PF+4)
screen.setColor(0, 0,48)
screen.drawRectF(6, 50, 85, PF+6)
screen.setColor(0, 0,44)
screen.drawRectF(6, 50, 85, PF+8)
screen.setColor(0, 0,40)
screen.drawRectF(6, 50, 85, PF+8)
screen.setColor(0, 0,36)
screen.drawRectF(6, 50, 85, PF+10)
screen.setColor(0, 0,32)
screen.drawRectF(6, 50, 85, PF+12)
screen.setColor(0, 0,28)
screen.drawRectF(6, 50, 85, PF+14)
screen.setColor(0, 0,24)
screen.drawRectF(6, 50, 85, PF+16)
screen.setColor(0, 0,20)
screen.drawRectF(6, 50, 85, PF+18)
screen.setColor(40,40,40)
screen.drawLine(6, 50, 91, 50)
end
if OneT then
if PPFP then
screen.drawTextBox(6, 30, 90, 20, string.format("%.0f%s",RSF,"L"), 0, 0)
else
screen.drawTextBox(6, 30, 90, 20, string.format("%.0f%s",-PFP,"%"), 0, 0)
end
end
screen.setColor(7,7,10-C)
screen.drawRectF(0,51,96,26)
if PC<.1 or SC<.1 then
screen.setColor(0,0,0,200)
screen.drawRectF(0, 0, 96, 64)
screen.setColor(0,100,0)
screen.drawTextBox(0, 0,96,64,"Input Max Fuel Capacity in Microcontroller Settings", 0, 0)
end
end