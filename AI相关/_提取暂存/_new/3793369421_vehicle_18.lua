-- source: steam id 3793369421 / vehicle.xml block#18
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793369421
tau=math.pi*2

function lerp(x,a,b)
return (x-a)/(b-a)
end

function round(x,nearest)
return nearest and (x/nearest+.5)//1*nearest or (x+.5)//1
end

cX=15.5
cY=15.5


dialX1=0
dialY1=0
dialX2=0
dialY2=0
dialX3=0
dialY3=0
dialX4=0
dialY4=0
dialX5=0
dialY5=0

outerLineRadius=13.5
innerLineRadius=10.5

linesPerHundred=2
lineCount=10*linesPerHundred

lines={}

for i=0,lineCount+1 do
lines[i]={{},{},{},{}}
local lineAngle=(i/lineCount)*tau+math.pi
lines[i][1][1]=math.sin(lineAngle)*outerLineRadius+cX
lines[i][1][2]=math.cos(lineAngle)*outerLineRadius+cY
local deltaRadius=outerLineRadius-innerLineRadius
local lineAngle=round(lineAngle+math.pi,math.pi/4)
if i%linesPerHundred==0 then 
lines[i][2][1]=math.sin(lineAngle)*deltaRadius+lines[i][1][1]
lines[i][2][2]=math.cos(lineAngle)*deltaRadius+lines[i][1][2]
else
lines[i][2][1]=math.sin(lineAngle)*1+lines[i][1][1]
lines[i][2][2]=math.cos(lineAngle)*1.6+lines[i][1][2]	
end
end


function onTick()
altitude=input.getNumber(1)*property.getNumber("Units")

hundredAngle=-altitude/1000*tau+math.pi
thouAngle=-altitude/10000*tau+math.pi
cY=cY+1
cX=cX-.1
dialX1=math.sin(hundredAngle)*12+cX
dialY1=math.cos(hundredAngle)*12+cY
dialX2=math.sin(hundredAngle+.1)*8+cX
dialY2=math.cos(hundredAngle+.1)*8+cY
dialX3=math.sin(hundredAngle-.1)*8+cX
dialY3=math.cos(hundredAngle-.1)*8+cY
dialX4=math.sin(hundredAngle+.6)+cX
dialY4=math.cos(hundredAngle+.6)+cY
dialX5=math.sin(hundredAngle-.6)+cX
dialY5=math.cos(hundredAngle-.6)+cY

dialX6=math.sin(thouAngle)*9+cX
dialY6=math.cos(thouAngle)*9+cY
dialX7=math.sin(thouAngle+.2)*6+cX
dialY7=math.cos(thouAngle+.2)*6+cY
dialX8=math.sin(thouAngle-.2)*6+cX
dialY8=math.cos(thouAngle-.2)*6+cY
dialX9=math.sin(thouAngle+.8)+cX
dialY9=math.cos(thouAngle+.8)+cY
dialX10=math.sin(thouAngle-.8)+cX
dialY10=math.cos(thouAngle-.8)+cY

cY=cY-1
cX=cX+.1

if altitude>=10000 then
altString=string.format("%ik",math.floor(altitude/1000))	
elseif altitude>=1000 then
altString=string.format("%.1f",math.floor(altitude/100)/10)
elseif altitude>=100 then
altString=string.format("%i",math.floor(altitude))
elseif altitude>=10 then
altString=string.format("0%i",math.floor(altitude))	
elseif altitude>=0 then
altString=string.format("00%i",math.floor(altitude))
elseif altitude>-1 then
altString="000"
elseif altitude>-10 then	
altString=string.format("-0%i",math.floor(math.abs(altitude)))	
elseif altitude<=-10 then
altString="rip"	
else
end
end
--Bassalicious
function onDraw()
screen.setColor(2,3,4)
screen.drawRectF(-1,-1,34,34)
screen.setColor(1,2,3)
screen.drawCircleF(cX,cY,15)

screen.setColor(9,10,11)
screen.drawCircleF(1.5,1.5,2)
screen.drawCircleF(29.5,1.5,2)
screen.drawCircleF(1.5,29.5,2)
screen.drawCircleF(29.5,29.5,2)

screen.setColor(40,40,40)	
for i in ipairs(lines) do
screen.drawLine(lines[i][1][1],lines[i][1][2],lines[i][2][1],lines[i][2][2])
end
screen.setColor(5,6,7)
for i=1,10 do
screen.drawCircle(cX,cY,outerLineRadius+1+(i/5))
end

screen.setColor(12,13,14)
screen.drawRectF(8,18,15,6)
screen.setColor(8,9,10)
screen.drawRect(8,18,15,6)
screen.setColor(40,40,40)
screen.drawTextBox(7,19,16,5,altString,1)	
	
screen.drawTriangleF(dialX1,dialY1,dialX2,dialY2,dialX3,dialY3)
screen.drawTriangleF(dialX2,dialY2,dialX3,dialY3,dialX4,dialY4)
screen.drawTriangleF(dialX3,dialY3,dialX4,dialY4,dialX5,dialY5)

screen.drawTriangleF(dialX6,dialY6,dialX7,dialY7,dialX8,dialY8)
screen.drawTriangleF(dialX7,dialY7,dialX8,dialY8,dialX9,dialY9)
screen.drawTriangleF(dialX8,dialY8,dialX9,dialY9,dialX10,dialY10)

screen.setColor(9,10,11)
screen.drawCircleF(cX,cY,2.1)

end
