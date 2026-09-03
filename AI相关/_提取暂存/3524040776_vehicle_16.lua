-- source: steam id 3524040776 / vehicle.xml block#16
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--search near gps
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
TS=T.insert
emptbl={0,0,0}
function Mp(x,min,max)
	return M.max(min,M.min(x,max))
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
function D2T(d,w)
	return M.atan(w,d)/P
end
function E2R(E) local x,y,z=E[1],E[2],E[3] return {{Mc(y)*Mc(z),Mc(x)*Mc(y)*Ms(z)+Ms(x)*Ms(y),Ms(x)*Mc(y)*Ms(z)-Mc(x)*Ms(y)},{-Ms(z),Mc(x)*Mc(z),Ms(x)*Mc(z)},{Ms(y)*Mc(z),Mc(x)*Ms(y)*Ms(z)-Ms(x)*Mc(y),Ms(x)*Ms(y)*Ms(z)+Mc(x)*Mc(y)}} end
function tM(M) local t={{},{},{}} for i=1,3 do for j=1,3 do t[i][j]=M[j][i] end end return t end
function Mv(M,v) local t={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end t[i]=_ end return t end
function R2G(r) local t=Mv(tM(E2R(Eu)),{r[1]*Mc(r[3]*P)*Ms(r[2]*P),r[1]*Mc(r[3]*P)*Mc(r[2]*P),r[1]*Ms(r[3]*P)}) return {t[1]+sp[1],t[2]+sp[2],t[3]+sp[3]} end
function G2L(g) return Mv(E2R(Eu),{g[1],g[2],g[3]}) end
function L2AE(l) local x,y,z=l[1],l[2],l[3] return M.atan(x,y),M.atan(z,y) end
function Dst(p1,p2) return Mr((p1[1]-p2[1])^2+(p1[2]-p2[2])^2+(p1[3]-p2[3])^2) end
mergedist=PN('merge dist')
function bb2d(s)
	local rst=''
	for i=1,10 do
		if GB(i+s-1) then rst=rst..'1' else rst=rst..'0' end
	end
	return rst
end
function onTick()
	--self position
	sp={GN(4),GN(8),GN(12)}
	Eu={GN(16),GN(20),GN(24)}
	hp={GN(28),GN(32),tonumber(bb2d(1),2)}
	--prepare target data
	guess={}
	tickbuffer={}
	for i=8,1,-1 do
		if GN(4*i-3)~=0 then--if signal
			r={}
			r.r={GN(4*i-3),GN(4*i-2),GN(4*i-1)}--radar d,a,e
			r.p=R2G(r.r)--position
			if #tickbuffer>0 then
				if Dst(r.p,tickbuffer[1])<mergedist then
					TS(tickbuffer,r.p)
				end
			else
				if Dst(r.p,hp)<PN('Radar Search Range') then
					guess=r
					TS(tickbuffer,r.p)
				end
			end
		end
	end
	SN(1,hp[1])
	SN(2,hp[2])
	SN(3,hp[3])
	if #tickbuffer>0 then
		_={0,0,0}
		for i=1,#tickbuffer do
			for j=1,3 do
				_[j]=_[j]+tickbuffer[i][j]
			end
		end
		guess.p={_[1]/#tickbuffer,_[2]/#tickbuffer,_[3]/#tickbuffer}
		SN(1,guess.p[1])
		SN(2,guess.p[2])
		SN(3,guess.p[3])
	end
end