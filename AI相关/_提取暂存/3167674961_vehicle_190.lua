-- source: steam id 3167674961 / vehicle.xml block#190
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
-- Author: Anonymous Sandwich
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1365 (1717 with comment) chars

U=input
e=math
V=output
h=V.setNumber
b=e.pi
T=e.abs
q=e.sqrt
d=e.atan
a=e.sin
g=e.cos
c=U.getNumber
_=property.getNumber
r=0
u=0
Z=0
A=0
at=_("Cruise Altitude")aC=_("Distance To Dive")az=-_("Cruise Sensitivity X")aj=-_("Cruise Sensitivity Y")an=-_("Terminal Sensitivity X")au=-_("Terminal Sensitivity Y")ap=_("Fire Delay (Ticks)")ay=_("Vertical Trim On Launch")as=_("Straight Pitch Trim")N=_("X to Y Ratio")ac=_("Horizontal Trim")aa=0
J=0
X=0
Q=false
F=0
D=0
function onTick()w=c(1)v=c(3)t=c(2)R=c(4)L=c(5)Y=c(6)n,j=g(R),a(R)s,i=g(L),a(L)m,o=g(Y),a(Y)I=s*m
z=-n*o+j*i*m
W=j*o+n*i*m
aA=s*o
ak=n*m+j*i*o
ag=-j*m+n*i*o
O=-i
G=j*s
P=n*s
av=d(aA,q(I*I+O*O))M=d(ak,q(z*z+G*G))S=d(ag,q(W*W+P*P))f=-d(a(av),a(-S))p=M
C=d(w-J,v-X)aD=d(a(M),a(-S))ai=d(z,G)ae=c(7)ax=c(8)ah=c(9)E=U.getBool(1)if E and not aq then
r=ae
u=ax
Z=ah
end
Q=T(r)>1 or T(u)>1
y=q((r-w)^2+(u-v)^2)aB=d(r-w,u-v)K=(b+C-aB)%(b*2)-b+ac
am=p+d(t-Z,y)ab=(t-aa)*60
aw=ao((at-t)*.25,-250,250)ar=(ab-aw)*.01
aa=t
J=w
X=v
if y>aC then
B=ar
l,k=az,aj
else
B=am
l,k=an,au
end
x=(g(f)*l*K)+(a(-f)*k*B)H=(a(f)*l*K)+(g(f)*k*B)if E then
if A>ap then
h(1,x)h(2,H*N)V.setBool(1,true)if not Q then
x=(g(f)*l*((b+C-F)%(b*2)-b))+(a(-f)*k*(p+D))H=(a(f)*l*((b+C-F)%(b*2)-b))+(g(f)*k*(p+D))h(1,x)h(2,H*N)y=0
end
else
h(1,0)h(2,ay)A=A+1
end
else
F=ai
D=p+as
end
aq=E
end
function ao(ad,al,af)return e.min(e.max(ad,al),af)end
