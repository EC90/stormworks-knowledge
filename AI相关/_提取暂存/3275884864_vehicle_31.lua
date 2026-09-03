-- source: steam id 3275884864 / vehicle.xml block#31
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3275884864

aK=input
aL=output
b7=property
b8=math
bb=screen
bd=string
--yyy--
a=aK.getNumber
b6=aK.getBool
z=aL.setNumber
ar=aL.setBool
a4=b7.getNumber
i=b8
A=i.atan
a5=i.abs
d=i.cos
B=i.floor
e=i.sin
as=i.sqrt
b=i.pi*2
function G(u,p,O)
return i.max(i.min(O,u),p)
end

function at(c)
local q,r,s=c[1],c[2],c[3]return{{d(r)*d(s),d(q)*d(r)*e(s)+e(q)*e(r),e(q)*d(r)*e(s)-d(q)*e(r)},{-e(s),d(q)*d(s),e(q)*d(s)},{e(r)*d(s),d(q)*e(r)*e(s)-e(q)*d(r),e(q)*e(r)*e(s)+d(q)*d(r)}}
end

function aM(i)
local f={{},{},{}}
for p=1,3 do
for j=1,3 do
f[p][j]=i[j][p]end
end
return f 
end

function au(i,u)
local f={}
for p=1,3 do
c=0
for j=1,3 do
c=c+i[j][p]*u[j]end
f[p]=c 
end
return f 
end

function aN(c)
return au(at(av),{c[1],c[2],c[3]})
end

function aO(_)
return A(_[1],_[2]),A(_[3],_[2])
end

function aw(c)
return A(c[1],c[2])/b,A(c[3],as(c[1]^2+c[2]^2))/b 
end

function a0(P,f)P,f=P%1,f%1
if P-f>0.5 then
f=f+1 
elseif P-f<-0.5 then
f=f-1 
end
return P-f 
end
Q={}
a6={}
aP={}
function R(t,u,a1,aQ,p,aR,ax,ay)
if not Q[t]then
Q[t]=0
a6[t]=0
aP[t]={}
end
Q[t]=G(Q[t]+p*(a1-u),-ay,ay)
local aS=G(aQ*(a1-u),-ax,ax)+Q[t]+aR*(a1-u-a6[t])a6[t]=a1-u
return aS 
end

