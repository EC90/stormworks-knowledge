-- source: steam id 2855051802 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2855051802
-- Author: Anonymous Sandwich
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 3546 (3898 with comment) chars

l=255
G=100
ap=tostring
aa=tonumber
L=false
B=true
as=input
W=property
aq=output
Q=math
U=screen
n=U.drawLine
X=U.drawRect
o=U.setColor
r=Q.abs
h=Q.sin
P=Q.floor
am=aq.setBool
af=string.sub
au=W.getText
H=W.getNumber
at=W.getBool
R=as.getBool
k=as.getNumber
g=Q.pi
az=9
aE=-20
p={}m={}ai={}b={}aI=B
aL=L
aM=B
z={}t={}y={}x={}q=0
j=0
c=0
pi=g
aH=B
d=0
i=0
ad,aj,ah=0,0,0
s=3
for _=1,8 do
z[_]={}t[_]={}y[_]={}x[_]={}for a=1,5 do
z[_][a]=0
t[_][a]=0
y[_][a]=L
x[_][a]=0
end
end
function onTick()aB=k(4)aG=k(8)w=k(12)O=k(16)ao=k(20)an=k(24)S=k(28)aC=R(11)ax=at("Enable Radar Tracking")T=H("HUD Orientation 1 (Arrow Direction)")v=H("Blocks From Front Of Seat")aF=at("Radar Orientation")M=H("Minimum Radar Distance")av=H("Radar Distance Units")J=R(12)Y=au("Color Value")ae=(H("Brightness")+.5)/1.5
ad,aj,ah=aa(af(Y,1,3)),aa(af(Y,5,7)),aa(af(Y,9,11))if J then
s=1
aK=1
end
if aF then
ak=-1
else
ak=1
end
if v==0 then
c=50
if J then c=42 end
elseif v==1 then
c=90
if J then c=80 end
elseif v==2 then
c=125
if J then c=115 end
elseif v==3 then
c=150
elseif v==4 then
c=165
elseif v==.5 then
c=75
end
if T==1 then
q=0
j=-10
elseif T==2 then
q=4
j=-5
elseif T==3 then
q=0
j=0
if J then
j=8
end
elseif T==4 then
q=-4
j=-5
end
for _=1,8 do
for a=5,2,-1 do
z[_][a]=z[_][a-1]t[_][a]=t[_][a-1]y[_][a]=y[_][a-1]x[_][a]=x[_][a-1]end
x[_][1]=k((_-1)*4+1)z[_][1]=k((_-1)*4+2)*ak
t[_][1]=k((_-1)*4+3)*ak
y[_][1]=R(_)V=0
ab=0
u=0
al=0
for a=1,5 do
if y[_][a]then
u=u+1
ab=ab+t[_][a]V=V+z[_][a]al=al+x[_][a]end
end
p[_]=V/u
m[_]=ab/u
ai[_]=u>4
b[_]=al/u
end
aD=R(10)aq.setNumber(1,w)am(1,d>0)am(2,i>0)end
function aJ(C,A,e)if C>e then return e
elseif C<A then return A
else return C end
end
function f(f)if av==2 then
f=f*3.28084
if f>5280 then
return(P(f/528)/10)end
return P(f/G)*G
end
if f>1000 then
return(P(f/G)/10)end
return(P(f/G)*G)end
function onDraw()if aC and ax then
I=h(aB*g*2.2)*az*(s/3)E=h(aG*g*2.1)*aE*(s/3)i=0
d=0
N=0
for _=8,1,-1 do
if ai[_]then
K=h(p[_]*g*2)*c*(s/3)D=h(m[_]*g*2)*c*(s/3)if _>1 then
F=B
for a=_-1,1,-1 do
if(r((m[_])-m[a])<.008)and(r((p[_])-p[a])<.008)then F=L end
end
if F then
if b[_]>M then
if w>r(p[_])and O>r(m[_])and b[_]>ao and b[_]<an then
if b[_]<S and d==0 then
d=_
elseif i==0 or(b[_]<N)and b[_]>S and d==0 then
i=_
N=b[_]end
end
end
end
else
if b[_]>M then
if w>r(p[_])and O>r(m[_])and b[_]>ao and b[_]<an then
if b[_]<S and d==0 then
d=_
elseif i==0 or(b[_]<N)and b[_]>S and d==0 then
i=_
N=b[_]end
end
end
end
end
end
if d>0 then i=0 end
for _=8,1,-1 do
if ai[_]then
K=h(p[_]*g*2)*c*(s/3)D=h(m[_]*g*2)*c*(s/3)o(ad,aj,ah,150)if _>1 then
F=B
for a=_-1,1,-1 do
if(r((m[_])-m[a])<.008)and(r((p[_])-p[a])<.008)then F=L end
end
if F then
if b[_]>M then
if d==_ then
o(l,0,0)elseif i==_ then
o(l,l,0)end
ag=f(b[_])ac((15+I+K)*3+q-1,(14+E-D)*3+j-1,ap(ag))X((16+I+K)*3+q-2,(12+E-D)*3+j-2,4,4)end
end
else
if b[_]>M then
if d==_ then
o(l,0,0)elseif i==_ then
o(l,l,0)end
ag=f(b[_])ac((15+I+K)*3+q-1,(14+E-D)*3+j-1,ap(ag))X((16+I+K)*3+q-2,(12+E-D)*3+j-2,4,4)end
end
end
end
if w>0 then
o(ad,aj,ah,200*ae)if d>0 then
o(l,0,0,150*ae)elseif i>0 then
o(l,l,0,150*ae)end
X(48+(I-h(w*g*2)*c)*3+q,36+(E-h(O*g*2)*c)*3+j,6*h(w*g*2)*c,6*h(O*g*2)*c)end
if aD then
o(l,0,0)n(1,1,10,1)n(1,1,1,10)n(95,95,95,88)n(95,95,86,95)n(1,95,1,86)n(1,95,10,95)n(95,1,86,1)n(95,1,95,10)ac(29,82,"RADAR WARN")end
end
end
local aA=au("f")function ac(aw,ay,ar,aN)for _=1,ar:len()do e=ar:sub(_,_):upper():byte()*4-127 if e>257 then e=e-104 end C="0x"..aA:sub(e,e+3)for Z=0,14 do if C&(1<<(14-Z))>0 then A=aw+Z//5+(_-1)*4 e=ay+Z%5 n(A,e,A,e+1)end end end end
