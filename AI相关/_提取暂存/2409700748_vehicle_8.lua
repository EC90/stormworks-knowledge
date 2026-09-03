-- source: steam id 2409700748 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2409700748
function onTick()
	setX = input.getNumber(9)
	setY = input.getNumber(10)
	
	displayX = math.floor(input.getNumber(9))
	displayY = math.floor(input.getNumber(10))
	
	deltaX = math.floor((input.getNumber(9) - input.getNumber(1)))
	output.setNumber(9, deltaX)
	
	deltaY = math.floor((input.getNumber(10) - input.getNumber(2)))
	output.setNumber(10, deltaY)
end
	
function onDraw()
	screen.getWidth()
	screen.getHeight()
	
	screen.setColor(0, 255, 0)
	
	screen.drawText(3, 5, "TGT")
	screen.drawText(3, 12, "X: ") screen.drawText(23, 12, displayX)
	screen.drawText(3, 19, "Y: ") screen.drawText(23, 19, displayY) 
	
	screen.drawText(3, 30, "derivative X - Y")
	screen.drawText(3, 37, deltaX)
	screen.drawText(3, 44, deltaY)
end