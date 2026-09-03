-- source: steam id 2855051802 / microcontroller.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2855051802
-- Author: Anonymous Sandwich
-- GitHub: <GithubLink>
-- Workshop: https://steamcommunity.com/id/AnonSandwich/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 3629 (3981 with comment) chars

H=tostring
ao=tonumber
aK=input
am=property
aD=output
ab=screen
o=math
ar=o.abs
s=ab.drawRectF
d=ab.drawLine
w=ab.setColor
aC=aD.setNumber
g=o.floor
Y=o.sqrt
q=o.atan
u=o.sin
af=o.cos
ah=string.sub
az=am.getText
aA=aK.getBool
C=am.getBool
t=am.getNumber
i=aK.getNumber
ap=o.pi
aY=9
aR=-20
pi=ap
l=0
f=0
aM=false
ag=true
k=1
a,_=64,64
K,D,E=0,0,0
au=0
b,c=0,0
bd=0
e=3
aG=0
b_=1
function onTick()aZ=i(1)aO=i(2)m=i(3)Z=t("Speed Units")aV=t("Altitude Units")aI=C("Vertical Speed Indicator")aT=C("Vertical Speed Dynamic Color")B=t("HUD Orientation 1 (Arrow Direction)")v=t("Blocks From Front Of Seat")aL=C("Enable Radar Tracking")aF=C("Enable Artificial Horizon")aS=C("Enable Prograde Indicator")av=t("Steering Bar Style")aB=(t("Brightness")+.5)/1.5
M=aA(2)aE=aA(1)R=i(10)Q=i(11)ak=az("Color Value")K,D,E=ao(ah(ak,1,3)),ao(ah(ak,5,7)),ao(ah(ak,9,11))if M then
e=1
b_=3
end
X=i(4)W=i(5)at=i(6)x,I=af(X),u(X)G,A=af(W),u(W)J,L=af(at),u(at)aJ=I*L+x*A*J
aP=q(G*L,Y((G*J)^2+A^2))/pi*2
aW=q(x*J+I*A*L,Y((-x*L+I*A*J)^2+(I*G)^2))/pi*2
bb=-q(-I*J+x*A*L,Y(aJ^2+(x*G)^2))ba=q(u(aP),u(aW))+pi/2
ax=g(q(aJ,x*G)*(180/pi)%360)ay=i(7)aw=i(8)aj=i(9)n=Y(ay^2+aw^2+aj^2)au=n
P=(aG-m)*t("Vertical Speed Factor")*60
aG=m
if v==0 then
j=50
if M then j=42 end
elseif v==1 then
j=90
if M then j=80 end
elseif v==2 then
j=125
if M then j=115 end
elseif v==3 then
j=150
elseif v==4 then
j=165
elseif v==.5 then
j=75
end
if aI then
aq=-1
else aq=0 end
if Z==1 then
n=n*1.94384
U="KN"
elseif Z==2 then
n=n*2.23694
U="MPH"
elseif Z==3 then
n=n*3.6
U="KMH"
elseif Z==4 then
U="m/s"
end
if aV==1 then
m=m*3.28084+.5
aa=g(m)an="ft"
if m>7500 then
an="fl"
aa=g(m/100)end
aN=0
else
an="M"
aa=g(m+.5)aN=3
end
if B==1 then
l=0
f=-10
V=21
T=7
S=25
O=11
ad=0
ae=0
ac=0
N=0
elseif B==2 then
l=4
f=-5
V=0
T=0
S=0
O=0
ad=7
ae=11
ac=21
N=25
elseif B==3 then
l=0
f=0
if M then
f=8
end
V=23/e
T=64/e
S=32/e
O=73/e
ad=g(93/e)ae=g(96/e)ac=g(93/e)N=g(96/e)elseif B==4 then
l=-4
f=-5
V=31
T=31
S=31
O=31
ad=21
ae=25
ac=7
N=11
end
if aE and not aM then
if R>=V and R<=S and Q>=ad and Q<=ae and aL then
ag=not ag
end
if R>=T and R<=O and Q>=ac and Q<=N then
k=k+1
if k==6 then
k=1
end
end
end
aC(1,B)aD.setBool(1,ag)aC(2,k)aM=aE
end
function onDraw()a=96
_=96
b=u(aZ*ap*2.2)*aY*e-1+l
c=u(aO*ap*2.1)*aR*e-12+f
if aF then
if k<4
then
w(K,D,E,255*aB)if av==1 then
d(a/2-11+b,_/2+c,a/2-4+b,_/2+c)d(a/2+11+b,_/2+c,a/2+4+b,_/2+c)s(a/2-1+b,_/2+c,3,1)d(a/2-4+b,_/2+c,a/2-4+b,_/2+2+c)d(a/2+4+b,_/2+c,a/2+4+b,_/2+2+c)elseif av==2 then
d(a/2-10+b,_/2+c,a/2-5+b,_/2+c)d(a/2-5+b,_/2+1+c,a/2-2+b,_/2+4+c)d(a/2-3+b,_/2+3+c,a/2+1+b,_/2-1+c)d(a/2+1+b,_/2+c,a/2+5+b,_/2+4+c)d(a/2+4+b,_/2+3+c,a/2+7+b,_/2+c)d(a/2+7+b,_/2+c,a/2+12+b,_/2+c)end
end
if k<3 or k==4 then
w(0,0,0)s(0,30+f,15,14)s(80,30+f,18,14)s(40+l,89,14,7)w(K,D,E)aX=H(g(aa)):len()y(94+aq-(aX*4),31+f,H(aa))y(1,31+f,H(g(n)))y(86+aq+aN,38+f,an)y(1,38+f,U)aQ=H(g(ax+.5)):len()y(47+l-(aQ*2),90,H(g(ax+.5)))if ar(P)>1 and aI then
if aT then
w(as(ar(P)*2-30,0,150),150-as(ar(P)*2-30,0,150),0)end
s(95,34+f,1,P/3)end
end
end
if aS and k<3 then
r=q(ay,aj)*j*e+b
p=-q(aw,aj)*j*e+c
w(K,D,E,255*aB)if au>1 then
ab.drawCircle(a/2+r,_/2+p,2)d((a/2)-3+r,_/2+p,(a/2)-6+r,_/2+p)d(a/2+r,(_/2)-3+p,a/2+r,(_/2)-5+p)d((a/2)+3+r,_/2+p,(a/2)+6+r,_/2+p)end
end
w(K,D,E,255)if aL then
s(23+l,93,9,3)end
if aF then
s(64+l,93,9,3)end
end
function as(z,F,h)if z>=h then return h
elseif z<=F then return F
else return z end
end
local aU=az("f")function y(X,W,aH,bc)for ai=1,aH:len()do h=aH:sub(ai,ai):upper():byte()*4-127 if h>257 then h=h-104 end z="0x"..aU:sub(h,h+3)for al=0,14 do if z&(1<<(14-al))>0 then F=X+al//5+(ai-1)*4 h=W+al%5 d(F,h,F,h+1)end end end end
