-- source: steam id 2885633937 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2885633937
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
sID=math.random(999)
tmr=0
R,Rstd={},{}
sC=screen.setColor
dL=screen.drawLine
dR=screen.drawRect
dRF=screen.drawRectF
dCF=screen.drawCircleF
mF=math.floor
mA=math.abs
PI=math.pi
stf=string.format
lock=0
Txo,Tyo=0,0
function zero(x,y)
dR(x,y,2,4)
end
function one(x,y)
dL(x+2,y,x+2,y+5)
end
function two(x,y)
dL(x,y,x+3,y)
dL(x,y+2,x+3,y+2)
dL(x,y+4,x+3,y+4)
dL(x+2,y,x+2,y+2)
dL(x,y+2,x,y+4)
end
function three(x,y)
dL(x,y,x+3,y)
dL(x,y+2,x+3,y+2)
dL(x,y+4,x+3,y+4)
dL(x+2,y,x+2,y+4)
end
function four(x,y)
dL(x,y+2,x+3,y+2)
dL(x+2,y,x+2,y+5)
dL(x,y,x,y+2)
end
function five(x,y)
dL(x,y,x+3,y)
dL(x,y+2,x+3,y+2)
dL(x,y+4,x+3,y+4)
dL(x,y,x,y+2)
dL(x+2,y+2,x+2,y+4)
end
function six(x,y)
dR(x,y+2,2,2)
dL(x,y,x+3,y)
dL(x,y,x,y+2)
end
function seven(x,y)
dL(x,y,x+3,y)
dL(x+2,y,x+2,y+5)
end
function eight(x,y)
dR(x,y,2,4)
dL(x,y+2,x+3,y+2)
end
function nine(x,y)
dR(x,y,2,2)
dL(x+2,y,x+2,y+5)
dL(x,y+4,x+3,y+4)
end
function CSN(x,y,n)
if n=="0"then zero(x,y)
elseif n=="1"then one(x,y)
elseif n=="2"then two(x,y)
elseif n=="3"then three(x,y)
elseif n=="4"then four(x,y)
elseif n=="5"then five(x,y)
elseif n=="6"then six(x,y)
elseif n=="7"then seven(x,y)
elseif n=="8"then eight(x,y)
elseif n=="9"then nine(x,y)
end
end
function dsN(x,y,s)
s=tostring(s)
l=string.len(s)
for i=1,l do
n=s:sub(i,i)
CSN(x,y,n)
x=x+4
end
end
--compare dict contents
function cmpr(a,b)
return a.id<b.id
end
function cmpra(a,b)
return a.c<b.c
end
function cmprb(a,b)
return a.tc<b.tc
end
function onTick()
Tx=GN(24)
Ty=GN(25)
Gx=GN(26)
Gy=GN(27)
Gz=GN(28)
cps=GN(29)
mapx=GN(30)
mapy=GN(31)
zoom=GN(32)
--update data
if GN(1)==sID then
sID=sID+math.random(100)
end
if GN(1)~=0 then
if #R>0 then
fail=0
for i=1,#R do
if GN(1)==R[i].id then
R[i].x=GN(2)
R[i].y=GN(3)
R[i].z=GN(4)
R[i].tx=GN(5)
R[i].ty=GN(6)
R[i].tz=GN(7)
R[i].t=0
break
else
fail=fail+1
end
end
if fail==#R then
table.insert(R,{id=GN(1),x=GN(2),y=GN(3),z=GN(4),t=0,tx=GN(5),ty=GN(6),tz=GN(7)})
end
else
table.insert(R,{id=GN(1),x=GN(2),y=GN(3),z=GN(4),t=0,tx=GN(5),ty=GN(6),tz=GN(7)})
end
end
if #R>0 then
for i=1,#R do
R[i].t=R[i].t+1
if R[i].t>600 then table.remove(R,i)
break
end
end
end
if #R>0 then
for i=1,#R do
R[i].a=-math.atan(R[i].x-Gx,R[i].y-Gy)/(2*PI)-cps
R[i].e=math.atan((R[i].z-Gz),math.sqrt((R[i].x-Gx)^2+(R[i].y-Gy)^2))/(2*PI)
R[i].c=mA(R[i].a)+mA(R[i].e)
R[i].ta=-math.atan(R[i].tx-Gx,R[i].ty-Gy)/(2*PI)-cps
R[i].te=math.atan((R[i].tz-Gz),math.sqrt((R[i].tx-Gx)^2+(R[i].ty-Gy)^2))/(2*PI)
R[i].tc=mA(R[i].ta)+mA(R[i].te)
end
Rstd=R
table.sort(Rstd,cmpra)
SN(11,Rstd[1].a)
SN(12,Rstd[1].e)
table.sort(Rstd,cmprb)
SN(13,Rstd[1].ta)
SN(14,Rstd[1].te)
else
SN(11,0)
SN(12,0)
SN(13,0)
SN(14,0)
end
--send timing
if tmr==1 then
send=true
else
send=false
end
tmr=tmr%(mF(100+0.02*sID))+1
SN(1,sID)
SB(1,send)
if mA(Tx-Txo)>10*zoom or mA(Ty-Tyo)>10*zoom then
if #R>0 then
lock=0
for i=1,#R do
dx=mA(R[i].tx-Tx)
dy=mA(R[i].ty-Ty)
if dx+dy<zoom*80 then lock=i break end
end
else lock=0
end
end
if lock~=0 then
SN(15,R[lock].tx)
SN(16,R[lock].ty)
SN(17,R[lock].tz)
else
SN(15,Tx)
SN(16,Ty)
SN(17,Gz)
end
Txo,Tyo=Tx,Ty
end
function onDraw()
w=screen.getWidth()
h=screen.getHeight()
sC(0,0,0,128)
dRF(1,1,20,5)
sC(15,233,15,200)
dL(2,1,2,6)
dL(4,1,4,6)
dL(4,1,6,1)
dL(4,5,6,5)
dL(6,2,6,5)
dsN(9,1,sID)
if #R>0 then
for i=1,#R do
rsx,rsy=map.mapToScreen(mapx,mapy,zoom,w,h,R[i].x,R[i].y)
a=math.min((1-R[i].t/600),0.9)
sC(0,0,0,138*a)
dRF(mF(rsx)-7,mF(rsy)-8,12,5)
sC(15,233,15,255*a)
dCF(rsx,rsy,h/32)
dsN(mF(rsx)-7,mF(rsy)-8,mF(R[i].id))
sC(0,0,0,138*a)
screen.drawCircle(rsx,rsy,h/32)
if R[i].tx~=0 then
tmx,tmy=map.mapToScreen(mapx,mapy,zoom,w,h,R[i].tx,R[i].ty)
sC(222,111,15,255*a)
dCF(tmx,tmy,h/32)
sC(0,0,0,138*a)
screen.drawCircle(tmx,tmy,h/32)
if i==lock then
screen.drawCircle(tmx,tmy,h/32+2)
end
end
end
end
end