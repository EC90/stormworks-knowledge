-- source: steam id 3358095813 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3358095813
aoffset=-0.25+0.125
--tws radar v2
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
function E2R(E) local x,y,z=E[1],E[2],E[3] return {{Mc(y)*Mc(z),Mc(x)*Mc(y)*Ms(z)+Ms(x)*Ms(y),Ms(x)*Mc(y)*Ms(z)-Mc(x)*Ms(y)},{-Ms(z),Mc(x)*Mc(z),Ms(x)*Mc(z)},{Ms(y)*Mc(z),Mc(x)*Ms(y)*Ms(z)-Ms(x)*Mc(y),Ms(x)*Ms(y)*Ms(z)+Mc(x)*Mc(y)}} end
function tM(M) local t={{},{},{}} for i=1,3 do for j=1,3 do t[i][j]=M[j][i] end end return t end
function Mv(M,v) local t={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end t[i]=_ end return t end
function R2G(r) local t=Mv(tM(E2R(Eu)),{r[1]*Mc(r[3]*P)*Ms(r[2]*P),r[1]*Mc(r[3]*P)*Mc(r[2]*P),r[1]*Ms(r[3]*P)}) return {t[1]+sp[1],t[2]+sp[2],t[3]+sp[3]} end
function G2L(g) return Mv(E2R(Eu),{g[1]-sp[1],g[2]-sp[2],g[3]-sp[3]}) end
function L2AE(l) local x,y,z=l[1],l[2],l[3] return M.atan(x,y),M.atan(z,y) end
function Dst(p1,p2) return Mr((p1[1]-p2[1])^2+(p1[2]-p2[2])^2+(p1[3]-p2[3])^2) end
TGT={}
mergedist=PN('merge dist')
function onTick()
	--self position
	sp={GN(4),GN(8),GN(12)}
	Eu={GN(16),GN(20),GN(24)}
	--prepare target data
	if #TGT==0 then
		for i=1,8 do
			if GN(4*i-3)>PN('min signal dist') then--if signal
				F=0--same target test
				r={}
				r.r={GN(4*i-3),GN(4*i-2)+aoffset,GN(4*i-1)}--radar d,a,e
				r.p=R2G(r.r)--position
				--check multi submesh and update existed
				if #TGT>0 then--if other target
					for j=1,#TGT do
						if Dst(r.p,TGT[j].p)<mergedist+Ms(0.002*P)*r.r[1] then
							TS(TGT[j].pb,r.p)--merge
							TGT[j].l=0
							F=0
							break
						else
							F=1
						end
					end
				else
					F=1
				end
				if F>0 then
					r.pb={r.p}--position buffer
					TS(TGT,r)
				end
			end
		end
		--process target list
		if #TGT>0 then
			for i=1,#TGT do
				_=#TGT[i].pb
				if _>1 then--if multi signals
					_u,_v,_w=0,0,0
					for j=1,_ do
						_u=_u+TGT[i].pb[j][1]
						_v=_v+TGT[i].pb[j][2]
						_w=_w+TGT[i].pb[j][3]
					end
					TGT[i].p={_u/_,_v/_,_w/_}
				end
			end
		end
	end
	if #TGT>0 then
		SN(1,TGT[1].p[1])
		SN(2,TGT[1].p[2])
		SN(3,TGT[1].p[3])
		T.remove(TGT,1)
	else
		SN(1,0)
		SN(2,0)
		SN(3,0)
	end
end