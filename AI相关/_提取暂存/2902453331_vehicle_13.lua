-- source: steam id 2902453331 / vehicle.xml block#13
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2902453331
-- Author: TAK4129
-- GitHub: https://github.com/yukimaru73
-- Workshop: https://steamcommunity.com/profiles/76561198174258594/myworkshopfiles/?appid=573090
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 2002 (2400 with comment) chars

T=tonumber
M=nil
v=math
ac=input
V=output
r=V.setNumber
af=V.setBool
a=ac.getNumber
S=property.getText
k=v.pi
ae=v.cos
U=v.sqrt
O=v.sin
A=A or{}A.ad=function(am,u,ag)u=u or{}for aa,s in pairs(am)do
u[aa]=not ag and u[aa]or s
end
return u
end;
P={C=function(l,h,f,c,e)return A.ad(l,{h=h or 0,f=f or 0,c=c or 0,e=e or 0})end;
ap=function(_)return _:C(-_.h,-_.f,-_.c,_.e)end;
E=function(_,b)return _:C(b.h*_.e-b.f*_.c+b.c*_.f+b.e*_.h,b.h*_.c+b.f*_.e-b.c*_.h+b.e*_.f,-b.h*_.f+b.f*_.h+b.c*_.e+b.e*_.c,-b.h*_.h-b.f*_.f-b.c*_.c+b.e*_.e)end;
J=function(l,y,g)y=y/2
local G,aj=O(y),U(g[1]^2+g[2]^2+g[3]^2)for d=1,3 do
g[d]=g[d]/aj
end
local n=l:C(g[1],g[2],g[3],0)n.h=G*n.h
n.f=G*n.f
n.c=G*n.c
n.e=ae(y)return n
end;
K=function(_,g)local w={}local j=_:E(_:C(g[1],g[2],g[3],0):E(_:ap()))w[1]=j.h
w[2]=j.f
w[3]=j.c
return w
end;
R=function(l,p,o,m)local s,j={1,0,0},l:J(m,{0,-1,0})s=j:K({0,0,1})j=l:J(p,s):E(j)s=j:K({-1,0,0})j=l:J(o,s):E(j)return j
end}aq={at=function(l,p,o,m)return A.ad(l,{p=p or 0,o=o or 0,m=m or 0,Z=P:R(p or 0,o or 0,m or 0),ah=0,an=0,as=0})end;
ak=function(_,i,B,z,D)D=D or .25
z=((z+1.75)%1-.5)*2*k
i=2*k*i
B=v.asin(O(2*k*B)/ae(i))if D<0 then
if i>0 then
i=k-i
elseif i<0 then
i=-k-i
elseif D==0 then
i=k/2
end
end
_.ah=i-_.p
_.an=B-_.o
_.as=(z-_.m+3*k)%(2*k)-k
_.p=i
_.o=B
_.m=z
_.Z=P:R(_.p,_.o,_.m)end;
Y=function(_,g)return _.Z:K(g)end}x={0,0,0}t={0,0,0}function N(al)local L,I={},M
for e in string.gmatch(al,"[-0-9.]+")do
I=T(e)if I~=M then
L[#L+1]=T(I)end
end
return L
end
ao=N(S("GPS Position Diff"))ar=N(S("Altitude Position Diff"))H=aq:at()q={0,0,0}function onTick()H:ak(a(14),a(15),a(16),.25)local W=H:Y(ao)local au=H:Y(ar)q[1]=a(17)-W[1]q[2]=a(18)-au[2]q[3]=a(19)-W[3]local F={a(17),a(18),a(19)}t[1]=(F[1]-x[1])t[2]=(F[2]-x[2])t[3]=(F[3]-x[3])x=F
local ab,Q,X=q[1]-a(4),q[2]-a(5),q[3]-a(6)local ai=U(ab*ab+Q*Q+X*X)if ai<20 then
af(1,false)else
af(1,ac.getBool(1))end
for d=1,3 do
r(d,q[d]+t[d]*5)r(d+3,a(d+3))r(d+6,t[d])r(d+9,a(d+9))r(d+13,a(d+13))end
r(13,a(13))r(20,a(20))end
