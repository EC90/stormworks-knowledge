-- source: steam id 1969765716 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
function onTick()
	OBS_UP = input.getBool(12)
	OBS_DN = input.getBool(11)
	OBS_HDG = input.getBool(13)
	OBS_180 = input.getBool(14)
	int_mode = input.getNumber(20)
	
end


function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	
	if int_mode == 4 and OBS_UP then
		screen.setColor(255, 64, 0, 192)
		screen.drawRectF(w-8, 9, 9, h-18)
		screen.setColor(255, 0, 0, 255)
		screen.drawTriangleF(w-7, h/2 - 5, w-7, h/2 + 5, w-2, h/2)
	end
	
	if int_mode == 4 and OBS_DN then
		screen.setColor(255, 64, 0, 192)
		screen.drawRectF(0, 9, 8, h-18)
		screen.setColor(255, 0, 0, 255)
		screen.drawTriangleF(7, h/2 - 5, 7, h/2 + 5, 2, h/2)
	end

	if int_mode == 4 and OBS_HDG then
		screen.setColor(255, 64, 0, 192)
		screen.drawRectF(9, 0, w-18, 9)
		screen.setColor(255, 0, 0, 255)
		screen.drawTextBox(0, 2, w, 5, "HD", 0, 0)
	end
	
	if int_mode == 4 and OBS_180 then
		screen.setColor(255, 64, 0, 192)
		screen.drawRectF(9, h-8, w-18, 9)
		screen.setColor(255, 0, 0, 255)
		screen.drawTextBox(0, h-7, w, 5, "<>", 0, 0)
	end
	
end