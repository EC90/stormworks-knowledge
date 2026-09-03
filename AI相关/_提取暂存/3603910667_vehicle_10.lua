-- source: steam id 3603910667 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667

at=input
au=output
aO=property
aP=math
aY=screen
aZ=string
--yyy--
a=at.getNumber
aM=at.getBool
u=au.setNumber
aN=au.setBool
A=aO.getNumber
d=aP
R=d.atan
aQ=d.abs
e=d.cos
p=d.floor
f=d.sin
ac=d.sqrt
q=d.pi*2
function v(r,m,D)
return d.max(d.min(D,r),m)
end

function ad(c)
local j,k,n=c[1],c[2],c[3]return{{e(k)*e(n),e(j)*e(k)*f(n)+f(j)*f(k),f(j)*e(k)*f(n)-e(j)*f(k)},{-f(n),e(j)*e(n),f(j)*e(n)},{f(k)*e(n),e(j)*f(k)*f(n)-f(j)*e(k),f(j)*f(k)*f(n)+e(j)*e(k)}}
end

function av(d)
local g={{},{},{}}
for m=1,3 do
for E=1,3 do
g[m][E]=d[E][m]end
end
return g 
end

function ae(d,r)
local g={}
for m=1,3 do
c=0
for E=1,3 do
c=c+d[E][m]*r[E]end
g[m]=c 
end
return g 
end

function aw(c)
return ae(ad(af),{c[1],c[2],c[3]})
end

function ax(S)
return R(S[1],S[2]),R(S[3],S[2])
end

function ay(c)
return R(c[1],c[2])/q,R(c[3],ac(c[1]^2+c[2]^2))/q 
end

function Y(F,g)F,g=F%1,g%1
if F-g>0.5 then
g=g+1 
elseif F-g<-0.5 then
g=g-1 
end
return F-g 
end
G={}
Z={}
az={}
function B(o,r,T,aA,m,aB,ag,ah,ai)
if not G[o]then
G[o]=0
Z[o]=0
az[o]={}
end
G[o]=v(G[o]+m*(T-r),-ah,ah)
local aC=v(aA*(T-r),-ag,ag)+G[o]+v(aB*(T-r-Z[o]),-ai,ai)Z[o]=T-r
return aC 
end

function aD(D,_)
return ac((D[1]-_[1])^2+(D[2]-_[2])^2+(D[3]-_[3])^2)
end
aR={rg=1,lf=600,v0=900,dg=0.995,dw=0.0005}
aS={0,0,-0.5}
H=0
aT=0
aU=0
I,J=0,0
i,b=0,0
aj=false
a0=aj
U=aj
a1=360
ak=A('pivot k')
aV=A('cam')
al=0
am=A('x limit')/a1
an=A('x limit')~=0
w=0
function onTick()
h=v((w-5)/10,0,1)
aE=a(19)<0.5
x={a(1),a(3),a(2)}
af={a(4),a(6),a(5)}
aW=ae(av(ad(af)),{a(7),a(9),a(8)})
aF=p(a(12)/1e6)
aG=aF>0
aH=a(15)
a2=a(16)
V=a(17)
ao=2^(a(14)%10)/4
l={a(21),a(22),a(23)}
aI={a(24),a(25),a(26)}
a3={a(30),a(31),a(32)}
a4=a3[1]~=0 and a3[2]~=0
if a4 then
l=a3
aI={0,0,0}
end
ap=l[1]~=0 and l[2]~=0
aq=ap
and aJ or a4
K=a(28)
a5=p(K/1e5)/50-1
a6=p(K%1e5/1e3)/50-1
if K%1e3>99 then
y=0.2/ao else y=1/ao 
end
aJ=K%100>9
a7=K%10>0
if a7 then
ar=-a(10)*4*ak
as=-a(11)*0.05 else ar=0
as=0
end
L=a(27)
aX=e(L*q)
a8=p(a(14)/10)
aK=A('-')/a1
aL=A('+')/a1
if ap then
al=aD(l,x)
a9={l[1],l[2],l[3]}
end
if aq and a8>0 then
if not U then
w=0
end
i,b=ay({a9[1]-x[1],a9[2]-x[2],a9[3]-x[3]})
I=I+a5*y*0.0005
J=J+a6*y*0.0005
z=B(1,Y(-V,i+I)*q,0,3*h,0.1*h,12*h,0.1,0.1,0.1)
H=B(2,a2,b+J,0,0.15*h,0,0,1,0.1)aa,M=ax(aw({l[1]-x[1],l[2]-x[2],l[3]-x[3]}))
ab=(aa/q+I)*8
W=(M/q+J)*8 else I,J=0,0
if a7 and a8>0 then
if not a0 then
w=0
i=-V
b=a2
elseif U then
w=0
i=-V
b=b
else i=i+a5*y*0.001
b=b+a6*y*0.0005 
end
z=B(1,Y(-V,i)*q,0,4*h,0.005*h,6*h,0.75,0.05,0.1)
H=B(2,a2,b,0,0.2*h,0.2*h,0,1,0.1)
W=(b-aH)*8 else 
if a8<1 then
i=0
b=0
elseif a0 or U then
w=0
i=L
b=W/8 else i=i+a5*y*0.001
b=b+a6*y*0.0005 
end
z=B(1,Y(L,i)*q,0,5*h,0.01*h,10*h,1,0.5,0.1)
H=B(2,b,b,0,0.2*h,0.2*h,0,1,0.1)
H=b*4
W=b*8 
end
ab=0
end
M=v(H+as,aK*4,aL*4)
u(1,ab)
if L>am and an then
z=d.min(z,0)
elseif L<-am and an then
z=d.max(z,0)
end
u(3,z*ak+ar)
u(4,M)aa,M=v(p(500*ab+500.5),0,999),v(p(500*W+500.5),0,999)
u(5,aa*1000+M)
a0=a7
U=aq
u(6,i)
u(7,b)
u(8,a(14))
w=w+1
end
N=aY
O=N.setColor
P=N.drawTextBox
X=N.drawLine
function onDraw()
C=N.getWidth()
Q=N.getHeight()
O(22,222,22)s,t=p(C/2+0.5),p(Q/2+0.5)
X(s-2,t,s-4,t)
X(s+2,t,s+4,t)
X(s,t-2,s,t-4)
X(s,t+2,s,t+4)
P(0,Q-6,C,6,aZ.format('%4.0f',al)..'m',0,0)
if a4 then
O(222,22,22)
P(0,9,C,6,'GPS OVR',0,0)
O(22,222,22)
end
if aG then
if aE then
O(222,222,22)
P(0,Q-13,C,6,'aiming',0,0)else P(0,Q-13,C,6,'ready',0,0)
end
else O(222,22,22)
P(0,Q-13,C,6,'loading',0,0)
end end