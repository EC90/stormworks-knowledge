-- source: steam id 2308050926 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2308050926
M=math
S=screen
dC=S.drawCircle
dCF=S.drawCircleF
dL=S.drawLine
dT=S.drawTriangle
dTF=S.drawTriangleF
tx=S.drawText
tb=S.drawTextBox
C=S.setColor

I=input
getN=I.getNumber
getB=I.getBool

P=property
prN=P.getNumber

O=output
setN=O.setNumber

zoom=0 deg=0 D=0 data={0,0,0,0,0,0} del=false w=0 h=0
gps={x=0,y=0}
units={} ping={}
nFmt=function (v,n) return string.format("%."..n.."f",v) end
function wXY(u) u.pos.x,u.pos.y=map.screenToMap(gps.x,gps.y,zoom,w,h,u.p1.x,u.p1.y) end
function pXY(u) u.p1.x,u.p1.y=map.mapToScreen(gps.x,gps.y,zoom,w,h,u.pos.x,u.pos.y) end

function p2(u)
	u.p2.x=u.p1.x+u.len*M.sin(u.deg*M.pi/180)
	u.p2.y=u.p1.y-u.len*M.cos(u.deg*M.pi/180)
end

function add(tbl,meters)
	local u={}
	u.name=#tbl
	u.pos={x=0,y=0}
	u.p1={x=w/2,y=h/2}
	u.p2={x=0,y=0}
	u.meters=meters
	u.radius=0
	u.len=0
	u.deg=deg+hdg-180
	u.time=0
	tbl[#tbl+1]=u
	wXY(tbl[#tbl])
end

function addUnit(meters,deg,str,elv)
	local u={}
	u.name=#units
	u.pos={x=0,y=0}
	u.p1={x=w/2,y=h/2}
	u.p2={x=0,y=0}
	u.meters=meters
	u.mass=str*meters
	u.radius=u.mass*2/1000
	u.len=0
	u.deg=deg+hdg-180
	u.str=str
	u.elv=elv
	u.time=0
	units[#units+1]=u
end

function mToPixels(u)
	u.len=u.meters*(w/(1000*zoom))	
end

function onTick()
	rng=prN("Max Range") --sonar max range = 3000m
	minRng=prN("Min Range")
	mount=prN("Mounting")
	minMass=prN("Min Mass")
	on=getB(8)
	gps={x=getN(7),y=getN(8)}
	hdg=getN(10)*-360%360
	zoom=getN(19)
	conD3D=getN(26)
	conElv=getN(27)*M.pi*2 --turns to radians
	conStr=getN(28)
	mass=conD3D*conStr
	
	if not on then
		units={} ping={} deg=0
	else
		deg=deg+1
		if deg>360 then deg=0 end	
		D=deg/360*rng
		add(ping,D)

		if conD3D>minRng and mass>=minMass then
			data[1]=conD3D
			data[2]=conElv
			data[3]=conStr
			conD2D=conD3D*M.cos(conElv)
			data[4]=conD2D
			conAlt=(conD3D^2-conD2D^2)^(1/2)
			data[5]=conAlt
			data[6]=mass
			addUnit(conD2D,deg,conStr,conElv)
		end
	
		for i=1,#ping do
			u=ping[i]
			p2(u) mToPixels(u)
			u.time=u.time+1
		end
		if #ping>360 then
			table.remove(ping,1)
		end		
		for i=1,#units do  --loop where the magic happens! LOL ;-D
			u=units[i]
			p2(u) mToPixels(u)
			x=D-u.meters
			y=rng/360
			if u.time==0 and x<y and x>-y then
				u.time=1
			end
			if u.time>0 then u.time=u.time+1 end
			if u.time>360 then del=true end
		end
		if del then
			table.remove(units,1)
			del=false
		end
		
		setN(29,mount*((deg/-360)%1-0.5))
		setN(30,conAlt)
		setN(31,conD2D)
	end
end

function fadeC(pct,alpha)
	C(0,255,255,(360*pct/u.time)*alpha)
end

function drawPing()
	for i=1,#ping do
		u=ping[i]
		fadeC(0.15,1)
		dC(u.p1.x,u.p1.y,u.len)
		if i>#ping-2 then
			fadeC(1,1)
			dC(u.p1.x,u.p1.y,u.len)
			--dL(u.p1.x,u.p1.y,u.p2.x,u.p2.y) --sweep line display for vetting only
		end
	end
end

function drawUnits()	
	for i=1,#units do
		u=units[i]
		if units[i].time>0 then
			echo=u.mass/60000
			C(0,255,255,echo*1.0*(255-255*(M.min(u.time/(360*1.0),1))))
			dC(u.p2.x,u.p2.y,u.len*(u.time/360))
			C(0,255,255,echo*0.9*(255-255*(M.min(u.time/(360*0.7),1))))
			dL(u.p1.x,u.p1.y,u.p2.x,u.p2.y)
		end
	end
end

function onDraw()
	w=S.getWidth()
	h=S.getHeight()
	if on then
		drawPing()
		drawUnits()	
		C(0,255,255,64)
		tb(w-80,h-22,77,7,nFmt(data[6],0)..":M",1,0) --Mass
		tb(w-80,h-15,77,7,nFmt(data[4],0)..":D",1,0) --Distance 2D
		tb(w-80,h-8,77,7,nFmt(data[5],0)..":A",1,0) --Altitude
	end
end