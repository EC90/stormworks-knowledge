-- source: steam id 3788750037 / vehicle.xml block#40
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
function onTick()
	Brit = input.getNumber(1)			
end
function onDraw()
screen.setColor(0, 0, 0, Brit)
screen.drawRectF(0, 0, 96, 64)
end