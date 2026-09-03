-- source: steam id 3275884864 / vehicle.xml block#26
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3275884864
--Weapon Monitor GNR
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
cnt1=-200
cnt2=1
SF=string.format
PN=property.getNumber
M=math
Mb=M.abs
Mc=M.cos
Mf=M.floor
Ms=M.sin
Mr=M.sqrt
P=M.pi*2
idle=true
ofst={
101521,392249,350689,722470,402166,185207,773846,474155,391270,888166,
267490,887742,650564,329825,236165,536647,763815,236908,680856,588564,
495532,402417,236228,743491,360480,887888,360260,599155,588532,402469,
815909,505595,288228,319417,774334,857459,588407,825752,153385,660522,
857334,381124,143218,215626,432825,794878,649731,742815,567291,556752,
340438,867386,846857,112123,608511,370500,516291,112699,226417,112647,
650229,567584,340354,423197,143364,112741,898763,402281,453846,887669,
277448,464385,153260,825689,649773,277783,743260,370584,660396,733532,
557124,547113,215762,453563,805396,246647,474741,339595,443438,122647,
888302,319469,826260,112364,267500,887888,805292,257270,257584,846491}
function Mp(value,vmin,vmax)
	return math.max(math.min(vmax,value),vmin)
end
Is={}
Ds={}
Dss={}
function pid(id,v,s,p,i,d,plmt,ilmt)
	if not Is[id] then Is[id]=0 Ds[id]=0 Dss[id]={} end
	Is[id]=Mp(Is[id]+i*(s-v),-ilmt,ilmt)
	local o=Mp(p*(s-v),-plmt,plmt)+Is[id]+d*(s-v-Ds[id])
	Ds[id]=s-v
	return o
end
gnrcnnm=PN('GNR CNN Ammo')
gnrmgm=PN('GNR MG Ammo')
cmdcnnm=PN('CMD CNN Ammo')
cmdmgm=PN('CMD MG Ammo')
function onTick()
	rackstts=0
	for i=1,8 do
		if GB(20+i) then
			rackstts=rackstts+2^(i-1)
		end
	end
	SN(21,rackstts)
	SN(22,cnt2-1)
	SB(21,GB(29))
	--
	subwp=GB(2)
	if GB(13) then
		trg=GB(31) and not subwp
		mg=GB(31) and subwp
	else
		trg=GB(14) and not GB(15)
		mg=GB(14) and GB(15)
	end
	trans=GB(12)
	frontfeed=false
	readfeed=false
	if idle then
		tcktgt=0.27
	else
		tcktgt=2.48
	end
	if loaded and not GB(11) then cnt1=0 cnt2=cnt2+1 end
	if cnt1<120 then breech=true else breech=false end
	if cnt1<150 then frontfeed=true end
	if cnt1>90 and cnt1<300 then
		if trans then
			idle=true
		else
			readfeed=true
			idle=false
		end
	end
	if cnt1>300 and not GB(11) and trg then cnt1=0 end
	SB(1,breech)
	SB(2,frontfeed)
	SB(3,readfeed)
	SB(4,idle)
	SB(5,trg)
	SB(6,mg)
	SN(3,tcktgt)
	cnt1=cnt1+1
	loaded=GB(11)
	if loaded then SN(2,1) else SN(2,0) end
	if cnt2>100 or subwp then out=500500 else out=ofst[cnt2]end
	SN(1,out)
	gnrcnna=gnrcnnm-cnt2
	gnrmga=GN(2)
	cmdcnna=GN(3)
	cmdmga=GN(4)
	SN(11,gnrcnna)
	SN(12,gnrmga)
	SN(13,cmdcnna)
	SN(14,cmdmga)
	SB(10,GB(16))
end
S=screen
sC=S.setColor
DL=S.drawLine
DR=S.drawRect
DRF=S.drawRectF
DT=S.drawText
DTB=S.drawTextBox
function onDraw()
	--DT(drawX-6,drawY-11,string.format('%3.0f',TGTs[i].va*60))
	sC(22,222,22)
	dx=0
	dy=0
	sC(66,6,6)
	DRF(dx+15,dy+6,-15*((gnrcnnm-gnrcnna)/gnrcnnm),8)
	sC(22,222,22)
	DTB(dx,dy,32,7,'GNR1 2')
	DR(dx,dy+6,15,8)
	DTB(dx,dy+7,15,8,SF('%2.0f',gnrcnna),0,0)
	dx=16
	dy=0
	sC(66,6,6)
	DRF(dx+15,dy+6,-15*((gnrmgm-gnrmga)/gnrmgm),8)
	sC(22,222,22)
	DR(dx,dy+6,15,8)
	DTB(dx,dy+7,15,8,SF('%2.0f',gnrmga),0,0)

	dx=0
	dy=16
	sC(66,6,6)
	DRF(dx+15,dy+6,-15*((cmdcnnm-cmdcnna)/cmdcnnm),8)
	sC(22,222,22)
	DTB(dx,dy,32,7,'CMD1 2')
	DR(dx,dy+6,15,8)
	DTB(dx,dy+7,15,8,SF('%2.0f',cmdcnna),0,0)

	dx=16
	dy=16
	sC(66,6,6)
	DRF(dx+15,dy+6,-15*((cmdmgm-cmdmga)/cmdmgm),8)
	sC(22,222,22)
	DR(dx,dy+6,15,8)
	DTB(dx,dy+7,15,8,SF('%2.0f',cmdmga),0,0)

end
