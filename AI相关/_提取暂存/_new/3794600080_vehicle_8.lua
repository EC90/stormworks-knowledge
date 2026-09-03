-- source: steam id 3794600080 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794600080

y=math
a4=input
a5=output
a6=screen
--yyy--
e=a4
o=e.getBool
L=e.getNumber
t=a5.setBool
k=a6
d=k.setColor
n=k.drawLine
u=k.drawRect
f=k.drawRectF
M=k.drawTriangleF
N=k.drawCircle
O=k.drawCircleF
b=k.drawText
v=false
p=false
k={}
w={}
P={}
z={}
c=0
q=0
function l(g,h,Q,R,a1,a2)
return g>=Q and h>=R and g<Q+a1 and h<R+a2 
end

function A(g,h,S)
d(0,20,30)
N(g+3,h+3,3)
N(g+8,h+3,3)
u(g+5,h,1,6)
if S then
d(0,50,100)else d(0,4,8)
end
f(g+1,h+2,10,3)
f(g+2,h+1,8,5)
d(200,200,200)
if S then
O(g+8,h+3,2.5)else O(g+3,h+3,2.5)
end
end

function T(g,h)
n(g+2,h,g+10,h)
n(g+1,h+1,g+11,h+1)
f(g,h+2,12,3)
n(g+1,h+5,g+11,h+5)
n(g+2,h+6,g+10,h+6)
end

function onTick()
j=o(10)
U=o(11)
r=o(12)
for e=0,3 do
P[e]=o(13+e)
end
B=o(17)
x=o(18)
V=o(19)
m=L(1)
i=L(2)
for e=0,3 do
s=e*8
w[e]=j and l(m,i,1,36+s+c,85,7)
end
w[4]=j and l(m,i,1,76+c,85,7)w[5]=j and l(m,i,1,108+c,85,7)
if r then
W="North Up"
else W="Heading Up"
end
if B then
C="On"
else C="Off"
end
if V then
X="On"
else X="Off"
end
if U then
if v then
j=false
end
Y=j
and l(m,i,88,9,7,7)
Z=j
and l(m,i,88,56,7,7)
_=j
and l(m,i,88,17,7,38)
if Y and c<0 then
c=c+0.5
q=c
end
if c>0 then
c=0
q=c
end
if Z and c>-53 then
c=c-0.5
q=c
end
if c<-53 then
c=-53
q=c
end
if j and _ and i>16 and i<55 then
a0=true
else 
if a0 then
q=-(y.min(y.max(i,26),45)-26)*53/19 
end
a0=false
end
a3=c*19/53
c=c+(q-c)*0.1
a=y.ceil(c-0.5)
if j and l(m,i,88,1,7,7)then
D=true
else 
if D then
v=true
end
D=false
end
if j and not l(m,i,0,0,87,9)or not j then
if j and l(m,i,2,19+c,83,7)then
E=true
else 
if E then
p=not
p 
end
E=false
end
if p then
if j and not l(m,i,1,18+c,85,24)then
p=false
end
if j and l(m,i,2,27+c,83,7)then
F=true
else 
if F then
if not r then
G=true
end
p=false
end
F=false
end
if j and l(m,i,2,35+c,83,7)then
H=true
else 
if H then
if r then
G=true
end
p=false
end
H=false
end
else 
for e=0,5 do
if w[e]then
k[e]=true else 
if k[e]then
z[e]=true 
end
k[e]=false 
end
end
if j and l(m,i,1,84+c,85,7)then
I=true
else 
if I then
if x then
J=true
end
end
I=false
end
if j and l(m,i,1,92+c,85,7)then
K=true
else 
if K then
if not x then
J=true
end
end
K=false
end
end
end
else v=false
q=0
c=0
end
t(1,v)
t(2,G)
G=false
for e=0,5 do
t(e+3,z[e])z[e]=false 
end
t(9,J)
J=false
end

function onDraw()
if U then
d(0,4,8)
screen.drawClear()
d(0,20,30)
f(87,0,9,64)
d(0,4,8)
f(88,17,7,38)
if D then
d(0,50,100)else d(0,4,8)
end
f(88,1,7,7)
if Y then
d(0,50,100)else d(0,4,8)
end
f(88,9,7,7)
if Z then
d(0,50,100)else d(0,4,8)
end
f(88,56,7,7)
d(0,50,100)
if _ then
f(88,17+y.min(y.max(i,26),45)-26,7,19)
end
if E then
f(2,19+a,83,7)
end
for e=0,3 do
if k[e]then
s=e*8
f(1,36+s+a,85,7)
end
end
if k[4]then
f(1,76+a,85,7)
end
if k[5]then
f(1,108+a,85,7)
end
if I then
f(1,84+a,85,7)
end
if K then
f(1,92+a,85,7)
end
d(0,20,30)
u(1,18+a,84,8)
n(79,21+a,82,24+a)
n(82,22+a,84,20+a)
u(2,85+a,4,4)
u(2,93+a,4,4)
d(100,100,100)
f(88,17-a3,7,19)
d(200,200,200)
n(89,2,94,7)
n(89,6,94,1)
M(89,15,91,10,93.5,15)
M(88.5,57,94,57,91,63)
b(3,20+a,W)
b(2,37+a,"Range Rings"
)
b(2,45+a,"D"
)
b(6,45+a,"I"
)
b(9,45+a,"rect"
)
b(27,45+a,"i"
)
b(30,45+a,"on L"
)
b(49,45+a,"i"
)
b(52,45+a,"nes"
)
b(2,53+a,"Heading Line"
)
b(2,61+a,"Radar Line"
)
b(20,77+a,C)
b(13,85+a,"Light Theme"
)
b(13,93+a,"Dark Theme"
)
b(20,109+a,X)
d(0,50,100)
b(1,11+a,"Present"
)
b(35,11+a,"at"
)
b(43,11+a,"i"
)
b(46,11+a,"on mode"
)
b(1,29+a,"Radar Display"
)
b(1,69+a,"Map Underlay"
)
b(1,101+a,"Audio Feedback"
)
if x then
d(0,4,8)else d(0,50,100)
end
f(3,86+a,3,3)
if x then
d(0,50,100)else d(0,4,8)
end
f(3,94+a,3,3)
for e=0,3 do
s=e*8
A(73,36+s+a,P[e])
end
A(2,76+a,B)
A(2,108+a,V)
d(0,0,0,200)
if not r then
b(2,53+a,"Heading Line"
)
T(73,52+a)
b(20,77+a,C)
T(2,76+a)
end
if not B or not r then
f(2,85+a,5,5)
b(13,85+a,"Light Theme"
)
f(2,93+a,5,5)
b(13,93+a,"Dark Theme"
)
end
if p then
d(0,20,30)
f(1,27+a,85,16)
d(0,50,100)
if F then
f(2,27+a,83,7)
end
if H then
f(2,35+a,83,7)
end
d(200,200,200)
b(3,28+a,"North Up"
)
b(3,36+a,"Heading Up"
)
end
d(0,20,30)
f(0,0,87,9)
d(200,200,200)
b(13,2,"Radar Settings"
)
end
end