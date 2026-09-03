-- source: steam id 3167674961 / vehicle.xml block#35
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
-- Author: Anonymous Sandwich / Klara
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1976 (2336 with comment) chars

af=true
ae=property
ad=input
m=math
ag=output
r=ag.setNumber
N=ag.setBool
g=m.pi
C=m.abs
t=m.atan
e=m.sin
h=m.cos
f=ad.getNumber
w=ae.getNumber
y=m.sqrt
function l(b,c,d)return{b=b or 0,c=c or 0,d=d or 0}end
function aI(_,i)return l(_.b+i.b,_.c+i.c,_.d+i.d)end
function aF(_,G)return l(_.b*G,_.c*G,_.d*G)end
function ao(_)return aF(_,-1)end
function aR(_,i)return aI(_,ao(i))end
function aM(_)return y(_.b*_.b+_.c*_.c+_.d*_.d)end
function ap(_,i)return l(_.c*i.d-_.d*i.c,_.d*i.b-_.b*i.d,_.b*i.c-_.c*i.b)end
A=0
Z=w("Distance To Dive")au=w("Cruise Altitude")H=-w("Cruise Sensitivity")ak=-w("Terminal Sensitivity")Q=w("Fire Delay (Ticks)")aE=w("Vertical Trim On Launch")aK=ae.getBool("Terminal Type")x=w("Laser Sensitivity")B,aP,s=l(),l(),l()function onTick()k=l(f(1),f(3),f(2))aO=f(4)aN=f(5)aQ=f(6)W,Y,U=f(4),f(5),f(6)q,u,p=h(W),h(Y),h(U)v,n,o=e(W),e(Y),e(U)ax=l(u*p,-n,u*o)am=l(v*o+q*n*p,q*u,-v*p+q*n*o)aL=ap(ax,am)aG=u*p
ab=-q*o+v*n*p
al=v*o+q*n*p
ay=u*o
av=q*p+v*n*o
aw=-v*p+q*n*o
aC=-n
ac=v*u
aD=q*u
aA=t(ay,y(aG^2+aC^2))F=t(av,y(ab^2+ac^2))at=t(aw,y(al^2+aD^2))a=-t(e(aA),-e(at))J=t(k.b-B.b,k.c-B.c)aq=t(ab,ac)s=l(f(7),f(8),f(9))R=ad.getBool(1)aj=C(s.b)>1 or C(s.c)>1
D=y((s.b-k.b)^2+(s.c-k.c)^2)aH=t(s.b-k.b,s.c-k.c)V=(g+J-aH)%(g*2)-g
aB=F+t(k.d-s.d,D)an=(k.d-B.d)*60
az=z((au-k.d)*1,-100,100)L=(an-az)*.02
B=k
if D<Z and R and A>Q then
N(1,af)P=aB
j=ak
else
N(1,false)P=L
j=H
end
I=(h(a)*j*V)+(e(-a)*j*P)M=(e(a)*j*V)+(h(a)*j*P)if R then
A=z(A+1,0,600)if A>Q then
r(1,I)r(2,M)if not aj then
N(1,af)j=j/2
I=(h(a)*j*((g+J-S)%(g*2)-g))+(e(-a)*j*(F+T))M=(e(a)*j*((g+J-S)%(g*2)-g))+(h(a)*j*(F+T))r(1,I)r(2,M)D=0
end
else
r(1,0)r(2,aE)end
else
S=aq
T=z(-F,g/6,g/2)end
K=f(10)/(g*2)O=f(11)/(g*-2)as=C(K)>0 or C(O)>0
E=h(a)*K+e(a)*O
X=-e(a)*K+h(a)*O
aa=(h(a)*E*x)+(e(-a)*(X)*x)ah=(e(a)*E*x)+(h(a)*(X)*x)if D>Z then
aa=(h(a)*E*x)+(e(-a)*L*H)ah=(e(a)*x*E)+(h(a)*H*L)end
if as and A>Q then
r(1,z(aa,-4,4))r(2,z(ah,-4,4))end
end
function z(ar,aJ,ai)return m.min(m.max(ar,aJ),ai)end
