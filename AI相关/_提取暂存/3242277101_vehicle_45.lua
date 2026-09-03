-- source: steam id 3242277101 / vehicle.xml block#45
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3242277101
--datalink3drawSelf
dcr=2
h=64
rdrx=property.getNumber('Showing Radar Fov X')
maxlife=property.getNumber('Search Radar Result Lifespan')
GN=input.getNumber
M=math
function Mf(_) return M.floor(_+0.5) end
pi=M.pi
rsts={}
M2S=map.mapToScreen
S=screen
sC=S.setColor
DL=S.drawLine
DR=S.drawRect
DRF=S.drawRectF
DC=S.drawCircle
DCF=S.drawCircleF
DT=S.drawText
et=0
function SC(scc)
if scc==1 then sC(233,15,15) end
if scc==3 then sC(233,233,15) end
if scc==4 then sC(15,233,15) end
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
SC(3) DCF(d,C,dcr) SC(0) DC(d,C,dcr)
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
	z=GN(17)
	tgtx=GN(21)
	tgty=GN(22)
	et=GN(23)

	--ipt rst
	if GN(1)~=0 then
		table.insert(rsts,{GN(1),GN(2),0})
	end
	for i=1,#rsts do
		if rsts[i][3]<maxlife then
			rsts[i][3]=rsts[i][3]+1
		else
			table.remove(rsts,i)
			break
		end
	end
	if #rsts>100 then
		table.remove(rsts,1)
	end
	--ipt end
end
function onDraw()
	w=S.getWidth()
	h=S.getHeight()
	S.drawMap(mapx,mapy,z)
	S.setMapColorOcean(20,25,35)
	S.setMapColorShallows(30,35,45)
	S.setMapColorLand(50,50,60)
	S.setMapColorGrass(30,35,35)
	S.setMapColorSand(50,45,40)
	S.setMapColorSnow(60,60,70)
	S.setMapColorRock(25,21,20)
	S.setMapColorGravel(30,25,20)
	selfx,selfy=M2S(mapx,mapy,z,w,h,gpsx,gpsy)
	akm1,akm2=M2S(mapx,mapy,z,w,h,gpsx+1000,gpsy-2000)
	akm5,akm10=M2S(mapx,mapy,z,w,h,gpsx+5000,gpsy-10000)
	km1,km2,km5,km10=akm1-selfx,akm2-selfy,akm5-selfx,akm10-selfy
	S.setColor(15,15,15,32)
	--2
	DT(selfx,selfy+km2,"2km")
	DT(selfx,selfy-km2,"2km")
	DT(selfx+km2,selfy,"2km")
	DT(selfx-km2,selfy,"2km")
	DC(selfx,selfy,km2)
	--1
	DC(selfx,selfy,km1)
	DT(selfx,selfy+km1,"1km")
	DT(selfx,selfy-km1,"1km")
	DT(selfx+km1,selfy,"1km")
	DT(selfx-km1,selfy,"1km")
	--5
	DT(selfx,selfy+km5,"5km")
	DT(selfx,selfy-km5,"5km")
	DT(selfx+km5,selfy,"5km")
	DT(selfx-km5,selfy,"5km")
	DC(selfx,selfy,km5)
	--10
	DT(selfx,selfy+km10,"10km")
	DT(selfx,selfy-km10,"10km")
	DT(selfx+km10,selfy,"10km")
	DT(selfx-km10,selfy,"10km")
	DC(selfx,selfy,km10)
	if h<65 then dcr=1.4 else dcr=2 end
	sC(15,233,15,32)
	S.drawLine(selfx,selfy,selfx-0.4*w*M.sin((cps-rdrx*0.5)*2*pi),selfy-0.4*w*M.cos((cps-rdrx*0.5)*2*pi))
	S.drawLine(selfx,selfy,selfx-0.4*w*M.sin((cps+rdrx*0.5)*2*pi),selfy-0.4*w*M.cos((cps+rdrx*0.5)*2*pi))
	--show target pos
	for i=1,#rsts do
		txs,tys=map.mapToScreen(mapx,mapy,z,w,h,rsts[i][1],rsts[i][2])
		DNATO(Mf(txs),Mf(tys),3,0)
	end	
	--if M.abs(tgtx-gpsx)>10 and M.abs(tgty-gpsy)>10 and tgtx~=0 and tgty~=0 then
	--	txs,tys=map.mapToScreen(mapx,mapy,z,w,h,tgtx,tgty)
	--	DNATO(txs,tys,2,et)
	--	DR(txs-4,tys-4,8,8)
	--end
    SC(4)
	DCF(Mf(selfx),Mf(selfy),dcr)
	SC(0)
	DC(Mf(selfx),Mf(selfy),dcr)
end