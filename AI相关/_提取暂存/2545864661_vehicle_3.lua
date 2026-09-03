-- source: steam id 2545864661 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2545864661
max = property.getNumber("max waypoints")
plav = property.getNumber("smoot")
xmm = 0
ymm = 0
function legV(v)
local x=v[1]
local y=v[2]
return math.sqrt(x*x+y*y)
end
function t5(x1,y1,x2,y2,x,y)
vector = {x2-x1,y2-y1}
Vnorm = {vector[1]/legV(vector),vector[2]/legV(vector)}
startLV = {x2-x,y2-y}
RAN = startLV[1]*Vnorm[1]+startLV[2]*Vnorm[2]
target = {x2-Vnorm[1]*(RAN-plav),y2-Vnorm[2]*(RAN-plav)}
return target,RAN
end
function tuth(x,y,xx,yy,w,h,tut)
ret = x>=xx and x<=xx+w and y >= yy and y <= yy+h and tut 
return ret
end
zoom = 1
zoomm = 1
xm = 0
ym = 0
wayp={}
for i = 1,max,1 do
wayp[i]={0,0}
end
wayc=0
cen = true
wayr = false
dist = 0
bacway = {0,0}
target = {0,0}
ipn = input.getNumber
ipb = input.getBool
tim = 0
nzm = true
mov = false
function onTick()
scs = 0
w = ipn(1)
h = ipn(2)
x = ipn(3)
y = ipn(4)
disco = -ipn(8)*math.pi*2 - math.pi/2
gpsx = ipn(6)
gpsy = ipn(7)
clik = ipb(1)
clk2 = ipb(2)
x2c = ipn(10)
tut = not clik and tim > 0 and tim < 30 and nzm

if clk2 then
nzm = false
	if y > x2c and zoomm < 50 then
	zoomm = zoomm + 0.1
	end
	if y < x2c and zoomm > 0.2 then
	zoomm = zoomm - 0.1
	end
end

if clik then
tim = tim + 1
else
tim = 0
nzm = true
end
hold = tim > 30 and nzm

if ipb(32) and wayc < max then
wayc = wayc + 1
if wayc == 1 then
bacway = {gpsx,gpsy}
end
wayp[wayc]= {ipn(15),ipn(16)}
wayr = true
cen = false
end
if ipb(4) then
bacway = {gpsx,gpsy}
end
target,RAN = t5(bacway[1],bacway[2],wayp[1][1],wayp[1][2],gpsx,gpsy)


if cen then
xm = gpsx
ym = gpsy
end
if wayr then
xm = wayp[wayc][1]
ym = wayp[wayc][2]
end

if hold then
xm, ym = map.screenToMap(xmm,ymm,zoom,w,h,x,y)
cen = false
wayr = false
mov = true
elseif mov then
xm, ym = xmm, ymm
mov = false
end

if tuth(x,y,w-8,h-22,8,8,tut) then 
cen = true
wayr = false
elseif tuth(x,y,w-8,h-11,8,8,tut) then 
wayc=0
cen = true
dist = 0
wayr = false
elseif tuth(x,y,w-8,h-33,8,8,tut) then 
if wayc ~= 0 then
wayr = true
cen = false
wayc = wayc - 1
if wayc == 0 then
cen = true
dist = 0
wayr = false
end
end
elseif tut and wayc < max then
wayc = wayc + 1
if wayc == 1 then
bacway = {gpsx,gpsy}
end
wayp[wayc]={map.screenToMap(xmm,ymm,zoom,w,h,x,y)}
wayr = true
cen = false
end
zoom = zoom + (zoomm - zoom)*0.2
o=output
osn = o.setNumber
o.setBool(1,wayc~=0)
osn(1,target[1])
osn(2,target[2])
osn(5,xmm)
osn(6,ymm)
osn(7,zoom)
sig = false
if wayc ~= 0 then
dist = math.sqrt((gpsx-wayp[1][1])^2+(gpsy-wayp[1][2])^2)
for WD=2,wayc,1 do
dist=dist+legV({wayp[WD-1][1]-wayp[WD][1],wayp[WD-1][2]-wayp[WD][2]})
end
if RAN<0 then
bacway={wayp[1][1],wayp[1][2]}
wayc=wayc-1
if wayc==0 then
wayr=false
dist=0
end
for i=1,max-1,1 do
wayp[i]=wayp[i+1]
end
end
end
osn(8,dist)
osn(9,RAN)
end

SC = screen.setColor
s = screen
mts = map.mapToScreen
function onDraw()
w = s.getWidth()
if w>60 then
scs = scs + 1				  
h = s.getHeight()	
if scs==1 then
xmm=xmm+(xm-xmm)*0.05
ymm=ymm+(ym-ymm)*0.05
end
SC(1, 1, 1)
if wayc ~=0 then
for i=1,wayc,1 do
xp1,yp1 = mts(xmm, ymm, zoom, w, h, wayp[i][1], wayp[i][2])		
if i == 1 then
xp2,yp2 = xp,yp
else
xp2,yp2 = mts(xmm, ymm, zoom, w, h, wayp[i-1][1], wayp[i-1][2])
end
s.drawCircle(xp1,yp1, 3)
s.drawLine(xp1, yp1, xp2, yp2)
end
end
SC(25, 0, 0)
xp,yp = mts(xmm, ymm, zoom, w, h, gpsx, gpsy)
screen.drawTriangleF(xp + math.cos(disco) * 10, yp + math.sin(disco) *10 , xp + math.cos(disco - math.pi/2) * 3, yp + math.sin(disco - math.pi/2) *3 ,xp + math.cos(disco + math.pi/2) * 3, yp + math.sin(disco + math.pi/2) *3 )
SC(20, 20, 10)
if dist > 2000 then
s.drawText(3,4,"".. (dist/1000)-(dist/1000)%0.1 .. " km")
else
s.drawText(3,4,"".. math.floor(dist) .. " m")
end	

end
end


