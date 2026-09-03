-- source: steam id 3074335771 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3074335771
-- Author: Pufferfish
-- GitHub: None
-- Workshop: https://steamcommunity.com/profiles/76561198450931154/myworkshopfiles/?appid=573090
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 2756 (3132 with comment) chars

p=360
r=255
ai=table
H=pairs
ag=input
Z=false
an=property
b=math
t=screen
aa=t.drawLine
S=t.drawRectF
s=t.setColor
ae=b.sqrt
N=b.atan
ar=output.setNumber
ay=an.getNumber
aC=b.pi
e=b.sin
q=b.cos
ak=b.min
R=b.floor
function aD(X,ad)local X=R(X)local ad=R(ad)local al=b.random(0,10000)b.randomseed(al)local aT=P(al%r*(ad*2/r)+X,0,r)return aT
end
function z(aY)return P(R((((aY+(E and .5 or 0))%1+1.5)%1-.5)*(g)+((g)/2)),0,g)end
function P(i,min,max)return ak(b.max(min,i),max)end
function Y(T,o,J)if T>o then
return J>T or J<o
else
return J>T and J<o
end
end
function av(j,at,l,aH)local I=q(j)*as(l.o,l.U,l.ap)+e(j)*as(-l.U,l.o,l.ap)local aL=j*e(I)+at*q(I)-q(j)*l.U+e(j)*-l.o
local aN=j*q(I)-at*e(I)+aH
return aN,aL
end
pi=aC
c=aC*2
function as(aR,aI,aG)local Q=b.asin(e(aR))/e(pi/2-(aI))if aG<0 then
Q=pi-Q
end
return(Q+pi)%c-pi
end
bc={}C={{},{},{}}ac={1,3,30}w=12
g,d=1,0
L=1
aj=ay("Baffles (total deg stern)")aQ=ay("Noise to Contact ratio")or 2
aX=an.getBool("Noise Simulation")E=Z
v=Z
a=13
aw=ar
h=ag.getNumber
f=ag.getBool
M=1
bb=.1
function onTick()L=L+1
aA=f(14)if not aA then
return
end
aV=f(15)aS=f(16)E=f(17)aZ=f(18)aW=f(19)if aS then
v=Z
aK=a
a=a%(w+1)+1
while not f(a)do
a=a%(w+1)+1
if a==aK then
a=w+1
break
end
end
end
if aW then
M=M%#ac+1
end
if aZ and a~=w+1 then
v=not v
end
i=h(28)n=h(29)aq=h(30)K,B=q(n),e(n)x,D=q(aq),e(aq)A,y=q(i),e(i)ah=y*D+A*B*x
au=A*K
am={o=N(K*D,ae((K*x)^2+(-B)^2)),U=N(-y*x+A*B*D,ae(ah^2+au^2)),ap=N(A*x+y*B*D,ae((-A*D+y*B*x)^2+(y*K)^2))}aU=P(b.abs(h(32)),0,25)af=P(-h(27),-100,0)G=-N(ah,au)/c
u,F=h(a*2-1),h(a*2)u,F=av(u*c,F*c,am,-G*c)u,F=u/c,F/c
aM=f(a)aJ=(aU/50*r+(100+af)/400*r)-100
aE=40
ab=z(-G-(.5-aj/720))W=z(-G+(.5-aj/720))-1
for O,bd in H(C)do
aP=L%(20*ac[O])==0
if aV and aP then
local k={n=0,aO=E}for _=1,w do
if f(_)and af<0 then
local j,ba=av(h(_*2-1)*c,h(_*2)*c,am,-G*c)local az=z(j/c)if not Y(W,ab,az)then
k[az]=155
end
end
end
for _=0,g-1 do
if not Y(W,ab,_)and af<0 and aX then
local aB=aD(aJ,aE)if k[_]then
k[_]=(k[_]+aB*aQ)/3
else
k[_]=aB
end
elseif not k[_]and Y(W,ab,_)then
k[_]=1
end
end
ai.insert(C[O],k)for _,m in H(C[O])do
m.n=m.n+1
if m.n>90 then
ai.remove(C[O],_)end
end
end
if v then
aw(1,(u*p+p)%p)aw(2,F*p)end
end
ar(3,ac[M]*30)end
function onDraw()g,d=t.getWidth(),t.getHeight()if not aA then
return
end
for _,m in H(C[M])do
for ax,aF in H(m)do
if type(ax)=="number" then
local b_=(ax+(m.aO==E and 0 or g/2))%g
s(0,ak(aF,r),0)S(b_,m.n-1,1,1)end
end
end
s(5,5,5)S(0,d-6,g,13)s(15,15,15)aa(0,d-6,g,d-6)s(25,25,25)for _=-1,1 do
local ao=E and 180 or 0
local i=z((ao-1)/p+_/3)t.drawText(i-7,d-5,string.format("%03.0f",(ao+p+_*120)%p))aa(i,d-6,i,d-8)end
if a~=w+1 and aM then
if not v and L%60<=30 or v then
s(200,125,0)else
s(0,0,0,0)end
local V=z(u)aa(V,d-6,V,d-3)S(V-1,d-4,3,2)end
end
