-- source: steam id 3524040776 / vehicle.xml block#43
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776

ai=table
aO=property
aP=string
aY=match
be=input
bf=output
bi=pi
bk=min
bl=max
bQ=tostring
cb=math
cc=screen
cf=tonumber
--yyy--
ca=be.getBool
f=be.getNumber
aN=bf.setNumber
bg=bf.setBool
W=aO.getNumber
n=aP.format
aQ=ai
aj=aQ.insert
k=cb
X=k.atan
bh=k.abs
function j(h)
return k.floor(h+0.5)
end
ak=k.floor
aR=k.sqrt
g=k.cos
e=k.sin
bi=k.pi
d=bi*2
function bj(h,bk,bl)
return k.max(bk,k.min(h,bl))
end
a4=165
u,v=32*8,32*6
bm,bn,bo,bp={},{},{},{}
aS=0
function a5(w,al,Y)
ai.insert(w,al)
local G=0
if#w>Y then
for a=1,#w-Y do
ai.remove(w,1)
end
end
for a=1,#w do
G=G+w[a]end
return G/#w 
end

function aT(am)
local h,m,B=am[1],am[2],am[3]return{{g(m)*g(B),g(h)*g(m)*e(B)+e(h)*e(m),e(h)*g(m)*e(B)-g(h)*e(m)},{-e(B),g(h)*g(B),e(h)*g(B)},{e(m)*g(B),g(h)*e(m)*e(B)-e(h)*g(m),e(h)*e(m)*e(B)+g(h)*g(m)}}
end

function aU(k,al)
local Y={}
for a=1,3 do
local x=0
for q=1,3 do
x=x+k[q][a]*al[q]end
Y[a]=x 
end
return Y 
end

function bq(br)
local aV={{},{},{}}
for C=1,3 do
for q=1,3 do
aV[C][q]=br[q][C]end
end
return aV 
end

function an(ao)
local D=aU(aT(ap),{ao[1]-y[1],ao[2]-y[2],ao[3]-y[3]})
return k.atan(D[1],D[2]),k.atan(D[3],D[2])
end

function K(bs,bt)
local aW,aX=bs-a6,bt-bu
return u/2+aW*a4/g(aW),v/2-aX*a4/g(aX)
end

function aq(ar,as)
return aR((ar[1]-as[1])^2+(ar[2]-as[2])^2+(ar[3]-as[3])^2)
end

function bv(at,au)at,au=at%1,au%1
local L=at-au
if L>0.5 then
L=L-1 
elseif L<-0.5 then
L=L+1 
end
return L 
end
M={}
R={}
Z=1
function av(N,aw,o,bw,r)
if N~=0 then
if#r>0 then
Z=bw
aY=0
for a=1,#r do
if r[a][4]==Z then
r[a]={N,aw,o,Z,0}
aY=1
break 
end
end
if aY==0 then
aj(r,{N,aw,o,Z,0})
end
else aj(r,{N,aw,o,Z,0})
end
end
end

function aZ(r,bx)if#r>0 then
for a=1,#r do
r[a][5]=r[a][5]+1
if r[a][5]>bx then
aQ.remove(r,a)
break 
end
end
end
end
ax=true
ay=180
E={}
for a=1,ay do
E[a]=nil 
end
by=1000
F=0
az=1
bz=0.02
function a_(bA,bB)
return aU(bq(aT(bA)),bB)
end

