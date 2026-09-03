-- source: steam id 2885633937 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2885633937
igN = input.getNumber
igB = input.getBool
ssC=screen.setColor
sdL=screen.drawLine
sdC = screen.drawCircle
sdR = screen.drawRect
sdTF = screen.drawTriangleF
sdRF= screen.drawRectF
sdCF = screen.drawCircleF
sdT=screen.drawText
stf = string.format
sts = string.sub
sin,cos = math.sin,math.cos
pi = 3.141592
dtr=pi/180
function zero(x,y)
sdR(x,y,2,4)
end
function one(x,y)
sdL(x+2,y,x+2,y+5)
end
function two(x,y)
sdL(x,y,x+3,y)
sdL(x,y+2,x+3,y+2)
sdL(x,y+4,x+3,y+4)
sdL(x+2,y,x+2,y+2)
sdL(x,y+2,x,y+4)
end
function three(x,y)
sdL(x,y,x+3,y)
sdL(x,y+2,x+3,y+2)
sdL(x,y+4,x+3,y+4)
sdL(x+2,y,x+2,y+4)
end
function four(x,y)
sdL(x,y+2,x+3,y+2)
sdL(x+2,y,x+2,y+5)
sdL(x,y,x,y+2)
end
function five(x,y)
sdL(x,y,x+3,y)
sdL(x,y+2,x+3,y+2)
sdL(x,y+4,x+3,y+4)
sdL(x,y,x,y+2)
sdL(x+2,y+2,x+2,y+4)
end
function six(x,y)
sdR(x,y+2,2,2)
sdL(x,y,x+3,y)
sdL(x,y,x,y+2)
end
function seven(x,y)
sdL(x,y,x+3,y)
sdL(x+2,y,x+2,y+5)
end
function eight(x,y)
sdR(x,y,2,4)
sdL(x,y+2,x+3,y+2)
end
function nine(x,y)
sdR(x,y,2,2)
sdL(x+2,y,x+2,y+5)
sdL(x,y+4,x+3,y+4)
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
function SG(x,y,t)
if t>0 then sdT(x,y,math.floor(t))
else sdT(x,y,"N")
end
end
Dist = 0
function onTick()
sps,fue,bat,ent,rps,gear,fum=igN(5),igN(6),igN(7),igN(8),igN(9),igN(16),igN(17)
park,rev,mode = igB(9),igB(10),igB(16)
sph=sps*3.6
Dist=Dist+sps/60000
Distk=math.floor(Dist)
Distm=math.floor((Dist-math.floor(Dist))*10)
asph=sph/200
aent=ent/110
arps=rps/30
afue=fue/fum
if asph>1 then
asph=1-math.random()*0.05
end
if aent>1 then
aent=1-math.random()*0.05
end
if arps>1 then 
arps=1-math.random()*0.05
end
end
function onDraw()
w,h,wh,hh=96,32,48,16
ssC(0,0,0,77)
--RPM
sdL(wh+17-9*cos(dtr*(0+150*arps)),22-9*sin(dtr*(0+150*arps)),wh+17,22)
--Speed
sdL(wh-17-9*cos(dtr*(0+150*asph)),22-9*sin(dtr*(0+150*asph)),wh-17,22)
--Temp
sdL(wh-9*cos(dtr*(190-90*aent)),14-9*sin(dtr*(190-90*aent)),wh-5*cos(dtr*(190-90*aent)),14-5*sin(dtr*(190-90*aent)))
--Fuel
sdL(wh-9*cos(dtr*(80-90*afue)),14-9*sin(dtr*(80-90*afue)),wh-5*cos(dtr*(80-90*afue)),14-5*sin(dtr*(80-90*afue)))
ssC(225,5,15)
--RPM
sdL(wh+17-9*cos(dtr*(0+150*arps)),21-9*sin(dtr*(0+150*arps)),wh+17,21)
--Speed
sdL(wh-17-9*cos(dtr*(0+150*asph)),21-9*sin(dtr*(0+150*asph)),wh-17,21)
--Temp
sdL(wh-9*cos(dtr*(190-90*aent)),13-9*sin(dtr*(190-90*aent)),wh-5*cos(dtr*(190-90*aent)),13-5*sin(dtr*(190-90*aent)))
--Fuel
sdL(wh-9*cos(dtr*(80-90*afue)),13-9*sin(dtr*(80-90*afue)),wh-5*cos(dtr*(80-90*afue)),13-5*sin(dtr*(80-90*afue)))
ssC(4,4,4)
sdRF(wh-21,20,16,7)
sdRF(wh+9,20,17,7)
sdRF(w-19,0,19,7)
ssC(1,1,1)
sdR(wh-21,20,15,0.1)
sdR(wh-21,20,0.1,6)
sdR(wh+9,20,16,0.1)
sdR(wh+9,20,0.1,6)
sdR(w-19,0,18,0.1)
sdR(w-19,0,0.1,6)
ssC(8,8,8)
dsN(w-18,1,stf("%3.0f", 888))
dsN(w-4,1,stf("%1.0f", 8))
dsN(wh-20,21,stf("%3.0f", 888))
dsN(wh+10,21,stf("%2.0f", 8888))
ssC(33,111,255)
sdL(w-6, 5,w-5,6)
dsN(w-18,1,stf("%3.0f", Distk))
dsN(w-4,1,stf("%1.0f", Distm))
dsN(wh-20,21,stf("%3.0f", sph))
dsN(wh+10,21,stf("%4.0f", math.floor(rps*1.2)*50))
cgw=w-14
cgh=9
if park then 
ssC(4,4,4)
sdT(cgw,cgh+1,"P")
SG(cgw+6,cgh+1,gear)
ssC(225,5,15)
sdT(cgw,cgh,"P")
SG(cgw+6,cgh,gear)
elseif rev then 
ssC(4,4,4)
sdT(cgw,cgh+1,"R")
SG(cgw+6,cgh+1,gear)
ssC(225,5,15)
sdT(cgw,cgh,"R")
SG(cgw+6,cgh,gear)
elseif mode then 
ssC(4,4,4)
sdT(cgw,cgh+1,"S")
SG(cgw+6,cgh+1,gear)
ssC(33,255,111)
sdT(cgw,cgh,"S")
SG(cgw+6,cgh,gear)
else 
ssC(4,4,4)
sdT(cgw,cgh+1,"D")
SG(cgw+6,cgh+1,gear)
ssC(33,111,255)
sdT(cgw,cgh,"D")
SG(cgw+6,cgh,gear)
end
end