-- source: steam id 3167674961 / vehicle.xml block#30
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
-- Author: Anonymous Sandwich
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1549 (1901 with comment) chars

P=true
D=false
U=input
f=math
L=output
T=L.setBool
h=L.setNumber
d=f.pi
S=f.abs
r=f.sqrt
c=f.atan
b=f.sin
g=f.cos
a=U.getNumber
ag=U.getBool
_=property.getNumber
s=0
w=0
A=0
x=0
ay=_("Cruise Altitude")aj=_("Distance To Dive")ao=-_("Cruise Sensitivity X")al=-_("Cruise Sensitivity Y")aA=-_("Terminal Sensitivity X")an=-_("Terminal Sensitivity Y")ah=_("Fire Delay (Ticks)")am=_("Vertical Trim On Launch")aH=_("Straight Pitch Trim")aa=_("X to Y Ratio")aE=_("Horizontal Trim")Q=_("Cluster Release Altitude")ai=0
ac=0
W=0
ad=D
C=0
E=0
K=D
ab=D
function onTick()k=ag(1)v=a(1)u=a(3)i=a(2)Y=a(4)N=a(5)V=a(6)o,q=g(Y),b(Y)y,n=g(N),b(N)l,p=g(V),b(V)O=y*l
H=-o*p+q*n*l
ae=q*p+o*n*l
ak=y*p
at=o*l+q*n*p
ar=-q*l+o*n*p
af=-n
I=q*y
R=o*y
aw=c(ak,r(O*O+af*af))Z=c(at,r(H*H+I*I))M=c(ar,r(ae*ae+R*R))e=-c(b(aw),b(-M))t=Z
J=c(v-ac,u-W)aL=c(b(Z),b(-M))aF=c(H,I)aI=a(7)aJ=a(8)aB=a(9)aq=ag(2)ap=a(10)if k and not ab then
s=aI
w=aJ
A=aB
end
ad=S(s)>1 or S(w)>1
B=r((s-v)^2+(w-u)^2)aD=c(s-v,w-u)X=(d+J-aD)%(d*2)-d+aE
aC=t+c(i-A,B)ax=(i-ai)*60
as=au((ay-i)*.25,-180,180)aG=(ax-as)*.01
ai=i
ac=v
W=u
if B>aj then
F=aG
m,j=ao,al
else
F=aC
m,j=aA,an
if i-A<Q and k and x>ah then
K=P
end
end
G=(g(e)*m*X)+(b(-e)*j*F)z=(b(e)*m*X)+(g(e)*j*F)if k then
if x>ah then
h(1,G)h(2,z*aa)if not ad then
G=(g(e)*m*((d+J-C)%(d*2)-d))+(b(-e)*j*(t+E))z=(b(e)*m*((d+J-C)%(d*2)-d))+(g(e)*j*(t+E))h(1,G)h(2,z*aa)B=0
end
if aq then
if ap<Q then
K=P
end
end
else
h(1,0)h(2,am)x=x+1
end
else
C=aF
E=t+aH
end
aM=a(10)aN=a(11)T(1,K)T(2,k)ab=k
end
function au(az,aK,av)return f.min(f.max(az,aK),av)end
