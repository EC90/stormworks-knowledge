-- source: steam id 3261800786 / vehicle.xml block#31
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3261800786

aH=pi
aI=input
aJ=output
aU=math
aX=property
aY=string
a_=screen
--yyy--
i=aU
F=i.floor
function j(A)
return F(A+0.5)
end
n=i.sin
aV=i.ceil
o=i.cos
aH=i.pi
T=aH*2
c=aI.getNumber
f=aI.getBool
aW=aJ.setNumber
B=aJ.setBool
ac=false
ad=aX.getNumber
v=aY.format
p=ad('Radar Fov X')*T*0.5
ae={'SEN','ENG','WPN','LGT'}
af=ad('Max Chaff Per Side')
aZ={true,false,false,false}
q=1
G=0
h=true
U=false
ag=false
ah=false
V=true
W=true
X=64
a1=64
k,ai=X-17,a1-8
function C(w,x,D,E,H)
if a2 and a3>w and a3<w+D and a4>x and a4<x+E and not ac then
H=not
H else 
end
return H 
end

function aj(w,x,D,E,aK,aL,H,aM)
local ak,al,am=4,45,43
if aM then
ak,al,am=1,15,13 
end
local a5=aK
if G<0 then
a5=aL
end
if H then
g(ak)
y(w,x,D,E)
g(0)
an(w,x,D,E,a5,0,0)else g(am)
y(w,x,D,E)
g(al)
an(w,x,D,E,a5,0,0)
end
end

function r(A,ao,Y)aN,aO=A*n(Y)-ao*o(Y),A*o(Y)+ao*n(Y)
return aN,aO 
end

function I(A)
if A then
return'OK'else return'ERR'end
end

function onTick()
a3=c(3)
a4=c(4)
a2=f(1)
aP=f(2)
s=-(c(32)-c(31)-0.25)*T
l=(c(32)-c(29))*T
ap=c(30)
aq=j(c(5)*3.6)
Z=j(c(6))
ar=j(c(7))
as=j(100*c(8))
at=j(100*c(9))
au=j(100*c(10))
aQ=j(100*c(11))
aR=j(100*c(12))
av=c(13)
aw=c(14)
ax=c(15)
ay=c(16)
az=c(17)
aA=c(18)
aB=j(c(19))
aC=v('%2.0f',c(21))
aD=v('%2.0f',c(22))
aE=v('%2.0f',c(23))
aF=v('%2.0f',c(24))
a6=F(c(25))
a7=F(c(26))
aS=v('%2.0f',c(27)*360)
aT=v('%2.0f',c(28)*360)
z={{{I(av),'PS1',av==0},{I(aw),'PS2',aw==0},{I(ax),'ASX',ax==0},{I(ay),'ASY',ay==0},{I(az),'WND',az==0},{v('%1.1f',aA),'RAD',aA>1.9},{aB,'TMP',aB<5},{'RWR','RWR',f(16)}},{{aq,'SPD',aq>90},{Z,'RPS',Z==0},{ar,'TMP',ar>110},{as,'FUE',as<20},{at,'BAT',at<60},{au,'THR',au==100},{aQ,'CLL',Z==0},{aR,'CLR',Z==0}},{{aC,'GW1',aC=='0'},{aD,'GW2',aD=='0'},{aE,'CW1',aE=='0'},{aF,'CW2',aF=='0'},{a6,'FLL',a6==0},{a7,'FLR',a7==0},{aS,'Pit',i.abs(c(27))>30},{aT,'Rol',i.abs(c(28))>30}},{{'all','all',not h,h},{'spl','spl',not h,U or f(11)},{'brk','brk',not h,f(12)},{'rev','rev',not h,f(13)and f(14)},{'int','int',not h,V},{'inf','inf',not h,W}}}
if h then
B(11,U or f(11))
B(12,f(12)and f(15))
B(13,f(13)and f(14)and f(15))
B(14,V and f(15))
B(15,W and f(15))else 
for d=11,15 do
B(d,false)
end
end
aG=false
for d=1,#z[1]do
if z[1][d][3]then
aG=true
break 
end
end
if a2 and a4<7 then
q=i.max(i.min(i.ceil(a3/16),4),1)
end
if q==4 then
h=C(k+1,2+7,16,6,h)
if h then
U=C(k+1,2+14,16,6,U)
ag=C(k+1,2+21,16,6,ag)
ah=C(k+1,2+28,16,6,ah)
V=C(k+1,2+35,16,6,V)
W=C(k+1,2+42,16,6,W)
end
end
if G==60 then
G=-60 
end
G=G+1
ac=a2
end
m=a_
t=m.setColor
b0=m.drawCircle
e=m.drawLine
b1=m.drawText
an=m.drawTextBox
J=m.drawRect
y=m.drawRectF
function g(u)
if u==0 then
t(5,5,5)
elseif u==1 then
t(166,21,10)
elseif u==15 then
t(83,10,5)
elseif u==13 then
t(41,5,2)
elseif u==4 then
t(15,220,30)
elseif u==43 then
t(5,14,6)
elseif u==45 then
t(9,55,11)
elseif u==47 then
t(10,140,20)
end
end

