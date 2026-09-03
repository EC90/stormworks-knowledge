-- source: steam id 3242277101 / vehicle.xml block#82
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3242277101

GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
SF=string.format
T=table
TS=T.insert
M=math
Ma=M.atan
Mb=M.abs
function Mf(x)
return M.floor(x+0.5)
end
mF=M.floor
Mr=M.sqrt
Mc=M.cos
Ms=M.sin
pi=M.pi
P=pi*2
function Mp(x,a,b)
return M.max(a,M.min(x,b))
end
ppr=165
w,h=32*8,32*6
t1,t2,t3,t4={},{},{},{}
Ao=0
function Av(d,e,f)
table.insert(d,e)
local g=0
if#d>f then
for i=1,#d-f do
table.remove(d,1)
end
end
for i=1,#d do
g=g+d[i]end
return g/#d 
end

function E2R(j)
local x,y,z=j[1],j[2],j[3]return{{Mc(y)*Mc(z),Mc(x)*Mc(y)*Ms(z)+Ms(x)*Ms(y),Ms(x)*Mc(y)*Ms(z)-Mc(x)*Ms(y)},{-Ms(z),Mc(x)*Mc(z),Ms(x)*Mc(z)},{Ms(y)*Mc(z),Mc(x)*Ms(y)*Ms(z)-Ms(x)*Mc(y),Ms(x)*Ms(y)*Ms(z)+Mc(x)*Mc(y)}}
end

function tM(M)
local f={{},{},{}}
for i=1,3 do
for k=1,3 do
f[i][k]=M[k][i]end
end
return f 
end

function Mv(M,e)
local f={}
for i=1,3 do
_=0
for k=1,3 do
_=_+M[k][i]*e[k]end
f[i]=_ 
end
return f 
end

function G2AE(l)
local m=Mv(E2R(Eu),{l[1]-sp[1],l[2]-sp[2],l[3]-sp[3]})
return M.atan(m[1],m[2]),M.atan(m[3],m[2])
end

function R2G(r)
local f=Mv(tM(E2R(Eu)),{r[1]*Mc(r[3]*P)*Ms(r[2]*P),r[1]*Mc(r[3]*P)*Mc(r[2]*P),r[1]*Ms(r[3]*P)})return{f[1]+sp[1],f[2]+sp[2],f[3]+sp[3]}
end

function AE2S(n,q)
local s,t=n-lookx,q-looky
return w/2+s*ppr/Mc(s),h/2-t*ppr/Mc(t)
end

function Dst(v,D)
return Mr((v[1]-D[1])^2+(v[2]-D[2])^2+(v[3]-D[3])^2)
end

function CD(c,f)c,f=c%1,f%1
if c-f>0.5 then
f=f+1 
elseif c-f<-0.5 then
f=f-1 
end
return c-f 
end
TEnmy={}
TFrd={}
id=1
TFCS={}
lookx=0
looky=0
zi,zo=false,false
z=1
lookdst=0
ic=1
stab=false
function updEl(n,E,c,F,G)
if n~=0 then
if#G>0 then
id=F
match=0
for i=1,#G do
if G[i][4]==id then
G[i]={n,E,c,id,0}
match=1
break 
end
end
if match==0 then
TS(G,{n,E,c,id,0})
end
else TS(G,{n,E,c,id,0})
end
end
end

function lfspC(G,H)if#G>0 then
for i=1,#G do
G[i][5]=G[i][5]+1
if G[i][5]>H then
T.remove(G,i)
break 
end
end
end
end

