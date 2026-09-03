-- source: steam id 2395501728 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2395501728
function onTick()
	w=input.getNumber(1)
	h=input.getNumber(2)
	ix=input.getNumber(3)
	iy=input.getNumber(4)
	x=input.getNumber(5)
	y=input.getNumber(6)
	z=input.getNumber(7)
	bd=input.getNumber(17)
	bx=input.getNumber(18)
	by=input.getNumber(19)
	bx1=input.getNumber(20)
	by1=input.getNumber(21)
	br1=input.getNumber(22)
	bx2=input.getNumber(23)
	by2=input.getNumber(24)
	br2=input.getNumber(25)
	bx3=input.getNumber(26)
	by3=input.getNumber(27)
	br3=input.getNumber(28)
	bxa=input.getNumber(29)
	bya=input.getNumber(30)
	bxb=input.getNumber(31)
	byb=input.getNumber(32)
	tX,tY=map.mapToScreen(x,y,z,w,h,wx,wy)
	bx1m,by1m=map.mapToScreen(x,y,z,w,h,bx1,by1)
	bx1m2,by1m2=map.mapToScreen(x,y,z,w,h,bx1,by1+br1)
	bx2m,by2m=map.mapToScreen(x,y,z,w,h,bx2,by2)
	bx2m2,by2m2=map.mapToScreen(x,y,z,w,h,bx2,by2+br2)
	bx3m,by3m=map.mapToScreen(x,y,z,w,h,bx3,by3)
	bx3m2,by3m2=map.mapToScreen(x,y,z,w,h,bx3,by3+br3)
	bxam,byam=map.mapToScreen(x,y,z,w,h,bxa,bya)
	bxbm,bybm=map.mapToScreen(x,y,z,w,h,bxb,byb)
	bxm,bym=map.mapToScreen(x,y,z,w,h,bx,by)
	isPressed=input.getBool(1) or input.getBool(2)
	isBP1=isPressed and isPointInRectangle(ix,iy,w-42,8,12,7)
	isBP2=isPressed and isPointInRectangle(ix,iy,w-27,8,12,7)
	isBP3=isPressed and isPointInRectangle(ix,iy,w-12,8,12,7)
	--isBP1a=bx1^2>0 or by1^2>0
	--isBP2a=bx2^2>0 or by2^2>0
	--isBP3a=bx3^2>0 or by3^2>0
	--isBPaa=bxa^2>0 or bya^2>0
	--isBPba=bxb^2>0 or byb^2>0
	output.setBool(6, isBP1)
	output.setBool(7, isBP2)
	output.setBool(8, isBP3)
end
function isPointInRectangle(x,y,rectX,rectY,rectW,rectH)
	return x>rectX and y>rectY and x<rectX+rectW and y<rectY+rectH
end
function onDraw()
	screen.setColor(255,255,0)
	if iswp then
		screen.drawLine(32,32,tX,tY)
	else
	end
	screen.setColor(0,175,0)
	screen.drawLine(bxam,byam,bx1m,by1m)
	screen.drawLine(bxam,byam,bx2m,by2m)
	screen.drawLine(bxbm,bybm,bx1m,by1m)
	screen.drawLine(bxbm,bybm,bx2m,by2m)
	screen.setColor(175,0,175)
	screen.drawCircle(bx1m,by1m,by1m2-by1m)
	screen.drawText(bx1m-2,by1m-2,"P1")
	screen.setColor(175,175,0)
	screen.drawCircle(bx2m,by2m,by2m2-by2m)
	screen.drawText(bx2m-2,by2m-2,"P2")
	screen.setColor(0,175,175)
	screen.drawCircle(bx3m,by3m,by3m2-by3m)
	screen.drawText(bx3m-2,by3m-2,"P3")
	screen.setColor(0,175,0)
	screen.drawCircle(bxam,byam,3)
	screen.drawCircle(bxbm,bybm,3)
	screen.drawLine(bxam,byam,bx1m,by1m)
	screen.drawLine(bxam,byam,bx2m,by2m)
	screen.drawLine(bxbm,bybm,bx1m,by1m)
	screen.drawLine(bxbm,bybm,bx2m,by2m)
	screen.setColor(255,255,255)
	screen.drawCircleF(bxm,bym,2)
	screen.drawLine(w/2,h/2,bxm,bym)
	screen.setColor(0,175,0)
	if isBP1 then
	screen.drawRectF(w-42,8,12,7)
	screen.setColor(0,0,0)
	screen.drawText(w-40,10,"P1")
	screen.setColor(0,175,0)
	else
	screen.drawText(w-40,10,"P1")
	end
	if isBP2 then
	screen.drawRectF(w-27,8,12,7)
	screen.setColor(0,0,0)
	screen.drawText(w-25,10,"P2")
	screen.setColor(0,175,0)
	else
	screen.drawText(w-25,10,"P2")
	end
	if isBP3 then
	screen.drawRectF(h-12,8,12,7)
	screen.setColor(0,0,0)
	screen.drawText(w-10,10,"P3")
	screen.setColor(0,175,0)
	else
	screen.drawText(w-10,10,"P3")
	end
	screen.drawText(w-20,h-48,"SIGN")
	screen.drawText(w-25,h-42,bd)
	screen.drawRectF(w-29,0,28,8)
	screen.setColor(0,0,0)
	screen.drawText(w-27,2,"BEACN")
	screen.setColor(0,175,0)
end