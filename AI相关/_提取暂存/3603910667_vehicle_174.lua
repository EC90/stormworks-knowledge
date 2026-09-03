-- source: steam id 3603910667 / vehicle.xml block#174
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
Z={0,0,0}

tPos={3970,-33920,1000}
tSP=Z
A=1

wPos300=Z
wPosunlock=Z
Lockon=false
Disconnect=false

timer1=0
timer2=0
function onTick()
	SelfPos={GN(1),GN(3),GN(2)}
	Euler={GN(4),GN(6),GN(5)}
	slSP={GN(7),GN(9),GN(8)}
	sAV={-GN(10),-GN(12),-GN(11)}
	if dis({GN(16),GN(17),GN(18)})~=0 then
	tPos={GN(15),GN(16),GN(17)}
	tSP={GN(18),GN(19),GN(20)}
	else
	tPos=add(tPos,mux(tSP,1/60))
	end
	
	if dis(slSP)<300 then
	wPos300=SelfPos
	wPosunlock=tPos
	SN(6,0)
	else
	SN(6,1)
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
	if timer2>120 and Lockon then
	Lockon=false
	Disconnect=true
	end
	
	if Disconnect then
	tPos=add(mux(wPosunlock,100000),mux(wPos300,-99999))
	end
	
	awPos=L2W({0,1,0})
	atPos=add(tPos,mux(SelfPos,-1))
	twAV=cmux(mux(awPos,A),mux(atPos,A/dis(atPos)))
	cwAV=add(twAV,mux(sAV,-1))
	cs=W2L(cwAV)
	SN(3,GN(15))
	SN(4,GN(16))
	SN(5,GN(17))
	
	if GN(21)==1 then
	SN(1,0)
	SN(2,0)
	elseif GN(13)~=0 and GN(14)~=0 and (dis(add(R2L({GN(22),GN(13),GN(14)}),mux(tPos,-1)))<pN("judge distance") or dis({GN(15),GN(16),GN(17)})<0.1) then
	SN(1,GN(13)*50)
	SN(2,GN(14)*50)
	else
	SN(1,-cs[3]*2)
	SN(2,cs[1]*2)
	end
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