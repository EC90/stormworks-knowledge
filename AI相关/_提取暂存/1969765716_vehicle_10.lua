-- source: steam id 1969765716 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
--Flight Director
function onTick()
	X1N = property.getNumber("X Bar1 Input Channel")
	Y1N = property.getNumber("Y Bar1 Input Channel")
	X1B = property.getNumber("X Bar1 Rev Channel")
	Y1B = property.getNumber("Y Bar1 Rev Channel")
	
	X2N = property.getNumber("X Bar2 Input Channel")
	Y2N = property.getNumber("Y Bar2 Input Channel")
	X2B = property.getNumber("X Bar2 Rev Channel")
	Y2B = property.getNumber("Y Bar2 Rev Channel")
		
	X = input.getNumber(X1N)
	Y = input.getNumber(Y1N)
	BX = input.getBool(X1B)
	BY = input.getBool(Y1B)

end


function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()					
	
	screen.setColor(255, 0, 255, 255)
	
	if BX then X = -X end
	if BY then Y = -Y end
	
	screen.drawLine(w/2 -1 + X*10*w/32, 0, w/2 -1 + X*10*w/32, h)
	screen.drawLine(0, h/2 -1 + Y*10*w/32, w, h/2 -1 + Y*10*w/32)
end