-- source: steam id 2213181424 / vehicle.xml block#46
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
gN=input.getNumber
si=math.sin
co=math.cos
pi=math.pi
pi2=pi*2
sC=screen.setColor
dL=screen.drawLine
dTB=screen.drawTextBox
ip=input
s=screen

mx=gpsx
my=gpsy
zoom=1.5
zoomScale=zoom+zoom
focusZone=false
grid=250

function onTick()
act=input.getBool(32)
if act then
	rx=gN(1)
	ry=gN(2)
	inputX=gN(3)
	inputY=gN(4)
	pressed=(ip.getBool(1) and not isPressed) and not iPIR(inputX, inputY,15, 59, 33,5)
	isPressed=ip.getBool(1)
	gpsx=gN(10)
	gpsy=gN(11)
	compass=gN(12)*pi2*-1
	alt=gN(13)
	if alt<0 then alt=0 end
	zoomingIn=isPressed and iPIR(inputX,inputY,0,ry/5,6,ry/5)
	zoomingOut=isPressed and iPIR(inputX,inputY,0,ry/5*2,6,ry/5)
	reset=isPressed and iPIR(inputX,inputY,0,ry/5*3,6,ry/5)
	Rtn = isPressed and iPIR(inputX, inputY, 15, 59, 33, 5)
	output.setBool(32, Rtn)

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
end
function onDraw()
if act then
	w=s.getWidth()
	h=s.getHeight()

	s.drawMap(mx,my+alt,zoom)
	s.setMapColorOcean(5,5,5)
	s.setMapColorShallows(8,8,8)
	s.setMapColorLand(25,25,25)
	s.setMapColorGrass(35,35,35)
	s.setMapColorSand(30,30,30)
	s.setMapColorSnow(30,30,30)

    x1,y1=map.screenToMap(mx,my+alt,zoom,w,h,0,0)
    x2,y2=map.screenToMap(mx,my+alt,zoom,w,h,w,h)
    x1=math.floor(x1/grid)*grid
    y1=math.floor(y1/grid)*grid

	sC(0,0,0,20)

    for xx=x1,x2,grid do
		x,y = map.mapToScreen(mx,my+alt,zoom,w,h,xx,y1)
		dL(x,0,x,h)
    end
    for yy=y1,y2,-grid do
		x,y = map.mapToScreen(mx,my+alt,zoom,w,h,x1,yy)
		dL(0,y,w,y)
    end

	dpsx,dpsy=map.mapToScreen(mx,my+alt,zoom,w,h,gpsx,gpsy)
	dpx,dpy=map.mapToScreen(mx,my,zoom,w,h,gpsx,gpsy)
	sC(0,0,0,150)
	drawPointer(dpsx,dpsy+1,10,compass)--shadow
	sC(255,255,255,60)
	s.drawLine(dpsx,dpsy,dpx,dpy)--line
	sC(255,255,255)
	drawPointer(dpx,dpy,10,compass)

	sC(0,0,0,150)
	s.drawRectF(0,h/5,6,h/5*3)
	
	sC(25,50,100)
	s.drawRectF(16,61,32,3)

	if zoomingIn then sC(25,50,100) else sC(25,50,100,100)end
	dTB(1,h/5,4,h/5,"+",0,0)
	if zoomingOut then sC(25,50,100) else sC(25,50,100,100)end
	dTB(1,h/5*2,4,h/5,"-",0,0)
	if reset then sC(25,50,100) else sC(25,50,100,100)end
	dTB(1,h/5*3,4,h/5,"r",0,0)

	if not focusZone then
		if w>100 then
		sC(0,0,0,150)
		dL(dpsx-6,dpsy-5,dpsx-10,dpsy-9)
		dL(dpsx+6,dpsy-5,dpsx+10,dpsy-9)
		dL(dpsx+6,dpsy+6,dpsx+10,dpsy+10)
		dL(dpsx-6,dpsy+6,dpsx-10,dpsy+10)
		sC(255,255,255)
		dL(w/2-6,h/2-6,w/2-10,h/2-10)
		dL(w/2+6,h/2-6,w/2+10,h/2-10)
		dL(w/2+6,h/2+5,w/2+10,h/2+9)
		dL(w/2-6,h/2+5,w/2-10,h/2+9)
		end
	else
		x=dpx
		y=dpy
		L=h/6
		sC(25,50,100)
		s.drawRectF(w/2,h/2,1,1)
		if not iPIR(x,y,0,0,w,h) then
			x,y = w/2-x,h/2-y
			v = math.sqrt((x^2)+(y^2))
			x,y = x/v,y/v
			dL(w/2-x*2,h/2-y*2-1,w/2-x*L,h/2-y*L-1)
		end
	end

	sC(25,50,100,30)
	s.drawRect(6,0,w-7,h-1)
	
x3,y3=map.screenToMap(mx,my+alt,zoom,w,h,w/2,h/2)
screen.setColor(25,50,100)
	screen.drawText(8,48,"X:"..string.format("%05.0f",x3))
	screen.drawText(8,54,"Y:"..string.format("%05.0f",y3))
	

end

function iPIR(x,y,rX,rY,rW,rH)
return x>rX and y>rY and x<rX+rW and y<rY+rH
end
end



function drawPointer(x,y,s,r,...)
if act then
a=...
a=(a or 30)*pi/360
x=x+s/2*si(r)
y=y-s/2*co(r)
screen.drawTriangleF(x,y,x-s*si(r+a),y+s*co(r+a),x-s*si(r-a),y+s*co(r-a))
end
end
