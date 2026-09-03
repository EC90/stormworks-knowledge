-- source: steam id 3228447235 / vehicle.xml block#27
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3228447235
function onTick()
	v1 = input.getNumber(1)
	v2 = input.getNumber(2)
	v3 = input.getNumber(3)
	a1 = input.getBool(1)
	a2 = input.getBool(2)
	a3 = input.getBool(3)
	l1 = property.getText("Ch.1 Label")
	l2 = property.getText("Ch.2 Label")
	l3 = property.getText("Ch.3 Label")
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	setC=screen.setColor
	format=string.format
	setC(10,10,10)
	screen.drawRectF(0, 0, w, h)
	setC(20,20,20)
	screen.drawRectF(0, 11, w, h)
	setC(10,10,10)
	screen.drawRectF(0, 21, w, h)
	
	if a1 then
		setC(60,60,60)
		screen.drawText(2, 1, l1)
		setC(255,255,255)
		screen.drawText(w-30, 6, format("%6.1f",v1))
	end
	if a2 then
		setC(60,60,60)
		screen.drawText(2, 11, l2)
		setC(255,255,255)
		screen.drawText(w-30, 16, format("%6.1f",v2))
	end
	if a3 then
		setC(60,60,60)
		screen.drawText(2, 21, l3)
		setC(255,255,255)
		screen.drawText(w-30, 26, format("%6.1f",v3))
	end
end