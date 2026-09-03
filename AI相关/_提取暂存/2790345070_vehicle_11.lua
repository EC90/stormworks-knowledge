-- source: steam id 2790345070 / vehicle.xml block#11
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2790345070
S=screen
M=math
dTx=S.drawText
dTxB=S.drawTextBox
dR=S.drawRect
dRF=S.drawRectF
dC=S.drawCircle
dCF=S.drawCircleF
dL=S.drawLine
sC=S.setColor
sf=string.format
iN=input.getNumber
iB=input.getBool
oN=output.setNumber
oB=output.setBool
function Button(x,y,rx,ry,rw,rh)
	return x>rx and y>ry and x<rx+rw and y<ry+rh
end

function Norm(x,y)
	return M.sqrt(x^2+y^2)
end

Z=0
px=0
py=0
e=1
r=999
c = true
dist=100

function onTick()
	w=iN(1)
	oN(1,w)
	h=iN(2)
	oN(2,h)
	tx=iN(3)
	oN(3,tx)
	ty=iN(4)
	oN(4,ty)
	tx2=iN(5)
	oN(5,tx2)
	ty2=iN(6)
	oN(6,ty2)
	oN(7,x)
	oN(8,y)
	oN(9,z)
	oN(10,e)
	oN(11,dist)
	oN(12,bearingR)
	gpsX=iN(11)
	gpsY=iN(12)
	kbX=iN(13)
	kbY=iN(14)
	tp=iB(1)
	oB(1,tp)
	tp2=iB(2)
	oB(2,tp2)
	kbS=iB(3)
	wp=iB(4)
	nm=iB(5)
	oB(3,ptt)
	oB(4,ptt100)
	
	z=M.exp(Z)
	if tp and Norm(w-20-tx,h-20-ty)<14 then
		c = false
		x=x+(tx-w+20)*z
		y=y+(h-20-ty)*z
	end
	if tp and Button(tx,ty,w-44,h-23,6,6) and z>0.1 then
		Z=Z-0.01
	end
	if tp and Button(tx,ty,w-44,h-13,6,6) and z<50 then
		Z=Z+0.01
	end
	
	if (tp and Button(tx,ty,w-44,h-33,6,6)) and pS == false then
		c = not c
	end
	pS = tp
	if c == true then
		x=gpsX
		y=gpsY
	end
end

