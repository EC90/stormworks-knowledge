-- source: steam id 3793328793 / vehicle.xml block#15
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793328793
function isInRect(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
range = 1500
count = 30
onoff = false
function onTick()
	if range > 7500 then range = 7500 end
	if range < 500 then range = 500 end

	pressed = input.getBool(1)
	x = input.getNumber(3)
	y = input.getNumber(4)
	output.setNumber(1, range)
	output.setBool(1, onoff)
	output.setBool(2, map)
	onoff = false
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()					
	--Title
	screen.setColor(255, 255, 255)
	screen.drawRect(0,0,w-1,h/4)
	screen.drawText(2,2,"Range")
	
	--First Button
	screen.setColor(255, 255, 255)
	if isInRect(x, y, 0,h/4+1,w/2-1,h/4) and pressed then
		screen.drawRectF(0,h/4+1,w/2,h/4) 
		screen.setColor(0, 0, 0)
	else 
		screen.drawRect(0,h/4,w/2-1,h/4) 
	end
	screen.drawText(3,h/4+2,"-")
	if isInRect(x, y, 0,h/4+1,w/2-1,h/4) and count > 20  and pressed then
		count = 0
		range = range - 250
	end
	
	
	--Second Button
	screen.setColor(255, 255, 255)
	if isInRect(x, y, w/2,h/4+1,w/2-1,h/4) and pressed then 
		screen.drawRectF(w/2,h/4+1,w/2,h/4) 
		screen.setColor(0, 0, 0)
	else 
		screen.drawRect(w/2,h/4,w/2-1,h/4) 
	end
	screen.drawText(w/2+3,h/4+2,"+")
	if isInRect(x, y, w/2,h/4+1,w/2-1,h/4) and count > 20 and pressed then
		count = 0
		range = range + 250
	end
	
	--Third Button
	screen.setColor(255, 255, 255)
	if isInRect(x, y, 0,h/2+1,w-1,h/4) and pressed then 
		screen.drawRectF(0,h/2+1,w,h/4) 
		screen.setColor(0, 0, 0)
	else 
		screen.drawRect(0,h/2,w-1,h/4) 
	end
	screen.drawText(2,h/2+2,"On/Off")
	if isInRect(x, y, 0,h/2+1,w-1,h/4) and count > 20 and pressed then
		count = 0
		onoff = true
	end
	
	
	count=count+1
end