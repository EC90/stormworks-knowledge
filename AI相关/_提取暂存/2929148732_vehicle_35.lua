-- source: steam id 2929148732 / vehicle.xml block#35
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2929148732
M=math
si=M.sin
co=M.cos
pi=M.pi

S=screen
C=S.setColor
dL=S.drawLine
dC=S.drawCircle
dRF=S.drawRectF
dTF=S.drawTriangleF
dTx=S.drawText
dTxB=S.drawTextBox

MS=map.mapToScreen
SM=map.screenToMap
I=input
O=output

tU=table.unpack
F=string.format

zoom = 1
tz = 5*32*0.11
zooms = {0.3,2,5,10,30,50}
grids = {10,100,500,1000,2500,5000}
grid = 100
sis = {5,4,3,2,1,1}
SZ = 4
wp = {}
sel = 0

function dPoi(xx,yy,s,r,...) local a,x,y=...,0,0 a=(a or 30)*pi/360;x=xx+s/2*si(r);y=yy-s/2*co(r);xx=xx-s/4*si(r);yy=yy+s/4*co(r);dTF(xx,yy,x,y,x-s*si(r+a),y+s*co(r+a))dTF(xx,yy,x,y,x-s*si(r-a),y+s*co(r-a)) end
function clamp(a,b,c) return M.min(M.max(a,b),c) end
function getN(...)local a={}for b,c in ipairs({...})do a[b]=I.getNumber(c)end;return tU(a)end
function outN(o, ...) for i,v in ipairs({...}) do O.setNumber(o+i-1,v) end end

function onTick()
	touch = I.getBool(1)
	W,H,tx,ty,gx,gy,gz,dir,swp = getN(1,2,3,4,11,12,13,14,15)
	if gx == nil then return true end
	if wx == nil then if gx==0 then return true end wx,wy,Fx,Fy,Fz = gx,gy,gx,gy,zoom end
	if swp>0 and swp<=#wp then sel=swp end


	if touch and not t then
		if tx < 10 then
			tz = ty
			Fz = M.sin((tz/H)^2*pi/2)*50
			i = 1
			while Fz>zooms[i] do i=i+1 end
			grid = grids[i]
			SZ = sis[i]
		elseif ty < 13 then
			ttx = M.ceil((tx-11)/13)
			if ttx>0 and ttx<=#wp then
				if sel == ttx then
					table.remove(wp,sel)
					sel = 0
					ttx = 0
				else
					sel = ttx
					Fx,Fy = wp[sel].x,wp[sel].y
				end
			end
			if ttx == #wp+1 then
				sel=#wp+1
				wp[sel] = {x=wx,y=wy}
			end
		else
			Fx,Fy = SM(wx,wy,zoom,W,H,tx,ty)
		end
	end
	wx = wx+(Fx-wx)*0.1
	wy = wy+(Fy-wy)*0.1
	zoom = zoom+(Fz-zoom)*0.1
	t = touch

	outN(1,gx,gy,wx,wy,gx,gy,gz,sel,#wp)
	if sel>0 then
		outN(1, wp[sel].x,wp[sel].y)
	end
end

function onDraw()
	if wx==nil then return true end
	w=S.getWidth()
	h=S.getHeight()
	cx=w/2
	cy=h/2
	sz=SZ/H*h
	if w==W then mx,my,zo=wx,wy,zoom else mx,my,zo=gx,gy,1 end

	S.setMapColorOcean(10,10,15)
	S.setMapColorShallows(15,15,20)
	S.setMapColorLand(60,60,60)
	S.setMapColorGrass(40,60,40)
	S.setMapColorSand(55,55,50)
	S.setMapColorSnow(80,80,80)
    S.drawMap(mx,my,zo)
	x1,y1 = SM(mx,my, zo, w,h, 0,h)
	x2,y2 = SM(mx,my, zo, w,h, w,0)
	x1 = M.floor(x1/grid)*grid
	y1 = M.floor(y1/grid)*grid

	C(0,0,0,20)
	for xx=x1,x2,grid do
		x,y = MS(mx,my,zo, w,h, xx,y1)
		dL(x,0,x,h)
	end
	for yy=y1,y2,grid do
		x,y = MS(mx,my,zo, w,h, x1,yy)
		dL(0,y,w,y)
	end

if w==W then
	dRF(8,0,2,h)
	C(0,0,0,200)
	dRF(0,0,8,h)
	dRF(58,h-19,45,16)
	dRF(11,h-19,45,16)
	dTxB(105,h-19,w-110,15,F("grid:%.0f  scale:%.1f",grid,zo),-1,1)

	C(255,150,0)
	dL(1,tz,7,tz)
	dTxB(105,h-20,w-110,15,F("grid:%.0f  scale:%.1f",grid,zo),-1,1)
	dTxB(60,h-20,45,15,F("x:%.0f\ny:%.0f",mx,my),-1,1)
end

	vx,vy = MS(mx,my,zo,w,h,gx,gy)
	r = dir*pi*-2

	if vx<10 or vx>w or vy<0 or vy>h then
		C(200,0,0)
		vx = clamp(vx,12,w-3)
		vy = clamp(vy,5,h-3)
		r=M.atan(gx-mx,gy-my)
		dPoi(vx,vy,10,r,40)
	else
		vy1 = vy-(gz/10)/(zo+1)
		if gz<0 then
			C(0,50,200)
			dPoi(vx,vy1,10,r,50)
			C(0,50,100,100)
			dL(vx,vy+5,vx,vy1)
			C(0,0,0,100)
			dPoi(vx,vy,10,r,50)
		else
			C(0,0,0,100)
			dPoi(vx,vy,10,r,50)
			C(100,0,0,100)
			dL(vx,vy-4,vx,vy1)
			C(200,0,0)
			dPoi(vx,vy1,10,r,50)
		end
	end

if w==W then
	C(0,0,0,50)
	dL(10,cy+1,cx-5,cy+1)
	dL(cx+1,0,cx+1,cy-5)
	dL(cx+6,cy+1,w,cy+1)
	dL(cx+1,cy+6,cx+1,h)
	C(255,255,255,50)
	dL(10,cy,cx-5,cy)
	dL(cx,0,cx,cy-5)
	dL(cx+6,cy,w,cy)
	dL(cx,cy+6,cx,h)
	C(200,0,0)
	dTxB(13,h-20,45,15,F("x:%.0f\ny:%.0f",gx,gy),-1,1)
end
	i = 1
	while i<=#wp do
		lx,ly=ox,oy
		ox,oy = MS(mx,my,zo,w,h,wp[i].x,wp[i].y)
		C(0,100,0,220)
		if i==sel then dL(ox,oy,vx,vy) end
		C(0,0,0,150)
		if i<=sel then C(0,0,0,20) end
		dC(ox,oy+1,sz)
		if i>1 then	dL(ox,oy,lx,ly) end
		C(0,i==sel and 150 or 0,0,220)
		dC(ox,oy,sz)
		if w==W then
			dRF(-2+i*13,2,10,10)
			C(255,255,255)
			dTx((i>9 and -2 or 1)+i*13,4,i)
		end
		i=i+1
	end
	if w==W then
		C(0,0,0,200)
		dRF(-2+i*13,2,10,10)
		C(255,255,255)
		dL(i*13-1,6,6+i*13,6)
		dL(2+i*13,3,2+i*13,10)
	end
end