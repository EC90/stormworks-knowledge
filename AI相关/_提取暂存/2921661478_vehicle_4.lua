-- source: steam id 2921661478 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2921661478
function onTick()
	inputX=input.getNumber(3)
	inputY=input.getNumber(4)
	isPressed=input.getBool(1)
	zoomin=isPressed and isPointInRectangle(inputX,inputY,0,0,6,6)
	output.setBool(1,zoomin)
	zoomout=isPressed and isPointInRectangle(inputX,inputY,0,7,6,6)
	output.setBool(2,zoomout)
end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	screen.setColor(5,5,5)
	screen.drawRectF(0,0,7,13)
	screen.setColor(3,3,3)
	screen.drawRectF(1,1,5,5)
	screen.drawRectF(1,7,5,5)
	screen.setColor(150,150,150)
	screen.drawRect(w/2,h/2,1,1)
	screen.drawRect(2,3,2,0)
	screen.drawRect(3,2,0,2)
	screen.drawRect(2,9,2,0)
end