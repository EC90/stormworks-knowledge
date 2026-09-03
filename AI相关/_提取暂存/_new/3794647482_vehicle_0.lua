-- source: steam id 3794647482 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794647482
function onTick()
	
	x = input.getBool(5)
	
end

function onDraw()
	
	if x then
		screen.setColor(50,0,0)
		screen.drawText(0,0,"mouse&wasd ctrl")
	else
		screen.setColor(0,50,0)
		screen.drawText(0,0,"wasd ctrl")
	end
end