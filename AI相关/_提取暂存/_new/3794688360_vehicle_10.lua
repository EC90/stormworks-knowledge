-- source: steam id 3794688360 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794688360
i=0
D=1000
mod3=1
mod2=false
Points={}
cos=math.cos
sin=math.sin
pi=math.pi
pi2=math.pi*2
function onTick()
X1=input.getNumber(3)
Y1=input.getNumber(4)
iP=input.getBool(1)
RR=input.getNumber(7)
TD=input.getNumber(8)
TA=input.getNumber(9)
DS=D/16
RR2=RR*360
TA2=TA*360
    
    
--PointCoords={x=math.sin((-TA2+180)*(math.pi/180))*((TD/D)*16)+16)+(math.sin((-RR2+180)*(math.pi/180))*((TD/D)*16)+16),y=      math.cos((-TA2+180)*(math.pi/180))*((TD/D)*16)+16)+(math.cos((-RR2+180)*(math.pi/180))*((TD/D)*16)+16)+16),a=255} DONT USE THIS

PointCoords= 
{x=cos((TA+pi)*pi2-pi/2)*((TD/D)*16)+16,y=sin((TA)*pi2-pi/2)*((TD/D)*16)+16,a=255}
  
table.insert(Points,PointCoords)

if Points[1].a==0 then
table.remove(Points,1)
end
FirstPoint=Points[1]
for index,PointCoords in pairs(Points) do
PointCoords.a=PointCoords.a-5
end
mod=press and mod2
mod2=not press
if mod==true then
mod3=mod3+1
end
if mod3==5 then
mod3=1
end
output.setNumber(1,mod3)
if mod3==1 then
D=1000
end
if mod3==2 then
D=2000
end
if mod3==3 then
D=3000
end
if mod3==4 then
D=4000
end
press=iP and Point(X1,Y1,0,0,4,3) 
clm=property.getBool("Switch Color Mode")
if clm==false then
c1=30
c11=0
c2=40
c22=0
c3=60
c33=0
c4=92
c44=0
c5=199
c55=0
c6=255
c66=0
else
c1=0
c11=30
c2=0
c22=40
c3=0
c33=60
c4=0
c44=92
c5=0
c55=199
c6=0
c66=255
end
end
function screen.gammaColor(r,g,b,a)
if a==nil then
a=255
end
screen.setColor((r/255)^2.2*255,(g/255)^2.2*255,(b/255)^2.2*255,a)
end
function screen.correctCircle(x,y,rad,wid)
if rad==nil then
rad=1
end
if wid==nil then
wid=1
end
for i=0,360 do
screen.drawRect(math.sin((-i+180)*(math.pi/180))*rad+(math.sin((-i+180)*(math.pi/180))*rad+x),math.cos((-i+180)*(math.pi/180))*rad+(math.cos((-i+180)*(math.pi/180))*rad+y),wid,wid)
end
end
function Point(x,y,rectX,rectY,rectW,rectH)
return x>rectX and y>rectY and x<rectX+rectW and y<rectY+rectH
end
function screen.fastLine(deg)
screen.drawLine(16,16,math.sin((-RR2+deg)*(math.pi/180))*16+16,math.cos((-RR2+deg)*(math.pi/180))*16+16)
end
function onDraw()
screen.gammaColor(0,c1,c11)
screen.drawRectF(0,0,33,33)
if mod3==1 then
screen.gammaColor(0,c2,c22) 
screen.correctCircle(15,15,4.5)
end
if mod3==2 then
screen.gammaColor(0,c2,c22) 
screen.correctCircle(15,15,2) 
screen.correctCircle(15,15,5)
end
if mod3==3 then
screen.gammaColor(0,c2,c22) 
screen.correctCircle(15,15,1.5)
screen.correctCircle(15,15,3.5)
screen.correctCircle(15,15,5.5)
end
if mod3==4 then
screen.gammaColor(0,c2,c22) 
screen.correctCircle(15,15,1.5)
screen.correctCircle(15,15,3)
screen.correctCircle(15,15,4.5)
screen.correctCircle(15,15,6)
end
screen.gammaColor(0,c3,c33)
screen.drawLine(16,16,16,1)
screen.drawLine(16,16,4,4)
screen.drawLine(16,16,1,16)
screen.drawLine(16,16,4,28)
screen.drawLine(16,16,30,16)
screen.drawLine(16,16,16,30)
screen.drawLine(16,16,28,4)
screen.drawLine(16,16,28,28)
screen.gammaColor(0,c2,c22)
screen.fastLine(207)
screen.fastLine(203)
screen.gammaColor(0,c3,c33)
screen.fastLine(199)
screen.fastLine(198)
screen.fastLine(195)
screen.fastLine(194)
screen.fastLine(191)
screen.fastLine(189)
screen.gammaColor(0,c4,c44)
screen.fastLine(186)
screen.fastLine(184)
screen.gammaColor(0,c5,c55)
screen.fastLine(180)
for index,PointCoords in pairs(Points) do
screen.gammaColor(162,38,51,PointCoords.a)
screen.drawRect(PointCoords.x,PointCoords.y,1,1)
end
screen.gammaColor(0,c6,c66) 
screen.correctCircle(15,15,7.5)
screen.gammaColor(36,36,36)
screen.drawRect(0,-1,31,1)
screen.drawRect(0,31,31,1)
if press==true then
screen.gammaColor(0,c6,c66)
screen.drawRect(2,0,2,1)
else
screen.gammaColor(46,46,46)
screen.drawRect(2,0,2,1)
end
screen.gammaColor(36,36,36)
screen.drawRectF(25,1,6,1)
screen.setColor(0,0,0)
screen.drawRect(26,0,3,1)
for i=0,mod3-1 do
screen.gammaColor(0,255-i*40,0+i*20)
screen.drawRect(26+i,0,0,1)
end
end
 


 