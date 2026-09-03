-- source: steam id 2213181424 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
-- Tick function that will be executed every logic tick
function onTick()
	time = input.getNumber(5)	
	temp = input.getNumber(6)
	intercomm = input.getNumber(7)

			 
	hr = time*24
	min = (hr-math.floor(time*24))*60
	
end

function onDraw()
	w = screen.getWidth()				  
	h = screen.getHeight()					
	screen.setColor(0, 0, 0)			
	screen.drawClear()
	
	screen.setColor(25, 50 ,100)
	
	screen.drawTextBox(0, 1,w,7, string.format('%02.0f:%02.0f', hr, min),0,0)
		
	if temp <0 then
		screen.setColor(100, 0, 0)
	elseif temp <5 then
		screen.setColor(150, 112, 0)		
	end
	screen.drawTextBox(0, 8, w, 7, string.format("%.0fC",temp), 0, 0)
	screen.setColor(25,50,100)
	
	screen.drawLine(0, 15, 32, 15)
		
	screen.drawTextBox(1, 16, w, 7,"INTCOM", 0, 0)
	
	if intercomm <= 999 then
	screen.drawTextBox(0, 23, w, 7,string.format("CH:%.0f",intercomm), 0, 0)
	else
	screen.drawTextBox(0, 23, w, 7,"CH:ERR", 0, 0)
	end
	

end