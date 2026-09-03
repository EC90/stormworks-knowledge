-- source: steam id 2840576784 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2840576784
function onTick()
	RED = input.getNumber(2)
	GREEN = input.getNumber(3)
	BLUE = input.getNumber(4)
	TRANSPARENCY = input.getNumber(5)
end

function onDraw()
	w = screen.getWidth()				
	h = screen.getHeight()					
	screen.setColor(RED,GREEN,BLUE,TRANSPARENCY)			
	screen.drawCircle(w / 2, h / 2, 10)   			
	screen.drawCircle(w / 2, h / 2, 5)
	screen.drawLine(0, h/2, w, h/2)
	screen.drawLine(w/2, 0, w/2, h)
end