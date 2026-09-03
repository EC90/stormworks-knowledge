-- source: steam id 3603910667 / vehicle.xml block#15
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667

aH=input
aI=output
b1=property
b2=math
--yyy--
a=aH.getNumber
a_=aH.getBool
O=aI.setNumber
b0=aI.setBool
t=b1.getNumber
f=b2
w=f.atan
ab=f.abs
c=f.cos
D=f.floor
b=f.sin
ac=f.sqrt
d=f.pi*2
function E(u,k,F)
return f.max(f.min(F,u),k)
end

function ad(e)
local n,o,q=e[1],e[2],e[3]return{{c(o)*c(q),c(n)*c(o)*b(q)+b(n)*b(o),b(n)*c(o)*b(q)-c(n)*b(o)},{-b(q),c(n)*c(q),b(n)*c(q)},{b(o)*c(q),c(n)*b(o)*b(q)-b(n)*c(o),b(n)*b(o)*b(q)+c(n)*c(o)}}
end

function aJ(f)
local g={{},{},{}}
for k=1,3 do
for i=1,3 do
g[k][i]=f[i][k]end
end
return g 
end

function ae(f,u)
local g={}
for k=1,3 do
e=0
for i=1,3 do
e=e+f[i][k]*u[i]end
g[k]=e 
end
return g 
end

function b3(e)
return ae(ad(af),{e[1],e[2],e[3]})
end

function b4(P)
return w(P[1],P[2]),w(P[3],P[2])
end

function ag(e)
return w(e[1],e[2])/d,w(e[3],ac(e[1]^2+e[2]^2))/d 
end

function Q(G,g)G,g=G%1,g%1
if G-g>0.5 then
g=g+1 
elseif G-g<-0.5 then
g=g-1 
end
return G-g 
end
H={}
X={}
aK={}
function z(r,u,R,aL,k,aM,ah,ai,aj)
if not H[r]then
H[r]=0
X[r]=0
aK[r]={}
end
H[r]=E(H[r]+k*(R-u),-ai,ai)
local aN=E(aL*(R-u),-ah,ah)+H[r]+E(aM*(R-u-X[r]),-aj,aj)X[r]=R-u
return aN 
end

function Y(F,Z)
return ac((F[1]-Z[1])^2+(F[2]-Z[2])^2+(F[3]-Z[3])^2)
end
A={rg=2600,lf=600,v0=900,dg=0.995,dw=0.003}
aO={0,0,-0.5}
I=0
b5=0
b6=0
J,K=0,0
_,a0=0,0
p=0
B=0
a1=false
a2=a1
S=a1
a3=360
ak=t('pivot k')
aP=t('rst when rld')
l=0
al=t('x limit')/a3
am=t('x limit')~=0
C=0
function onTick()
h=E((C-5)/10,0,1)an,ao=a(13),a(29)
ap=a1
s={a(1),a(3),a(2)}
af={a(4),a(6),a(5)}
L=ae(aJ(ad(af)),{a(7),a(9),a(8)})
aq=t('acc k')
T=(t('breech dir')*0.25-a(18))*d
ar=a(12)%1e6
as=aq*(D(ar/1e3)-5e2)/5e5
at=-aq*(ar%1e3-5e2)/5e5
U=as*c(T)+at*b(T)
V=-as*b(T)+at*c(T)
au=D(a(12)/1e6)
b7=au>0
v=f.max(aP,au)
b8=a(15)
a4=a(16)
M=a(17)
av=2^(a(14)%10)/4
m={a(21),a(22),a(23)}
W={a(24),a(25),a(26)}
a5={a(30),a(31),a(32)}
aw=a5[1]~=0 and a5[2]~=0
if aw then
m=a5
W={0,0,0}
end
ax=m[1]~=0 and m[2]~=0
ay=ax
and aQ or aw
N=a(28)
aR=D(N/1e5)/50-1
aS=D(N%1e5/1e3)/50-1
if N%1e3>99 then
a6=0.2/av else a6=1/av 
end
aQ=N%100>9
a7=N%10>0
if a7 then
az=-a(10)*4*ak
aA=-a(11)*0.05 else az=0
aA=0
end
a8=a(27)
aB=D(a(14)/10)
aT=t('-')/a3
aU=t('+')/a3
if ax then
l=Y(m,s)
aV=l<A.rg
if aV then
aC=a(19)
aD=a(20)
aW={aD*b((aC-M)*d)-L[1],aD*c((aC-M)*d)-L[2],0}
B=1.5+0.07*l+1E-05*l^2
p=-2E-05*l-4.2E-09*l^2
for b9=1,3 do
j={m[1]+W[1]*B,m[2]+W[2]*B,m[3]+W[3]*B}
a9=j
l=Y(j,s)
x={a(1),a(3),a(2)}aE,aF=ag({j[1]-s[1],j[2]-s[2],j[3]-s[3]})
aX=A.v0*b(aF*d-p)
aG=A.v0*c(aF*d-p)
aa={L[1]+aG*b(aE*d),L[2]+aG*c(aE*d),L[3]+aX}
for k=1,A.lf do
for i=1,3 do
x[i]=x[i]+aa[i]/60
aa[i]=aa[i]*A.dg+aO[i]-aW[i]*A.dw 
end
if Y(x,s)>l then
aY=w(x[3]-m[3],l)
p=p+aY
B=k
j={j[1]+a9[1]-x[1],j[2]+a9[2]-x[2],j[3]+a9[3]-x[3]}
break 
end
end
end
else p=0
B=0
j={m[1],m[2],m[3]}
end
end
if ay and aB>0 then
if not S then
C=0
end
J=J+aR*a6*0.0005
K=K+aS*a6*0.0005
_,a0=ag({j[1]-s[1],j[2]-s[2],j[3]-s[3]})
y=z(1,Q(-M,_+J+U)*d,0,4*h,0.1*h,16*h,0.2,0.1,0.2)
I=z(2,a4,a0+K-p/d+V,0,0.2*v*h,0.2*v*h,0,1*v,0.1*v)
ap=ab(Q(-M,_+J+U)*d)>w(30,l)or ab(a4-(a0+K-p/d+V))*d>w(30,l)else J,K=0,0
if a7 and aB>0 then
if S or not a2 then
C=0
end
y=z(1,Q(-M,an+U)*d,0,4*h,0.005*h,6*h,0.75,0.05,0.2)
I=z(2,a4,ao-p/d+V,0,0.2*v*h,0.2*v*h,0,1*v,0.1*v)else 
if a2 or S then
C=0
end
y=z(1,Q(a8,an+U)*d,0,3*h,0.005*h,6*h,1,0.2,0.5)
I=z(2,0,0,0,0.2*h,0.2*h,0,1,0.1)
I=(ao-p/d+V)*4 
end
end
aZ=E(I+aA,aT*4,aU*4)
if a8>al and am then
y=f.min(y,0)
elseif a8<-al and am then
y=f.max(y,0)
end
O(3,y*ak+az)
O(4,aZ)
if ap then
O(5,0)else O(5,1)
end
a2=a7
S=ay
C=C+1 end