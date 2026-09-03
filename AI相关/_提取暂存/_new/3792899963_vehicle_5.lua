-- source: steam id 3792899963 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792899963
m=math
pi=m.pi
pi2=pi*2
i=input
o=output
ign=i.getNumber
igb=i.getBool
osn=o.setNumber
osb=o.setBool
pgn=property.getNumber

dst={}
azm={}
elv={}
tgt={}
queue={}
contacts={}

tick=1
history=600
drawWindow=180
zoom=4

function vec(x,y,z) return {x=x or 0,y=y or 0,z=z or 0,
add=function(a,b) return vec(a.x+b.x,a.y+b.y,a.z+b.z) end,
sub=function(a,b) return vec(a.x-b.x,a.y-b.y,a.z-b.z) end,
scale=function(a,b) return vec(a.x*b,a.y*b,a.z*b) end,
dot=function(a,b) return (a.x*b.x+a.y*b.y+a.z*b.z) end,
cross=function(a,b) return vec(a.y*b.z-a.z*b.y,a.z*b.x-a.x*b.z,a.x*b.y-a.y*b.x) end,
len=function(a) return a:dot(a)^0.5 end,
normalize=function(a) return a:scale(1/a:len()) end,
unpack=function(a,...) return a.x,a.y,a.z,... end,
clone=function(a)return vec(a.x,a.y,a.z) end,
mult=function(a,b)return vec(a.x*b.x,a.y*b.y,a.z*b.z) end,
reject=function(a,b)return a:sub(b:scale(a:dot(b))) end,
tolocal=function(a,f,u,r)return vec(r:dot(a),f:dot(a),u:dot(a)) end,
toglobal=function(a,f,u,r)return r:scale(a.x):add(f:scale(a.y)):add(u:scale(a.z)) end} end

function rad2xyz(dst,azm,elv)
lVec=vec(m.sin(azm*pi2)*m.cos(elv*pi2)*dst,m.cos(azm*pi2)*m.cos(elv*pi2)*dst,m.sin(elv*pi2)*dst)
gVec=lVec:toglobal(f,u,r)
if gVec:len()>pgn("Minimum Range") then
return pos:add(gVec)
else return vec()
end
end

function turnsToRad(t) return t*pi2 end

function rot2d(x,y,cx,cy,a)
s,c = m.sin(a), m.cos(a)
dx,dy = x-cx,y-cy
return cx+dx*c-dy*s,cy+dx*s+dy*c
end

function pushContact(tickIndex, v)
if v and v:len()>0 then
bucket=contacts[tickIndex]
if not bucket then
bucket={}
contacts[tickIndex]=bucket
end
bucket[#bucket+1]=v:clone()
end
end

function pruneContacts(nowTick)
cutoff=nowTick-history
if cutoff <= 0 then return end
for t=1,cutoff do
contacts[t]=nil
end
end

function formatZoom(z)
    if z>=1 then
        return tostring(m.floor(z + 0.5))
    else
        return string.format("%.1f", z)
    end
end

function onTick()
    pos=vec(ign(1),ign(3),ign(2))
    rx,ry,rz=ign(4),ign(5),ign(6)
    cx,cy,cz,sx,sy,sz=m.cos(rx),m.cos(ry),m.cos(rz),m.sin(rx),m.sin(ry),m.sin(rz)
    r=vec(cy*cz,-sy,cy*sz)
    f=vec(sx*sz+cx*sy*cz,cx*cy,-sx*cz+cx*sy*sz)
    u=r:cross(f)

    for i=6,1,-1 do
        dst[i],azm[i],elv[i]=ign(3+i*4),ign(4+i*4),ign(5+i*4)
        tgt[i]=rad2xyz(dst[i],azm[i],elv[i])
        if tgt[i]:len()>0 and ign(6+i*4)==0 then
            table.insert(queue, tgt[i])
        end
    end

    -- Store all radar hits that arrived this tick
    if #queue > 0 then
        for q=1,#queue do
            pushContact(tick, queue[q])
        end
        local last = queue[#queue]
        targetx, targety, targetalt = last.x, last.y, last.z
    else
        targetx, targety, targetalt = 0, 0, 0
    end

    queue = {}

    compass=turnsToRad(-ign(31))
	zcycle=ign(32)
	if zcycle==1 then
	if zoom==0.4 then zoom=0 end
	if zoom==1 then zoom=0.4 end
	if zoom==2 then zoom=1 end
	if zoom==4 then zoom=2 end
	if zoom==8 then zoom=4 end
	if zoom==16 then zoom=8 end
	if zoom==32 then zoom=16 end
	if zoom==0 then zoom=32 end
	end

    pruneContacts(tick)
    tick=tick+1
end

function gFix(r,g,b)
r=r^2.2/255^2.2*r
g=g^2.2/255^2.2*g
b=b^2.2/255^2.2*b
return r,g,b
end

function onDraw()

width = screen.getWidth()
height = screen.getHeight()
midx=width/2
midy=height/2
--screen.setMapColorOcean(gFix(0,29,144))
--screen.setMapColorShallows(gFix(0,29,144))
--screen.setMapColorLand(gFix(60,60,60))
--screen.setMapColorGrass(gFix(54,63,14))
--screen.setMapColorSand(gFix(189,144,96))
--screen.setMapColorSnow(gFix(240,240,240))
--screen.setMapColorRock(0,255,0)
--screen.setMapColorGravel(0,0,255)
screen.drawMap(pos.x, pos.y, zoom)

screen.setColor(128,128,128)
screen.drawRectF(midx-1,midy-1,3,3)
screen.setColor(255,255,255)
screen.drawLine(midx,midy,midx+m.sin(compass)*4,midy-m.cos(compass)*4)
zDisp = zoom * 0.5
screen.setColor(0,255,0)
screen.drawText(1, height-6, formatZoom(zDisp))

screen.setColor(128,128,0)
local fromTick = tick - drawWindow
if fromTick < 1 then fromTick = 1 end

for t = fromTick, tick do
    local bucket = contacts[t]
    if bucket then
        for j = 1, #bucket do
            local v = bucket[j]
            local sx, sy = map.mapToScreen(pos.x, pos.y, zoom, width, height, v.x, v.y)

            -- optional rounding for crisp 1px dots
            sx = m.floor(sx + 0.5)
            sy = m.floor(sy + 0.5)

            -- optional bounds check (avoids wasted draw calls)
            if sx >= 0 and sx < width and sy >= 0 and sy < height then
                screen.drawRectF(sx, sy, 1, 1)
            end
        end
    end
end

end