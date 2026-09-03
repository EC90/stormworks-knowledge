-- source: steam id 3603910667 / vehicle.xml block#189
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
pN=property.getNumber
pB=property.getBool
M=math
abs=M.abs
sin=M.sin
cos=M.cos
tan=M.tan
sqrt=M.sqrt
asin=M.asin
acos=M.acos
atan=M.atan
exp=M.exp
pi=M.pi
pi2=M.pi*2

dwtPos={0,0,0}
dstPos={0,0,0}
wtPos={0,0,0}
wtSP={0,0,0}
dslSP={0,0,0}

stPos={0,1000,0}
tPos={3970,-33920,1000}
tSP={0,0,0}
A=1

wPos300=Z
wPosunlock=Z
Lockon=false
Disconnect=false

timer=0
timerl=0
timer1=0
timer2=0

pitpull=false

function onTick()
	SelfPos={GN(1),GN(3),GN(2)}
	Euler={GN(4),GN(6),GN(5)}
	slSP={GN(7),GN(9),GN(8)}
	sAV={-GN(10),-GN(12),-GN(11)}
	Dis=GN(21)
	
	eH,eV=GN(13)/cos(GN(14)*pi2),GN(14)/cos(GN(13)*pi2)
	stPos=L2W(add(R2L({Dis,-eH,eV}),{0,-5,0}))
	wtPos=add(stPos,SelfPos)
	
	locking=GN(13)~=0 and GN(14)~=0 and abs(GN(21)-GN(22))<1 and (dis(add(wtPos,mux({GN(15),GN(16),GN(17)},-1)))<pN("judge distance") or dis({GN(15),GN(16),GN(17)})<1)
	
	if locking then
	tSP=mux(add(wtPos,mux(dwtPos,-1)),60)
	stSP=mux(add(stPos,mux(dstPos,-1)),60)
	stPos1=add(stPos,mux(stSP,10/60))
	dwtPos=wtPos
	dstPos=stPos
	--tPos=add(wtPos,mux(tSP,Dis/dis(slSP)/2))
	tPos=wtPos
	tAV=mux(cmux(stPos1,stSP),1/dis(stPos1)^2)
	--tAV=mux(cmux(stPos,stSP),1/dis(stPos1)^2)
	sAV=mux(cmux(slSP,add(slSP,mux(dslSP,-1))),60/dis(slSP)^2/pi2)
	dslSP=slSP
	cwAV=add(mux(tAV,24/pi2),mux(sAV,-2/pi2))
	timer=0
	else
	if timer<1 then
	timer=timer+0.07
	else
	timer=-1
	end
		if dis({GN(16),GN(17),GN(18)})~=0 then
		tPos={GN(15),GN(16),GN(17)}
		tSP={GN(18),GN(19),GN(20)}
		else
		tPos=add(tPos,mux(tSP,1/60))
		end
		
	if Disconnect then
	tPos=add(mux(wPosunlock,100000),mux(wPos300,-99999))
	end
		
	if timerl<120 then
	awPos=L2W({0,1,0})
	else
	awPos=L2W(slSP)
	end
	--atPos=add(add(tPos,mux(SelfPos,-1)),mux(tSP,dis(tPos)/400*pN("Prefix ratio")))
	atPos=add(tPos,mux(SelfPos,-1))
	atPosdis=dis(atPos)
	atPos=add(atPos,mux(tSP,atPosdis/10*pN("Prefix ratio")))
	pitpull=dis(atPos)<5000 and GN(23)==0
	stPos=atPos
	twAV=cmux(mux(awPos,A/dis(awPos)),mux(atPos,A/dis(atPos)))
	
	cwAV=add(mux(twAV,5),mux(sAV,-1))
	end
	
	if dis(slSP)<300 then
	wPos300=SelfPos
	wPosunlock=tPos
	end
	locking=GN(13)~=0 and GN(14)~=0
	
	if locking then
	timer1=timer1+1
	timer2=0
	else
	timer2=timer2+1
	timer1=0
	end
	
	if timer1>10 then
	Lockon=true
	end
	if timer2>60 and Lockon and timerl>=120 then
	Lockon=false
	Disconnect=true
	end
	
	ytPos=W2L(stPos)
	yawx=atan2(ytPos[1],ytPos[2])/pi2+timer*0.1
	yawy=atan2(ytPos[3],ytPos[2])/pi2+timer*0.1
	cs=W2L(cwAV)
	if dis(slSP)<10 or timerl<10 then
	cs[3],cs[1],yawx,yawy=0,0,0,0
	end
	if GN(23)==0 then
	timerl=timerl+1
	end
	--SN(1,cs[3]*0.6)
	--SN(2,cs[1]*0.6)
	SN(1,cs[3]*0.4)
	SN(2,cs[1]*0.4)
	
	FOV=atan((dis(tSP)/10+100)/dis(stPos))/pi2
	FOV=1
	
	SN(3,tPos[1])
	SN(4,tPos[2])
	SN(5,tPos[3])
	SN(6,FOV)
	SN(7,yawx)
	SN(8,yawy)
	
	SB(2,pitpull)
