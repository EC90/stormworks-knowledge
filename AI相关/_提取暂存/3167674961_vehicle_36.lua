-- source: steam id 3167674961 / vehicle.xml block#36
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
-- Author: Anonymous Sandwich / Klara
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 2087 (2447 with comment) chars

X=true
P=property
ab=input
m=math
Y=output
q=Y.setNumber
J=Y.setBool
k=m.pi
aa=m.abs
S=ab.getBool
p=m.atan
e=m.sin
f=m.cos
h=ab.getNumber
n=P.getNumber
C=m.sqrt
U=m.max
V=m.min
function y(N,K,O)return V(U(N,K),O)end
function j(b,c,d)return{b=b or 0,c=c or 0,d=d or 0}end
function ap(_,g)return j(_.b+g.b,_.c+g.c,_.d+g.d)end
function aF(_,M)return j(_.b*M,_.c*M,_.d*M)end
function aP(_)return aF(_,-1)end
function aU(_,g)return ap(_,aP(g))end
function aT(_)return C(_.b*_.b+_.c*_.c+_.d*_.d)end
function aL(_,g)return j(_.c*g.d-_.d*g.c,_.d*g.b-_.b*g.d,_.b*g.c-_.c*g.b)end
w=0
aC=n("Distance To Dive")B=-n("Cruise Sensitivity")an=-n("Terminal Sensitivity")G=n("Fire Delay (Ticks)")aJ=n("Vertical Trim On Launch")aS=n("Radar Dive Distance")ar=P.getBool("Helicopter Launch")z=n("Laser Sensitivity")aE=n("Distance To Dive (Laser)")E,af,r=j(),j(),j()L=0
function onTick()i=j(h(1),h(3),h(2))ad,ae,aj=h(4),h(5),h(6)l,x,o=f(ad),f(ae),f(aj)v,t,s=e(ad),e(ae),e(aj)aK=j(x*o,-t,x*s)aw=j(v*s+l*t*o,l*x,-v*o+l*t*s)aV=aL(aK,aw)am=x*o
Q=-l*s+v*t*o
aM=v*s+l*t*o
aA=x*s
aI=l*o+v*t*s
aD=-v*o+l*t*s
ax=-t
ak=v*x
aQ=l*x
ay=p(aA,C(am^2+ax^2))av=p(aI,C(Q^2+ak^2))as=p(aD,C(aM^2+aQ^2))a=-p(e(ay),-e(as))I=p(i.b-E.b,i.c-E.c)aB=p(Q,ak)aG=j(h(7),h(8),h(9))D=S(1)if D and not aq then
r=af
end
ac=L+200
if ar then
ac=y(L,100,300)end
at=aa(r.b)>1 or aa(r.c)>1
R=C((r.b-i.b)^2+(r.c-i.c)^2)T=(k+I-p(r.b-i.b,r.c-i.c))%(k*2)-k
au=av+p(i.d-r.d,R)az=(i.d-E.d)*60
ao=y((ac-i.d),-75,75)A=(az-ao)*.01
E=i
if R<aC and D and w>G then
J(1,X)H=au
u=an
else
J(1,false)H=A
u=B
end
aN=(f(a)*u*T)+(e(-a)*u*H)aH=(e(a)*u*T)+(f(a)*u*H)if D then
w=y(w+1,0,600)if w>G then
q(1,aN)q(2,aH)J(1,X)if not at then
q(1,(f(a)*u*((k+I-ah)%(k*2)-k))+(e(-a)*A*B))q(2,(e(a)*u*((k+I-ah)%(k*2)-k))+(f(a)*B*A))end
else
q(1,0)q(2,aJ)w=w+1
end
else
ah=aB
L=i.d
end
aO=S(2)al=h(11)ag=h(12)aR=h(10)F=f(a)*al+e(a)*ag
W=-e(a)*al+f(a)*ag
Z=(f(a)*F*z)+(e(-a)*(W)*z)ai=(e(a)*F*z)+(f(a)*(W)*z)if aR>aE then
Z=(f(a)*F*z)+(e(-a)*A*B)ai=(e(a)*z*F)+(f(a)*B*A)end
if aO and w>G then
q(1,y(Z,-4,4))q(2,y(ai,-4,4))end
aq=D
af=aG
end
function y(N,K,O)return V(U(N,K),O)end
