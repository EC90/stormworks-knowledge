-- source: steam id 3464467373 / vehicle.xml block#24
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3464467373

GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.abs
mF=M.floor
Mr=M.sqrt
Mc=M.cos
Ms=M.sin
P=M.pi*2
T=table
TS=T.insert
TR=T.remove
TT=T.sort
TN=tonumber
function Dst(a,b)
return Mr((a[1]-b[1])^2+(a[2]-b[2])^2+(a[3]-b[3])^2)
end

function Sorteta(c,d)
return c.e<d.e 
end
mergedist=PN('merge dist')
adr=PN('AutoDefendRange')
dlsw=PN('Danger Level Shift Wait')
d1t=PN('D1 eta threshold')
d2t=PN('D2 eta threshold')
fltA=PN('Target Altitude Filter')
D={}
F={}
id=1
slid=0
slchanged=false
tc=false
sltgt=1
cur=1
sp={0,0}
name={'a','b','c','d','e','f','g','h'}
slot={}
lifemax=0
fireplan={}w,h=64,64
for e=1,8 do
slot[e]={0,0,0,0,0,0}
end

function bb2d(f)
local g=''for e=1,9 do
if GB(e+f-1)then
g=g..'1'else g=g..'0'end
end
return g 
end

function onTick()
ae1=GB(20)
ae2=GB(21)
ui=GB(22)
tx=TN(bb2d(2),2)
ty=TN(bb2d(11),2)
w=mF(GN(32)/10)*32
h=mF(GN(32))%10*32
wh=w/2
hh=h/2
zoom=GN(32)%1
cps=GN(29)
dsp={GN(30)-sp[1],GN(31)-sp[2]}
sp={GN(30),GN(31),25}
for e=1,32 do
SN(e,0)
end
if#F>0 then
for e=1,#F do
F[e][5]=F[e][5]+1
if F[e][5]>PN('time out ticks')then
TR(F,e)
break 
end
end
end
fid=GN(25)
if fid~=0 then
temp={GN(26),GN(27),GN(28),fid,0}if#F>0 then
match=0
for e=1,#F do
if F[e][4]==fid then
F[e]=temp
match=1
break 
end
end
if match==0 then
TS(F,temp)
end
else TS(F,temp)
end
end
if#D>0 then
todlt=0
for e=1,#D do
curt=D[e]curt.l=curt.l+1
lifemax=M.max(lifemax,curt.l)if#curt.b>32 then
TR(curt.b,1)
TR(curt.w,1)
end
if curt.l>PN('time out ticks')then
todlt=e
lifemax=0
end
end
if todlt~=0 then
TR(D,todlt)
end
end
slot0,slot1={},{}
for e=1,8 do
if slot[e][4]~=0 then
TS(slot1,e)else TS(slot0,e)
end
end
if slchanged then
existed=0
if#slot1>0 then
for e=1,#slot1 do
if slot[slot1[e]][4]==slid then
existed=1
end
end
end
if existed==0 then
if#slot0>0 then
slot[slot0[1]]={0,0,0,slid,0,0}TR(slot0,1)
end
end
end
if tx>w-17 and ty<40 and(GB(1)and not tc)and ui then
tgtt=M.max(M.min(M.ceil(ty/10),4),1)
if tx>w-9 then
tgtt=tgtt+4 
end
if sltgt~=tgtt then
sltgt=tgtt
else slot[sltgt]={0,0,0,0,0,0}
end
end
for e=1,8 do
if GN(e*3-2)~=0 and GN(e*3)>fltA then
temp={}_x,_y,_z=GN(e*3-2),GN(e*3-1),GN(e*3)temp.p={_x,_y,_z}
rangetest=mergedist+Ms(0.002*P)*Dst(sp,temp.p)
frd=0
if#F>0 then
for i=1,#F do
if Dst(F[i],temp.p)<rangetest then
frd=1
break 
end
end
end
if frd==0 then
temp.b={}TS(temp.b,{_x,_y,_z})temp.v={2,2,0}
temp.a={0.01,0.01,0}
temp.w={}
temp.va=0.01
temp.l=0
temp.id=id
temp.e=1e4
temp.m=1e4
temp.d=3
temp.c=0
temp.mc=0
if#D>0 then
match=0
for i=1,#D do
curt=D[i]if Dst(curt.p,temp.p)<rangetest+curt.l*Dst(curt.v,{0,0,0})*2 then
if curt.l>8 then
curt.p={_x,_y,_z}
for j=1,#slot1 do
if slot[slot1[j]][4]==curt.id then
_=slot[slot1[j]][6]slot[slot1[j]]={_x,_y,_z,curt.id,0,_}
end
end
_=curt.b
curt.v={(curt.p[1]-_[#_][1])/curt.l,(curt.p[2]-_[#_][2])/curt.l,(curt.p[3]-_[#_][3])/curt.l}TS(_,curt.p)
_=curt.w
TS(_,curt.v)if#_>3 then
_x,_y,_z=0,0,0
for k=#_,#_-3,-1 do
_x=_x+_[k][1]_y=_y+_[k][2]_z=_z+_[k][3]end
curt.a={_x/4,_y/4,_z/4}
curt.va=Dst({_x/4,_y/4,_z/4},{0,0,0})
end
curt.l=0
end
match=1
break 
end
end
if match==0 then
TS(D,temp)
id=id+1 
end
else TS(D,temp)
id=id+1 
end
end
end
end
Dd={{},{}}if#D>0 then
for e=1,#D do
curt=D[e]if curt.va>0.3 then
for i=1,3 do
curt.g[i]=curt.p[i]+curt.a[i]*curt.l 
end
else _=curt.b
if#_>3 then
_x,_y,_z=0,0,0
for i=#_,#_-3,-1 do
_x=_x+_[i][1]_y=_y+_[i][2]_z=_z+_[i][3]end
curt.g={_x/4,_y/4,_z/4}
else curt.g=curt.p
end
end
x0,y0=curt.p[1]-sp[1],curt.p[2]-sp[2]vx,vy=curt.a[1]-dsp[1],curt.a[2]-dsp[2]curt.c=(1.25-M.atan(vy,vx)/P)%1*360
curt.e=-(x0*vx+y0*vy)/(vx^2+vy^2+curt.a[3]^2)curt.m=M.abs(x0*vy-y0*vx)/Mr(vx^2+vy^2)
if curt.e<0 then
curt.e=5940
if curt.d<3 then
curt.mc=curt.mc+2 
end
end
if curt.m<adr*3 and curt.e<d2t and curt.va>1 then
if curt.m<adr and curt.e<d1t then
if curt.d>1 then
curt.mc=curt.mc-1 
end
else 
if curt.d>2 then
curt.mc=curt.mc-1 
elseif curt.d<2 then
curt.mc=curt.mc+1 
end
end
end
dtgt=Dst(curt.p,sp)
if dtgt<PN('Level up distance')and curt.d>1 then
curt.mc=curt.mc-0.5 
elseif dtgt>PN('Level down distance')and curt.d<3 then
curt.mc=curt.mc+0.5 
end
if curt.mc>dlsw and curt.d<3 then
curt.d=curt.d+1
curt.mc=0
elseif curt.mc<-dlsw and curt.d>1 then
curt.d=curt.d-1
curt.mc=0
end
if curt.d<3 then
TS(Dd[curt.d],curt)
end
end
end
Dall={}
for e=1,2 do
if#Dd[e]>0 then
TT(Dd[e],Sorteta)
for i=1,#Dd[e]do
TS(Dall,Dd[e][i])
end
end
end
out={0,0,0,0,0}
outdm=1
if ae1 then
outdm=2
end
if ae2 then
outdm=3
end
for e=4,8 do
if slot[e][4]~=0 then
slot[e][5]=slot[e][5]+1
slot[e][6]=slot[e][6]+1
if slot[e][5]>90 then
slot[e]={0,0,0,0,0,0}
end
end
end
for e=1,5 do
if Dall[e]then
if Dall[e].g then
out[e]=Dall[e].id
SN(4*e+8,Dall[e].id+Dall[e].d/10)
for i=1,3 do
SN(4+e*4+i,Dall[e].g[i])
end
if Dall[e].d<outdm then
merged=false
for i=8,5,-1 do
if slot[i][4]==Dall[e].id then
merged=true
_=slot[i][6]slot[i]={Dall[e].g[1],Dall[e].g[2],Dall[e].g[3],Dall[e].id,0,_}
break 
end
end
if not merged then
for i=8,5,-1 do
if slot[i][1]==0 then
slot[i]={Dall[e].g[1],Dall[e].g[2],Dall[e].g[3],Dall[e].id,0,0}table.insert(fireplan,{i,10})
break 
end
end
end
end
end
end
end
if outdm>1 then
for e=4,8 do
if slot[e][4]~=0 then
for i=1,#D do
if D[i].id==slot[e][4]then
if D[i].d<outdm then
slot[e][6]=slot[e][6]+1-D[i].e/900
if slot[e][6]>PN('Fire wait')then
slot[e][6]=0
table.insert(fireplan,{e,10})
end
else slot[e]={0,0,0,0,0,0}
end
break 
end
end
end
end
end
SB(1,false)if#fireplan>0 then
fireplan[1][2]=fireplan[1][2]-1
sltgt=fireplan[1][1]SB(1,fireplan[1][2]==3)
if fireplan[1][2]==0 then
TR(fireplan,1)
end
end
cur=cur+1
if cur>8 then
cur=1
end
for e=1,3 do
SN(e,slot[cur][e])
end
SN(7,cur)
SN(8,sltgt)
SN(30,slot[sltgt][1])
SN(31,slot[sltgt][2])
SN(32,slot[sltgt][3])
tc=GB(1)
if tc then
lifemax=0
end
end
S=screen
SC=S.setColor
DL=S.drawLine
DRF=S.drawRectF
DR=S.drawRect
str=string
SF=str.format
function DV(x,y,l)
local _=-3
if l<30 then
_=3
end
DL(x,y,x-3,y+_)
DL(x,y,x+3,y+_)
end
num={1121112,2212122,1222122,1221212,1222221,2222221,1121122,2222222,1222222}num[0]=2122222
function N(x,y,m)
m=tostring(m)
local n=str.len(m)
for e=1,n do
local o=m:sub(e,e)
local p=TN(o)
local q=4
if p then
local q=3
local r,s,t,u=x,y+4,0,0
for i=1,7 do
r,s=r+t*2,s-u*2
if i==5 then
s=s-2 
end
t,u=Ms(0.25*P*(i-1)),Mc(0.25*P*(i-1))
if str.sub(num[p],i,i)=='2'then
DL(r,s,r+t*3,s-u*3)
end
end
else S.drawText(x,y,o)
end
x=x+q 
end
end

function G2XY(v)
local t,u=v[1]-sp[1],v[2]-sp[2]local z=Mr(t^2+u^2)
local c=M.atan(u,t)+(0.25-cps)*P
local x,y=wh+zoom*z*Ms(c),hh+zoom*z*Mc(c)
return mF(x+0.5),mF(y+0.5)
end

function onDraw()
SC(24,64,222)if#F>0 then
for e=1,#F do
x,y=G2XY(F[e])
DV(x,y,F[e][3])
end
end
slchanged=false
if#D>0 then
for e=1,#D do
curt=D[e]if curt.va>0.2 and#curt.b>1 then
_=0
for i=#curt.b,1,-1 do
if i-1>0 and _<32 then
SC(222,222,222,32-1*_)x1,y1=G2XY(curt.b[i])x2,y2=G2XY(curt.b[i-1])
DL(x1,y1,x2,y2)
_=_+1 else 
break 
end
end
end
x,y=G2XY(curt.g)
if tc and Ma(tx-x)<3 and Ma(ty-y)<3 and slid~=curt.id then
slid=curt.id
slchanged=true
end
_=240-80*curt.d
if curt.d<2 and curt.e>0 then
if curt.e<5940 then
x1,y1=G2XY({curt.p[1]+curt.e*curt.a[1],curt.p[2]+curt.e*curt.a[2],0})
SC(_,_,_)
DL(x,y,x1,y1)
end
SC(8,8,8)
DRF(x-6,y-2,13,5)
SC(_,curt.d*64-32,32)
msg=SF('%0.0f',curt.e/60)
N(x+4,y-2,msg)
end
SC(_,curt.d*64-32,32)
for i=1,5 do
if curt.id==out[i]then
N(x-6,y-2,i)
end
end
DV(x,y,curt.p[3])
if curt.id==slid and ui then
DV(x,y+1,curt.p[3])
SC(8,8,8)
_=w-20
DRF(_-2,h-25,32,32)
SC(64,64,64)
DR(_-2,h-25,32,32)
N(_,h-23,'d'..SF('%4.1f',Dst(sp,curt.p)/1e3))
fmt='%4.0f'N(_,h-17,'v'..SF(fmt,curt.va*60))
N(_,h-11,'a'..SF(fmt,curt.p[3]))
N(_,h-5,'b'..SF(fmt,curt.c))
end
end
end
if tc and tx>w-20 and ty>h-25 and ui then
slid=0
end
if ui then
for e=1,8 do
if e<5 then
dcx=w-17
dcy=(e-1)*10 else dcx=w-8
dcy=(e-5)*10 
end
if slot[e][4]~=0 then
SC(64,64,64)dcx1,dcy1=G2XY(slot[e])
if e==sltgt then
SC(128,128,128)else SC(128,128,128,128)
end
N(dcx1-2,dcy1+3,name[e])else SC(16,16,16)
end
if e==sltgt then
DRF(dcx,dcy,8,9)
SC(8,8,8)else DR(dcx,dcy,7,8)
end
N(dcx+2,dcy+2,name[e])
end
end
SC(24,222,24)
DV(wh,hh-1,0)end