-- source: steam id 2902431068 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2902431068
	dtb=screen.drawTextBox drt=screen.drawRect drf=screen.drawRectF osn=output.setNumber otb=output.setBool ipn=input.getNumber isCenter = false isFollow = true oX=0 oY=0 tgl2=false w,h=64,64
function onTick()
	cX=ipn(5) cY=ipn(6) z=ipn(7) iX=ipn(3) iY=ipn(4)
	touch=input.getBool(1) compass=math.rad(ipn(8)*-(360)) compass2=compass+math.rad(-90)
	otb(1,zoomin) otb(2,zoomout) otb(3,reset) 
	
	zoomin=touch and ipir(iX,iY,0,h/4,10,6) zoomout=touch and ipir(iX,iY,0,2*h/4,10,6) reset=touch and ipir(iX,iY,0,3*h/4,10,6)
	inputX = iX inputY = iY
	
		if reset then focusZone=false end
		if touch and iX>8 then focusZone=true end
		if focusZone then
		if touch and iX>8 then tx,ty=map.screenToMap(dX,dY,z,w,h,iX,iY) end
		rcx,rcy=map.screenToMap(dX,dY,z,w,h,w/2,h/2)
		dX=rcx+((tx-rcx)*0.05) dY=rcy+((ty-rcy)*0.05)
	else
		dX=cX dY=cY
	end
	if reset then
		oX=0 oY=0 dX=cX dY=cY end
	if tgl then
	dX=wpxn dY=wpyn
	end
	xz,yz=100/z*math.cos(compass2),100/z*math.sin(compass2)
	if not touch then tgl2=false atp2=false end
	if toggle and not tgl2 then tgl2=true tgl = not tgl end
	osn(31,dX) osn(32,dY)
	xz1, yz1 = map.mapToScreen(dX, dY, z, w, h, cX, cY)
end
function ipir(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
function onDraw()
	screen.drawMap(dX,dY,z)
	
	screen.setMapColorOcean(setC(200,180,160))
	screen.setMapColorShallows(setC(190,160,130))
	screen.setMapColorLand(setC(160,130,110))
	screen.setMapColorGrass(setC(130,105,65))
	screen.setMapColorSand(setC(130,105,65))
	screen.setMapColorSnow(setC(130,105,65))
	
	screen.setColor(2,2,2)
	--screen.drawLine(xz1,yz1,xz1+xz,yz1+yz)
	drt(w/2, h/2, 1, 1)
	drt(xz1, yz1, 1, 1)
	--drawPointer(xz1,yz1+1,10,compass)
	screen.setColor(50,50,50,150)
	drf(0,0,10,h)
	screen.setColor(2,2,2)
	dtb(0,h/4,10,6,"+",0,0)
	dtb(0,2*h/4,10,6,"-",0,0)
	dtb(0,3*h/4,10,6,"R",0,0)

	screen.setColor(40,40,40,120)
	
	if zoomin then drf(0,h/4,10,6) end 
	if zoomout then drf(0,2*h/4,10,6) end 
	if reset then drf(0,3*h/4,10,6) end
	screen.setColor(100,100,100,100)
screen.drawRectF(0,0,w,h)
end
function drawPointer(x,y,s,r,...)
a=...
a=(a or 30)*math.pi/360
x=x+s/2*math.sin(r)
y=y-s/2*math.cos(r)
screen.drawTriangleF(x,y,x-s*math.sin(r+a),y+s*math.cos(r+a),x-s*math.sin(r-a),y+s*math.cos(r-a))
end
function setC(r,g,b)
return r^2.2/255^2.2*r,g^2.2/255^2.2*g,b^2.2/255^2.2*b
end