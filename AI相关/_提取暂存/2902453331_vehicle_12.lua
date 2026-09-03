-- source: steam id 2902453331 / vehicle.xml block#12
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2902453331
-- Author: TAK4129
-- GitHub: https://github.com/yukimaru73
-- Workshop: https://steamcommunity.com/profiles/76561198174258594/myworkshopfiles/?appid=573090
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 2967 (3365 with comment) chars

as=property
az=input
t=math
ay=t.atan
ak=output.setNumber
q=az.getNumber
x=as.getNumber
l=t.pi
E=t.cos
ar=t.sqrt
U=t.sin
y=y or{}y.N=function(aP,G,aL)G=G or{}for aC,z in pairs(aP)do
G[aC]=not aL and G[aC]or z
end
return G
end;
av={J=function(g,e,f,d,i)return y.N(g,{e=e or 0,f=f or 0,d=d or 0,i=i or 0})end;
am=function(_)return _:J(-_.e,-_.f,-_.d,_.i)end;
Q=function(_,c)return _:J(c.e*_.i-c.f*_.d+c.d*_.f+c.i*_.e,c.e*_.d+c.f*_.i-c.d*_.e+c.i*_.f,-c.e*_.f+c.f*_.e+c.d*_.i+c.i*_.d,-c.e*_.e-c.f*_.f-c.d*_.d+c.i*_.i)end;
aa=function(g,R,b)R=R/2
local Y,aO=U(R),ar(b[1]^2+b[2]^2+b[3]^2)for u=1,3 do
b[u]=b[u]/aO
end
local p=g:J(b[1],b[2],b[3],0)p.e=Y*p.e
p.f=Y*p.f
p.d=Y*p.d
p.i=E(R)return p
end;
Z=function(_,b)local T={}local k=_:Q(_:J(b[1],b[2],b[3],0):Q(_:am()))T[1]=k.e
T[2]=k.f
T[3]=k.d
return T
end;
ai=function(g,m,n,o)local z,k={1,0,0},g:aa(o,{0,-1,0})z=k:Z({0,0,1})k=g:aa(m,z):Q(k)z=k:Z({-1,0,0})k=g:aa(n,z):Q(k)return k
end}aw={w=function(g,m,n,o)return y.N(g,{m=m or 0,n=n or 0,o=o or 0,ao=av:ai(m or 0,n or 0,o or 0),au=0,ah=0,aA=0})end;
v=function(_,j,M,S,V)V=V or .25
S=((S+1.75)%1-.5)*2*l
j=2*l*j
M=t.asin(U(2*l*M)/E(j))if V<0 then
if j>0 then
j=l-j
elseif j<0 then
j=-l-j
elseif V==0 then
j=l/2
end
end
_.au=j-_.m
_.ah=M-_.n
_.aA=(S-_.o+3*l)%(2*l)-l
_.m=j
_.n=M
_.o=S
_.ao=av:ai(_.m,_.n,_.o)end;
aH=function(_,b)return _.ao:am():Z(b)end;
aK=function(_,af)return aw:w(_.m+_.au*af,_.n+_.ah*af,_.o+_.aA*af)end}aJ={w=function(g,ab,H,ac,s)return y.N(g,{ab=ab,H=H,ac=ac,s=s,K=0,D=0,A=0,at=1/60})end;
v=function(_,C,c)local a=_
a.K=a.D
a.D=C-c
a.A=a.A+(a.D+a.K)/2*a.at
local aN,u,aT=a.ab*a.D,a.H*a.A,a.ac*(a.D-a.K)/a.at
if u>a.s then
a.A=a.s/a.H
u=a.s
elseif u<-a.s then
a.A=-a.s/a.H
u=-a.s
end
return aN+u+aT
end;
aF=function(_)_.K=0
_.A=0
end}an={w=function(g,I,O,P)local aQ={h=0,r=0,I=I,O=O,P=P}return y.N(g,aQ)end;
v=function(_,r)_.r=r
if _.h<_.r then
_.h=t.min(_.h+_.I,_.r)elseif _.h>_.r then
_.h=t.max(_.h-_.I,_.r)end
if _.h<_.O then
_.h=_.O
elseif _.h>_.P then
_.h=_.P
end
return _.h
end;
aF=function(_)_.h=0
_.r=0
end}L=x("Max Left Horizontal Angle")/360
X=x("Max Right Horizontal Angle")/360
aV=x("Max Up Vertical Angle")/90
aW=x("Max Down Vertical Angle")/90
ae=x("Horizontal Speed")/100
aD=x("Vertical Speed")/100
aU=(L+X==0)and(L==.5)aX=an:w(ae/100,X*4,L*4)aG=an:w(aD/100,aW,aV)aE=as.getBool("Horizontal Pivot")aB=aw:w()ag=0
W=0
aj=0
ap=aJ:w(20,.005,.3,.08)al=.5/l
function onTick()aB:v(q(14),q(15),q(16),.25)if az.getBool(1)then
local aZ,aI,a=q(1),q(2),q(3)local aR=aM(a,aI)local aS=aB:aK(8):aH(aR)ag,aj=aY(aS)end
if aE then
local ax,ad=aq(ag,X,L),0
if aU then
ad=ap:v((ax-q(13)+1.5)%1-.5,0)else
ad=ap:v(ax-q(13),0)end
W=aq(ad,-ae,ae)else
W=aX:v(ag*4)end
ak(1,W)ak(2,aG:v(aj*4))end
function aM(F,B)local e=E(B)*E(F)local f=U(B)local d=E(B)*U(F)return{e,f,d}end
function aY(b)local F,B
F=ay(b[3],b[1])B=ay(b[2],ar(b[1]^2+b[3]^2))return F*al,B*al
end
function aq(C,min,max)if C<min then
return min
elseif C>max then
return max
else
return C
end
end