function onDraw()
X=m.getWidth()
a1=m.getHeight()
k,ai=X-17,a1-8
a,b=F(k/2),7+F(ai/2)
g(45)K,L=r(-10,-13,s)M,N=r(10,-13,s)O,P=r(-10,20,s)Q,R=r(10,20,s)
e(a+K,b+L,a+M,b+N)
e(a+M,b+N,a+Q,b+R)
e(a+Q,b+R,a+O,b+P)
e(a+O,b+P,a+K,b+L)K,L=r(-5,14,s)M,N=r(5,14,s)O,P=r(-5,18,s)Q,R=r(5,18,s)
e(a+K,b+L,a+M,b+N)
e(a+M,b+N,a+Q,b+R)
e(a+Q,b+R,a+O,b+P)
e(a+O,b+P,a+K,b+L)
g(45)
e(a-2,b-8,a-7,b-6)
e(a-7,b-6,a-7,b+11)
e(a-7,b+11,a+7,b+11)
e(a+7,b+11,a+7,b-6)
e(a+7,b-6,a+2,b-8)
e(a+2,b-8,a-2,b-8)
g(0)
y(a-1,b-5,2,-15)
g(45)
J(a-1,b-5,2,-15)
if aP then
e(a+18*n(l-p),7+b-18*o(l-p),a+37*n(l-p),7+b-37*o(l-p))
e(a+18*n(l+p),7+b-18*o(l+p),a+37*n(l+p),7+b-37*o(l+p))
if ap~=0 then
g(1)
for d=-5,5 do
_=l+ap*T+d*0.02
e(a+19*n(_),7+b-19*o(_),a+66*n(_),7+b-66*o(_))
end
end
end
S=4
a0=2+2*af
a8=a-7-S
a9=b+8
aa=a+7
ab=b+8
g(0)
y(a8,a9,S,-a0)
y(aa,ab,S,-a0)
g(47)
J(a8,a9,S,-a0)
J(aa,ab,S,-a0)
e(0,7,X,7)
for d=1,af do
if d<a6+1 then
y(a8+2,a9+1-2*d,1,-1)
end
if d<a7+1 then
y(aa+2,ab+1-2*d,1,-1)
end
end
for d=1,4 do
aj(16*d-16,1,15,6,ae[d],ae[d],q==d,false)
end
for d=1,#z[q]do
aj(k+1,2+7*d,16,6,z[q][d][2],z[q][d][1],z[q][d][4],z[q][d][3])
end
if aG then
g(1)else g(45)
end
J(a+2,b-1,3,4)
J(a-5,b-3,3,2)end