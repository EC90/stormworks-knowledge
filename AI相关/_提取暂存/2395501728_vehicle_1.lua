-- source: steam id 2395501728 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2395501728
function onTick()
isPressed=input.getBool(1) or input.getBool(2)
isWing=input.getBool(4)
isRing=input.getBool(5)
isBing=input.getBool(6)
w=input.getNumber(1)
h=input.getNumber(2)
ix=input.getNumber(3)
iy=input.getNumber(4)
x=input.getNumber(5)
y=input.getNumber(6)
z=input.getNumber(7)
wx=input.getNumber(14)
wy=input.getNumber(15)
wd=input.getNumber(16)
rx=input.getNumber(17)
ry=input.getNumber(18)
rd=input.getNumber(19)
bx=input.getNumber(20)
by=input.getNumber(21)
bd=input.getNumber(22)
wxm,wym=map.mapToScreen(x,y,z,w,h,wx,wy)
rxm,rym=map.mapToScreen(x,y,z,w,h,rx,ry)
bxm,bym=map.mapToScreen(x,y,z,w,h,bx,by)
iswp=wx^2>0 or wy^2>0
isrt=rx^2>0 or ry^2>0
isbt=bx^2>0 or by^2>0
isGW=isPressed and isPointInRectangle(ix,iy,15,9,8,8) and iswp
isGR=isPressed and isPointInRectangle(ix,iy,25,9,8,8) and isrt
isGB=isPressed and isPointInRectangle(ix,iy,35,9,8,8) and isbt
isAP=isPressed and isPointInRectangle(ix,iy,0,0,28,8)
isRD=isPressed and isPointInRectangle(ix,iy,0.5*w-15,0,28,8)
isBC=isPressed and isPointInRectangle(ix,iy,w-29,0,28,8)
output.setBool(8, isGW)
output.setBool(9, isGR)
output.setBool(10, isGB)
output.setBool(11, isAP)
output.setBool(12, isRD)
output.setBool(13, isBC)
end
function isPointInRectangle(x,y,rectX,rectY,rectW,rectH)
return x>rectX and y>rectY and x<rectX+rectW and y<rectY+rectH
end
function onDraw()
screen.drawMap(x,y,z)
if iswp then
screen.setColor(255,255,0)
screen.drawLine(0.5*w,0.5*h,wxm,wym)
screen.drawText(wxm-2,wym-2.5,"W")
else
end
if isrt then
screen.setColor(0,255,255)
screen.drawLine(0.5*w,0.5*h,rxm,rym)
screen.drawText(rxm-2,rym-2.5,"R")
else
end
if isbt then
screen.setColor(255,0,255)
screen.drawLine(0.5*w,0.5*h,bxm,bym)
screen.drawText(bxm-2,bym-2.5,"B")
else
end
screen.setColor(0,175,0)
screen.drawText(2,2,"WAY P")
screen.drawRect(0,0,28,8)
screen.drawText(0.5*w-13,2,"RADAR")
screen.drawRect(0.5*w-15,0,28,8)
screen.drawText(w-27,2,"BEACN")
screen.drawRect(w-29,0,28,8)
screen.drawText(2,10,"GO W R B")
if isWing then
screen.drawRectF(15,9,8,8)
screen.setColor(0,0,0)
screen.drawText(17,10,"W")
screen.setColor(0,175,0)
else
end
if isRing then
screen.drawRectF(25,9,8,8)
screen.setColor(0,0,0)
screen.drawText(27,10,"R")
screen.setColor(0,175,0)
else
end
if isBing then
screen.drawRectF(35,9,8,8)
screen.setColor(0,0,0)
screen.drawText(37,10,"B")
screen.setColor(0,175,0)
else
end
if iswp then
screen.drawText(w-25,h-6,wd)
screen.drawText(w-30,h-12,"W DIST")
else
screen.drawText(w-25,h-12,"NO WP")
end
if isrt then
screen.drawText(w-25,h-18,rd)
screen.drawText(w-30,h-24,"R DIST")
else
screen.drawText(w-25,h-24,"NO RT")
end
if isbt then
screen.drawText(w-25,h-30,bd)
screen.drawText(w-30,h-36,"B DIST")
else
screen.drawText(w-25,h-36,"NO BT")
end
end