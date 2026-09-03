-- source: steam id 3793328793 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793328793
pointX = {}
pointY = {}
timeago = {}


function onTick()
	pi = math.pi

	compass = input.getNumber(1)*pi*2
	
end

function onDraw()
	pi = math.pi
	w = screen.getWidth()
	h = screen.getHeight()
	padX = 0

	if w > h then 
		padX = (w-h)/2
		w = h 
	end

	R = property.getNumber("Red")
	G = property.getNumber("Green")
	B = property.getNumber("Blue")
	
	screen.setColor(255, 255, 255, 65)
	screen.drawText(w/2-2.0+padX+math.cos(compass-pi/2)*(h-8)/2, h/2-2.5+math.sin(compass-pi/2)*(h-8)/2, "N")
	screen.drawText(w/2-2.0+padX+math.cos(compass)*(h-8)/2, h/2-2.5+math.sin(compass)*(h-8)/2, "E")
	screen.drawText(w/2-2.0+padX+math.cos(compass+pi/2)*(h-8)/2, h/2-2.5+math.sin(compass+pi/2)*(h-8)/2, "S")
	screen.drawText(w/2-2.0+padX+math.cos(compass+pi)*(h-8)/2, h/2-2.5+math.sin(compass+pi)*(h-8)/2, "W")
	
	--Background
	screen.setColor(R, G, B, 65)
	screen.drawCircleF(w/2-0.5+padX, h/2-0.5, w/2)

end