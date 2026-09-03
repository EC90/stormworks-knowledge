-- source: steam id 2790345070 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2790345070
-- Tick function that will be executed every logic tick
function onTick()
	min = math.floor((input.getNumber(5)+0.5)/60)

	
	level = input.getNumber(6)
	cap = input.getNumber(7)
	percent = math.floor(((level/cap)*100)+ 0.5)
	
	range = math.floor(37*60/1000*min)
	
	if min > 999 then
		min = 999
	end
	if min < 0 then
		min = 0
	end
	
	if range > 999 then
		range = 999
	end
	if range < 0 then
		range = 0
	end
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	screen.setColor(0, 100, 0, 200)
	screen.drawRectF(4, 4, 4, 25)
	screen.setColor(0, 0, 200, 200)
	screen.drawRectF(4, 29, 4, -(percent/4)+1)
	screen.setColor(255, 255, 255)
	screen.drawLine(4, (25 - (percent/4))+4 , 8, (25 - (percent/4))+4)
	screen.setColor(255, 255, 255, 200)
	screen.drawText(13, 13, percent)
	screen.drawText(15, 19, '%')
	screen.setColor(100, 100, 0)
	screen.drawRect(11, 11, 17, 15)
	screen.drawRect(0, 0, 31, 31)
	screen.drawRect(31, 0, 32, 31)
	
	screen.setColor(50, 50, 50)
	screen.drawText(11, 4, "Fuel")
	
	screen.drawText(35, 3, 'F')
	screen.drawText(45, 3, 'T')
	screen.drawText(48, 3, 'i')
	screen.drawText(51, 3, 'me')
	
	screen.drawText(35, 17, 'Range')
	
	
	screen.setColor(200, 200, 200)
	screen.drawTextBox(34, 9, 15, 5, min, 0, 0)
	screen.drawText(50, 9, 'm')
	screen.drawText(54, 9, 'i')
	screen.drawText(57, 9, 'n')
	
	screen.drawTextBox(34, 23, 15, 5, range, 0, 0)
	screen.drawText(51, 23, 'km')
end