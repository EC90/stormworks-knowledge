-- source: steam id 2800117544 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2800117544
-- Tick function that will be executed every logic tick
function onTick()
launcher = input.getBool(2)
launcher2 = input.getBool(3)
launcher3 = input.getBool(6)
arm = input.getBool(4)
waypoint = input.getBool(5)
range = input.getBool(7)
end

function onDraw()

if launcher then
screen.setColor(150,150,150,55)
screen.drawRectF(1,55,60,7)
screen.setColor(220, 220, 220, 240)
screen.drawTextBox(2,56,60,7, "Launch Ready")
end
if launcher2 then
screen.setColor(150,150,150,55)
screen.drawRectF(1,55,61,7)
screen.setColor(220, 220, 220, 240)
screen.drawTextBox(2,56,61,7, "Launch Extnd")
end
if launcher3 then
screen.setColor(150,150,150,55)
screen.drawRectF(1,55,60,7)
screen.setColor(220, 220, 220, 240)
screen.drawTextBox(2,56,60,7, "Launch Rtrct")
end
if arm then
screen.setColor(150,150,150,55)
screen.drawRectF(1,47,51,7)
screen.setColor(220, 220, 220, 240)
screen.drawTextBox(2,48,61,7, "Master Arm")	
end
if waypoint then
screen.setColor(150,150,150,55)
screen.drawRectF(1,39,61,7)
screen.setColor(220, 220, 220, 240)
screen.drawTextBox(2,40,61,7, "XYZ Required")	
end
if range then
screen.setColor(150,150,150,55)
screen.drawRectF(1,31,61,7)
screen.setColor(220, 220, 220, 240)
screen.drawTextBox(2,32,61,7, "Low Range")	
end
end