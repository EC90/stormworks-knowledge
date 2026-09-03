-- source: steam id 2800117544 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2800117544
i=input
ign=i.getNumber
igb=i.getBool
o=output
osb=o.setBool
osn=o.setNumber
pi=math.pi
pi2=pi*2
s=screen
m=math
ssc=s.setColor
stt=s.drawText
stb=s.drawTextBox
srf=s.drawRectF
srr=s.drawRect
sdl=s.drawLine
fom=string.format
pi=m.pi
pi2=pi*2
mx=0
my=0
tx=0
ty=0
px1=0
py1=0
w=64
h=64
ax=0
ay=0
mxold=0
myold=0
zoom=1
lock=true
old=false
target=false
target1=false
view=false
view1=false
function onTick()
inputX=ign(1)
inputY=ign(2)
sx=ign(3)
sy=ign(4)
selectedx=ign(5)
selectedy=ign(6)
keyx=ign(7)
keyy=ign(8)
old=touch
touch=igb(1)
showdata=igb(2)

if showdata then view=false end

key=igb(3)
jtacx=ign(10)
jtacy=ign(11)
jtac=igb(5)
minputX=inputX-w/2
minputY=inputY-h/2
zin=button(inputX,inputY,1,h-8,6,6,touch)
zout=button(inputX,inputY,9,h-8,6,6,touch)
reset=button(inputX,inputY,17,h-8,5,6,touch)and not target and not view
targetold=target1
target1=button(inputX,inputY,w-8,h-8,6,6,touch)
targetpulse=target1
and not targetold
if targetpulse and not view then
target=not
target and not showdata 
end
viewold=view1
view1=button(inputX,inputY,w-16,h-8,6,6,touch)and not target
viewpulse=view1
and not viewold
if viewpulse then
view=not
view and not showdata 
end
if zin and zoom>0.5 then
zoom=zoom-0.06 
end
if zout and zoom<25 then
zoom=zoom+0.06 
end
if touch and not lock and not button(inputX,inputY,0,h-9,w,10,touch)and not reset and not target then
mx1=mx+minputX*zoom/1.5
my1=my+-minputY*zoom/1.5 
elseif lock and not target then
mx1=sx
my1=sy
end
if view then
averagex=ax
averagey=ay
elseif showdata then
averagex=selectedx
averagey=selectedy
elseif not view and not showdata then
averagex=mx1
averagey=my1
end
mx=averagex*0.35+mxold*0.65
mxold=averagex
my=averagey*0.35+myold*0.65
myold=averagey
if touch and not button(inputX,inputY,0,h-9,w,10,touch)and not target then
lock=false
end
if reset then
lock=true
end
if target and touch and not button(inputX,inputY,0,h-9,w,10,touch)then
tx,ty=map.screenToMap(mx,my,zoom,w,h,inputX,inputY)
end
px1,py1=map.mapToScreen(mx,my,zoom,w,h,tx,ty)
pa=m.atan(px1-w/2,py1-h/2)
pa1=m.atan(py1-h/2,px1-w/2)
pd=((px1-w/2)^2+(py1-h/2)^2)^0.5
pxd=m.min(h/2,pd)
pyd=m.min(w/2,pd)
px=m.sin(pa)*pxd+w/2
py=m.cos(pa)*pyd+h/2
sxp,syp=map.mapToScreen(mx,my,zoom,w,h,sx,sy)
ax=(tx+sx)/2
ay=(ty+sy)/2
axp,ayp=map.mapToScreen(mx,my,zoom,w,h,ax,ay)
trued=((tx-sx)^2+(ty-sy)^2)^0.5
if key then
tx=keyx
ty=keyy
end
if jtac then
tx,ty=jtacx,jtacy
osn(4,jtacx)
osn(5,jtacy)else 
if not(tx==keyx and ty==keyy)then
osn(4,tx)
osn(5,ty)else osn(4,keyx)
osn(5,keyy)
end
end
osn(6,sx)
osn(7,sy)
osn(8,ign(9))
osn(9,trued)
end

function onDraw()
s.setMapColorOcean(0,15,20)
s.setMapColorShallows(5,15,25)
s.setMapColorLand(50,60,50)
s.setMapColorGrass(70,80,70)
s.setMapColorSand(70,70,60)
s.setMapColorSnow(80,60,60)
s.drawMap(mx,my,zoom)
if showdata then
ssc(210,2,2,240)
srf(w/2-1,h/2-1,3,3)
end
if target then
ssc(255,255,255)
srr(px-1,py-1,3,3)
elseif not target and not lock then
ssc(255,255,255)
srr(px,py,1,1)
end
ssc(16.5,16.5,16.5,225)
srf(0,h-9,w,10)
highlight(zin)
sdl(2,h-5,7,h-5)
sdl(4,h-7,4,h-2)
highlight(zout)
sdl(10,h-5,15,h-5)
ssc(255,255,255)
stt(1,h-15,string.format("%.0fKM"
,zoom))
if not showdata then
highlight(target)
sdl(w-7,h-7,w-2,h-7)
sdl(w-5,h-7,w-5,h-2)
end
if not lock and not showdata then
highlight(reset)
s.drawText(18,h-7,"R"
)
end
if lock and not view and not showdata then
ssc(255,255,255)
sdl(sxp,syp,px1,py1)
end
if view and not showdata then
size=0.5-250/trued/2*zoom
ssc(255,255,255)
sdl(sxp,syp,lerp(sxp,px1,size),lerp(syp,py1,size))
sdl(lerp(sxp,px1,1-size),lerp(syp,py1,1-size),px1,py1)
s.drawTextBox(axp-16,ayp-2.5,32,5,string.format("%.0fKM"
,trued/1000),0,0)
end
if not target and not showdata then
highlight(view)
sdl(w-13,h-3,w-10,h-8)
sdl(w-13,h-3,w-16,h-8)
end
end

function highlight(h)
if h then
s.setColor(90,90,90)else screen.setColor(255,255,255)
end
end

function button(a,b,c,d,e,f,g)
return a>=c and b>=d and a<=c+e and b<=d+f and g 
end

function clamp(j,k,l)
return m.max(k,m.min(j,l))
end

function lerp(j,k,l)
return j+(k-j)*l end