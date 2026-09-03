-- source: steam id 3794618673 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794618673
tau=math.pi*2
s=screen
m=math
p=property.getNumber

function lerp(x,a,b)
return (x-a)/(b-a) or 0
end

--function round(x,nearest)
--return nearest and (x/nearest+.5)//1*nearest or (x+.5)//1
--end

cX=15.5
cY=15.5

outerRadius=12.5
innerRadius=10.5

minSpeed=p("Indicator Alive Speed")
maxSpeed=p("Needle Stop Speed")

greenStart=math.max(p("Green Arc Start Speed"),minSpeed)
yellowStart=math.max(p("Yellow Arc Start Speed"),minSpeed)
yellowMax=math.max(math.min(p("Yellow Arc End Speed"),maxSpeed),minSpeed)
whiteStart=math.max(p("White Arc Start Speed"),minSpeed)
whiteMax=math.max(math.min(p("White Arc End Speed"),maxSpeed),minSpeed)

vne=p("VNE Speed")


minAngle=math.pi
maxAngle=math.pi*2.5
deltaAngle=maxAngle-minAngle
vneAngle=-(vne/maxSpeed)*deltaAngle+minAngle
vneX1=m.sin(vneAngle)*(outerRadius+1)+cX
vneY1=m.cos(vneAngle)*(outerRadius+1)+cY
vneX2=m.sin(vneAngle+m.pi)*5+vneX1
vneY2=m.cos(vneAngle+m.pi)*5+vneY1

markDelta=p("Tick Marks Every X Units")

lines={}
lineStart=m.ceil(minSpeed/markDelta)-1
lineCount=m.floor((maxSpeed)/markDelta)-lineStart
for i=1,lineCount+1 do
lines[i]={{},{},{},{}}
local j=(i-1+lineStart)*markDelta
local lineAngle=(j/maxSpeed)*-deltaAngle+minAngle
lines[i][1][1]=m.sin(lineAngle)*(outerRadius+1)+cX
lines[i][1][2]=m.cos(lineAngle)*(outerRadius+1)+cY--0.2
local lineAngle=lineAngle+math.pi
local deltaRadius=outerRadius-innerRadius+2.7--+1.7
lines[i][2][1]=m.sin(lineAngle)*deltaRadius+lines[i][1][1]
lines[i][2][2]=m.cos(lineAngle)*deltaRadius+lines[i][1][2]
end

greenStartAngle=(greenStart/maxSpeed)*deltaAngle+minAngle
yellowStartAngle=(yellowStart/maxSpeed)*deltaAngle+minAngle
yellowMaxAngle=(yellowMax/maxSpeed)*deltaAngle+minAngle
arcDeltaAngle=yellowMaxAngle-greenStartAngle
yellowStartPoly=1
arcPolyCount=math.ceil(arcDeltaAngle/math.pi)*property.getNumber("Polygons per 180deg of Arc")

arc={}

for i=1,arcPolyCount+1 do
arc[i]={}
local arcAngle=-((i-1)*(arcDeltaAngle/arcPolyCount)+greenStartAngle)
if -arcAngle<=yellowStartAngle then
yellowStartPoly=i
end
arc[i][1]=m.sin(arcAngle)*(outerRadius-.6)+cX--+.1
arc[i][2]=m.cos(arcAngle)*(outerRadius-.6)+cY+1
arc[i][3]=m.sin(arcAngle)*(innerRadius-1.5)+cX--+.1
arc[i][4]=m.cos(arcAngle)*(innerRadius-1.5)+cY+1
end

whiteStartAngle=(whiteStart/maxSpeed)*deltaAngle+minAngle
whiteMaxAngle=(whiteMax/maxSpeed)*deltaAngle+minAngle
wArcDeltaAngle=whiteMaxAngle-whiteStartAngle

wArcPolyCount=math.ceil(wArcDeltaAngle/math.pi)*property.getNumber("Polygons per 180deg of Arc")
wArc={}

for i=1,wArcPolyCount+1 do
wArc[i]={}
local wArcAngle=-((i-1)*(wArcDeltaAngle/wArcPolyCount)+whiteStartAngle)
wArc[i][1]=m.sin(wArcAngle)*(outerRadius+2)+cX--+.1
wArc[i][2]=m.cos(wArcAngle)*(outerRadius+2)+cY+1
wArc[i][3]=m.sin(wArcAngle)*(innerRadius+1.5)+cX--+.1
wArc[i][4]=m.cos(wArcAngle)*(innerRadius+1.5)+cY+1
end
--Basslicious
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

s.setColor(2,25,10)
for i=1,arcPolyCount do
if i>=yellowStartPoly then
s.setColor(30,25,1)
end
s.drawTriangleF(arc[i][1],arc[i][2],arc[i][3],arc[i][4],arc[i+1][1],arc[i+1][2])
s.drawTriangleF(arc[i][3],arc[i][4],arc[i+1][1],arc[i+1][2],arc[i+1][3],arc[i+1][4])
end

s.setColor(40,40,40)
for i=1,wArcPolyCount do
s.drawTriangleF(wArc[i][1],wArc[i][2],wArc[i][3],wArc[i][4],wArc[i+1][1],wArc[i+1][2])
s.drawTriangleF(wArc[i][3],wArc[i][4],wArc[i+1][1],wArc[i+1][2],wArc[i+1][3],wArc[i+1][4])
end

for i in ipairs(lines) do
	if i~=1 then
	s.drawLine(lines[i][1][1],lines[i][1][2],lines[i][2][1],lines[i][2][2])
	end
end

s.setColor(40,5,2)
s.drawLine(vneX1,vneY1,vneX2,vneY2)

s.setColor(12,13,14)
s.drawRectF(8,7,15,6)
s.setColor(8,9,10)
s.drawRect(8,7,15,6)

s.setColor(5,6,7)
for i=1,10 do
s.drawCircle(cX,cY,outerRadius+2+(i/5))
end
end