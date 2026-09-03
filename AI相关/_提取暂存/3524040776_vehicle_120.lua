-- source: steam id 3524040776 / vehicle.xml block#120
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--FireEye MP FlightCon
GB=input.getBool
GN=input.getNumber
PN=property.getNumber
SN=output.setNumber
SB=output.setBool
M=math
Ma=M.atan
Mb=M.abs
Mc=M.cos
Mf=M.floor
Ms=M.sin
Mr=M.sqrt
P=M.pi*2
T=table
TS=T.insert
function Mp(v,i,a)return M.max(M.min(a,v),i)end
function E2R(_)
	local x,y,z=_[1],_[2],_[3]
	return {{Mc(y)*Mc(z),Mc(x)*Mc(y)*Ms(z)+Ms(x)*Ms(y),Ms(x)*Mc(y)*Ms(z)-Mc(x)*Ms(y)},{-Ms(z),Mc(x)*Mc(z),Ms(x)*Mc(z)},{Ms(y)*Mc(z),Mc(x)*Ms(y)*Ms(z)-Ms(x)*Mc(y),Ms(x)*Ms(y)*Ms(z)+Mc(x)*Mc(y)}}
end
function tM(M) local t={{},{},{}} for i=1,3 do for j=1,3 do t[i][j]=M[j][i] end end return t end
function Mv(M,v) local t={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end t[i]=_ end return t end
function G2L(_) return Mv(E2R(Eu),{_[1],_[2],_[3]}) end
function L2AE(l) return Ma(l[1],l[2]),Ma(l[3],l[2]) end
function G2CP(_) return Ma(_[1],_[2])/P,Ma(_[3],Mr(_[1]^2+_[2]^2))/P end
function CD(c,t)
	c,t=c%1,t%1
	if (c-t)>0.5 then
		t=t+1
	elseif (c-t)<-0.5 then
		t=t-1
	end
	return (c-t)
end
Is={} Ds={} Dss={}
function pid(id,v,s,p,i,d,pI,iI)
	if not Is[id] then
		Is[id]=0
		Ds[id]=0
		Dss[id]={}
	end
	Is[id]=Mp(Is[id]+i*(s-v),-iI,iI)
	local o=Mp(p*(s-v),-pI,pI)+Is[id]+d*(s-v-Ds[id])
	Ds[id]=s-v
	return o
end
function dst(a,b)
	return Mr((a[1]-b[1])^2+(a[2]-b[2])^2+(a[3]-b[3])^2)
end
function Av(n,v,t)
	t=M.max(Mf(t),1)
	TS(n,v)
	local s=0
	if #n>t then
		for i=1,#n-t do
			table.remove(n,1)
			break
		end
	end
	for i=1,#n do
		s=s+n[i]
	end
	return s/#n
end
tgtg={0,0,0}
tgto={0,0,0}
tgtgv={0,0,0}
aim={0,0,0}
life=0
tgtd=0
eta=0
temp={}
vzo=0
launch=0
vzmax=0
zstart=0
etao=0
tgtdo=0
function onTick()
	--Input
	Sp={GN(1),GN(3),GN(2)}
	Eu={GN(4),GN(6),GN(5)}
	vx,vy,vz=GN(7),GN(8),GN(9)
	tgt={GN(11),GN(12),GN(13)}
	tgtv={GN(14),GN(15),GN(16)}
	if launch==0 then zstart=GN(2) end
	if GN(17)==0 then
		launch=launch+1
	end
	if GN(22)>0.5 and guessolf<0.5 then
		Is = {} -- 
    	Ds = {} -- 
	end
	guessolf=GN(22)
	Ksd=Mp(launch/PN('Start Delay'),0,1)
	--guess cord cal
	if tgt[1]~=0 then
		if life>0 then
			if tgtv[1]==0 and dst(tgto,tgt)/life<8 and life<600 then
				tgtgv={(tgt[1]-tgto[1])/life,(tgt[2]-tgto[2])/life,(tgt[3]-tgto[3])/life}
			else
				tgtgv={0,0,0}
			end
		else
			if tgtv[1]~=0 then
				tgtgv=tgtv
			else
				tgtgv={tgt[1]-tgto[1],tgt[2]-tgto[2],tgt[3]-tgto[3]}
			end
		end
		life=0
		tgtg=tgt
		tgto=tgt
	else
		life=life+1
		if life<PN('lifespan') then
			tgtg={tgto[1]+tgtgv[1]*life,tgto[2]+tgtgv[2]*life,tgto[3]+tgtgv[3]*life}
		else
			tgto={0,0,0}
			tgtg={0,0,0}
			tgtgv={0,0,0}
		end
	end
	if tgtg[1]~=0 then
		--path
		if tgtg[3]<PN('path active alt')+zstart then
			tgtdh=dst({tgtg[1],tgtg[2],0},{Sp[1],Sp[2],0})
			if Sp[3]<PN('path height') and tgtdh>PN('path active dist')*2 then
				zofst=30000*Mp(tgtdh/PN('path active dist'),0,1)
			else
				zofst=Mp((tgtdh-PN('path active dist'))/PN('path active dist'),0,1)*PN('path height')
			end
		else
			zofst=0
		end
		--aim cord cal
		aim={tgtg[1]+eta*tgtgv[1],tgtg[2]+eta*tgtgv[2],tgtg[3]+eta*tgtgv[3]+zofst}
		--eta cal
		if tgtd~=0 then
			tgtdd=Av(temp,Mp(dst(tgtg,Sp)-tgtd,-3*vz,3*vz),4)
		else
			tgtdd=-1
		end
		tgtd=dst(tgtg,Sp)
		eta=Mp(-tgtd/tgtdd+PN('Lead offset'),0,PN('Max Lead'))
		taa,tea=L2AE(G2L({aim[1]-Sp[1],aim[2]-Sp[2],aim[3]-Sp[3]}))
		Kv=Mp(vz/60,0,1)
		if vz>30 then
			ta,te=taa-Ma(vx,vz)*Kv,tea-Ma(vy,vz)*Kv
		else
			ta,te=taa,tea
		end
		Knear=1+PN('K end')*Mp(200-tgtd,0,1)
		K=Ksd*Kv*Knear
		--K=1
		if tgtd<PN('PN active distance') then
			ao=pid(3,GN(18),0,PN('K pn'),0.06*PN('K pn'),0,1,0.3)
			eo=-pid(4,GN(19),0,PN('K pn'),0.06*PN('K pn'),0,1,0.3)
		elseif tgtd<PN('radar fin active distance') and GN(20)~=0 and (-tgtdd*60>vz*PN('radar fin active velocity') or GN(23)>0.5) then
			ao=GN(20)*PN('K radar fin')
			eo=GN(21)*PN('K radar fin')
		else
			ao=-pid(1,ta,0,PN('P')*K,PN('I')*K,PN('D')*K,PN('P max'),PN('I max')*K)
			eo=-pid(2,te,0,PN('P')*K,PN('I')*K,PN('D')*K,PN('P max'),PN('I max')*K)
		end
		SN(21,tgtd)
		SN(22,tgtdd)
		SN(23,eta)
		fseta=-tgtd/tgtdd<PN('VT Fuse tick') and tgtdo>0 and tgtdo<50
		fsmiss=eta>etao and tgtdd>1 and tgtdo<50 and tgtdo>0 and tgtd<50 and etao<10
		vtfuse=fseta or fsmiss
	else
		aim={0,0,0}
		eta=PN('Max Lead')
		tgtd=0
		ao=0
		eo=0
	end
	etao=eta
	tgtdo=tgtd
	if vz-vzo<-PN('impact speed gate') and vzo>30 then
		impactfuse=true
	else
		impactfuse=false
	end
	vzmax=M.max(vzmax,vz)
	vzo=vz
	SB(1,launch>PN('Start Delay') and (vtfuse or impactfuse) and GN(22)>0)
	SN(1,ao)
	SN(2,eo*PN('Y mtpl'))
	SN(11,aim[1])
	SN(12,aim[2])
	SN(13,aim[3])
	SN(14,tgtgv[1])
	SN(15,tgtgv[2])
	SN(16,tgtgv[3])
	SN(17,vzmax)
	SN(18,launch)
	SN(19,zofst)
end