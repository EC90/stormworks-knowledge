-- source: steam id 2871941850 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2871941850
function onTick()
	speed = input.getNumber(1)
	gpsZ = input.getNumber(2)
	ang = input.getNumber(3)
	
	laser = input.getBool(2)
	autohover = input.getBool(3)
end

function enabled(bool)
	if bool then screen.setColor(0,255,0,200) else screen.setColor(255,0,0,200)	end
end

function onDraw()
	screen.setColor(0,255,0,200)
	
	screen.drawText(0,0, "SPD:"..("%.1f"):format(speed))
	screen.drawText(0,10, "ALT:"..("%.1f"):format(gpsZ))

	screen.drawText(0,20, "ANG:"..("%.0f"):format(ang/0.0055))

	enabled(laser)
	screen.drawText(72,0,"Laser")
	
	enabled(autohover)
	screen.drawText(72,10,"Hover")
end