-- source: steam id 3793328793 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793328793
pointX = {}
pointY = {}
timeago = {}

function clean()
	tempX = {}
	tempY = {}
	tempago = {}
	
	for i=1, #timeago do 
		timeago[i] = timeago[i] + 1 
		if timeago[i] < 120 then 
			tempago[#tempago+1] = timeago[i]
			tempX[#tempX+1] = pointX[i]
			tempY[#tempY+1] = pointY[i]
		end
	end
	pointX = tempX
	pointY = tempY
	timeago = tempago	
end

function onTick()
	pi = math.pi
	
	angle = input.getNumber(31)*pi*2-pi/2
	range = input.getNumber(30)
	
	lasttargetdist = targetdist
	target = input.getBool(1)
	targetdist = input.getNumber(1)
	targetangle = input.getNumber(2)*pi*2-pi/2
	
	clean()
	
	if target then --When target detected
		if targetdist <= range then
			pointX[#pointX+1] = (w/2)+math.cos(targetangle)*(targetdist/range)*(w/2)
			pointY[#pointY+1] = (h/2)+math.sin(targetangle)*(targetdist/range)*(h/2)
		else
			pointX[#pointX+1] = (w/2)+math.cos(targetangle)*((w/2)-1)
			pointY[#pointY+1] = (h/2)+math.sin(targetangle)*((h/2)-1)
		end
		timeago[#timeago+1] = 0
	end
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

	--Set Range
	screen.setColor(255, 255, 255)
	screen.drawText(1,h-5,math.floor(range))
	
	--Dots
	for i=1, #timeago do
		screen.setColor(255-(2*timeago[i]), 0, 0)
		screen.drawRectF(pointX[i]+padX, pointY[i], 1, 1)
	end
end