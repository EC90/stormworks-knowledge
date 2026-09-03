-- source: steam id 3793328793 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793328793
pointX = {}
pointY = {}
timeago = {}


function clean()
	tempX = {}
	tempY = {}
	tempago = {}
	
	for i=3, #timeago do 
		timeago[i] = timeago[i] + 1 
		if timeago[i] < 80 then 
			tempago[#tempago+1] = timeago[i]
			tempX[#tempX+1] = pointX[i]
			tempY[#tempY+1] = pointY[i]
		end
	end
	pointX = tempX
	pointY = tempY
	timeago = tempago	
end

function lerp(from, to, by)
    return from+((to-from)*by)
end

function onTick()
	pi = math.pi

	angle = input.getNumber(31)*pi*2-pi/2
	range = input.getNumber(30)
	
	clean()

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
		
	res = 1/5
	for i=1, (w+h-3)*res do
		timeago[#tempago+1] = 0
		pointX[#tempX+1] = w/2+math.cos(angle)*((w-1)/2)-0.5+padX
		pointY[#tempY+1] = h/2+math.sin(angle)*((h-1)/2)+0.5
	end
	
	--Rings
	screen.setColor(R, G, B, 255)
	screen.drawCircle(w/2-0.5+padX, h/2-0.5, w/2)
	screen.setColor(R, G, B, 100)
	screen.drawCircle(w/2-0.5+padX, h/2-0.5, (w/2)*0.25)
	screen.drawCircle(w/2-0.5+padX, h/2-0.5, (w/2)*0.50)
	screen.drawCircle(w/2-0.5+padX, h/2-0.5, (w/2)*0.75)
	
	--Dot Sweeper
	for i=1, #timeago do
		screen.setColor(R, G, B, 255/(timeago[i]/2))
		screen.drawTriangleF(pointX[i],pointY[i], pointX[i+1],pointY[i+1], w/2-0.5+padX,h/2-0.5)
	end
end