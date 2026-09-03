-- source: steam id 3788750037 / vehicle.xml block#32
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
function onTick()
inputX = input.getNumber(3)
inputY = input.getNumber(4)
PFP=input.getNumber(7)
SFP=input.getNumber(8)
PF=input.getNumber(9)
SF=input.getNumber(10)
LS=input.getNumber(13)
KML=input.getNumber(12)
RSF=input.getNumber(14)
RPF=input.getNumber(15)
C=input.getNumber(16)
isPressed = input.getBool(1)
TM = input.getBool(2)
TH = input.getBool(3)
PSFP = input.getBool(4)
PPFP = input.getBool(5)
OneT = input.getBool(6)
isPressingRectangle2 = isPressed and isPointInRectangle(inputX, inputY, 3, 3, 9, 5)
isPressingRectangle1 = isPressed and isPointInRectangle(inputX, inputY, 83, 2, 10, 6)
isPressingRectangle3 = isPressed and isPointInRectangle(inputX, inputY, 5, 15, 40, 10)
PressingSFP = isPressed and isPointInRectangle(inputX, inputY, 51, 30, 40, 20)
if not OneT then
PressingPFP = isPressed and isPointInRectangle(inputX, inputY, 5, 30, 40,20)
end
if OneT then
PressingPFP = isPressed and isPointInRectangle(inputX, inputY, 5, 30, 86,20)
end
output.setBool(1, isPressingRectangle1)
output.setBool(2, isPressingRectangle2)
output.setBool(3, isPressingRectangle3)
output.setBool(4, PressingSFP)
output.setBool(5, PressingPFP)
end
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
function onDraw()
LM=LS*60
LH=LM*60
if not OneT then
screen.setColor(40,40,40)
screen.drawRect(5, 30, 40,20) --40
screen.drawRect(51, 30, 40, 20)
screen.setColor(15,15,18-C)
screen.drawLine(52, 30, 91, 30)
screen.drawLine(6, 30, 45, 30)
screen.setColor(0, 0,60)
screen.drawRectF(52, 50, 39, SF)
screen.drawRectF(6, 50, 39, PF)
screen.setColor(0, 0,56)
screen.drawRectF(52, 50, 39, SF+2)
screen.drawRectF(6, 50, 39, PF+2)
screen.setColor(0, 0,52)
screen.drawRectF(52, 50, 39, SF+4)
screen.drawRectF(6, 50, 39, PF+4)
screen.setColor(0, 0,48)
screen.drawRectF(52, 50, 39, SF+6)
screen.drawRectF(6, 50, 39, PF+6)
screen.setColor(0, 0,44)
screen.drawRectF(52, 50, 39, SF+8)
screen.drawRectF(6, 50, 39, PF+8)
screen.setColor(0, 0,40)
screen.drawRectF(52, 50, 39, SF+8)
screen.drawRectF(6, 50, 39, PF+8)
screen.setColor(0, 0,36)
screen.drawRectF(52, 50, 39, SF+10)
screen.drawRectF(6, 50, 39, PF+10)
screen.setColor(0, 0,32)
screen.drawRectF(52, 50, 39, SF+12)
screen.drawRectF(6, 50, 39, PF+12)
screen.setColor(0, 0,28)
screen.drawRectF(52, 50, 39, SF+14)
screen.drawRectF(6, 50, 39, PF+14)
screen.setColor(0, 0,24)
screen.drawRectF(52, 50, 39, SF+16)
screen.drawRectF(6, 50, 39, PF+16)
screen.setColor(0, 0,20)
screen.drawRectF(52, 50, 39, SF+18)
screen.drawRectF(6, 50, 39, PF+18)
end
screen.setColor(40,40,40)
screen.drawLine(52, 50, 91, 50)
screen.drawLine(6, 50, 45, 50)
screen.setColor(60, 60, 60)
screen.drawRect(5, 12, 30, 9)
screen.drawRect(51, 12, 30, 9)
if TM then
screen.drawText(5, 5, "LT/M")
elseif TH then
screen.drawText(5, 5, "LT/H")
else
screen.drawText(5, 5, "LT/S")
end
screen.drawText(51, 5, "KM Left")
if not OneT then
if PSFP then
screen.drawTextBox(51, 30, 40, 20, string.format("%.0f%s",RPF,"L"), 0, 0)
else
screen.drawTextBox(51, 30, 40, 20, string.format("%.0f%s",-SFP,"%"), 0, 0)
end
if PPFP then
screen.drawTextBox(5, 30, 40, 20, string.format("%.0f%s",RSF,"L"), 0, 0)
else
screen.drawTextBox(5, 30, 40, 20, string.format("%.0f%s",-PFP,"%"), 0, 0)
end
end
--screen.drawTextBox(x, y, w, h, text, h_align, v_align)
screen.setColor(4,4,7-C)
screen.drawRectF(6,13,39,12)
screen.drawRectF(52,13,39,12)
screen.setColor(60, 60, 60)
if TM then
screen.drawText(9, 16, string.format("%.1f",LM))
elseif TH then
screen.drawText(9, 16, string.format("%.0f",LH))
else
screen.drawText(9, 16, string.format("%.2f",LS))
end

screen.drawText(56, 16, string.format("%.1f",KML))


end
