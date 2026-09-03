-- source: steam id 2372828168 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2372828168
textOffsetS = 0
textOffsetA = 0
round = 0
degree = 0
function onTick()
	speed = input.getNumber(4)
	altitude = input.getNumber(5)
	bearing = input.getNumber(6)
	speed = speed*1.944
	speed = math.floor(speed+0.5)
	altitude = math.floor(altitude+0.5)
	if bearing >= 0 then
		degree = bearing*360
	else
		degree = 180 + (180-bearing*(-360))
	end
end
-- Draw function that will be executed when this script renders to a screen
function onDraw()
	screen.setColor(0, 0, 0, 100)
	screen.drawRectF(0, 0, 15, 64)
	screen.drawRectF(48, 0, 16, 64)
	screen.setColor(175, 175, 0)
	screen.drawTriangleF(32, 13, 27, 19, 37.5, 19)
	screen.drawRect(18, 13, 2, 1)
	screen.drawRect(44, 13, 2, 1)
	screen.setColor(255, 255, 255, 100)
	if speed < 100 then
	textOffsetS = 4
	end
	if speed < 10 then
	textOffsetS = 8
	end
	if altitude < 100 then
	textOffsetA = 4
	end
	if altitude < 10 then
	textOffsetA = 8
	end
	if speed >= 100 then
	textOffsetS = 0
	end
	if altitude >= 100 then
	textOffsetA = 0
	end
	screen.drawText(1 + textOffsetS, 14, speed+1)
	screen.drawText(1 + textOffsetS, 6, speed+2)
	screen.drawText(1 + textOffsetS, -2, speed+3)
	if speed > 3 then
	screen.drawText(1 + textOffsetS, 38, speed-1)
	screen.drawText(1 + textOffsetS, 46, speed-2)
	screen.drawText(1 + textOffsetS, 54, speed-3)
	end
	screen.drawText(49 + textOffsetA, 14, altitude+1)
	screen.drawText(49 + textOffsetA, 6, altitude+2)
	screen.drawText(49 + textOffsetA, -2, altitude+3)
	if altitude > 3 then
	screen.drawText(49 + textOffsetA, 38, altitude-1)
	screen.drawText(49 + textOffsetA, 46, altitude-2)
	screen.drawText(49 + textOffsetA, 54, altitude-3)
	end
	screen.setColor(0, 0, 0)
	screen.drawRectF(0, 22, 15, 8)
	screen.drawRectF(48, 22, 15, 8)
	screen.drawRectF(48, 56, 15, 8)
	screen.drawRectF(0, 56, 15, 8)
	screen.setColor(10, 10, 10)
	screen.drawRect(0, 22, 15, 8)
	screen.drawRect(48, 22, 15, 8)
	screen.drawRect(48, 56, 15, 8)
	screen.drawRect(0, 56, 15, 8)
	screen.setColor(250, 250, 250)
	screen.drawText(1 + textOffsetS, 24, speed)
	screen.drawText(49 + textOffsetA, 24, altitude)
	if altitude >= 1000 then
	round = altitude % 10
	screen.drawText(57, 58, round)
	end
	if altitude >= 10000 then
	round = altitude % 100
	screen.drawText(52, 58, round)
	end
end