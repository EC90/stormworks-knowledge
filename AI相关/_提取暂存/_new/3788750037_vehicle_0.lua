-- source: steam id 3788750037 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
-- Tick function that will be executed every logic tick
function onTick()
	Distance = math.floor(input.getNumber(1))
	Bearing = math.floor(input.getNumber(2)*360)
	AmmoL = math.floor(input.getNumber(3))
	AmmoR = math.floor(input.getNumber(4))
	
	TAmmo = AmmoL + AmmoR
end

function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(0, 0, 0)			 -- Set draw color to green
	screen.drawRectF(0, 0, w, 7)
	screen.drawRectF(0, h-7, w, 7)
	
	screen.setColor(255, 0, 0, 190)
	screen.drawCircle(w/2, h/2, 2)
	screen.drawLine(w/2, (h/2)+4, w/2, (h/2)+10)
	screen.drawLine(w/2, (h/2)-4, w/2, (h/2)-10)
	screen.drawLine((w/2)+4, h/2, (w/2)+10, h/2)
	screen.drawLine((w/2)-4, h/2, (w/2)-10, h/2)
	screen.drawText(1, 9, "R")
	screen.drawText(5, 9, ":")
	screen.drawTextBox(8, 9, 10, 5, TAmmo, 0, 0)
	

	
	screen.setColor(255, 255, 255)
	if Bearing < 0 then 
		screen.drawText(1, 1, "PORT")
		screen.drawTextBox((w/2)-7, 1, 15, 5, string.format('%03.0f',Bearing*-1), 0, 0)
	else
		screen.drawText(w-21, 1, "STBD")
		screen.drawTextBox((w/2)-7, 1, 15, 5, string.format('%03.0f',Bearing), 0, 0)
	end	
	screen.drawTextBox((w/2)-8, h-6, 20, 5, string.format('%04.0f',Distance), 0, 0)
	screen.drawText((h/2)+10, w-6, "M")
	screen.drawText((h/2)-19, w-6, "D")
	screen.drawText((h/2)-15, w-6, "I")
	screen.drawText((h/2)-12, w-6, "S")
	screen.drawText((h/2)-8, w-6, ":")
end
	
