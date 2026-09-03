-- source: steam id 2046605849 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2046605849
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
		
	X1 = input.getNumber(X1N)
	Y1 = input.getNumber(Y1N)
	BX1 = input.getBool(X1B)
	BY1 = input.getBool(Y1B)
	
	X2 = input.getNumber(X2N)
	Y2 = input.getNumber(Y2N)
	BX2 = input.getBool(X2B)
	BY2 = input.getBool(Y2B)

end


function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()					
	
	screen.setColor(0, 255, 0, 192)
	
	if BX2 then X2 = -X2 end
	if BY2 then Y2 = -Y2 end
	
	screen.drawLine(w/2 -1 + X2*10*w/32, 0, w/2 -1 + X2*10*w/32, h)
	screen.drawLine(0, h/2 -1 + Y2*10*w/32, w, h/2 -1 + Y2*10*w/32)
	
	
	screen.setColor(255, 0, 255, 192)
	
	if BX1 then X1 = -X1 end
	if BY1 then Y1 = -Y1 end
	
	screen.drawLine(w/2 -1 + X1*10*w/32, 0, w/2 -1 + X1*10*w/32, h)
	screen.drawLine(0, h/2 -1 + Y1*10*w/32, w, h/2 -1 + Y1*10*w/32)
end