function b0(bC,bD)
local bE=k.atan(bC,bD)
local bF=bE/d
return(bF%1+1)%1 
end
a7={0}
function onTick()
bg(1,ax)
ax=true
y={f(1),f(3),f(2)}
ap={f(4),f(6),f(5)}
a6=f(19)*d
bu=f(20)*d
bG=f(18)
z=a5(bm,f(2),30)
b1=(z-aS)*60
aS=z
C,l,o=f(15),-f(16),-f(17)
if o<0 then
o=1+o 
end
a8=a5(bn,f(7),15)
aA=a5(bo,f(8),15)
O=a5(bp,k.max(f(9),0),15)
_=aq({a8,aA,O},{0,0,0})*1.944
if O>W('Vector Ball Draw Speed')then
b2=aR(X(a8,O)^2+X(aA,O)^2)*180/d else b2=0
end
P,Q=K(0,0)P,Q=j(P),j(Q)
F=F+az*bz
if F>1.0 then
F=1.0
az=-1 
elseif F<-1.0 then
F=-1.0
az=1
end
aN(1,F)
aN(2,-0.01+F*e(l*d))
s=f(21)
aj(a7,F)if#a7>5 then
ai.remove(a7,1)
end
local a9=a7[1]*0.125*d
if not(s>0 and s<by)then
local bH=1*e(a9)
local bI=1*g(a9)
local b3=a_(ap,{bH,bI,0})
local bJ=b0(b3[1],b3[2])
local bK=ak(bJ*360/2)%ay+1
E[bK]=nil else 
local bL=s*e(a9)
local bM=s*g(a9)
local b4=a_(ap,{bL,bM,0})
local bN=b0(b4[1],b4[2])
local bO=bN*360/2
local aB=ak(bO)%ay+1
if E[aB]==nil or s<E[aB]then
E[aB]=s 
end
end
aZ(M,120)
aZ(R,1200)
av(f(23),f(24),f(25),f(22)+0.1,M)
av(f(27),f(28),f(29),f(22)+ak(f(26)/1e5)/10,M)
av(f(30),f(31),f(32),f(22),R)
end
A=cc
H=A.setColor
function t(h)
if h==1 then
H(10,220,20)
elseif h==0 then
H(0,0,0)
end
end
cd=A.drawCircle
b5=A.drawLine
bP=A.drawText
ce=A.drawTextBox
S=A.drawRect
I=A.drawRectF
aC=A.drawTriangleF
function i(h,m,N,D)
A.drawLine(h,m,h+D*e(0.01*N*d),m-D*g(0.01*N*d))
end
b6={1121112,2212122,1222122,1221212,1222221,2222221,1121122,2222222,1222222}b6[0]=2122222
function p(h,m,G)h,m=j(h),j(m)
G=bQ(G)
local D=aP.len(G)
for a=1,D do
local w,u=G:sub(a,a),4
if w=='.'then
local u=2
end
local b7=cf(w)
if b7 then
local aa,T,aD,aE=h,m+4,0,0
for q=1,7 do
aa,T=aa+aD*2,T-aE*2
if q==5 then
T=T-2 
end
aD,aE=e(0.25*d*(q-1)),g(0.25*d*(q-1))
if aP.sub(bQ(b6[b7]),q,q)=='2'then
b5(aa,T,aa+aD*3,T-aE*3)
end
end
else A.drawText(h,m,w)
end
h=h+u 
end
end
bR=aO.getBool('Side Speed Indicator')
bS=aO.getBool('show both altitude')bT,bU=W('Pitch Indicator Max'),W('Pitch Indicator Min')
bV=W('Vector Ball Draw Speed')
cg={'a','b','c','d','e','f','g','h'}
function onDraw()
ax=false
H(66,6,6)
ab=20
aF=6
bW=j((o+a6/d+1)%1*180)
for a=-ab/2,ab/2 do
ac=(180+bW+a)%180
bX=(E[ac-1]==nil or a==-ab/2)and E[ac]if bX then
b8=a
end
b9=(E[ac+1]==nil or a==ab/2)and E[ac]if b9 then
bY=a
end
if b8 and b9 then
x=b8*2/360
aG,aH=K(x*d+a6,(-C-0.001)*d+x*d*e(l*d))
x=bY*2/360
aI,aJ=K(x*d+a6,(-C-0.001)*d+x*d*e(l*d))
aC(aG,aH,aI,aJ,aG,aH+aF)
aC(aI,aJ,aG,aH+aF,aI,aJ+aF)
end
end
if false then
for a=-10,10 do
for q=-10,10 do
ad={y[1]-y[1]%100+a*100,y[2]-y[2]%100+q*100,k.max(0,z-s)}
x=X(ad[1]-y[1],ad[2]-y[2])/d
ba=bv(x,o)
if ba>-0.15 and ba<0.15 then
aK,aL=K(an(ad))
if aK>0 and aK<u and aL>0 and aL<v then
bZ=aq(ad,y)
bb=bZ/1e3
if bb<1 then
H(22,222,22,(88-bb*88)*bj(s/25,0,1))
bP(aK-2,aL-2,'+')
end
end
end
end
end
end
t(1)
i(P+2,Q,25,2)
i(P-2,Q,75,2)
i(P,Q+2,50,2)
i(P,Q-2,0,2)
t(1)
J=10
b,c=15,v/2
for a=j(_)-9*J,j(_)+10*J do
if a>0 then
if a%10==0 then
i(b,c-3*(a-_)/J,25,3)
end
if a%50==0 then
p(b-12,c-3*(a-_)/J,n('%3.0f',a))
end
end
end
b,c=u-16,v/2
for a=j(z)-9*J,j(z)+10*J do
if a>W('Min Altitude')then
if a%10==0 then
i(b,c-3*(a-z)/J,75,3)
end
if a%50==0 then
p(b+2,c-3*(a-z)/J,n('%3.0f',a))
end
end
end
b,c=u/2,12
for a=j(o*360)-45,j(o*360)+45 do
if a<0 then
ae=360+a else ae=a
end
ae=ae%360
if a%5==0 then
i(b+1.6*(a-o*360),c,50,3)
end
if a%10==0 then
p(b+1.6*(a-o*360)-3,c-6,n('%02.0f',ae/10))
end
end
if bR then
b,c=u/2,v/2+48
for a=-2,2 do
af=(a*0.04+0.5)*d
b_=b+36*e(af)
c0=c-36*g(af)
c1=b+40*e(af)
c2=c-40*g(af)
b5(b_,c0,c1,c2)
end
U=(-a8/30*0.04+0.5)*d
c3=b+43*e(U)
c4=c-43*g(U)
c5=b+47*e(U+0.06*d)
c6=c-47*g(U+0.06*d)
c7=b+47*e(U-0.06*d)
c8=c-47*g(U-0.06*d)
aC(c3,c4,c5,c6,c7,c8)
end
b,c=P,Q
ag=32
for a=j(C*360)+bU,j(C*360)+bT do
if a<0 then
aM=0
else aM=50
end
ah=b+(a-C*360)*e(-l*d)*a4*d/360
V=c-(a-C*360)*g(-l*d)*a4*d/360
if V>15 and V<v-15 then
if a%10==0 and a~=0 and bh(a)<91 then
a0=ah+ag*e((0.75-l)*d)
a1=V-ag*g((0.75-l)*d)
a2=ah+ag*e((0.25-l)*d)
a3=V-ag*g((0.25-l)*d)
p(a0-14,a1-2,n('%3d',a))
p(a2+4,a3-2,n('%3d',a))
i(a0,a1,25-100*l,6)
i(a0,a1,aM-100*l,3)
i(a2,a3,75-100*l,6)
i(a2,a3,aM-100*l,3)
elseif a==0 then
a0=ah+5*e((0.75-l)*d)
a1=V-5*g((0.75-l)*d)
a2=ah+5*e((0.25-l)*d)
a3=V-5*g((0.25-l)*d)
i(a0,a1,75-100*l,32)
i(a2,a3,25-100*l,32)
end
end
end
c9=b2
if O>bV then
b,c=K(X(a8,O),X(aA,O))b,c=j(b),j(c)
i(b-1,c-2,25,3)
i(b-1,c+2,25,3)
i(b-2,c-1,50,3)
i(b+2,c-1,50,3)
i(b-3,c,75,2)
i(b+3,c,25,2)
end
b,c=4,4
i(b,c+2,50,2)
i(b+1,c+1,25,2)
i(b+1,c+4,25,2)
i(b+3,c+2,12,3)
i(b+3,c+3,37,3)
p(b+6,c,n('%.1f',c9))b,c=u-16,v/2+k.min(k.max(-b1,-30),30)
t(0)
I(b-19,c-1,17,7)
t(1)
p(b-18,c,n('%+3.0f',j(b1))..'>')b,c=21,v/2
t(1)
I(b,c,2,-bG*48)b,c=0,v/2-4
t(0)
I(b,c,21,11)
t(1)
S(b+1,c+1,18,8)
p(b+3,c+3,n('%4.0f',_))
if bS then
b,c=u-21,v/2-7
t(0)
I(b,c,21,17)
t(1)
S(b+1,c+1,18,14)
p(b+3,c+3,n('%4.0f',z))
p(b+3,c+9,n('%3.0f',s)..'R')else b,c=u-21,v/2-4
t(0)
I(b,c,21,11)
t(1)
S(b+1,c+1,18,8)
if s<z and s~=0 and s<999 then
bc=n('%3.0f',s)..'R'else bc=n('%4.0f',z)
end
p(b+3,c+3,bc)
end
b,c=u/2-9,1
t(0)
I(b,c,18,11)
t(1)
S(b+1,c+1,15,8)
p(b+3,c+3,n('%03.0f',o*360%360))if#M>0 then
for a=1,#M do
b,c=K(an(M[a]))b,c=j(b),j(c)
H(0,0,0)
I(b-2,c-2,4,4)
H(222,22,22)
S(b-2,c-2,4,4)
bd=n('%1.1f',aq(M[a],y)/1000)
p(b-j(bd:len()
*2),c-8,bd)
end
end
if#R>0 then
for a=1,#R do
b,c=K(an(R[a]))b,c=j(b),j(c)
H(0,0,0)
I(b-2,c-2,4,4)
H(22,99,222)
S(b-2,c-2,4,4)
p(b-3,c-8,n('%2.0f',R[a][4]))
end
end
end