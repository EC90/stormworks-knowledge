-- source: steam id 2446775682 / microcontroller.xml block#36
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2446775682
function onTick()

	page = input.getNumber(31)
	osb = input.getNumber(32)
	ca = input.getBool(11)
	lowpressure = input.getBool(9)
	critpressure = input.getBool(10)
	fire = input.getBool(8)
	notcleared = input.getBool(12)
	drain = input.getBool(13)
	acclow = input.getBool(14)
	overheat = input.getBool(23)

end
function onDraw()

double=(lowpressure==true or critpressure==true) and (drain==true or acclow==true)
problem=lowpressure==true or critpressure==true or drain==true or acclow==true
if notcleared==true or ca==true then
if ca==true then
screen.setColor(0,0,0)
screen.drawRectF(0, 0, 70, 70)
screen.setColor(0,255,0)
screen.drawTextBox(0, 5, 64, 10, "c/a", 0, 0)
end
if lowpressure==true then
screen.setColor(255,255,0)
screen.drawRectF(0, 54, 64, 8)
screen.setColor(0,0,0)
screen.drawTextBox(0, 54, 64, 8, "hyd pres", 0, 0)
end
if critpressure==true then
screen.setColor(255,0,0)
screen.drawRectF(0, 54, 64, 8)
screen.setColor(0,0,0)
screen.drawTextBox(0, 54, 64, 8, "hyd pres", 0, 0)
end
if drain==true then
if lowpressure==true or critpressure==true then
screen.setColor(255,255,0)
screen.drawRectF(0, 46, 64, 8)
screen.setColor(0,0,0)
screen.drawTextBox(0, 46, 64, 8, "acc drain", 0, 0)
else
screen.setColor(255,255,0)
screen.drawRectF(0, 54, 64, 8)
screen.setColor(0,0,0)
screen.drawTextBox(0, 54, 64, 8, "acc drain", 0, 0)
end end
if acclow==true then
if lowpressure==true or critpressure==true then
screen.setColor(255,0,0)
screen.drawRectF(0, 46, 64, 8)
screen.setColor(0,0,0)
screen.drawTextBox(0, 46, 64, 8, "acc low", 0, 0)
else
screen.setColor(255,0,0)
screen.drawRectF(0, 54, 64, 8)
screen.setColor(0,0,0)
screen.drawTextBox(0, 54, 64, 8, "acc low", 0, 0)
end end

if overheat==true then
if double==true then
screen.setColor(255,0,0)
screen.drawRectF(0, 38, 64, 8)
screen.setColor(0,0,0)
screen.drawTextBox(0, 38, 64, 8, "overheat", 0, 0)
end
if double==false then 
if problem==true then
screen.setColor(255,0,0)
screen.drawRectF(0, 46, 64, 8)
screen.setColor(0,0,0)
screen.drawTextBox(0, 46, 64, 8, "overheat", 0, 0)
else
screen.setColor(255,0,0)
screen.drawRectF(0, 54, 64, 8)
screen.setColor(0,0,0)
screen.drawTextBox(0, 54, 64, 8, "overheat", 0, 0)
end end end

if fire==true then
if double==true then
screen.setColor(255,0,0)
screen.drawRectF(0, 38, 64, 8)
screen.setColor(0,0,0)
screen.drawTextBox(0, 38, 64, 8, "fire", 0, 0)
end
if double==false then 
if problem==true then
screen.setColor(255,0,0)
screen.drawRectF(0, 46, 64, 8)
screen.setColor(0,0,0)
screen.drawTextBox(0, 46, 64, 8, "fire", 0, 0)
else
screen.setColor(255,0,0)
screen.drawRectF(0, 54, 64, 8)
screen.setColor(0,0,0)
screen.drawTextBox(0, 54, 64, 8, "fire", 0, 0)
end end end





end
end