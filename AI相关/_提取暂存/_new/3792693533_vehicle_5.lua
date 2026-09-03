-- source: steam id 3792693533 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792693533
function drawPen(x,y,a,r,g,b)
	local a1=a+180
	local x1=x+2*math.sin(math.rad(a1))
	local y1=y-2*math.cos(math.rad(a1))
	
	local x2=x+5*math.sin(math.rad(a1))
	local y2=y-5*math.cos(math.rad(a1))
	
	local x2A=x2+2*math.sin(math.rad(a1-90))
	local y2A=y2-2*math.cos(math.rad(a1-90))
	
	local x2B=x2+1*math.sin(math.rad(a1+90))
	local y2B=y2-1*math.cos(math.rad(a1+90))
	
	screen.setColor(200,180,100)
	screen.drawTriangleF(x,y, x2A, y2A, x2B, y2B)
	screen.setColor(0,0,0)
	screen.drawLine(x,y,x1,y1)
	
	
	local x3=x+12*math.sin(math.rad(a1))
	local y3=y-12*math.cos(math.rad(a1))
	
	local x3A=x3+2*math.sin(math.rad(a1-90))
	local y3A=y3-2*math.cos(math.rad(a1-90))
	
	local x3B=x3+1*math.sin(math.rad(a1+90))
	local y3B=y3-1*math.cos(math.rad(a1+90))
	
	
	screen.setColor(r,g,b)
	screen.drawTriangleF(x2A, y2A, x2B, y2B, x3A,y3A )
	screen.drawTriangleF(x3A, y3A, x3B, y3B, x2B,y2B )

end

function drawPenShadow(x,y,a,alpha)
	local a1=a+180
	local x1=x+2*math.sin(math.rad(a1))
	local y1=y-2*math.cos(math.rad(a1))
	
	local x2=x+5*math.sin(math.rad(a1))
	local y2=y-5*math.cos(math.rad(a1))
	
	local x2A=x2+2*math.sin(math.rad(a1-90))
	local y2A=y2-2*math.cos(math.rad(a1-90))
	
	local x2B=x2+1*math.sin(math.rad(a1+90))
	local y2B=y2-1*math.cos(math.rad(a1+90))
	
	screen.setColor(0,0,0,alpha)
	screen.drawTriangleF(x,y, x2A, y2A, x2B, y2B)
	screen.drawLine(x,y,x1,y1)
	
	
	local x3=x+12*math.sin(math.rad(a1))
	local y3=y-12*math.cos(math.rad(a1))
	
	local x3A=x3+2*math.sin(math.rad(a1-90))
	local y3A=y3-2*math.cos(math.rad(a1-90))
	
	local x3B=x3+1*math.sin(math.rad(a1+90))
	local y3B=y3-1*math.cos(math.rad(a1+90))
	
	
	screen.drawTriangleF(x2A, y2A, x2B, y2B, x3A,y3A )
	screen.drawTriangleF(x3A, y3A, x3B, y3B, x2B,y2B )

end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

selectedColorID = 1

click=true
function onTick()	
	w=input.getNumber(1)
	h=input.getNumber(2)
	iX = input.getNumber(3)
	iY = input.getNumber(4)
	iP = input.getBool(1)
	
	cycleColor = iP and isPointInRectangle(iX, iY, w-23, h-20, 23, 20)
	
	if not iP then
		click=true
	end
	
	if click and cycleColor then
		if selectedColorID >= 4 then		
			selectedColorID = 1
		else
			selectedColorID = selectedColorID + 1
		end
		click=false
	end
	output.setNumber(1, selectedColorID)
end
	
penHOffset={}
function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	x0=w/2
	y0=h/2
	
	if selectedColorID == 1 then
		penHOffset[1] = 1
		drawPenShadow(w-20,h-14,0,100)
	else
		penHOffset[1] = 0
	end
	drawPen(w-20+penHOffset[1],h-14-penHOffset[1],0,5,5,5)
	
	if selectedColorID == 2 then
		penHOffset[2] = 1
		drawPenShadow(w-15,h-14,0,100)
	else
		penHOffset[2] = 0
	end
	drawPen(w-15+penHOffset[2],h-14-penHOffset[2],0,255,0,0)
	
	if selectedColorID == 3 then
		penHOffset[3] = 1
		drawPenShadow(w-10,h-14,0,100)
	else
		penHOffset[3] = 0
	end
	drawPen(w-10+penHOffset[3],h-14-penHOffset[3],0,0,255,0)
	
	if selectedColorID == 4 then
		penHOffset[4] = 1
		drawPenShadow(w-5,h-14,0,100)
	else
		penHOffset[4] = 0
	end
	drawPen(w-5+penHOffset[4],h-14-penHOffset[4],0,0,0,255)
end