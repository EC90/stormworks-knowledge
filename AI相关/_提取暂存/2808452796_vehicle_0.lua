-- source: steam id 2808452796 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2808452796
dM,dR=2,10
lostT,srs,trs=0,1,1
tm,twx,twy,twz,yaw=0,0,0,0,0,0
yawO={}
dtm,dtwx,dtwy,dtwz=0,0,0,0
dtcx,dtcy,dtcz=0,0,0
tsqz=0
TRm=0

inB=input.getBool
inN=input.getNumber
ouB=output.setBool
ouN=output.setNumber
m=math
pi=m.pi
pi2=2*pi
s=m.sin
c=m.cos
t=m.tan
as=m.asin
at=m.atan
abs=m.abs
f4="%4.0f"
sc=screen
drT=sc.drawText

function sgn(x)
	return x/abs(x)
end
function len2(x,y)
	return (x^2+y^2)^0.5
end
function len3(x,y,z)
	return (x^2+y^2+z^2)^0.5
end
function drTf(x,y,txt,fmt)
	return drawText(x,y,string.format(fmt,txt))
end
function angDif1(a,b)
	a,b=a*pi2,b*pi2
	return at(s(a-b),c(a-b))/pi2
end
function angFix(a)
	return (a+0.5)%1-0.5
end
function SphToRec(r,qx,qz)
	x=r*c(qx)*s(qz)
	y=r*c(qx)*c(qz)
	z=r*s(qx)
return x,y,z
end
function LocalToWorld(xl,yl,zl,qx,qy,qz,xlw,ylw,zlw)
	qx,qz=as(s(qx)/c(qy)),qz-at(t(qx)*t(qy))
	xw=xlw+c(qz)*c(qy)*xl-(s(qz)*c(qx)+c(qz)*s(qy)*s(qx))*yl+(s(qz)*s(qx)-c(qz)*s(qy)*c(qx))*zl
	yw=ylw+s(qz)*c(qy)*xl+(c(qz)*c(qx)-s(qz)*s(qy)*s(qx))*yl-(c(qz)*s(qx)+s(qz)*s(qy)*c(qx))*zl
	zw=zlw+s(qy)*xl+c(qy)*s(qx)*yl+c(qy)*c(qx)*zl
return xw,yw,zw
end
function CalcWrldCrd(sr,sqx,sqz,rqx,rqy,rqz,xlw,ylw,zlw)
	xl,yl,zl=SphToRec(sr,sqx,sqz)
	xw,yw,zw=LocalToWorld(xl,yl,zl,rqx,rqy,rqz,xlw,ylw,zlw)
return xw,yw,zw
end
function RecToSph(x,y,z)
	xy=len2(x,y)
	r=len2(xy,z)
	qx=at(z,xy)
	qz=at(x,y)
return r,qx,qz
end
function WorldToLocal(xw,yw,zw,qx,qy,qz,xlw,ylw,zlw)
	qx,qz=as(s(qx)/c(qy)),qz-at(t(qx)*t(qy))
	xr,yr,zr=xw-xlw,yw-ylw,zw-zlw
	xl=c(qz)*c(qy)*xr-s(qz)*c(qy)*yr+s(qy)*zr
	yl=(s(qz)*c(qx)+c(qz)*s(qy)*s(qx))*xr+(c(qz)*c(qx)-s(qz)*s(qy)*s(qx))*yr-c(qy)*s(qx)*zr
	zl=(s(qz)*s(qx)-c(qz)*s(qy)*c(qx))*xr+(c(qz)*s(qx)+s(qz)*s(qy)*c(qx))*yr+c(qy)*c(qx)*zr
return xl,yl,zl
end
function CalcLclCrd(xw,yw,zw,rqx,rqy,rqz,xlw,ylw,zlw)
	xl,yl,zl=WorldToLocal(xw,yw,zw,rqx,rqy,rqz,xlw,ylw,zlw)
	sr,sqx,sqz=RecToSph(xl,yl,zl)
	return sr,sqx,sqz,xl,yl,zl
