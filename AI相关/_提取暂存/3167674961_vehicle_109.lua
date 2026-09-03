-- source: steam id 3167674961 / vehicle.xml block#109
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
-- Author: Anonymous Sandwich / Klara
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1659 (2019 with comment) chars

H=true
K=input
p=math
N=output
w=N.setNumber
C=N.setBool
i=p.pi
L=p.abs
r=p.atan
g=p.sin
t=p.cos
j=K.getNumber
v=property.getNumber
x=p.sqrt
function f(b,a,c)return{b=b or 0,a=a or 0,c=c or 0}end
function aw(_,d)return f(_.b+d.b,_.a+d.a,_.c+d.c)end
function ah(_,G)return f(_.b*G,_.a*G,_.c*G)end
function ab(_)return ah(_,-1)end
function aF(_,d)return aw(_,ab(d))end
function aG(_)return x(_.b*_.b+_.a*_.a+_.c*_.c)end
function aa(_,d)return f(_.a*d.c-_.c*d.a,_.c*d.b-_.b*d.c,_.b*d.a-_.a*d.b)end
y=0
ad=v("Distance To Dive")Z=v("Cruise Altitude")ar=-v("Cruise Sensitivity")ap=-v("Terminal Sensitivity")O=v("Fire Delay (Ticks)")am=v("Vertical Trim On Launch")B,T,k=f(),f(),f()function onTick()e=f(j(1),j(3),j(2))X,S,R=j(4),j(5),j(6)m,s,n=t(X),t(S),t(R)u,o,l=g(X),g(S),g(R)at=f(s*n,-o,s*l)ax=f(u*l+m*o*n,m*s,-u*n+m*o*l)aE=aa(at,ax)al=s*n
V=-m*l+u*o*n
aA=u*l+m*o*n
ac=s*l
Y=m*n+u*o*l
ag=-u*n+m*o*l
an=-o
U=u*s
ak=m*s
aq=r(ac,x(al^2+an^2))z=r(Y,x(V^2+U^2))aj=r(ag,x(aA^2+ak^2))q=-r(g(aq),-g(aj))E=r(e.b-B.b,e.a-B.a)ai=r(V,U)aB=f(j(7),j(8),j(9))A=K.getBool(1)if A and not af then
k=T
end
as=L(k.b)>1 or L(k.a)>1
D=x((k.b-e.b)^2+(k.a-e.a)^2)ae=r(k.b-e.b,k.a-e.a)Q=(i+E-ae)%(i*2)-i
ay=z+r(e.c-k.c,D)ao=(e.c-B.c)*60
av=W((Z-e.c),-250,250)aD=(ao-av)*.005
B=e
if D<ad and A and y>O then
C(1,H)F=ay
h=ap
else
C(1,false)F=aD
h=ar
end
I=(t(q)*h*Q)+(g(-q)*h*F)J=(g(q)*h*Q)+(t(q)*h*F)if A then
y=W(y+1,0,600)if y>O then
C(2,H)w(1,I)w(2,J)if not as then
C(1,H)I=(t(q)*h*((i+E-M)%(i*2)-i))+(g(-q)*h*(z+P))J=(g(q)*h*((i+E-M)%(i*2)-i))+(t(q)*h*(z+P))w(1,I)w(2,J)D=0
end
else
w(1,0)w(2,am)end
else
M=ai
P=-z
end
af=A
T=aB
end
function W(au,az,aC)return p.min(p.max(au,az),aC)end
