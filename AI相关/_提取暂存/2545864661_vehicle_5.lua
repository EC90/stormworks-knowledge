-- source: steam id 2545864661 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2545864661

function onTick()
xmm = input.getNumber(5)
ymm = input.getNumber(6)
zoom = input.getNumber(7)
end

s = screen
function onDraw()
w = s.getWidth()
if w>60 then				  
h = s.getHeight()	
screen.setMapColorLand(102,77,26) 
screen.setMapColorShallows(36, 128, 255)
screen.setMapColorGrass(102,100,26) 
screen.setMapColorSand(102,77,26) 
screen.setMapColorSnow(102,77,26)
screen.setMapColorOcean(92,168,255)	
s.drawMap(xmm, ymm, zoom)
if w > 64 then
if zoom < 1 then
prom = 50
elseif zoom < 5 then
prom = 250
elseif zoom < 10 then
prom = 1000
elseif zoom < 30 then
prom = 2500
elseif zoom < 40 then
prom = 5000
else 
prom = 10000
end
else

if zoom < 1 then
prom = 100
elseif zoom < 5 then
prom = 400
elseif zoom < 10 then
prom = 1500
elseif zoom < 30 then
prom = 3000
elseif zoom < 40 then
prom = 5000
else 
prom = 10000
end

end
sx, sy = map.screenToMap(xmm,ymm,zoom,w,h,-50,-50)
sx = sx - sx%prom
sy = sy - sy%prom
s.setColor(1,1,1,60)
for i = sx, sx + prom * 50 , prom do
xl, yl = map.mapToScreen(xmm, ymm, zoom, w, h, i, i)
s.drawLine(xl, -1, xl, 800)
end
for ii=sy,sy-prom*50,-prom do
xl, yl = map.mapToScreen(xmm, ymm, zoom, w, h, ii, ii)
s.drawLine(-1, yl, 800, yl)
end
end
end