function onDraw()
	if nm then
	r1=0
	g1=4
	b1=10
	r2=4
	g2=8
	b2=14
	r3=10
	g3=12
	b3=15
	r4=18
	g4=30
	b4=26
	r5=10
	g5=14
	b5=20
	r6=60
	g6=60
	b6=60
	else
	r1=0
	g1=30
	b1=35
	r2=24
	g2=68
	b2=72
	r3=90
	g3=90
	b3=90
	r4=64
	g4=85
	b4=48
	r5=100
	g5=93
	b5=41
	r6=200
	g6=200
	b6=200
	end
	sC(0,0,0)
	S.setMapColorOcean(r1,g1,b1)
	S.setMapColorShallows(r2,g2,b2)
	S.setMapColorLand(r3,g3,b3)
	S.setMapColorGrass(r4,g4,b4)
	S.setMapColorSand(r5,g5,b5)
	S.setMapColorSnow(r6,g6,g6)
	S.drawMap(x,y,z)
	Ox,Oy=map.mapToScreen(x,y,z,w,h,0,0)
	ex,Oy=map.mapToScreen(x,y,z,w,h,1,0)
	e=M.abs(Ox-ex)
	Ox,Oy=map.screenToMap(x,y,z,w,h,0,0)
	dL(3,h-3,3,h-8)
	if e*10000<w/2-10 then
		r=e*10000
		R="10km"
		Ox=Ox-M.fmod(Ox,10000)
		Oy=Oy-M.fmod(Oy,10000)
		Ox,Oy=map.mapToScreen(x,y,z,w,h,Ox,Oy)
	elseif e*1000<w/2-10 then 
		r=e*1000
		R="1km"
		Ox=Ox-M.fmod(Ox,1000)
		Oy=Oy-M.fmod(Oy,1000)
		Ox,Oy=map.mapToScreen(x,y,z,w,h,Ox,Oy)
	elseif e*100<w/2-10 then 
		r=e*100
		R="100m"
		Ox=Ox-M.fmod(Ox,100)
		Oy=Oy-M.fmod(Oy,100)
		Ox,Oy=map.mapToScreen(x,y,z,w,h,Ox,Oy)
	elseif e*10<w/2-10 then 
		r=e*10
		R="10m"
		Ox=Ox-M.fmod(Ox,10)
		Oy=Oy-M.fmod(Oy,10)
		Ox,Oy=map.mapToScreen(x,y,z,w,h,Ox,Oy)
	end
	sC(0,0,0,50)
	i=0
	while i*r<w do
		dL(Ox+i*r,0,Ox+i*r,h)
		i=i+1
	end
	i=0
	while i*r<h do
		dL(0,Oy+i*r,w,Oy+i*r)
		i=i+1
	end
	sC(0,0,0)
	dTx(4,h-13,R)
	for i=0,4 do
		dL(3+i*2*r/10,h-5,3+(i*2+1)*r/10,h-5)
	end
	dL(3+r,h-3,3+r,h-8)
	dTxB(0,0,w,h,"0",0,-1)
	dTxB(0,0,w,h,"90",1,0)
	dTxB(0,0,w,h,"180",0,1)
	dTxB(0,0,w,h,"270",-1,0)
	dC(w-20,h-20,15)
	if tp and Norm(w-20-tx,h-20-ty)<14 then
		dCF(tx,ty,4)
		dL(w-20,h-20,tx,ty)
	else
		dCF(w-20,h-20,4)
	end
	if tp and Button(tx,ty,w-44,h-23,6,6) and z>0.1 then
		dRF(w-44,h-22,7,7)
	else
		dR(w-44,h-23,6,6)
		dTx(w-42,h-22,"+")
	end
	if tp and Button(tx,ty,w-44,h-13,6,6) and z<50 then
		dRF(w-44,h-12,7,7)
	else
		dR(w-44,h-13,6,6)
		dTx(w-42,h-12,"-")
	end
	if c == true then
		dRF(w-44,h-32,7,7)
	else
		dR(w-44,h-33,6,6)
		dTx(w-42,h-32,"c")
	end
	sC(100,0,0)
	dCF(w/2,h/2,2)
	dTx(3,3,sf("X:%.0f",x))
	dTx(3,9,sf("Y:%.0f",y))
	
	if tp and not Button(tx,ty,w-45,h-35,45,35) then
		mx=tx
		my=ty
		px,py=map.screenToMap(x,y,z,w,h,mx,my)
	end

	if kbS then
		px=kbX
		py=kbY
	end
	
	if tp and not Button(tx,ty,w-45,h-35,45,35) and wp == false or kbS and wp == false then
		ptt=true
	else
		ptt=false
	end
	
		gpsXP,gpsYP=map.mapToScreen(x,y,z,w,h,gpsX,gpsY)
		wpX,wpY=map.mapToScreen(x,y,z,w,h,px,py)
		dist=Norm(px-gpsX,py-gpsY)
		bearingR=M.atan(px-gpsX,py-gpsY)/(M.pi*2)
		bearingD=((1+bearingR)*360)%360
		
	if wp then
		sC(0,100,100)
		dCF(wpX,wpY,2)
		dTx(3,16,sf("X:%.0f",px))
		dTx(3,22,sf("Y:%.0f",py))
		dTx(3,29,"Bearing:")
		dTx(3,35,sf("%.1f",bearingD))
		sC(0,100,0)
		dL(wpX,wpY,gpsXP,gpsYP)
		dTx(3,42,"Distance:")
		dTx(3,48,sf("%.0fm",dist))
		if dist < 100 then
			ptt100=true
		end
	else
		ptt100=false
	end
end