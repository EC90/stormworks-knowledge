-- source: steam id 3794647482 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794647482
m=math
sin=m.sin
cos=m.cos
tan=m.tan
asin=m.asin
atan=m.atan
abs=m.abs
flr=m.floor
T=table
tup=T.unpack
tin=T.insert
pi=m.pi
pi2=pi*2
pN=property.getNumber
pB=property.getBool
iN=input.getNumber
iB=input.getBool
s=screen
Line=s.drawLine
Text=s.drawText
RF=s.drawRectF
TF=s.drawTriangleF
DC=s.drawCircle
DR=s.drawRect
Color=s.setColor
function fMP(n)
an=abs(flr(n))
if an>=M then
return flr(n/M).."M"
elseif an>=K then
return flr(n/K).."K"
else
return flr(n)
end
end
function cD(n)
local n_abs = abs(flr(n))
if n_abs == 0 then return 1 end
local digits=flr(m.log(n_abs, 10))+1
if n < 0 then
digits=digits+1
end
return digits
end
function math.clamp(x, min, max)
if x ~= x then x=min end
if x < min then x=min end
if x > max then x=max end
return x
end
function EXtoQ(x)
return {sin(x/2),0,0,cos(x/2)}
end
function EYtoQ(y)
return {0,sin(y/2),0,cos(y/2)}
end
function EZtoQ(z)
return {0,0,sin(z/2),cos(z/2)}
end
function EZYXtoQ(x,y,z)
return Qmult(Qmult(EZtoQ(z),EYtoQ(y)),EXtoQ(x))
end
function Qmult(q,p)
local x,y,z,w=tup(q)
local a,b,c,d=tup(p)
return{w*a+x*d+y*c-z*b,w*b+y*d+z*a-x*c,w*c+z*d+x*b-y*a,w*d-z*c-y*b-x*a}
end
function Qconj(q)
local x,y,z,w=tup(q)
return{-x,-y,-z,w}
end
function Qrot(q,v)
v[4]=0
local x,y,z,w=tup(Qmult(Qmult(q,v),Qconj(q)))
return{x,y,z}
end
function E2l(x,y,z,Gx,Gy)
local Q=Qmult(EZYXtoQ(x,y,z),EZYXtoQ(-Gy,Gx,0))
local Vfw=Qrot(Q, {0, 0, 1})
local Vh={Vfw[1],0,Vfw[3]}
local yd=atan(Vh[1],Vh[3])
local hy = yd*0.5
local qpr=Qmult(Qconj({0,sin(hy),0,cos(hy)}),Q)
local x,y,z,w=qpr[1],qpr[2],qpr[3],qpr[4]
local pd=asin(m.max(-1.0,m.min(1.0,2*(w*x-y*z))))
local rd=atan(2*(w*z+x*y),1-2*(x*x+z*z))
return {pd,yd,rd}
end
function ErV(x,y,z,ax,ay,az,Gx,Gy)
local Q=Qmult(EZYXtoQ(x,y,z),EZYXtoQ(-Gy,Gx,0))
local AV=Qrot(Qconj(Q),{ax,ay,az})
return AV
end
style=pN("Style")
dis=pN("Display Distance")
offsetP=pN("Offset")
ld=pN("Pitch Scale Interval (deg)")
LS=pN("Ladder Scaling")
CSI=pN("Compass Scale Interval (deg)")
CO=pN("Color Option")
UA=pN("Unit of Altitude")
US=pN("Unit of Speed")
DV=pB("Display Vertical Velocity")
VV=pB("Display Velocity Vector")
PL=pB("Display Pitch Ladder Label")
CL=pB("Display Compass Label")
CS=pB("Display Compass Scale")
SL=pB("Display Speed Label")
SS=pB("Display Speed Scale")
AL=pB("Display Altitude Label")
AS=pB("Display Altitude Scale")
if CO==0 then
R=70
G=0
B=0
R2=70
G2=0
B2=0
else 
if CO==1 then
R=200
G=0
B=0
R2=0
G2=255
B2=0
else
R=63
G=63
B=63
R2=63
G2=63
B2=63
end
end
M=10^6
K=10^3
function onTick()
wx={}
wy={}
alt=iN(2)*UA
x=iN(4)
y=iN(5)
z=iN(6)
sx=iN(7)
sy=iN(8)
sz=iN(9)
ax=iN(10)
ay=iN(11)
az=iN(12)
spd=iN(13)*US
Gx=iN(14)*pi2
Gy=iN(15)*pi2
tn=iN(32)
if style==2 then
nXYZ2=E2l(x,y,z,Gx,Gy)
nV=ErV(x,y,z,ax,ay,az,Gx,Gy)
else
nXYZ2=E2l(x,y,z,0,0)
nV=ErV(x,y,z,ax,ay,az,0,0)
end
com=(((nXYZ2[2]/pi2-1)%1)*pi2)*(180/pi)
if UD==0 then
altdig=flr(cD(alt))
spddig=flr(cD(spd))
altF=flr(alt)
spdF=flr(spd)
else
spddig=0
altdig=0
altF=fMP(alt)
spdF=fMP(spd)
end
for i=1,8 do
tin(wx,iN(16+i*2-2))
tin(wy,iN(16+i*2-1))
end
end
function onDraw()
w=s.getWidth()
h=s.getHeight()
if style==2 then
nSV=ErV(0,0,0,sx,sy,sz,Gx,Gy)
sx,sy,sz=nSV[1],nSV[2],nSV[3]
fovX=(73/360)*pi2
fov=(58/360)*pi2
offset=offsetP
else
if style==0 then
offset=offsetP+tan(Gy)*-16
Gx,Gy=0,0
fov=atan(h/32,dis)
fovX=atan(w/32,dis)
else
Gx,Gy=0,0
offset=offsetP
fov=atan(h/32,3)
fovX=atan(w/32,3)
end
end
dy=ld/360*pi2/fov*-h/-3
rad=flr(w/LS)
cx=w/2
cy=h/2
y=nXYZ2[1]/fov*-h
co1=cos(nXYZ2[3])
si1=sin(nXYZ2[3])
if style==1 then
Color(30,30,255)
s.drawClear()
x1=cx+(y+pi2/fov*h*32)*co1-y*si1
y1=cy+(y+pi2/fov*h*32)*si1+y*co1
x2=cx-(y+pi2/fov*h*32)*co1-y*si1
y2=cy-(y+pi2/fov*h*32)*si1+y*co1
x3=cx+(y+pi2/fov*h*32)*co1-(y+pi2/fov*h*32)*si1
y3=cy+(y+pi2/fov*h*32)*si1+(y+pi2/fov*h*32)*co1
x4=cx-(y+pi2/fov*h*32)*co1-(y+pi2/fov*h*32)*si1
y4=cy-(y+pi2/fov*h*32)*si1+(y+pi2/fov*h*32)*co1
Color(60,20,10)
TF(x1,y1+offset,x2,y2+offset,x3,y3+offset)
TF(x2,y2+offset,x3,y3+offset,x4,y4+offset)
end
if SS then
Color(R,G,B)
for i=0,4,1 do
if UD==0 then
itv=5
i2=i*itv
spdFS=flr(spd-i2-spd%itv+0.1+itv*2)
else
if abs(spd-K*i)>=M then
itv=M
elseif abs(spd-5*i)>=K then
itv=K
else
itv=5
end
i2=i*itv
spdFS=fMP(spd-i2-spd%itv+0.1+itv*2)
end
seth=cy-22+spd%itv*(10/itv)+i*10+offset
if (cy+offset-7>seth or seth>cy+offset+4) then
Text(1,seth,spdFS)
end
end
end
if AS then
Color(R,G,B)
for i=0,4,1 do
if UD==0 then
itv=5
i2=i*itv
altFS=flr(alt-i2-alt%itv+0.1+itv*2)
else
if abs(alt-K*i)>=M then
itv=M
elseif abs(alt-5*i)>=K then
itv=K
else
itv=5
end
i2=i*itv
altFS=fMP(alt-i2-alt%itv+0.1+itv*2)
end
seth=cy-22+alt%itv*(10/itv)+i*10+offset
if (cy+offset-7>seth or seth>cy+offset+4) then
Text(w-m.clamp(altdig*5+1,21,9999),seth,altFS)
end
end
end
Color(R2,G2,B2)
x1=cx+rad*co1-y*si1
y1=cy+rad*si1+y*co1
x2=cx-(rad+1)*co1-y*si1
y2=cy-(rad+1)*si1+y*co1
Line(x1, y1+offset, x2, y2+offset)
for i=ld,90+fov/pi2*180,ld do
y=(nXYZ2[1]+i/360*pi2)/fov*-h
x1=cx+rad*co1-y*si1
y1=cy+rad*si1+y*co1
x2=cx+5*co1-y*si1
y2=cy+5*si1+y*co1
x4=cx-6*co1-y*si1
y4=cy-6*si1+y*co1
x5=cx-rad*co1-y*si1
y5=cy-rad*si1+y*co1
Line(x1,y1+offset,x2,y2+offset)
Line(x4,y4+offset,x5,y5+offset)
if i<91 then 
x3=cx+rad*co1-(y+dy)*si1
y3=cy+rad*si1+(y+dy)*co1
x6=cx-rad*co1-(y+dy)*si1
y6=cy-rad*si1+(y+dy)*co1
Line(x1,y1+offset,x3,y3+offset)
Line(x5,y5+offset,x6,y6+offset)
if PL then
x3=cx-(rad+8)*co1-y*si1
y3=cy-(rad+8)*si1+y*co1
Text(x3-3,y3-7+offset,flr(i))
end
else
x3=cx+rad*co1-(y-dy)*si1
y3=cy+rad*si1+(y-dy)*co1
x6=cx-rad*co1-(y-dy)*si1
y6=cy-rad*si1+(y-dy)*co1
Line(x1,y1+offset,x3,y3+offset)
Line(x5,y5+offset,x6,y6+offset)
if PL then
x3=cx+(rad+8)*co1-y*si1
y3=cy+(rad+8)*si1+y*co1
Text(x3-3,y3-7+offset,flr(180-i))
end
end
y=(nXYZ2[1]-i/360*pi2)/fov*-h
for i=5,rad,2 do
x1=cx+i*co1-y*si1
y1=cy+i*si1+y*co1
x2=cx+(i-1)*co1-y*si1
y2=cy+(i-1)*si1+y*co1
x3=cx-i*co1-y*si1
y3=cy-i*si1+y*co1
x4=cx-(i-1)*co1-y*si1
y4=cy-(i-1)*si1+y*co1
Line(x1,y1+offset,x2,y2+offset)
Line(x3,y3+offset,x4,y4+offset)
x1=cx+rad*co1-y*si1
y1=cy+rad*si1+y*co1
x3=cx-rad*co1-y*si1
y3=cy-rad*si1+y*co1
end
if i<91 then
x5=cx+rad*co1-(y-dy)*si1
y5=cy+rad*si1+(y-dy)*co1
x6=cx-rad*co1-(y-dy)*si1
y6=cy-rad*si1+(y-dy)*co1
Line(x1,y1+offset,x5,y5+offset)
Line(x3,y3+offset,x6,y6+offset)
if PL then
x3=cx-(rad+10)*co1-y*si1
y3=cy-(rad+10)*si1+y*co1
Text(x3-5,y3-7+offset,-flr(i))
end
else
x5=cx+rad*co1-(y+dy)*si1
y5=cy+rad*si1+(y+dy)*co1
x6=cx-rad*co1-(y+dy)*si1
y6=cy-rad*si1+(y+dy)*co1
Line(x1,y1+offset,x5,y5+offset)
Line(x3,y3+offset,x6,y6+offset)
if PL then
x3=cx+(rad+10)*co1-y*si1
y3=cy+(rad+10)*si1+y*co1
Text(x3-5,y3-7+offset,-flr(180-i))
end
end
end
if DV then
Color(R,G,B)
Line(w-1,cy+offset,w-1,cy+sy/5*-cy+offset)
end
if VV then
Color(R2,G2,B2)
if m.sqrt(sx^2+sz^2)*3.6<50 then
DC(cx,cy+offset,5)
RF(cx-1,cy+offset-1,3,3)
Line(cx,cy+offset,cx-sx/6*-cx,cy+offset+sz/6*-cy)
else
DC(cx-nV[2]*1.5*cx,cy+offset+nV[1]*1.5*-cy,2)
DC(cx,cy+offset,2)
Line(cx-2,cy+offset,cx-5,cy+offset)
Line(cx+2,cy+offset,cx+5,cy+offset)
Line(cx,cy+offset-2,cx,cy+offset-5)
end
else
Line(cx,cy+5+offset,cx-5,cy+offset)
Line(cx,cy+5+offset,cx+5,cy+offset)
end
if CS then
Color(R,G,B)
lcom=com-fovX/pi2*180
for i=CSI,fovX/pi2*360,CSI do
x=((lcom%CSI-i)/360*pi2)/fovX*-w
if x>cx+8 or x<cx-10 then
Line(x,0,x,4)
end
if ((lcom-lcom%CSI+i)%360)%10==0 then
if x-4>cx+8 or x-4<cx-21 then
Text(x-4,4,flr((lcom-lcom%CSI+i)%360))
end
end
end
end
if CL then
Color(0,0,0,150)
RF(cx-9,0,17,8)
Color(R,G,B)
Text(cx-7,2,flr(com))
DR(cx-9,0,17,8)
end
if SL then
Color(0,0,0,150)
RF(0,cy-4+offset,m.clamp(spddig*5+2,22,9999),8)
Color(R,G,B)
Line(m.clamp(spddig*5+2,22,9999),cy+offset,cx-4,cy+offset)
Text(2,(h/2)-2+offset,spdF)
DR(0,cy-4+offset,m.clamp(spddig*5+2,22,9999),8)
else
Line(0,cy+offset,cx-4,cy+offset)
end
if AL then
Color(0,0,0,150)
RF(w-m.clamp(altdig*5+3,23,9999),cy-4+offset,m.clamp(altdig*5+2,22,9999),8)
Color(R,G,B)
Line(cx+5,cy+offset,w-m.clamp(altdig*5+2,22,9999),cy+offset)
Text(w-m.clamp(altdig*5+1,21,9999),(h/2)-2+offset,altF)
DR(w-m.clamp(altdig*5+3,23,9999),cy-4+offset,m.clamp(altdig*5+2,22,9999),8)
else
Line(cx+5,cy+offset,w,cy+offset)
end
X2=Gx/fovX*-w
Y2=Gy/fov*h
for i=1,8 do
Color(R2,G2,B2)
if i==tn then
Color(200,0,0)
end
DC(X2+cx+(wx[i]/(fovX/2)*cx),Y2+cy+offset-(wy[i]/(fov/2)*cy),3)
end
end