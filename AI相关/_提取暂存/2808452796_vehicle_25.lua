-- source: steam id 2808452796 / vehicle.xml block#25
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2808452796
-- Author: Anonymous Sandwich
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1595 (1947 with comment) chars

h=math
Y=input
R=output
g=R.setNumber
ab=Y.getBool
e=h.pi
L=h.abs
u=h.sqrt
f=h.atan
a=h.sin
d=h.cos
b=Y.getNumber
c=property.getNumber
q=0
s=0
P=0
p=0
ak=c("Cruise Altitude")W=c("Distance To Dive")aw=-c("Cruise Sensitivity X")aE=-c("Cruise Sensitivity Y")au=-c("Terminal Sensitivity X")an=-c("Terminal Sensitivity Y")ai=c("Fire Delay (Ticks)")aH=c("Vertical Trim On Launch")aD=c("Straight Pitch Trim")H=c("X to Y Ratio")av=c("Horizontal Trim")Q=0
ad=0
N=0
K=false
G=0
C=0
aN=0
aP=0
aO=0
r=c("Laser Sensitivity")function onTick()w=b(1)v=b(3)x=b(2)af=b(4)ah=b(5)T=b(6)m,i=d(af),a(af)y,l=d(ah),a(ah)n,k=d(T),a(T)U=y*n
E=-m*k+i*l*n
O=i*k+m*l*n
aK=y*k
am=m*n+i*l*k
aL=-i*n+m*l*k
aa=-l
z=i*y
V=m*y
aM=f(aK,u(U*U+aa*aa))S=f(am,u(E*E+z*z))ae=f(aL,u(O*O+V*V))_=-f(a(aM),a(-ae))B=S
A=f(w-ad,v-N)ar=f(a(S),a(-ae))aF=f(E,z)ay=b(7)aq=b(8)ap=b(9)q=ay
s=aq
P=ap
K=L(q)>1 or L(s)>1
I=u((q-w)^2+(s-v)^2)az=f(q-w,s-v)M=(e+A-az)%(e*2)-e+av
ax=B+f(x-P,I)ao=(x-Q)*60
aC=F((ak-x)*.5,-50,50)aB=(ao-aC)*.01
Q=x
ad=w
N=v
if I>W then
J=aB
o,j=aw,aE
else
J=ax
o,j=au,an
end
D=(d(_)*o*M)+(a(-_)*j*J)t=(a(_)*o*M)+(d(_)*j*J)aJ=ab(1)if aJ then
if p>ai then
g(1,D)g(2,t*H)R.setBool(1,true)if not K then
D=(d(_)*o*((e+A-G)%(e*2)-e))+(a(-_)*j*(B+C))t=(a(_)*o*((e+A-G)%(e*2)-e))+(d(_)*j*(B+C))g(1,D)g(2,t*H)I=0
end
else
g(1,0)g(2,aH)p=p+1
end
else
G=aF
C=-ar+aD
end
aI=ab(2)aj=b(12)ag=b(11)aG=b(10)Z=d(_)*ag+a(_)*aj
ac=-a(_)*ag+d(_)*aj
at=(d(_)*Z*r)+(a(-_)*(ac)*r)X=(a(_)*Z*r)+(d(_)*(ac)*r)if aG>W and K then X=t end
if aI and p>ai then
g(1,F(at,-4,4))g(2,F(X*H,-4,4))end
end
function F(al,aA,as)return h.min(h.max(al,aA),as)end
