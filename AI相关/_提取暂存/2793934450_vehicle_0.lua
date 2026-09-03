-- source: steam id 2793934450 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793934450
gN=input.getNumber

m=math
sin,cos,pi=m.sin,m.cos,m.pi
tau=pi*2

function Q(x,y,z,w) -- aa = Axis Angle(Axis, RadiansAngle),m = Multiply with quaternion B, i = inverse; n = normalize quaternion, mV = Multply quaternion with vector v
	return {x=x or 0;y=y or 0;z=z or 0;w=w or 1;
		aa=function(na,a)local s=sin(a/2)return Q(na.x*s,na.y*s,na.z*s,cos(a/2))end;
		m=function(a,b)return Q((((a.w*b.x)+(a.x*b.w))+(a.y*b.z))-(a.z*b.y),(((a.w*b.y)+(a.y*b.w))+(a.z*b.x))-(a.x*b.z),(((a.w*b.z)+(a.z*b.w))+(a.x*b.y))-(a.y*b.x),(((a.w*b.w)-(a.x*b.x))-(a.y*b.y))-(a.z*b.z)) end;
		i=function(q)return Q(-q.x,-q.y,-q.z,q.w)end;
		n=function(q)local n=q.x^2+q.y^2+q.z^2+q.w^2;if n~=0 and n>0 then n=1/m.sqrt(n);q.x=q.x*n;q.y=q.y*n;q.z=q.z*n;q.w=q.w*n end;return q end;
		mV=function(q,v)
			local a,b,c=q.x*2,q.y*2,q.z*2
			local d,e,f,g,h,i,j,k,l=q.x*a,q.y*b,q.z*c,q.x*b,q.x*c,q.y*c,q.w*a,q.w*b,q.w*c
			return {(((1-(e+f))*v.x)+((g-l)*v.y))+((h+k)*v.z),(((g+l)*v.x)+((1-(d+f))*v.y))+((i-j)*v.z),(((h-k)*v.x)+((i+j)*v.y))+((1-(d+e))*v.z)}
		end}
end

function qM(q) --Quaternion To Rotation Matrix
	local x,y,z,s=q.x*2,q.y*2,q.z*2,q.w
	local X,Y,Z,a,b,c,A,B,C=x*q.x,y*q.y,z*q.z,x*q.y,x*q.z,y*q.z,x*q.w,y*q.w,z*q.w
	return {
	1-Y-Z,	a-C,	b+B,
	a+C,	1-X-Z,	c-A,
	b-B,	c+A,	1-X-Y}
end


p,q=Q(),Q()

speed=0.025
function onTick()
	local rx,ry,rz, trigger=gN(1)*speed, -gN(2)*speed, gN(3)*speed, input.getBool(31) -- X:Roll, Y:Pitch, Z:Yaw
	
	local r=qM(q)	--rotation matrix
	FORW,LEFT,UP={x=r[1],y=r[4],z=r[7]},{x=r[2],y=r[5],z=r[8]},{x=r[3],y=r[6],z=r[9]}
	
	if trigger then
		p=Q().aa({x=0,y=0,z=1},rz)
	else
		p=Q().aa(FORW,rx):m(Q().aa(LEFT,ry)):m(Q().aa(UP,rz))
	end
	
	q=p:m(q):n()


	a={ --yaw, pitch and roll angles following the z-y'-x" convention
		x=m.atan(2 * (q.w * q.x + q.y * q.z),1 - 2 * (q.x * q.x + q.y * q.y)),
		y=m.asin(2 * (q.w * q.y - q.z * q.x)),
		z=m.atan(2 * (q.w * q.z + q.x * q.y),1 - 2 * (q.y * q.y + q.z * q.z))
	}

	
	roll=	(-gN(5) - a.x/tau +0.5)%1-0.5
	pitch=	(-gN(6) - a.y/tau +0.5)%1-0.5
	yaw=	(-gN(7) - a.z/tau +0.5)%1-0.5
	
	output.setNumber(1,roll)
	output.setNumber(2,pitch)
	output.setNumber(3,yaw)
	
	output.setNumber(4,a.z)
end


-- \/ ONLY FOR DEBUG \/ --

function mm(a,b,c) --Matrix multiplication of a*b with c|column size. Column major
	local r = {}
	for i=1,c do
		r[i]=0
		for j=1,c do
			r[i] = r[i]+a[(i-1)*c+j]*b[j]
		end
	end
	return r
end

w,h=96,96
cx,cy=w/2,h/2
n,f,sX,sY=0.1,100,1.25,1.25
fn=f-n

orthographic={
	1/sX*cx,	0,			0,			0,
	0,			1/sY*cy,	0,			0,
	0,			0,			-2/fn,		-(f+n)/fn,
	0,			0,			0,			1}


function worldToScreen(a)
	local r = mm(orthographic,{a.x, a.y, a.z-2 ,1}, 4) --Looking down the z axis
	return r[1]/r[4]+cx, r[2]/r[4]+cy
end

s=screen
function onDraw()
	s.setColor(255,255,0,100)
	s.drawText(0,0,string.format("%.2f",q.w))
	s.drawText(0,10,string.format("%.2f",q.x).." "..string.format("%.2f",q.y).." "..string.format("%.2f",q.z))
	s.drawText(5,90,"yaw:"..string.format("%.2f",a.z*(180/pi)))
	
	--x y z
	local l=
	{
		{255,0,0,worldToScreen(FORW)},
		{0,255,0,worldToScreen(LEFT)},
		{0,0,255,worldToScreen(UP)}
		
	}
	
	for i=1,3 do
		s.setColor(l[i][1],l[i][2],l[i][3],150)
		s.drawLine(cx,cy,l[i][4],l[i][5])
	end
end