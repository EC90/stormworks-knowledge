-- source: steam id 2395501728 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2395501728
-- Tick function that will be executed every logic tick
function onTick()
	FWD = input.getNumber(7)
	VTC = input.getNumber(8)
	ALT = input.getNumber(9)
	GND = input.getNumber(10)
	FWDa = input.getNumber(11)
	VTCa = input.getNumber(12)
end
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(20, 200, 20)
	screen.drawText(0, 0, "FWD")
	screen.drawText(0, 7, "VTC")
	screen.drawText(0, 14, "ALT")
	screen.drawText(0, 21, "GND")
	if FWD < -0.5
	then
	screen.setColor(222,20,20)
	else
	screen.setColor(20,222,20)
	end
	screen.drawText(17, 0, FWDa)
	if VTC < -0.5
	then
	screen.setColor(222,20,20)
	else
	screen.setColor(20,222,20)
	end
	screen.drawText(17, 7, VTCa)
	if ALT < 50
	then
	screen.setColor(222,20,20)
	screen.drawText(17, 14, ALT)
	else 
	if ALT > 1000
	then 
	screen.setColor(20,20,222)
	screen.drawText(17, 14, ALT*0.001)
	else
	screen.setColor(20,222,20)
	screen.drawText(17, 14, ALT)
	end
	end
	if GND < 50
	then
	screen.setColor(222,20,20)
	screen.drawText(17, 21, GND)
	else 
	if GND > 1000
	then 
	screen.setColor(20,20,222)
	screen.drawText(17, 21, GND*0.001)
	else
	screen.setColor(20,222,20)
	screen.drawText(17, 21, GND)
	end
	end
	if 5*VTC+GND < 0 or GND < 25 or ALT < 25
	then
	screen.setColor(222,20,20)
	screen.drawRectF(0, 27, 32, 6)
	screen.setColor(222,222,222)
	screen.drawText(1, 27, "PullUP")
	else
	screen.setColor(20,222,20)
	screen.drawText(6, 27, "safe")
	end
end