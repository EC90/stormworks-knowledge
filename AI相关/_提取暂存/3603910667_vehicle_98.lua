-- source: steam id 3603910667 / vehicle.xml block#98
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
atan=M.atan
exp=M.exp
pi=M.pi
pi2=M.pi*2
floor=M.floor
T=true
F=false

--time all in tick
--dis all in meter
--??????
freq=12700

--????????/s ????????/s ????/m ????/m ??????/m/s ????????
MSLDATA=
		{{22,3,8000,1500,350,T,1}
		,{46,4,19000,100,420,T,1}
		,{0,0,0,0,100,F,0}
		,{0,0,0,0,100,F,0}}
MSLDATA[0]={0,0,0,0,100,F,0}

--?????
--???? wltgt -w????? -l?? -tgt??
wltgt={}
wltgt[0]={0,0,0}

target_freq={0,0,0,0,0,0,0,0}

--????
lanuching=F

function onTick()
	--??VLS????
	vlsdata=GN(4)
	--??VLS???????ID
	weapon={floor((vlsdata/100000)%100),floor((vlsdata/1000)%100),floor((vlsdata/10))%100}
	launched=floor(vlsdata%10)
	--????
	med=M.floor(freq/100)-M.floor(freq/100000)*1000
	freq=(med)^2

	--????????
	input_channel = floor(GN(7)+0.1)

	--??????
	--???? wltgt -w????? -l?? -tgt??
	wltgt[input_channel]={GN(1),GN(2),GN(3)}
	
	--????
	target_channel=GN(5)
	--????
	missle_channel=GN(6)
	--????
	launch=GB(1)

	--??????
	if launched>1.5 and launched<2.5 then
		lanuching=F
	end

	--????
	if launch and not lanuching then
		target_freq[target_channel]=freq
		--????
		lanuching=T
	end
	
	--????????????????
	if lanuching then
		--????
		SN(31,missle_channel)
		--????
		SN(32,target_freq[target_channel])
	else
		--????
		SN(31,0)
		--????
		SN(32,0)
	end

	SN(1,wltgt[input_channel][1])
	SN(2,wltgt[input_channel][2])
	SN(3,wltgt[input_channel][3])
	--[[SN(1,input_channel)
	SN(2,input_channel)
	SN(3,input_channel)]]
	SN(7,target_freq[input_channel])
	SN(8,input_channel)
	SB(1,lanuching)

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
function sub(a,b) return {a[1]-b[1],a[2]-b[2],a[3]-b[3]} end
function mux(a,b) return {a[1]*b,a[2]*b,a[3]*b} end
function cmux(a,b) return {a[2]*b[3]-a[3]*b[2],a[3]*b[1]-a[1]*b[3],a[1]*b[2]-a[2]*b[1]} end
function dmux(a,b) return a[1]*b[1]+a[2]*b[2]+a[3]*b[3] end
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