function a7(O,a8)
return as((O[1]-a8[1])^2+(O[2]-a8[2])^2+(O[3]-a8[3])^2)
end
H={{rg=5e3,lf=1500,v0=800,dg=0.998,dw=0.001},{rg=1200,lf=120,v0=1600,dg=0.975,dw=0.0025}}
aT={0,0,-0.5}
I=0
b9=0
az=0
J,K=0,0
l,g=0,0
m=0
L=0
a9=false
aa=a9
ab=a9
aU=0
S=360
n=0
function onTick()
aA=a9
o={a(1),a(3),a(2)}
av={a(4),a(6),a(5)}
T=au(aM(at(av)),{a(7),a(9),a(8)})
U=-0.25*(B(a(12)/1e3)-5e2)/5e5
v=-0.25*(a(12)%1e3-5e2)/5e5
aV=a(13)>0
aW=a(15)
V=a(16)
C=a(17)
a2=a(18)
ac=-45.9/((a2*2.175-2.2)/b*S)
aB=a(19)
aC=a(20)
ad={aC*e((aB-C)*b)-T[1],aC*d((aB-C)*b)-T[2],0}z(8,ad[1])
z(9,ad[2])
h={a(21),a(22),a(23)}
ae={a(24),a(25),a(26)}
af={a(30),a(31),a(32)}
ag=af[1]~=0 and af[2]~=0
if ag then
h=af
end
aD=h[1]~=0 and h[2]~=0
W=a(28)
D=a(29)
ah=B(W/1e5)/50-1
ai=B(W%1e5/1e3)/50-1
if W%1e3>99 then
E=0.2/ac else E=1/ac 
end
aX=W%100>9
aj=W%10>0
if aj then
aE=-a(10)*4
aF=-a(11)*0.05 else aE=0
aF=0
end
ak=a(27)
aY=d(ak*b)
al=a(14)
if aY<-0.85 then
am=-0.01 else am=a4('-')/S 
end
aG=a4('+')/S
ba=-a4('-')/S
if aD then
n=a7(h,o)
aZ=n<H[D].rg
if aZ then
L=1.5+0.07*n+1E-05*n^2
m=-2E-05*n-4.2E-09*n^2
for w=1,3 do
k={h[1]+ae[1]*L,h[2]+ae[2]*L,h[3]+ae[3]*L}
an=k
n=a7(k,o)
F={a(1),a(3),a(2)}aH,aI=aw({k[1]-o[1],k[2]-o[2],k[3]-o[3]})
a_=H[D].v0*e(aI*b-m)
aJ=H[D].v0*d(aI*b-m)
ao={T[1]+aJ*e(aH*b),T[2]+aJ*d(aH*b),T[3]+a_}
for p=1,H[D].lf do
for j=1,3 do
F[j]=F[j]+ao[j]/60
ao[j]=ao[j]*H[D].dg+aT[j]-ad[j]*H[D].dw 
end
if a7(F,o)>n then
b0=A(F[3]-h[3],n)
m=m+b0
L=p
k={k[1]+an[1]-F[1],k[2]+an[2]-F[2],k[3]+an[3]-F[3]}
break 
end
end
end
else m=0
L=0
k={h[1],h[2],h[3]}
end
if aX or ag then
J=J+ah*E*0.0005
K=K+ai*E*0.0005
l,g=aw({k[1]-o[1],k[2]-o[2],k[3]-o[3]})
ap=R(1,a0(-C,l+J+v)*b,0,5,0.05,4,0.25,0.05)
if al>0 then
c=g+K-m/b+U else c=V
end
I=R(2,V,c,0,0.2,0.2,0.5,0.25)b1,b2=aO(aN({h[1]-o[1],h[2]-o[2],h[3]-o[3]}))
aq=b1/b*8
X=b2/b*8
aA=a5(a0(-C,l+J+v)*b)>A(2,n)or a5(V-(g+K-m/b+U))*b>A(2,n)
end
else J,K=0,0
if aj then
if not aa then
l=-C-v
g=V+m/b-U 
elseif ab then
l=-C-v
g=g
else l=l+ah*E*0.002
g=g+ai*E*0.001 
end
ap=R(3,a0(-C,l+v)*b,0,4,0.005,6,0.5,0.1)
I=R(4,V,g-m/b+U,0,0.2,0.2,0.5,0.25)
X=(g-aW)*8 else 
if aa or ab then
l=ak-v
g=X/8 else l=(l+ah*E*0.002)*al
g=G(g+ai*E*0.001,am,aG)*al 
end
ap=R(5,a0(ak,l+v)*b,0,4,0.005,12,1,0.1)
I=(g-m/b+U)*4
X=g*8 
end
aq=-v*8 
end
z(1,aq)
z(2,X)
z(3,ap+aE)
z(4,G(I+aF,am*4,aG*4))
b3=a5(I-az)>0.001
az=I
ar(12,b3)b4,b5=G(B(500*aq+500.5),0,999),G(B(500*X+500.5),0,999)
z(5,b4*1000+b5)
aa=aj
ab=aD
aU=m
ar(13,D>1.5)
end
M=bb
Y=M.setColor
Z=M.drawTextBox
bc=M.drawText
a3=M.drawLine
function onDraw()
N=M.getWidth()
w=M.getHeight()
Y(22,222,22)
a2=b*45.9/S/ac
x,y=B(N/2+0.5+w*J*b/a2),B(w/2+0.5-w*K*b/a2)
a3(x-2,y,x-4,y)
a3(x+2,y,x+4,y)
a3(x,y-2,x,y-4)
a3(x,y+2,x,y+4)
Z(0,w-6,N,6,bd.format('%4.0f',n)..'m',0,0)
if ag then
Y(222,22,22)
Z(0,9,N,6,'CMD OVR',0,0)
Y(22,222,22)
end
if aV then
if aA then
Y(222,222,22)
Z(0,w-13,N,6,'aiming',0,0)else Z(0,w-13,N,6,'ready',0,0)
end
else Y(222,22,22)
Z(0,w-13,N,6,'loading',0,0)
end
end