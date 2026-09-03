-- source: steam id 3267803171 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3267803171
--PYO's ANTICAUSAL FCS Cold War Build Radar
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.abs
function Mf(x) return M.floor(x+0.5) end
mF=M.floor
Mr=M.sqrt
Mc=M.cos
Ms=M.sin
pi=M.pi
P=pi*2
T=table
function E2R(E) local x,y,z=E[1],E[2],E[3] return {{Mc(y)*Mc(z),Mc(x)*Mc(y)*Ms(z)+Ms(x)*Ms(y),Ms(x)*Mc(y)*Ms(z)-Mc(x)*Ms(y)},{-Ms(z),Mc(x)*Mc(z),Ms(x)*Mc(z)},{Ms(y)*Mc(z),Mc(x)*Ms(y)*Ms(z)-Ms(x)*Mc(y),Ms(x)*Ms(y)*Ms(z)+Mc(x)*Mc(y)}} end
function tM(M) local t={{},{},{}} for i=1,3 do for j=1,3 do t[i][j]=M[j][i] end end return t end
function Mv(M,v) local t={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end t[i]=_ end return t end
function R2G(r) local t=Mv(tM(E2R(Eu)),{r[1]*Mc(r[3]*P)*Ms(r[2]*P),r[1]*Mc(r[3]*P)*Mc(r[2]*P),r[1]*Ms(r[3]*P)}) return {t[1]+sp[1],t[2]+sp[2],t[3]+sp[3]} end
function G2L(g) return Mv(E2R(Eu),{g[1]-sp[1],g[2]-sp[2],g[3]-sp[3]}) end
function L2AE(l) local x,y,z=l[1],l[2],l[3] return M.atan(x,y),M.atan(z,y) end
function SortR(a,b) return Ma(a.r[2])+Ma(a.r[3])<Ma(b.r[2])+Ma(b.r[3]) end
function Dst(p1,p2) return Mr((p1[1]-p2[1])^2+(p1[2]-p2[2])^2+(p1[3]-p2[3])^2) end
seat1o=0
LockID=0
function onTick()
	if GB(4) then slow=2 else slow=1 end
	seat1=GB(1)
	laserRange=GN(32)
	--self position
	sp={GN(4),GN(8),GN(12)}
	Eu={GN(16),GN(20),GN(24)}
	if seat1 and laserRange~=0 and laserRange~=4000 then
		ltg=R2G({laserRange,0,0})
		SN(1,ltg[1])
		SN(2,ltg[2])
		SN(3,ltg[3])
	else
		SN(1,0)
		SN(2,0)
		SN(3,0)
	end
	seat1o=seat1
end