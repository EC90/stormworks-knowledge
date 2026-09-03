-- source: steam id 2409700748 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2409700748

function onTick()
	p1 = input.getBool(5) 
	p2 = input.getBool(6) 
	p3 = input.getBool(7) 
	p4 = input.getBool(8) 		
end


function onDraw()
	w = screen.getWidth()				  
	h = screen.getHeight()
						
	if p1 then screen.setColor(0,255,0) else screen.setColor(255,0,0) end
	screen.drawLine(8, 17, 8, 15)
	
	if p2 then screen.setColor(0,255,0) else screen.setColor(255,0,0) end
	screen.drawLine(11, 17, 11, 15)
	 
	if p3 then screen.setColor(0,255,0) else screen.setColor(255,0,0) end
	screen.drawLine(19, 17, 19, 15)
	
	if p4 then screen.setColor(0,255,0) else screen.setColor(255,0,0) end
	screen.drawLine(22, 17, 22, 15)	 
	
end	