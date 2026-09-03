-- source: steam id 3792551514 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792551514
sc=screen
sC=sc.setColor
sL=sc.drawLine
sRF=sc.drawRectF
sTB=sc.drawTextBox
sDC=sc.drawCircle
sDCF=sc.drawCircleF
sDT=sc.drawText
iB=input.getBool
iN=input.getNumber
oB=output.setBool
oN=output.setNumber
mf=math.floor
pi=math.pi
sf=string.format
sw,sh=0,0
tTicks,tTL1,tTL2,tFreq=0,0,0,0
tPulse={}
rTgts={}
sweepTrail={}
newCont=false
zoom=property.getNumber('Default Zoom')
radar=false
locat=false
inited=false
zIn,zOut=nil,nil
prevRadar=false
mapOX,mapOY=0,0
cLF=false
showC=false
prevTouched=false
rTTL=300
MAP_COLOR=property.getNumber('Map Color')
RRange=property.getNumber('Radar Range')
GRID=property.getBool('Map Grid')
TOUCH_MOVE=property.getBool('Touch Map Movement')
MCP={
-- 1: Grey
{
    {16,16,16},   -- Ocean
    {30,30,30},   -- Shallow
    {55,55,55},   -- Land
    {35,35,35},   -- Grass
    {65,65,65},   -- Sand
    {180,180,180},-- Snow
    {50,50,50},   -- Rock
    {70,70,70}    -- Gravel
},
-- 2: Faded
{
    {10,30,30},   -- Ocean
    {20,45,55},   -- Shallow
    {60,60,55},   -- Land
    {45,55,30},   -- Grass
    {85,80,35},   -- Sand
    {200,200,200},-- Snow
    {55,55,50},   -- Rock
    {75,70,55}    -- Gravel
},
-- 3: Green
{
    {16,16,16},   -- Ocean
    {10,25,10},   -- Shallow
    {5,35,5},     -- Land
    {0,55,0},     -- Grass
    {0,76,0},     -- Sand
    {0,76,0},     -- Snow
    {15,45,15},   -- Rock
    {25,65,25}    -- Gravel
}
}
MCF={sc.setMapColorOcean,sc.setMapColorShallows,sc.setMapColorLand,sc.setMapColorGrass,sc.setMapColorSand,sc.setMapColorSnow,sc.setMapColorRock,sc.setMapColorGravel}
function gPOC(r,a) return r*math.cos(a*pi/180),r*math.sin(a*pi/180) end
function r2d(a) return(a*180/pi)%360 end
function init()
zIn=cBtn():onPressed(function()
zoom=zoom-0.1
if zoom<0.1 then zoom=0.1 end
end)
zOut=cBtn():onPressed(function()
zoom=zoom+0.1
if zoom>50 then zoom=50 end
end)
inited=true
end
function onTick()
if not inited then init() end
local rawTX=iN(29)
local rawTY=iN(30)
touched=iB(32)
local rawTX=iN(29)
local rawTY=iN(30)
if touched then tX=rawTX;tY=rawTY;lastTX=tX;lastTY=tY else tX=-999;tY=-999 end
local justReleased=not touched and prevTouched
local justTouched=touched and not prevTouched
local rPulse,lPulse=false,false
newCont=false
gpsX=iN(25)
gpsY=iN(26)
cAng=iN(27)
rDir=iN(28)*360
radar=iB(29)
locat=iB(30)
myDir=((-cAng+0.5)*360+180)%360
distOS=zoom*1000
local h2=sh/2
zIn:handleEvents(touched and tX>=0 and tX<=8 and tY>=h2-8 and tY<=h2)
zOut:handleEvents(touched and tX>=0 and tX<=8 and tY>=h2 and tY<=h2+8)
if justReleased then
if lastTX>=sw-8 and lastTX<=sw-2 and lastTY>=h2-8 and lastTY<=h2-2 then
rPulse=true
end
if lastTX>=sw-8 and lastTX<=sw-2 and lastTY>=h2+3 and lastTY<=h2+9 then
lPulse=true
end
if showC and lastTX>=1 and lastTX<=6 and lastTY>=h2+9 and lastTY<=h2+15 then
mapOX,mapOY=0,0
end
end
showC=math.abs(mapOX)>0.5 or math.abs(mapOY)>0.5
if TOUCH_MOVE and touched then
if tX>8 and tX<sw-8 and tY < sh-4 then
local dx=tX-sw/2
local dy=sh/2-tY
local th=math.atan(dy/dx)
if dx<0 then th=th+math.pi end
mapOX=mapOX+math.cos(th)*zoom*12
mapOY=mapOY+math.sin(th)*zoom*12
end
end
if locat then
tTicks=tTicks+1
if iB(31) then
table.insert(tPulse,1)
tTL2=tTL1
tTL1=tTicks
tFreq=tTL1-tTL2
end
else tTicks,tTL1,tTL2,tFreq=0,0,0,0;tPulse={} end
if radar then
table.insert(sweepTrail,1,rDir+myDir-90)
if #sweepTrail>18 then table.remove(sweepTrail) end
for i=1,6 do
if not iB(i) then break end
local b=i*4-3
local dist=iN(b)
local az=r2d(iN(b+1)*(pi*2))
local tx,ty=gPOC(dist,myDir+az-90)
tx,ty=mf(gpsX+tx),mf(gpsY-ty)
local k=tx..":"..ty
if not rTgts[k] then
if dist<=2000 then newCont=true end
rTgts[k]={x=tx,y=ty,ttl=rTTL,az=az,vis=false}
else rTgts[k].ttl=rTTL end
end
local cSD=rDir+myDir
for k,t in pairs(rTgts) do
if not t.vis and(cSD-(myDir+t.az)%360)%360<15 then t.vis=true end
end
else sweepTrail={};rTgts={} end
oN(1,zoom)
oB(1,rPulse)
oB(2,lPulse)
oB(3,newCont)
prevTouched=touched
end
function onDraw()
sw=sc.getWidth()
sh=sc.getHeight()
local mx,my=gpsX+mapOX,gpsY+mapOY
sc.drawMap(mx,my,zoom)
if MAP_COLOR > 0 and MCP[MAP_COLOR] then
    local cp = MCP[MAP_COLOR]
    for i,f in ipairs(MCF) do
        f(cp[i][1],cp[i][2],cp[i][3],200)
