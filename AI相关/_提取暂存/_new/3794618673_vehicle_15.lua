-- source: steam id 3794618673 / vehicle.xml block#15
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794618673
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
	poweron=input.getBool(25)
	output.setBool(25, power)
	output.setBool(26, mini)
	
	gpsx=ip.getNumber(10)
	gpsy=ip.getNumber(11)

	compass=ip.getNumber(12)*pi2*-1
	alt=ip.getNumber(13)
	if alt<0 then alt=0 end
	
	power=isPressed and iPIR(inputX,inputY,1,25,6,6)
	mini=isPressed and poweron and iPIR(inputX,inputY,24,25,6,6)
	zoomingIn=isPressed and poweron and iPIR(inputX,inputY,12,25,6,6)
	zoomingOut=isPressed and poweron and iPIR(inputX,inputY,18,25,6,6)
	
		mx=gpsx
		my=gpsy

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
	s.setMapColorOcean(0,0,20)
	s.setMapColorShallows(0,0,20)
	s.setMapColorLand(00,00,00)
	s.setMapColorGrass(1,1,1)
	s.setMapColorSand(1,1,1)
	s.setMapColorSnow(00,00,00)

    x1,y1=map.screenToMap(mx,my+alt,zoom,w,h,0,0)
    x2,y2=map.screenToMap(mx,my+alt,zoom,w,h,w,h)
    x1=math.floor(x1/grid)*grid
    y1=math.floor(y1/grid)*grid

	dpsx,dpsy=map.mapToScreen(mx,my+alt,zoom,w,h,gpsx,gpsy)
	dpx,dpy=map.mapToScreen(mx,my,zoom,w,h,gpsx,gpsy)
	s.setColor(255,255,255,60)
	s.drawLine(dpsx,dpsy,dpx,dpy)--line
	s.setColor(200,200,200)
	drawPointer(dpx,dpy,6,compass)

	if zoomingIn then s.setColor(40,40,40) else s.setColor(8,8,8,255)end
	s.drawTextBox(15,27,3,3,"+",0,0)
	if zoomingOut then s.setColor(40,40,40) else s.setColor(8,8,8,255)end
	s.drawTextBox(21,27,3,3,"-",0,0)
	if power then s.setColor(40,40,40) else s.setColor(8,8,8,255)end
	screen.drawRectF(3, 27, 3, 3)
	if mini then s.setColor(40,40,40) else s.setColor(8,8,8,255)end
	screen.drawRectF(26, 27, 3, 3)

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