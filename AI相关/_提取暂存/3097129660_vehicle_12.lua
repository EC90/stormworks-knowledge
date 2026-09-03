-- source: steam id 3097129660 / vehicle.xml block#12
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
rdrx=property.getNumber('Radar Fov X')
GN=input.getNumber
GB=input.getBool
pi=math.pi
rsts={}
S=screen
sdtf=S.drawTriangleF
sC=S.setColor
DL=S.drawLine
DR=S.drawRect
DRF=S.drawRectF
DT=S.drawText
DC=S.drawCircle
DCF=S.drawCircleF
Mf=math.floor
function SC(scc)
if scc==1 then sC(233,15,15) end
if scc==3 then sC(233,233,15) end
if scc==4 then sC(22,222,22) end
if scc==6 then sC(15,64,233) end
if scc==9 then sC(233,233,233) end
if scc==0 then sC(15,15,15) end
end
function DNATO(d,C,F,T)--x,y,faction,type
d,C=Mf(d),Mf(C)
local a,b,c,e,f,g,A,B,D,E=d-3,d-2,d-1,d+1,d+2,d+3,C-2,C-1,C+1,C+2
if F==1 then--ally
SC(6) DRF(a,A-1,7,7) SC(0) DR(a,A-1,6,6) 
elseif F==2 then--enemy
SC(1) S.drawTriangleF(a,D,e,A-1,g+2,D) S.drawTriangleF(a,D,e,E+3,g+2,D) SC(0) DL(d,A-2,a-1,C) DL(a-1,C,d,E+2) DL(d,E+2,g+1,C) DL(g+1,C,d,A-2) 
else--unknown
SC(3) DCF(d,C,1) SC(0) DC(d,C,1)
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
	gpsx=GN(11)
	gpsy=GN(12)
	cps=GN(13)
	mapx=GN(15)
	mapy=GN(16)
	z=GN(7)
	--ipt rst
	if GN(3)~=0 then
		table.insert(rsts,{GN(3),GN(4),0})
	end
	for i=1,#rsts do
		if rsts[i][3]<255 then
			rsts[i][3]=rsts[i][3]+1
		else
			table.remove(rsts,i)
			break
		end
	end
	--ipt end
end
function onDraw()
	w=S.getWidth()
	h=S.getHeight()
	sC(15,233,15,128)
	selfx,selfy=map.mapToScreen(mapx,mapy,z,w,h,gpsx,gpsy)
	if cps~=0 then
	S.drawLine(selfx,selfy,selfx-0.4*w*math.sin((cps-rdrx*0.5)*2*pi),selfy-0.4*w*math.cos((cps-rdrx*0.5)*2*pi))
	S.drawLine(selfx,selfy,selfx-0.4*w*math.sin((cps+rdrx*0.5)*2*pi),selfy-0.4*w*math.cos((cps+rdrx*0.5)*2*pi))
	end
	SC(4)
	DCF(Mf(selfx+0.5),Mf(selfy+0.5),1.4)
	SC(0)
	DC(Mf(selfx+0.5),Mf(selfy+0.5),1.4)
	--show target pos
	for i=1,#rsts do
		txs,tys=map.mapToScreen(mapx,mapy,z,w,h,rsts[i][1],rsts[i][2])
		DNATO(Mf(txs+0.5),Mf(tys+0.5),3,0)
	end	
end