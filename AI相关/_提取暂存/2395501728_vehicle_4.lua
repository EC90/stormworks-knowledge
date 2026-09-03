-- source: steam id 2395501728 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2395501728
function onTick()
	isP=input.getBool(1) or input.getBool(2)
	w=input.getNumber(1)
	h=input.getNumber(2)
	ix=input.getNumber(3)
	iy=input.getNumber(4)
	x=input.getNumber(5)
	y=input.getNumber(6)
	z=input.getNumber(7)
	rr=input.getNumber(8)
	sx=input.getNumber(10)
	sy=input.getNumber(11)
	rx1=input.getNumber(12)
	ry1=input.getNumber(13)
	rw1=input.getNumber(14)
	rx2=input.getNumber(15)
	ry2=input.getNumber(16)
	rw2=input.getNumber(17)
	rx3=input.getNumber(18)
	ry3=input.getNumber(19)
	rw3=input.getNumber(20)
	rx4=input.getNumber(21)
	ry4=input.getNumber(22)
	rw4=input.getNumber(23)
	rx5=input.getNumber(24)
	ry5=input.getNumber(25)
	rw5=input.getNumber(26)
	rx6=input.getNumber(27)
	ry6=input.getNumber(28)
	rw6=input.getNumber(29)
	rx7=input.getNumber(30)
	ry7=input.getNumber(31)
	rw7=input.getNumber(32)
	rrx=0.5*math.sqrt(w^2+h^2)*math.sin(rr*6.28318)
	rry=0.5*math.sqrt(w^2+h^2)*math.cos(rr*6.28318)
	scx,scy=map.screenToMap(x,y,z,w,h,ix,iy)
	sc=isP and isPointInRectangle(ix,iy,10,15,w-10,h-22)
	c1x,c1y=map.mapToScreen(x,y,z,w,h,x,y+2500)
	c2x,c2y=map.mapToScreen(x,y,z,w,h,x,y+5000)
	r1x,r1y=map.mapToScreen(x,y,z,w,h,rx1,ry1)
	r2x,r2y=map.mapToScreen(x,y,z,w,h,rx2,ry2)
	r3x,r3y=map.mapToScreen(x,y,z,w,h,rx3,ry3)
	r4x,r4y=map.mapToScreen(x,y,z,w,h,rx4,ry4)
	r5x,r5y=map.mapToScreen(x,y,z,w,h,rx5,ry5)
	r6x,r6y=map.mapToScreen(x,y,z,w,h,rx6,ry6)
	r7x,r7y=map.mapToScreen(x,y,z,w,h,rx7,ry7)
	sxm,sym=map.mapToScreen(x,y,z,w,h,sx,sy)
	output.setNumber(1,scx)
	output.setNumber(2,scy)
	output.setBool(1,sc)
end
function isPointInRectangle(x,y,rectX,rectY,rectW,rectH)
	return x>rectX and y>rectY and x<rectX+rectW and y<rectY+rectH
end
function onDraw()
	screen.setColor(0,175,0)
	if isr1 or isr2 or isr3 or isr4 or isr5 or isr6 or isr7 then
	screen.drawCircleF(w/2,h/2,5)
	else
	end
	screen.drawCircle(w/2,h/2,c1y-h/2)
	screen.drawCircle(w/2,h/2,c2y-h/2)
	screen.drawRectF(0.5*w-15,0,28,8)
	screen.setColor(0,0,0)
	screen.drawText(0.5*w-13,2,"RADAR")
	screen.setColor(0,175,0)
	screen.drawLine(w/2,h/2,rrx+w/2,rry+h/2)
	if 390<rw1 and rw1<410 then
	screen.setColor(255,128,0)
	screen.drawText(r1x-2,r1y-2.5,"x")
	screen.setColor(0,175,0)
	else
	screen.drawText(r1x-2,r1y-2.5,"x")
	screen.drawText(r1x+2,r1y-2.5,rw1)
	end
	if 390<rw2 and rw2<410 then
	screen.setColor(255,128,0)
	screen.drawText(r2x-2,r2y-2.5,"x")
	screen.setColor(0,175,0)
	else
	screen.drawText(r2x-2,r2y-2.5,"x")
	screen.drawText(r2x+2,r2y-2.5,rw2)
	end
	if 390<rw3 and rw3<410 then
	screen.setColor(255,128,0)
	screen.drawText(r3x-2,r3y-2.5,"x")
	screen.setColor(0,175,0)
	else
	screen.drawText(r3x-2,r3y-2.5,"X")
	screen.drawText(r3x+2,r3y-2.5,rw3)
	end
	if 390<rw4 and rw4<410 then
	screen.setColor(255,128,0)
	screen.drawText(r4x-2,r4y-2.5,"x")
	screen.setColor(0,175,0)
	else
	screen.drawText(r4x-2,r4y-2.5,"x")
	screen.drawText(r4x+2,r4y-2.5,rw4)
	end
	if 390<rw5 and rw5<410 then
	screen.setColor(255,128,0)
	screen.drawText(r5x-2,r5y-2.5,"x")
	screen.setColor(0,175,0)
	else
	screen.drawText(r5x-2,r5y-2.5,"x")
	screen.drawText(r5x+2,r5y-2.5,rw5)
	end
	if 390<rw6 and rw6<410 then
	screen.setColor(255,128,0)
	screen.drawText(r6x-2,r6y-2.5,"x")
	screen.setColor(0,175,0)
	else
	screen.drawText(r6x-2,r6y-2.5,"x")
	screen.drawText(r6x+2,r6y-2.5,rw6)
	end
	if 390<rw7 and rw7<410 then
	screen.setColor(255,128,0)
	screen.drawText(r7x-2,r7y-2.5,"x")
	screen.setColor(0,175,0)
	else
	screen.drawText(r7x-2,r7y-2.5,"x")
	screen.drawText(r7x+2,r7y-2.5,rw7)
	end
	screen.setColor(0,175,175)
	screen.drawRectF(sxm-3,sym-3.5,6,7)
	screen.setColor(0,0,0)
	screen.drawText(sxm-2,sym-2.5,"R")
end