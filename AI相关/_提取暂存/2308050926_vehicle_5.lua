-- source: steam id 2308050926 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2308050926
S=screen
dC=S.drawCircle
tx=S.drawText
tb=S.drawTextBox
C=S.setColor

I=input
getN=I.getNumber
getB=I.getBool

P=property
prN=P.getNumber

zoom=0 tix=0 w=0 h=0
gps={x=0,y=0}
units={} ranges={}
nFmt=function (v,n) return string.format("%."..n.."f",v) end
function wXY(u) u.pos.x,u.pos.y=map.screenToMap(gps.x,gps.y,zoom,w,h,u.p1.x,u.p1.y) end
function pXY(u) u.p1.x,u.p1.y=map.mapToScreen(gps.x,gps.y,zoom,w,h,u.pos.x,u.pos.y) end

function add(meters,tbl)
	local u={}
	u.name=#tbl
	u.pos={x=0,y=0}
	u.p1={x=w/2,y=h/2}
	u.meters=meters
	u.radius=0
	tbl[#tbl+1]=u
	wXY(tbl[#tbl])
end

function mToPixels(u)
	u.radius=u.meters*(w/(1000*zoom))	
end

function onTick()
	on=getB(5)
	pulse=getB(6)
	zoom=getN(19)
	gps={x=getN(7),y=getN(8)}
	
	if on then
		tix=tix+1
	else
		units={}
		tix=0
	end
	
	if pulse and canPulse then
		add(tix*50.06-250,units)
		tix=0
		canPulse=false
	end

	if pulse and canPulse then
		canPulse=false
	else
		canPulse=true
	end
	
	for i=1,#ranges do
		u=ranges[i]
		u.p1={x=w/2,y=h/2}	
		mToPixels(u)
	end

	for i=1,#units do
		u=units[i]	
		mToPixels(u)
		pXY(u)
	end
	
end

function drawRanges()
	C(0,1,25,40) --faint dark blue
	for i=1,#ranges do
		u=ranges[i]
		dC(u.p1.x,u.p1.y,u.radius)
	end
end

function drawUnits()
	C(255,0,0,1)
	for i=1,#units do
		u=units[i]
		dC(u.p1.x,u.p1.y,u.radius)
	end
end

function onDraw()
	w=S.getWidth()
	h=S.getHeight()
	drawRanges()	
	drawUnits()
	C(255,0,0,64)
	if on then
		tb(w-80,h/2-3,77,7,#units,1,0)
		tb(w-80,h/2+4,77,7,"ELT",1,0)
	end
end

add(1000,ranges) --add range circles 1-5km
add(2000,ranges)
add(3000,ranges)
add(4000,ranges)
add(10*500,ranges) --max range for each zoom level
add(20*500,ranges)
add(30*500,ranges)
add(40*500,ranges)
add(50*500,ranges)