s,i,o=screen,input,output
sc,dc,dcf,dr,drf,dt,dtb,dl,dtb=s.setColor,s.drawCircle,s.drawCircleF,s.drawRect,s.drawRectF,s.drawText,s.drawTextBox,s.drawLine,s.drawTextBox
gn,gb,sn,sb=i.getNumber,i.getBool,o.setNumber,o.setBool
deg=math.pi/180
nX=0
nY=0
nnX=0
nnY=0
function onTick()
	w = input.getNumber(1)
	h = input.getNumber(2)
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)
	reset = input.getBool(3)
	gpstoggle = input.getBool(4)
	cX=gn(7)
	cY=gn(8)
	comp=gn(9)
	zoom=gn(10)
	
	touch1 = isPressed and isPointInRectangle(inputX,inputY,w-9,h-17,6,6)
	touch2 = isPressed and isPointInRectangle(inputX,inputY,w-9,h-9,6,6)
	reset = isPressed and isPointInRectangle(inputX,inputY,w-10,2,8,8)
	if w>=64 and h>=64 then
	gps = isPressed and isPointInRectangle(inputX,inputY,w-10,12,8,8)
	end
	
	cw=w/2
	ch=h/2
	if isPressed and not touch1 and not touch2 and not reset and not gps then
	if inputX>cw or inputX<cw then outX=inputX/cw-1 end
	if inputY>ch or inputY<ch then outY=inputY/ch-1 end
	else
	outX=0
	outY=0
	end
	nX=(1.4^clamp(zoom,0,20))*(outX*4)
	nY=(1.4^clamp(zoom,0,20))*(outY*4)
	nnX=nnX+nX
	nnY=nnY-nY
	if reset then nnX,nnY=0,0 end
	sb(1,touch1)
	sb(2,touch2)
	sb(3,reset)
	sb(4,gps)
end
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
function onDraw()
	s.drawMap(cX+nnX,cY+nnY,zoom)
	s.setMapColorOcean(5,5,5)
	s.setMapColorShallows(25,25,25)
	s.setMapColorSand(40,40,40)
	s.setMapColorSnow(40,40,40)
	s.setMapColorLand(220,35,0)
	s.setMapColorGrass(110,25,0)
	pX, pY = map.mapToScreen(cX+nnX, cY+nnY, zoom, w, h, cX, cY)
	sc(25,25,25,175)
	dl(pX,pY,pX+12*math.cos(-1.58+comp),pY+12*math.sin(-1.58+comp))
	sc(100,10,10)
	dcf(pX,pY,2)
	sc(120,120,120)
	dcf(pX,pY,1)
	
	if touch1 then
		sc(35,35,35)
		circle(w-6,h-14,1,3)
		sc(50,50,50)
		dtb(w-8,h-16,6,6,"+",0,0)
	else
		sc(50,50,50)
		circle(w-6,h-14,1,3)
		sc(150,150,150)
		dtb(w-8,h-16,6,6,"+",0,0)
	end
	
	if touch2 then
		sc(35,35,35)
		circle(w-6,h-6,1,3)
		sc(50,50,50)
		dtb(w-8,h-8,6,6,"-",0,0)
	else
		sc(50,50,50)
		circle(w-6,h-6,1,3)
		sc(150,150,150)
		dtb(w-8,h-8,6,6,"-",0,0)
	end
	
	if reset then
		sc(35,35,35)
		circle(w-6,6,2,3)
		sc(50,50,50)
		dtb(w-8,4,6,6,"R",0,0)
	else
		sc(50,50,50)
		circle(w-6,6,2,3)
		sc(150,150,150)
		dtb(w-8,4,6,6,"R",0,0)
	end
	if w>=64 and h>=64 then
	if gps then
		sc(35,35,35)
		circle(w-6,16,2,3)
		dl(w-6,16,w-5,16)
		sc(50,50,50)
		dtb(w-8,14,6,6,"C",0,0)
	else
		sc(50,50,50)
		circle(w-6,16,2,3)
		dl(w-6,16,w-5,16)
		sc(150,150,150)
		dtb(w-8,14,6,6,"C",0,0)
	end
	
	if gpstoggle then
	sc(5,5,5)
	drf(0,0,44,15)
	sc(220,35,0)
	dt(2,2,"X:"..string.format("%.0f",cX+nnX).."\n".."Y:"..string.format("%.0f",cY+nnY))
	end
	end
end
function circle(w,h,r,w2)
	for i=0,360,15 do
		i=i*deg
		screen.drawCircleF(w+r*math.cos(-(180*deg)+i),h+r*math.sin(-(180*deg)+i),w2/2)
	end
end
function clamp(n,mi,ma)
	if n>ma then return ma elseif n<mi then return mi else return n end
end