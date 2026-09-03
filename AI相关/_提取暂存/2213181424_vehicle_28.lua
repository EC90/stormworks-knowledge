-- source: steam id 2213181424 / vehicle.xml block#28
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
temp_distance = 0
relative = 0

function onTick()
act=input.getBool(32)
if act then
distance = input.getNumber(5)
end
end

function onDraw()
if act then
	w = screen.getWidth()				  
	h = screen.getHeight()
screen.setColor(25,50,100)
screen.drawLine(0,58,64,58)				

if distance/20 >100 then
	screen.setColor(25, 50,100)
		screen.drawTextBox(0, 6, w, 7, "---", 0, 0)
		screen.drawTextBox(0, 13, w, 7, "NO SIGNAL", 0, 0)
		screen.setColor(25,50,100,100)
		screen.drawRectF(0, 13, w, 7)


elseif distance/20 >0.45 then
	screen.setColor(25, 50, 100)
	screen.drawTextBox(0, 6, w, 7, math.floor(distance / 2) / 10 .. "km", 0, 0)
	
	if temp_distance ~= distance then
			relative = (temp_distance - distance) * 100
			temp_distance = distance
	end

	if relative > 0 then
			screen.setColor(0,100,0)
			screen.drawTextBox(0, 13, w, 7, "GAIN", 0, 0)
			screen.setColor(0,100,0, 00)
			screen.drawRectF(0, 13, w, 7)
	else
			screen.setColor(100,0,0)
			screen.drawTextBox(0, 13, w, 7, "LOSE", 0, 0)
			screen.setColor(100,0,0, 100)
			screen.drawRectF(0, 13, w, 7)
	end
else
		screen.setColor(0, 100,0)
		screen.drawTextBox(0, 6, w, 7, "<400m", 0, 0)
		screen.drawTextBox(0, 13, w, 7, "LOCATE", 0, 0)
		screen.setColor(0,100,0,100)
		screen.drawRectF(0, 13, w, 7)
end

end
end


