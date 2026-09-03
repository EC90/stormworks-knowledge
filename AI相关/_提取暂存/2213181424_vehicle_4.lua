-- source: steam id 2213181424 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
-- Tick function that will be executed every logic tick
function onTick()

RRPS = input.getNumber(4)
SPD = input.getNumber(6)*1.94384		
ALT = input.getNumber(7)-4
dALT = input.getNumber(8)
DRPS = property.getNumber("Rotor Danger RPS")
WRPS = property.getNumber("Rotor Warn RPS")
MRPS = property.getNumber("Rotor Mean RPS")

DD = property.getNumber("Descent Danger")
DW = property.getNumber("Descent Warn")
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	screen.setColor(200, 200, 0)
		screen.drawRectF(16, 12, 1, 1)
		screen.drawLine(5, 12, 14, 12)
		screen.drawLine(18, 12, 28, 12)
		screen.drawLine(14, 12, 14, 14)
		screen.drawLine(18, 12, 18, 14)
	
	screen.setColor(0, 0, 0)
		screen.drawRectF(0, 24, 32, 12)
	
		screen.drawRectF(0, 1, 2, 23)
		screen.drawRectF(30, 1, 2, 23)
	
	
	
	screen.setColor(100, 0, 0)
	
	if RRPS > DRPS then
	screen.setColor(150, 112)
	end
	
	if RRPS > WRPS then
	screen.setColor(25, 50 , 100)
	end
	
	if RRPS > ((MRPS*2)-WRPS) then
	screen.setColor(150, 112, 0)
	end
	
	if RRPS > ((MRPS*2)-DRPS) then
	screen.setColor(100, 0, 0)
	end
	
		screen.drawRectF(0, 24, 2, -(RRPS/(MRPS*2))*23)
		
	
	screen.setColor(25, 50, 100)
	
	if -0.5 < dALT and dALT < 0 and ALT < 25 then
	screen.setColor(0, 50 , 0)
	end
	
	if -DW > dALT then
	screen.setColor(150, 112)
	end
	
	if -DD > dALT then
	screen.setColor(100, 0, 0)
	end
	
		screen.drawRectF(30, 13, 2, -(dALT/10)*11)
		

	screen.setColor(25, 50 , 100)
			
		screen.drawTextBox(1, 23, 16, 9, string.format("%.0f",SPD), -1, 0)
	
	if ALT < 0 then
		screen.setColor(100,0,0)
		screen.drawTextBox(16, 23, 16, 9, "SUB", 1, 0)
	else
		if ALT < 25 then
		screen.setColor(150,100,0)
		end
		if ALT < 999 then
		screen.drawTextBox(16, 23, 16, 9, string.format("%.0f",ALT), 1, 0)
		else
		screen.drawTextBox(16, 23, 16, 9, string.format("%.0f",ALT/1000), 1, 0)
		end
	
	end
	

end
