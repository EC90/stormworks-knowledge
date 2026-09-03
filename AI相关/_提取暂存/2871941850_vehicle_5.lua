-- source: steam id 2871941850 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2871941850
-- Author: Jumper
-- GitHub: https://github.com/Jumper-44
-- Workshop: https://steamcommunity.com/profiles/76561198084249280/myworkshopfiles/


q=false
av=property
an=math
at=table
aP=input
aB=aP.getBool
O=at.unpack
ae=aP.getNumber
M=an.cos
N=an.sin
function n(a,g,h,ak)a=a or{}a[1]=g or 0
a[2]=h or 0
a[3]=ak or 0
return a
end
function ai(d,f,a)for _=1,#d do
a[_]=d[_]+f[_]end
return a
end
function be(d,bd,a)for _=1,#d do
a[_]=d[_]*bd
end
return a
end
function bw(d,f,a)a[1],a[2],a[3]=d[2]*f[3]-d[3]*f[2],d[3]*f[1]-d[1]*f[3],d[1]*f[2]-d[2]*f[1]return a
end
function aD(bi,bz,a)a=a or{}for _=1,bz do
a[_]=a[_]or{}for o=1,bi do
a[_][o]=0
end
end
return a
end
function aR(as,am,a)for _=1,3 do
a[_]=as[1][_]*am[1]+as[2][_]*am[2]+as[3][_]*am[3]end
return a
end
function bF(aM,aC,aH,a)a=a or aD(3,3,a)local D,C,H,G,X,P=N(aM),N(aC),N(aH),M(aM),M(aC),M(aH)a[1][1]=X*P
a[1][2]=X*H
a[1][3]=-C
a[2][1]=-G*H+D*C*P
a[2][2]=G*P+D*C*H
a[2][3]=D*X
a[3][1]=D*H+G*C*P
a[3][2]=-D*P+G*C*H
a[3][3]=G*X
return a
end
function aL(g,h,ak)return ae(g),ae(h),ae(ak)end
function aS(bf,j)j=j or{}for bh in av.getText(bf):gmatch"[+%w.-]+" do
j[#j+1]=tonumber(bh)end
return j
end
local p,i,ac,x,ag,aT,W,L,ao,ar,Z,V
p={}i=1
x,ag,aT,W=O(aS "LaserSum, tickDelay, PointOUTSum, OutBufferSize")L={}ao={}ar={}Z=q
V=q
do
local az={}local bx=.125+.017
for _=1,x do
local v,ab,aj,bc
v=aS("Laser".._)L[_]={O(v,1,3)}ab={O(v,4,6)}aj={O(v,7,9)}bc=bw(ab,aj,{})ao[_]={aj,bc,ab}ai(L[_],be(ab,bx,{}),L[_])local aw,aA={},{}for o=1,ag do
aw[o]=q
aA[o]=q
end
p[_]={g=aw,h=aA}local aU,aF,f,j=O(v,10,13)az[_]={(aF+aU)/2,aF-aU,(j+f)/2,j-f}ar[_]=v[14]end
local U=(1+5^.5)/2
local bs=U*U
local ay=U/10
local bu=ay/x
function bE(aQ,bj,bv,bo,bA)local j=U*aQ%1
local g=j-.5
local h=(bs*aQ)%1-.5
return bj+bv*g,bo+bA*h
end
local function aN()ac=0
end
aN()function bk()ac=ac+1
i=i%ag+1
Z=aB(1)V=aB(2)if V then
aN()end
end
function bl()local y,J,g,h
if Z then
for _=1,x do
J=az[_]g,h=bE(ac*ay+(_-1)*bu,J[1],J[2],J[3],J[4])y=p[_]y.g[i]=g
y.h[i]=h
end
else
for _=1,x do
y=p[_]y.g[i]=q
y.h[i]=q
end
end
end
end
function bb(u,I,al)I={}u.I=I
function u.R(bp)al=#I>0 and at.remove(I)or#u[1]+1
for _=1,#u do
u[_][al]=bp[_]end
return al
end
return u
end
by=function(m,aq,S,ad,b,ax,T,ah,K,l,c,e,k)local B,F,E,Q,w={},{},{},{},{0,0,0,{}}S=bb{B,F,E,Q}S.R(w)ax=function(d,f)return m[e][d]<m[e][f]end
m.bB=function(aX)c=1
e=1
k=1
repeat
b=Q[c]if b then
b[#b+1]=aX
if#b==16 then
at.sort(b,ax)B[c]=(m[e][b[8]]+m[e][b[9]])/2
Q[c]=q
w[4]=b
F[c]=S.R(w)w[4]={}E[c]=S.R(w)for _=9,16 do
w[4][_-8]=b[_]b[_]=nil
end
end
else
c=m[e][aX]<B[c]and F[c]or E[c]e=k%aq+1
k=k+1
end
until b
end
function T(c,k,e,ap)b=Q[c]if b then
for _=1,#b do
l=0
for o=1,aq do
e=ad[o]-m[o][b[_]]l=l+e*e
end
if l<K then
K=l
ah=b[_]end
end
else
e=k%aq+1
ap=ad[e]<B[c]T(ap and F[c]or E[c],k+1)if K>=(ad[e]-B[c])^2 then
T(ap and E[c]or F[c],k+1)end
end
end
m.br=function(bm)ad=bm
ah=0
K=1e300
T(1,0)return ah,K
end
end
local t=output.setNumber
local au,aY,b_={},{},{}local s,A,r
local function bq()return r==W
end
local function bC(aa)A=A%W+1
r=r+1
au[A]=aa[1]aY[A]=aa[2]b_[A]=aa[3]end
local function bg(_)if r>0 then
t(_,au[s])t(_+1,aY[s])t(_+2,b_[s])s=s%W+1
r=r-1
else
t(_,0)t(_+1,0)t(_+2,0)end
end
local aG,af,aI=n(),n(),aD(3,3)local z,aZ=n(),n()local aJ=an.pi/4
local bD=aT*3-2
local ba,aV,aW
local b
local bt=av.getNumber("MinPointDist")local function aO()s=1
A=0
r=0
ba={}aV={}aW={}b=bb{ba,aV,aW}by(b,3)end
aO()function onTick()bk()if V then
aO()end
if Z then
n(aG,aL(1,2,3))n(af,aL(4,5,6))bF(af[1],af[2],af[3],aI)for _=1,x do
if bq()then
break
end
local Y=ae(6+_)if Y>ar[_]and Y<4000 and p[_].g[i]then
local aK=p[_].g[i]*aJ
local aE=p[_].h[i]*aJ
local l=M(aE)*Y
ai(aG,aR(aI,ai(L[_],aR(ao[_],n(z,N(aK)*l,N(aE)*Y,M(aK)*l),aZ),aZ),z),z)local aa,bn=b.br(z)if bn^.5>=bt then
b.bB(b.R(z))bC(z)end
end
end
end
for _=1,bD,3 do
bg(_)end
bl()end
