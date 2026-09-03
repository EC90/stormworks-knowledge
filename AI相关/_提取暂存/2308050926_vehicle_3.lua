-- source: steam id 2308050926 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2308050926
s=screen I=input
getB=I.getBool
getN=I.getNumber
setN=output.setNumber
prN=property.getNumber
tx=s.drawText
dL=s.drawLine
C=s.setColor
act=0 old=0 z=2 zoom={2,10,20,40,50} del=0 w=0 h=0 kts=1.943844
units={} gps={x=0,y=0} key={x=0,y=0}
nFmt=function (v,n) return string.format("%."..n.."f",v) end
function wXY(u) u.pos.x,u.pos.y=map.screenToMap(gps.x,gps.y,zoom[z],w,h,u.p1.x,u.p1.y) end
function pXY(u) u.p1.x,u.p1.y=map.mapToScreen(gps.x,gps.y,zoom[z],w,h,u.pos.x,u.pos.y) end
function add(x,y)
	local u={}
	u.name=#units
	u.unit={}
	u.link=-1
	u.time=0
	u.pos={x=0,y=0}
	u.p1={x=x,y=y}
	u.p2={x=0,y=0}
	u.p3={x=0,y=0}
	u.p4={x=0,y=0}
	u.p5={x=0,y=0}
	u.deg=0
	u.len=0
	u.scal=prN("Scalar")
	units[#units+1]=u
	wXY(units[#units])
end
function kill(n)
	for i=1,#units do
		u=units[i]
		if u.link==n then
			u.link=-1
		elseif u.link>n then
			u.link=u.link-1
		end
	end
	table.remove(units,n+1)
end
function link(u1,u2) units[u1+1].link=u2 end
function brg(u1,u2)
	local p1=u1.p1
	local p2=u2.p1
	return math.atan(p1.x-p2.x,p2.y-p1.y)*180/math.pi+180
end
function dis(u1,u2,pix)
	local p1=u1.pos
	local p2=u2.pos
	if pix==1 then p1=u1.p1 p2=u2.p2 end
	return ((p2.x-p1.x)^2+(p2.y-p1.y)^2)^(1/2)
end
function vec(u,spd,hdg) u.len=spd u.deg=hdg end
function isPtInRect(x,y,unit)
	n=5 if unit.name==0 then n=8 end
	x1=unit.p1.x-n y1=unit.p1.y-n
	return x>x1 and y>y1 and x<x1+2*n and y<y1+2*n
end
function clickToggle(unit)
	if isPtInRect(inX,inY,unit) then
		if act>0 and act==unit.name then
			del=act act=0
		end
		if act==0 and act==unit.name then
			z=z+1
			if z==#zoom+1 then z=1 end
		end
		act=unit.name
	end
end
function p2(u)
	local pt={}
	pt.x=u.p1.x+u.len*math.sin(u.deg*math.pi/180)*u.scal
	pt.y=u.p1.y-u.len*math.cos(u.deg*math.pi/180)*u.scal
	return pt
end
function pN(u,deg) return p2({p1=u.p2,deg=u.deg+deg,len=4,scal=1}) end
function pO(u) return p2({p1=u.p1,deg=u.deg,len=4,scal=1}) end
function onTick()
	inX=getN(3) inY=getN(4)
	inSpd=getN(9)*kts
	inHdg=getN(10)*-360%360
	isPress=getB(1)
	gps={x=getN(7),y=getN(8)}
	key={x=getN(11),y=getN(12)}
	units[1].pos=gps
	vec(units[1],inSpd,inHdg)
	old=0
	if getB(4) then add(0,0) units[#units].pos=key link(#units-1,act) end
	for i=1,#units do
		u=units[i]	
		u.p2=p2(u)
		u.p3=pO(u)
		u.p4=pN(u,135)
		u.p5=pN(u,-135)
		u.name=i-1
		pXY(u)
		if u.name>0 then 
			u.time=u.time+1/60
			if u.link==-1 then u.link=0 end
		end
		if isPress and canPress then
			clickToggle(u)
			if isPtInRect(inX,inY,u) then 
				old=old+1 u.time=0
			end
		end
	end
	if isPress and canPress and old==0 then
		add(inX,inY)
		link(#units-1,act)
		u=units[#units]
		ul=units[u.link+1]
		if ul.time>30 then
			u.deg=brg(ul,u)
			u.len=dis(ul,u)/ul.time*kts
		end	
		act=0 old=1
		canPress=false
	end
	if isPress then canPress=false else canPress=true end
	p=units[#units].p1
	for i=1,#units-1 do
		u=units[i].p1
		if u.x==p.x and u.y==p.y then del=#units-1 end
	end
	if del>0 then kill(del) del=0 act=0 end
	u=units[act+1]
	H=nFmt(u.deg,0) setN(13,H)
	S=nFmt(math.max(u.len,0),0) setN(14,S)
	B=0 D=0
	if u.link>-1 then
		B=brg(units[u.link+1],u)
		D=dis(units[u.link+1],u)	
	end
	B=nFmt(B,0) setN(15,B)
	D=nFmt(D,0) setN(16,D)
	T=nFmt(u.time,0)
	X=nFmt(u.pos.x,0) setN(17,X)
	Y=nFmt(u.pos.y,0) setN(18,Y)
	setN(19,zoom[z])
	R=nFmt(zoom[z]/2,0)
end
function drawUnits()
	for i=1,#units do
		u=units[i] x=u.p1.x y=u.p1.y	
		C(0,255,0) if i-1==act then C(255,255,0) end
		if i==1 then
			s.drawCircle(x,y,4)
		else
			s.drawRect(x-4,y-4,8,8)
			if u.name<10 then tx(x-1,y-1,u.name) end
		end
		C(0,255,0,10) if i-1==act then C(255,255,0,20) end
		if u.len>0 then
			dL(u.p3.x,u.p3.y,u.p2.x,u.p2.y)
			dL(u.p2.x,u.p2.y,u.p4.x,u.p4.y)
			dL(u.p2.x,u.p2.y,u.p5.x,u.p5.y)
		end
		if u.link>-1 then
			local p2=units[u.link+1].p1
			dL(u.p1.x, u.p1.y, p2.x, p2.y)
		end
	end
end
function onDraw()
	w=s.getWidth()
	h=s.getHeight()	
	C(255,255,0,64)	
	tx(3,8,"M"..act)
	tx(3,15,"H:"..H)
	tx(3,22,"S:"..S)
	tx(3,h/2-10,"B:"..B)
	tx(3,h/2-3,"D:"..D)
	tx(3,h/2+4,"T:+"..T)
	tx(3,h-22,"X:"..X)
	tx(3,h-15,"Y:"..Y)
	tx(3,h-8,"RNG:"..R.."km")
	drawUnits()
end
add(0,0)