end
function pnpn(x,xMax,dx,sign)
	x=x+sign*dx
	if abs(x)>xMax then
		x=sgn(x)*xMax
		sign=-sign
	end
	return x,sign
end
function RadYawS(yw)
	if rng==1 then
		yw=yw+rpt*1
	else
		yw,srs=pnpn(yw,rng/2,2*rpt*rng,srs)
	end
	return angFix(yw)
end
function RadYawT(yw,yw0)
	TRrng=at(10/tsr)/pi2+lostT/10*fov
	dyw=angDif1(yw,yw0)
	if abs(dyw)>TRrng then
		yw=yw0
	else
		dyw,trs=pnpn(dyw,TRrng,fov/2,trs)
		yw=dyw+yw0
	end
	return angFix(yw)
end
function tiltFix(q,v)
	return q-m.min(0,sgn(v))*(sgn(q)/2-2*q)
end

function onTick()
act=inB(1)
isSR,isTR=inB(2),inB(3)
table.insert(yawO,1,yaw)
yawO[5]=nil
if act and yawO[4]~=nil then
	owx,owy,owz=inN(1)+inN(7),inN(2)+inN(8),inN(3)+inN(9)
	com,elv,dst=inN(10)*pi2,inN(11)*pi2,inN(12)
	tm=dst*inN(13)
	vt=inN(6)
	pit,rol=tiltFix(inN(4),vt)*pi2,tiltFix(inN(5),vt)*pi2
	mR,mM=inN(18),inN(19)
	if dst>mR and tm>mM then
		twx,twy,twz=CalcWrldCrd(dst,elv,yawO[4]*pi2,pit,-rol,com,owx,owy,owz)
	else
		tm,twx,twy,twz=0,0,0,0
	end

	rps,dir,rng,fov=inN(21),inN(22),inN(23)/360,inN(24)
	rpt=rps/60

	TRm=inN(29)
	Msgn=1
	if isTR and TRm>0 then
		Msgn=-1
	end

	if Msgn==-1 and abs(TRm-tm)<dM and len3(TRwx-twx,TRwy-twy,TRwz-twz)<dR then
		TRwx,TRwy,TRwz=twx,twy,twz
		lostT=0
	else
		TRwx,TRwy,TRwz=inN(30),inN(31),inN(32)
		lostT=lostT+1
	end

	if TRm>0 and isTR then
		tsr,tsqx,tsqz,tcx,tcy,tcz=CalcLclCrd(TRwx,TRwy,TRwz,-pit,rol,-com,owx,owy,owz)
		tsqx,tsqz=tsqx/pi2,tsqz/pi2
		yaw=RadYawT(yaw,tsqz)
	elseif isSR then
		tcr,tcqx,tcqz=1,0,0
		yaw=RadYawS(yaw)
	end
else
	tm,Msgn,yaw=0,1,0
	srs,trs=1,1
end
ouN(1,tm*Msgn)
ouN(2,twx)
ouN(3,twy)
ouN(4,twz)
ouN(5,tsr)
ouN(6,tsqx)
ouN(7,tsqz)
ouN(11,yaw)
ouB(1,true)
ouB(2,isSR)
ouB(3,isTR)
end

function onDraw()
w=sc.getWidth()
h=sc.getHeight()
sc.setColor(0,255,0)
sc.drawLine(w/2,h/2,w/2+w*c((-yaw+1/4)*pi2),h/2-w*s((-yaw+1/4)*pi2))
drT(1,8,"tm  "..dtm)
drT(1,56,"twx "..dtwx)
drT(1,64,"twy "..dtwy)
drT(1,72,"twz "..dtwz)
drT(1,80,"lostt"..lostT)
if tm>10 then
	sc.setColor(255,0,0)
	drT(1,1,"detect")
	dtm,dtwx,dtwy,dtwz=tm,twx,twy,twz
end
if TRm>10 then
	dtcx,dtcy,dtcz=tcx,tcy,tcz
	drT(1,24,"tcx "..dtcx)
	drT(1,32,"tcy "..dtcy)
	drT(1,40,"tcz "..dtcz)
end
end