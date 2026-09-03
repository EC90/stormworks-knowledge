-- source: steam id 1969765716 / vehicle.xml block#20
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
SNr = 0
SNm = 1

ANr = false
ANm = 1

alpha = 255
alpha2 = 50
function onTick()
Speed = input.getNumber(2)
Alt = input.getNumber(1)
speedUnit = input.getBool(1)
altUnit = input.getBool(4)
onHud = input.getBool(3)
infra = input.getBool(2)

if speedUnit and SNr >= 0 and SNr < 3 then SNr = SNr + 1 elseif speedUnit and SNr == 3 then SNr = 0 end
if SNr == 1 then 
SN = "M/S" 
SNm = 1
elseif SNr == 2 then
SN = "Kmph"
SNm = 3.6
elseif SNr == 3 then
SN = "Mph"
SNm = 2.236936
elseif SNr == 0 then
SN = "Kts"
SNm = 1.943844
end

if altUnit then ANr = not ANr end
if not ANr then
ANm = 1
AN = "M"
elseif ANr then
ANm = 3.2808399
AN = "Ft"
end

if onHud then alpha2 = 0 else alpha2 = 15 end
if onHud and infra then alpha = 200 else alpha = 255 end

output.setNumber(1,SNm)
output.setNumber(2,ANm)
end

function onDraw()
screen.setColor(255,255,0,alpha2)
screen.drawRect(0,0,31,31)
screen.drawLine(1,15,31,15)
	
screen.setColor(0,255,0,alpha)
screen.drawText(2,17,SN)
screen.drawText(2,23,string.format("%.1f", Speed*SNm))
screen.drawText(2,2,"ALT("..AN..")")
if Alt < 100 and Alt > 0 then screen.setColor(255,255,0,alpha) elseif Alt < 0 then screen.setColor(255,0,0,alpha) end
screen.drawText(2,8,string.format("%.1f", Alt*ANm))
end