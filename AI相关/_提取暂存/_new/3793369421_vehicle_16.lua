-- source: steam id 3793369421 / vehicle.xml block#16
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

outerLineRadius=13.5
innerLineRadius=10.5

degrees=property.getNumber("Units")>0
cardinal={"N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW","N"}

lineCount=16

lines={}
for i=0,lineCount+1 do
lines[i]={{},{},{},{}}
end


function onTick()

heading=-input.getNumber(1)

if degrees then
hdgString=math.floor(((heading+1)%1)*360+0.5)

if hdgString<10 then
hdgString=string.format("00%i",hdgString)
elseif hdgString<100 then
hdgString=string.format("0%i",hdgString)
else
hdgString=string.format("%i",hdgString)
end

else
hdgString=cardinal[math.ceil(((heading+1)%1)*16+0.5)]
end

heading=(heading*tau)%tau

for i=0,lineCount do
local lineAngle=((i-1)/lineCount)*tau+heading+math.pi
lines[i][1][1]=math.sin(lineAngle)*outerLineRadius+cX
lines[i][1][2]=math.cos(lineAngle)*outerLineRadius+cY
local deltaRadius=outerLineRadius-innerLineRadius
if (i-1)%(lineCount/4)==0 then
lines[i][2][1]=math.sin(lineAngle+math.pi)*(deltaRadius+3)+lines[i][1][1]
lines[i][2][2]=math.cos(lineAngle+math.pi)*(deltaRadius+3)+lines[i][1][2]
else
	local lineAngle=round(lineAngle+math.pi,math.pi/4)
lines[i][2][1]=math.sin(lineAngle)*deltaRadius+lines[i][1][1]
lines[i][2][2]=math.cos(lineAngle)*deltaRadius+lines[i][1][2]
end
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
for i=0,lineCount-1 do
	if i==1 then
		screen.setColor(60,0,0)
	else
		screen.setColor(40,40,40)
	end
screen.drawLine(lines[i][1][1],lines[i][1][2],lines[i][2][1],lines[i][2][2])
end
screen.setColor(5,6,7)
for i=1,10 do
screen.drawCircle(cX,cY,outerLineRadius+1+(i/5))
end

screen.setColor(12,13,14)
screen.drawRectF(8,20,15,6)
screen.setColor(8,9,10)
screen.drawRect(8,20,15,6)

screen.setColor(40,40,40)
if #hdgString~=2 then
screen.drawTextBox(8,21,16,5,hdgString,0)
else
screen.drawText(11,21,string.sub(hdgString,1,1))
screen.drawText(17,21,string.sub(hdgString,2,2))
end


screen.setColor(9,10,11)

screen.setColor(40,40,40)
screen.drawRectF(cX-1,cY-4,2,8)
screen.drawRectF(cX-6,cY-2,12,3)
screen.drawRectF(cX-2,cY+3,4,2)
screen.drawTriangleF(cX-2,cY+3,cX-2,cY+5,cX-3,cY+5)
screen.drawTriangleF(cX+2,cY+3,cX+2,cY+5,cX+3,cY+5)
end
