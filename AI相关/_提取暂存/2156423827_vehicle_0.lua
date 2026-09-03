-- source: steam id 2156423827 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2156423827

o=input
u=output
z=tostring
A=table
D=screen
H=math
M=pairs
N=tonumber
O=ipairs
P=string
--yyy--
a=0
b=1000
c=a
d=13
e=7
f={}
g={}
h={}
i=0
j=false
k={x=1,y=1,w=25,h=7}
l={x=100,y=1,w=31,h=7}
m={}
n=e*3
function onTick()
if n>0 then
n=n-1 
end
if not(o.getNumber(29)==a)or not(o.getNumber(30)==b)then
c=o.getNumber(29)
n=e*2 
end
a=o.getNumber(29)
b=o.getNumber(30)
d=o.getNumber(28)
p=o.getBool(31)
if b-a<=0 then
return 
end
if j and not p and(q>=k.x and q<=k.x+k.w and r>=k.y and r<=k.y+k.h)then
i=i+1
if i>2 then
i=0
end
end
if j and not p and(q>=l.x and q<=l.x+l.w and r>=l.y and r<=l.y+l.h)then
f={}
g={}
h={}
m={}
end
q=o.getNumber(31)
r=o.getNumber(32)
j=p
for s=1,d do
t=c+s-1
while t>b do
t=t-b+a-1 
end
u.setNumber(s,t)
if n==0 then
v=c+s-1-d*e
while v<a do
v=v+b-a+1 
end
w=v
x=o.getNumber((s-1)*2+1)
y=o.getNumber((s-1)*2+2)
if y>0 or x>0 then
g[z(w)]={compAudio=y,video=x}m[z(w)]={compAudio=y,video=x}
else g[z(w)]=nil 
end
f[z(w)]={compAudio=y,video=x}
end
end
c=c+d
if c>b then
A.insert(h,1,m)
if B and#h>B-30 then
A.remove(h,#h)
end
m={}
end
while c>b do
c=c-b+a-1 
end
end

function onDraw()
C=D
E=C.getWidth()
B=C.getHeight()
if i==0 then
C.setColor(100,100,100)
C.drawText(1,10,"Live"
)
C.setColor(0,0,127)
C.drawText(28,10,"Vid"
)
C.setColor(127,0,0)
C.drawText(50,10,"Cmp/Aud"
)
for s=a,b do
F=f[z(s)]if not(F==nil)then
if F.compAudio>0 then
C.setColor(255,0,0,127)
G=H.max(1,(B-30)*F.compAudio)
C.drawRectF((E-1)*(s-a)/(b-a),B-G,1,G)
end
if F.video>0 then
C.setColor(0,0,255,127)
G=H.max(1,(B-30)*F.video)
C.drawRectF((E-1)*(s-a)/(b-a),B-G,1,G)
end
end
end
C.setColor(0,255,0,127)
C.drawRectF(E*(c-a)/(b-a),0,1,B)
elseif i==1 then
C.setColor(100,100,100)
C.drawText(1,10,"Freq"
)
C.drawText(E-35,10,"Cmp/Aud"
)
C.drawText(E-55,10,"Vid"
)
I=0
J={}
for K,L in M(g)do
A.insert(J,N(K))
end
A.sort(J)
for K,L in O(J)do
C.setColor(150,150,150)
C.drawText(1,I*8+20,P.format(N(L),"%.f"
).." +- 0.5"
)
C.setColor(127,0,0)
C.drawTextBox(E-40,I*8+20,35,5,H.floor(g[z(L)].compAudio*100).."%"
,1,0)
C.setColor(0,0,127)
C.drawTextBox(E-60,I*8+20,20,5,H.floor(g[z(L)].video*100).."%"
,1,0)
I=I+1 
end
elseif i==2 then
C.setColor(100,100,100)
C.drawText(1,10,"Time"
)
C.setColor(0,0,127)
C.drawText(28,10,"Vid"
)
C.setColor(127,0,0)
C.drawText(50,10,"Cmp/Aud"
)
for Q,R in O(h)do
for S,T in M(R)do
s=S
F=R[z(s)]if not(F==nil)then
U=B-Q
if F.compAudio>0 then
C.setColor(255,0,0,127)
C.drawRectF((E-1)*(s-a)/(b-a),U,1,1)
end
if F.video>0 then
C.setColor(0,0,255,127)
C.drawRectF((E-1)*(s-a)/(b-a),U,1,1)
end
end
end
end
end
C.setColor(120,120,120)
C.drawText(k.x+k.w+6,1,H.floor(a).." - "
..H.floor(b))
C.drawRectF(k.x,k.y,k.w,k.h)
C.drawRectF(l.x,l.y,l.w,l.h)
C.setColor(0,0,0)
C.drawTextBox(k.x,k.y,k.w,k.h,"Mode"
,0,0)
C.drawTextBox(l.x,l.y,l.w,l.h,"Reset"
,0,0)
if b-a<=0 then
C.setColor(0,0,0)
C.drawClear()
C.setColor(100,100,100)
C.drawTextBox(0,0,E,B,"select min and max freq to scan"
,0,0)
end
end