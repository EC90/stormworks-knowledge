-- source: steam id 3791754921 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3791754921
function onTick()
	value = input.getNumber(1)			
	text = property.getText("Screen4Text")
	BR = property.getNumber("BackroundR")
	BG = property.getNumber("BackroundG")
	BB = property.getNumber("BackroundB")
	BRT  = input.getNumber(2)
end

function onDraw()
	w = screen.getWidth()				 
	h = screen.getHeight()					
	
	screen.setColor(5, 5, 5)			
	screen.drawRectF(0, 0, w, h)
	
	screen.setColor(BR, BG, BB)			 
	screen.drawRectF(2, 2, w-4, h-11)
	
	screen.setColor(0, 0, 0, BRT)
	screen.drawTextBox(2, 3, w-4, 7, text, 0, -1)
	screen.drawTextBox(2, 16, w-4, 7, string.format("%.0f", value), 0, 0)
	
end