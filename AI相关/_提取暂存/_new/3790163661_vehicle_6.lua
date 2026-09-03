-- source: steam id 3790163661 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3790163661
function onTick()
x=input.getNumber(1)
y=input.getNumber(2)
zoom=input.getNumber(4)
nx=math.floor(input.getNumber(5))
ny=math.floor(input.getNumber(6))
DL=property.getBool("Show desert lands")

if DL then
function onDraw()
w=screen.getWidth()
h=screen.getHeight()
screen.setColor(100,30,30)
screen.drawRectF(tx3,ty3,1,1) tx3,ty3=map.mapToScreen(nx,ny,zoom,w,h,-11430,-34205)--mineral sell

screen.setColor(255,70,0)
screen.drawRectF(tex1,tey1,1,1) tex1,tey1=map.mapToScreen(nx,ny,zoom,w,h,2017,-25990)
screen.drawRectF(tex2,tey2,1,1) tex2,tey2=map.mapToScreen(nx,ny,zoom,w,h,262,-36717)--terminals

screen.setColor(255,10,10)
screen.drawRectF(mx1,my1,1,1) mx1,my1=map.mapToScreen(nx,ny,zoom,w,h,-7692,-31102)--medic
screen.drawRectF(mx2,my2,1,1) mx2,my2=map.mapToScreen(nx,ny,zoom,w,h,-19947,-26644)

screen.setColor(30,30,30)
screen.drawRectF(ox1,oy1,1,1) ox1,oy1=map.mapToScreen(nx,ny,zoom,w,h,-1290,-26362)
screen.drawRectF(ox2,oy2,1,1) ox2,oy2=map.mapToScreen(nx,ny,zoom,w,h,-173,-36085)--oil deposits
screen.drawRectF(ox3,oy3,1,1) ox3,oy3=map.mapToScreen(nx,ny,zoom,w,h,-15630,-29000)
screen.drawRectF(ox4,oy4,1,1) ox4,oy4=map.mapToScreen(nx,ny,zoom,w,h,-20588,-27989)

screen.setColor(255,170,30)
screen.drawRectF(tx4,ty4,1,1) tx4,ty4=map.mapToScreen(nx,ny,zoom,w,h,-15873,-25060)--gas sell

screen.setColor(30,180,255)
screen.drawRectF(tx5,ty5,1,1) tx5,ty5=map.mapToScreen(nx,ny,zoom,w,h,2035,-25840)
screen.drawRectF(tx6,ty6,1,1) tx6,ty6=map.mapToScreen(nx,ny,zoom,w,h,260,-36762)--fish sell
screen.drawRectF(tx7,ty7,1,1) tx7,ty7=map.mapToScreen(nx,ny,zoom,w,h,-16350,-24882)

screen.setColor(10,255,30)
screen.drawRectF(Dx1,Dy1,1,1) Dx1,Dy1=map.mapToScreen(nx,ny,zoom,w,h,-13035,-34795)--fish data

screen.setColor(25,45,155)
screen.drawRectF(px3,py3,1,1) px3,py3=map.mapToScreen(nx,ny,zoom,w,h,-6376,-32868)
screen.drawRectF(px4,py4,1,1) px4,py4=map.mapToScreen(nx,ny,zoom,w,h,-17857,-33464)
screen.drawRectF(px5,py5,1,1) px5,py5=map.mapToScreen(nx,ny,zoom,w,h,-16060,-30350)
screen.drawRectF(px6,py6,1,1) px6,py6=map.mapToScreen(nx,ny,zoom,w,h,-11734,-29735)
screen.drawRectF(px7,py7,1,1) px7,py7=map.mapToScreen(nx,ny,zoom,w,h,-12175,-29711)
screen.drawRectF(px8,py8,1,1) px8,py8=map.mapToScreen(nx,ny,zoom,w,h,2720,-29785)
screen.drawRectF(px9,py9,1,1) px9,py9=map.mapToScreen(nx,ny,zoom,w,h,-12743,-34025)
screen.drawRectF(px10,py10,1,1) px10,py10=map.mapToScreen(nx,ny,zoom,w,h,-21172,-31631)
screen.drawRectF(px11,py11,1,1) px11,py11=map.mapToScreen(nx,ny,zoom,w,h,-19315,-26377)
screen.drawRectF(px12,py12,1,1) px12,py12=map.mapToScreen(nx,ny,zoom,w,h,-12940,-26090)
if zoom>(h/5) then
screen.drawRectF(px1,py1,2,2) px1,py1=map.mapToScreen(nx,ny,zoom,w,h,-16970,-35100)--En airbase
end
if zoom<(h/5) then
hx1,hy1=map.mapToScreen(nx,ny,zoom,w,h,-16885,-35100)
hx2,hy2=map.mapToScreen(nx,ny,zoom,w,h,-16969,-35100)
hx3,hy3=map.mapToScreen(nx,ny,zoom,w,h,-16927,-35140)--En airbase H
hx4,hy4=map.mapToScreen(nx,ny,zoom,w,h,-16927,-35057)
screen.drawTriangleF(hx1,hy1,hx2,hy2,hx4,hy4)
screen.drawTriangleF(hx3,hy3,hx2,hy2,hx1,hy1)
screen.setColor(45,45,45)
fx1,fy1=map.mapToScreen(nx,ny,zoom,w,h,-16678,-34520)
fx2,fy2=map.mapToScreen(nx,ny,zoom,w,h,-16640,-34557)
fx3,fy3=map.mapToScreen(nx,ny,zoom,w,h,-17463,-35386)--En airbase F
fx4,fy4=map.mapToScreen(nx,ny,zoom,w,h,-17503,-35345)
screen.drawText(fx2*1.1,fy2,"45'")
screen.drawTriangleF(fx1,fy1,fx2,fy2,fx3,fy3)
screen.drawTriangleF(fx3,fy3,fx4,fy4,fx1,fy1)
end
end
end
end