-- source: steam id 3097129660 / vehicle.xml block#22
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
w,h=96,96
t1,t2,t3,t4={},{},{},{}
Ao=0
GN=input.getNumber
GB=input.getBool
SF=string.format
M=math
P=2*M.pi
Ma=M.atan
Mas=M.asin
Mb=M.abs
O=M.cos
Mf=M.floor
I=M.sin
Mr=M.sqrt
Mx=M.max
S=screen
SC=S.setColor
function C(x)
if x==1 then SC(22,222,22) elseif x==0 then SC(0,0,0) else SC(22,222,22,128) end end
DC=S.drawCircle
DL=S.drawLine
DT=S.drawText
DTB=S.drawTextBox
DR=S.drawRect
DRF=S.drawRectF
D3F=S.drawTriangleF
function B(x,y,a,l)
S.drawLine(x,y,x+l*I(0.01*a*P),y-l*O(0.01*a*P))
end
function DN(x,y,s)
x=Mf(x) y=Mf(y)
s=tostring(s) 
local l=string.len(s)
for i=1,l do
local n,w=s:sub(i,i),4
if n=="1"then B(x+2,y,50,5)
elseif n=="2"then B(x,y,25,2) B(x+2,y,50,2) B(x+2,y+2,75,2) B(x,y+2,50,2) B(x,y+4,25,3)
elseif n=="3"then B(x,y,25,2) B(x+2,y,50,5) B(x+1,y+2,75,1) B(x+1,y+4,75,2)
elseif n=="4"then B(x,y,50,2) B(x,y+2,25,2) B(x+2,y,50,5)
elseif n=="5"then B(x,y,25,3) B(x,y+1,50,2) B(x+1,y+2,25,2) B(x+2,y+3,50,2) B(x,y+4,25,2)
elseif n=="6"then DR(x,y+2,2,2)	B(x+1,y,25,2) B(x,y,50,2)
elseif n=="7"then B(x,y,25,3) B(x+2,y+1,50,4)
elseif n=="8"then DR(x,y,2,4) B(x+1,y+2,25,1)
elseif n=="9"then DR(x,y,2,2) B(x+2,y+3,50,2) B(x,y+4,25,2)
elseif n==","then B(x,y+4,0,2) w=2
elseif n=="."then B(x,y+4,25,1) w=2
elseif n=="+"then B(x,y+2,25,3) B(x+1,y+1,50,1) B(x+1,y+3,50,1)
elseif n=="-"then B(x,y+2,25,3)
elseif n=='0'then DR(x,y,2,4)
elseif n==" "then
else DT(x,y,n) w=5 end x=x+w end end
function psa(x,y,z)
local a,b,c=Mas(O(x)*I(z)*I(y)-I(x)*O(z))/P,-Mas(I(z)*O(y))/P,-Ma(O(x)*O(z)*I(y)+I(x)*I(z),O(x)*O(y))/P
return a,b,c end
function Av(n,v,t)
table.insert(n,v)
local s=0
if #n>t then for i=1,#n-t do table.remove(n,1) end end
for i=1,#n do s=s+n[i] end return s/#n end
fov=1.1125
function onTick()
ppt=540
A=Av(t1,GN(2),30)
dA=(A-Ao)*62
Ao=A
p,r,c=GN(15),-GN(16),-GN(17)
if c<0 then c=1+c end
vx,vy,vz=Av(t2,GN(7),15),Av(t3,GN(8),15),Av(t4,Mx(GN(9),0),15)
vz2=vz*3.6
r2=GN(24)
X=Mf(h*0.5*GN(21)/fov+0.5)
Y=Mf(h*(-1.38*GN(22)-0.0439)/fov+0.5)
if r2<0 then r=0.5-r end
sb=GN(26)~=7
end
function onDraw()
C(1)
u=20
x,y=2+X,48+Y
for i=Mf(vz2)-9*u,Mf(vz2)+10*u do
if i>0 then
if i%20==0 then B(x,y-3*(i-vz2)/u,25,2) end
if i%100==0 then DN(x+3,y-3*(i-vz2)/u,SF('%-3.0f',i)) end
end end
u=10
x,y=w-2+X,48+Y
for i=Mf(A)-9*u,Mf(A)+10*u do
if i>0 then if i%10==0 then B(x,y-3*(i-A)/u,75,2) end
if i%50==0 then DN(x-21,y-3*(i-A)/u,SF('%5.0f',i)) end
end end
x,y=w/2+X,2+Y
for i=Mf(c*360)-15,Mf(c*360)+15 do
if i<0 then fi=360+i else fi=i end
if i%5==0 then B(x+1.6*(i-c*360),y,50,2) end
if i%10==0 then DN(x+1.6*(i-c*360)-3,y+3,SF('%02.0f',fi/10)) end
end
x,y=w/2+X,h/2+Y
for i=-2,2 do
o=(i*0.04+0.5)*P
x0=x+42*I(o)
y0=y-42*O(o)
x1=x+46*I(o)
y1=y-46*O(o)
DL(x0,y0,x1,y1)
end
o=(-vx/30*0.04+0.5)*P
x2=x+43*I(o)
y2=y-43*O(o)
x3=x+47*I(o+0.06)
y3=y-47*O(o+0.06)
x4=x+47*I(o-0.06)
y4=y-47*O(o-0.06)
D3F(x2,y2,x3,y3,x4,y4)
x,y=w/2+X,h/2+Y
C(3)
for i=Mf(p*360)-22,Mf(p*360)+22 do
if i<0 then o=0 else o=50 end
x0=x+1.4*(i-p*360)*I(-r*P)
y0=y-1.4*(i-p*360)*O(-r*P)
if i%15==0 and i~=0 and Mb(i)<91 then
x1=x0+16*I((0.75-r)*P)
y1=y0-16*O((0.75-r)*P)
x2=x0+16*I((0.25-r)*P)
y2=y0-16*O((0.25-r)*P)
B(x1,y1,25-100*r,5)
B(x1,y1,o-100*r,2)
B(x2,y2,75-100*r,5)
B(x2,y2,o-100*r,2)
elseif i==0 then
x1=x0+5*I((0.75-r)*P)
y1=y0-5*O((0.75-r)*P)
x2=x0+5*I((0.25-r)*P)
y2=y0-5*O((0.25-r)*P)
B(x1,y1,75-100*r,22)
B(x2,y2,25-100*r,22)
end
end
C(1)
if vz>10 and sb then
x=Mf(w/2+Ma(vx,vz)/P*ppt)+X
y=Mf(h/2-Ma(vy,vz)/P*ppt)+Y
B(x-1,y-2,25,3)
B(x-1,y+2,25,3)
B(x-2,y-1,50,3)
B(x+2,y-1,50,3)
B(x-3,y,75,2)
B(x+3,y,25,2)end
if vz>10 then aoa=Mr(Ma(vx,vz)^2+Ma(vy,vz)^2)*360/P else aoa=0 end
x=1+X y=3+Y
B(x,y+2,50,2)
B(x+1,y+1,25,2)
B(x+1,y+4,25,2)
B(x+3,y+2,12,3)
B(x+3,y+3,37,3)
DN(x+6,y,SF('%.1f',aoa))
x=w-4+X y=h/2+M.min(Mx(-2*dA,-25),25)+Y
C(0)
DRF(x-15,y-1,16,7)
C(1)
DN(x-14,y,SF('%+3.0f',Mx(M.min(dA,99),-99))..'>')
x,y=X,44+Y
C(0)
DRF(x,y,19,11)
C(1)
DR(x-5,y+1,22,8)
DN(x+1,y+3,SF('%4.0f',vz2))
x,y=w-20+X,44+Y
C(0)
DRF(x,y,21,11)
C(1)
DR(x+1,y+1,24,8)
DN(x+3,y+3,SF('%4.0f',A))
x,y=w/2-9+X,2+Y
C(0)
DRF(x,y,18,11)
C(1)
DR(x+1,y+1,15,8)
DN(x+3,y+3,SF('%03.0f',c*360))
end