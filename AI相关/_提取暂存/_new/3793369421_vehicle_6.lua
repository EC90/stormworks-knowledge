-- source: steam id 3793369421 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793369421
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

x=0
y=0
Z=0
e=1
r=999

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
	tp=iB(1)
	oB(1,tp)
	tp2=iB(2)
	oB(2,tp2)
	
	z=M.exp(Z)
	if tp and Norm(w-20-tx,h-20-ty)<14 then
		x=x+(tx-w+20)*z
		y=y+(h-20-ty)*z
	end
	if tp and Button(tx,ty,w-44,h-23,6,6) and z>0.1 then
		Z=Z-0.01
	end
	if tp and Button(tx,ty,w-44,h-13,6,6) and z<50 then
		Z=Z+0.01
	end
	
	if (tp and Button(tx,ty,w-44,h-33,6,6)) or iB(3) then
		x=iN(11)
		y=iN(12)
	end
end

function onDraw()
	if property.getBool("Map Color Scheme") then
		S.setMapColorOcean(0,1,0)
		S.setMapColorShallows(0,5,0)
		S.setMapColorLand(0,255,0)
		S.setMapColorGrass(0,255,0)
		S.setMapColorSand(0,150,0)
		S.setMapColorSnow(0,255,0)
		sC(179,255,0)
	else
		sC(0,0,0)
	end
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
	if property.getBool("Map Color Scheme") then
		sC(179,255,0,50)
	else
		sC(0,0,0,50)
	end
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
	if property.getBool("Map Color Scheme") then
		sC(179,255,0)
	else
		sC(0,0,0)
	end
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
	if tp and Button(tx,ty,w-44,h-33,6,6) then
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
		sC(0,100,100)
		dCF(tx,ty,2)
		p1x,p1y=map.screenToMap(x,y,z,w,h,tx,ty)
		dTx(3,19,sf("X:%.0f",p1x))
		dTx(3,25,sf("Y:%.0f",p1y))
	end
	if tp2 and not Button(tx2,ty2,w-45,h-35,45,35) then
		sC(100,100,100)
		dCF(tx2,ty2,2)
		p2x,p2y=map.screenToMap(x,y,z,w,h,tx2,ty2)
		dTx(3,32,sf("X:%.0f",p2x))
		dTx(3,38,sf("Y:%.0f",p2y))
		dL(tx,ty,tx2,ty2)
		dTx(3,45,"Distance:")
		dTx(3,51,sf("%.0fm",Norm(p1x-p2x,p1y-p2y)))
		dTx(3,58,"Bearing:")
		A=M.acos((ty-ty2)/Norm(tx-tx2,ty-ty2))
		if tx>tx2 then
			A=2*M.pi-A
		end
		dTx(3,64,sf("%.1f",M.deg(A)))
	end
end