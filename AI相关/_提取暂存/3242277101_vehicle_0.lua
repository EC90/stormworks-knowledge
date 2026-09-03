-- source: steam id 3242277101 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3242277101
--GPS AIM SAMPLE
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.atan
Mb=M.abs
U=M.cos
Mf=M.floor
V=M.sin
Mr=M.sqrt
P=M.pi*2
function Mp(value,vmin,vmax)return math.max(math.min(vmax,value),vmin)end
function E2R(_)
local x,y,z=_[1],_[2],_[3] return {{U(y)*U(z),U(x)*U(y)*V(z)+V(x)*V(y),V(x)*U(y)*V(z)-U(x)*V(y)},{-V(z),U(x)*U(z),V(x)*U(z)},{V(y)*U(z),U(x)*V(y)*V(z)-V(x)*U(y),V(x)*V(y)*V(z)+U(x)*U(y)}}
end
function tM(M) local t={{},{},{}} for i=1,3 do for j=1,3 do t[i][j]=M[j][i] end end return t end
function Mv(M,v) local t={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end t[i]=_ end return t end
function G2L(_) return Mv(E2R(Eu),{_[1],_[2],_[3]}) end
function G2CP(_) return Ma(_[1],_[2]),Ma(_[3],Mr(_[1]^2+_[2]^2)) end
function CD(c,t) c,t=c%1,t%1 if (c-t)>0.5 then t=t+1 elseif (c-t)<-0.5 then t=t-1 end return (c-t) end
Is={} Ds={} Dss={}
function pid(id,v,s,p,i,d,plmt,ilmt) if not Is[id] then Is[id]=0 Ds[id]=0 Dss[id]={} end Is[id]=Mp(Is[id]+i*(s-v),-ilmt,ilmt) local o=Mp(p*(s-v),-plmt,plmt)+Is[id]+d*(s-v-Ds[id]) Ds[id]=s-v return o end
Ta,Te=0,0
function onTick()
	Sp={GN(1),GN(3),GN(2)}
	Eu={GN(4),GN(6),GN(5)}
	gC=GN(17) gP=GN(15)
	Tp={GN(27),GN(28),GN(29)}--dtlk
	il=Tp[1]~=0 and Tp[2]~=0
	--13
	if il then
		Ta,Te=G2CP({Tp[1]-Sp[1],Tp[2]-Sp[2],Tp[3]-Sp[3]})
		Xg=pid(1,CD(-gC,Ta/P),0,3,0.003,3,0.5,0.1)
		Yg=pid(2,gP,Te/P,0,0.2,0.2,0.5,0.25)
		SN(6,Xg)
		SN(7,Yg*4)
		SB(1,true)
	else
		SN(6,0)
		SN(7,0)
		SB(1,false)
	end
end