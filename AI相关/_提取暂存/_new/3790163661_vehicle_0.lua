-- source: steam id 3790163661 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3790163661
sin=math.sin
cos=math.cos
pi=math.pi
function onTick()
x=input.getNumber(1)
y=input.getNumber(2)
z=math.floor(input.getNumber(3))
zoom=input.getNumber(4)
TSx=input.getNumber(5)
TSy=input.getNumber(6)
nx=math.floor(input.getNumber(7))
ny=math.floor(input.getNumber(8))
comp=input.getNumber(9)
TS=input.getBool(1)
VC=input.getBool(2)
SWCOO=property.getBool("Show coordinates")
SWKM=property.getBool("Show Km grid")
ARS=property.getNumber("Compass arrow size")
output.setNumber(1,wx)
output.setNumber(2,wy)
nnn=(math.floor(math.log(math.abs(nx))/math.log(10)+1))*6
if math.abs(nx)-9 < 9 then nnn=10 end
if nx==1000 or nx==-1000 then nnn=24 end
if nx<0 then nnn=nnn+5 end
nnnz=(math.floor(math.log(math.abs(ny))/math.log(10)+1))*6
if math.abs(ny)-9 < 9 then nnnz=10 end
if ny==1000 or ny==-1000 then nnnz=24 end
if ny<0 then nnnz=nnnz+5 end
rad=(comp+90)*(pi/180)
rad2=(comp-48)*(pi/180)
rad3=(comp-132)*(pi/180)
t1x=ARS*cos(rad)
t1y=ARS*sin(rad)
t2x=ARS*cos(rad2)
t2y=ARS*sin(rad2)
t3x=ARS*cos(rad3)
t3y=ARS*sin(rad3)
VCX=1000*cos(rad)
VCY=1000*sin(rad)

if TS then wx,wy=map.screenToMap(nx, ny, zoom, w, h, TSx, TSy) end
pX, pY=map.mapToScreen(nx, ny, zoom, w, h, wx, wy)
arx, ary=map.mapToScreen(nx, ny, zoom, w, h, x, y+z)
arx1, arys=map.mapToScreen(nx, ny, zoom, w, h, x, y)
function onDraw()
screen.setColor(255, 255, 255)
w = screen.getWidth()
h = screen.getHeight()
screen.drawRectF(w/2, h/2, 1, 1)

if SWCOO then
screen.setColor(0, 0, 0, 80)
screen.drawRectF(5, h-8, w, 8)
screen.setColor(255, 255, 255)
screen.drawText(7, h-5, "x")
screen.drawText(12, h-5, nx)
screen.drawText(nnn+10, h-5, "y")
screen.drawText(nnn+14, h-5, ny)
screen.drawText(nnn+nnnz+12, h-5, "h")
screen.drawText(nnn+nnnz+17, h-5, z)
end
screen.setColor(0, 0, 0, 80)
screen.drawTriangleF(arx+t1x, arys+t1y, arx+t2x, arys+t2y, arx+t3x, arys+t3y)
screen.setColor(255, 255, 255)
screen.drawTriangleF(arx+t1x, ary+t1y, arx+t2x, ary+t2y, arx+t3x, ary+t3y)
if ary<2 then ary1=0 if ary>2 then ary1=2 end end
screen.drawLine(arx, arys-2, arx, ary+ARS-2)
if math.abs(x-nx)>=100 and math.abs(y-ny)>=100 then
screen.setColor(255, 255, 255)
xl=(w/2)-arx1	yl=(h/2)-arys	L=math.sqrt(xl^2+yl^2)
lx=(xl/L)*10	ly=(yl/L)*10
screen.drawLine((w/2)-(lx/2), (h/2)-(ly/2), (w/2)-lx, (h/2)-ly)
end
if VC then
screen.setColor(255, 0, 255, 80)
screen.drawLine(arx1,arys,arx1+VCX,arys+VCY)
end


if SWKM then
kkm=math.floor((zoom/10)*2)
if kkm==0 then kkm=kkm+1 end
xr=(math.floor(nx/(1000*kkm)))*(1000*kkm)
yr=(math.floor(ny/(1000*kkm)))*(1000*kkm)
gx,gy=map.mapToScreen(nx,ny,zoom,w,h,xr,yr)
gx1,gy1=map.mapToScreen(nx,ny,zoom,w,h,xr+1000*kkm,yr+1000*kkm)
gx2,gy2=map.mapToScreen(nx,ny,zoom,w,h,xr+2000*kkm,yr+2000*kkm)
gx3,gy3=map.mapToScreen(nx,ny,zoom,w,h,xr+3000*kkm,yr+3000*kkm)
gx4,gy4=map.mapToScreen(nx,ny,zoom,w,h,xr+4000*kkm,yr+4000*kkm)
gx5,gy5=map.mapToScreen(nx,ny,zoom,w,h,xr+5000*kkm,yr+5000*kkm)
gx01,gy01=map.mapToScreen(nx,ny,zoom,w,h,xr-1000*kkm,yr-1000*kkm)
gx02,gy02=map.mapToScreen(nx,ny,zoom,w,h,xr-2000*kkm,yr-2000*kkm)
gx03,gy03=map.mapToScreen(nx,ny,zoom,w,h,xr-3000*kkm,yr-3000*kkm)
gx04,gy04=map.mapToScreen(nx,ny,zoom,w,h,xr-4000*kkm,yr-4000*kkm)
gx05,gy05=map.mapToScreen(nx,ny,zoom,w,h,xr-5000*kkm,yr-5000*kkm)
screen.setColor(0,0,0,30)
screen.drawLine(gx,0,gx,h)
screen.drawLine(gx1,0,gx1,h)
screen.drawLine(gx2,0,gx2,h)
screen.drawLine(gx3,0,gx3,h)
screen.drawLine(gx4,0,gx4,h)
screen.drawLine(gx5,0,gx5,h)
screen.drawLine(gx01,0,gx01,h)
screen.drawLine(gx02,0,gx02,h)
screen.drawLine(gx03,0,gx03,h)
screen.drawLine(gx04,0,gx04,h)
screen.drawLine(gx05,0,gx05,h)
screen.drawLine(0,gy,w,gy)
screen.drawLine(0,gy1,w,gy1)
screen.drawLine(0,gy2,w,gy2)
screen.drawLine(0,gy3,w,gy3)
screen.drawLine(0,gy4,w,gy4)
screen.drawLine(0,gy5,w,gy5)
screen.drawLine(0,gy01,w,gy01)
screen.drawLine(0,gy02,w,gy02)
screen.drawLine(0,gy03,w,gy03)
screen.drawLine(0,gy04,w,gy04)
screen.drawLine(0,gy05,w,gy05)
k=5 if kkm>9 then k=k+5 end
screen.drawText(w-k,1,kkm)
end end end