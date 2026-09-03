-- source: steam id 3603910667 / vehicle.xml block#71
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

function onTick()
	wltgt={GN(7),GN(8),GN(9)}
	wl={GN(1),GN(3),GN(2)}
	wsltgt=sub(wltgt,wl)
	Euler={GN(4),GN(6),GN(5)}
	sltgt=Mv(E2R(Euler),wsltgt)
	
	phy=atan2(sltgt[2],sltgt[1])
	tha=M.acos(sltgt[3]/sqrt(sltgt[1]^2+sltgt[2]^2+sltgt[3]^2))
	phy=phy/pi2*4
	tha = (-tha/pi2+0.25)*4
	
	if GN(10)+0.01<0.1 then
	phy=0
	tha=0.2
	end
	
	SN(1,phy)
	SN(2,tha)
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
	
function E2R(_)
local cx,cy,cz,sx,sy,sz=cos(_[1]),cos(_[2]),cos(_[3]),sin(_[1]),sin(_[2]),sin(_[3]) return {{cy*cz,cx*cy*sz+sx*sy,sx*cy*sz-cx*sy},{-sz,cx*cz,sx*cz},{sy*cz,cx*sy*sz-sx*cy,sx*sy*sz+cx*cy}}
end

function L2W(_)
return Mv(tM(E2R(Euler)),{_[1],_[2],_[3]})
end

function W2L(_)
return Mv(E2R(Euler),{_[1],_[2],_[3]})
end

function R2L(f)return{f[1]*cos(f[3]*pi2)*sin(f[2]*pi2),f[1]*cos(f[3]*pi2)*cos(f[2]*pi2),f[1]*sin(f[3]*pi2)}
end

function pid(g,h,i,j,k,l)
if j then
g[2]=clamp(g[2]+(h-g[1])*i[2],k,l)
local out=(h-g[1])*i[1]+g[2]+(h-g[1]-g[3])*i[3]g[3]=h-g[1]return g,out else g,out={0,0,0},0
return g,out 
end
end

function dis(y)
return sqrt(y[1]^2+y[2]^2+y[3]^2)
end

function add(m,n)return{m[1]+n[1],m[2]+n[2],m[3]+n[3]}
end

function sub(m,n)return{m[1]-n[1],m[2]-n[2],m[3]-n[3]}
end

function mux(m,n)return{m[1]*n,m[2]*n,m[3]*n}
end

function cmux(m,n)return{m[2]*n[3]-m[3]*n[2],m[3]*n[1]-m[1]*n[3],m[1]*n[2]-m[2]*n[1]}
end

function dmux(m,n)
return m[1]*n[1]+m[2]*n[2]+m[3]*n[3]end

function clamp(o,m,n)
if o<m then
o=m
end
if o>n then
o=n
end
return o 
end

function sgn(o)
if o<0 then
y=-1 else y=1
end
return o 
end

function atan2(y,o)
if o>0 then
return atan(y/o)
elseif y<0 then
return atan(y/o)-pi else 
return atan(y/o)+pi 
end
end