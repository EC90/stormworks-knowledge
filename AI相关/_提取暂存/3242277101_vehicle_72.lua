-- source: steam id 3242277101 / vehicle.xml block#72
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3242277101
--datalink3main
--short for drawing
w,h=96,96
dox=w-60
S=screen
sC=S.setColor
DL=S.drawLine
DR=S.drawRect
DRF=S.drawRectF
DT=S.drawText
DTB=S.drawTextBox
--
btnsS={
	--default,toggle or push or continue,text
	{false,	'c',	'W'},--1
	{false,	'c',	'E'},--2
	{false,	'c',	'N'},--3
	{false,	'c',	'S'},--4
	{false,	'c',	'+'},--5
	{false,	'c',	'-'},--6
	{false,	'c',	'add'},--7
	{false,	'c',	'del'},--8
	{false,	'c',	'rst'},--9
	{false,	't',	'opt'},--10
	{false,	'p',	'-'},--11 page2o-
	{false,	'p',	'+'},--12 page2o+
	{false,	'p',	'- '},--13 page2z-
	{false,	'p',	' +'},--14 page2z+
	{false,	'p',	'- '},--15 page3h-
	{false,	'p',	' +'},--16 page3h+
	{false,	'p',	'- '},--17 page3r-
	{false,	'p',	' +'},--18 page3r+
	{false,	't',	'ldn'},--19 page3rtb
	{false,	't',	'al'},--20 page3cv
	{false,	'c',	'atk'},--21 page3atk
	{false,	't',	'cam'},--22 page3cam
	{false,	't',	'rc'},--23 page4rc
	{false,	't',	'cam'},--24 page4cam
	{false,	'p',	'- '},--25 page34o-
	{false,	'p',	' +'},--26 page34o+
}
btnsC={}
for i=1,#btnsS do
	btnsC[i]={0,0,0,0}
end
function UpdBtn(n,con)
	if btnsS[n] then
		local CurBtnS=btnsS[n]
		local CurBtnC=btnsC[n]
		if touch and tx>CurBtnC[1] and tx<CurBtnC[1]+CurBtnC[3] and ty>CurBtnC[2] and ty<CurBtnC[2]+CurBtnC[4] and con then
			if CurBtnS[2]=='t' then
				if not toucho then
					CurBtnS[1]=not CurBtnS[1]
				end
			elseif CurBtnS[2]=='p' then
				if not toucho then
					CurBtnS[1]=true
				else
					CurBtnS[1]=false
				end
			else
				CurBtnS[1]=true
			end
		elseif CurBtnS[2]~='t' then
			CurBtnS[1]=false
		end
	end
end
function DrawBtn(n)
	if btnsS[n] then
		local CurBtnS=btnsS[n]
		local CurBtnC=btnsC[n]
		sC(15,233,15)
		if CurBtnS[1] then
			DRF(CurBtnC[1],CurBtnC[2],CurBtnC[3],CurBtnC[4])
			sC(15,15,15)
		end
		DTB(CurBtnC[1]-2,CurBtnC[2]-2,CurBtnC[3]+4,CurBtnC[4]+4,CurBtnS[3],0,0)
	end
end
--end of btns sys
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
SF=string.format
--map
z=2.5
mox,moy=0,0
mapofsto=false
--menu
menu=false
--sos status
sosf,sosa,sosm,sosr=false,false,false,false
dmx=-24
page=1
touchx,touchy=0,0
toucho=false
M=math
Mf=M.floor
optms={{56,54},{45,13},{45,31},{45,13}}
wph=25
uavh=50
uavr=0
tgttp=0
function PB(bx,by,bw,bh) if touch and tx>bx and tx<bx+bw and ty>by and ty<by+bh then return true else return false end end
function TB(bx,by,bw,bh,stts) if touch and tx>bx and tx<bx+bw and ty>by and ty<by+bh and (not toucho) then stts=not stts else end return stts end
function DB(bx,by,bw,bh,text,stts)
	sC(15,233,15)
	if stts then
		DRF(bx,by,bw,bh) sC(15,15,15)
	end
	DTB(bx+1,by,bw-2,bh,text,0,0)
