-- source: steam id 2793934450 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793934450
-- Author: Jumper
-- GitHub: https://github.com/Jumper-44
-- Workshop: https://steamcommunity.com/profiles/76561198084249280/myworkshopfiles/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 3574 (3957 with comment) chars

p=nil
ae=table
Q=math
aT=property
aH=input
K=output.setNumber
aM=aH.getBool
ac=aT.getText
aQ=Q.random
N=aT.getNumber
R=aH.getNumber
F=Q.cos
G=Q.sin
function at(s,D,aq)D={}s.insert=function(bh)aq=#D>0 and ae.remove(D)or#s[1]+1
for _=1,#s do
s[_][aq]=bh[_]end
return aq
end
s.remove=function(bl)D[#D+1]=bl
end
return s
end
aG=function(...)local H,T,P,M,al,b,ad,bo,e,q,af,X
local f,w,L,Z,J,t,aP,m={...},{},{},{},{},{0,0,0,{}},{},{}H=#f
P=at({w,L,Z,J})P.insert(t)for h=1,H do
aP[h]=function(d,j)return f[h][d]<f[h][j]end
end
function ad(c,h,r)b=J[c]if b then
b[#b+1]=al
if#b==16 then
ae.sort(b,aP[h])w[c]=.5*(f[h][b[8]]+f[h][b[9]])J[c]=false
t[4]=b
L[c]=P.insert(t)t[4]={}Z[c]=P.insert(t)for _=9,16 do
t[4][_-8]=b[_]b[_]=p
end
end
else
return ad(f[h][al]<w[c]and L[c]or Z[c],r%H+1,r+1)end
end
f.bj=function(ap)al=ap
ad(1,1,1)end
function T(bd,b_)local ar=0
for _=1,H do
local aN=bd[_]-f[_][b_]ar=ar+aN*aN
end
return ar
end
f.T=T
f.m=m
function af(ah)for _=1,#e do
if m[ah]<m[e[_]]then
ae.insert(e,_,ah)return
end
end
e[#e+1]=ah
end
function X(c,r)local h,as,am=r%H+1,Z[c],L[c]b=J[c]if b then
for _=1,#b do
m[b[_]]=T(M,b[_])if#e<q then
af(b[_])else
if m[b[_]]<m[e[q]]then
e[q]=p
af(b[_])end
end
end
else
if M[h]<w[c]then
as,am=am,as
end
X(as,r+1)local v=M[h]-w[c]if#e<q or m[e[q]]>=v*v then
X(am,r+1)end
end
end
f.bf=function(ap,bc)e={}M=ap
q=bc
X(1,0)return e
end
return f
end
function ag(aV,a)a=a or{}for E in aV:gmatch("([^,]+)")do
a[#a+1]=tonumber(E)end
return a
end
function k(a,g,i,ai)a=a or{}a[1]=g or 0
a[2]=i or 0
a[3]=ai or 0
return a
end
function aj(d,j,a)for _=1,#d do
a[_]=d[_]+j[_]end
return a
end
function aX(d,aU,a)for _=1,#d do
a[_]=d[_]*aU
end
return a
end
function bi(d,j,a)a[1],a[2],a[3]=d[2]*j[3]-d[3]*j[2],d[3]*j[1]-d[1]*j[3],d[1]*j[2]-d[2]*j[1]return a
end
function aK(bk,bm,a)a=a or{}for _=1,bm do
a[_]=a[_]or{}for W=1,bk do
a[_][W]=0
end
end
return a
end
function aR(au,E,a)for _=1,3 do
a[_]=au[1][_]*E[1]+au[2][_]*E[2]+au[3][_]*E[3]end
return a
end
function bb(ay,aO,aS,a)a=a or aK(3,3,a)local C,A,B,x,U,y=G(ay),G(aO),G(aS),F(ay),F(aO),F(aS)a[1][1]=U*y
a[1][2]=U*B
a[1][3]=-A
a[2][1]=-x*B+C*A*y
a[2][2]=x*y+C*A*B
a[2][3]=C*U
a[3][1]=C*B+x*A*y
a[3][2]=-C*y+x*A*B
a[3][3]=x*U
return a
end
aw=Q.pi*2
function aE(g,i,ai)return R(g),R(i),R(ai)end
local ba=(1+5^.5)/2
local aC=N("Laser_Spread_Multiplier")local bg=function(bp)return(aQ()-.5)*aC,(aQ()-.5)*aC
end
local be=.125+.017
local n={}local l=1
local o={}local O=N("Laser_amount")local aW=N("Laser_tick_offset")local aY=N("Point_Min_Density_Squared")local Y={}local ax={}for _=1,O do
local V,an,aI
V=ag(ac("Laser_forward_dir".._))an=ag(ac("Laser_right_dir".._))aI=bi(V,an,{})ax[_]={an,aI,V}Y[_]=ag(ac("Laser_GPS_to_head".._))aj(Y[_],aX(V,be,{}),Y[_])n[_]={g={},i={}}o[_]=k()end
local ao=0
local az=ba/10
local bn=az/O
local aB,S,aA=k(),k(),aK(3,3)local I,u,z={},{},{}local b=at({I,u,z})local ab=aG(I,u,z)local aD,aF=k(),k()function onTick()aZ=aM(1)if aM(2)then
I,u,z={},{},{}b=at({I,u,z})ab=aG(I,u,z)end
ao=ao+1
l=l%aW+1
if aZ then
k(aB,aE(1,2,3))k(S,aE(4,5,6))bb(S[1],S[2],S[3],aA)for _=1,O do
local aa=R(6+_)if aa>0 and aa<4000 and n[_].g[l]~=p then
local av,aL=n[_].g[l],n[_].i[l]local v=F(aL)*aa
aj(aB,aR(aA,aj(Y[_],aR(ax[_],k(aD,G(av)*v,G(aL)*aa,F(av)*v),aF),aF),aD),o[_])local aJ=ab.bf(o[_],1)if aJ[1]==p or ab.m[aJ[1]]>aY then
ab.bj(b.insert(o[_]));
else
k(o[_])end
else
k(o[_])end
local g,i=bg(ao*az+(_-1)*bn)n[_].g[l]=g/8*aw
n[_].i[l]=i/8*aw
local ak=(_-1)*5
K(ak+1,g)K(ak+2,i)for W=1,3 do
K(ak+W+2,o[_][W])end
end
else
for _=1,O do
n[_].g[l]=p
n[_].i[l]=p
end
for _=1,32 do
K(_,0)end
end
end
