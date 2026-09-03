-- source: steam id 2013584399 / vehicle.xml block#15
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2013584399
zoom = 2.5

windSpd = 0
windDir = 0

rain = 0
humid = 0
time = 0

formattedTime = ""
weather = ""
visibility = ""


function onTick()

	
	windSpd = input.getNumber(3)
	windDir = input.getNumber(4)
	
	rain = input.getNumber(5)
	humid = input.getNumber(6)
	time = input.getNumber(7)
	
	compassDir = input.getNumber(8) * -1
	
end


function onDraw()
	
	--wind direction
	local newWindDir = windDir + compassDir + 0.5
	newWindDir = newWindDir - math.floor(newWindDir)
	
	
	--time
	local minutes = math.floor((1440 * time) % 60)
	local hours = math.floor(24 * time)
	
	if minutes < 10 then minutes = '0' .. minutes end
	if hours < 10 then hours = '0' .. hours end
	
	formattedTime = hours .. ':' .. minutes
	
	--weather
	if rain < 0.01 then weather = 'No Rain'
	elseif rain < 0.50 then weather = 'Light Rain'
	elseif rain < 0.70 then weather = 'Rainy'
	elseif rain < 0.90 then weather = 'Heavy Rain'
	else weather = 'Stormy' end
	
	--visibility
	if humid < 0.10 then visibility = 'Good'
	elseif humid < 0.40 then visibility = 'Moderate'
	else visibility = 'Poor' end
	
	--screen
	w = screen.getWidth()
	h = screen.getHeight()
	
	
	screen.setColor(0, 0, 0)
	screen.drawRectF(0, 0, 52, h)
	screen.setColor(255, 255, 255)
	screen.drawLine(52, 0, 52, h)
	screen.drawLine(0, 16, 52, 16)
	screen.drawLine(0, 75, 52, 75)
	
	
	screen.drawText(1, 2, formattedTime)
	screen.drawText(1, 9, weather)
	screen.drawText(1, 19, 'Wind')
	screen.drawText(1, 26, math.floor((windSpd * 1.943844) + 0.5) .. ' knots')
	screen.drawText(1, 33, math.floor((newWindDir * 360) + 0.5) .. ' deg')
	screen.drawText(1, 80, 'Visibility')
	screen.drawText(1, 87, visibility)
	
	screen.drawRectF(25, 53, 3, 3)
	screen.setColor(0, 200, 0)
	
	newWindDir = newWindDir * 6.283185
	screen.drawLine(26, 54, 26 + (math.sin(newWindDir) * math.min(windSpd, 15)), 54 + (math.cos(newWindDir) * math.min(windSpd, 15) * -1))
	
end