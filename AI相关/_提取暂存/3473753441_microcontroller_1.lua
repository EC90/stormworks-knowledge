-- source: steam id 3473753441 / microcontroller.xml block#1
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
	drawGround(w,h)
	drawSky(w,h)		
end
function drawGround(w,h)
	screen.setColor(100,32,5)
	for theta=1,0.5,-1/res do
		for phi=0,2,1/res do
			coords1=get_spherical(theta,phi)
			newcoords1=augment(coords1.x,coords1.y,coords1.z)
			x1=w/2+newcoords1.x*h/2
			y1=h/2-newcoords1.y*h/2
			z1=newcoords1.z
			coords2=get_spherical(theta,phi-1/res)
			newcoords2=augment(coords2.x,coords2.y,coords2.z)
			x2=w/2+newcoords2.x*h/2
			y2=h/2-newcoords2.y*h/2
			z2=newcoords2.z
			coords3=get_spherical(theta+1/res,phi-1/res)
			newcoords3=augment(coords3.x,coords3.y,coords3.z)
			x3=w/2+newcoords3.x*h/2
			y3=h/2-newcoords3.y*h/2
			z3=newcoords3.z
			coords4=get_spherical(theta+1/res,phi)
			newcoords4=augment(coords4.x,coords4.y,coords4.z)
			x4=w/2+newcoords4.x*h/2
			y4=h/2-newcoords4.y*h/2
			z4=newcoords4.z
			if z1>0 then
				screen.drawTriangleF(x1,y1,x2,y2,x3,y3)
				screen.drawTriangleF(x1,y1,x4,y4,x3,y3)
			end
		end
	end
end
function drawSky(w,h)
	screen.setColor(6,89,142)
	for theta=0,0.5,1/res do
		for phi=0,2,1/res do
			coords1=get_spherical(theta,phi)
			newcoords1=augment(coords1.x,coords1.y,coords1.z)
			x1=w/2+newcoords1.x*h/2
			y1=h/2-newcoords1.y*h/2
			z1=newcoords1.z
			coords2=get_spherical(theta,phi+1/res)
			newcoords2=augment(coords2.x,coords2.y,coords2.z)
			x2=w/2+newcoords2.x*h/2
			y2=h/2-newcoords2.y*h/2
			z2=newcoords2.z
			coords3=get_spherical(theta-1/res,phi+1/res)
			newcoords3=augment(coords3.x,coords3.y,coords3.z)
			x3=w/2+newcoords3.x*h/2
			y3=h/2-newcoords3.y*h/2
			z3=newcoords3.z
			coords4=get_spherical(theta-1/res,phi)
			newcoords4=augment(coords4.x,coords4.y,coords4.z)
			x4=w/2+newcoords4.x*h/2
			y4=h/2-newcoords4.y*h/2
			z4=newcoords4.z
			if z1>0 then
				screen.drawTriangleF(x1,y1,x2,y2,x3,y3)
				screen.drawTriangleF(x1,y1,x4,y4,x3,y3)
			end
		end
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
function get_spherical(lat,long)
	x=sin(lat*PI)*cos(long*PI)
	y=sin(lat*PI)*sin(long*PI)
	z=cos(lat*PI)
	return {x=x,y=y,z=z}
end
function augment(x,y,z)
	return {x=-(x*ix+y*jx+z*kx),y=x*iy+y*jy+z*ky,z=x*iz+y*jz+z*kz}
end
function dist(x1,y1,x2,y2)
	return sqrt(((y2-y1)*(y2-y1))+((x2-x1)*(x2-x1)))
end