-- source: steam id 1772155525 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1772155525
z = 5

function onTick()
	w = input.getNumber(1)
	h = input.getNumber(2)
	a = h/2
	b = w/2
	touchX = input.getNumber(3) -- touchscreen pixel coords
	touchY = input.getNumber(4)
	press = input.getBool(1)
	plus = press and inRect(touchX, touchY, b, 1, 7, 7) -- plus button pressed
	minus = press and inRect(touchX, touchY, b-7, 1, 7, 7) -- minus button
	if w>63 then
		ctr = press and inRect(touchX, touchY, 1, 1, 16, 7) -- ctr button
	end
	if plus then -- zooms in
		z = z-0.1
	end
	if minus then -- zooms out
		z = z+0.1
	end
	if z<1 then -- limits zoom level
		z = 1
	end
	if z>50 then
		z = 50
	end
	output.setNumber(4, z)
	output.setBool(4, ctr)
end

function inRect(x, y, rectx, recty, rectw, recth) -- checks if click is inside button
	return x>rectx and y>recty and x<rectw+rectx and y<recth+recty
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	a = h/2
	b = w/2
	screen.setColor(50, 50, 50, 100) -- semi transparent buttons
	screen.drawRectF(b-7, 1, 7, 7)
	screen.drawRectF(b, 1, 7, 7)
	screen.setColor(255, 255, 255) -- button text
	screen.drawLine(b+3, 1, b+3, 6)
	screen.drawLine(b-6, 3, b-1, 3)
	screen.drawLine(b+1, 3, b+6, 3)
	if w>63 then
		screen.setColor(50, 50, 50, 100)
		screen.drawRectF(1, 1, 16, 7)
		screen.setColor(255, 255, 255)
		screen.drawText(2, 1, "CTR")
	end
--	if ctr then
--		screen.drawLine(5, 5, 10, 10)
--	end
end