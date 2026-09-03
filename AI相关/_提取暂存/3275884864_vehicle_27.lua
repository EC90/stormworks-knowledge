-- source: steam id 3275884864 / vehicle.xml block#27
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3275884864
--Pyo's Tank Con IV for CVM's Tone
GB=input.getBool
GN=input.getNumber
PN=property.getNumber
SN=output.setNumber
SB=output.setBool
M=math
Ma=M.abs
Mf=M.floor
Mr=M.sqrt
t0={}
cnt1=0
cnt2=0
Ga={1/PN('Gear A Off'),1/PN('Gear A On')}
Gb={1/PN('Gear B Off'),1/PN('Gear B On')}
Gc={1/PN('Gear C Off'),1/PN('Gear C On')}
Gs={
	{0,0,0},
	{1,0,0},
	{0,0,1},
	{1,1,0},
	{0,1,1},
	{1,1,1}}
Rs={}
G1s=PN('Gear 1 Spd')
tpg=PN('time per gear')*60
for i=1,#Gs do
	Rs[i]=Ga[Gs[i][1]+1]*Gb[Gs[i][2]+1]*Gc[Gs[i][3]+1]
end
gear=1
function Mp(x,min,max)
	return M.max(min,M.min(x,max))
end
function sgn(x)
	if x<0 then return -1 else return 1 end
end
Is={}
Ds={}
Dss={}
function pid(id,v,s,p,i,d,plmt,ilmt)
	if not Is[id] then Is[id]=0 Ds[id]=0 Dss[id]={} end
	Is[id]=Mp(Is[id]+i*(s-v),-ilmt,ilmt)
	local rst=Mp(p*(s-v),-plmt,plmt)+Is[id]+d*(s-v-Av(Dss[id],Ds[id],3))
	Ds[id]=s-v
	return rst
end
function Av(n,v,t)
	t=M.max(Mf(t),1) table.insert(n,v) local s=0
	if #n>t then for i=1,#n-t do table.remove(n,1) end end
	for i=1,#n do s=s+n[i] end return s/#n end
cnt3=tpg*1
function onTick()
	--system
	sys=GB(1)
	btr=GN(3)
	rps=GN(4)
	vz=GN(5)
	tmp=GN(6)
	ktmp=Mp((114-tmp)/10,0,1)
	if rps>6 then gen=(1-btr)/0.2 else gen=0 end
	if sys and rps<5 and btr>0.5 then mtr=1 else mtr=0 end
	if rps>5 then gnrt=1-Mp((btr-0.7)/0.3,0,1) else gnrt=0 end
	--order
	spdl=GN(11)
    if spdl>0 then
        ws=GN(2)*(1+Mp((spdl-4-Ma(vz*3.6))/16,-1,0))
    else
        ws=GN(2)
    end
    ad=GN(1)
	kv=sgn(vz+0.5)*(1-Mp(Ma(vz)/50,0,0.7))
	oL=ws+ad*kv*(1-Ma(ws*0.55))
	oR=ws-ad*kv*(1-Ma(ws*0.55))
	MC=1
	if property.getBool('Twin Flow Trans') then
		if vz*oL<-2 or (Ma(oL)<0.2 and Ma(vz)<5) then
			cL=0 bL=true
		else
			cL=Mp(Ma(oL)*0.75,0,0.75)
			bL=false
		end
		if vz*oR<-2 or (Ma(oR)<0.2 and Ma(vz)<5) then
			cR=0 bR=true
		else
			cR=Mp(Ma(oR)*0.75,0,0.75)
			bR=false
		end
	else
		if vz*oL<-2 or (sgn(ws)*oL<0.2 and Ma(vz)<5) then
			cL=0 bL=true
		else
			cL=Mp(sgn(ws)*oL*0.75,0,0.75)
			bL=false
		end
		if vz*oR<-2 or (sgn(ws)*oR<0.2 and Ma(vz)<5) then
			cR=0 bR=true
		else
			cR=Mp(sgn(ws)*oR*0.75,0,0.75)
			bR=false
		end
	end
	if bL and bR and Ma(vz)>5 then
		gen=1
		MC=0
	end
	--enginePID
	if sys then
		if GB(24) then
			_=40
		else
			_=8+14*M.max(cL,cR)+7*(1-cnt2/cnt3)*M.max(cL,cR)+(1-M.max(cL,cR))*(1-btr)*18
		end
		airth=Av(t0,Mp(pid(1,rps,_,PN('Eng P'),PN('Eng I'),PN('Eng D'),PN('P max'),PN('I max')),0,1),6)
	else
		airth=0
	end
	flth=0.5*airth
	--gear
	for i=1,#Rs do
		if Ma(vz)>G1s*(Rs[i]/Rs[1]) and gear==i and gear<#Gs then gear=i+1 cnt1=10 cnt2=tpg*gear cnt3=tpg*gear
		elseif i>1 then if Ma(vz)<0.65*G1s*Rs[i-1]/Rs[1] and gear==i then gear=gear-1  cnt1=10 end end
	end
	if cnt1>0 then cnt1=cnt1-1 end
	if cnt2>0 then cnt2=cnt2-1 end
	if GB(24) then
		Kcharge=0
		SN(7,1)
	else
		Kcharge=1 
		SN(7,gen)
	end
	SN(1,airth*ktmp)
	SN(2,flth*ktmp)
	SN(3,mtr)
	sft=0.5+0.5*(1-cnt1/10)
	SN(4,cL*sft*Kcharge)
	SN(5,cR*sft*Kcharge)
	SN(6,gear)
	SN(8,btr)
	SN(9,rps)
	SN(10,vz)
	SN(11,tmp)
	SN(12,MC)
	SN(13,GN(7)/GN(8))
	SB(1,sys)
	--SB(4,oL<-0.2 and vz<2 or oL<vz and oL<0)
	--SB(5,oR<-0.2 and vz<2)
	SB(4,(vz<-1 and oL<-0.5) or (vz<2 and oL<-0.1))
	SB(5,(vz<-1 and oR<-0.5) or (vz<2 and oR<-0.1))
	SB(6,bL and MC>0)
	SB(7,bR and MC>0)
	SB(8,Gs[gear][1]>0)
	SB(9,Gs[gear][2]>0)
	SB(10,Gs[gear][3]>0)
	SB(11,GB(23))
	SB(12,bL and bR)
end