end

function E2R(_)
	local x,y,z=_[1],_[2],_[3] return {{cos(y)*cos(z),cos(x)*cos(y)*sin(z)+sin(x)*sin(y),sin(x)*cos(y)*sin(z)-cos(x)*sin(y)},{-sin(z),cos(x)*cos(z),sin(x)*cos(z)},{sin(y)*cos(z),cos(x)*sin(y)*sin(z)-sin(x)*cos(y),sin(x)*sin(y)*sin(z)+cos(x)*cos(y)}}
end
function tM(M)
	local t={{},{},{}}
	for i=1,3 do
		for j=1,3 do
			t[i][j]=M[j][i]
		end
	end
	return t
end
function trace(_)
	return _[1][1]+_[2][2]+_[3][3]
end
function Mv3(M,V)
	local t={{},{},{}}
	for i=1,3 do
		for j=1,3 do
			_=0
			for l=1,3 do
				_=_+M[i][l]*V[l][j]
			end
			t[i][j]=_
		end
	end
	return t
end
function Mv(M,v)
	local t={}
	for i=1,3 do
		_=0
		for j=1,3 do
			_=_+M[j][i]*v[j]
		end
		t[i]=_
	end
	return t
end
function L2W(_)
	return Mv(tM(E2R(Euler)),{_[1],_[2],_[3]})
end
function W2L(_)
	return Mv(E2R(Euler),{_[1],_[2],_[3]})
end
function R2L(r) return {r[1]*cos(r[3]*pi2)*sin(r[2]*pi2),r[1]*cos(r[3]*pi2)*cos(r[2]*pi2),r[1]*sin(r[3]*pi2)} end
function pid(data,setpoint,coff,En,down,up)
	if En then
		data[2]=clamp(data[2]+(setpoint-data[1])*coff[2],down,up)
		local out=(setpoint-data[1])*coff[1]+(data[2])+(setpoint-data[1]-data[3])*coff[3]
		data[3]=setpoint-data[1]
		return data,out
	else
		data,out={0,0,0},0
		return data,out
	end
end
function dis(y) return sqrt(y[1]^2+y[2]^2+y[3]^2) end
function add(a,b) return {a[1]+b[1],a[2]+b[2],a[3]+b[3]} end
function mux(a,b) return {a[1]*b,a[2]*b,a[3]*b} end
function cmux(a,b) return {a[2]*b[3]-a[3]*b[2],a[3]*b[1]-a[1]*b[3],a[1]*b[2]-a[2]*b[1]} end
function clamp(x,a,b)
	if x<a then x=a end
	if x>b then x=b end
	return x
end

function sgn(x)
	if x<0 then
	y=-1
	else
	y=1
	end
	return x
end
	
function atan2(y,x)
	if x>0 then
	return atan(y/x)
	elseif y<0 then
	return atan(y/x)-pi
	else
	return atan(y/x)+pi
	end
end