-- source: steam id 2232448349 / vehicle.xml block#39
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2232448349
function onTick()
	hour = input.getNumber(1)
	m = input.getNumber(2)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()					
	screen.setColor(0,0,10)
	screen.drawClear()
	
	screen.setColor(255,255,255)
	screen.drawTextBox(0,1,w,h,string.format("%02.0f:%02.0f",hour,m),0,0)
end