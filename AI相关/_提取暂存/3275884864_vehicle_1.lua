-- source: steam id 3275884864 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3275884864

am=math
aG=input
aH=output
b8=property
bc=screen
be=string
--yyy--
a=aG.getNumber
b7=aG.getBool
j=aH.setNumber
aI=aH.setBool
al=b8.getNumber
m=am
G=m.atan
b9=m.abs
f=m.cos
q=m.floor
e=m.sin
an=m.sqrt
d=m.pi*2
function w(aJ,aK,aL)
return am.max(am.min(aL,aJ),aK)
end

function a0(b)
local r,s,u=b[1],b[2],b[3]return{{f(s)*f(u),f(r)*f(s)*e(u)+e(r)*e(s),e(r)*f(s)*e(u)-f(r)*e(s)},{-e(u),f(r)*f(u),e(r)*f(u)},{e(s)*f(u),f(r)*e(s)*e(u)-e(r)*f(s),e(r)*e(s)*e(u)+f(r)*f(s)}}
end

function ao(m)
local g={{},{},{}}
for n=1,3 do
for k=1,3 do
g[n][k]=m[k][n]end
end
return g 
end

function ap(m,x)
local g={}
for n=1,3 do
b=0
for k=1,3 do
b=b+m[k][n]*x[k]end
g[n]=b 
end
return g 
end

function aM(aN,x)
b=0
for n=1,3 do
b=b+aN[n]*x[n]end
return b 
end

function aO(b)
return ap(a0(a1),{b[1],b[2],b[3]})
end

function a2(b)
return G(b[1],b[2])/d,G(b[3],an(b[1]^2+b[2]^2))/d 
end

function aP(b)
return G(b[1],b[2]),G(b[3],b[2])
end

function M(N,g)N,g=N%1,g%1
if N-g>0.5 then
g=g+1 
elseif N-g<-0.5 then
g=g-1 
end
return N-g 
end
O={}
a3={}
aQ={}
function P(v,x,V,aR,n,aS,aq,ar)
if not O[v]then
O[v]=0
a3[v]=0
aQ[v]={}
end
O[v]=w(O[v]+n*(V-x),-ar,ar)
local aT=w(aR*(V-x),-aq,aq)+O[v]+aS*(V-x-a3[v])a3[v]=V-x
return aT 
end

