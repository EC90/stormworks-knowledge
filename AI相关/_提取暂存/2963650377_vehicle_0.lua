-- source: steam id 2963650377 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2963650377

function onTick()
	gear = input.getNumber(1)			 
	re = input.getNumber(2)		
end


function onDraw()
	w = screen.getWidth()				  
	h = screen.getHeight()					
	screen.setColor(100, 100, 100,255)			
	screen.drawCircle(w/2, h/2, 3)
	screen.drawLine(4, h/2, 28, h/2)
	screen.drawLine(4, 8, 4, 24)
	screen.drawLine(28, 8, 28, 24)
	
	if math.floor(re)<-0.2 then
	screen.setColor(255, 0, 0,255)
	else
	screen.setColor(100, 100, 100,255)
	end
	screen.drawText(2, 2, "R")
	
	if math.floor(gear)==1 then
	screen.setColor(255, 0, 0,255)
	else
	screen.setColor(100, 100, 100,255)
	end
	screen.drawText(2, 25, "1")
	
	if math.floor(gear)==2 then
	screen.setColor(255, 0, 0,255)
	else
	screen.setColor(100, 100, 100,255)
	end
	screen.drawText(26, 2, "2")
	
	if math.floor(gear)==3 then
	screen.setColor(255, 0, 0,255)
	else
	screen.setColor(100, 100, 100,255)
	end
	screen.drawText(26, 25, "3")
	
end