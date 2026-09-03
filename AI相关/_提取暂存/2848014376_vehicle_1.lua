-- source: steam id 2848014376 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2848014376


function onTick()


fre = input.getNumber(1)


end

function onDraw()

setC(80,79,78)
screen.drawRectF(84,3,10,3)
setC(90,90,90)
screen.drawRectF(85,4,8,1)

setC(61,39,23)
screen.drawRectF(27,2,42,7)
setC(96,96,96)
screen.drawRectF(27,2,42,7)
setC(0,0,0)
screen.drawTextBox(27, 2, 42, 7, "100=KHz", 0, 0)

setC(0,0,0)
screen.drawRectF(28,11,42,23)
setC(96,96,96)
screen.drawRectF(31,14,36,17)

setC(96,96,96)
screen.drawRectF(41,24,16,7)
setC(93,93,93)
screen.drawRectF(42,25,14,5)
setC(0,0,0)
screen.drawTextBox(41, 24, 21, 7, math.floor(fre/1000), 0, 0)

setC(19,19,19)
screen.drawRectF(83,7,12,6)
setC(19,19,19)
screen.drawRectF(84,8,10,4)

cx=76.5
cy=10
ri=4
ro=5
setC(1,1,1)
screen.drawCircleF(cx,cy,ro)
setC(91,91,91)
screen.drawCircleF(cx,cy,ri)

setC(0,0,0)
screen.drawLine(36, 17, 39, 24)

setC(0,0,0)
screen.drawLine(60, 24, 63, 17)

setC(0,0,0)
screen.drawLine(49, 24, 50, 16)

setC(3,3,3)
cx=50
cy=8
angle=0
p1=rotatePoint(cx,cy,angle,48,11)
p2=rotatePoint(cx,cy,angle,50,17)
p3=rotatePoint(cx,cy,angle,52,11)
screen.drawTriangleF(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y)

cx=88
cy=22
ri=4
ro=5
setC(23,22,23)
screen.drawCircleF(cx,cy,ro)
setC(22,22,23)
screen.drawCircleF(cx,cy,ri)

setC(34,36,36)
cx=88
cy=18
angle=0
p1=rotatePoint(cx,cy,angle,86,22)
p2=rotatePoint(cx,cy,angle,88,14)
p3=rotatePoint(cx,cy,angle,90,22)
screen.drawTriangleF(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y)

cx=88
cy=37
ri=4
ro=5
setC(23,22,23)
screen.drawCircleF(cx,cy,ro)
setC(22,22,23)
screen.drawCircleF(cx,cy,ri)

setC(34,36,36)
cx=88
cy=33
angle=0
p1=rotatePoint(cx,cy,angle,86,37)
p2=rotatePoint(cx,cy,angle,88,29)
p3=rotatePoint(cx,cy,angle,90,37)
screen.drawTriangleF(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y)

cx=86.5
cy=52
ri=6
ro=7
setC(20,19,20)
screen.drawCircleF(cx,cy,ro)
setC(39,38,40)
screen.drawCircleF(cx,cy,ri)

cx=53
cy=52.5
ri=4.5
ro=5.5
setC(20,19,20)
screen.drawCircleF(cx,cy,ro)
setC(39,38,40)
screen.drawCircleF(cx,cy,ri)

setC(0,0,0)
screen.drawRectF(28,37,50,8)
setC(91,91,91)
screen.drawRectF(29,38,48,6)
setC(0,0,0)
screen.drawTextBox(28, 37, 50, 8, "Frequenz", 0, 0)

setC(19,19,19)
screen.drawRectF(7,47,7,14)
setC(19,19,19)
screen.drawRectF(8,48,5,12)

setC(19,19,19)
screen.drawRectF(15,47,7,14)
setC(19,19,19)
screen.drawRectF(16,48,5,12)

setC(96,96,96)
screen.drawRectF(4,42,10,4)
setC(96,96,96)
screen.drawRectF(5,43,8,2)

setC(96,96,96)
screen.drawRectF(15,42,10,4)
setC(96,96,96)
screen.drawRectF(16,43,8,2)

setC(96,96,96)
screen.drawRectF(3,27,15,4)
setC(96,96,96)
screen.drawRectF(4,28,13,2)

setC(96,96,96)
screen.drawRectF(3,22,15,4)
setC(96,96,96)
screen.drawRectF(4,23,13,2)

cx=12
cy=36
ri=2
ro=4
setC(0,0,0)
screen.drawCircleF(cx,cy,ro)
setC(77,25,25)
screen.drawCircleF(cx,cy,ri)

setC(19,19,19)
screen.drawRectF(3,14,17,7)
setC(19,19,19)
screen.drawRectF(4,15,15,5)

setC(96,96,96)
screen.drawRectF(3,9,15,4)
setC(96,96,96)
screen.drawRectF(4,10,13,2)

setC(19,19,19)
screen.drawRectF(3,1,17,7)
setC(19,19,19)
screen.drawRectF(4,2,15,5)
end

function setC(r,g,b,a)
if a==nil then a=255 end
screen.setColor(r,g,b,a)
end

function rotatePoint(cx,cy,angle,px,py)
s=math.sin(angle)
c=math.cos(angle)
px=px-cx
py=py-cy
xnew=px*c-py*s
ynew=px*s+py*c
px=xnew+cx
py=ynew+cy
return {x=px,y=py}
end