end
function onTick()
	btnsC={
		--x,	y,		w,		h
		{0,		0.4*h,	4,		0.2*h},--1
		{w-4,	0.4*h,	4,		0.2*h},--2
		{0.4*w,	0,		0.2*w,	5},--3
		{0.4*w,	h-5,	0.2*w,	5},--4
		{w-4,	0.2*h,	4,		0.2*h},--5
		{w-4,	0.6*h,	4,		0.2*h},--6
		{0.6*w,	h-5,	0.4*w,	5},--7
		{5,		h-5,	0.4*w-5,5},--8
		{5,		0,		0.4*w-5,5},--9
		{0.6*w,	0,		0.4*w,	5},--10
		{dox+22,6,		7,		5},--11 page2o-
		{dox+30,6,		7,		5},--12 page2o+
		{dox+14,12,		15,		5},--13 page2z-
		{dox+33,12,		15,		5},--14 page2z+
		{dox+14,12,		15,		5},--15 page3h-
		{dox+33,12,		15,		5},--16 page3h+
		{dox+14,18,		15,		5},--17 page3r-
		{dox+33,18,		15,		5},--18 page3r+
		{dox+3,	24,		18,		5},--19 page3rtb
		{dox+24,24,		18,		5},--20 page3cv
		{dox+3,	30,		18,		5},--21 page3atk
		{dox+24,30,		18,		5},--22 page3cam
		{dox+1,	12,		13,		5},--23 page4rc
		{dox+16,12,		18,		5},--24 page4cam
		{dox+14,6,		15,		6},--25 page34o-
		{dox+33,6,		15,		6},--26 page34o+
	}
	--new btn sys touch
	touch=input.getBool(1) and not (btnsS[24][1] or btnsS[22][1])
	btnt=touch and not toucho
	tx=GN(3)
	ty=GN(4)
	gpsx=GN(5)
	gpsy=GN(6)
	if GN(7)>0 then btnsS[24][1]=false btnsS[22][1]=false end
	cur=GN(8)
	sID=GN(9)
	menubtns={{'menu',false},{'JTAC',page==1},{'WAYP',page==2},{'UAV',page==3},{'RC',page==4},{'AMMO',sosa},{'FUEL',sosf},{'MEDC',sosm},{'REPR',sosr}}
	--new btns
	UpdBtn(1,dmx<-20)
	if btnsS[1][1] then mox=mox-z*5 end
	UpdBtn(2,1)
	if btnsS[2][1] then mox=mox+z*5 end
	UpdBtn(3,dmx<-20)
	if btnsS[3][1] then moy=moy+z*5 end
	UpdBtn(4,1)
	if btnsS[4][1] then moy=moy-z*5 end
	UpdBtn(5,1)
	if btnsS[5][1] then z=M.max(z*0.97,0) end
	UpdBtn(6,1)
	if btnsS[6][1] then z=M.min(z*1.03,50) end
	UpdBtn(7,1)
	UpdBtn(8,1)
	UpdBtn(9,dmx<-20)
	if btnsS[9][1] then mox,moy=0,0 end
	UpdBtn(10,1)
	--
	dox=w-4-optms[page][1]
	SB(28,false)
	order=5
	if btnsS[10][1] then
		menu=false
		if page==1 then
			SB(28,true)
			if PB(dox,5,optms[page][1],optms[page][2]) then
				tgttp=Mf((tx-dox)/28)*6+Mf((ty-10)/8)
			end
		elseif page==2 then
			for i=11,14 do
				UpdBtn(i,1)
			end
			if btnsS[11][1] then order=1 end
			if btnsS[12][1] then order=9 end
			if btnsS[13][1] then wph=M.max(wph-50,0) end
			if btnsS[14][1] then wph=M.min(wph+50,2500) end
		elseif page==3 then
			for i=15,22 do
				UpdBtn(i,1)
			end
			if btnsS[15][1] then uavh=M.max(uavh-50,0) end
			if btnsS[16][1] then uavh=M.min(uavh+50,2500) end
			if btnsS[17][1] then uavr=M.max(uavr-50,0) end
			if btnsS[18][1] then uavr=M.min(uavr+50,2500) end
		elseif page==4 then
			UpdBtn(23,1)
			UpdBtn(24,1)
		end
		if page>2 then
			UpdBtn(25,1)
			UpdBtn(26,1)
			if btnsS[25][1] then order=1 end
			if btnsS[26][1] then order=9 end
		end
	end
	if page~=4 then btnsS[23][1]=false end
	menu=TB(dmx,0,28,5,menu)
	if menu then
		menu=TB(26,5,w-22,h-10,menu)
		dmx=M.min(dmx+1,0)
		mbt='<'
		btnsS[10][1]=false
		if PB(-2,6,26,23) then page=Mf(ty/6) end
		sosa=TB(dmx,29,24,6,sosa)
		sosf=TB(dmx,35,24,6,sosf)
		sosm=TB(dmx,41,24,6,sosm)
		sosr=TB(dmx,47,24,6,sosr)
	else
		dmx=M.max(dmx-1,-24)
		mbt='>'
	end
	mapofst=mox~=0 and moy~=0
	if mapofst then
		if not mapofsto then
			mcx,mcy=gpsx,gpsy
		end
	else
		mcx,mcy=gpsx,gpsy
	end
	if PB(dmx+29,6,w-10,h-12) and (not toucho) and not(PB(dox,5,optms[page][1],optms[page][2]) and btnsS[10][1]) then
		touchx,touchy=map.screenToMap(mcx+mox,mcy+moy,z,w,h,tx,ty)
		mox=mox+(touchx-(mcx+mox))
		moy=moy+(touchy-(mcy+moy))
	end
	SN(21,order)
	SN(22,tgttp)
	SN(23,wph/50)
	SN(24,uavh/50)
	SN(25,uavr/50)
	SN(26,page)
	SN(27,touchx)
	SN(28,touchy)
	SN(30,mcx+mox)
	SN(31,mcy+moy)
	SN(32,z)
	--
	SB(21,btnsS[7][1] and not toucho)
	SB(22,btnsS[8][1] and not toucho)
	SB(23,btnsS[21][1] and not toucho)
	SB(24,btnsS[19][1])
	SB(25,btnsS[20][1])
	SB(26,btnsS[23][1])
	SB(27,btnsS[24][1] or btnsS[22][1])
	SB(29,sosa)
	SB(30,sosf)
	SB(31,sosm)
	SB(32,sosr)
	toucho=touch
	mapofsto=mapofst
