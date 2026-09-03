-- source: steam id 3790163661 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3790163661
function onTick()
x=input.getNumber(1)
y=input.getNumber(2)
zoom=input.getNumber(4)
nx=math.floor(input.getNumber(5))
ny=math.floor(input.getNumber(6))
end
function onDraw()
w=screen.getWidth()
h=screen.getHeight()
screen.setColor(100,30,30)
screen.drawRectF(tx3,ty3,1,1) tx3,ty3=map.mapToScreen(nx,ny,zoom,w,h,3765,-5321)--mineral sell

screen.setColor(255,70,0)
screen.drawRectF(tex1,tey1,1,1) tex1,tey1=map.mapToScreen(nx,ny,zoom,w,h,7155,-10404)
screen.drawRectF(tex2,tey2,1,1) tex2,tey2=map.mapToScreen(nx,ny,zoom,w,h,1303,-3590)--terminals

screen.setColor(255,10,10)
screen.drawRectF(mx1,my1,1,1) mx1,my1=map.mapToScreen(nx,ny,zoom,w,h,7087,-9715)
screen.drawRectF(mx2,my2,1,1) mx2,my2=map.mapToScreen(nx,ny,zoom,w,h,-4,-4760)--medic

screen.setColor(255,170,30)
screen.drawRectF(gx4,gy4,1,1) gx4,gy4=map.mapToScreen(nx,ny,zoom,w,h,6866,-9725)
screen.drawRectF(gx5,gy5,1,1) gx5,gy5=map.mapToScreen(nx,ny,zoom,w,h,7131,-10430)
screen.drawRectF(gx6,gy6,1,1) gx6,gy6=map.mapToScreen(nx,ny,zoom,w,h,-5565,-3490)--gas
screen.drawRectF(gx7,gy7,1,1) gx7,gy7=map.mapToScreen(nx,ny,zoom,w,h,234,-4905)

screen.setColor(30,180,255)
screen.drawRectF(tx5,ty5,1,1) tx5,ty5=map.mapToScreen(nx,ny,zoom,w,h,1350,-3585)
screen.drawRectF(tx6,ty6,1,1) tx6,ty6=map.mapToScreen(nx,ny,zoom,w,h,60,-4920)--fish sell
screen.drawRectF(tx7,ty7,1,1) tx7,ty7=map.mapToScreen(nx,ny,zoom,w,h,7116,-10424)

screen.setColor(10,255,30)
screen.drawRectF(Dx1,Dy1,1,1) Dx1,Dy1=map.mapToScreen(nx,ny,zoom,w,h,7082,-9725)--fish data

screen.setColor(25,45,155)
screen.drawRectF(px3,py3,1,1) px3,py3=map.mapToScreen(nx,ny,zoom,w,h,1278,-3582)
screen.drawRectF(px4,py4,1,1) px4,py4=map.mapToScreen(nx,ny,zoom,w,h,1310,-3765)
screen.drawRectF(px5,py5,1,1) px5,py5=map.mapToScreen(nx,ny,zoom,w,h,4364,-5637)
screen.drawRectF(px6,py6,1,1) px6,py6=map.mapToScreen(nx,ny,zoom,w,h,7185,-10386)

if zoom>(h/5) then
screen.drawRectF(px1,py1,2,2) px1,py1=map.mapToScreen(nx,ny,zoom,w,h,4106,-5940)--April On airbase
screen.drawRectF(px2,py2,2,2) px2,py2=map.mapToScreen(nx,ny,zoom,w,h,-5892,-6057)--Har airbase
end
if zoom<(h/5) then
hx1,hy1=map.mapToScreen(nx,ny,zoom,w,h,4106,-5940)
hx2,hy2=map.mapToScreen(nx,ny,zoom,w,h,4147,-5898)
hx3,hy3=map.mapToScreen(nx,ny,zoom,w,h,4105,-5856)--On airbase H
hx4,hy4=map.mapToScreen(nx,ny,zoom,w,h,4064,-5898)
screen.drawTriangleF(hx1,hy1,hx2,hy2,hx3,hy3)
screen.drawTriangleF(hx3,hy3,hx4,hy4,hx1,hy1)

hx1a,hy1a=map.mapToScreen(nx,ny,zoom,w,h,-5893,-6141)
hx2a,hy2a=map.mapToScreen(nx,ny,zoom,w,h,-5851,-6100)
hx3a,hy3a=map.mapToScreen(nx,ny,zoom,w,h,-5892,-6057)--Har airbase H
hx4a,hy4a=map.mapToScreen(nx,ny,zoom,w,h,-5934,-6100)
screen.drawTriangleF(hx1a,hy1a,hx2a,hy2a,hx3a,hy3a)
screen.drawTriangleF(hx3a,hy3a,hx4a,hy4a,hx1a,hy1a)

screen.setColor(45,45,45)
fx1,fy1=map.mapToScreen(nx,ny,zoom,w,h,4346,-6478)
fx2,fy2=map.mapToScreen(nx,ny,zoom,w,h,4384,-6441)
fx3,fy3=map.mapToScreen(nx,ny,zoom,w,h,3557,-5616)--On airbase F
fx4,fy4=map.mapToScreen(nx,ny,zoom,w,h,3522,-5658)
screen.drawText(fx2,fy2,"135'")
screen.drawTriangleF(fx1,fy1,fx2,fy2,fx3,fy3)
screen.drawTriangleF(fx3,fy3,fx4,fy4,fx1,fy1)

fx1a,fy1a=map.mapToScreen(nx,ny,zoom,w,h,-6433,-6383)
fx2a,fy2a=map.mapToScreen(nx,ny,zoom,w,h,-6472,-6345)
fx3a,fy3a=map.mapToScreen(nx,ny,zoom,w,h,-5650,-5516)--Har airbase F
fx4a,fy4a=map.mapToScreen(nx,ny,zoom,w,h,-5610,-5558)
screen.drawText(fx4a*1.1,fy4a,"45'")
screen.drawTriangleF(fx1a,fy1a,fx2a,fy2a,fx3a,fy3a)
screen.drawTriangleF(fx3a,fy3a,fx4a,fy4a,fx1a,fy1a)
end
end