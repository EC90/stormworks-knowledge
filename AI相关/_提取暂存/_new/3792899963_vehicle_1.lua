-- source: steam id 3792899963 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792899963

m=255
an=pairs
aK=property
ay=output
aB=input
M=math
C=screen
at=string.format
aJ=C.drawText
D=M.floor
aq=C.setColor
k=C.drawLine
aE=M.tan
f=M.sin
j=M.cos
aD=M.sqrt
t=aB.getNumber
bc=aB.getBool
aZ=ay.setNumber
bd=ay.setBool
aF=aK.getNumber
av=aK.getBool
B={}H=M.pi*2
aT=(73/360)*H
aS=(58/360)*H
function aP(h,g,aQ,s,r,aU)return aD((h-s)^2+(g-r)^2+(aQ-aU)^2)end
function aw(aa,X,Y,af,aj,am,o,q,n)local N,G,I,K,J,L,F,l,e,w,al,ag,a,Q,b,ae
aa=aa-af
X=X-am
Y=Y-aj
N=j(n)*j(q)G=j(n)*f(q)*f(o)-f(n)*j(o)I=j(n)*f(q)*j(o)+f(n)*f(o)K=aa
J=f(n)*j(q)L=f(n)*f(q)*f(o)+j(n)*j(o)F=f(n)*f(q)*j(o)-j(n)*f(o)l=Y
e=-f(q)w=j(q)*f(o)al=j(q)*j(o)ag=X
ae=((N*L-G*J)*al+(I*J-N*F)*w+(G*F-I*L)*e)a=0
b=0
Q=0
if ae~=0 then
a=((G*F-I*L)*ag+(K*L-G*l)*al+(I*l-K*F)*w)/ae
b=-((N*F-I*J)*ag+(K*J-N*l)*al+(I*l-K*F)*e)/ae
Q=((N*L-G*J)*ag+(K*J-N*l)*w+(G*l-K*L)*e)/ae
end
return a,Q,b
end
function aY(T,E,S)local ac,W,ab
ac=A/2+(T/E)*(A/2)/aE(aT/2)W=l/2-(S/E)*(l/2)/aE(aS/2)ab=E>0
return ac,W,ab
end
function aN(aa,X,Y,o,q,n)local T,E,S,ac,W,ab
T,E,S=aw(aa,X,Y,af,aj,am,o,q,n)T,E,S=aw(T,E,S,0,0,0,-aR,ba,0)ac,W,ab=aY(T,E,S)return ac,W,ab
end
function be(a,b)return a>=0 and a<=A and b>=0 and b<=l
end
function aO(d,c,x,O,p,Z,z)local y,aG,ax,aC,aM,R
function y(h,g,s,r)local U,P,len,u,aL,aH,aA,as
U,P=s-h,r-g
len=aD(U^2+P^2)U,P=U/len,P/len
u=1
for e=0,len,u*2 do
aL,aH=h+U*e,g+P*e
aA,as=h+U*(e+u),g+P*(e+u)if e+u<len then
k(aL,aH,aA,as)end
end
end
function aG(a,b,A,l)y(a,b,a,b+l+2)y(a,b,a+A+2,b)y(a+A,b+l,a,b+l)y(a+A,b+l,a+A,b)end
function ax(h,g,s,r,aI,az)y(h,g,s,r)y(s,r,aI,az)y(aI,az,h,g)end
function aC(a,b,_)local ao=M.atan(1,_)for e=0,H,ao*2 do
local h,g,s,r
h=a+_*j(e)g=b+_*f(e)s=a+_*j(e+ao)r=b+_*f(e+ao)k(h,g,s,r)end
end
function aM(a,b,_)local u=10/360*H
for e=0,H-u,u do
local h,g,s,r
h=a+_*j(e)g=b+_*f(e)s=a+_*j(e+u)r=b+_*f(e+u)k(h,g,s,r)end
end
R=function(a,b,_,ak)drawLine=ak and y or k
drawRect=ak and aG or C.drawRect
drawTriangle=ak and ax or C.drawTriangle
drawCircle=ak and aC or C.drawCircle
if x==0 then
drawRect(a-_,b-_,_*2,_*2)elseif x<=2 then
drawLine(a-_,b,a,b+_)drawLine(a,b+_,a+_,b)drawLine(a+_,b,a,b-_)drawLine(a,b-_,a-_,b)if x==2 then
_=(_==3)and(_+1)or _
drawRect(a-_,b-_,_*2,_*2)end
elseif x==3 then
drawTriangle(d,c-_,d+_/2*3^.5,c+_/2,d-_/2*3^.5,c+_/2)elseif x==4 then
drawCircle(d,c,_)elseif x==5 then
if _==3 then
drawLine(a-_,b-_,a-_,b-_+1)drawLine(a-_,b+_,a-_,b+_+1)drawLine(a+_,b-_,a+_,b-_+1)drawLine(a+_,b+_,a+_,b+_+1)else
drawLine(a-_,b-_,a-_/2,b-_)drawLine(a-_,b-_,a-_,b-_/2)drawLine(a-_,b+_,a-_/2,b+_)drawLine(a-_,b+_,a-_,b+_/2)drawLine(a+_,b-_,a+_/2,b-_)drawLine(a+_,b-_,a+_,b-_/2)drawLine(a+_,b+_,a+_/2,b+_)drawLine(a+_,b+_,a+_,b+_/2)end
elseif x==6 then
if _==3 then
drawLine(a-_,b,a-_,b+1)drawLine(a,b+_,a,b+_+1)drawLine(a+_,b,a+_,b+1)drawLine(a,b-_,a,b-_+1)else
drawLine(a-_,b,a-_/2,b+_/2)drawLine(a-_,b,a-_/2,b-_/2)drawLine(a,b+_,a+_/2,b+_/2)drawLine(a,b+_,a-_/2,b+_/2)drawLine(a+_,b,a+_/2,b+_/2)drawLine(a+_,b,a+_/2,b-_/2)drawLine(a,b-_,a+_/2,b-_/2)drawLine(a,b-_,a-_/2,b-_/2)end
end
end
ah=function()if p==1 then
R(d,c,3,p==2)elseif p==3 then
k(d-1,c,d+2,c)k(d,c-1,d,c+2)elseif p==4 then
k(d+4,c,d-5,c)k(d,c+4,d,c-5)elseif p==5 then
k(d-4,c-4,d+5,c+5)k(d+4,c-4,d-5,c+5)elseif p==6 then
k(d+4,c,d+1,c)k(d-4,c,d-1,c)k(d,c+4,d,c+1)k(d,c-4,d,c-1)elseif p==7 then
k(d-4,c-4,d-1,c-1)k(d+4,c+4,d+1,c+1)k(d+4,c-4,d+1,c-1)k(d-4,c+4,d-1,c+1)end
end
ai={{0,m,0},{16,16,m},{m,0,0},{m,m,0},{0,m,m},{m,0,m},{0,m,0},{0,m,0},{0,m,0},{m,m,m}}if ai[O+1]then
aq(ai[O+1][1],ai[O+1][2],ai[O+1][3])else
aq(0,m,0)end
if Z==1 then
if z%12>=6 then
R(d,c,4,p==2)ah()end
elseif Z==2 then
if z%30>=15 then
R(d,c,4,p==2)ah()end
elseif Z==3 then
aq(127*f(z/30)+128,127*j(z/30)+128,127*f(z/15)+128)R(d,c,4,p==2)ah()else
R(d,c,4,p==2)ah()end
end
function onTick()af=t(27)aj=t(28)am=t(29)o=t(30)q=t(31)n=t(32)ba=t(9)*H
aR=t(10)*H
bb=aF("Radar delete tick")b_=aF("Distance Units")aX=av("radar ID")aV=av("radar distance")for v,i in an(B)do
i.z=i.z+1
i.V=i.V+1
if i.V>60^3*10 then
i.V=0
end
end
for e=0,5 do
w=e>1 and 2 or 0
local ad=t(e*4+4+w)v=ad%1000
if v~=0 then
B[v]={a=t(e*4+1+w),b=t(e*4+2+w),Q=t(e*4+3+w),z=0,x=D(ad/(10^3))%10,O=D(ad/(10^4))%10,p=D(ad/(10^5))%10,Z=D(ad/(10^6))%10,V=(B[v]and B[v].V)or 0}end
end
for v,i in an(B)do
if i.z>bb then
B[v]=nil
end
end
aZ(30,#B)end
function onDraw()A=C.getWidth()l=C.getHeight()for v,i in an(B)do
h,g,aW=aN(i.a,i.b,i.Q,o,q,n)h=D(h)g=D(g)if aW then
aO(h,g,i.x,i.O,i.p,i.Z,i.V)if aX then
au=tostring(v)aJ(h+1-2.5*#au,g-10,au)end
if aV then
ap=aP(af,am,aj,i.a,i.b,i.Q)*b_
if ap>=10 then
ar=at("%.0f",D(ap+.5))else
ar=at("%.1f",D(ap*10+.5)/10)end
aJ(h+1-2.5*#ar,g+6,ar)end
end
end
end
