-- source: steam id 2751468095 / vehicle.xml block#16
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2751468095
function onTick()

	rs = input.getNumber(20)
	t = input.getNumber(21)
	f = input.getNumber(22)
	com = input.getBool(1)
	
	BR = property.getNumber("BackroundR")
	BG = property.getNumber("BackroundG")
	BB = property.getNumber("BackroundB")
	BRT = input.getNumber(23)
	time = math.floor(t) + 0.60*(t-math.floor(t))
end

function onDraw()
	w = screen.getWidth()			
	h = screen.getHeight()					

	screen.setColor(5, 5, 5)			
	screen.drawRectF(0, 0, w, h)
	
	screen.setColor(BR, BG, BB)			 
	screen.drawRectF(2, 2, w-4, h-11)
	
	
	screen.setColor(BR, BG, BB, BRT-30)
	screen.drawRectF(22, h-10, 1, -1)
	screen.drawRectF(24, h-10, 1, -2)
	screen.drawRectF(26, h-10, 1, -3)
	screen.drawRectF(28, h-10, 1, -4)
		screen.drawRectF(3,17,16,5)
	
	screen.setColor(0, 0, 0, BRT)
	
	screen.drawLine(2, 9, w-2, 9)
	
	screen.drawTextBox(4, 3, 25, 7, string.format("%.2f", time), -1, -1)
	screen.drawTextBox(3, 11, w-6, 7, string.format("%.0f", f), 1, -1)
	screen.drawTextBox(3, 11, w-6, 7, "FQ:", -1, -1)
		

	if rs > 0 then
	screen.drawRectF(22, h-10, 1, -1)
	end
	if rs > 0.4 then
	screen.drawRectF(24, h-10, 1, -2)
	end
	if rs > 0.6 then
	screen.drawRectF(26, h-10, 1, -3)
	end
	if rs > 0.8 then
	screen.drawRectF(28, h-10, 1, -4)	
	end
	
	if com then
		screen.drawRectF(3,17,16,5)
	end
	
		screen.setColor(BR, BG, BB)
		screen.drawTextBox(4, 17, w-6, 7, "COM", -1, -1)
	
end