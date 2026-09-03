-- source: steam id 3793369421 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793369421

iN=input.getNumber
m=math
tau=math.pi*2
oldX,oldY,oldZ=0,0,0
oldVX,oldVY,oldVZ=0,0,0
oldGLX=0
oldGLY=0
outerRadius=12.5
smoothing=1/math.max((property.getNumber("Ball Damping")+0.05)*20,1)
turnSmoothing=1/math.max((property.getNumber("Turn Rate Indicator Damping")+0.2)*5,1)
turnInd=0
ballPos=0
arcAngle=1.5
arcPolyCount=20

arc={}
for a=1,arcPolyCount+1 do
arc[a]={}
local b=-((a-1)*arcAngle/arcPolyCount-arcAngle/2)arc[a][1]=math.sin(b)*13+15.5
arc[a][2]=math.cos(b)*13+9.5+1
arc[a][3]=math.sin(b)*16.1+15.5-.1
arc[a][4]=math.cos(b)*16.1+9.5+1 
end
mx1=math.cos(.35)*11+15.5
my1=math.sin(.35)*11+15.5
mx2=math.cos(.35)*14+15.5
my2=math.sin(.35)*14+15.5
mx3=math.cos(math.pi-.35)*11+15.5
my3=math.sin(math.pi-.35)*11+15.5
mx4=math.cos(math.pi-.35)*14+15.5
my4=math.sin(math.pi-.35)*14+15.5

function onTick()

pX,pY,pZ=iN(1),iN(2),iN(3)
x,y,z=iN(4),iN(5),iN(6)
vL,vUp,vFwd=-iN(7),iN(8),iN(9)
ax,ay,az=iN(10),iN(11),iN(12)
cx,sx=m.cos(x),m.sin(x)cy,sy=m.cos(y),m.sin(y)cz,sz=m.cos(z),m.sin(z)
m00=cy*cz
m01=-cx*sz+sx*sy*cz
m02=sx*sz+cx*sy*cz
m10=cy*sz
m11=cx*cz+sx*sy*sz
m12=-sx*cz+cx*sy*sz
m20=-sy
m21=sx*cy
m22=cx*cy
angSpeedUp=m01*ax+m11*ay+m21*az
rollLeft=-m.atan(m10,m.sqrt(m00*m00+m20*m20))
rollUp=m.atan(m11,m.sqrt(m01*m01+m21*m21))
pitch=m.atan(m12,m.sqrt(m02*m02+m22*m22))
roll=math.atan(rollLeft,rollUp)

vX=(pX-oldX)*60
vY=(pY-oldY)*60
vZ=(pZ-oldZ)*60
dX=(vX-oldVX)*60
dY=(vY-oldVY)*60
dZ=(vZ-oldVZ)*60

gLoadX=m00*dX+m10*dY+m20*dZ
gLoadY=m01*dX+m11*dY+m21*dZ

avgGLX=(gLoadX+oldGLX)*.5
avgGLY=(gLoadY+oldGLY)*.5

oldGLX=gLoadX
oldGLY=gLoadY
oldX,oldY,oldZ=pX,pY,pZ
oldVX,oldVY,oldVZ=vX,vY,vZ

ballGx=math.sin(roll)*m.abs(m.cos(pitch))*9.81
ballGy=math.cos(roll)*m.abs(m.cos(pitch))*9.81
ballAngle=math.atan(ballGx-avgGLX,ballGy+avgGLY)

if math.abs(ballAngle)>2.48 then
if not frozen then
ballAngleFreeze=ballAngle
frozen=true
end
else 
frozen=false
end
ballAngle=frozen and ballAngleFreeze or ballAngle

ballPos=math.min(math.max(ballPos+smoothing*math.min(math.max(ballAngle-ballPos,-smoothing*30),smoothing*30),-.67),.67)
ballPos=ballPos==ballPos and ballPos or 0

turnInd=math.min(math.max(turnInd+turnSmoothing*(angSpeedUp*120*0.35-turnInd),-.61),.61)
turnInd=turnInd==turnInd and turnInd or 0
wx1=math.cos(turnInd)*11+15.5
wy1=math.sin(turnInd)*11+16
wx2=-math.cos(turnInd)*11+15.5
wy2=-math.sin(turnInd)*11+16
vx1=math.cos(turnInd-math.pi/2)*8+15.5
vy1=math.sin(turnInd-math.pi/2)*8+15.5 
end

--Bassalicious
function onDraw()

screen.setColor(2,3,4)
screen.drawRectF(-1,-1,34,34)
screen.setColor(1,2,3)
screen.drawCircleF(15.5,15.5,15)
screen.setColor(9,10,11)
screen.drawCircleF(1.5,1.5,2)
screen.drawCircleF(29.5,1.5,2)
screen.drawCircleF(1.5,29.5,2)
screen.drawCircleF(29.5,29.5,2)
screen.setColor(40,40,40)
screen.drawLine(mx1,my1,mx2,my2)
screen.drawLine(mx3,my3,mx4,my4)
screen.drawLine(2,15.5,4,15.5)
screen.drawLine(28,15.5,30,15.5)
screen.setColor(38,37,32)
for a=1,arcPolyCount do
screen.drawTriangleF(arc[a][1],arc[a][2],arc[a][3],arc[a][4],arc[a+1][1],arc[a+1][2])
screen.drawTriangleF(arc[a][3],arc[a][4],arc[a+1][1],arc[a+1][2],arc[a+1][3],arc[a+1][4])
end
screen.setColor(5,6,7)
screen.drawCircleF(math.sin(ballPos)*14.5+15.5,math.cos(ballPos)*14.6+9.5,1.6)
screen.setColor(1,2,3)
screen.drawLine(14.5,23,14.5,26)
screen.drawLine(17.5,23,17.5,26)
screen.setColor(5,6,7)
for a=1,10 do
screen.drawCircle(15.5,15.5,14.5+a/5)
end
screen.setColor(40,40,40)
screen.drawCircleF(15.5,15.5,3)
screen.drawLine(wx1,wy1,wx2,wy2)
screen.drawLine(vx1,vy1,15.5,15.5)
end