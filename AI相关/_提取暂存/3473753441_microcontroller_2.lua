-- source: steam id 3473753441 / microcontroller.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3473753441
res=16
PI=math.pi
PI2=2*PI
function onTick()
	ix=input.getNumber(1)
	iy=input.getNumber(2)
	iz=input.getNumber(3)
	jx=input.getNumber(4)
	jy=input.getNumber(5)
	jz=input.getNumber(6)
	kx=input.getNumber(7)
	ky=input.getNumber(8)
	kz=input.getNumber(9)
end
function onDraw()
	w = screen.getWidth()				 
	h = screen.getHeight()
	drawLatitude(w,h,0,h/22)
	drawLatitude(w,h,0.25,h/55)
	drawLatitude(w,h,-0.25,h/55)
	drawLongitude(w,h,0.75,h/55)
	drawLongitude(w,h,0.25,h/55)
	drawLongitude(w,h,0,h/33)
	drawLongitude(w,h,0.5,h/33)
	drawOutline(w,h)
	drawChar(w,h,0,0.5,"N")
	drawChar(w,h,0,0,"E")
	drawChar(w,h,0,1.5,"S")
	drawChar(w,h,0,1,"W")
end
function drawPoint(x,y,w,h,d)
	screen.drawCircleF((x*h/2)+w/2,-(y*h/2)+h/2,d/2)
end
function drawLatitude(w,h,lat,thickness)
	u=lat+0.5
	screen.setColor(255,255,255)
	for v=0,2,1/res do
		coords1=get_spherical(u,v)
		newcoords1=augment(coords1.x,coords1.y,coords1.z)
		x1=newcoords1.x
		y1=newcoords1.y
		z1=newcoords1.z
		
		coords2=get_spherical(u,v+1/res)
		newcoords2=augment(coords2.x,coords2.y,coords2.z)
		x2=newcoords2.x
		y2=newcoords2.y
		z2=newcoords2.z
		if z1>0 or z2>0 then
			drawLine(x1,y1,x2,y2,thickness*2/h,w,h)
		end
	end
end
function drawLongitude(w,h,long,thickness)
	screen.setColor(255,255,255)
	for u=0,2,1/res do
		coords1=get_spherical(u,long)
		newcoords1=augment(coords1.x,coords1.y,coords1.z)
		x1=newcoords1.x
		y1=newcoords1.y
		z1=newcoords1.z
		
		coords2=get_spherical(u+1/res,long)
		newcoords2=augment(coords2.x,coords2.y,coords2.z)
		x2=newcoords2.x
		y2=newcoords2.y
		z2=newcoords2.z
		if z1>0 or z2>0 then
			drawLine(x1,y1,x2,y2,thickness*2/h,w,h)
		end
	end
end
function drawOutline(w,h)
	screen.setColor(0,0,0)
	for v=0,2,1/20 do
		r=23/22
		x1=r*cos(v*PI)
		y1=r*sin(v*PI)
		x2=r*cos((v+1/20)*PI)
		y2=r*sin((v+1/20)*PI)
		drawLine(x1,y1,x2,y2,1/11,w,h)
	end
end
function drawChar(w,h,lat,long,char)
	screen.setColor(0,0,255)
	coords=get_spherical(lat+0.5,long)
	newcoords=augment(coords.x,coords.y,coords.z)
	x=newcoords.x
	y=newcoords.y
	z=newcoords.z
	if (z>=-0.01) then
		screen.drawText(w/2+x*h/2-1,h/2-y*h/2-2,char)
	end
end
function cos(theta)
	return math.cos(theta)
end	
function sin(theta)
	return math.sin(theta)
end
function sqrt(x)
	return math.sqrt(x)
end
function round(x)
	return math.floor(x+0.5)
end
function draw_spherical(w,h,lat,long,thickness,r,g,b)
	screen.setColor(r,g,b)
	coords=get_spherical(lat,long)
	newcoords=augment(coords.x, coords.y, coords.z)
	x=newcoords.x
	y=newcoords.y
	z=newcoords.z
	if (z>=-0.01) then
		drawPoint(x,y,w,h,thickness)
	end
end
function get_spherical(lat,long)
	x=sin(lat*PI)*cos(long*PI)
	y=sin(lat*PI)*sin(long*PI)
	z=cos(lat*PI)
	return {x=x,y=y,z=z}
end
function augment(x,y,z)
	return {x=-(x*ix+y*jx+z*kx),y=x*iy+y*jy+z*ky,z=x*iz+y*jz+z*kz}
end
function drawLine(x1,y1,x2,y2,r,w,h)
	l1x=-r*(y2-y1)/(2*dist(x1,y1,x2,y2))+x1
	l1y=r*(x2-x1)/(2*dist(x1,y1,x2,y2))+y1
	l2x=r*(y2-y1)/(2*dist(x1,y1,x2,y2))+x1
	l2y=-r*(x2-x1)/(2*dist(x1,y1,x2,y2))+y1
	l3x=r*(y2-y1)/(2*dist(x1,y1,x2,y2))+x2
	l3y=-r*(x2-x1)/(2*dist(x1,y1,x2,y2))+y2
	l4x=-r*(y2-y1)/(2*dist(x1,y1,x2,y2))+x2
	l4y=r*(x2-x1)/(2*dist(x1,y1,x2,y2))+y2
	screen.drawTriangleF(w/2+l1x*h/2,h/2-l1y*h/2,w/2+l2x*h/2,h/2-l2y*h/2,w/2+l3x*h/2,h/2-l3y*h/2)
	screen.drawTriangleF(w/2+l1x*h/2,h/2-l1y*h/2,w/2+l3x*h/2,h/2-l3y*h/2,w/2+l4x*h/2,h/2-l4y*h/2)
	drawPoint(x1,y1,w,h,r*h/2 - 0.5)
	drawPoint(x2,y2,w,h,r*h/2 - 0.5)
end
function dist(x1,y1,x2,y2)
	return sqrt(((y2-y1)*(y2-y1))+((x2-x1)*(x2-x1)))
end