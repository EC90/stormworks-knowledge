-- source: steam id 2793900947 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947
si=math.sin
co=math.cos
pi=math.pi
pi2=pi*2
s=screen
ip=input

mx=gpsx
my=gpsy
zoom=1.5
zoomScale=zoom+zoom
focusZone=false
grid=250

function onTick()
	rx=ip.getNumber(1)
	ry=ip.getNumber(2)
	inputX=ip.getNumber(3)
	inputY=ip.getNumber(4)
	pressed=ip.getBool(1) and not isPressed--pulse
	isPressed=ip.getBool(1)

	gpsx=ip.getNumber(10)
	gpsy=ip.getNumber(11)

	compass=ip.getNumber(12)*pi2*-1
	alt=ip.getNumber(13)
	if alt<0 then alt=0 end

	zoomingIn=isPressed and iPIR(inputX,inputY,0,ry/5,6,ry/5)
	zoomingOut=isPressed and iPIR(inputX,inputY,0,ry/5*2,6,ry/5)
	reset=isPressed and iPIR(inputX,inputY,0,ry/5*3,6,ry/5)

	if reset then focusZone=false zoom=1.5 grid=250 end
	if isPressed and inputX>6 then focusZone=true end
	if focusZone then
		if pressed and inputX>6 then tx,ty=map.screenToMap(mx,my,zoom,rx,ry,inputX,inputY) end
		cx,cy=map.screenToMap(mx,my,zoom,rx,ry,rx/2,ry/2)
		mx=cx+((tx-cx)*0.05)
		my=cy+((ty-cy)*0.05)
	else
		mx=gpsx
		my=gpsy
	end
	if zoomingIn and zoom>0.1 then
		zoomScale=zoom+zoom
		zoom=zoom-(zoomScale/100)
	end
	if zoomingOut and zoom<50 then
		zoomScale=zoom+zoom
		zoom=zoom+(zoomScale/100)
	end
	if zoom>0 and zoom<0.2 then
		grid=25
	end
	if zoom>0.2 and zoom<0.5 then
		grid=50
	end
	if zoom>0.5 and zoom<1 then
		grid=100
	end
	if zoom>1 and zoom<2 then
		grid=250
	end
	if zoom>2 and zoom<5 then
		grid=500
	end
	if zoom>5 and zoom<10 then
		grid=1000
	end
	if zoom>10 and zoom<20 then
		grid=2000
	end
	if zoom>20 and zoom<40 then
		grid=4000
	end
	if zoom>40 then
		grid=8000
	end
end
function onDraw()
	w=s.getWidth()
	h=s.getHeight()

	s.drawMap(mx,my+alt,zoom)
	s.setMapColorOcean(0,10,0)
	s.setMapColorShallows(0,15,0)
	s.setMapColorLand(0,50,0)
	s.setMapColorGrass(0,70,0)
	s.setMapColorSand(0,60,0)
	s.setMapColorSnow(0,60,0)

    x1,y1=map.screenToMap(mx,my+alt,zoom,w,h,0,0)
    x2,y2=map.screenToMap(mx,my+alt,zoom,w,h,w,h)
    x1=math.floor(x1/grid)*grid
    y1=math.floor(y1/grid)*grid

	s.setColor(0,80,0,20)
    for xx=x1,x2,grid do
		x,y = map.mapToScreen(mx,my+alt,zoom,w,h,xx,y1)
		screen.drawLine(x,0,x,h)
    end
    for yy=y1,y2,-grid do
		x,y = map.mapToScreen(mx,my+alt,zoom,w,h,x1,yy)
		screen.drawLine(0,y,w,y)
    end

	dpsx,dpsy=map.mapToScreen(mx,my+alt,zoom,w,h,gpsx,gpsy)
	dpx,dpy=map.mapToScreen(mx,my,zoom,w,h,gpsx,gpsy)
	s.setColor(20,20,20,150)
	drawPointer(dpsx,dpsy+1,10,compass)--shadow
	s.setColor(255,255,255,60)
	s.drawLine(dpsx,dpsy,dpx,dpy)--line
	s.setColor(0,5,0)
	drawPointer(dpx,dpy,10,compass)

	s.setColor(0,80,0,150)
	s.drawRectF(0,h/5,6,h/5*3)

	if zoomingIn then s.setColor(0,0,0) else s.setColor(0,0,0)end
	s.drawTextBox(1,h/5,4,h/5,"+",0,0)
	if zoomingOut then s.setColor(0,0,0) else s.setColor(0,0,0)end
	s.drawTextBox(1,h/5*2,4,h/5,"-",0,0)
	if reset then s.setColor(0,0,0) else s.setColor(0,0,0)end
	s.drawTextBox(1,h/5*3,4,h/5,"r",0,0)

	if not focusZone then
		if w>100 then
		s.setColor(0,0,0,150)
		s.drawLine(dpsx-6,dpsy-5,dpsx-10,dpsy-9)
		s.drawLine(dpsx+6,dpsy-5,dpsx+10,dpsy-9)
		s.drawLine(dpsx+6,dpsy+6,dpsx+10,dpsy+10)
		s.drawLine(dpsx-6,dpsy+6,dpsx-10,dpsy+10)
		s.setColor(255,255,255)
		s.drawLine(w/2-6,h/2-6,w/2-10,h/2-10)
		s.drawLine(w/2+6,h/2-6,w/2+10,h/2-10)
		s.drawLine(w/2+6,h/2+5,w/2+10,h/2+9)
		s.drawLine(w/2-6,h/2+5,w/2-10,h/2+9)
		end
	else
		x=dpx
		y=dpy
		L=h/6
		s.setColor(0,0,0)
		s.drawRectF(w/2,h/2,1,1)
		if not iPIR(x,y,0,0,w,h) then
			x,y = w/2-x,h/2-y
			v = math.sqrt((x^2)+(y^2))
			x,y = x/v,y/v
			s.drawLine(w/2-x*2,h/2-y*2-1,w/2-x*L,h/2-y*L-1)
		end
	end

	s.setColor(255,255,255,30)
	s.drawRect(6,0,w-7,h-1)
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