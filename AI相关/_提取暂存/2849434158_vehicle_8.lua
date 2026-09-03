-- source: steam id 2849434158 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2849434158
FrSize=10
LookD=100

iB=input.getBool
iN=input.getNumber
oN=output.setNumber
oB=output.setBool
pN=property.getNumber
m=math
s=m.sin
c=m.cos
t=m.tan
as=m.asin
ac=m.acos
at=m.atan
pi=m.pi
pi2=2*pi
sc=screen
sC=sc.setColor
dT=sc.drawText
dL=sc.drawLine
dR=sc.drawRect
dRF=sc.drawRectF
dL=sc.drawLine
dT=sc.drawText
fo=string.format

function quant(x,a)
	return m.floor(x/a)*a
end
function distV(V1,V2)
	_=0
	for i=1,3 do
		_=_+(V1[i]-V2[i])^2	
	end
	return _^0.5
end
function inPro(u,v)
	_=0
	for i=1,3 do
		_=_+u[i]*v[i]
	end
	return _
end
function outPro(u,v)
	w={}
	w[1]=u[2]*v[3]-u[3]*v[2]
	w[2]=u[3]*v[1]-u[1]*v[3]
	w[3]=u[1]*v[2]-u[2]*v[1]
	return w
end
function AngleToBasis(Q)
	ex={c(Q[1])*s(-Q[2]),c(Q[1])*c(-Q[2]),s(Q[1])}
	ey={c(Q[3])*s(-Q[4]),c(Q[3])*c(-Q[4]),s(Q[3])}
	ez=outPro(ex,ey)
	if m.abs(inPro(ex,ey))>0.1 then er=true else er=false end
	return {ex,ey,ez},er
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
function tM(M)
	N={{},{},{}}
	for i=1,3 do
		for j=1,3 do
			N[i][j]=M[j][i]
		end
	end
	return N
end
function OrthToPol(VO)
	VP={}
	VP[1]=distV(VO,{0,0,0})
	VP[2]=at(VO[1],VO[2])
	VP[3]=as(VO[3]/VP[1])
	return VP
end
function dFrame(x,y,r,k)
	for i=-1,1,2 do
		for j=-1,1,2 do
			dL(x+i*r,y+j*r,x+k*i*r,y+j*r)
			dL(x+i*r,y+j*r,x+i*r,y+k*j*r)
		end
	end
end
function isPrR(px,py,Tb)
	return px>Tb.x and px<Tb.x+Tb.w and py>Tb.y and py<Tb.y+Tb.h
end
function DrawButton(T)
	for i=1,#T do
		sC(255,255,255)
		if i==SelN then
			dRF(T[i].x,T[i].y,T[i].w+1,T[i].h+1)
			sC(0,0,0)
			dT(2+T[i].x,2+T[i].y,T[i].L)
		else
			dR(T[i].x,T[i].y,T[i].w,T[i].h)
			dT(2+T[i].x,2+T[i].y,T[i].L)
		end
		
	end
end
function TGTScreenPos(T)
	x,y=w2+h2*t(T[2])/t(VA/2),h2-h2*t(T[3])/t(VA/2)
	size=m.max(m.min(h2*(FrSize/2)/(T[1]*c(T[2])*t(VA/2)),10),3)
	return x,y,size
end

B={}
SelN=4
KEYG,LASG,RADG={0,0,0},{0,0,0},{0,0,0}
Send={0,0,0}
LOOK={}

function onTick()
	w,h,tx,ty=iN(27),iN(28),iN(29),iN(30)
	B[1]={L="K",x=0,y=2,w=8,h=8}
	B[2]={L="L",x=8,y=2,w=8,h=8}
	B[3]={L="R",x=16,y=2,w=8,h=8}
	B[4]={L="X",x=24,y=2,w=7,h=8}
	
	--Touch detection
	for i=1,#B do
		if B[i].isPr==nil then B[i].isPrO=false else B[i].isPrO=B[i].isPr end
		if isPrR(tx,ty,B[i]) then B[i].isPr=true else B[i].isPr=false end
		if B[i].isPr and not B[i].isPrO then SelN=i end
	end
	
	--Input
	PO={iN(7),iN(8),iN(9)}
	QO={iN(10)*pi2,iN(11)*pi2,iN(12)*pi2,iN(13)*pi2}
	fov=iN(14)
	BO,_=AngleToBasis(QO)
	bO,_=tM(BO)
	if iN(19)==1 then LockTGT=true else LockTGT=false end
	
	--Calculate View Angle
	VA=2.2-fov*(2.2-0.025)
	
	--Target data input
	RADG={iN(1),iN(2),iN(3)}
	RADp={iN(4),iN(5),iN(6)}
	if distV(RADG,{0,0,0})~=0 then
		RDet=true
	else
		RDet=false
	end
	
	--Lasar target update
	LDist=iN(15)
	if LDist>0 and LDist<4000 then
		LDet=true
		if LockTGT and SelN==2 then
			_={}
			for i=1,3 do
				_[i]=LASG[i]-PO[i]
			end
			LASp=OrthToPol(Mv(bO,_))
		else
			LASo={0,LDist,0}
			LASp=OrthToPol(LASo)
			_=Mv(BO,LASo)
			LASG={}
			for i=1,3 do
				LASG[i]=_[i]+PO[i]
			end
		end
	else
		LDet=false
		_={}
		for i=1,3 do
			_[i]=LASG[i]-PO[i]
		end
		LASp=OrthToPol(Mv(bO,_))
	end
	
	--Keypad target update
	_={iN(16),iN(17),iN(18)}
	if distV(_,{0,0,0})~=0 then
		KDet=true
		KEYG={iN(16),iN(17),iN(18)}
	else
		KDet=false
	end
	KEYo={}
	for i=1,3 do
		KEYo[i]=KEYG[i]-PO[i]
	end
	KEYp=OrthToPol(Mv(bO,KEYo))
	
	--Look target
	delayL=5
	for i=1,3 do
		LOOK[i]=PO[i]+LookD*BO[2][i]
	end
	
	if SelN==1 then
		Send=KEYG
		delayS=3
	elseif SelN==2 then
		Send=LASG
		delayS=5
	elseif SelN==3 then
		Send=RADG
		delayS=pN("Process Delay (tick)")+4
	else
		Send={0,0,0}
		delayS=0
	end
	
	for i=1,3 do
		oN(i,Send[i])
		oN(4+i,LOOK[i])
		oN(8+i,KEYp[i])
		oN(11+i,LASp[i])
		oN(14+i,RADp[i])
	end
	oN(4,delayS)
	oN(8,delayL)
	oN(18,SelN)
	oN(19,VA)
	oB(1,KDet)
	oB(2,LDet)
	oB(3,RDet)
end

function onDraw()
	sC(255,255,255)
	dT(2,13,"X"..fo("%5.0f",Send[1]))
	dT(2,19,"Y"..fo("%5.0f",Send[2]))
	dT(2,25,"Z"..fo("%5.0f",Send[3]))
	DrawButton(B)
end