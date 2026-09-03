-- source: steam id 3603910667 / vehicle.xml block#51
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
function onTick()
	remain = input.getNumber(1)
	speed = input.getNumber(2)
	range = speed*remain/1000			 
end

function onDraw()

	w = screen.getWidth()				 
	h = screen.getHeight()					
	screen.setColor(0, 0, 0)			
	screen.drawClear()
	screen.setColor(0, 255, 0)
	
	if speed<5 then
		
	screen.drawTextBox(1, 4, w, 6, string.format("%s %s", "---", "Mins"), 0, 0)
	screen.drawTextBox(1, 20, w, 6, string.format("%s %s", "---", "km"), 0, 0)
	
	else
	
	screen.drawTextBox(1, 4, w, 6, string.format("%.1f %s", remain/60, "Mins"), 0, 0)
	screen.drawTextBox(1, 20, w, 6, string.format("%.1f %s", range, "km"), 0, 0)
	
	end
	
end