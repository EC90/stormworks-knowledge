-- source: steam id 3794647482 / vehicle.xml block#13
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794647482
dist = 0


function onTick()
	
	dist = input.getNumber(1)
	on = input.getBool(1)
	x = input.getBool(2)
	
end



function onDraw()
	
	w = screen.getWidth()
	h = screen.getHeight()
	cw = w/2
	ch = h/2
	
	
	if on then
		screen.setColor(70,10,10)
		screen.drawText(cw+3,ch-12,string.format("%.0f",dist)..",m")
	end
	if x then
		screen.setColor(50,0,0)
		screen.drawText(0,0,"mouse&wasd ctrl")
	else
		screen.setColor(0,50,0)
		screen.drawText(0,0,"wasd ctrl")
	end
	
end