end end
if GRID and zoom>0 then
local g=2^(mf(math.log(zoom/0.1953125,2)))*31.25
local xt,yt=mf(mx/g),mf(my/g)
sC(255,255,255,15)
for G=xt-6,xt+6 do
local ox=map.mapToScreen(mx,my,zoom,sw,sh,g*G,my)
sL(ox,0,ox,sh)
end
for H=yt-6,yt+6 do
local _,oy=map.mapToScreen(mx,my,zoom,sw,sh,mx,g*H)
sL(0,oy,sw,oy)
end
end
local ssx,ssy=map.mapToScreen(mx,my,zoom,sw,sh,gpsX,gpsY)
local pxKm=math.max(0.01,math.abs(map.mapToScreen(mx,my,zoom,sw,sh,gpsX+1000,gpsY)-ssx))
if radar then
local rPx=RRange/1000*pxKm
sC(0,170,0,45)
sDC(ssx,ssy,rPx)
for i=1,#sweepTrail do
local tx,ty=gPOC(rPx,sweepTrail[i])
sC(0,200,0,mf(30*(1-i/#sweepTrail)))
sL(ssx,ssy,ssx+tx,ssy+ty)
end
local x1,y1=gPOC(rPx,rDir+myDir-90)
sC(0,200,0)
sL(ssx,ssy,ssx+x1,ssy+y1)
end
if locat then
local r=((tFreq*50-250)/distOS)*math.max(sw,sh)
sC(255,170,0,30)
sDCF(ssx,ssy,r+1)
sC(255,170,0)
sDC(ssx,ssy,r+1)
end
sC(200,0,0)
local x1,y1=gPOC(10,myDir-90)
sL(ssx,ssy,ssx+x1,ssy+y1)
sDC(ssx,ssy,1)
if radar then
for k,t in pairs(rTgts) do
if t.vis then
if MAP_COLOR==3 then
    sC(255,0,0)
else
    sC(0,250,0)
end
local tx,ty=map.mapToScreen(mx,my,zoom,sw,sh,t.x,t.y)
sDCF(tx,ty,1)
end
t.ttl=t.ttl-1
if t.ttl<=0 then rTgts[k]=nil end
end
end
sC(0,0,0,150)
sRF(0,0,sw,7)
if locat then
if #tPulse>0 then
table.remove(tPulse,1)
sC(255,0,0)
sDCF(sw-4,3,2)
sC(150,0,0)
sDC(sw-4,3,2)
else
sC(30,30,30)
sDCF(sw-4,3,2)
sC(0,0,0)
sDC(sw-4,3,2)
end
local td=tFreq*50-250
sC(120,120,120)
sTB(0,0,sw-7,7,td<=-250 and"srch"or(td>999 and sf("%.1f",td/1000).."km"or sf("%.0f",td).."m"),1,0)
end
sC(255,0,0)
sL(3,5,4,5)
sL(3,4,4,4)
sL(2,3,5,3)
sC(120,120,120)
sL(2,2,5,2)
sL(3,1,4,1)
sL(3,0,4,0)
sTB(6,1,sw-1,5,sf("%.0f",myDir),-1,0)
if sw>32 then
sC(200,200,200,150)
local ha,bkm
if sw>sh then
sL(sw/2-17,sh-7,sw/2-17,sh-4)
sL(sw/2+15,sh-7,sw/2+15,sh-4)
sL(sw/2-17,sh-6,sw/2+15,sh-6)
ha=0
bkm=32/pxKm
else
sL(sw-2,sh-14,sw-5,sh-14)
sL(sw-2,sh-5,sw-5,sh-5)
sL(sw-3,sh-14,sw-3,sh-5)
ha=1
bkm=8/pxKm
end
sTB(5,sh-12,sw-10,5,sf("%.1f",bkm).."km",ha,0)
end
local h2=sh/2
sC(0,0,0,150)
sRF(1,h2-8,6,6)
local c=zIn:isPressed()
sC(c and 0 or 120,c and 0 or 120,c and 0 or 120)
sL(4,h2-6,4,h2-3)
sL(3,h2-5,6,h2-5)
sC(0,0,0,150)
sRF(1,h2+1,6,6)
c=zOut:isPressed()
sC(c and 0 or 120,c and 0 or 120,c and 0 or 120)
sL(3,h2+4,6,h2+4)
if showC then
sC(0,0,0,150)
sRF(1,h2+9,6,6)
sC(120,120,120)
sDT(2,h2+10,"C")
end
sC(0,radar and 200 or 0,0,150)
sRF(sw-8,h2-8,6,6)
sC(120,120,120)
sDT(sw-7,h2-7,"R")
sC(0,locat and 200 or 0,0,150)
sRF(sw-8,h2+3,6,6)
sC(120,120,120)
sDT(sw-7,h2+4,"L")
end
function cBtn()
local c,cL=-1,-1
local oD,oP,oU
return{
onDown=function(s,cb) oD=cb;return s end,
onPressed=function(s,cb) oP=cb;return s end,
onUp=function(s,cb) oU=cb;return s end,
isNotPressed=function() return c==-1 and cL==-1 end,
isDown=function() return c==0 end,
isPressed=function() return c>0 end,
isUp=function() return c==-1 and cL>-1 end,
handleEvents=function(s,p)
c=p and(c+1)or -1
if c>100 then c=1 end
if s:isDown()and oD then oD()end
if s:isPressed()and oP then oP()end
if s:isUp()and oU then oU()end
cL=c
end
}
end