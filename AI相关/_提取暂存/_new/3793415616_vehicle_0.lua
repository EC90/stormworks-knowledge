-- source: steam id 3793415616 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793415616
cm="%03d"

N=.01
m=.5
H=360
U=true
l=false
bq=input
Q=math
u=screen
ba=u.setColor
P=Q.abs
w=u.drawText
ar=Q.floor
F=string.format
z=u.drawLine
c=bq.getNumber
Z=bq.getBool
d=Q.sin
f=Q.cos
aD=Q.pi
ck=aD
O=aD*2
bV=58
aj=10000
bv=5
bG=1
ch=1
cb=10
bP=1
bB=1
bu=0
bt=0
bS=0
bR=0
bF=255
by=60
aP=l
S=0
bl=0
bf=0
cc=0
bi=l
V=0
bo=0
aO=0
ca=0
aI=l
X=0
aV=0
bp=0
bC=0
aC=l
T=0
aS=0
bb=0
bw=0
at=0
aB=0
aJ=0
bg=0
bn=0
bj=0
aX=0
b_=0
aF=0
aZ=0
aW=0
au=l
be=0
bm=0
av=l
aR=0
aT=0
aw=l
aQ=0
aE=0
ax=l
function abs(j)if j<0 then
return-j
end
return j
end
function ae(j)while j<0 do
j=j+H
end
while j>=H do
j=j-H
end
return j
end
function cl(j,aL,aM)if j<aL then
return aL
end
if j>aM then
return aM
end
return j
end
function bK(aA,az,ap,bW,bX,bY,p,s,q)local L,G,D,B,I,J,y,_,K,aa,af,ad
local b,e,t
local W
aA=aA-bW
az=az-bY
ap=ap-bX
L=f(q)*f(s)G=f(q)*d(s)*d(p)-d(q)*f(p)D=f(q)*d(s)*f(p)+d(q)*d(p)B=aA
I=d(q)*f(s)J=d(q)*d(s)*d(p)+f(q)*f(p)y=d(q)*d(s)*f(p)-f(q)*d(p)_=ap
K=-d(s)aa=f(s)*d(p)af=f(s)*f(p)ad=az
W=((L*J-G*I)*af+(D*I-L*y)*aa+(G*y-D*J)*K)b=0
e=0
t=0
if W~=0 then
b=((G*y-D*J)*ad+(B*J-G*_)*af+(D*_-B*y)*aa)/W
e=-((L*y-D*I)*ad+(B*I-L*_)*af+(D*_-B*y)*K)/W
t=((L*J-G*I)*ad+(B*I-L*_)*aa+(G*_-B*J)*K)/W
end
return b,t,e
end
function bN(C,ao,ay)local aG=ao*O*bP
local aY=ay*O*bB
local bd=f(aY)local b=C*bd*d(aG)local e=C*bd*f(aG)local t=C*d(aY)return b,e,t
end
function ac(C,ao,ay)local b,e,t=bN(C,ao,ay)b=b-bu
e=e-bt
t=t-bS
local c_=at*O
local bx=-aB*O
local n,k,o=bK(b,e,t,0,0,0,bx,c_,0)return n,k,o
end
function ai(n,k,o,a,_)if k<=0 then
return 0,0,l
end
local bM=bV*ck/180
local bh=(_*m)/Q.tan(bM*m)local h=a*m+(n/k)*bh
local g=_*m-(o/k)*bh
return h,g,U
end
function bQ(a,_)au=l
if aP
and S>0
and S<=aj then
local n,k,o=ac(S,bl,bf)local h,g,A=ai(n,k,o,a,_)if A
and h>=0
and h<=a
and g>=0
and g<=_ then
aZ=h
aW=g
au=U
end
end
end
function br(a,_)av=l
if bi
and V>0
and V<=aj then
local n,k,o=ac(V,bo,aO)local h,g,A=ai(n,k,o,a,_)if A
and h>=0
and h<=a
and g>=0
and g<=_ then
be=h
bm=g
av=U
end
end
end
function bZ(a,_)aw=l
if aI
and X>0
and X<=aj then
local n,k,o=ac(X,aV,bp)local h,g,A=ai(n,k,o,a,_)if A
and h>=0
and h<=a
and g>=0
and g<=_ then
aR=h
aT=g
aw=U
end
end
end
function cj(a,_)ax=l
if aC
and T>0
and T<=aj then
local n,k,o=ac(T,aS,bb)local h,g,A=ai(n,k,o,a,_)if A
and h>=0
and h<=a
and g>=0
and g<=_ then
aQ=h
aE=g
ax=U
end
end
end
function onTick()aP=Z(1)S=c(1)bl=c(2)bf=c(3)cc=c(4)bi=Z(2)V=c(5)bo=c(6)aO=c(7)ca=c(8)aI=Z(3)X=c(9)aV=c(10)bp=c(11)bC=c(12)aC=Z(4)T=c(13)aS=c(14)bb=c(15)bw=c(16)at=c(17)aB=c(18)aJ=c(19)bg=c(20)bn=c(21)bj=c(22)aX=c(23)b_=c(24)aF=c(25)end
function bA(a,_)local i=a*m
local x=_*m
u.drawCircle(i,x,2)local aH=-b_*O*bG
local am=f(aH)local Y=d(aH)local ah=8
local ag=2
z(i-ah*am,x-ah*Y,i-ag*am,x-ag*Y)z(i+ag*am,x+ag*Y,i+ah*am,x+ah*Y)local bs=aX*O*ch
local bT=d(bs)*cb
local M=x+bT
if M>x-14
and M<x+14 then
local bk=5
z(i-bk,M,i-3,M)z(i+3,M,i+bk,M)end
end
function bE()return ae(-bj*H)end
function bU()local cg=bE()local bL=-at*H
return ae(cg+bL)end
function bz(a,_)local i=a*m
local aq=bU()local bO=F(cm,ar(aq+m))w(i-7,0,bO)w(i+9,0,"")local r=14
local bc=7
local aN=a-7
local bJ=12
local al=15
z(bc,r,aN,r)local bD=ar(aq/al+m)*al
local K
for K=-4,4 do
local v=ae(bD+K*al)local ab=ae(v-aq)if ab>180 then
ab=ab-H
end
local b=i+(ab/al)*bJ
if b>=bc
and b<=aN then
local aU=P(v%30)<N
if aU then
z(b,r-4,b,r+3)else
z(b,r-2,b,r+2)end
if aU then
local E
if P(v-0)<N
or P(v-H)<N then
E="N"
elseif P(v-90)<N then
E="E"
elseif P(v-180)<N then
E="S"
elseif P(v-270)<N then
E="W"
else
E=F(cm,ar(v+m))end
local an=#E*5
w(b-an*m,r+5,E)end
end
end
u.drawTriangleF(i,r-2,i-2,r-5,i+2,r-5)end
function ci(a,_)local b=a-52
local e=_-26
w(b,e,F("X %.0f",aJ))w(b,e+7,F("Y %.0f",bg))w(b,e+14,F("ALT %.0f",bn))end
function bH(a,_)local b=7
local e=_-12
local as=aF*3.6
if as<0 then
as=0
end
w(b,e,F("SPD %.0f",as))end
function ak(b,e,C)local R=bv
u.drawRect(b-R,e-R,R*2,R*2)local aK=F("%.0f",C)local an=#aK*5
w(b-an*m,e+R+2,aK)end
function cd()if au then
ak(aZ,aW,S)end
end
function ce()if av then
ak(be,bm,V)end
end
function bI()if aw then
ak(aR,aT,X)end
end
function cf()if ax then
ak(aQ,aE,T)end
end
function onDraw()local a=u.getWidth()local _=u.getHeight()ba(0,0,0)u.drawClear()ba(bR,bF,by)bQ(a,_)br(a,_)bZ(a,_)cj(a,_)bA(a,_)bz(a,_)ci(a,_)bH(a,_)cd()ce()bI()cf()end
