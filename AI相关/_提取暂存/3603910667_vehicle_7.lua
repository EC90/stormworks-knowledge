-- source: steam id 3603910667 / vehicle.xml block#7
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
floor=M.floor
T=true
F=false

type=pN("Type")
ID=pN("ID")
delay1=90
if type>1.5 then
delay2=60
else
delay2=2
end

launchbuf=false
launched=false
launchms=0

timer1=0
timer2=0
function onTick()
	launch=GN(1)==ID
	launching=launch and not launchbuf
	counter=0
	if GN(24)>0.5 or GN(25)>0.5 then
		counter=counter+1
		if launching and not launched then
		launched=true
		launchms=1
		end
	end
	for i=2,5 do
	if GN(24+i)>0.5 then
		counter=counter+1
		if launching and not launched then
		launched=true
		launchms=i
		end
	end
	end
	if launched and timer1<delay1 then
	timer1=timer1+1
	end
	if launched and timer1>=delay1 and timer2<delay2 then
	timer2=timer2+1
	end
	if timer2>=delay2 then
	timer1=0
	timer2=0
	launched=F
	end
	SB(1,timer1>=delay1 and launchms==1)
	SB(2,timer1>=delay1 and launchms==2)
	SB(3,timer1>=delay1 and launchms==3)
	SB(4,timer1>=delay1 and launchms==4)
	SB(5,timer1>=delay1 and launchms==5)
	SN(1,type+counter*0.1)
	SB(6,launched)
	launchbuf=launch
	SN(3,launchms)
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