-- source: steam id 2232448349 / vehicle.xml block#14
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2232448349
Pi = 3.14159

function onTick()
	scale = property.getNumber("Multiplier")
	MaxScale = property.getNumber("Max Scale") --Maximum scale of input for dial scale
	PV = math.floor(input.getNumber(1)*scale) --process value
	PinAngle = PV/(MaxScale)*2*Pi --finding the needles angle
	dispName = property.getText("Name") -- get display name

end

function onDraw()
	w = 30
	h = 30
	
	screen.setColor(0, 0, 0)
	screen.drawRectF(32, 0, 32, 32)
	
	screen.setColor(255, 255, 255)
	screen.drawTextBox(10+32, 21, 20, 5, PV, 1, 0)
	screen.drawTextBox(8+32, 9, 16, 5, dispName, 0, 0)
	
	screen.setColor(255, 0, 0)
	for Ang = Pi/4, 0, -Pi/100
	do
		screen.drawLine(w/2+32+14*math.cos(Ang), h/2-14*math.sin(Ang), w/2+32+16*math.cos(Ang), h/2-16*math.sin(Ang))
	end

	screen.setColor(255, 255, 255)
	for Ang = Pi*3/2, -0.01, -Pi/4
	do
		screen.drawLine(w/2+32+13*math.cos(Ang), h/2-13*math.sin(Ang), w/2+32+16*math.cos(Ang), h/2-16*math.sin(Ang))
	end
	
	for Ang = Pi*3/2, Pi/8, -Pi/8
	do
		screen.drawLine(w/2+32+15*math.cos(Ang), h/2-15*math.sin(Ang), w/2+32+16*math.cos(Ang), h/2-16*math.sin(Ang))
	end
	
	screen.setColor(255, 0, 0)
	screen.drawLine(w/2+32, h/2, w/2+32-16*math.cos(Pi*3/2+PinAngle*3/4), h/2-16*math.sin(Pi*3/2+PinAngle*3/4))
	
end