-- source: steam id 3524040776 / vehicle.xml block#13
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--gps2aim
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.atan
Mb=M.abs
Mc=M.cos
Mf=M.floor
Ms=M.sin
Mr=M.sqrt
P=M.pi*2
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
gunY=0
AimTgtX,AimTgtY=0,0
False=false
T2D=360
function onTick()
	Sp={GN(1),GN(3),GN(2)}
	--
	gunPit=GN(15)
	gunCps=GN(17)
	--target input
	Tp={GN(21),GN(22),GN(23)}
	istgt=Tp[1]~=0 and Tp[2]~=0
	trtRot=GN(27)
	CosTrtRot=Mc(trtRot*P)
	gunYmin=PN('-')/T2D
	gunYmax=PN('+')/T2D
	if istgt then
		Aim={Tp[1],Tp[2],Tp[3]}
		AimTgtX,AimTgtY=G2CP({Aim[1]-Sp[1],Aim[2]-Sp[2],Aim[3]-Sp[3]})
		gunX=-pid(1,CD(-gunCps,AimTgtX)*P,0,1,0.1,1,0.2,0.1)
		gunY=pid(2,gunPit,AimTgtY,0,0.3,0.3,1,1)
		Sx=-GN(10)*4
		Sy=-GN(11)*0.05
	else
		Sx=0 Sy=0
		gunX=pid(5,CD(trtRot,0)*P,0,4,0.005,6,0.5,0.1)
		gunY=0
	end
	SN(3,gunX+Sx)
	SN(4,Mp(gunY+Sy,gunYmin*4,gunYmax*4))
end