-- source: steam id 3464467373 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3464467373
GB=input.getBool
GN=input.getNumber
PN=property.getNumber
mrev=property.getBool('Manual Reverse')
krev=1
rev=false
SN=output.setNumber
SB=output.setBool
M=math
Ma=M.abs
Mf=M.floor
Mr=M.sqrt
U=M.cos
V=M.sin
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
function E2R(_)
	local x,y,z=_[1],_[2],_[3] return {{U(y)*U(z),U(x)*U(y)*V(z)+V(x)*V(y),V(x)*U(y)*V(z)-U(x)*V(y)},{-V(z),U(x)*U(z),V(x)*U(z)},{V(y)*U(z),U(x)*V(y)*V(z)-V(x)*U(y),V(x)*V(y)*V(z)+U(x)*U(y)}}
end
function tM(M) local t={{},{},{}} for i=1,3 do for j=1,3 do t[i][j]=M[j][i] end end return t end
function Mv(M,v) local t={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end t[i]=_ end return t end
function G2L(_) return Mv(E2R(E),{_[1],_[2],_[3]}) end
ltso=false ltmd=0
cnt4=0
function onTick()
	--as
	E={GN(24),GN(26),GN(25)}
	as=G2L({GN(20),GN(22),GN(21)})--pry
	--system
	sys=GB(1)
	lts=GB(2)
	hzd=GB(3)
	ad=GN(2)
	lr=GN(19)
	if lr>0.7 or hzd then ltR=true else ltR=false end
	if lr<-0.7 or hzd then ltL=true else ltL=false end 
	if ltR or ltL then cnt4=(cnt4+1)%40 end
	SB(15,ltL and cnt4<20)
	SB(16,ltR and cnt4<20)
	if lts and not ltso then ltmd=(ltmd+1)%3 end
	if ltmd==0 then ltg1=false ltg2=false elseif ltmd==1 then ltg1=true ltg2=false else ltg1=true ltg2=true end
	SB(13,ltg1)
	SB(14,ltg2)
	ltso=lts
	btr=GN(3)
	rps=GN(4)
	tmp=GN(6)
	ktmp=Mp((114-tmp)/10,0,1)
	if rps>6 then gen=(1-btr)/0.3 else gen=0 end
	if sys and rps<3 and btr>0.5 then mtr=1 else mtr=0 end
	if rps>5 then gnrt=1-Mp((btr-0.7)/0.3,0,1) else gnrt=0 end
	--order
	vz=GN(5)
	if GN(27)>0 and Ma(GN(1))>0.99 and not rev then
	ws=Mp(pid(3,vz,GN(1)*GN(27)*krev/3.6,0.1,0.002,0.2,1,0.5),-1,1)
	else ws=GN(1)
	end
	if vz<0 and rev then ws=ws*(1+vz/10) end
	ad=sgn(vz)*pid(2,as[3],0,2,0,4,0.5,0)*(1-Ma(GN(2)))+GN(2)
	kv=1-Mp(Ma(vz)/50,0,1)
	krps=Mp((rps-5)/5,0,1)
	if Ma(vz)<2 and (Ma(ws)<0.1 or (mrev and ws<0)) then hb=true else hb=false end
	if mrev then
		if GN(32)>0 then krev=-1 rev=true else krev=1 rev=false end
	else
		if vz<-1 or (vz<1 and ws<-0.1) then rev=true else rev=false end
	end
	oL=ws+0.1*ad*kv*Ma(ws)
	oR=ws-0.1*ad*kv*Ma(ws)
	if mrev then
		cL=Mp(oL,0,0.8) cR=Mp(oR,0,0.8) brk=0.1*M.max(-ws,0)
	else
		if ws*vz<-0.5 then cL=0 cR=0 brk=0.1*Ma(ws) else cL=Mp(Ma(oL),0,0.8) cR=Mp(Ma(oR),0,0.8) brk=0 end
	end
	--enginePID
	if sys then
		airth=Av(t0,Mp(pid(1,rps,9+8*M.max(cL,cR)+6*(1-cnt2/cnt3)*M.max(cL,cR),PN('Eng P'),PN('Eng I'),PN('Eng D'),PN('P max'),PN('I max')),0,1),6)
	else
		airth=0
	end
	flth=0.5*airth
	--gear
	for i=1,#Rs do
		if vz>G1s*(Rs[i]/Rs[1]) and gear==i and gear<#Gs then gear=i+1 cnt1=30 cnt2=tpg*gear cnt3=tpg*gear
		elseif i>1 then if Ma(vz)<0.65*G1s*Rs[i-1]/Rs[1] and gear==i then gear=gear-1  cnt1=30 end end
	end
	if cnt1>0 then cnt1=cnt1-1 end
	if cnt2>0 then cnt2=cnt2-1 end
	SN(1,airth*ktmp)
	SN(2,flth*ktmp)
	SN(3,mtr)
	SB(11,mtr>0)
	sft=0.5+0.5*(1-cnt1/30)
	SN(4,cL*sft)
	SN(5,cR*sft)
	SN(6,gear)
	SN(7,gen)
	SN(8,btr)
	SN(9,rps)
	SN(10,vz)
	SN(11,tmp)
	if ad<0 then sl=ad*0.7*kv sr=ad*0.6*kv else sl=ad*0.6*kv sr=ad*0.7*kv end
	SN(21,-sl)
	SN(22,sr)
	SN(23,brk)
	SB(1,sys)
	SB(4,rev)
	SB(6,hb)
	SB(8,Gs[gear][1]>0)
	SB(9,Gs[gear][2]>0)
	SB(10,Gs[gear][3]>0)
	SB(17,sys and (brk>0 or ltg1 or ltg2 or hb))
end