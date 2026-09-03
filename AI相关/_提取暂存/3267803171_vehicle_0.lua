-- source: steam id 3267803171 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3267803171

aM=input
aN=output
b7=property
b8=math
bb=screen
bd=string
--yyy--
a=aM.getNumber
b5=aM.getBool
M=aN.setNumber
b6=aN.setBool
z=b7.getNumber
i=b8
A=i.atan
ap=i.abs
c=i.cos
B=i.floor
d=i.sin
aq=i.sqrt
b=i.pi*2
function G(u,p,N)
return i.max(i.min(N,u),p)
end

function ar(e)
local q,r,s=e[1],e[2],e[3]return{{c(r)*c(s),c(q)*c(r)*d(s)+d(q)*d(r),d(q)*c(r)*d(s)-c(q)*d(r)},{-d(s),c(q)*c(s),d(q)*c(s)},{d(r)*c(s),c(q)*d(r)*d(s)-d(q)*c(r),d(q)*d(r)*d(s)+c(q)*c(r)}}
end

function aO(i)
local f={{},{},{}}
for p=1,3 do
for j=1,3 do
f[p][j]=i[j][p]end
end
return f 
end

function as(i,u)
local f={}
for p=1,3 do
e=0
for j=1,3 do
e=e+i[j][p]*u[j]end
f[p]=e 
end
return f 
end

function aP(e)
return as(ar(at),{e[1],e[2],e[3]})
end

function aQ(X)
return A(X[1],X[2]),A(X[3],X[2])
end

function au(e)
return A(e[1],e[2])/b,A(e[3],aq(e[1]^2+e[2]^2))/b 
end

function Y(O,f)O,f=O%1,f%1
if O-f>0.5 then
f=f+1 
elseif O-f<-0.5 then
f=f-1 
end
return O-f 
end
P={}
a5={}
aR={}
function Q(t,u,Z,aS,p,aT,av,aw)
if not P[t]then
P[t]=0
a5[t]=0
aR[t]={}
end
P[t]=G(P[t]+p*(Z-u),-aw,aw)
local aU=G(aS*(Z-u),-av,av)+P[t]+aT*(Z-u-a5[t])a5[t]=Z-u
return aU 
end

