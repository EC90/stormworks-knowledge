-- source: steam id 2892569502 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2892569502
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
M=math
abs=M.abs
sin=M.sin
cos=M.cos
tan=M.tan
asin=M.asin
atan=M.atan
pi=M.pi
pi2=M.pi*2

xold=0
yold=0
zold=0

xs,ys,zs={},{},{}
xss,yss,zss={},{},{}
tgtas,tgtes={},{}
dxs,dys,dzs={},{},{}
dxss,dyss,dzss={},{},{}
x,y,z,spdx,spdy,spdz=0,0,0,0,0,0
function avg(n,v,t)
	table.insert(n,v)
	if #n>t then table.remove(n,1) end
	sum=0
	for i=1,#n do sum=sum+n[i] end
	return sum/#n end
function DropAndETA(dltx,dlty,dltz,issub)
	Hdist,Vdist,Adist=math.sqrt(dltx^2+dlty^2),dltz,math.sqrt(dltx^2+dlty^2+dltz^2)
	if issub then
	ETA=-3.93+0.144*Adist-3.21*10^(-4)*Adist^2+4.61*10^(-7)*Adist^3
	drop=-0.0912+3.06*10^(-3)*Adist-8.59*10^(-6)*Adist^2+1.17*10^(-8)*Adist^3
	else
	ETA=1.56+0.0695*Adist+9.53*10^(-6)*Adist^2
	drop=0.0605+1.19*10^(-3)*Adist+2.41*10^(-7)*Adist^2
	end
	drop=drop/360
	aimv=math.atan(Vdist/Hdist)/pi2
	if aimv>0 then
		fix=-0.05*(aimv/0.125)
	else
		fix=0.12*(aimv/0.125)
	end
	--return fix+aimv,ETA end
	return (1+fix)*drop+aimv,ETA,aimv end
function onTick()
	gpsx=GN(1)
	gpsy=GN(2)
	alt=GN(3)
	rdrcps=-GN(4)*pi2
	rdrpitch=-GN(5)*pi2
	rdrroll=-GN(6)*pi2
	rdrd=GN(11)
	rdra=GN(12)*pi2
	rdre=GN(13)*pi2
	artx=GN(27)
	arty=GN(28)
	artz=GN(29)
	islock=GB(4)
	isart=GB(30)
	ismg=GB(3)
	if isart and artx~=0 then
		tgta=math.atan(-artx+gpsx,arty-gpsy)/(math.pi*2)
		tgte,shellETA,tgts=DropAndETA(artx-gpsx,arty-gpsy,artz-alt,ismg)
	elseif rdrd>10 then
		xr=0
		yr=0
		zr=0
		n=0
		xr=rdrd*cos(rdre)*sin(rdra)
		yr=rdrd*cos(rdre)*cos(rdra)
		zr=rdrd*sin(rdre)	
		srdrcps=sin(rdrcps)
		crdrcps=cos(rdrcps)
		srdrpitch=sin(rdrpitch)
		crdrpitch=cos(rdrpitch)
		srdrroll=sin(rdrroll)
		crdrroll=cos(rdrroll)
		rly=(yr*crdrcps*crdrpitch+xr*(crdrcps*srdrpitch*srdrroll-srdrcps*crdrroll)+zr*(crdrcps*srdrpitch*crdrroll+srdrcps*srdrroll))
		rlx=(yr*srdrcps*crdrpitch+xr*(srdrcps*srdrpitch*srdrroll+crdrcps*crdrroll)+zr*(srdrcps*srdrpitch*crdrroll-crdrcps*srdrroll))
		rlz=(yr*(-srdrpitch)+xr*(crdrpitch*srdrroll)+zr*(crdrpitch*crdrroll))
		rlx=avg(xs,rlx,64)
		rly=avg(ys,rly,64)
		rlz=avg(zs,rlz,64)
		spdx=avg(dxs,rlx-xold,128)
		spdy=avg(dys,rly-yold,128)
		spdz=avg(dzs,rlz-zold,128)
		xold=rlx
		yold=rly
		zold=rlz
		tgte,shellETA,tgts=DropAndETA(rlx,rly,rlz,ismg)
		guessx,guessy,guessz=rlx+spdx*shellETA,rly+spdy*shellETA,rlz+spdz*shellETA
		tgte,shellETA,tgts=DropAndETA(guessx,guessy,guessz,ismg)
		guessx,guessy,guessz=rlx+spdx*shellETA,rly+spdy*shellETA,rlz+spdz*shellETA
		tgta=math.atan(-guessx,guessy)/(math.pi*2)
		tgte,shellETA,tgts=DropAndETA(guessx,guessy,guessz,ismg)
		tgta=avg(tgtas,tgta,32)
		tgte=avg(tgtes,tgte,64)
	else
		rlx,rly,rlz,spdx,spdy,spdz=0,0,0,0,0,0
		tgta,tgte,tgts=0,0,0
	end
	SN(1,tgta)
	SN(2,tgte)
	lead=tgta-GN(4)
	dropa=tgte-GN(5)
	leadf=lead*math.cos(rdrroll)-dropa*math.sin(rdrroll)
	dropf=lead*math.sin(rdrroll)+dropa*math.cos(rdrroll)
	SN(3,leadf)
	SN(4,dropf)
	SN(1,GN(4)+leadf)
	SN(2,GN(5)+dropf)
	SN(5,tgte-tgts)
	if islock then
		SN(30,rlx+gpsx)
		SN(31,rly+gpsy)
		SN(32,rlz+alt)
	else
		SN(30,0)
		SN(31,0)
		SN(32,0)
	end
end