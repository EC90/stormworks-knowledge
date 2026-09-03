-- source: steam id 2395501728 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2395501728
function onTick()
	isPressed=input.getBool(1) or input.getBool(2)
	w=input.getNumber(1)
	h=input.getNumber(2)
	ix=input.getNumber(3)
	iy=input.getNumber(4)
	spd=input.getNumber(5)
	wind=input.getNumber(6)
	fog=input.getNumber(7)
	rain=input.getNumber(8)
	isCAM=input.getBool(3)
	isChange=isPressed and isPointInRectangle(ix,iy,0.5*w-8,h-8,16,8)
	isZI=isPressed and isPointInRectangle(ix,iy,0,0.5*h-14,7,8)
	isZR=isPressed and isPointInRectangle(ix,iy,0,0.5*h-4,7,7)
	isZO=isPressed and isPointInRectangle(ix,iy,0,0.5*h+6,7,8)
	isIR=isPressed and isPointInRectangle(ix,iy,78,44,17,8)
	output.setBool(3, isChange)
	output.setBool(4, isZI)
	output.setBool(5, isZO)
	output.setBool(6, isZR)
end
function isPointInRectangle(x,y,rectX,rectY,rectW,rectH)
	return x>rectX and y>rectY and x<rectX+rectW and y<rectY+rectH
end
function onDraw()
	screen.setColor(0,175,0)
	if isCAM then
	screen.drawText(0.5*w-6,h-6,"CAM")
	else
	screen.drawText(0.5*w-6,h-6,"MAP")
	end
	if isChange then
	screen.drawRectF(0.5*w-8,h-8,16,8)
	else
	screen.drawRect(0.5*w-8,h-8,16,8)
	end	
	screen.drawText(1,h-6,"RAI")
	screen.drawText(16,h-6,rain)
	screen.drawText(1,h-12,"FOG")
	screen.drawText(16,h-12,fog)
	screen.drawText(1,h-18,"WNd")
	screen.drawText(16,h-18,wind)
	screen.drawText(1,h-24,"SPD")
	screen.drawText(16,h-24,spd)
	if isZI then
	screen.drawTriangleF(1,0.5*h-7,7.4,0.5*h-7,4,0.5*h-13)
	else
	screen.drawTriangle(1,0.5*h-7,7.4,0.5*h-7,4,0.5*h-13)
	end
	if isZR then
	screen.drawCircleF(4,0.5*h,3.49)
	else
	screen.drawCircle(4,0.5*h,3.49)
	end
	if isZO then
	screen.drawTriangleF(1,0.5*h+7,7.4,0.5*h+7,4,0.5*h+13)
	else
	screen.drawTriangle(1,0.5*h+7,7.4,0.5*h+7,4,0.5*h+13)
	end
end