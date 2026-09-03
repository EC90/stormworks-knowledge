-- source: steam id 2084796098 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2084796098
-- Tick function that will be executed every logic tick
function onTick()
	hum = input.getNumber(1)
	temp = input.getNumber(2)
	rain = input.getNumber(3)
	wind = input.getNumber(4)
	spead = input.getNumber(5)
	H = input.getNumber(6)
	M = input.getNumber(7)
	S = input.getNumber(8)
	
	windSpead = wind - spead
	
	
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(0, 250, 0)
	screen.drawText(w-60, h-60, 'hum '.. math.floor(hum*10^2)/10^2)	
	screen.drawText(w-60, h-48, 'temp '.. math.floor(temp*10^1)/10^1)	
	screen.drawText(w-60, h-36, 'rain '.. math.floor(rain*10^2)/10^2)	
	screen.drawText(w-60, h-24, 'wind '.. windSpead)
	screen.drawText(w-60, h-12, 'Time '.. math.floor(H).. ' : '.. math.floor(M))
	
	
end