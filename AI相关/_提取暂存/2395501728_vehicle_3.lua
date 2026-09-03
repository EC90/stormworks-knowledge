-- source: steam id 2395501728 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2395501728
function onTick()
	isPressed=input.getBool(1) or input.getBool(2)
	isTRACKing=input.getBool(3)
	isIRing=input.getBool(4)
	isLSRing=input.getBool(5)
	w=input.getNumber(1)
	h=input.getNumber(2)
	ix=input.getNumber(3)
	iy=input.getNumber(4)
	isIR=isPressed and isPointInRectangle(ix,iy,0.5*w-14,0,27,8)
	isLSR=isPressed and isPointInRectangle(ix,iy,w-27,0,27,8)
	isTRACK=isPressed and isPointInRectangle(ix,iy,0,0,27,8)
	isCPM=isPressed and isPointInRectangle(ix,iy,0.4*w,0.75*h,0.2*w,0.05*h)
	isCPP=isPressed and isPointInRectangle(ix,iy,0.4*w,0.2*h,0.2*w,0.05*h)
	output.setBool(7, isTRACK)
	output.setBool(9, isLSR)
	output.setBool(12, isCPP)
	output.setBool(13, isCPM)
end
function isPointInRectangle(x,y,rectX,rectY,rectW,rectH)
	return x>rectX and y>rectY and x<rectX+rectW and y<rectY+rectH
end
function onDraw()
	screen.setColor(0,175,0)
	if isTRACKing then
	screen.drawRectF(0,0,27,8)
	screen.setColor(0,0,0)
	screen.drawText(2,2,"TRACK")
	screen.setColor(0,175,0)
	else
	screen.drawRect(0,0,27,8)
	screen.drawText(2,2,"TRACK")
	end
	if isLSRing then
	screen.drawRectF(w-28,0,27,8)
	screen.setColor(0,0,0)
	screen.drawText(w-26,2,"M A G")
	screen.setColor(0,175,0)
	else
	screen.drawRect(w-28,0,27,8)
	screen.drawText(w-26,2,"M A G")
	end
	screen.drawText(0.5*w-10,2,"ROPE")
	if isCPM then
	screen.drawTriangleF(0.4*w,0.75*h,0.6*w,0.75*h,0.5*w,0.8*h)
	screen.setColor(0,0,0)
	screen.setColor(0,175,0)
	else
	screen.drawTriangle(0.4*w,0.75*h,0.6*w,0.75*h,0.5*w,0.8*h)
	end
	if isCPP then
	screen.drawTriangleF(0.4*w,0.25*h,0.6*w,0.25*h,0.5*w,0.2*h)
	screen.setColor(0,0,0)
	screen.setColor(0,175,0)
	else
	screen.drawTriangle(0.4*w,0.25*h,0.6*w,0.25*h,0.5*w,0.2*h)
	end
end