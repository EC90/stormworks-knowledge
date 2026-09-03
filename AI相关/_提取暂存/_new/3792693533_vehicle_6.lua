-- source: steam id 3792693533 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792693533
function drawPin(x,y,r,g,b)
	screen.setColor(25,25,25)
	screen.drawTriangleF(x,y, x-2, y-5, x+2, y-5)
	
	screen.setColor(r,g,b)
	screen.drawTriangleF(x-3, y-4, x, y-7, x+4, y-4 )
	screen.drawTriangleF(x-3, y-10, x, y-7, x+4, y-10 )
	
	screen.drawTriangleF(x-1, y-4, x-1, y-10, x+2, y-4 )
	screen.drawTriangleF(x-1, y-10, x+2, y-4, x+2, y-10 )
end


function drawRuler(x,y,r,g,b)
	local L=35
	local H=7
	
	screen.setColor(r,g,b)
	screen.drawRectF(x, y,L,H)
	
	screen.setColor(10,10,10)
	screen.drawLine(x+1, y+H-1, x+1, y+H-5)
	screen.drawLine(x+L-2, y+H-1, x+L-2, y+H-5)
	for i=0,L-6,2 do
		screen.drawLine(x+3+i, y+H-1, x+3+i, y+H-3)
	end
	for i=6,L-6,8 do
		screen.drawLine(x+3+i,y+H-1,x+3+i,y+H-4)
	end
end

function drawCompass(x,y,r,g,b)
	screen.setColor(25,25,25)
	screen.drawRectF(x-1, y, 3, 9)
	screen.setColor(15,15,15)
	screen.drawCircle(x, y+5, 3)
	screen.setColor(30,30,30)
	screen.drawTriangleF(x-4, y+25, x-2, y+8, x, y+8 )
	screen.drawLine(x-4, y+25, x, y+8)
	screen.drawTriangleF(x+4, y+25, x+2, y+8, x, y+8 )
	screen.drawLine(x+4, y+25, x, y+8)
	screen.setColor(20,20,20)
	screen.drawCircleF(x, y+7, 3)
	screen.setColor(50,50,50)
	screen.drawCircleF(x, y+7, 1.5)
end

function drawEraser(x,y,r,g,b)
	screen.setColor(5,50,45)
	screen.drawRectF(x,y, 14, 7)
	screen.drawRectF(x-1,y+1, 1, 5)
	screen.setColor(100,0,10)
	screen.drawRectF(x+7,y, 7, 7)
	screen.drawRectF(x+14,y+1, 1, 5)
	screen.setColor(150,150,150)
	screen.drawRectF(x+6,y, 2, 7)
	
end


function drawPinShadow(x,y,a)
	screen.setColor(0,0,0,a)
	screen.drawTriangleF(x,y, x-2, y-5, x+2, y-5)
	
	screen.drawTriangleF(x-3, y-4, x, y-7, x+4, y-4 )
	screen.drawTriangleF(x-3, y-10, x, y-7, x+4, y-10 )
	
	screen.drawTriangleF(x-1, y-4, x-1, y-10, x+2, y-4 )
	screen.drawTriangleF(x-1, y-10, x+2, y-4, x+2, y-10 )
end

function drawRulerShadow(x,y,a)
	local L=35
	local H=7
	
	screen.setColor(0,0,0,a)
	screen.drawRectF(x,y,L,H)
end

function drawCompassShadow(x,y,a)
	screen.setColor(0,0,0,a)
	screen.drawRectF(x-1, y, 3, 9)
	screen.drawCircle(x, y+5, 3)
	screen.drawTriangleF(x-4, y+25, x-2, y+8, x, y+8 )
	screen.drawLine(x-4, y+25, x, y+8)
	screen.drawTriangleF(x+4, y+25, x+2, y+8, x, y+8 )
	screen.drawLine(x+4, y+25, x, y+8)
	screen.drawCircleF(x, y+7, 3)
	screen.drawCircleF(x, y+7, 1.5)
end
function drawEraserShadow(x,y,a)
	screen.setColor(0,0,0,a)
	screen.drawRectF(x,y, 14, 7)
	screen.drawRectF(x-1,y+1, 1, 5)
	screen.drawRectF(x+14,y+1, 1, 5)
end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

selectedToolID = 0

click=true
function onTick()	
	w=input.getNumber(1)
	h=input.getNumber(2)
	iX = input.getNumber(3)
	iY = input.getNumber(4)
	iP = input.getBool(1)
	
	compassTool = iP and isPointInRectangle(iX, iY, 0,0,12,28)
	eraserTool = iP and isPointInRectangle(iX, iY, 18-2,2-1,18,9)
	rulerTool = iP and isPointInRectangle(iX, iY, w-38,2-1,37,9)
	pinTool = iP and isPointInRectangle(iX, iY, w-12,25-12,10,11)
	
	if not iP then
		click=true
	end
	
	if click and compassTool then
		if selectedToolID == 1 then
			selectedToolID = 0
		else
			selectedToolID = 1
		end
		click=false
	end
	if eraserTool then
		selectedToolID = 0
		output.setBool(1,true)
	else
		output.setBool(1,false)
	end
	if click and rulerTool then
		if selectedToolID == 3 then
			selectedToolID = 0
		else
			selectedToolID = 3
		end
		click=false
	end
	if click and pinTool then
		if selectedToolID == 4 then
			selectedToolID = 0
		else
			selectedToolID = 4
		end
		click=false
	end
	output.setNumber(1, selectedToolID)
end
offset={}
function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	x0=w/2
	y0=h/2
	
	
	if selectedToolID == 4 then
		offset[4]=2
		drawPinShadow(w-7,25,100)
	else
		offset[4]=0
	end
	drawPin(w-7+offset[4],25-offset[4],255,5,5)
	---
	if selectedToolID == 3 then
		offset[3]=2
		drawRulerShadow(w-37,2,100)
	else
		offset[3]=0
	end
	drawRuler(w-37+offset[3],2-offset[3],100,50,0)
	---
	if eraserTool then
		offset[2]=2
		drawEraserShadow(18,2,100)
	else
		offset[2]=0
	end
	drawEraser(18-offset[2],2-offset[2],0,0,0)
	---
	if selectedToolID == 1 then
		offset[1]=2
		drawCompassShadow(6,2,100)
	else
		offset[1]=0
	end
	drawCompass(6-offset[1],2-offset[1],15,15,15)
end