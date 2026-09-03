-- source: steam id 2793934450 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793934450
-- Author: Jumper
-- GitHub: https://github.com/Jumper-44
-- Workshop: https://steamcommunity.com/profiles/76561198084249280/myworkshopfiles/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 2513 (2896 with comment) chars

aq=false
z=math
ac=property
al=input
av=output
J=av.setNumber
ae=av.setBool
S=al.getBool
e=ac.getNumber
u=z.cos
A=z.sin
k=al.getNumber
T=z.pi*2
function ap(j,ar,i)return j<ar and ar or j>i and i or j
end
function F(j,P,L)return k(j),k(P),k(L)end
function aJ(aD,_)_=_ or{}for v in aD:gmatch("([^,]+)")do
_[#_+1]=tonumber(v)end
return _
end
function s(_,j,P,L)_=_ or{}_[1]=j or 0
_[2]=P or 0
_[3]=L or 0
return _
end
function R(f,d,_)for a=1,#f do
_[a]=f[a]+d[a]end
return _
end
function Q(f,aA,_)for a=1,#f do
_[a]=f[a]*aA
end
return _
end
function g(C,H,_)_=_ or{}for a=1,H do
_[a]=_[a]or{}for c=1,C do
_[a][c]=0
end
end
return _
end
function an(C,H,_)_=g(C,H,_)for a=1,z.min(C,H)do
_[a][a]=1
end
return _
end
function aB(l,_)_=_ or{}for a=1,#l[1]do
_[a]=_[a]or{}for c=1,#l do
_[a][c]=l[c][a]end
end
return _
end
function N(f,d,_)_=_ or{}for a=1,#d do
_[a]=_[a]or{}for c=1,#f[1]do
_[a][c]=0
for X=1,#f do
_[a][c]=_[a][c]+f[X][c]*d[a][X]end
end
end
return _
end
function as(l,v,_)for a=1,3 do
_[a]=l[1][a]*v[1]+l[2][a]*v[2]+l[3][a]*v[3]end
return _
end
function am(ah,au,ak,_)_=_ or g(3,3,_)local x,n,o,q,D,r=A(ah),A(au),A(ak),u(ah),u(au),u(ak)_[1][1]=D*r
_[1][2]=D*o
_[1][3]=-n
_[2][1]=-q*o+x*n*r
_[2][2]=q*r+x*n*o
_[2][3]=x*D
_[3][1]=x*o+q*n*r
_[3][2]=-x*r+q*n*o
_[3][3]=q*D
return _
end
function aF(p,B,y,i,w,d,_)_=g(4,4,_)_[1][1]=2*p/(y-i)_[2][2]=2*p/(d-w)_[3][1]=-(y+i)/(y-i)_[3][2]=-(d+w)/(d-w)_[3][3]=B/(B-p)_[3][4]=1
_[4][3]=-B*p/(B-p)return _
end
local ax,at,I,O,U
local aa,ao,G,m,h,M,V,az={},{},{},{},{},{},{},{}local aG,aE,ay,ag,Z,E,ad,ai=g(3,3),g(3,3),g(4,4),g(4,4),an(4,4),an(4,4),g(4,4),g(4,4)local K,W,t=aq,aq,{}local b={aK=e("w"),aL=e("h"),aH=e("near")+.625,aC=e("far"),ab=e("sizeX"),af=e("sizeY"),Y=e("positionOffsetX"),aw=e("positionOffsetY")}b.y=b.ab/2+b.Y
b.i=-b.ab/2+b.Y
b.w=b.af/2+b.aw
b.d=-b.af/2+b.aw
t.aI=aJ(ac.getText("GPS_to_camera"))t.aj=e("tick")/60
function onTick()K=S(1)ae(1,K)ae(2,S(3))if K then
do
W=S(2)s(aa,F(1,2,3))s(G,F(4,5,6))s(ao,F(7,8,9))s(m,F(10,11,12))ax,at=k(13),k(14)I=ap(ax,-.277,.277)*.408*T
U=ap(at,-.125,.125)*.9*T+.404+z.abs(I/.7101)*.122
O=u(I)*.1523
h=s(h,A(I)*.1523,A(U)*O-(W and .141 or .023),u(U)*O+(W and .132 or .161))aF(b.aH-h[3],b.aC,b.y-h[1],b.i-h[1],b.w-h[2],b.d-h[2],ad)Q(m,t.aj*T,m)N(am(m[1],m[2],m[3],aG),am(G[1],G[2],G[3],aE),E)R(R(as(E,R(t.aI,h,V),az),Q(as(E,ao,V),t.aj,V),M),aa,M)Q(M,-1,Z[4])N(aB(E,ay),Z,ag)N(ad,ag,ai)end
for a=1,4 do
for c=1,4 do
J((a-1)*4+c,ai[a][c])end
end
for a=15,20 do
J(a+2,k(a))end
for a=21,31 do
J(a+2,k(a))end
end
end
