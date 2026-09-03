-- source: steam id 3275884864 / vehicle.xml block#28
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3275884864
GN=input.getNumber
GB=input.getBool
S=screen
SC=S.setColor
DL=S.drawLine
DC=S.drawCircle
DR=S.drawRect
DTF=S.drawTriangleF
DRF= S.drawRectF
DCF=S.drawCircleF
DT=S.drawText
M=math
stf=string.format
sts=string.sub
sin,cos=M.sin,M.cos
pi=M.pi
R=pi/180
function zero(x,y)
DR(x,y,2,4)
end
function one(x,y)
DL(x+2,y,x+2,y+5)
end
function two(x,y)
DL(x,y,x+3,y)
DL(x,y+2,x+3,y+2)
DL(x,y+4,x+3,y+4)
DL(x+2,y,x+2,y+2)
DL(x,y+2,x,y+4)
end
function three(x,y)
DL(x,y,x+3,y)
DL(x,y+2,x+3,y+2)
DL(x,y+4,x+3,y+4)
DL(x+2,y,x+2,y+4)
end
function four(x,y)
DL(x,y+2,x+3,y+2)
DL(x+2,y,x+2,y+5)
DL(x,y,x,y+2)
end
function five(x,y)
DL(x,y,x+3,y)
DL(x,y+2,x+3,y+2)
DL(x,y+4,x+3,y+4)
DL(x,y,x,y+2)
DL(x+2,y+2,x+2,y+4)
end
function six(x,y)
DR(x,y+2,2,2)
DL(x,y,x+3,y)
DL(x,y,x,y+2)
end
function seven(x,y)
DL(x,y,x+3,y)
DL(x+2,y,x+2,y+5)
end
function eight(x,y)
DR(x,y,2,4)
DL(x,y+2,x+3,y+2)
end
function nine(x,y)
DR(x,y,2,2)
DL(x+2,y,x+2,y+5)
DL(x,y+4,x+3,y+4)
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
function DN(x,y,s)
s=tostring(s)
l=string.len(s)
for i=1,l do
n=s:sub(i,i)
CSN(x,y,n)
x=x+4
end
end
function SG(x,y,t)
if t>0 then DT(x,y,M.floor(t))
else DT(x,y,"N")
end
end
D=0
function onTick()
gear=GN(6)
bat=GN(8)
rps=GN(9)
sps=M.abs(GN(10))
ent=GN(11)
fue=GN(22)
fum=GN(23)
park=GB(6) and GB(7) and M.abs(sps)<1
rev=GB(4) and GB(5)
mode=false
sph=sps*3.6
D=D+sps/60000
Dk=M.floor(D)
Dm=M.floor((D-M.floor(D))*10)
asph=sph/GN(24)
aent=ent/120
arps=rps/GN(25)
afue=fue/fum
if asph>1 then
asph=1-M.random()*0.05
end
if aent>1 then
aent=1-M.random()*0.05
end
if arps>1 then 
arps=1-M.random()*0.05
end
end
function onDraw()
w,h=S.getWidth(),S.getHeight()
wh,hh=w/2,h/2
Ax,Ay,Bx,By,Cx,Cy=wh-20,20,wh,20,wh+20,20
SC(0,0,0,77)
--RPM
DL(Cx-9*cos(R*(0+150*arps)),Cy+1-9*sin(R*(0+150*arps)),Cx,Cy+1)
--Speed
DL(Ax-9*cos(R*(0+150*asph)),Ay+1-9*sin(R*(0+150*asph)),Ax,Ay+1)
--Temp
DL(Bx-9*cos(R*(190-90*aent)),By+1-9*sin(R*(190-90*aent)),Bx-5*cos(R*(190-90*aent)),By+1-5*sin(R*(190-90*aent)))
--Fuel
DL(Bx-9*cos(R*(80-90*afue)),By+1-9*sin(R*(80-90*afue)),Bx-5*cos(R*(80-90*afue)),By+1-5*sin(R*(80-90*afue)))
SC(88,99,93)
--RPM
DL(Cx-9*cos(R*(0+150*arps)),Cy-9*sin(R*(0+150*arps)),Cx,Cy)
--Speed
DL(Ax-9*cos(R*(0+150*asph)),Ay-9*sin(R*(0+150*asph)),Ax,Ay)
--Temp
DL(Bx-9*cos(R*(190-90*aent)),By-9*sin(R*(190-90*aent)),Bx-5*cos(R*(190-90*aent)),By-5*sin(R*(190-90*aent)))
--Fuel
DL(Bx-9*cos(R*(80-90*afue)),By-9*sin(R*(80-90*afue)),Bx-5*cos(R*(80-90*afue)),By-5*sin(R*(80-90*afue)))
SC(66,199,77)
--RPM
DL(Cx-8*cos(R*(0+150*arps)),Cy-8*sin(R*(0+150*arps)),Cx,Cy)
--Speed
DL(Ax-8*cos(R*(0+150*asph)),Ay-8*sin(R*(0+150*asph)),Ax,Ay)
--Temp
DL(Bx-8*cos(R*(190-90*aent)),By-8*sin(R*(190-90*aent)),Bx-5*cos(R*(190-90*aent)),By-5*sin(R*(190-90*aent)))
--Fuel
DL(Bx-8*cos(R*(80-90*afue)),By-8*sin(R*(80-90*afue)),Bx-5*cos(R*(80-90*afue)),By-5*sin(R*(80-90*afue)))
SC(4,4,4)
DRF(Ax-6,Ay,13,7)
DRF(Cx-7,Cy,16,7)
DRF(w-19,0,19,7)
SC(1,1,1)
DR(Ax-6,Ay,12,0.1)
DR(Ax-6,Ay,0.1,6)
DR(Cx-7,Cy,15,0.1)
DR(Cx-7,Cy,0.1,6)
DR(w-19,0,18,0.1)
DR(w-19,0,0.1,6)
SC(8,8,8)
DN(w-18,1,stf("%3.0f", 888))
DN(w-4,1,stf("%1.0f", 8))
DN(Ax-5,Ay+1,stf("%3.0f", 888))
DN(Cx-6,Cy+1,stf("%2.0f", 8888))
SC(144,177,155)
DL(w-6, 5,w-5,6)
DN(w-18,1,stf("%3.0f", Dk))
DN(w-4,1,stf("%1.0f", Dm))
DN(Ax-5,Ay+1,stf("%3.0f", sph))
DN(Cx-6,Cy+1,stf("%4.0f", M.floor(rps*60/50+0.5)*50))
cgw=wh-4
cgh=1
if park then 
SC(4,4,4)
DT(cgw,cgh+1,"P")
SG(cgw+6,cgh+1,gear)
SC(200,25,15)
DT(cgw,cgh,"P")
SG(cgw+6,cgh,gear)
elseif rev then 
SC(4,4,4)
DT(cgw,cgh+1,"R")
SG(cgw+6,cgh+1,gear)
SC(200,25,15)
DT(cgw,cgh,"R")
SG(cgw+6,cgh,gear)
elseif mode then 
SC(4,4,4)
DT(cgw,cgh+1,"S")
SG(cgw+6,cgh+1,gear)
SC(33,255,111)
DT(cgw,cgh,"S")
SG(cgw+6,cgh,gear)
else 
SC(4,4,4)
DT(cgw,cgh+1,"D")
SG(cgw+6,cgh+1,gear)
SC(10,180,20)
DT(cgw,cgh,"D")
SG(cgw+6,cgh,gear)
end
end