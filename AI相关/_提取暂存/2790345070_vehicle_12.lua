-- source: steam id 2790345070 / vehicle.xml block#12
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2790345070

function onTick()
	dist = input.getNumber(11)
	seconds = dist/37
	hour = math.floor(seconds/3600)
	min = math.floor(seconds/60 - (hour*60))
	sec = math.floor(seconds - hour*3600 - min*60)
end


function onDraw()
	screen.setColor(10, 10, 10)
	screen.drawRectF(0, 0, 31, 7)
	
	screen.setColor(100, 100, 100)
	screen.drawText(9, 1, 'ETA')

	screen.setColor(100, 100, 100)
	screen.drawTextBox(-2, 9, 15, 5, hour, 1, 0)
	screen.drawText(16, 9, 'hr')
	
	screen.drawTextBox(3, 17, 10, 5, min, 1, 0)
	screen.drawText(16, 17, 'm')
	screen.drawText(20, 17, 'i')
	screen.drawText(23, 17, 'n')
	
	screen.drawTextBox(3, 25, 10, 5, sec, 1, 0)
	screen.drawText(16, 25, 'sec')
end