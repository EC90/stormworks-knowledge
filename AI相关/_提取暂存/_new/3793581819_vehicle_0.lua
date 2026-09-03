-- source: steam id 3793581819 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819

i=input
igB=i.getBool
igN=i.getNumber
s=screen
sc=s.setColor
dl=s.drawLine
dr=s.drawRect
drf=s.drawRectF
dtf=s.drawTriangleF
dtx=s.drawText
dtxb=s.drawTextBox
range=property.getNumber('Default Radar Range'
)
maxRange=property.getNumber('Max Radar Range'
)
tickU=0
tickD=0
menu=false
function inRect(a,b,c,d,e,f)
return a>=c and b>=d and a<c+e and b<d+f 
end

function drawArc(...)
local a,b,g,h,j,k,l=...h=h
or 0
j=j
or 360
l=l
or 22.5
if j<h then
j,h=h,j 
end
local m,n,o,p,q,r=false,0,0,0,0,0
repeat m=m
and math.min(m+l,j)or h
r=(m-90)*math.pi/180
n,o=a+g*math.cos(r),b+g*math.sin(r)
if m~=h then
if k then
s.drawTriangleF(a,b,p,q,n,o)else dl(p,q,n,o)
end
end
p,q=n,o until m>=j 
end

function onTick()
untoggle=igB(9)
touch=igB(10)
north=igB(12)
rangeRings=igB(13)
directionLines=igB(14)
mapOn=igB(17)and north
mapDark=igB(18)
inputX=igN(1)
inputY=igN(2)
headingD=(1-igN(4))*360%360
speed=igN(5)*1.94384
rot=math.max(math.min(igN(6)*360,999),-99)
gpsX=igN(7)
gpsXalt=gpsX+548*range
gpsY=igN(8)
vX=igN(26)
vY=igN(27)
up=touch
and inRect(inputX,inputY,55,1,7,7)
down=touch
and inRect(inputX,inputY,55,56,7,7)
rings=range/2-1
zoom=3.097*range
if vX>0 and vY>0 then
vD=0
elseif vY<0 then
vD=180
elseif vX<0 and vY>0 then
vD=360
end
if vX==0 and vY>0 then
track=0
elseif vX==0 and vY<0 then
track=180
elseif vX>0 and vY==0 then
track=90
elseif vX<0 and vY==0 then
track=270
elseif vX~=0 and vY~=0 then
track=vD+math.deg(math.atan(vX/vY))
end
if north then
mode='North'
else mode='Head'
end
if mapDark then
r1=0
g1=4
b1=10
r2=4
g2=8
b2=14
r3=10
g3=12
b3=15
r4=18
g4=30
b4=26
r5=10
g5=14
b5=20
r6=60
g6=60
b6=60
else r1=0
g1=30
b1=35
r2=24
g2=68
b2=72
r3=90
g3=90
b3=90
r4=64
g4=85
b4=48
r5=100
g5=93
b5=41
r6=200
g6=200
b6=200
end
if untoggle then
menu=false
end
if not menu then
if up and range<maxRange then
if tickU==0 then
range=range+2 
end
tickU=tickU+1
if tickU>30 then
tickU=0
end
else tickU=0
end
if down and range>2 then
if tickD==0 then
range=range-2 
end
tickD=tickD+1
if tickD>30 then
tickD=0
end
else tickD=0
end
if touch and inRect(inputX,inputY,1,56,7,7)then
settings=true
else 
if settings then
menu=true
end
settings=false
end
end
output.setNumber(1,range)
output.setBool(1,menu)
end

function onDraw()
sc(0,4,8)
if mapOn then
s.setMapColorOcean(r1,g1,b1)
s.setMapColorShallows(r2,g2,b2)
s.setMapColorLand(r3,g3,b3)
s.setMapColorGrass(r4,g4,b4)
s.setMapColorSand(r5,g5,b5)
s.setMapColorSnow(r6,g6,g6)
s.drawMap(gpsXalt,gpsY,zoom)
drf(64,0,32,64)
if mapDark then
sc(0,20,30)else sc(0,12,18)
end
drawArc(31,32,30.9)else s.drawClear()
sc(0,0,0)
drawArc(31,33,30.9,0,360,true)
sc(0,2,4)
end
if directionLines then
dl(1,32,62,32)
dl(31,2,31,63)
dl(10,11,53,54)
dl(10,53,53,10)
end
if rangeRings then
for i=1,rings do
drawArc(31,32,30.9/(rings+1)*i)
end
end
sc(0,20,30)
dl(63,0,63,64)
if up then
sc(0,50,100)else sc(0,20,30)
end
drf(55,1,7,7)
if down then
sc(0,50,100)else sc(0,20,30)
end
drf(55,56,7,7)
if settings then
sc(0,50,100)else sc(0,20,30)
end
drf(1,56,7,7)
sc(200,200,200)
dl(56,4,61,4)
dl(58,2,58,7)
dl(56,59,61,59)
dr(3,58,2,2)
dl(2,59,3,59)
dl(4,57,5,57)
dl(6,59,7,59)
dl(4,61,5,61)
dtx(65,1,"ROT"
)
dtx(65,7,'HDG'
)
dtx(65,13,'TRK'
)
dtx(65,19,'SPD'
)
dtx(65,26,"X-Coor"
)
dtx(65,39,"Y-Coor"
)
dtx(65,52,"Mode"
)
sc(0,200,0)
dtxb(81,0,15,7,string.format("%.0f"
,rot),0,0)
dtxb(81,6,15,7,string.format("%.0f"
,headingD),0,0)
if vX>-0.01 and vX<0.01 and vY>-0.01 and vY<0.01 then
dtx(81,13,"N/A"
)else dtxb(81,12,15,7,string.format("%.0f"
,track),0,0)
end
dtxb(81,18,15,7,string.format("%.0f"
,speed),0,0)
dtx(65,32,string.format("%.0f"
,gpsX))
dtx(65,45,string.format("%.0f"
,gpsY))
sc(0,50,100)
dtx(1,1,string.format("%.0f"
,range))
dtx(65,58,mode)
dl(1,7,1,11)
dl(3,7,3,9)
dl(2,9,4,11)
dl(5,7,5,11)
dl(6,8,7,8)
dl(7,7,7,11)end