end
pagen={'j','w','u','r'}
function onDraw()
	w=S.getWidth()
	h=S.getHeight()
	sC(0,0,0,128)
	DRF(0,0,w,5)
	DRF(0,5,4,h-10)
	DRF(w-4,5,4,h-10)
	DRF(0,h-5,w,5)
	--new btns
	for i=1,10 do
		if i~=9 then
			DrawBtn(i)
		end
	end
	--
	if mapofst then
		DrawBtn(9)
	else
		sC(15,233,15)
		DL(5,0,5,5)
		DT(7,0,'D'..Mf(sID))
	end
	--
	if btnsS[10][1] then
		sC(0,0,0,64)
		DRF(dox,5,optms[page][1],optms[page][2])
		sC(15,233,15)
		if page==2 then
			DT(dox+1,6,'ORDR')
			DT(dox+1,12,'ALT '..SF('%04d',wph))
			DrawBtn(11)
			DrawBtn(12)
			DrawBtn(13)
			DrawBtn(14)
		elseif page==3 then
			DT(dox+1,6,'CUR '..SF('%4d',cur))
			DT(dox+1,12,'ALT '..SF('%04d',uavh))
			DT(dox+1,18,'RAD '..SF('%04d',uavr))
			for i=15,22 do
				DrawBtn(i)
			end
			DrawBtn(25)
			DrawBtn(26)
		elseif page==4 then
			DT(dox+1,6,'CUR '..SF('%2d',cur))
			DrawBtn(23)
			DrawBtn(24)
			DrawBtn(25)
			DrawBtn(26)
		end
	end
	sC(15,233,15)
	--DT(0,6,page)
	DT(0,6,pagen[page])
	_=Mf(0.65*h)
	if sosa then
		sC(233,233,15)
		DRF(1,_,2,2)
	end
	if sosf then
		sC(15,233,15)
		DRF(1,_+3,2,2)
	end
	if sosm then
		sC(233,15,15)
		DRF(1,_+6,2,2)
	end
	if sosr then
		sC(15,32,233)
		DRF(1,_+9,2,2)
	end
	sC(0,0,0,166)
	DRF(dmx,0,28,5)
	DRF(dmx,0,24,h)
	DB(dmx+23,0,8,5,mbt,false)
	for i=1,#menubtns do
		DB(dmx,i*6-6,23,5,menubtns[i][1],menubtns[i][2])
	end
end