-- source: steam id 3167674961 / vehicle.xml block#49
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
-- Author: Anonymous Sandwich / Klara
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1769 (2129 with comment) chars

E=true
M=input
r=math
Z=output
o=Z.setNumber
z=Z.setBool
g=r.pi
T=r.abs
N=M.getBool
p=r.atan
k=r.sin
v=r.cos
e=M.getNumber
u=property.getNumber
x=r.sqrt
function i(b,c,a)return{b=b or 0,c=c or 0,a=a or 0}end
function az(_,d)return i(_.b+d.b,_.c+d.c,_.a+d.a)end
function aB(_,H)return i(_.b*H,_.c*H,_.a*H)end
function al(_)return aB(_,-1)end
function aE(_,d)return az(_,al(d))end
function aG(_)return x(_.b*_.b+_.c*_.c+_.a*_.a)end
function at(_,d)return i(_.c*d.a-_.a*d.c,_.a*d.b-_.b*d.a,_.b*d.c-_.c*d.b)end
y=0
P=u("Distance To Dive")aq=u("Cruise Altitude")aj=-u("Cruise Sensitivity")am=-u("Terminal Sensitivity")I=u("Fire Delay (Ticks)")ak=u("Vertical Trim On Launch")ad=u("Cluster Release Altitude")B,aH,j=i(),i(),i()function onTick()f=i(e(1),e(3),e(2))R,Y,W=e(4),e(5),e(6)l,t,n=v(R),v(Y),v(W)w,s,q=k(R),k(Y),k(W)aD=i(t*n,-s,t*q)ar=i(w*q+l*s*n,l*t,-w*n+l*s*q)aF=at(aD,ar)aw=t*n
U=-l*q+w*s*n
ae=w*q+l*s*n
as=t*q
ap=l*n+w*s*q
av=-w*n+l*s*q
an=-s
S=w*t
aC=l*t
ac=p(as,x(aw^2+an^2))C=p(ap,x(U^2+S^2))ai=p(av,x(ae^2+aC^2))m=-p(k(ac),-k(ai))K=p(f.b-B.b,f.c-B.c)ah=p(U,S)j=i(e(7),e(8),e(9))J=N(1)O=T(j.b)>1 or T(j.c)>1
A=x((j.b-f.b)^2+(j.c-f.c)^2)ay=p(j.b-f.b,j.c-f.c)V=(g+K-ay)%(g*2)-g
aA=C+p(f.a-j.a,A)aa=(f.a-B.a)*60
ab=L((aq-f.a)*1,-100,100)au=(aa-ab)*.02
B=f
if A<P and J and y>I then
z(1,E)D=aA
h=am
if f.a-j.a<ad and J and y>I then
ag=E
end
else
z(1,false)D=au
h=aj
end
F=(v(m)*h*V)+(k(-m)*h*D)G=(k(m)*h*V)+(v(m)*h*D)if J then
y=L(y+1,0,600)if y>I then
o(1,F)o(2,G)if not O then
z(1,E)h=h/2
F=(v(m)*h*((g+K-X)%(g*2)-g))+(k(-m)*h*(C+Q))G=(k(m)*h*((g+K-X)%(g*2)-g))+(v(m)*h*(C+Q))o(1,F)o(2,G)A=0
end
if N(2)and(A<P or not O)then
o(1,e(10))o(2,e(11))end
else
o(1,0)o(2,ak)end
else
X=ah
Q=L(-C,g/6,g/2)end
z(3,ag)end
function L(ax,ao,af)return r.min(r.max(ax,ao),af)end
