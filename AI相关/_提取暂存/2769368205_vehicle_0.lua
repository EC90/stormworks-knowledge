-- source: steam id 2769368205 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2769368205
-- Tick function that will be executed every logic tick
function onTick()
	throttle = input.getNumber(6)
	brake = input.getNumber(10)
	rps = input.getNumber(2)
	speed = input.getNumber(4)
	fuel = input.getNumber(5)
	gear = input.getNumber(3)
	motor = input.getNumber(7)
	tc = input.getBool(6)
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	screen.setColor(255,255,255)
	screen.drawText(screen.getWidth()/2-15,12+14,math.floor(speed*3.6))
	screen.drawText(screen.getWidth()/2+1,12+14,"KPH")
	screen.drawText(1,20,math.floor(fuel).."L")
	screen.setColor(25,5,5)
	screen.drawRectF(screen.getWidth()/2-2+11,25,1,-5)--brake--
	screen.setColor(5,25,5)
	screen.drawRectF(screen.getWidth()/2-2+13,25,1,-5)--throttle--
	screen.setColor(55,55,5)
	screen.drawRectF(screen.getWidth()/2-2+15,25,1,-5)--motor--
	screen.setColor(255,0,0)
	screen.drawRectF(screen.getWidth()/2-2+11,25,1,-brake*5)
	screen.setColor(0,155,0)
	screen.drawRectF(screen.getWidth()/2-2+13,25,1,-throttle*5)
	screen.setColor(200,200,0)
	screen.drawRectF(screen.getWidth()/2-2+15,25,1,-math.abs(motor*5))
	screen.setColor(255,255,255)
	if gear > 0 then
			screen.setColor(255,255,255)
			screen.drawText(screen.getWidth()/2-2,5+4,math.ceil(gear))
	else if gear == -1 then
			screen.setColor(255,0,0)
			screen.drawText(screen.getWidth()/2-2,5+4,"R")
	else if gear == -3 then
			screen.setColor(50,50,0)
			screen.drawText(screen.getWidth()/2-2,5+4,"P")
	else
			screen.setColor(255,255,255)
			screen.drawText(screen.getWidth()/2-2,5+4,"N")
		end
		end
		end
	if tc then 
		screen.setColor(200,0,0)
		screen.drawText(screen.getWidth()/2-2+9,15,"TC")
	end
	if rps > 33
		then
			screen.setColor(0,255,0)
			screen.drawRectF(1,2,2,2)
		else
			screen.setColor(2,2,2)
			screen.drawRectF(1,2,2,2)
		end
	if rps > 34
		then
			screen.setColor(0,255,0)
			screen.drawRectF(5,2,2,2)
		else
			screen.setColor(2,2,2)
			screen.drawRectF(5,2,2,2)
		end
	if rps > 35
		then
			screen.setColor(0,255,0)
			screen.drawRectF(9,2,2,2)
		else
			screen.setColor(2,2,2)
			screen.drawRectF(9,2,2,2)
		end
	if rps > 36
		then
			screen.setColor(255,0,0)
			screen.drawRectF(13,2,2,2)
		else
			screen.setColor(2,2,2)
			screen.drawRectF(13,2,2,2)
		end
			
	if rps > 37
		then
			screen.setColor(255,0,0)
			screen.drawRectF(17,2,2,2)
		else
			screen.setColor(2,2,2)
			screen.drawRectF(17,2,2,2)
		end
	if rps > 38.8
		then
			screen.setColor(255,0,0)
			screen.drawRectF(21,2,2,2)
		else
			screen.setColor(2,2,2)
			screen.drawRectF(21,2,2,2)
		end
	if rps > 39.5
		then
			screen.setColor(0,25,200)
			screen.drawRectF(25,2,2,2)
		else
			screen.setColor(2,2,2)
			screen.drawRectF(25,2,2,2)
		end		
	if rps > 40
		then
			screen.setColor(0,25,200)
			screen.drawRectF(29,2,2,2)
		else
			screen.setColor(2,2,2)
			screen.drawRectF(29,2,2,2)
		end
	screen.setColor(255,255,255)
end