-- source: steam id 2807959992 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2807959992
function onTick()
	P = input.getNumber(1)
	R = input.getNumber(2)
	
	
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	
	screen.setColor(50,50,50)
	screen.drawLine(0,h/2,4,h/2)
	screen.drawLine(w,h/2,w-5,h/2)				
	screen.setColor(0, 250, 30,85)
	
	rad = w+h/4
	cx = w/2
	cy = h/2
	
	pitch = math.acos(P/90)
	roll = math.rad(90 - R)
	
	x1 = cx + rad*math.cos(roll + pitch)
	y1 = cy + rad*math.sin(roll + pitch)
	x2 = cx + rad*math.cos(roll - pitch)
	y2 = cy + rad*math.sin(roll - pitch)
	
	
	
	screen.drawLine(x1,y1,x2,y2)
	
	
end