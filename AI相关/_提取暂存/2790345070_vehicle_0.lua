-- source: steam id 2790345070 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2790345070
function onTick()
	in1X = input.getNumber(3)
	in1Y = input.getNumber(4)
	in2X = input.getNumber(5)
	in2Y = input.getNumber(6)
	dist = input.getNumber(7)
	iP1 = input.getBool(1)
	iP2 = input.getBool(2)
	laserIn = input.getBool(3)
	
	isPointInRectangle = In
	iPUp1 = iP1 and In(in1X, in1Y, w-14, h-28, 12, 12)
	iPUp2 = iP2 and In(in2X, in2Y, w-14, h-28, 12, 12)
	
	iPDown1 = iP1 and In(in1X, in1Y, w-14, h-14, 12, 12)
	iPDown2 = iP2 and In(in2X, in2Y, w-14, h-14, 12, 12)
	
	iPRight1 = iP1 and In(in1X, in1Y, w-28, h-14, 12, 12)
	iPRight2 = iP2 and In(in2X, in2Y, w-28, h-14, 12, 12)
	
	iPLeft1 = iP1 and In(in1X, in1Y, w-42, h-14, 12, 12)
	iPLeft2 = iP2 and In(in2X, in2Y, w-42, h-14, 12, 12)
	
	iPPlus1 = iP1 and In(in1X, in1Y, w-14, 1, 12, 12)
	iPPlus2 = iP2 and In(in2X, in2Y, w-14, 1, 12, 12)
	
	iPMinus1 = iP1 and In(in1X, in1Y, w-14, 15, 12, 12)
	iPMinus2 = iP2 and In(in2X, in2Y, w-14, 15, 12, 12)
	
	iPLaser1 = iP1 and In(in1X, in1Y, 1, h-10, 27, 8)
	iPLaser2 = iP2 and In(in2X, in2Y, 1, h-10, 27, 8)
	
	if iPUp1 and iPDown2 or iPUp2 and iPDown1 then
		pitch = 0
	else
		if iPUp1 or iPUp2 then
			pitch = 1
		elseif iPDown1 or iPDown2 then
			pitch = -1
		else 
			pitch = 0
		end
	end
	output.setNumber(2, pitch)
	
	if iPRight1 and iPLeft2 or iPRight2 and iPLeft1 then
		rotate = 0
	else
		if iPRight1 or iPRight2 then
			rotate = -1
		elseif iPLeft1 or iPLeft2 then
			rotate = 1
		else
			rotate = 0
		end
	end
	output.setNumber(3, rotate)
	
	if iPPlus1 and iPMinus2 or iPPlus2 and iPMinus1 then
		zoomIn = false
		zoomOut = false
	else
		if iPPlus1 or iPPlus2 then
			zoomIn = true
		else
			zoomIn = false
		end
		
		if iPMinus1 or iPMinus2 then
			zoomOut = true
		else
			zoomOut = false
		end
	end
	output.setBool(4, zoomIn)
	output.setBool(5, zoomOut)
	
	if iPLaser1 or iPLaser2 then
		laserOut = true
	else
		laserOut = false
	end
	output.setBool(1, laserOut)
end


function In(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end


function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()

	if laserIn then
		screen.setColor(200, 0, 0)
		screen.drawTextBox(w/2-10, 1, 25, 5, string.format("%.0fm", dist), 0, 0)
		if dist == 4000 then
			screen.drawText(w/2-14, 1, ">")
		end
	end

	screen.setColor(50, 50, 50)
	screen.drawRectF(w-13, h-27, 11, 11)
	screen.drawRectF(w-13, h-13, 11, 11)
	screen.drawRectF(w-27, h-13, 11, 11)
	screen.drawRectF(w-41, h-13, 11, 11)
	screen.drawRectF(w-13, 2, 11, 11)
	screen.drawRectF(w-13, 16, 11, 11)
	screen.drawRectF(2, h-9, 26, 7)

	screen.setColor(10, 10, 10)
	screen.drawRect(w-14, h-28, 12, 12)
	screen.drawRect(w-14, h-14, 12, 12)
	screen.drawRect(w-28, h-14, 12, 12)
	screen.drawRect(w-42, h-14, 12, 12)
	screen.drawRect(w-14, 1, 12, 12)
	screen.drawRect(w-14, 15, 12, 12)
	screen.drawRect(1, h-10, 27, 8)

	if iPUp1 or iPUp2 then
	screen.setColor(200, 200, 200)
	else
	screen.setColor(10, 10, 10)
	end
	screen.drawTriangleF(w-12, h-17, w-3, h-16, w-8, h-26)

	if iPDown1 or iPDown2 then
	screen.setColor(200, 200, 200)
	else
	screen.setColor(10, 10, 10)
	end
	screen.drawTriangleF(w-12, h-11, w-3, h-12, w-8, h-2)

	if iPRight1 or iPRight2 then
	screen.setColor(200, 200, 200)
	else
	screen.setColor(10, 10, 10)
	end
	screen.drawTriangleF(w-27, h-2, w-27, h-12, w-17, h-7)

	if iPLeft1 or iPLeft2 then
	screen.setColor(200, 200, 200)
	else
	screen.setColor(10, 10, 10)
	end
	screen.drawTriangleF(w-30, h-2, w-30, h-12, w-40, h-7)	

	if iPPlus1 or iPPlus2 then
	screen.setColor(200, 200, 200)
	else
	screen.setColor(10, 10, 10)
	end
	screen.drawRectF(w-12, 6, 9, 3)
	screen.drawRectF(w-9, 3, 3, 9)

	if iPMinus1 or iPMinus2 then
	screen.setColor(200, 200, 200)
	else
	screen.setColor(10, 10, 10)
	end
	screen.drawRectF(w-12, 20, 9, 3)

	if laserIn == true then
	screen.setColor(200, 0, 0)
	else
	screen.setColor(10, 10, 10)
	end
	screen.drawText(3, h-8, "Laser")
	
	screen.setColor(50, 50, 50)
	screen.drawLine(w-27, h-3, w-27, h-13)
	screen.drawLine(w-31, h-3, w-31, h-13)
end