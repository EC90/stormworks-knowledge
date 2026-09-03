-- source: steam id 3792899963 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792899963
aQ="Torpedo"
aP=""
aO="LGB"
aN="Rocket Pod"
aM="LGM"
aL="Ammo: "
aK="Unknown"
aJ="GPS Missile"
aI="Unguided Bomb"
aH="Cannon"
aG="Empty"
aF="Fuel Pod"

ad=ipairs
w=tonumber
r=tostring
C=true
d=false
ak=input
al=property
P=string
s=math
B=screen
x=B.drawLine
aj=B.drawRectF
A=B.setColor
Z=s.pi
q=P.sub
S=s.floor
ac=al.getText
V=output.setBool
e=ak.getNumber
J=ak.getBool
af=al.getNumber
N={}k=aP
type={0,0}b=aP
y=aP
M=d
_={}_.I=0
_.F=0
_.L=0
_.T=0
_.E=0
K=d
R=d
h={0,0}Y=d
ab=1
aB=d
aA=d
aD=d
H=0
o={}u=d
function onTick()X=af("Number of Hardpoints")aa=J(20)aw=e(20)ae=e(21)n=e(24)W=J(22)ar=J(23)as=J(24)if H>9 then
ax(e(23),e(31))else
H=H+1
end
if n<1 then n=X
elseif n>X then n=1 end
if aa and not Y and W and aw<30 and ae>16 and ae<24 then
u=not u
end
if n~=ab then aq()end
ab=n
Y=aa
for j=1,16 do
V(j,d)end
V(n,aC)if type[1]==4 then V(16,C)end
a={{},{},{},{},{},{}}for j=1,6 do
Q=ac("Color Code "..r(S(j)))a[j].v,a[j].z,a[j].f=w(q(Q,1,3)),w(q(Q,5,7)),w(q(Q,9,11))end
end
function ax(c,an)if c>=1000000 then
G=r(S(c))type[1],type[2]=w(q(G,1,1)),w(q(G,2,2))ao=w(q(G,6,7))N[ao]=P.char(q(G,3,5)+0)h[1],h[2]=e(2),e(3)at(type[1],type[2],e(2))k=aP
for g,f in ad(N)do
k=k..f
end
else
k,type[1],type[2]=ay(c)h[1],h[2]=e(2),e(3)end
if r(an)~=aP then
_.I=e(25)*180*Z
_.F=e(26)*180*Z
_.L=e(27)_.T=e(28)_.E=e(29)if _.I*_.F>0 then
_.E=8/(_.I*_.F)R=C
else
_.E=0
R=d
end
if _.L>0 and _.T>0 then
K=C
else
K=d
end
end
end
function am(l)if l==1 then return "AAM"
elseif l==2 then return "Radar AGM"
elseif l==3 then return "Radar AAM/AGM"
elseif l==4 then return aM
elseif l==5 then return aJ
elseif l==6 then return aQ
elseif l==7 then return aO
elseif l==8 then return "Radar GBU"
elseif l==9 then return aI
else return "Launch Weapon" end
end
function at(t,i,av)if t==0 then b="empty"
elseif t==1 then
b=am(i)elseif t==2 then
if i==1 then b=aH
elseif i==2 then b=aN
elseif i==3 then b="Chaff Dispenser"
elseif i==4 then b="Flare Dispenser"
else b="Firing Weapon" end
elseif t==3 then
b="Rack"
if av>0 then
y=am(i)else
y=aG
end
elseif t==4 then
if i==1 then b="Jamming Pod"
elseif i==2 then b="Tracking Pod"
else b="Unknown Activate" end
elseif t==5 then
if i==1 then b=aF
elseif i==2 then b="Winch"
else b="Unknown Utility" end
else
b=aK
end
end
function ay(c)M=C
if c==1 then
return "Utility",5,0
elseif c==2 then
return aF,5,1
elseif c==3 then
return aI,1,9
elseif c==4 then
return aO,1,7
elseif c==5 then
return "GPS PGM",1,8
elseif c==6 then
return "Rocket",1,0
elseif c==7 then
return aN,2,2
elseif c==8 then
return aM,1,4
elseif c==9 then
return aJ,1,5
elseif c==10 then
return "RGM",1,3
elseif c==11 then
return aQ,1,6
elseif c==12 then
return aH,2,1
end
return aG,0,0
end
function aq()M=d
H=0
N={}k=aP
b=aP
type={0,0}_={}_.I=0
_.F=0
_.L=0
_.T=0
_.E=0
K=d
R=d
h={0,0}y=aP
end
function onDraw()if W then
A(a[1].v,a[1].z,a[1].f)B.drawClear()p={}aE={}if M and k~=aG then
O=aK
ah=k
else
O=k
ah=b
end
if y~=aP and h[1]<1 then O=aG end
if k~=aG then
if u then
if y~=aP then
p[3]=aL..s.floor(h[1])elseif type[1]==2 then
p[3]=aL..s.floor(h[1]).."/"..s.floor(h[2])elseif type[1]==5 and type[2]==1 then
p[3]="Lvl: "..s.floor(h[1]).."L/"..s.floor(h[2]).."L"
else
u=d
end
end
else
u=d
end
if not u
then
p[3]="Type: "..ah
end
if k==aG then p[3]=aP end
p[1]="Pos "..r(S(n))p[2]="Name: "..O
A(a[2].v,a[2].z,a[2].f)for g,f in ad(p)do
ag=P.len(f)*4+12
if o[g]==nil then o[g]=0 end
if o[g]>=ag then o[g]=0
else o[g]=o[g]+af("Scroll Speed")end
if o[g]>0 and ag>40 then
D(1-o[g],(g-1)*8+2,r(f).."   "..r(f))else
D(1,(g-1)*8+2,r(f))end
end
A(a[5].v,a[5].z,a[5].f)if as then
aj(0,25,17,7)end
if ar then
aj(17,25,15,7)end
A(a[2].v,a[2].z,a[2].f)D(1,26,"DROP")if type[1]==4 then
D(22,26,"A")end
A(a[3].v,a[3].z,a[3].f)x(0,0,29,0)x(0,8,29,8)x(0,16,29,16)x(0,24,29,24)x(17,25,17,32)end
end
local au=ac("f")function D(ap,az,ai,v)for j=1,ai:len()do m=ai:sub(j,j):upper():byte()*4-127 if m>257 then m=m-104 end g="0x"..au:sub(m,m+3)for U=0,14 do if g&(1<<(14-U))>0 then f=ap+U//5+(j-1)*4 m=az+U%5 x(f,m,f,m+1)end end end end
