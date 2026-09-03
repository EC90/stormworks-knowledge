-- source: steam id 3794618673 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794618673
tau=math.pi*2
s=screen
m=math

function lerp(x,a,b)
return (x-a)/(b-a)
end

cX=15.5
cY=15.5



minSpeed=property.getNumber("Indicator Alive Speed")
maxSpeed=property.getNumber("Needle Stop Speed")

minAngle=math.pi
maxAngle=math.pi*2.5
deltaAngle=maxAngle-minAngle

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


function onTick()
speed=input.getNumber(1)
if speed<minSpeed then
speed=0
end
dAngle=m.min(m.max(speed,0),maxSpeed)/maxSpeed*-deltaAngle+minAngle
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
displaySpeed=m.floor(m.abs(speed))
if displaySpeed<20 then
speedString="000"
elseif displaySpeed<100 then
speedString=string.format("0%i",displaySpeed)
elseif displaySpeed<1000 then
speedString=string.format("%i",displaySpeed)
else
speedString=string.format("%.1f",math.min(displaySpeed,9999)/1000)
end

end
--Bassalicious
function onDraw()
s.setColor(40,40,40)
s.drawTextBox(7,8,16,5,speedString,1)

s.drawTriangleF(dX1,dY1,dX2,dY2,dX3,dY3)
s.drawTriangleF(dX2,dY2,dX3,dY3,dX4,dY4)
s.drawTriangleF(dX3,dY3,dX4,dY4,dX5,dY5)
s.setColor(9,10,11)
s.drawCircleF(cX,cY,2.1)

end