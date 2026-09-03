-- source: steam id 3167674961 / vehicle.xml block#106
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
-- Author: Anonymous Sandwich / Klara
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 2183 (2543 with comment) chars

af=property
ah=input
q=math
ad=output
y=ad.setNumber
M=ad.setBool
l=q.pi
X=q.abs
j=q.atan
k=q.sin
w=q.cos
e=ah.getNumber
A=af.getNumber
C=q.sqrt
function h(c,b,a)return{c=c or 0,b=b or 0,a=a or 0}end
function I(_,f)return h(_.c+f.c,_.b+f.b,_.a+f.a)end
function L(_,Q)return h(_.c*Q,_.b*Q,_.a*Q)end
function ay(_)return L(_,-1)end
function aT(_,f)return I(_,ay(f))end
function aM(_)return C(_.c*_.c+_.b*_.b+_.a*_.a)end
function aU(_,f)return h(_.b*f.a-_.a*f.b,_.a*f.c-_.c*f.a,_.c*f.b-_.b*f.c)end
F=0
T=A("Distance To Dive")as=-A("Cruise Sensitivity")aj=-A("Terminal Sensitivity")aG=A("Fire Delay (Ticks)")aH=A("Vertical Trim On Launch")aB=af.getBool("Terminal Type")aY=0
aX=0
bc=0
R=0
P=0
z,Y,i=h(),h(),h()O=0
B=0
G=0
function onTick()d=h(e(1),e(3),e(2))aZ=e(4)ba=e(5)bb=e(6)ab,ag,Z=e(4),e(5),e(6)o,u,r=w(ab),w(ag),w(Z)t,n,p=k(ab),k(ag),k(Z)aK=h(u*r,-n,u*p)ak=h(t*p+o*n*r,o*u,-t*r+o*n*p)aE=aU(aK,ak)aD=u*r
ac=-o*p+t*n*r
ap=t*p+o*n*r
aq=u*p
aW=o*r+t*n*p
am=-t*r+o*n*p
an=-n
al=t*u
aI=o*u
aR=j(aq,C(aD^2+an^2))D=j(aW,C(ac^2+al^2))ao=j(am,C(ap^2+aI^2))m=-j(k(aR),-k(ao))N=j(d.c-z.c,d.b-z.b)aJ=j(ac,al)aA=h(e(7),e(8),e(9))aa=e(11)av=aa<500
aQ=I(d,L(ak,aa))O=e(10)aP=O<500
S=I(d,L(aE,O))H=ah.getBool(1)if H and not aF then
i=Y
end
aN=X(i.c)>1 or X(i.b)>1
v=C((i.c-d.c)^2+(i.b-d.b)^2)ax=j(i.c-d.c,i.b-d.b)U=(l+N-ax)%(l*2)-l
aS=D+j(d.a-i.a,v)s=x(aQ.a+10,20,1000)if not av then s=20 end
B=x(B-.003,0,1.5)if aP then
B=1.4
G=S.a+25
if S.a>d.a+10 then G=S.a+50 end
end
if B==0 then
G=0
end
aV=x(G-s,0,1000)s=s+aV*x(B,0,1)if H and F<300 then
s=x(s,50,1000)end
ar=(d.a-z.a)*60
V=-50
if d.a>400 then
V=-100
end
au=x((s-d.a)*1,V,200)aO=(ar-au)*.02
b_=aM(aT(d,z))*60
z=d
if v>T then
M(1,false)E=aO
g=as
if v<T*1.75 then
ae=250
if aB then ae=3000 end
g=aj
E=D+j(d.a-(i.a+ae),v)end
else
M(1,true)E=aS
g=aj
end
J=(w(m)*g*U)+(k(-m)*g*E)K=(k(m)*g*U)+(w(m)*g*E)if H then
F=x(F+1,0,600)if F>aG then
y(1,J)y(2,K)if not aN then
J=(w(m)*g*((l+N-R)%(l*2)-l))+(k(-m)*g*(D+P))K=(k(m)*g*((l+N-R)%(l*2)-l))+(w(m)*g*(D+P))y(1,J)y(2,K)v=0
end
ai=v<3000
W=v<1000
M(2,(ai and not aL)or(W and not at))aL,at=ai,W
else
y(1,0)y(2,aH)end
else
R=aJ
P=D
end
aF=H
Y=aA
end
function x(az,aC,aw)return q.min(q.max(az,aC),aw)end
