-- source: steam id 3167674961 / vehicle.xml block#47
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
-- Author: Anonymous Sandwich / Klara
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 2000 (2360 with comment) chars

Q=true
Y=input
o=math
ac=output
t=ac.setNumber
B=ac.setBool
g=o.pi
E=o.abs
u=o.atan
e=o.sin
f=o.cos
k=Y.getNumber
r=property.getNumber
z=o.sqrt
function l(c,d,b)return{c=c or 0,d=d or 0,b=b or 0}end
function aH(_,h)return l(_.c+h.c,_.d+h.d,_.b+h.b)end
function aB(_,J)return l(_.c*J,_.d*J,_.b*J)end
function aJ(_)return aB(_,-1)end
function aN(_,h)return aH(_,aJ(h))end
function aO(_)return z(_.c*_.c+_.d*_.d+_.b*_.b)end
function an(_,h)return l(_.d*h.b-_.b*h.d,_.b*h.c-_.c*h.b,_.c*h.d-_.d*h.c)end
y=0
V=r("Distance To Dive")aE=r("Cruise Altitude")R=-r("Cruise Sensitivity")aK=-r("Terminal Sensitivity")F=r("Fire Delay (Ticks)")aA=r("Vertical Trim On Launch")x=r("Laser Sensitivity")ap=r("Cluster Release Altitude")D,aM,m=l(),l(),l()function onTick()i=l(k(1),k(3),k(2))X,Z,aa=k(4),k(5),k(6)n,v,q=f(X),f(Z),f(aa)w,p,s=e(X),e(Z),e(aa)au=l(v*q,-p,v*s)av=l(w*s+n*p*q,n*v,-w*q+n*p*s)aL=an(au,av)az=v*q
ab=-n*s+w*p*q
al=w*s+n*p*q
as=v*s
ax=n*q+w*p*s
ah=-w*q+n*p*s
am=-p
W=w*v
ay=n*v
aC=u(as,z(az^2+am^2))C=u(ax,z(ab^2+W^2))aw=u(ah,z(al^2+ay^2))a=-u(e(aC),-e(aw))S=u(i.c-D.c,i.d-D.d)ai=u(ab,W)m=l(k(7),k(8),k(9))L=Y.getBool(1)aq=E(m.c)>1 or E(m.d)>1
G=z((m.c-i.c)^2+(m.d-i.d)^2)aD=u(m.c-i.c,m.d-i.d)ae=(g+S-aD)%(g*2)-g
ak=C+u(i.b-m.b,G)aI=(i.b-D.b)*60
aG=A((aE-i.b)*1,-100,100)N=(aI-aG)*.02
D=i
if G<V and L and y>F then
B(1,Q)O=ak
j=aK
if i.b-m.b<ap and L and y>F then
ao=Q
end
else
B(1,false)O=N
j=R
end
K=(f(a)*j*ae)+(e(-a)*j*O)P=(e(a)*j*ae)+(f(a)*j*O)if L then
y=A(y+1,0,600)if y>F then
t(1,K)t(2,P)if not aq then
B(1,Q)j=j/2
K=(f(a)*j*((g+S-T)%(g*2)-g))+(e(-a)*j*(C+ag))P=(e(a)*j*((g+S-T)%(g*2)-g))+(f(a)*j*(C+ag))t(1,K)t(2,P)G=0
end
else
t(1,0)t(2,aA)end
else
T=ai
ag=A(-C,g/6,g/2)end
I=k(10)/(g*2)M=k(11)/(g*-2)aF=E(I)>0 or E(M)>0
H=f(a)*I+e(a)*M
ad=-e(a)*I+f(a)*M
U=(f(a)*H*x)+(e(-a)*(ad)*x)af=(e(a)*H*x)+(f(a)*(ad)*x)if G>V then
U=(f(a)*H*x)+(e(-a)*N*R)af=(e(a)*x*H)+(f(a)*R*N)end
if aF and y>F then
t(1,A(U,-4,4))t(2,A(af,-4,4))end
B(3,ao)end
function A(ar,at,aj)return o.min(o.max(ar,at),aj)end
