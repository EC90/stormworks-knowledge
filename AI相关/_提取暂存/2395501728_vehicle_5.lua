-- source: steam id 2395501728 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2395501728
function onTick()
isPressed=input.getBool(1) or input.getBool(2)
w=input.getNumber(1)
h=input.getNumber(2)
ix=input.getNumber(3)
iy=input.getNumber(4)
x=input.getNumber(5)
y=input.getNumber(6)
z=input.getNumber(7)
wx1=input.getNumber(8)
wy1=input.getNumber(9)
wx2=input.getNumber(10)
wy2=input.getNumber(11)
wx3=input.getNumber(12)
wy3=input.getNumber(13)
wx4=input.getNumber(14)
wy4=input.getNumber(15)
wn=input.getNumber(16)
wx1m,wy1m=map.mapToScreen(x,y,z,w,h,wx1,wy1)
wx2m,wy2m=map.mapToScreen(x,y,z,w,h,wx2,wy2)
wx3m,wy3m=map.mapToScreen(x,y,z,w,h,wx3,wy3)
wx4m,wy4m=map.mapToScreen(x,y,z,w,h,wx4,wy4)
iswpm=isPressed and isPointInRectangle(ix,iy,w-9,0.5*h-19,7,8)
iswps=isPressed and isPointInRectangle(ix,iy,w-9,0.5*h-10,7,7)
iswpp=isPressed and isPointInRectangle(ix,iy,w-9,0.5*h+1,7,8)
isw1= wx1^2>0 or wy1^2>0
isw2= wx2^2>0 or wy2^2>0
isw3= wx3^2>0 or wy3^2>0
isw4= wx4^2>0 or wy4^2>0
output.setBool(11, iswpm)
output.setBool(12, iswps)
output.setBool(13, iswpp)
end
function isPointInRectangle(x,y,rectX,rectY,rectW,rectH)
return x>rectX and y>rectY and x<rectX+rectW and y<rectY+rectH
end
function onDraw()
screen.setColor(0,175,0)
if iswpm then
screen.drawTriangleF(w-9,0.5*h-13,w-2,0.5*h-13,w-6,0.5*h-19)
else
screen.drawTriangle(w-9,0.5*h-13,w-2,0.5*h-13,w-6,0.5*h-19)
end
if iswps then
screen.drawCircleF(w-6,0.5*h-6,3.49)
else
screen.drawCircle(w-6,0.5*h-6,3.49)
screen.drawText(w-8,0.5*h-8,wn)
end
if iswpp then
screen.drawTriangleF(w-9,0.5*h+1,w-2,0.5*h+1,w-6,0.5*h+7)
else
screen.drawTriangle(w-9,0.5*h+1,w-2,0.5*h+1,w-6,0.5*h+7)
end
screen.setColor(180,90,0)
if isw1 then
screen.drawLine(w/2,h/2,wx1m,wy1m)
else
end
if isw1 and isw2 then
screen.drawLine(wx1m,wy1m,wx2m,wy2m)
else
end
if isw2 and isw3 then
screen.drawLine(wx2m,wy2m,wx3m,wy3m)
else
end
if isw3 and isw4 then
screen.drawLine(wx3m,wy3m,wx4m,wy4m)
else
end
screen.setColor(0,175,0)
screen.drawRectF(0,0,29,9)
screen.setColor(0,0,0)
screen.drawText(2,2,"WAY P")
end