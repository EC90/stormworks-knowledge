-- source: steam id 3788750037 / vehicle.xml block#42
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
function onTick()
TwoEng=input.getBool(4)
TrimPresentandOn=input.getBool(5)
PRPM=input.getNumber(5)
SRPM=input.getNumber(6)
PTEMP=input.getNumber(7)
STEMP=input.getNumber(8)
Max=input.getNumber(9)
MaxT=input.getNumber(11)
PBat=input.getNumber(12)
SBat=input.getNumber(13)
PTrim=input.getNumber(14)
STrim=input.getNumber(15)
C=input.getNumber(17)
end
function onDraw()
if TwoEng then
screen.setColor(0,30,0)
screen.drawLine(48,17,48+((14)*math.cos(((SRPM/Max)-4.96)*4.575)), 18+((14)*math.sin(((SRPM/Max)-4.96)*4.575)))
screen.drawLine(48,19,48+((14)*math.cos(((SRPM/Max)-4.96)*4.575)), 18+((14)*math.sin(((SRPM/Max)-4.96)*4.575)))
screen.drawLine(47,18,48+((14)*math.cos(((SRPM/Max)-4.96)*4.575)), 18+((14)*math.sin(((SRPM/Max)-4.96)*4.575)))
screen.drawLine(49,18,48+((14)*math.cos(((SRPM/Max)-4.96)*4.575)), 18+((14)*math.sin(((SRPM/Max)-4.96)*4.575)))

screen.drawLine(86,46,86+((6)*math.cos(((STEMP/MaxT)-4.96)*4.575)), 47+((6)*math.sin(((STEMP/MaxT)-4.96)*4.575)))
screen.drawLine(86,48,86+((6)*math.cos(((STEMP/MaxT)-4.96)*4.575)), 47+((6)*math.sin(((STEMP/MaxT)-4.96)*4.575)))
screen.drawLine(85,47,86+((6)*math.cos(((STEMP/MaxT)-4.96)*4.575)), 47+((6)*math.sin(((STEMP/MaxT)-4.96)*4.575)))
screen.drawLine(87,47,86+((6)*math.cos(((STEMP/MaxT)-4.96)*4.575)), 47+((6)*math.sin(((STEMP/MaxT)-4.96)*4.575)))

screen.setColor(0,70,0)
screen.drawLine(48,18,48+((14)*math.cos(((SRPM/Max)-4.96)*4.575)), 18+((14)*math.sin(((SRPM/Max)-4.96)*4.575)))
screen.drawLine(86,47,86+((6)*math.cos(((STEMP/MaxT)-4.96)*4.575)), 47+((6)*math.sin(((STEMP/MaxT)-4.96)*4.575)))

 
end
screen.setColor(30,0,0)
screen.drawLine(48,17,48+((14)*math.cos(((PRPM/Max)-4.96)*4.575)), 18+((14)*math.sin(((PRPM/Max)-4.96)*4.575)))
screen.drawLine(48,19,48+((14)*math.cos(((PRPM/Max)-4.96)*4.575)), 18+((14)*math.sin(((PRPM/Max)-4.96)*4.575)))
screen.drawLine(47,18,48+((14)*math.cos(((PRPM/Max)-4.96)*4.575)), 18+((14)*math.sin(((PRPM/Max)-4.96)*4.575)))
screen.drawLine(49,18,48+((14)*math.cos(((PRPM/Max)-4.96)*4.575)), 18+((14)*math.sin(((PRPM/Max)-4.96)*4.575)))

screen.drawLine(86,46,86+((6)*math.cos(((PTEMP/MaxT)-4.96)*4.575)), 47+((6)*math.sin(((PTEMP/MaxT)-4.96)*4.575)))
screen.drawLine(86,48,86+((6)*math.cos(((PTEMP/MaxT)-4.96)*4.575)), 47+((6)*math.sin(((PTEMP/MaxT)-4.96)*4.575)))
screen.drawLine(85,47,86+((6)*math.cos(((PTEMP/MaxT)-4.96)*4.575)), 47+((6)*math.sin(((PTEMP/MaxT)-4.96)*4.575)))
screen.drawLine(87,47,86+((6)*math.cos(((PTEMP/MaxT)-4.96)*4.575)), 47+((6)*math.sin(((PTEMP/MaxT)-4.96)*4.575)))

screen.setColor(70,0,0)
screen.drawLine(48,18,48+((14)*math.cos(((PRPM/Max)-4.96)*4.575)), 18+((14)*math.sin(((PRPM/Max)-4.96)*4.575)))
screen.drawLine(86,47,86+((6)*math.cos(((PTEMP/MaxT)-4.96)*4.575)), 47+((6)*math.sin(((PTEMP/MaxT)-4.96)*4.575)))
 -- -RPS1=Start Bottom or top, -1.5= where neddle start, 3.175=full circle? -.6
if TwoEng then
screen.setColor(50,50,50)
screen.drawTextBox(8, 4, 22, 9, string.format("%.0f",PRPM), 0, 0)
screen.drawTextBox(8, 17, 22, 9, string.format("%.0f",SRPM), 0, 0)
screen.drawTextBox(62, 39, 15, 7, string.format("%.0f",STEMP), 0, 0)
screen.drawTextBox(62, 47, 15, 7, string.format("%.0f",PTEMP), 0, 0)
else
screen.setColor(50,50,50)
screen.drawTextBox(8, 11, 22, 9, string.format("%.0f",PRPM), 0, 0)
screen.drawTextBox(62, 44, 15, 7, string.format("%.0f",PTEMP), 0, 0)
end
if TwoEng and not TrimPresentandOn then
screen.drawTextBox(22, 47, 15, 7, string.format("%.1f",PBat), 0, 0)
screen.drawTextBox(22, 39, 15, 7, string.format("%.1f",SBat), 0, 0)
elseif TwoEng and TrimPresentandOn then
screen.drawTextBox(22, 47, 15, 7, string.format("%.1f",PTrim), 0, 0)
screen.drawTextBox(22, 39, 15, 7, string.format("%.1f",STrim), 0, 0)
end
if not TwoEng and not TrimPresentandOn then
screen.drawTextBox(22, 44, 15, 7, string.format("%.1f",PBat), 0, 0)
elseif not TwoEng and TrimPresentandOn then
screen.drawTextBox(22, 47, 15, 7, string.format("%.1f",PTrim), 0, 0)
screen.drawTextBox(22, 39, 15, 7, string.format("%.1f",STrim), 0, 0)
end
end