-- source: steam id 2551954944 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2551954944

function onTick()
	spd = input.getNumber(1)
	R = input.getNumber(2)
	G = input.getNumber(3)
	B = input.getNumber(4)
	Wh = input.getNumber(5)
	Bl = input.getNumber(6)
end


function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(R+Wh, G+Wh, B+Wh)
	screen.drawClear()
	
	screen.setColor(Wh, Wh, Wh)
	screen.drawRectF(0, 0, 32, 10)
	screen.drawRectF(0, 22, 32, 10)
	
	screen.setColor((R/3)+(Wh/6)+Bl, (G/3)+(Wh/6)+Bl, (B/3)+(Wh/6)+Bl)
	screen.drawRect(1, 11, 29, 10)
	screen.drawTextBox(1, 3, 32, 5, "SPEED", 0, 0)
	screen.drawTextBox(1, 25, 32, 5, "KM/H", 0, 0)
	
	screen.setColor(255-Wh, 255-Wh, 255-Wh)
	screen.drawRect(0, 10, 31, 12)
	screen.drawTextBox(0, 3, 32, 5, "SPEED", 0, 0)
	screen.drawTextBox(0, 14, 32, 5, string.format("%.0f", spd), 0, 0)
	screen.drawTextBox(0, 25, 32, 5, "KM/H", 0, 0)
	
end
