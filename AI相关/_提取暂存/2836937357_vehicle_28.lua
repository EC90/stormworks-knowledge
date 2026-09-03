-- source: steam id 2836937357 / vehicle.xml block#28
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2836937357
si=math.sin
co=math.cos
pi=math.pi
pi2=pi*2
s=screen
ip=input

zoom=15

function onTick()
	rx=ip.getNumber(1)
	ry=ip.getNumber(2)
	inputX=ip.getNumber(3)
	inputY=ip.getNumber(4)

	gpsx=ip.getNumber(10)
	gpsy=ip.getNumber(11)
	TIMEAR=ip.getNumber(14)
	DISTA=ip.getNumber(15)
	SPEED=ip.getNumber(16)
	
	compass=ip.getNumber(12)*pi2*-1
	alt=ip.getNumber(13)
	if alt<0 then alt=0 end
	
end
function onDraw()
	w=s.getWidth()
	h=s.getHeight()

	s.drawMap(gpsx,gpsy+alt,zoom)

    x1,y1=map.screenToMap(gpsx,gpsy+alt,zoom,w,h,0,0)
    x2,y2=map.screenToMap(gpsx,gpsy+alt,zoom,w,h,w,h)

	dpsx,dpsy=map.mapToScreen(gpsx,gpsy+alt,zoom,w,h,gpsx,gpsy)
	dpx,dpy=map.mapToScreen(gpsx,gpsy,zoom,w,h,gpsx,gpsy)
	s.setColor(0,0,0,150)
	drawPointer(dpsx,dpsy+1,10,compass)--shadow
	s.setColor(255,255,255,60)
	s.drawLine(dpsx,dpsy,dpx,dpy)--line
	s.setColor(255,255,255)
	drawPointer(dpx,dpy,10,compass) 
	
	s.setColor(44,112,181)
	s.drawLine(0, 54, 96, 54)
	s.setColor(0,0,0)
	s.drawRectF(0, 55, 96, 9)
	s.setColor(200,200,200)
	s.drawText(4,57,"EST:")
	s.drawText(45,57,"DIS:")
	
	if DISTA<=200 then
    s.drawText(65,57,"---")
    end 
    if DISTA>200 then
    s.drawText(65,57,string.format("%.0f" , DISTA ))
    end

    if TIMEAR<=2 or SPEED<10 then
    s.drawText(23,57,"---")
    end 
    if TIMEAR>60 and SPEED>10 then
    s.drawText(23,57,"1H+")
    end
    if TIMEAR>2 and TIMEAR<60  then
    s.drawText(23,57,string.format("%.0f" , TIMEAR ))
    s.drawText(34,57,"M")
    end

   

end

function iPIR(x,y,rX,rY,rW,rH)
return x>rX and y>rY and x<rX+rW and y<rY+rH
end
function drawPointer(x,y,s,r,...)
a=...
a=(a or 30)*pi/360
x=x+s/2*si(r)
y=y-s/2*co(r)
screen.drawTriangleF(x,y,x-s*si(r+a),y+s*co(r+a),x-s*si(r-a),y+s*co(r-a))
end