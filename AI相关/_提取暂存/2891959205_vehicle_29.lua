-- source: steam id 2891959205 / vehicle.xml block#29
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2891959205
rdrx=property.getNumber('Radar Fov X')
ign=input.getNumber
sdtf=screen.drawTriangleF
pi=math.pi
rsta,rstd={},{}
sC=screen.setColor
DL=screen.drawLine
DR=screen.drawRect
DRF=screen.drawRectF
DT=screen.drawText
mF=math.floor
et=0
function SC(scc)
if scc==1 then sC(233,15,15) end
if scc==3 then sC(233,233,15) end
if scc==6 then sC(15,64,233) end
if scc==9 then sC(233,233,233) end
if scc==0 then sC(15,15,15) end
end
function DNATO(d,C,F,T)--x,y,faction,type
d,C=mF(d),mF(C)
local a,b,c,e,f,g,A,B,D,E=d-3,d-2,d-1,d+1,d+2,d+3,C-2,C-1,C+1,C+2
if F==1 then--ally
SC(6) DRF(a,A-1,7,7) SC(0) DR(a,A-1,6,6) 
elseif F==2 then--enemy
SC(1) screen.drawTriangleF(a,D,e,A-1,g+2,D) screen.drawTriangleF(a,D,e,E+3,g+2,D) SC(0) DL(d,A-2,a-1,C) DL(a-1,C,d,E+2) DL(d,E+2,g+1,C) DL(g+1,C,d,A-2) 
else--unknown
SC(3) DRF(c,B,3,3) SC(0) DL(c,A,f,A) DL(f,B,f,E) DL(e,E,b,E) DL(b,D,b,A) 
end
if T==1 then DL(d,C,d,D) end 
if T==2 then DL(c,B,f,B) DL(c,D,f,D) DL(b,C,c,C) DL(f,C,e,C) end 
if T==3 then DL(b,A,g,E+1) DL(f,A,a,E+1) end 
if T==4 then DL(b,E,c,D) DL(f,E,e,D) DL(c,D,f,D) end 
if T==5 then DL(b,C,d,A) DL(c,D,f,A) DL(e,D,g,B) end 
if T==6 then DL(b,B,b,E) DL(c,C,f,C) DL(f,B,f,E) end 
if T==7 then DL(d,B,d,C) DL(c,E,c,B) DL(e,E,e,B) end 
if T==8 then DL(b,E,g,A-1) end 
if T==9 then DL(b,D,g,D) end 
if T==10 then DL(c,B,e,D) DL(e,B,c,D) end 
if T==11 then DL(b,E,e,B) DL(f,E,c,B) end 
end
function onTick()
	gpsx=ign(11)
	gpsy=ign(12)
	cps=ign(3)
	mapx=ign(15)
	mapy=ign(16)
	z=ign(7)
	--ipt rst
	for i=1,8 do
		rstd[i]=ign(-3+4*i)
		rsta[i]=ign(-2+4*i)
	end
	tgtx,tgty=ign(4),ign(8)
	et=ign(19)
end
function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	sC(15,233,15,128)
	selfx,selfy=map.mapToScreen(mapx,mapy,z,w,h,gpsx,gpsy)
	if cps~=0 then
	screen.drawLine(selfx,selfy,selfx-0.4*w*math.sin((cps-rdrx*0.5)*2*pi),selfy-0.4*w*math.cos((cps-0.08)*2*pi))
	screen.drawLine(selfx,selfy,selfx-0.4*w*math.sin((cps+rdrx*0.5)*2*pi),selfy-0.4*w*math.cos((cps+0.08)*2*pi))
	end
	sC(15,233,15,200)
	screen.drawCircleF(selfx,selfy,h/32)
	sC(0,0,0,128)
	screen.drawCircle(selfx,selfy,h/32)
	--show target pos
	for i=1,#rstd do
		if rstd[i]>100 then
			tx,ty=rstd[i]*math.sin((cps-rsta[i])*2*pi),rstd[i]*math.cos((cps-rsta[i])*2*pi)
			txs,tys=map.mapToScreen(mapx,mapy,z,w,h,gpsx-tx,gpsy+ty)
			DNATO(txs,tys,3,0)
		end
	end
	if math.abs(tgtx-gpsx)>10 and math.abs(tgty-gpsy)>10 and tgtx~=0 and tgty~=0 then
		txs,tys=map.mapToScreen(mapx,mapy,z,w,h,tgtx,tgty)
		DNATO(txs,tys,2,et)
		DR(mF(txs)-4,mF(tys)-4,8,8)
	end
end