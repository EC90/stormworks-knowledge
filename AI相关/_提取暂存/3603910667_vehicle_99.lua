-- source: steam id 3603910667 / vehicle.xml block#99
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

--time all in tick
--dis all in meter
id=4

MAXETA=3.5*60
MINETA=0*60
MAXRAN=2500
MINRAN=0
MSSPD=700/60

launch=false
WLTGTbuf={0,0,0}
launchid=0

tgttimer={}
tgttimer[0]=0
tgtdata={}
tgtdata[0]={0,0,0}
tgtspd={}
tgtspd[0]={0,0,0}
tgtwlb={}
tgtwlb[0]=2

function onTick()

for i=1,6 do
WLTGT={GN(9+(i-1)*4),GN(10+(i-1)*4),GN(11+(i-1)*4)}
WLSLO={GN(5),GN(6),GN(7)}
tgtid=M.floor(GN(12+(i-1)*4))
tgtwl=(GN(12+(i-1)*4)%1)*10
if tgtdata[tgtid]==nil then
tgtdata[tgtid]=WLSLO
tgtspd[0]={0,0,0}
tgttimer[tgtid]=0
tgtwlb[tgtid]=2
end
WSTGT=sub(WLTGT,tgtdata[tgtid])
LLTGT=sub(WLTGT,WLSLO)
CLRATE=-dmux(LLTGT,WSTGT)/dis(LLTGT)
tgtdata[tgtid]=WLTGT
tgtspd[tgtid]=WSTGT
tgtwlb[tgtid]=tgtwl
if dis(LLTGT)-CLRATE*MAXETA<MAXRAN and dis(LLTGT)-CLRATE*MAXETA>MINRAN and tgtwl>0.5 and tgtwl<1.5 and not launch and tgttimer[tgtid]==0 and  tgtid>0 then
--if dis(LLTGT)<MAXRAN and dis(LLTGT)>MINRAN and tgtwl>0.5 and tgtwl<1.5 and not launch and tgttimer[tgtid]==0 and  tgtid>0 then
launch=true
launchid=tgtid
tgttimer[launchid]=0
end

if tgttimer[tgtid]>0 then
tgttimer[tgtid]=tgttimer[tgtid]-1
end

end

if tgtwlb[launchid]>1.1 then
launch=false
launchid=0
end

if GN(id)>0.5 and launch then
launch=false
tgttimer[launchid]=120
launchid=0
end

WLTGTbuf=WLTGT
--outtgt=add(tgtdata[launchid],mux(add(tgtspd[launchid],{0,0,3}),dis(sub(tgtdata[launchid],WLSLO))/MSSPD*0))
outtgt=tgtdata[launchid]
SN(1,outtgt[1])
SN(2,outtgt[2])
SN(3,outtgt[3])
SN(4,tgtwlb[1])
SB(1,launch)
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