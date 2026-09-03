-- source: steam id 3228447235 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3228447235
iB=input.getBool
iN=input.getNumber
oB=output.setBool
oN=output.setNumber
m=math
pi=m.pi
pi2=2*pi
s=m.sin
c=m.cos
t=m.tan
as=m.asin
ac=m.acos
at=m.atan
degs=180/pi
rads=1/degs
sc=screen
dL=sc.drawLine
dC=sc.drawCircle
dR=sc.drawRect
dT=sc.drawText
fo=string.format

function sgn(x)
	if x==0 then
		return 1
	else
		return x/m.abs(x)
	end
end
function distV(V1,V2)
	_=0
	for i=1,3 do
		_=_+(V1[i]-V2[i])^2	
	end
	_=_^0.5
	return _
end
function inPro(u,v)
	_=0
	for i=1,3 do
		_=_+u[i]*v[i]
	end
	return _
end
function outPro(u,v)
	local w={}
	w[1]=u[2]*v[3]-u[3]*v[2]
	w[2]=u[3]*v[1]-u[1]*v[3]
	w[3]=u[1]*v[2]-u[2]*v[1]
	return w
end
function Mv(M,v)
	V={}
	for i=1,3 do
		_=0
		for j=1,3 do
			_=_+M[j][i]*v[j]
		end
		V[i]=_
	end
	return V
end
function AngleToBasis(Q)
	ex={c(Q[1])*s(-Q[2]),c(Q[1])*c(-Q[2]),s(Q[1])}
	ey={c(Q[3])*s(-Q[4]),c(Q[3])*c(-Q[4]),s(Q[3])}
	ez=outPro(ex,ey)
	if m.abs(inPro(ex,ey))>0.01 then er=true else er=false end
	return {ex,ey,ez},er
end
function tM(M)
	N={{},{},{}}
	for i=1,3 do
		for j=1,3 do
			N[i][j]=M[j][i]
		end
	end
	return N
end
function PxRQ(xr,yr,r,q)
	return m.floor(xr+r*s(q))-0.5,m.floor(yr-r*c(q))-0.5
end
function dLP(xr,yr,rs,re,q)
	xs,ys=PxRQ(xr,yr,rs,q)
	xe,ye=PxRQ(xr,yr,re,q)
	dL(xs,ys,xe,ye)
end
function Ang2Px(q,mode)
	if mode==2 then
		qr=dHUD*t(q)*128
	elseif mode==1 then
		qr=h*t(q)/t(VA/2)
	else
		qr=DpA*q
	end
	return qr
end

RHead=0.088
w,h=9,9
Col0={}
ST={}
for i=1,20 do ST[i]=9 end

function onTick()
	if iN(31)>0 then
		ST[iN(31)]=iN(32)
	end
	Col0[1],Col0[2],Col0[3],AUnt,VUnt,OIType,DpA,dHUD,EInt,BarR,SpcR,GapN,GapL,PStl,VStl,DpS,SwSp,OffW,OffH,CalibModeN=ST[1],ST[2],ST[3],ST[4],ST[5],ST[6],ST[7],ST[8],ST[9],ST[10],ST[11],ST[12],ST[13],ST[14],ST[15],ST[16],ST[17],ST[18],ST[19],ST[20]
	
	QO={iN(1)*pi2,iN(2)*pi2,iN(3)*pi2,iN(4)*pi2}
	es,_=AngleToBasis(QO)
	Es=tM(es)
	PO,VO={},{}
	for i=1,3 do
		PO[i]=iN(10+i)
		VO[i]=(PO[i]-iN(13+i))*60
	end
	vO=Mv(Es,VO)
	VAbs=distV(VO,{0,0,0})
	drCx,drCy=w/2+OffW,h/2+OffH
	
end

function onDraw()
	w=sc.getWidth()
	h=sc.getHeight()
	sc.setColor(Col0[1],Col0[2],Col0[3])
	
	--Speed
	VAbsD=fo("%3.0f",VAbs*VUnt)
	dT(0,drCy-2.5,VAbsD)
	
	--Alt
	AltD=fo("%3.0f",PO[3]*AUnt)
	dT(w-17,drCy-2.5,AltD)
	
	
end