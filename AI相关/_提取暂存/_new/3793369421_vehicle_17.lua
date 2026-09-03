-- source: steam id 3793369421 / vehicle.xml block#17
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793369421
tau=math.pi*2
s=screen
m=math

function lerp(x,a,b)
return (x-a)/(b-a)
end

cX=15.5
cY=15.5

outerRadius=12.5

dX1=0
dY1=0
dX2=0
dY2=0
dX3=0
dY3=0
dX4=0
dY4=0
dX5=0
dY5=0

max=property.getNumber("Needle Stop")

minAngle=m.pi+0.3
maxAngle=m.pi-0.3
centerAngle=m.pi*1.5
deltaAngle=m.pi-(-maxAngle+minAngle)/2
markDelta=max/4
offset=-3


lines={}
lineCount=14

for i=0,lineCount do
lines[i+1]={{},{},{},{}}
if i==12 then
markDelta=max/4
offset=3
elseif i==3 then
markDelta=max/8
offset=0
end
local j=(i-7-offset)*markDelta
local lineAngle=(j/max)*-deltaAngle+centerAngle
lines[i+1][1][1]=m.sin(lineAngle)*15.5+cX
lines[i+1][1][2]=m.cos(lineAngle)*15.5+cY--0.2
local lineAngle=lineAngle+m.pi
if i==4 or i==6 or i==8 or i==10 then
deltaRadius=3.8
elseif i==0 or i==14 then
deltaRadius=8
elseif i==7 then
deltaRadius=9
else
deltaRadius=7
end
lines[i+1][2][1]=m.sin(lineAngle)*deltaRadius+lines[i+1][1][1]
lines[i+1][2][2]=m.cos(lineAngle)*deltaRadius+lines[i+1][1][2]
end




function onTick()
fpm = input.getNumber(1)*property.getNumber("Units")*3600

dAngle=(m.min(m.max(fpm,-max),max)/max)*-deltaAngle-m.pi/2
cY=cY+1
cX=cX-.1
dX1=m.sin(dAngle)*13+cX
dY1=m.cos(dAngle)*13+cY
dX2=m.sin(dAngle+.1)*8+cX
dY2=m.cos(dAngle+.1)*8+cY
dX3=m.sin(dAngle-.1)*8+cX
dY3=m.cos(dAngle-.1)*8+cY
dX4=m.sin(dAngle+.6)+cX
dY4=m.cos(dAngle+.6)+cY
dX5=m.sin(dAngle-.6)+cX
dY5=m.cos(dAngle-.6)+cY
cY=cY-1
cX=cX+.1


end
--Bassalicious
function onDraw()
screen.setColor(2,3,4)
screen.drawRectF(-1,-1,34,34)
screen.setColor(1,2,3)
screen.drawCircleF(cX,cY,15)

s.setColor(9,10,11)
s.drawCircleF(1.5,1.5,2)
s.drawCircleF(29.5,1.5,2)
s.drawCircleF(1.5,29.5,2)
s.drawCircleF(29.5,29.5,2)


s.setColor(40,40,40)
for i in ipairs(lines) do
s.drawLine(lines[i][1][1],lines[i][1][2],lines[i][2][1],lines[i][2][2])
end

s.drawTriangleF(dX1,dY1,dX2,dY2,dX3,dY3)
s.drawTriangleF(dX2,dY2,dX3,dY3,dX4,dY4)
s.drawTriangleF(dX3,dY3,dX4,dY4,dX5,dY5)
s.setColor(9,10,11)
s.drawCircleF(cX,cY,2.1)

s.setColor(5,6,7)
for i=1,10 do
s.drawCircle(cX,cY,outerRadius+2+(i/5))
end

end