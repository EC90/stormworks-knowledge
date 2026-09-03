-- source: steam id 3167674961 / vehicle.xml block#143
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
-- Author: Anonymous Sandwich / Klara
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 2024 (2384 with comment) chars

X=true
V=property
ah=input
r=math
al=output
k=al.setNumber
I=al.setBool
l=r.pi
af=r.abs
Y=ah.getBool
m=r.atan
e=r.sin
i=r.cos
g=ah.getNumber
u=V.getNumber
z=r.sqrt
ak=r.max
W=r.min
function C(E,G,M)return W(ak(E,G),M)end
function j(a,b,c)return{a=a or 0,b=b or 0,c=c or 0}end
function aF(_,f)return j(_.a+f.a,_.b+f.b,_.c+f.c)end
function at(_,N)return j(_.a*N,_.b*N,_.c*N)end
function aE(_)return at(_,-1)end
function aS(_,f)return aF(_,aE(f))end
function aT(_)return z(_.a*_.a+_.b*_.b+_.c*_.c)end
function ap(_,f)return j(_.b*f.c-_.c*f.b,_.c*f.a-_.a*f.c,_.a*f.b-_.b*f.a)end
x=0
an=u("Distance To Dive")F=-u("Cruise Sensitivity")av=-u("Terminal Sensitivity")ae=u("Fire Delay (Ticks)")au=u("Vertical Trim On Launch")aq=u("Radar Dive Distance")T=V.getBool("Helicopter Launch")B=u("Radar Sensitivity")D,Z,p=j(),j(),j()H=0
function onTick()h=j(g(1),g(3),g(2))aa,U,O=g(4),g(5),g(6)n,w,s=i(aa),i(U),i(O)t,q,o=e(aa),e(U),e(O)am=j(w*s,-q,w*o)aI=j(t*o+n*q*s,n*w,-t*s+n*q*o)aV=ap(am,aI)ax=w*s
R=-n*o+t*q*s
ao=t*o+n*q*s
as=w*o
aM=n*s+t*q*o
ay=-t*s+n*q*o
aN=-q
P=t*w
aK=n*w
aL=m(as,z(ax^2+aN^2))aP=m(aM,z(R^2+P^2))aQ=m(ay,z(ao^2+aK^2))d=-m(e(aL),-e(aQ))K=m(h.a-D.a,h.b-D.b)aB=m(R,P)aJ=j(g(7),g(8),g(9))y=Y(1)if y and not S then
p=Z
end
ad=H+200
if T then
ad=C(H,100,300)end
aD=af(p.a)>1 or af(p.b)>1
ac=z((p.a-h.a)^2+(p.b-h.b)^2)ai=(l+K-m(p.a-h.a,p.b-h.b))%(l*2)-l
aw=aP+m(h.c-p.c,ac)az=(h.c-D.c)*60
aH=C((ad-h.c),-75,75)L=(az-aH)*.01
D=h
if ac<an and y and x>ae then
I(1,X)J=aw
v=av
else
I(1,false)J=L
v=F
end
aA=(i(d)*v*ai)+(e(-d)*v*J)aO=(e(d)*v*ai)+(i(d)*v*J)if y then
x=C(x+1,0,600)if x>ae then
k(1,aA)k(2,aO)I(1,X)if not aD then
k(1,(i(d)*v*((l+K-ag)%(l*2)-l))+(e(-d)*L*F))k(2,(e(d)*v*((l+K-ag)%(l*2)-l))+(i(d)*F*L))end
else
k(1,0)k(2,au)x=x+1
end
else
ag=aB
H=h.c
end
aR=Y(2)aj=g(10)ab=g(11)aC=g(12)Q=i(d)*aj+e(d)*ab
A=-e(d)*aj+i(d)*ab
if aq<aC and not T then
A=A+(.4/l/2)end
ar=(i(d)*Q*B)+(e(-d)*(A)*B)aG=(e(d)*Q*B)+(i(d)*(A)*B)if aR then
k(1,ar)k(2,aG)end
S=y
k(3,aU)k(4,aW)S=y
Z=aJ
end
function C(E,G,M)return W(ak(E,G),M)end
