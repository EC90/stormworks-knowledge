-- source: steam id 2950778456 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2950778456
function onTick()
	PosWS = input.getNumber(1)
	NegWS = input.getNumber(2)
	X = input.getNumber(3)
	Y = input.getNumber(4)
	Gun = input.getBool(1)
end
	
function onDraw()
 if Gun then
	w = screen.getWidth()
	h = screen.getHeight()	
	screen.setColor(0, 255, 0)
	screen.drawRect(47 + X, 47 + Y, 1, 1)
	
	screen.drawLine(48 + X, 40 + Y + NegWS, 48 + X, 38 + Y + NegWS)
	screen.drawLine(47 + X, 55 + Y + PosWS, 47 + X, 57 + Y + PosWS)
	
	screen.drawLine(40 + X + NegWS, 48 + Y, 38 + X + NegWS, 48 + Y)
	screen.drawLine(55 + X + PosWS, 47 + Y, 57 + X + PosWS, 47 + Y)
	
	screen.drawLine(40 + X + (NegWS / 1.5), 41 + Y + (NegWS / 1.5), 42 + X + (NegWS / 1.5), 43 + Y + (NegWS / 1.5))
	screen.drawLine(53 + X + (PosWS / 1.5), 53 + Y + (PosWS / 1.5), 55 + X + (PosWS / 1.5), 55 + Y + (PosWS / 1.5))
	
	screen.drawLine(41 + X + (NegWS / 1.5), 54 + Y + (PosWS / 1.5), 43 + X + (NegWS / 1.5), 52 + Y + (PosWS / 1.5))
	screen.drawLine(54 + X + (PosWS / 1.5), 41 + Y + (NegWS / 1.5), 52 + X + (PosWS / 1.5), 43 + Y + (NegWS / 1.5))
  end
	
end