-- source: steam id 2790345070 / vehicle.xml block#15
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2790345070
---Get all data from the sensors---
function onTick() 
	rainLevel = input.getNumber(1)
	fogDensity = input.getNumber(2)
	windSpeedBrut = input.getNumber(3)
	boatSpeed = input.getNumber(4)
	windDirectionBrut = input.getNumber(5)
	compassDirection = input.getNumber(6)
	temp = math.floor(input.getNumber(7))
	
	screenRed = input.getNumber(8)
	screenGreen = input.getNumber(9)
	screenBlue = input.getNumber(10)
	
	policeRed = input.getNumber(11)
	policeGreen = input.getNumber(12)
	policeBlue = input.getNumber(13)
	
	unit = input.getNumber(14)
	
	unitString = "Knots"
	
	valueOrWD = input.getNumber(15)
	
	windSpeed = math.abs(math.floor(windSpeedBrut - boatSpeed))
	windDirection = (((windDirectionBrut-compassDirection))*2*3.14)-1.57
	
	output.setBool(16, windWarning)
	if windSpeed >= 10 then
		windWarning = true
	else
		windWarning = false
	end
end


---Calculate weather depending on what are the data---
function calculateMeteoRain()
	if rainLevel==0 then return 'Not' 
	elseif 0.40>=rainLevel and rainLevel>0 then return 'light'
	elseif 0.70>=rainLevel and rainLevel>0.40 then return 'medium'
	elseif 0.70<rainLevel then return 'extreme'
	end
end


function calculateMeteoFog()
	if fogDensity>=0.30 and fogDensity<0.60 then return 'Bad' elseif fogDensity>=0.60 then return 'Very bad' elseif fogDensity<0.30 	then return "Good" end
end


function onDraw()
	width = screen.getWidth()
	height = screen.getHeight()
	
	
	if width == 160 and height == 96 then
		
		screen.setColor(screenRed,screenGreen,screenBlue)
		screen.drawClear()
		
		screen.setColor(255,255,255)
		if windSpeed<14 and rainLevel<=0.70 then 
			screen.setColor(10,255,10)
			screen.drawText(1,7*height/8,'Alerte: OK') 
		elseif windSpeed>=14 or rainLevel>0.70 then
			screen.setColor(255,10,10)
			screen.drawText(1,7*height/8,'Alert: Danger') 
		end
		screen.setColor(policeRed,policeGreen,policeBlue)
		screen.drawText(1,height/8,'Weather:')
		screen.drawText(1,2*height/8,'Temperature: ' .. temp)
		screen.drawText(1,3*height/8,'Rain: ' .. calculateMeteoRain())
		if unit == 1 then
			windSpeed = math.floor(windSpeed/1.944*100)/100
			unitString = 'm/s'
		end
		screen.drawText(1,4*height/8,'Wind: ' .. windSpeed .. ' ' .. unitString)
		screen.drawText(1,5*height/8,'Visibilty: ' .. calculateMeteoFog())
		
		screen.drawText(3*width/4-2,1*height/4-7,'N')
		screen.drawText(3*width/4-2,3*height/4+2,'S')
		screen.drawText(3*width/4-1*height/4-7,height/2-2,'W')
		screen.drawText(3*width/4+1*height/4+3,height/2-2,'E')
		
		---screen.drawLine(width/2,0,width/2,height)---
		screen.drawText(width/2+4,2,'Wind direction')
		screen.drawCircle(3*width/4,height/2,1*height/4)
		
		screen.setColor(255,0,0)
		screen.drawLine(3*width/4,height/2,(math.cos(windDirection-1.57))*(height/4)+(3*width/4),(math.sin(windDirection-1.57))*(height/4)+(height/2))
	end
	
	
	if width == 64 and height == 64 then
		screen.setColor(screenRed,screenGreen,screenBlue)
		screen.drawClear()
		if valueOrWD == 0 then 
			screen.drawText(1,1*height/8,'Weather:')
			screen.drawText(1,2*height/8,'Temp: ' .. temp)
			screen.drawText(1,3*height/8,'Rain: ' .. calculateMeteoRain())
			if unit == 1 then
				windSpeed = math.floor(windSpeed/1.944*100)/100
				unitString = 'm/s'
			end
			screen.drawText(1,4*height/8,'Wind:' .. windSpeed .. ' ' ..unitString)
			screen.drawText(1,5*height/8,'Fog: ' .. calculateMeteoFog())
		end
		
		if valueOrWD == 1 then
			screen.setColor(10, 10, 10)
			screen.drawRectF(0, 0, 23, 7)
			screen.setColor(100, 100, 100)
			screen.drawText(2,1,'Wind')
			screen.setColor(policeRed,policeGreen,policeBlue)
			screen.drawText(width/2-2,4,'N')
			screen.drawText(width/2-2,height-8,'S')
			screen.drawText(3,height/2-2,'W')
			screen.drawText(width-7,height/2-2,'E')
		
			---screen.drawLine(width/2,0,width/2,height)---
			screen.drawCircle(width/2,height/2,1*height/3)
		
			screen.setColor(255,0,0)
			screen.drawLine(width/2,height/2,(math.cos(windDirection))*(height/3)+(width/2),(math.sin(windDirection))*(height/3)+(height/2))
		end
	end
end