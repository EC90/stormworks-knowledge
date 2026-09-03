-- source: steam id 2855051802 / microcontroller.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2855051802
-- Author: Anonymous Sandwich
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/


p=150
q=1.5
ar=tostring
as=output
W=tonumber
am=input
aj=property
at=screen
s=math
aE=s.floor
f=at.drawLine
ah=at.setColor
m=s.abs
af=s.sqrt
V=s.atan
h=s.sin
l=s.cos
ag=string.sub
aq=aj.getText
y=aj.getNumber
u=am.getNumber
ak=s.pi
aI=9
aJ=-20
pi=ak
M=0
v=0
al=1
A,H=64,64
R,U,N=0,0,0
C,D=0,0
aW=0
aa=3
o=1
function onTick()aM=u(1)aR=u(2)w=y("Blocks From Front Of Seat")aF=aj.getBool("Enable Artificial Horizon")J=y("Bar Style")ai=aq("Color Value")r=y("Angle Text")E=am.getBool(2)ad=(y("Brightness")+.5)/q
R,U,N=W(ag(ai,1,3)),W(ag(ai,5,7)),W(ag(ai,9,11))al=u(12)X=y("Draw Bars")K=y("HUD Orientation 1 (Arrow Direction)")if E then
aa=1
o=3
end
b=u(4)a=u(5)ap=u(6)G,L=l(b),h(b)O,I=l(a),h(a)B,F=l(ap),h(ap)aN=L*F+G*I*B
aQ=V(O*F,af((O*B)^2+I^2))/pi*2
aH=V(G*B+L*I*F,af((-G*F+L*I*B)^2+(L*O)^2))/pi*2
j=-V(-L*B+G*I*F,af(aN^2+(G*O)^2))g=V(h(aQ),h(aH))+pi/2
if w==0 then
k=50
if E then k=42 end
elseif w==.5 then
k=75
elseif w==1 then
k=90
if E then k=80 end
elseif w==2 then
k=125
if E then k=115 end
elseif w==3 then
k=p
elseif w==4 then
k=165
end
j=j*(k/50)if K==1 then
M=0
v=-10
elseif K==2 then
M=4
v=-5
elseif K==3 then
M=0
v=0
if E then
v=8
end
elseif K==4 then
M=-4
v=-5
end
as.setNumber(1,K)as.setBool(1,aT)aV=aS
end
function e(aC,S,T)aD=(aC*(pi/18)-j)*p/o
ax=(-aC*(pi/18)-j)*p/o
ab,ac={},{}ab.b=A/2+(l(g)*(aD-T))+h(-g)*S+C
ab.a=H/2+(h(g)*(aD-T))+l(-g)*S+D
ac.b=A/2+(l(g)*(ax+T))+h(-g)*S+C
ac.a=H/2+(h(g)*(ax+T))+l(-g)*S+D
return ac,ab
end
function onDraw()A=96
H=96
C=h(aM*ak*2.2)*aI*aa-1+M
D=h(aR*ak*2.1)*aJ*aa-12+v
if aF then
if al==1 then
for i=X,18,X do
if X>0 then
P=0
if i>9 then P=-1
elseif i<9 then P=1 end
if i~=9 then
d=i*(k/50)c,_={},{}c[1],_[1]=e(d,15,3*P)c[2],_[2]=e(d,15,0)c[3],_[3]=e(d,12,0)c[4],_[4]=e(d,11,0)c[5],_[5]=e(d,9,0)c[6],_[6]=e(d,8,0)c[7],_[7]=e(d,5,0)c[8],_[8]=e(d,4,0)c[9],_[9]=e(d,1,0)c[10],_[10]=e(d,-1,0)c[11],_[11]=e(d,-4,0)c[12],_[12]=e(d,-5,0)c[13],_[13]=e(d,-8,0)c[14],_[14]=e(d,-9,0)c[15],_[15]=e(d,-11,0)c[16],_[16]=e(d,-12,0)c[17],_[17]=e(d,-15,0)c[18],_[18]=e(d,-15,3*P)c[19],_[19]=e(d,(19+((r-1)*3)),1)c[20],_[20]=e(d,-(19+((r-1)*3)),1)Z=m((m(d)*(pi/18)-m(j))*p)*q
ah(R,U,N,Y(220-Z/o,0,220)*ad)if J<5 then
f(c[2].b,c[2].a,c[8].b,c[8].a)f(c[17].b,c[17].a,c[11].b,c[11].a)f(_[2].b,_[2].a,_[3].b,_[3].a)f(_[4].b,_[4].a,_[5].b,_[5].a)f(_[6].b,_[6].a,_[7].b,_[7].a)f(_[17].b,_[17].a,_[16].b,_[16].a)f(_[15].b,_[15].a,_[14].b,_[14].a)f(_[13].b,_[13].a,_[12].b,_[12].a)end
if J==1 or J==4 then
f(_[18].b,_[18].a,_[17].b,_[17].a)f(c[2].b,c[2].a,c[1].b,c[1].a)f(c[18].b,c[18].a,c[17].b,c[17].a)f(_[2].b,_[2].a,_[1].b,_[1].a)end
if J==3 or J==4 then
f(c[11].b,c[11].a,c[7].b,c[7].a)f(_[8].b,_[8].a,_[9].b,_[9].a)f(_[10].b,_[10].a,_[11].b,_[11].a)end
if r>1 then
t=""
if(i%1)==0 then
t=ar(m(aE(-m(-i+9)+9)))end
if r==2 then
t=ar(m(aE((-m(-i+9)+9)*10)))end
Q(c[19].b-q*r,c[19].a-2,t)Q(c[20].b-q*r,c[20].a-2,t)Q(_[19].b-q*r,_[19].a-2,t)Q(_[20].b-q*r,_[20].a-2,t)end
else
d=9*(k/50)Z=m((d*(pi/18)-m(j))*p)*q
ah(R,U,N,Y(200-Z/o,0,200)*ad)aA,an=e(d,20,6)aB,az=e(d,-20,-6)aw,ao=e(d,-20,6)av,ay=e(d,20,-6)f(aA.b,aA.a,aB.b,aB.a)f(an.b,an.a,az.b,az.a)f(aw.b,aw.a,av.b,av.a)f(ao.b,ao.a,ay.b,ay.a)end
end
end
aP=H/2+(h(g)*(-j*p)/o)+l(-g)*30+D
aO=H/2+(h(g)*(-j*p)/o)+l(-g)*-30+D
aK=A/2+(l(g)*(-j*p)/o)+h(-g)*30+C
aG=A/2+(l(g)*(-j*p)/o)+h(-g)*-30+C
ah(R,U,N,Y((200-(m((pi/18)-m(j))*p*q)/o),0,200)*ad)f(aK,aP,aG,aO)end
end
end
function Y(x,z,n)if x>n then return x
elseif x<z then return z
else return x end
end
local aL=aq("f")function Q(b,a,au,aU)for i=1,au:len()do n=au:sub(i,i):upper():byte()*4-127 if n>257 then n=n-104 end x="0x"..aL:sub(n,n+3)for ae=0,14 do if x&(1<<(14-ae))>0 then z=b+ae//5+(i-1)*4 n=a+ae%5 f(z,n,z,n+1)end end end end
