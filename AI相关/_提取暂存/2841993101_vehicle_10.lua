-- source: steam id 2841993101 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2841993101
function onTick()
	clock = input.getNumber(1)
end

function onDraw()				
	screen.setColor(0, 0, 0, clock)
	screen.drawRectF(0, 0, 64, 64)			  
end