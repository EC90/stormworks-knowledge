-- source: steam id 2913735149 / vehicle.xml block#12
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2913735149
h=96
w=96
grid=24
rkm=0
function onTick()
d1=input.getBool(1)
d2=input.getBool(2)
d3=input.getBool(3)
d4=input.getBool(4)
stc=input.getBool(5)
mbb=input.getBool(6)
x1=input.getNumber(1)
rkm=math.floor(input.getNumber(21))
rpa=math.floor(input.getNumber(18))
fovy=math.floor(input.getNumber(19)/2)
fovx=math.floor(input.getNumber(20)/2)
rot1=input.getNumber(2)
rot2=input.getNumber(4)
rot3=input.getNumber(6)
rot4=input.getNumber(8)
rot5=input.getNumber(10)
rot6=input.getNumber(12)
rot7=input.getNumber(14)
rot8=input.getNumber(16)
ang1=-input.getNumber(3)
ang2=-input.getNumber(5)
ang3=-input.getNumber(7)
ang4=-input.getNumber(9)
ang5=-input.getNumber(11)
ang6=-input.getNumber(13)
ang7=-input.getNumber(15)
ang8=-input.getNumber(17)
dist=math.floor(input.getNumber(22))
dist1=math.floor(input.getNumber(22)/100)
dist2=math.floor(input.getNumber(23)/100)
dist3=math.floor(input.getNumber(24)/100)
dist4=math.floor(input.getNumber(25)/100)
dist5=math.floor(input.getNumber(26)/100)
dist6=math.floor(input.getNumber(27)/100)
dist7=math.floor(input.getNumber(28)/100)
dist8=math.floor(input.getNumber(29)/100)
end
function onDraw()
screen.setColor(0, 20, 0)
screen.drawRectF(w/2-8,h/2,17,h/2)
screen.setColor(0,255,0)
if d1 then
screen.drawText(3,2,"-30")
screen.drawText(79,2,"30")
grid=24 end
if d2 then
screen.drawText(3,2,"-40")
screen.drawText(79,2,"40")
grid=16 end
if d3 then
screen.drawText(3,2,"-50")
screen.drawText(79,2,"50")
grid=12 end
if d4 then
screen.drawText(3,2,"-60")
screen.drawText(79,2,"60")
grid=8 end
if stc then
screen.drawText(3,2,-fovx)
screen.drawText(79,2,fovx)
screen.drawLine(w/2-fovx,0,w/2-fovx,h)
screen.drawLine(w/2+fovx,0,w/2+fovx,h)
for i=0, h-8 do
if math.fmod(i,grid)==0 then
screen.setColor(0, 90, 0,90)
screen.drawLine(w/2-fovx,i,w/2+fovx,i)
screen.drawLine(i,0,i,w)
end end else
for i=0, h-8 do
if math.fmod(i,grid)==0 then
screen.setColor(0, 90, 0,90)
screen.drawLine(0, i, w, i)
screen.drawLine(i, 0, i, w)
end end end
screen.setColor(0,255,0)
screen.drawText(7,h/2-7,fovy+rpa)
screen.drawText(2,h/2+2,-fovy+rpa)
screen.drawText(2,h-8,rkm)
screen.drawText(12,h-8,"km")
screen.setColor(0, 30, 0)
screen.drawRectF(w/2-5+x1,h,10,-h)
screen.setColor(0, 50, 0)
screen.drawRectF(w/2-3+x1,h,6,-h)
if mbb then
if stc then
screen.setColor(0,255-dist1,0)
screen.drawLine(w/2+rot1+4,h/2+ang1,w/2+rot1-4,h/2+ang1)
screen.drawText(w/2+rot1,h/2+4+ang1,dist)
screen.drawRect(w/2+6+rot1,h/2+2+ang1,-12,-4)
else
screen.setColor(0,255-dist1,0)
screen.drawLine(w/2+rot1+4,h/2+ang1,w/2+rot1-4,h/2+ang1)
end
screen.setColor(0,255-dist2,0)
screen.drawLine(w/2+rot2+4,h/2+ang2,w/2+rot2-4,h/2+ang2)
screen.setColor(0,255-dist3,0)
screen.drawLine(w/2+rot3+4,h/2+ang3,w/2+rot3-4,h/2+ang3)
screen.setColor(0,255-dist4,0)
screen.drawLine(w/2+rot4+4,h/2+ang4,w/2+rot4-4,h/2+ang4)
screen.setColor(0,255-dist5,0)
screen.drawLine(w/2+rot5+4,h/2+ang5,w/2+rot5-4,h/2+ang5)
screen.setColor(0,255-dist6,0)
screen.drawLine(w/2+rot6+4,h/2+ang6,w/2+rot6-4,h/2+ang6)
screen.setColor(0,255-dist7,0)
screen.drawLine(w/2+rot7+4,h/2+ang7,w/2+rot7-4,h/2+ang7)
screen.setColor(0,255-dist8,0)
screen.drawLine(w/2+rot8+4,h/2+ang8,w/2+rot8-4,h/2+ang8)
else
screen.setColor(0,255,0)
if stc then
screen.drawLine(w/2+rot1+4,h/2+ang1,w/2+rot1-4,h/2+ang1)
screen.drawText(w/2+5+rot1,h/2+3+ang1,dist)
screen.setColor(0,255,0)
screen.drawRect(w/2+6+rot1,h/2+2+ang1,-12,-4)
else
screen.drawLine(w/2+rot1+4,h/2+ang1,w/2+rot1-4,h/2+ang1)
end
screen.setColor(0, 255, 0)
screen.drawLine(w/2+rot2+4,h/2+ang2,w/2+rot2-4,h/2+ang2)
screen.drawLine(w/2+rot3+4,h/2+ang3,w/2+rot3-4,h/2+ang3)
screen.drawLine(w/2+rot4+4,h/2+ang4,w/2+rot4-4,h/2+ang4)
screen.drawLine(w/2+rot5+4,h/2+ang5,w/2+rot5-4,h/2+ang5)
screen.drawLine(w/2+rot6+4,h/2+ang6,w/2+rot6-4,h/2+ang6)
screen.drawLine(w/2+rot7+4,h/2+ang7,w/2+rot7-4,h/2+ang7)
screen.drawLine(w/2+rot8+4,h/2+ang8,w/2+rot8-4,h/2+ang8)
end end