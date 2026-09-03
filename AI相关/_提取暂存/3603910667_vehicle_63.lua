-- source: steam id 3603910667 / vehicle.xml block#63
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
function onTick()
	temp = input.getNumber(1)	
	atemp = input.getNumber(3)		
	BR = property.getNumber("BackroundR")
	BG = property.getNumber("BackroundG")
	BB = property.getNumber("BackroundB")
	BRT  = input.getNumber(2)
	abtemp = (input.getNumber(3)/35)*23
	abtemph = (input.getNumber(3)/35)*7

end

function onDraw()
	w = screen.getWidth()				 
	h = screen.getHeight()					
	
	screen.setColor(5, 5, 5)			
	screen.drawRectF(0, 0, w, h)
	
	screen.setColor(BR, BG, BB)			 
	screen.drawRectF(2, 2, w-4, h-11)
	
	screen.setColor(0, 0, 0, BRT)
	screen.drawTextBox(3, 2, w-4, 7, string.format("%.0f'C", temp), 0, 0)
	screen.drawTextBox(3, 16, w-4, 7, string.format("+%.0f'C", atemp), 0, 0)
	
	screen.drawTriangleF(5, 16, 5+abtemp, 16, 5+abtemp, 16-abtemph)
	
		screen.setColor(5, 5, 5,BRT)
	screen.drawTriangle(4, 15, w-5, 15, w-5, 9)
end