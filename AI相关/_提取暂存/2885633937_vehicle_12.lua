-- source: steam id 2885633937 / vehicle.xml block#12
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2885633937
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
	ETA=-3.52+0.194*Adist-7.11*10^(-4)*Adist^2+1.54*10^(-6)*Adist^3
	drop=-0.102+5.25*10^(-3)*Adist-2.38*10^(-5)*Adist^2+4.92*10^(-8)*Adist^3
	else
	ETA=-2.85+0.0869*Adist-1.87*10^-5*Adist^2+1.57*10^-8*Adist^3
	drop=-0.0642+0.00162*Adist-5.86*10^(-7)*Adist^2+4.19*10^(-10)*Adist^3
	end
	drop=drop/360
	aimv=math.atan(Vdist/Hdist)/pi2
	if aimv>0 then
		fix=(1-aimv/0.125)*1.016663*drop
	else
		fix=(1-aimv/0.125)*0.856315*drop
	end
	return fix+aimv,ETA end
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
	artx=GN(15)
	arty=GN(16)
	artz=GN(17)
	isart=GB(2)
	ismg=GB(3)
	if isart and artx~=0 then
		tgta=math.atan(-artx+gpsx,arty-gpsy)/(math.pi*2)
		tgte,shellETA=DropAndETA(artx-gpsx,arty-gpsy,artz-alt,ismg)
		SN(30,0)
		SN(31,0)
		SN(32,0)
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
		rlx=avg(xs,rlx,16)
		rly=avg(ys,rly,16)
		rlz=avg(zs,rlz,16)
		spdx=avg(dxs,rlx-xold,64)
		spdy=avg(dys,rly-yold,64)
		spdz=avg(dzs,rlz-zold,64)
		--spdx=rlx-xold
		--spdy=rly-yold
		--spdz=rlz-zold
		xold=rlx
		yold=rly
		zold=rlz
		tgte,shellETA=DropAndETA(rlx,rly,rlz,ismg)
		guessx,guessy,guessz=rlx+spdx*shellETA,rly+spdy*shellETA,rlz+spdz*shellETA
		tgte,shellETA=DropAndETA(guessx,guessy,guessz,ismg)
		guessx,guessy,guessz=rlx+spdx*shellETA,rly+spdy*shellETA,rlz+spdz*shellETA
		tgta=math.atan(-guessx,guessy)/(math.pi*2)
		tgte,shellETA=DropAndETA(guessx,guessy,guessz,ismg)
		tgta=avg(tgtas,tgta,16)
		tgte=avg(tgtes,tgte,16)
		SN(30,rlx+gpsx)
		SN(31,rly+gpsy)
		SN(32,rlz+alt)
	else
		rlx,rly,rlz,spdx,spdy,spdz=0,0,0,0,0,0
		tgta,tgte=0,0
		SN(30,0)
		SN(31,0)
		SN(32,0)
	end
		SN(1,tgta)
		SN(2,tgte)
end

function onDraw()
	w,h=screen.getWidth(),screen.getHeight()
	screen.setColor(222,0,0)
	--screen.drawText(1,46,tgta)
	--screen.drawText(1,53,tgte)
end