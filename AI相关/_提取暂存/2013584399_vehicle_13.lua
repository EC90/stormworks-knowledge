-- source: steam id 2013584399 / vehicle.xml block#13
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2013584399
mapZ=0.7
lck=true
function onTick()
	G=input
	w=G.getNumber(1) cx=w/2
	h=G.getNumber(2) cy=w/2
	pR=(h<96) and 2 or 4
	tx=G.getNumber(3)
	ty=G.getNumber(4)
	fk=G.getBool(1)
	mvbl=true
	bPos=1
	gpsX=G.getNumber(11)
	gpsY=G.getNumber(12)
	Ltc=G.getBool(20)
	if mapX == nil and gpsX ~= 0 then
		mapX=gpsX
		mapY=gpsY
	end	
	output.setNumber(13, mapX)
	output.setNumber(14, mapY)
	output.setNumber(15, mapZ)
	output.setNumber(16, pR)
	local stX=G.getNumber(17)
	local stY=G.getNumber(18)	
	targetX, targetY = map.mapToScreen(mapX, mapY, mapZ, w, h, stX, stY)
	posX, posY = map.mapToScreen(mapX, mapY, mapZ, w, h, gpsX, gpsY)
	local c=G.getNumber(24)
	local sV=((c+0.5)*360)*100/100 sV=sV*(math.pi/180) cos=math.cos(sV) sin=math.sin(sV) 
	dX=(0*cos)-(4*sin)dY=(0*sin)+(4*cos)
end

function onDraw()
	if Ltc then
	sC (51, 255, 51)
	S.drawLine(posX, posY, targetX, targetY)
	sC (10, 255, 10)
	dC(targetX, targetY, pR-1) dC(targetX, targetY, pR+1)
	end
	if tx<10 and ty<58 and ty>46 then 
	mvSpdX,mvSpdY=0,0 else 
	mvSpdX,mvSpdY=0.7,0.5
	end
	dC=screen.drawCircle
	S=screen
	M=math
	cx,cy=w/2,h/2
	nb=mvbl and 3 or 2
	bW=w/nb
	barHeight=M.floor(h / 10)
	dCF=screen.drawCircleF
	sC=screen.setColor
	if barHeight < 6 then barHeight=6 end
	barTop,barBot,mapTop,mapBot=h-barHeight, h, 0, h-barHeight-1
	if bPos == 2 then
		barTop=0
		barBot=barHeight
		mapTop=barHeight + 1
		mapBot=h
	end
	if move then
		if lck then newX=gpsX;newY=gpsY; end			
		mapX,mapY=M.floor(mapX*100)/100, M.floor(mapY*100)/100
		lenX,lenY=M.sqrt((newX-mapX)^2), M.sqrt((newY-mapY)^2)
		mvSpdX,mvSpdY=mvSpdX * (lenX / 10), mvSpdY * (lenY / 10)
		if newX>mapX then mapX=mapX+mvSpdX end
		if newX<mapX then mapX=mapX-mvSpdX end
		if newY>mapY then mapY=mapY+mvSpdY end
		if newY<mapY then mapY=mapY-mvSpdY end
		if lenX<0.15 and lenY<0.25 then move=false end
end
if (lck and not move) or not mvbl then
mapX=gpsX
mapY=gpsY
end
S.drawMap(mapX, mapY, mapZ)
S.setColor(90, 0, 0)
if mvbl then
sX, sY=map.mapToScreen(mapX, mapY, mapZ, w, h, gpsX, gpsY)
mw,mh=w/2, (h-barHeight)/2
cY=(bPos == 1) and mh or (h+barHeight)/2
lx,ly,alx,aly=sX-mw,sY-cY,M.abs(sX-mw),M.abs(sY-cY)
if alx > mw or aly > mh then
toX, toY=(aly~=0) and mh/aly*lx or 0, (alx~=0) and mw/alx*ly or 0
if M.abs(toY)<=mh then
if alx==lx then dCF(w, cY+toY, pR)
else dCF(0, cY+toY, pR) end
else
if bPos == 1 then
if aly==ly then dCF(mw+toX, h-barHeight-1, pR)
else dCF(mw+toX, 0, pR) end
else
if aly==ly then dCF(mw+toX, h, pR)
else dCF(mw+toX, barHeight+1, pR) end
end
end
--Direction
else S.drawRectF(sX, sY, pR, pR) 
S.drawLine(sX, sY, sX - dX, sY + dY) S.drawRectF(sX - 1, sY - 1, 3, 3) end
if scrP(fk,1,bW-1,barTop,barBot) then
lck=true
move=true
S.setColor(0, 27, 41)
else S.setColor(0, 94, 142) end
S.drawRectF(0, barTop, bW, barHeight)
--Direction R
else S.drawRectF(w/2, h/2, pR, pR)
S.drawLine(cx, cy, cx - dX, cy + dY) S.drawRectF(cx - 1, cy - 1, 3, 3) end
scl=0.05 * (mapZ/2)
if not minD and scrP(fk,bW*(nb-2)+1,bW*(nb-1)-1,barTop,barBot) then
S.setColor(0, 27, 41)
mapZ=mapZ + scl
plusD=false
if mapZ >= 15 then
mapZ=15
minD=true
end
elseif minD then S.setColor(20, 20, 20) else S.setColor(0, 94, 142) end S.drawRectF(bW*(nb-2), barTop, bW, barHeight)
if not plusD and scrP(fk,bW*(nb-1)+1,w,barTop,barBot) then S.setColor(0, 27, 41) mapZ=mapZ - scl minD=false if mapZ <= 0.1 then mapZ=0.1 plusD=true end elseif plusD then S.setColor(20, 20, 20) else S.setColor(0, 94, 142) end
S.drawRectF(bW*(nb-1), barTop, bW, barHeight) if scrP(fk,0,w,mapTop,mapBot) and mvbl then newX, newY=map.screenToMap(mapX, mapY, mapZ, w, h, tx, ty) newX=M.floor(newX*100)/100 newY=M.floor(newY*100)/100 lck=false move=true end S.setColor(15, 15, 15) S.drawLine(bW ,barTop, bW, barBot) if mvbl then S.drawLine(bW*2 ,barTop, bW*2, barBot) end S.setColor(255, 255, 255) if mvbl then S.drawText(bW/2-2, barBot-(barHeight/2)-2, "R") end S.drawText((bW*(nb-2))+bW/2-2, barBot-(barHeight/2)-2, "-") S.drawText((bW*(nb-1))+bW/2-2, barBot-(barHeight/2)-2, "+") end function scrP(k,x,x2,y,y2) return tx>=x and tx<=x2 and ty>=y and ty<=y2 and k end