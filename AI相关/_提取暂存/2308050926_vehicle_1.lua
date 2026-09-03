-- source: steam id 2308050926 / vehicle.xml block#1
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
zoom=0 deg=0 data={0,0,0,0,0,0} del=false w=0 h=0
gps={x=0,y=0}
units={} sweep={}
nFmt=function (v,n) return string.format("%."..n.."f",v) end
function wXY(u) u.pos.x,u.pos.y=map.screenToMap(gps.x,gps.y,zoom,w,h,u.p1.x,u.p1.y) end
function pXY(u) u.p1.x,u.p1.y=map.mapToScreen(gps.x,gps.y,zoom,w,h,u.pos.x,u.pos.y) end

function p2(u)
	u.p2.x=u.p1.x+u.len*M.sin(u.deg*M.pi/180)
	u.p2.y=u.p1.y-u.len*M.cos(u.deg*M.pi/180)
end

function p3(u)
	u.p3.x=u.p2.x+5*M.sin((u.deg-90)*M.pi/180)
	u.p3.y=u.p2.y-5*M.cos((u.deg-90)*M.pi/180)
end

function lineSeg(u,m,p1,p2)
	m=m*(w/(1000*zoom))
	p1.x=u.p1.x+m*M.sin(u.deg*M.pi/180)
	p1.y=u.p1.y-m*M.cos(u.deg*M.pi/180)
	p2.x=p1.x+2*M.sin((u.deg+90)*M.pi/180)
	p2.y=p1.y-2*M.cos((u.deg+90)*M.pi/180)
end

function dis(u1,u2)
	local p1=u1.pos
	local p2=u2.pos
	return ((p2.x-p1.x)^2+(p2.y-p1.y)^2)^(1/2)
end

function linCon(val,oMin,oMax,nMin,nMax)
	return M.min(nMax,M.max(nMin,nMin,(((val-oMin)*(nMax-nMin))/(oMax-oMin))+nMin))
end

function add(tbl,meters)
	local u={}
	u.name=#tbl
	u.pos={x=0,y=0}
	u.p1={x=w/2,y=h/2}
	u.p2={x=0,y=0}
	u.p3={x=0,y=0}
	u.p4={x=0,y=0}
	u.p5={x=0,y=0}
	u.p6={x=0,y=0}
	u.p7={x=0,y=0}
	u.p8={x=0,y=0}
	u.p9={x=0,y=0}
	u.p10={x=0,y=0}
	u.p11={x=0,y=0}
	u.p12={x=0,y=0}
	u.p13={x=0,y=0}
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
	u.radius=linCon(u.mass,400,60000,2,6)
	u.len=0
	u.deg=deg+hdg-180
	u.str=str
	u.elv=elv
	u.time=0
	units[#units+1]=u
end

function mToPixels(u) u.len=u.meters*(w/(1000*zoom)) end

function onTick()
	rng=prN("Max Range")
	minRng=prN("Min Range")
	mount=prN("Mounting")
	minMass=prN("Min Mass")
	on=getB(7)
	gps={x=getN(7),y=getN(8)}
	hdg=getN(10)*-360%360
	zoom=getN(19)
	conD3D=getN(20)
	conElv=getN(21)*M.pi*2 --turns to radians
	conStr=getN(22)
	mass=conD3D*conStr
	if not on then
		units={} sweep={}
	else
		deg=deg+1
		if deg>360 then 
			deg=0 
		end
		add(sweep,rng)
		if conD3D>=minRng and mass>=minMass then
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
		for i=1,#sweep do
			u=sweep[i]
			p2(u) p3(u) mToPixels(u)
			lineSeg(u,1000-25,u.p4,u.p5)
			lineSeg(u,2000-25,u.p6,u.p7)
			lineSeg(u,3000-25,u.p8,u.p9)
			lineSeg(u,4000-25,u.p10,u.p11)
			lineSeg(u,5000-25,u.p12,u.p13)
			u.time=u.time+1
		end
		if #sweep>360 then
			i=1,5 do
				table.remove(sweep,1)
			end
		end
		for i=1,#units do
			u=units[i]
			p2(u) mToPixels(u)
			u.time=u.time+1
			if u.time>360 then del=true end
		end
		if del then
			table.remove(units,1)
			del=false
		end
		setN(23,mount*((deg/-360)%1-0.5)) 
		setN(24,conAlt)
		setN(25,conD2D)
	end
end

function fadeC(pct,alpha)
	C(0,255,0,(360*pct/u.time)*alpha)
end

function drawSweep()
	for i=1,#sweep do
		u=sweep[i]
		fadeC(0.2,0.7)	
		dTF(u.p1.x,u.p1.y,u.p2.x,u.p2.y,u.p3.x,u.p3.y)
		if i==#sweep-2 then
			fadeC(1,1)
			dL(u.p1.x,u.p1.y,u.p2.x,u.p2.y)
		end
		fadeC(0.27,0.6)
		dL(u.p4.x,u.p4.y,u.p5.x,u.p5.y)
		dL(u.p6.x,u.p6.y,u.p7.x,u.p7.y)
		dL(u.p8.x,u.p8.y,u.p9.x,u.p9.y)
		dL(u.p10.x,u.p10.y,u.p11.x,u.p11.y)
		dL(u.p12.x,u.p12.y,u.p13.x,u.p13.y)
	end
end

function drawUnits()
	for i=1,#units do
		u=units[i]
		fadeC(1,1)
		dCF(u.p2.x,u.p2.y,u.radius)
		fadeC(0.5,0.7)
		dL(u.p1.x,u.p1.y,u.p2.x,u.p2.y)
	end
end

function onDraw()
	w=S.getWidth()
	h=S.getHeight()	
	if on then
		drawSweep()
		drawUnits()
		C(0,255,0,64)
		tb(w-80,8,77,7,nFmt(data[6],0)..":M",1,0) --Mass
		tb(w-80,15,77,7,nFmt(data[4],0)..":D",1,0) --Distance 2D
		tb(w-80,22,77,7,nFmt(data[5],0)..":A",1,0) --Altitude
	end
end