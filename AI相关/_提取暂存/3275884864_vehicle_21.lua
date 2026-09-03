-- source: steam id 3275884864 / vehicle.xml block#21
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3275884864
--datalink3main
J=true
K=false
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
SF=string.format
z=1
mox,moy=0,0
mapofsto=K
opt=K
menu=K
dmx=-24
page=1
touchx,touchy=0,0
toucho=K
M=math
Mf=M.floor
S=screen
sC=S.setColor
DL=S.drawLine
DR=S.drawRect
DRF=S.drawRectF
DT=S.drawText
DTB=S.drawTextBox
optms={{56,54},{45,13},{45,31},{35,13}}
wph=25
uavh=250
uavr=0
RTB=K
CV=K
CAM=K
RC=K
tgttp=0
U=233
V=15
gpsxo=0
gpsyo=0
function PB(bx,by,bw,bh) if touch and tx>bx and tx<bx+bw and ty>by and ty<by+bh then return J else return K end end
function TB(bx,by,bw,bh,stts) if touch and tx>bx and tx<bx+bw and ty>by and ty<by+bh and (not toucho) then stts=not stts else end return stts end
function DB(bx,by,bw,bh,text,stts)
	sC(V,U,V)
	if stts then
		DRF(bx,by,bw,bh) sC(V,V,V)
	end
	DTB(bx+1,by,bw-2,bh,text,0,0)
end
function onTick()
    sosf,sosa,sosm,sosr=GB(29),GB(30),GB(31),GB(32)
	w=GN(1)
	h=GN(2)
	tx=GN(3)
	ty=GN(4)
	gpsx=GN(5)
	gpsy=GN(6)
	vx=(gpsx-gpsxo)*60*z*16
	vy=(gpsy-gpsyo)*60*z*16
	if GN(7)>0 then CAM=K end
	cur=GN(8)
	sID=GN(9)
	touch=input.getBool(1) and not CAM
	zi,zo=K,K
	oW,oE,oN,oS=K,K,K,K
	menubtns={{'menu',K},{'JTAC',page==1},{'WAYP',page==2},{'UAV',page==3},{'RC',page==4}}
	if PB(0,0.4*h,4,0.2*h) and dmx<-20 then mox=mox-z*5 oW=J end
	if PB(w-4,0.4*h,4,0.2*h) then mox=mox+z*5 oE=J end
	if PB(0.4*w,0,0.2*w,5) and dmx<-20 then moy=moy+z*5 oN=J end
	if PB(0.4*w,h-5,0.2*w,5) then moy=moy-z*5 oS=J end
	if PB(0,0.2*h,4,0.2*h) then z=M.max(z*0.97,0) zi=J end
	if PB(0,0.6*h,4,0.2*h) then z=M.min(z*1.03,50) zo=J end
	add,del,rstb=K,K,K
	--if PB(0.6*w,h-5,0.4*w,5) then add=J end
	--if PB(5,h-5,0.4*w-5,5) then del=J end
	if PB(5,0,0.4*w-5,5) and dmx<-20 then rstb=J mox,moy=0,0 end
	--opt=TB(0.6*w,0,0.4*w,5,opt)
	dox=w-4-optms[page][1]
	SB(28,K)
	ATK=K
	order=5
	mapofst=mox~=0 and moy~=0
	if mapofst then
		if not mapofsto then
			mcx,mcy=gpsx,gpsy
		end
	else
		mcx,mcy=gpsx+vx,gpsy+vy
		--mcx,mcy=gpsx,gpsy
	end
	if PB(dmx+29,6,w-10,h-12) and (not toucho) and not(PB(dox,5,optms[page][1],optms[page][2]) and opt) then
		touchx,touchy=map.screenToMap(mcx+mox,mcy+moy,z,w,h,tx,ty)
		mox=mox+(touchx-(mcx+mox))
		moy=moy+(touchy-(mcy+moy))
	end
	SN(27,touchx)
	SN(28,touchy)
	SN(30,mcx+mox)
	SN(31,mcy+moy)
	SN(32,z)
	--
	toucho=touch
	mapofsto=mapofst
    gpsxo=gpsx
    gpsyo=gpsy
end
function onDraw()
	sC(0,0,0,128)
	DRF(0,0,w,5)
	DRF(0,5,4,h-10)
	DRF(w-4,5,4,h-10)
	DRF(0,h-5,w,5)
	DB(0,0.4*h,4,0.2*h,"W",oW)
	DB(w-4,0.4*h,4,0.2*h,"E",oE)
	DB(0.4*w,0,0.2*w,5,"N",oN)
	DB(0.4*w,h-5,0.2*w,5,"S",oS)
	DB(0,0.2*h,4,0.2*h,"+",zi)
	DB(0,0.6*h,4,0.2*h,"-",zo)
	if mapofst then DB(0,0,0.4*w,5,'rst',rstb) else sC(V,U,V) DL(5,0,5,5) DT(7,0,'D'..Mf(sID)) end
	_=Mf(0.65*h)
	if sosa then
		sC(U,U,V)
		DRF(1,_,2,2)
	end
	if sosf then
		sC(V,U,V)
		DRF(1,_+3,2,2)
	end
	if sosm then
		sC(U,V,V)
		DRF(1,_+6,2,2)
	end
	if sosr then
		sC(V,32,U)
		DRF(1,_+9,2,2)
	end
end