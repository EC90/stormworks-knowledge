-- source: steam id 2810365309 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2810365309
function onTick()
	X = input.getNumber(1)
	Y = input.getNumber(2)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()	
	screen.setColor(80, 45, 0)
	screen.drawCircle(w / 2 + X, h / 2 + Y, 30)
	screen.setColor(0, 0, 0)
	screen.drawRectF(0 + X, 0 + Y, 28, 60)
	screen.drawRectF(69 + X, 0 + Y, 28, 60)
	
	screen.setColor(80, 45, 0)
	screen.drawCircle(w / 2 + X, h / 2 + Y, 17)
	screen.setColor(0, 0, 0)
	screen.drawRectF(0 + X, 0 + Y, 96, 45)
	
	screen.setColor(80, 45, 0)
	screen.drawLine(48 + X, 36 + Y, 48 + X, 85 + Y)
	screen.drawLine(42 + X, 48 + Y, 47 + X, 48 + Y)
	screen.drawLine(50 + X, 48 + Y, 55 + X, 48 + Y)
	
	screen.drawLine(42 + X, 54 + Y, 16 + X, 80 + Y)
	screen.drawLine(55 + X, 54 + Y, 81 + X, 80 + Y)
	
	screen.drawLine(40 + X, 46 + Y, 40 + X, 51 + Y)
	screen.drawLine(56 + X, 46 + Y, 56 + X, 51 + Y)
	
	screen.drawLine(46 + X, 69 + Y, 51 + X, 69 + Y)
	screen.drawLine(45 + X, 82 + Y, 52 + X, 82 + Y)
end