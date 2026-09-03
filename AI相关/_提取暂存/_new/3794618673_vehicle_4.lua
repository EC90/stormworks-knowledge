-- source: steam id 3794618673 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794618673
tau=math.pi*2

spacing=property.getNumber("Line Spacing")
lines={{{},{}},{{},{}}}

--vignette
--surround
radiusSurround=13.5
outerRadius=100

cX=15.5 --center X,Y
cY=16.5

vertCount=16
vertAngle=tau/vertCount

verts={}

for i=0,vertCount+1 do
verts[i]={}
local angle=i*vertAngle
verts[i][1]=math.sin(angle)*radiusSurround+cX
verts[i][2]=math.cos(angle)*radiusSurround+cY
verts[i][3]=math.sin(angle)*outerRadius+cX
verts[i][4]=math.cos(angle)*outerRadius+cY
end
--shadow
radii={}

innerRadiusShadow=radiusSurround-6
radiusOffsetShadow=0.2
centerXShadow=16
centerYShadow=16

circleCount=((radiusSurround+2)-innerRadiusShadow)/radiusOffsetShadow

for i=1,circleCount do
radii[i]=innerRadiusShadow+radiusOffsetShadow*i
end
--roll indicator markings
rollAngles={-62,-45,-30,-20,-10,10,20,30,45,62}
for i in ipairs(rollAngles) do
rollAngles[i]=(rollAngles[i]/360)*tau+math.pi
end

rollMarkings={}
for i in ipairs(rollAngles) do
rollMarkings[i]={}
if i==2 or i==9 then
rr2=radiusSurround+2.5
else
rr2=radiusSurround+1
end
rollMarkings[i][1]=math.sin(rollAngles[i])*rr2+cX
rollMarkings[i][2]=math.cos(rollAngles[i])*rr2+cY
rollMarkings[i][3]=math.sin(rollAngles[i])*(radiusSurround-0.5)+cX
rollMarkings[i][4]=math.cos(rollAngles[i])*(radiusSurround-0.5)+cY-0.5
end

function onTick()
pitch=input.getNumber(1)*tau*spacing
roll=math.atan(math.sin(input.getNumber(2)*tau),math.sin(input.getNumber(3)*tau))
for i=-9,9 do
if i~=0 then
halfLineWidth=2+((i+1)%2)*2
else
halfLineWidth=64
skyX=math.sin(roll)*-100+15.5
skyY=math.cos(roll)*-100
end
lineY=(7*i)*spacing+pitch*40.107
radius=math.sqrt(lineY^2+halfLineWidth^2)
angle=math.atan(halfLineWidth,lineY)
if math.abs(i)==9 then
lines[1][1][i]=math.sin(roll)*lineY+15.5
lines[1][2][i]=math.cos(roll)*lineY+15.5
else
lines[1][1][i]=math.sin(roll-angle)*radius+15.5
lines[1][2][i]=math.cos(roll-angle)*radius+15.5
lines[2][1][i]=math.sin(roll+angle)*radius+15.5
lines[2][2][i]=math.cos(roll+angle)*radius+15.5
end

end
rIR=roll-math.pi
rIX1=math.sin(rIR)*radiusSurround+cX
rIY1=math.cos(rIR)*radiusSurround+cY
rIX2=math.sin(rIR-0.2)*11+cX
rIY2=math.cos(rIR-0.2)*11+cY
rIX3=math.sin(rIR+0.2)*11+cX
rIY3=math.cos(rIR+0.2)*11+cY
end
--Bassalicious
function onDraw()
--background	
screen.setColor(1,2,3)
screen.drawRectF(-1,-1,34,34)
screen.setColor(8,18,29)
screen.drawTriangleF(lines[1][1][0],lines[1][2][0]+0.5,lines[2][1][0],lines[2][2][0]+0.5,skyX,skyY)
--pitch lines & displayed angles		
screen.setColor(40,40,40)
for i=-9,9 do
if math.abs(i)==9 then
screen.drawCircleF(lines[1][1][i],lines[1][2][i],1.5)
else
if i%2==0 then
screen.drawText(lines[2][1][i]+3,lines[2][2][i]-3,math.abs(i*10))	
end
screen.drawLine(lines[1][1][i],lines[1][2][i],lines[2][1][i],lines[2][2][i])
end
end

screen.setColor(40,40,40)
--moving roll indicator
screen.drawTriangleF(rIX1,rIY1,rIX2,rIY2,rIX3,rIY3)
--static roll indicator markings
screen.drawTriangleF(16,3,13,0,18,0)

for i in ipairs(rollMarkings) do
screen.drawLine(rollMarkings[i][1],rollMarkings[i][2],rollMarkings[i][3],rollMarkings[i][4])
end
screen.drawLine(0,cY-1,3,cY-1)
screen.drawLine(29,cY-1,32,cY-1)

screen.setColor(40,20,3)
screen.drawLine(9.5,cY-1,14.5,cY-1)
screen.drawLine(21.5,cY-1,17.5,cY-1)
screen.drawLine(14.5,cY-1,14.5,cY+2)
screen.drawLine(17.5,cY-1,17.5,cY+2)
end