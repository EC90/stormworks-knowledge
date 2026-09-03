-- source: steam id 2871941850 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2871941850
-- Author: Jumper
-- GitHub: https://github.com/Jumper-44
-- Workshop: https://steamcommunity.com/profiles/76561198084249280/myworkshopfiles/


bh=property
u=math
aK=input
bb=output
aJ=bb.setNumber
V=aK.getBool
az=u.abs
aI=bh.getNumber
b_=bh.getText
n=u.cos
s=u.sin
x=aK.getNumber
D=u.pi*2
function w(r,m,i)return r<m and m or r>i and i or r
end
function P(r,ax,an)return x(r),x(ax),x(an)end
function K(_,r,ax,an)_=_ or{}_[1]=r or 0
_[2]=ax or 0
_[3]=an or 0
return _
end
function aD(j,e,_)for a=1,#j do
_[a]=j[a]+e[a]end
return _
end
function au(j,bm,_)for a=1,#j do
_[a]=j[a]*bm
end
return _
end
function p(ae,S,_)_=_ or{}for a=1,S do
_[a]=_[a]or{}for f=1,ae do
_[a][f]=0
end
end
return _
end
function v(ae,S,_)_=p(ae,S,_)for a=1,u.min(ae,S)do
_[a][a]=1
end
return _
end
function aL(o,_)_=_ or{}for a=1,#o[1]do
_[a]=_[a]or{}for f=1,#o do
_[a][f]=o[f][a]end
end
return _
end
function J(j,e,_)_=_ or{}for a=1,#e do
_[a]=_[a]or{}for f=1,#j[1]do
_[a][f]=0
for aS=1,#j do
_[a][f]=_[a][f]+j[aS][f]*e[a][aS]end
end
end
return _
end
function aT(o,ar,_)for a=1,3 do
_[a]=o[1][a]*ar[1]+o[2][a]*ar[2]+o[3][a]*ar[3]end
return _
end
function bo(h,_)_=p(3,3,_)local m,I=s(h),n(h)_[1][1]=1
_[2][2]=I
_[2][3]=m
_[3][2]=-m
_[3][3]=I
return _
end
function bp(h,_)_=p(3,3,_)local m,I=s(h),n(h)_[2][2]=1
_[1][1]=I
_[1][3]=-m
_[3][1]=m
_[3][3]=I
return _
end
function bc(aE,aO,aW,_)_=_ or p(3,3,_)local L,C,G,A,Q,B=s(aE),s(aO),s(aW),n(aE),n(aO),n(aW)_[1][1]=Q*B
_[1][2]=Q*G
_[1][3]=-C
_[2][1]=-A*G+L*C*B
_[2][2]=A*B+L*C*G
_[2][3]=L*Q
_[3][1]=L*G+A*C*B
_[3][2]=-L*B+A*C*G
_[3][3]=A*Q
return _
end
function bg(g,k,l,i,c,e,_)_=p(4,4,_)_[1][1]=2*g/(l-i)_[2][2]=2*g/(e-c)_[3][1]=-(l+i)/(l-i)_[3][2]=-(e+c)/(e-c)_[3][3]=k/(k-g)_[3][4]=1
_[4][3]=-k*g/(k-g)return _
end
function aq(aA,c)c=c or{}for aa in b_(aA):gmatch"[+%w.-]+" do
c[#c+1]=tonumber(aa)end
return c
end
function bl(aA,c)c=c or{}for aa in b_(aA):gmatch"[^!]+" do
aq(aa,c)end
return c
end
local ba,aG,h,t,q,at,as,bs={},{},{},{},{},{},{},{}local aV,M=false,{}local aZ,aM,y,ad,bi,H,ao,be=v(3,3),v(3,3),v(4,4),v(4,4),v(4,4),v(4,4),p(4,4),p(4,4)local b=bl "S"
b.g=b[3]+.635
b.k=b[4]b.l=b[5]/2+b[7]b.i=-b[5]/2+b[7]b.c=b[6]/2+b[8]b.e=-b[6]/2+b[8]local d={aa=256,bB=192,bn=1.014197,g=.1,k=b[4]}d.c=d.g*u.tan(d.bn/2)d.l=d.c*4/3
d.i=-d.l
d.e=-d.c
local O,al,N,aw,R,ap,z,aB,am
z=aI("SeatTick")aB=(z+1)^2/2
am=(z+2)^3/6
O,N,R=table.unpack(aq "Mouse (Vel, Acc, Jerk) Smoothing")al,aw,ap=1-O,1-N,1-R
local W,ai,aY,aX,af,ah,ab,U,ag,aj=0,0,0,0,0,0,0,0,0,0
local aH,bf,aR,aP,aQ,aF=0,0,0,0,0,0
local bz,bv=.35,-.35
local bu,bq=.2,-.2
M.by=aq "GPS_to_camera"
M.bd=aI("PhysicsTick")/60
function br(T,ak)local E,F,Y,X,bj,bk
E=T-aH
F=ak-bf
Y=E-aR
X=F-aP
bj=w(Y-aQ,-.001,.001)bk=w(X-aF,-.001,.001)aY=T
aX=ak
af=af*O+E*al
ah=ah*O+F*al
ab=ab*N+Y*aw
U=U*N+X*aw
ag=ag*R+bj*ap
aj=aj*R+bk*ap
if az(E)<1e-9 and az(F)<1e-9 then
W=T
ai=ak
af=0
ah=0
ab=0
U=0
ag=0
aj=0
else
W=w(aY+af*z+ab*aB+ag*am,bv,bz)ai=w(aX+ah*z+U*aB+aj*am,bq,bu)end
aH=T
bf=ak
aR=E
aP=F
aQ=Y
aF=X
end
function bw(aC,ay,ac,bt)local av=w(aC,-.277,.277)*.408*D
local aN=w(ay,-.125,.125)*.9*D+.404+az(av/.7101)*.122
local aU=n(av)*.1523
K(bt,s(av)*.1523,s(aN)*aU-(ac and .141 or .023),n(aN)*aU+(ac and .132 or .161))end
function bx(Z,bA)if Z then
bg(d.g,d.k,d.l,d.i,d.c,d.e,ao)else
bg(b.g-q[3],b.k,b.l-q[1],b.i-q[1],b.c-q[2],b.e-q[2],ao)end
au(t,M.bd*D,t)J(bc(t[1],t[2],t[3],aZ),bc(h[1],h[2],h[3],aM),H)aD(aD(aT(H,aD(M.by,q,as),bs),au(aT(H,aG,as),M.bd,as),at),ba,at)if Z then
J(bp(W*D,aZ),bo(-ai*D,aM),y)J(H,y,ad)aL(ad,y)else
aL(H,y)end
au(at,-1,bi[4])J(y,bi,ad)J(ao,ad,bA)end
function onTick()aV=V(1)for a=17,32 do
aJ(a,x(a))end
for a=1,32 do
bb.setBool(a,V(a))end
if aV then
do
local ac,Z=V(2),V(5)K(ba,P(1,2,3))K(h,P(4,5,6))K(aG,P(7,8,9))K(t,P(10,11,12))local aC=x(13)local ay=x(14)br(aC,ay)bw(W,ai,ac,q)bx(Z,be)end
for a=1,4 do
for f=1,4 do
aJ((a-1)*4+f,be[a][f])end
end
end
end
