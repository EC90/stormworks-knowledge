-- source: steam id 2793900947 / vehicle.xml block#11
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947
function onTick()
	x=input.getNumber(1)
end

function onDraw()
w=screen.getWidth()
h=screen.getHeight()
	screen.setColor(0,100,0)
	screen.drawTriangleF(3,11.5,6,8.5,9,11.5)
		screen.setColor(0,150,0)
		screen.drawRect(3,12,6,9)
		x1 = 6 + 7 * math.cos(x-1.57)
		y1 = 16 + 7 * math.sin(x-1.57)
		screen.drawLine(6, 16, x1, y1)
end
