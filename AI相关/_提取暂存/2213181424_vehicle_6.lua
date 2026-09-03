-- source: steam id 2213181424 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
-- Tick function that will be executed every logic tick
function onTick()
	crewdoor = input.getNumber(1)
	ramp = input.getNumber(2)
	cargodoor = input.getNumber(3)
	winch1 = input.getNumber(4)
	winch2 = input.getNumber(5)
	nosegear = input.getNumber(6)
	brake = input.getNumber(7)
	batt = input.getNumber(8)
	sling = input.getNumber(9)
	
if batt ==1 then
output.setBool(1,true)
else
output.setBool(1,false)
end

if cargodoor <0 or ramp >-0.28 then
output.setBool(2,true)
else
output.setBool(2,false)
end
if crewdoor <0 or ramp >0  then
output.setBool(3,true)
output.setBool(2,true)
else
output.setBool(3,false)
end

if winch1 >0.5 or winch2 >0.5 or sling >0.5 then
output.setBool(4,true)
else
output.setBool(4,false)
end

if nosegear <0 then
output.setBool(5,true)
else
output.setBool(5,false)
end
if brake == 1 and nosegear <0 then
output.setBool(6,true)
else
output.setBool(6,false)
end

end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	
if batt ==1 then
screen.setColor(100,0,0)
screen.drawRectF(0, 1, w, 8)
end

if cargodoor <0 or ramp >-0.28 then
screen.setColor(150,112,0)
screen.drawRectF(0, 9, w, 8)
end
if crewdoor <0 or ramp >0 then
screen.setColor(100,0,0)
screen.drawRectF(0, 9, w, 8)
end

if winch1 >0.5 or winch2 >0.5 or sling >0.5 then
screen.setColor(150,112,0)
screen.drawRectF(0, 17, w, 8)
end

if nosegear <0 then
screen.setColor(150,112,0)
screen.drawRectF(0, 25, w, 8)
end
if brake ==1 and nosegear <0 then
screen.setColor(100,0,0)
screen.drawRectF(0, 25, w, 8)
end


screen.setColor(0,0,0)

screen.drawTextBox(1, 1, w, 7, "BATT", 0, 0)
screen.drawTextBox(1, 9, w, 7, "DOOR", 0, 0)
screen.drawTextBox(1, 17, w, 7, "WINCH", 0, 0)

if brake >0 then
screen.drawTextBox(1, 25, w, 7, "BRAKE", 0, 0)
else
screen.drawTextBox(1, 25, w, 7, "GEAR", 0, 0)
end

end