function a6(N,a7)
return aq((N[1]-a7[1])^2+(N[2]-a7[2])^2+(N[3]-a7[3])^2)
end
H={rg=5e3,lf=1500,v0=800,dg=0.998,dw=0.001}
aV={0,0,-0.5}
_=0
b9=0
ba=0
I,J=0,0
l,g=0,0
m=0
a8=0
a9=false
aa=a9
ab=a9
aW=0
C=360
ax=z('pivot k')
n=0
function onTick()
ay=a9
o={a(1),a(3),a(2)}
at={a(4),a(6),a(5)}
R=as(aO(ar(at)),{a(7),a(9),a(8)})
az=z('accuracy k')
a0=z('breech dir')
aA=az*(B(a(12)/1e3)-5e2)/5e5
aB=-az*(a(12)%1e3-5e2)/5e5
v=aA*c(a0*0.25*b)+aB*d(a0*0.25*b)
S=-aA*d(a0*0.25*b)+aB*c(a0*0.25*b)
aC=a(13)>0
aX=a(15)
T=a(16)
D=a(17)
a1=a(18)
ac=-45.9/((a1*2.175-2.2)/b*C)
h={a(21),a(22),a(23)}
ad={a(30),a(31),a(32)}
ae=ad[1]~=0 and ad[2]~=0
if ae then
h=ad
end
aD=h[1]~=0 and h[2]~=0
a2=a(28)
af=B(a2/1e5)/50-1
ag=B(a2%1e5/1e3)/50-1
if a2%1e3>99 then
E=0.2/ac else E=1/ac 
end
ah=a2%10>0
if ah then
aE=-a(10)*4*ax
aF=-a(11)*0.05 else aE=0
aF=0
end
ai=a(27)
aG=c(ai*b)
aj=a(14)
if aG<-0.85 then
a3=z('ele back')/C 
elseif aG<-0.55 then
a3=z('ele side')/C else a3=z('-')/C 
end
if aC then
ak=z('+')/C else ak=8/C 
end
if aD then
n=a6(h,o)
aY=n<H.rg
if aY then
aH=a(19)
aI=a(20)
aZ={aI*d((aH-D)*b)-R[1],aI*c((aH-D)*b)-R[2],0}
a8=1.5+0.07*n+1E-05*n^2
m=-2E-05*n-4.2E-09*n^2
for w=1,3 do
k={h[1],h[2],h[3]}
al=k
n=a6(k,o)
F={a(1),a(3),a(2)}aJ,aK=au({k[1]-o[1],k[2]-o[2],k[3]-o[3]})
a_=H.v0*d(aK*b-m)
aL=H.v0*c(aK*b-m)
am={R[1]+aL*d(aJ*b),R[2]+aL*c(aJ*b),R[3]+a_}
for p=1,H.lf do
for j=1,3 do
F[j]=F[j]+am[j]/60
am[j]=am[j]*H.dg+aV[j]-aZ[j]*H.dw 
end
if a6(F,o)>n then
b0=A(F[3]-h[3],n)
m=m+b0
a8=p
k={k[1]+al[1]-F[1],k[2]+al[2]-F[2],k[3]+al[3]-F[3]}
break 
end
end
end
else m=0
a8=0
k={h[1],h[2],h[3]}
end
if ae then
I=I+af*E*0.0005
J=J+ag*E*0.0005
l,g=au({k[1]-o[1],k[2]-o[2],k[3]-o[3]})
an=Q(1,Y(-D,l+I+v)*b,0,4,0.1,16,0.2,0.1)
if aj>0 then
e=g+J-m/b+S else e=T
end
_=Q(2,T,e,0,0.2*a(13),0.2*a(13),0.5,0.25)b1,b2=aQ(aP({h[1]-o[1],h[2]-o[2],h[3]-o[3]}))
ao=b1/b*8
U=b2/b*8
ay=ap(Y(-D,l+I+v)*b)>A(2,n)or ap(T-(g+J-m/b+S))*b>A(2,n)
end
else I,J=0,0
if ah then
if not aa then
l=-D-v
g=T+m/b-S 
elseif ab then
l=-D-v
g=g
else l=l+af*E*0.002
g=g+ag*E*0.001 
end
an=Q(3,Y(-D,l+v)*b,0,4,0.005,6,0.5,0.1)
_=Q(4,T,g-m/b+S,0,0.2,0.2,0.5,0.25)
U=(g-aX)*8 else 
if aa or ab then
l=ai-v
g=U/8 else l=(l+af*E*0.002)*aj
g=G(g+ag*E*0.001,a3,ak)*aj 
end
an=Q(5,Y(ai,l+v)*b,0,4,0.005,6,0.5,0.1)
_=(g-m/b+S)*4
U=g*8 
end
ao=-v*8 
end
M(1,ao)
M(2,U)
M(3,an*ax+aE)
M(4,G(_+aF,a3*4,ak*4))b3,b4=G(B(500*ao+500.5),0,999),G(B(500*U+500.5),0,999)
M(5,b3*1000+b4)
aa=ah
ab=aD
aW=m
end
K=bb
V=K.setColor
W=K.drawTextBox
bc=K.drawText
a4=K.drawLine
function onDraw()
L=K.getWidth()
w=K.getHeight()
V(22,222,22)
a1=b*45.9/C/ac
x,y=B(L/2+0.5+w*I*b/a1),B(w/2+0.5-w*J*b/a1)
a4(x-2,y,x-4,y)
a4(x+2,y,x+4,y)
a4(x,y-2,x,y-4)
a4(x,y+2,x,y+4)
W(0,w-6,L,6,bd.format('%4.0f',n)..'m',0,0)
if ae then
V(222,22,22)
W(0,9,L,6,'GPS OVR',0,0)
V(22,222,22)
end
if aC then
if ay then
V(222,222,22)
W(0,w-13,L,6,'aiming',0,0)else W(0,w-13,L,6,'ready',0,0)
end
else V(222,22,22)
W(0,w-13,L,6,'loading',0,0)
end
end