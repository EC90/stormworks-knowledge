-- source: steam id 2855051802 / microcontroller.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2855051802
-- Author: Anonymous Sandwich
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/


p=150
r=1.5
at=tostring
ao=output
ad=tonumber
ay=input
W=property
ar=screen
s=math
ax=s.floor
f=ar.drawLine
ab=ar.setColor
i=s.abs
ai=s.sqrt
Q=s.atan
h=s.sin
l=s.cos
aa=string.sub
ap=W.getText
y=W.getNumber
u=ay.getNumber
Z=s.pi
aK=9
aJ=-20
pi=Z
F=0
x=0
aD=1
I,K=64,64
S,P,O=0,0,0
B,z=0,0
aV=0
af=3
o=1
function onTick()aN=u(1)aQ=u(2)t=y("Blocks From Front Of Seat")aF=W.getBool("Enable Artificial Horizon")A=y("Bar Style")ah=ap("Color Value")q=y("Angle Text")L=ay.getBool(2)Y=(y("Brightness")+.5)/r
S,P,O=ad(aa(ah,1,3)),ad(aa(ah,5,7)),ad(aa(ah,9,11))aD=u(12)aj=y("Draw Bars")C=y("HUD Orientation 1 (Arrow Direction)")if L then
af=1
o=3
end
a=u(4)b=u(5)aq=u(6)G,H=l(a),h(a)T,J=l(b),h(b)E,M=l(aq),h(aq)aR=H*M+G*J*E
aO=Q(T*M,ai((T*E)^2+J^2))/pi*2
aL=Q(G*E+H*J*M,ai((-G*M+H*J*E)^2+(H*T)^2))/pi*2
j=-Q(-H*E+G*J*M,ai(aR^2+(G*T)^2))g=Q(h(aO),h(aL))+pi/2
if t==0 then
k=50
if L then k=42 end
elseif t==.5 then
k=75
elseif t==1 then
k=90
if L then k=80 end
elseif t==2 then
k=125
if L then k=115 end
elseif t==3 then
k=p
elseif t==4 then
k=165
end
j=j*(k/50)if C==1 then
F=0
x=-10
elseif C==2 then
F=4
x=-5
elseif C==3 then
F=0
x=0
if L then
x=8
end
elseif C==4 then
F=-4
x=-5
end
ao.setNumber(1,C)ao.setBool(1,aS)aT=aW
end
function e(az,U,R)an=(az*(pi/18)-j)*p/o
aC=(-az*(pi/18)-j)*p/o
ak,ae={},{}ak.a=I/2+(l(g)*(an-R))+h(-g)*U+B
ak.b=K/2+(h(g)*(an-R))+l(-g)*U+z
ae.a=I/2+(l(g)*(aC+R))+h(-g)*U+B
ae.b=K/2+(h(g)*(aC+R))+l(-g)*U+z
return ae,ak
end
function onDraw()I=96
K=96
B=h(aN*Z*2.2)*aK*af-1+F
z=h(aQ*Z*2.1)*aJ*af-12+x
if aF then
if aD==1 then
for m=aj,18,aj do
if aj>0 then
N=0
if m>9 then N=-1
elseif m<9 then N=1 end
if m~=9 then
d=m*(k/50)c,_={},{}c[1],_[1]=e(d,15,3*N)c[2],_[2]=e(d,15,0)c[3],_[3]=e(d,12,0)c[4],_[4]=e(d,11,0)c[5],_[5]=e(d,9,0)c[6],_[6]=e(d,8,0)c[7],_[7]=e(d,5,0)c[8],_[8]=e(d,4,0)c[9],_[9]=e(d,1,0)c[10],_[10]=e(d,-1,0)c[11],_[11]=e(d,-4,0)c[12],_[12]=e(d,-5,0)c[13],_[13]=e(d,-8,0)c[14],_[14]=e(d,-9,0)c[15],_[15]=e(d,-11,0)c[16],_[16]=e(d,-12,0)c[17],_[17]=e(d,-15,0)c[18],_[18]=e(d,-15,3*N)c[19],_[19]=e(d,(19+((q-1)*3)),1)c[20],_[20]=e(d,-(19+((q-1)*3)),1)ac=i((i(d)*(pi/18)-i(j))*p)*r
ab(S,P,O,X(220-ac/o,0,220)*Y)if A<5 then
f(c[2].a,c[2].b,c[8].a,c[8].b)f(c[17].a,c[17].b,c[11].a,c[11].b)f(_[2].a,_[2].b,_[3].a,_[3].b)f(_[4].a,_[4].b,_[5].a,_[5].b)f(_[6].a,_[6].b,_[7].a,_[7].b)f(_[17].a,_[17].b,_[16].a,_[16].b)f(_[15].a,_[15].b,_[14].a,_[14].b)f(_[13].a,_[13].b,_[12].a,_[12].b)end
if A==1 or A==4 then
f(_[18].a,_[18].b,_[17].a,_[17].b)f(c[2].a,c[2].b,c[1].a,c[1].b)f(c[18].a,c[18].b,c[17].a,c[17].b)f(_[2].a,_[2].b,_[1].a,_[1].b)end
if A==3 or A==4 then
f(c[11].a,c[11].b,c[7].a,c[7].b)f(_[8].a,_[8].b,_[9].a,_[9].b)f(_[10].a,_[10].b,_[11].a,_[11].b)end
if q>0 then
v=""
if(m%1)==0 then
v=at(i(ax(-i(-m+9)+9)))end
if q==2 then
v=at(i(ax((-i(-m+9)+9)*10)))end
V(c[19].a-r*q,c[19].b-2,v)V(c[20].a-r*q,c[20].b-2,v)V(_[19].a-r*q,_[19].b-2,v)V(_[20].a-r*q,_[20].b-2,v)end
else
d=9*(k/50)ac=i((d*(pi/18)-i(j))*p)*r
ab(S,P,O,X(200-ac/o,0,200)*Y)al,aE=e(d,20,6)aw,as=e(d,-20,-6)aA,aB=e(d,-20,6)am,au=e(d,20,-6)f(al.a,al.b,aw.a,aw.b)f(aE.a,aE.b,as.a,as.b)f(aA.a,aA.b,am.a,am.b)f(aB.a,aB.b,au.a,au.b)end
end
end
aH=K/2+(h(g)*(-j*p)/o)+l(-g)*30+z
aI=K/2+(h(g)*(-j*p)/o)+l(-g)*-30+z
aM=I/2+(l(g)*(-j*p)/o)+h(-g)*30+B
aP=I/2+(l(g)*(-j*p)/o)+h(-g)*-30+B
ab(S,P,O,X((200-(i((pi/18)-i(j))*p*r)/o),0,200)*Y)f(aM,aH,aP,aI)end
end
end
function X(w,D,n)if w>n then return w
elseif w<D then return D
else return w end
end
local aG=ap("f")function V(a,b,av,aU)for m=1,av:len()do n=av:sub(m,m):upper():byte()*4-127 if n>257 then n=n-104 end w="0x"..aG:sub(n,n+3)for ag=0,14 do if w&(1<<(14-ag))>0 then D=a+ag//5+(m-1)*4 n=b+ag%5 f(D,n,D,n+1)end end end end