function a4(a5,a6)
return an((a5[1]-a6[1])^2+(a5[2]-a6[2])^2+(a5[3]-a6[3])^2)
end
H={{rg=2600,lf=600,v0=900,dg=0.995,dw=0.0005},{rg=1000,lf=120,v0=1600,dg=0.975,dw=0.0025}}
aU={0,0,-0.5}
Q=0
R,S=0,0
o,p=0,0
h=0
I=0
a7=false
a8=false
aV=0
function onTick()
B=0.5*(q(a(14)/1e3)-5e2)/5e5
y=-0.5*(a(14)%1e3-5e2)/5e5
i={a(1),a(3),a(2)}
a1={a(4),a(6),a(5)}
a9=ap(ao(a0(a1)),{a(7),a(9),a(8)})
aa=ao(a0(a1))
J=m.asin(aM(aa[2],{0,0,1}))/d
W=-G(aa[2][1],aa[2][2])/d
ab=a(15)
X=a(16)*d
as=a(17)
ac=2^q(a(18)/10)/4
aW={a(13),a(19),0}
if a(12)>9 then
c={a(31),a(32),a(20)}
C={0,0,0}
else c={a(21),a(22),a(23)}
C={a(24),a(25),a(26)}
end
Y=c[1]~=0 and c[2]~=0
T=a(28)
ad=q(T/100000)/50-1
ae=q(T%100000/1000)/50-1
if T%1000>99 then
D=0.2/ac else D=1/ac 
end
ba=T%100>9
af=T%10>0
K=a(12)%10
at=a(27)
bb=a(30)
ag=a(18)%10
if af then
au=-a(10)*1.6
av=-a(11)*0.05 else au=0
av=0
end
aw=al('-')/360
ax=al('+')/360
E=a(29)
if Y then
t=a4(c,i)
aX=t<H[E].rg
if aX then
I=1.5+0.07*t+1E-05*t^2
h=-2E-05*t-4.2E-09*t^2
for U=1,3 do
l={c[1]+C[1]*I,c[2]+C[2]*I,c[3]+C[3]*I}
ah=l
t=a4(l,i)
F={a(1),a(3),a(2)}ay,az=a2({l[1]-i[1],l[2]-i[2],l[3]-i[3]})
aY=H[E].v0*e(az*d-h)
aA=H[E].v0*f(az*d-h)
aZ=aA*e(ay*d)
a_=aA*f(ay*d)
ai={a9[1]+aZ,a9[2]+a_,a9[3]+aY}
for n=1,H[E].lf do
for k=1,3 do
F[k]=F[k]+ai[k]/60
ai[k]=ai[k]*H[E].dg+aU[k]-aW[k]*H[E].dw 
end
b0=a4(F,i)
if b0>t then
b1=G(F[3]-c[3],t)
h=h+b1
I=n
l={l[1]-(F[1]-ah[1]),l[2]-(F[2]-ah[2]),l[3]-(F[3]-ah[3])}
break 
end
end
end
else h=0
I=0
l={c[1],c[2],c[3]}
end
if Y then
R,S=R+ad*D*0.001,S+ae*D*0.001
o,p=a2({l[1]-i[1],l[2]-i[2],l[3]-i[3]})
aj=P(1,M(-W,o+R+B)*d,0,2,0.002,3,0.5,0.05)
if ag>0 then
b=p+S-h/d+y else b=J
end
Q=P(2,J,b,0,0.2,0.2,0.5,0.25)b2,b3=aP(aO({c[1]-i[1],c[2]-i[2],c[3]-i[3]}))
ak=b2/d*8
Z=b3/d*8 
end
else R,S=0,0
t=0
if af then
if not a7 then
o=-W-B
p=J+h/d-y 
elseif a8 then
o=-W-B
p=J+h/d-y else o=o+ad*D*0.002
p=p+ae*D*0.001 
end
aj=P(3,M(-W,o+B)*d,0,2,0.002,3,0.5,0.05)
Q=P(4,J,p-h/d+y,0,0.2,0.2,0.5,0.25)
Z=(h/d-y)*8 else 
if a7 or a8 then
o=at-B
p=J-ab+h/d-y else o=(o+ad*D*0.002)*ag
p=w(p+ae*D*0.001,aw,ax)*ag 
end
aj=P(5,M(at,o+B)*d,0,2,0.002,3,0.5,0.05)
Q=(p-h/d+y)*4
Z=(h/d-y)*8 
end
ak=-B*8 
end
j(1,ak)
j(2,Z)
j(3,aj+au)
j(4,w(Q+av,aw*4,ax*4))
if Y then
aB,aC=a2({c[1]-i[1],c[2]-i[2],c[3]-i[3]})
aD=w(q(500*8*(f(X)*M(aB,-as)+e(X)*(aC-ab))+500.5),0,999)
aE=w(q(500*8*(-e(X)*M(aB,-as)+f(X)*(aC-ab))+500.5),0,999)else aD=w(q(500*ak+500.5),0,999)
aE=w(q(500*(Q*2+Z)+500.5),0,999)
end
j(5,aD*1000+aE)
j(11,c[1]*K)
j(12,c[2]*K)
j(13,c[3]*K)
j(14,C[1]*K)
j(15,C[2]*K)
j(16,C[3]*K)
j(21,c[1])
j(22,c[2])
j(23,c[3])
a7=af
a8=Y
aV=h
aI(13,E>1.5)
end
L=bc
b4=L.setColor
b5=L.drawText
bd=L.drawTextBox
_=L.drawLine
function onDraw()
b6=L.getWidth()
U=L.getHeight()
b4(22,222,22)
aF=45.9/360/ac
z,A=q(b6/2+0.5+U*R/aF),q(U/2+0.5-U*S/aF)
_(z-2,A,z-4,A)
_(z+2,A,z+4,A)
_(z,A-2,z,A-4)
_(z,A+2,z,A+4)
b5(19,U-6,be.format('%4.0f',t)..'m')end