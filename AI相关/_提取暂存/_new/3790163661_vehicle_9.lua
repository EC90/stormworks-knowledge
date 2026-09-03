-- source: steam id 3790163661 / vehicle.xml block#9
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
screen.setColor(255,5,200)
screen.drawRectF(opx3,opy3,1,1) opx3,opy3=map.mapToScreen(nx,ny,zoom,w,h,-28890,90940)--Oil Data!

screen.setColor(100,30,30)
screen.drawRectF(mtx3,mty3,1,1) mtx3,mty3=map.mapToScreen(nx,ny,zoom,w,h,-24898,92010)--mineral sell
screen.drawRectF(mtx4,mty4,1,1) mtx4,mty4=map.mapToScreen(nx,ny,zoom,w,h,-28514,90577)

screen.setColor(255,70,0)
screen.drawRectF(tex1,tey1,1,1) tex1,tey1=map.mapToScreen(nx,ny,zoom,w,h,-33035,88025)--terminals

screen.setColor(255,10,10)
screen.drawRectF(mx1,my1,1,1) mx1,my1=map.mapToScreen(nx,ny,zoom,w,h,-29365,89750)--medic

screen.setColor(255,170,30)
screen.drawRectF(gx4,gy4,1,1) gx4,gy4=map.mapToScreen(nx,ny,zoom,w,h,-24927,91983)
screen.drawRectF(gx5,gy5,1,1) gx5,gy5=map.mapToScreen(nx,ny,zoom,w,h,-32996,88127)
screen.drawRectF(gx6,gy6,1,1) gx6,gy6=map.mapToScreen(nx,ny,zoom,w,h,-29399,89719)--gas
screen.drawRectF(gx7,gy7,1,1) gx7,gy7=map.mapToScreen(nx,ny,zoom,w,h,-28817,90987)
screen.drawRectF(gx8,gy8,1,1) gx8,gy8=map.mapToScreen(nx,ny,zoom,w,h,-31202,91291)

screen.setColor(30,180,255)
screen.drawRectF(tx5,ty5,1,1) tx5,ty5=map.mapToScreen(nx,ny,zoom,w,h,-30848,91303)--fish sell

screen.setColor(10,255,30)
screen.drawRectF(Dx1,Dy1,1,1) Dx1,Dy1=map.mapToScreen(nx,ny,zoom,w,h,-31104,91224)--fish data

screen.setColor(25,45,155)
screen.drawRectF(px3,py3,1,1) px3,py3=map.mapToScreen(nx,ny,zoom,w,h,-30795,91245)
screen.drawRectF(px4,py4,1,1) px4,py4=map.mapToScreen(nx,ny,zoom,w,h,-28997,89620)
screen.drawRectF(px5,py5,1,1) px5,py5=map.mapToScreen(nx,ny,zoom,w,h,-28628,90675)

if zoom>(h/5) then
screen.drawRectF(px1,py1,2,2) px1,py1=map.mapToScreen(nx,ny,zoom,w,h,-31153,91237)--Ta airbase
end
if zoom<(h/5) then
hx1,hy1=map.mapToScreen(nx,ny,zoom,w,h,-31153,91237)
hx2,hy2=map.mapToScreen(nx,ny,zoom,w,h,-31114,91270)
hx3,hy3=map.mapToScreen(nx,ny,zoom,w,h,-31155,91317)--Ta airbase H
hx4,hy4=map.mapToScreen(nx,ny,zoom,w,h,-31193,91283)
screen.drawTriangleF(hx1,hy1,hx2,hy2,hx3,hy3)
screen.drawTriangleF(hx3,hy3,hx4,hy4,hx1,hy1)

screen.setColor(45,45,45)
fx1,fy1=map.mapToScreen(nx,ny,zoom,w,h,-30675,90540)
fx2,fy2=map.mapToScreen(nx,ny,zoom,w,h,-30635,90577)
fx3,fy3=map.mapToScreen(nx,ny,zoom,w,h,-31415,91438)--Ta airbase F
fx4,fy4=map.mapToScreen(nx,ny,zoom,w,h,-31457,91404)
screen.drawText(fx2,fy2,"135'")
screen.drawTriangleF(fx1,fy1,fx2,fy2,fx3,fy3)
screen.drawTriangleF(fx3,fy3,fx4,fy4,fx1,fy1)
end
end