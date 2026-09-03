-- source: steam id 3790163661 / vehicle.xml block#5
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
screen.drawRectF(px13,py13,1,1) px13,py13=map.mapToScreen(nx,ny,zoom,w,h,196,-36700)
if zoom>(h/5) then
screen.drawRectF(px1,py1,2,2) px1,py1=map.mapToScreen(nx,ny,zoom,w,h,1705,-26387)--FJ Warner Docks
screen.drawRectF(px2,py2,2,2) px2,py2=map.mapToScreen(nx,ny,zoom,w,h,-4920,-28890)--Clarke airf
end
if zoom<(h/5) then
hx1,hy1=map.mapToScreen(nx,ny,zoom,w,h,1705,-26387)
hx2,hy2=map.mapToScreen(nx,ny,zoom,w,h,1720,-26446)
hx3,hy3=map.mapToScreen(nx,ny,zoom,w,h,1777,-26425)--FJ Warner Dock H
hx4,hy4=map.mapToScreen(nx,ny,zoom,w,h,1760,-26370)
screen.drawTriangleF(hx1,hy1,hx2,hy2,hx3,hy3)
screen.drawTriangleF(hx3,hy3,hx4,hy4,hx1,hy1)
hx1a,hy1a=map.mapToScreen(nx,ny,zoom,w,h,2237,-25957)
hx2a,hy2a=map.mapToScreen(nx,ny,zoom,w,h,2285,-26127)
hx3a,hy3a=map.mapToScreen(nx,ny,zoom,w,h,2370,-26103)--FJ Warner Dock Ha
hx4a,hy4a=map.mapToScreen(nx,ny,zoom,w,h,2324,-25930)
screen.drawTriangleF(hx1a,hy1a,hx2a,hy2a,hx3a,hy3a)
screen.drawTriangleF(hx3a,hy3a,hx4a,hy4a,hx1a,hy1a)

hx1b,hy1b=map.mapToScreen(nx,ny,zoom,w,h,-4920,-28890)
hx2b,hy2b=map.mapToScreen(nx,ny,zoom,w,h,-4880,-28850)
hx3b,hy3b=map.mapToScreen(nx,ny,zoom,w,h,-4921,-28807)--Clarke airf H
hx4b,hy4b=map.mapToScreen(nx,ny,zoom,w,h,-4963,-28847)
screen.drawTriangleF(hx1b,hy1b,hx2b,hy2b,hx3b,hy3b)
screen.drawTriangleF(hx3b,hy3b,hx4b,hy4b,hx1b,hy1b)
hx1ba,hy1ba=map.mapToScreen(nx,ny,zoom,w,h,-5237,-28066)--Clarke airf Ha
screen.drawRectF(hx1ba,hy1ba,1,1)
hx1ba,hy1ba=map.mapToScreen(nx,ny,zoom,w,h,-4703,-28630)--Clarke airf Hb
screen.drawRectF(hx1ba,hy1ba,1,1)

screen.setColor(45,45,45)
fx1,fy1=map.mapToScreen(nx,ny,zoom,w,h,1212,-26729)
fx2,fy2=map.mapToScreen(nx,ny,zoom,w,h,1226,-26785)
fx3,fy3=map.mapToScreen(nx,ny,zoom,w,h,2352,-26485)--FJ Warner Docks F
fx4,fy4=map.mapToScreen(nx,ny,zoom,w,h,2337,-26426)
screen.drawText(fx2*1.1,fy2,"75'")
screen.drawTriangleF(fx1,fy1,fx2,fy2,fx3,fy3)
screen.drawTriangleF(fx3,fy3,fx4,fy4,fx1,fy1)


fx1b,fy1b=map.mapToScreen(nx,ny,zoom,w,h,-4672,-29427)
fx2b,fy2b=map.mapToScreen(nx,ny,zoom,w,h,-4630,-29385)
fx3b,fy3b=map.mapToScreen(nx,ny,zoom,w,h,-5470,-28570)--Clarke airf F
fx4b,fy4b=map.mapToScreen(nx,ny,zoom,w,h,-5496,-28603)
screen.drawText(fx2b*1.1,fy2b,"135'")
screen.drawTriangleF(fx1b,fy1b,fx2b,fy2b,fx3b,fy3b)
screen.drawTriangleF(fx3b,fy3b,fx4b,fy4b,fx1b,fy1b)
end
end
end
end --BAAAXXKOOOO!!!