function onTick()
sp={GN(1),GN(3),GN(2)}
Eu={GN(4),GN(6),GN(5)}
if GB(1)then
lookx=0
looky=0
end
if stab then
lookx,looky=G2AE(lookgps)
lookdst=Dst(lookgps,sp)else lookx=Mp(lookx+GN(19)*0.01/z,-P/8,P/8)
looky=Mp(looky+GN(20)*0.01/z,-P/8,P/8)
end
if GB(6)and not stab then
d0=1
for i=1,16 do
ic=i
lookgps=R2G({d0,lookx/P,looky/P})
if Mb(lookgps[3]-20)>5 then
d0=d0+(lookgps[3]-20)*16 
elseif d0>9999 then
lookgps=R2G({9999,lookx/P,looky/P})
break 
elseif d0<200 then
lookgps=R2G({200,lookx/P,looky/P})
break else 
break 
end
end
end
stab=GB(6)
A=Av(t1,GN(2),30)
dA=(A-Ao)*60
Ao=A
p,r,c=GN(15),-GN(16),-GN(17)
if c<0 then
c=1+c 
end
vx,vy,vz=Av(t2,GN(7),15),Av(t3,GN(8),15),Av(t4,M.max(GN(9),0),15)
vz2=Dst({vx,vy,vz},{0,0,0})*3.6
X,Y=AE2S(0,0)X,Y=Mf(X),Mf(Y)
ra=GN(21)
lfspC(TEnmy,120)
lfspC(TFrd,1200)
lfspC(TFCS,120)
updEl(GN(23),GN(24),GN(25),GN(22)+0.1,TEnmy)
updEl(GN(27),GN(28),GN(29),GN(22)+mF(GN(26)/1e5)/10,TEnmy)
updEl(GN(30),GN(31),GN(32),GN(22),TFrd)
updEl(GN(11),GN(12),GN(13),GN(14),TFCS)
fcssl=GN(10)
if GB(3)and not zi then
z=M.min(z*2,32)
end
zi=GB(3)
if GB(2)and not zo then
z=M.max(z*0.5,0.5)
end
zo=GB(2)
fov=(2.2-45.9/z/180*M.pi)/2.175
fovd=45.9/z
fovr=fovd/360*P
ppr=h/fovr
lookxo=lookx/(P/8)
lookyo=looky/(P/8)
SN(1,lookxo)
SN(2,lookyo)
SN(11,fov)
end
S=screen
SC=S.setColor
function C(x)
if x==1 then
SC(10,220,20)
elseif x==0 then
SC(0,0,0)
end
end
DC=S.drawCircle
DL=S.drawLine
DT=S.drawText
DTB=S.drawTextBox
DR=S.drawRect
DRF=S.drawRectF
D3F=S.drawTriangleF
function B(x,y,n,m)
S.drawLine(x,y,x+m*Ms(0.01*n*P),y-m*Mc(0.01*n*P))
end
num={1121112,2212122,1222122,1221212,1222221,2222221,1121122,2222222,1222222}num[0]=2122222
function DN(x,y,g)x,y=Mf(x),Mf(y)
g=tostring(g)
local m=string.len(g)
for i=1,m do
local d,w=g:sub(i,i),4
if d=='.'then
local w=2
end
local I=tonumber(d)
if I then
local J,K,L,N=x,y+4,0,0
for k=1,7 do
J,K=J+L*2,K-N*2
if k==5 then
K=K-2 
end
L,N=Ms(0.25*P*(k-1)),Mc(0.25*P*(k-1))
if string.sub(num[I],k,k)=='2'then
DL(J,K,J+L*3,K-N*3)
end
end
else S.drawText(x,y,d)
end
x=x+w 
end
end
drawSide=property.getBool('Side Speed Indicator')
drawboth=property.getBool('show both altitude')pdmax,pdmin=PN('Pitch Indicator Max'),PN('Pitch Indicator Min')
drawvb=PN('Vector Ball Draw Speed')
fcsname={'a','b','c','d','e','f','g','h'}
function onDraw()
w,h=S.getWidth()
,S.getHeight()
C(1)
B(X+2,Y,25,2)
B(X-2,Y,75,2)
B(X,Y+2,50,2)
B(X,Y-2,0,2)
C(1)
u=10
x,y=15,h/2
for i=Mf(vz2)-9*u,Mf(vz2)+10*u do
if i>0 then
if i%10==0 then
B(x,y-3*(i-vz2)/u,25,3)
end
if i%50==0 then
DN(x-12,y-3*(i-vz2)/u,SF('%3.0f',i))
end
end
end
x,y=w-16,h/2
for i=Mf(A)-9*u,Mf(A)+10*u do
if i>PN('Min Altitude')then
if i%10==0 then
B(x,y-3*(i-A)/u,75,3)
end
if i%50==0 then
DN(x+2,y-3*(i-A)/u,SF('%3.0f',i))
end
end
end
x,y=w/2,12
for i=Mf(c*360)-45,Mf(c*360)+45 do
if i<0 then
fi=360+i else fi=i
end
if i%5==0 then
B(x+1.6*(i-c*360),y,50,3)
end
if i%10==0 then
DN(x+1.6*(i-c*360)-3,y-6,SF('%02.0f',fi/10))
end
end
if drawSide then
x,y=w/2,h/2+48
for i=-2,2 do
o=(i*0.04+0.5)*P
x0=x+36*Ms(o)
y0=y-36*Mc(o)
x1=x+40*Ms(o)
y1=y-40*Mc(o)
DL(x0,y0,x1,y1)
end
o=(-vx/30*0.04+0.5)*P
x2=x+43*Ms(o)
y2=y-43*Mc(o)
x3=x+47*Ms(o+0.06)
y3=y-47*Mc(o+0.06)
x4=x+47*Ms(o-0.06)
y4=y-47*Mc(o-0.06)
D3F(x2,y2,x3,y3,x4,y4)
end
x,y=X,Y
dlen=32
for i=Mf(p*360)+pdmin,Mf(p*360)+pdmax do
if i<0 then
o=0
else o=50
end
x0=x+(i-p*360)*Ms(-r*P)*ppr*P/360
y0=y-(i-p*360)*Mc(-r*P)*ppr*P/360
if y0>15 and y0<32*6-15 then
if i%10==0 and i~=0 and Mb(i)<91 then
x1=x0+dlen*Ms((0.75-r)*P)
y1=y0-dlen*Mc((0.75-r)*P)
x2=x0+dlen*Ms((0.25-r)*P)
y2=y0-dlen*Mc((0.25-r)*P)
DN(x1-14,y1-2,SF('%3d',i))
DN(x2+4,y2-2,SF('%3d',i))
B(x1,y1,25-100*r,6)
B(x1,y1,o-100*r,3)
B(x2,y2,75-100*r,6)
B(x2,y2,o-100*r,3)
elseif i==0 then
x1=x0+5*Ms((0.75-r)*P)
y1=y0-5*Mc((0.75-r)*P)
x2=x0+5*Ms((0.25-r)*P)
y2=y0-5*Mc((0.25-r)*P)
B(x1,y1,75-100*r,32)
B(x2,y2,25-100*r,32)
end
end
end
if vz>drawvb then
x,y=AE2S(Ma(vx,vz),Ma(vy,vz))x,y=Mf(x),Mf(y)
aoa=Mr(Ma(vx,vz)^2+Ma(vy,vz)^2)*360/P
B(x-1,y-2,25,3)
B(x-1,y+2,25,3)
B(x-2,y-1,50,3)
B(x+2,y-1,50,3)
B(x-3,y,75,2)
B(x+3,y,25,2)else aoa=0
end
x=4
y=4
B(x,y+2,50,2)
B(x+1,y+1,25,2)
B(x+1,y+4,25,2)
B(x+3,y+2,12,3)
B(x+3,y+3,37,3)
DN(x+6,y,SF('%.1f',aoa))
x=w-16
y=h/2+M.min(M.max(-dA,-30),30)
C(0)
DRF(x-19,y-1,17,7)
C(1)
DN(x-18,y,SF('%+3.0f',Mf(dA))..'>')x,y=0,h/2-4
C(0)
DRF(x,y,21,11)
C(1)
DR(x+1,y+1,18,8)
DN(x+3,y+3,SF('%4.0f',vz2))
if drawboth then
x,y=w-21,h/2-7
C(0)
DRF(x,y,21,17)
C(1)
DR(x+1,y+1,18,14)
DN(x+3,y+3,SF('%4.0f',A))
DN(x+3,y+9,SF('%3.0f',ra)..'R')else x,y=w-21,h/2-4
C(0)
DRF(x,y,21,11)
C(1)
DR(x+1,y+1,18,8)
if ra<A and ra~=0 and ra<999 then
_=SF('%3.0f',ra)..'R'else _=SF('%4.0f',A)
end
DN(x+3,y+3,_)
end
x,y=w/2-9,1
C(0)
DRF(x,y,18,11)
C(1)
DR(x+1,y+1,15,8)
DN(x+3,y+3,SF('%03.0f',c*360))if#TEnmy>0 then
for i=1,#TEnmy do
x,y=AE2S(G2AE(TEnmy[i]))x,y=Mf(x),Mf(y)
SC(0,0,0)
DRF(x-2,y-2,4,4)
SC(222,22,22)
DR(x-2,y-2,4,4)
msg=SF('%1.1f',Dst(TEnmy[i],sp)/1000)
DN(x-6,y-8,msg)
end
end
if#TFrd>0 then
for i=1,#TFrd do
x,y=AE2S(G2AE(TFrd[i]))x,y=Mf(x),Mf(y)
SC(0,0,0)
DRF(x-2,y-2,4,4)
SC(22,99,222)
DR(x-2,y-2,4,4)
DN(x-3,y-8,SF('%2.0f',TFrd[i][4]))
end
end
if#TFCS>0 then
for i=1,#TFCS do
x,y=AE2S(G2AE(TFCS[i]))x,y=Mf(x),Mf(y)
SC(0,0,0)
DRF(x-2,y-2,4,4)
SC(22,222,22)
DT(x-2,y+4,fcsname[TFCS[i][4]])
msg=SF('%1.1f',Dst(TFCS[i],sp)/1000)
DN(x-5,y-8,msg)
DR(x-2,y-2,4,4)
if TFCS[i][4]==fcssl then
SC(222,22,22)
DR(x-3,y-3,6,6)
end
end
end
SC(22,222,22)dcx,dcy=w/2,h-10
DR(dcx-8,dcy-6,18,12)x,y=Mf(dcx+lookxo*7),Mf(dcy-lookyo*4)
DR(x-2,y-2,4,4)
if stab then
DTB(dcx-32,dcy-12,64,5,'stab'..string.format('%4.0f',M.min(lookdst,9999)),0,0)
end
end