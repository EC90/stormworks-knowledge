-- source: steam id 2810365309 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2810365309
function onTick()
	Data = input.getBool(1)
	PosWS = input.getNumber(1)
	NegWS = input.getNumber(2)
	X = input.getNumber(3)
	Y = input.getNumber(4)
	WS = input.getNumber(5)
	D = input.getNumber(6)
end
	
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()	
	screen.setColor(255, 180, 0)
	screen.drawRect(47 + X, 47 + Y, 1, 1)
	
	screen.drawLine(48 + X, 40 + Y + NegWS, 48 + X, 38 + Y + NegWS)
	screen.drawLine(47 + X, 55 + Y + PosWS, 47 + X, 57 + Y + PosWS)
	
	screen.drawLine(40 + X + NegWS, 48 + Y, 38 + X + NegWS, 48 + Y)
	screen.drawLine(55 + X + PosWS, 47 + Y, 57 + X + PosWS, 47 + Y)
	
	screen.drawLine(40 + X + (NegWS / 1.5), 41 + Y + (NegWS / 1.5), 42 + X + (NegWS / 1.5), 43 + Y + (NegWS / 1.5))
	screen.drawLine(53 + X + (PosWS / 1.5), 53 + Y + (PosWS / 1.5), 55 + X + (PosWS / 1.5), 55 + Y + (PosWS / 1.5))
	
	screen.drawLine(41 + X + (NegWS / 1.5), 54 + Y + (PosWS / 1.5), 43 + X + (NegWS / 1.5), 52 + Y + (PosWS / 1.5))
	screen.drawLine(54 + X + (PosWS / 1.5), 41 + Y + (NegWS / 1.5), 52 + X + (PosWS / 1.5), 43 + Y + (NegWS / 1.5))
	
	if Data then
		screen.drawText(4, 85, string.format("%.1f", WS))
		screen.drawText(24, 85, "M")
		screen.drawText(69, 85, string.format("%.0f", D))
		screen.drawText(87, 85, "M")
	end
end