-- source: steam id 3384355742 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3384355742
--PYOs FCS hull-trt+sensor-gun Radar + antiMSL
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
function G2L(g) return Mv(E2R(Eu),{g[1]-sp[1],g[2]-sp[2],g[3]-sp[3]}) end
function L2AE(l) local x,y,z=l[1],l[2],l[3] return M.atan(x,y),M.atan(z,y) end
function SortR(a,b) return Ma(a.r[2])+Ma(a.r[3])<Ma(b.r[2])+Ma(b.r[3]) end
function Dst(p1,p2) return Mr((p1[1]-p2[1])^2+(p1[2]-p2[2])^2+(p1[3]-p2[3])^2) end
TGT={}
id=1
mergedist=PN('merge distance')
seat1o=0
LockID=0
dangerCnt=0
cnt=-1
function onTick()
	AT=PN('position ticks')
	vavgl=PN('velocity ticks')
	--self position
	sp={GN(4),GN(8),GN(12)}
	Eu={GN(16),GN(20),GN(24)}
	--lifspan check
	if #TGT>0 then
		for i=1,#TGT do
			if TGT[i].l>10 then
				T.remove(TGT,i)
				break
			end
		end
	end
	--prepare target data
	for i=1,8 do
		if GN(4*i-3)>25 then--if signal
			F=0--same target test
			r={}
			r.r={GN(4*i-3),GN(4*i-2),GN(4*i-1)}--radar d,a,e
			r.p=R2G(r.r)--position
			--check multi submesh and update existed
			if #TGT>0 then--if other target
				for j=1,#TGT do
					delta={}
					for k=1,3 do
						delta[k]=Ma(TGT[j].r[k]-r.r[k])
					end
					if delta[2]<0.002+D2T(TGT[j].r[1],mergedist+TGT[j].va) and delta[3]<0.002+D2T(TGT[j].r[1],mergedist+TGT[j].va) and delta[1]<0.02*TGT[j].r[1]+mergedist+TGT[j].va then--if same target
					--if delta[2]<0.01 and delta[3]<0.01 and delta[1]<0.1*r.r[1] then--if same target
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
				r.g=r.p--guess
				r.b={}--buffer
				r.v=emptbl
				r.va=0--abs velocity
				r.vb={{0},{0},{0}}--velocity buffer
				r.l=0--life
				r.s=1--sample count
				r.id=id
				r.d=0--delta dist
				r.db={}--delta dist buffer
				id=id+1
				TS(TGT,r)
			end
		end
	end
	--process target list
	danger=false
	ddir=0
	if #TGT>0 then
		for i=1,#TGT do
			if TGT[i].l==0 then--if updated
				_=#TGT[i].pb
				if _>1 then--if multi signals
					_u,_v,_w=0,0,0
					for j=1,_ do
						_u=_u+TGT[i].pb[j][1]
						_v=_v+TGT[i].pb[j][2]
						_w=_w+TGT[i].pb[j][3]
					end
					TS(TGT[i].b,{_u/_,_v/_,_w/_})
				else
					TS(TGT[i].b,TGT[i].pb[1])
				end
				temp0=TGT[i].r[1]
				temp1=TGT[i].b[#TGT[i].b]
				temp2,temp3=L2AE(G2L(temp1))
				temp4=Dst(temp1,sp)
				TGT[i].r={temp4,temp2/P,temp3/P}--recalculate d,a,e
				TGT[i].d=Av(TGT[i].db,temp4-temp0,vavgl)
				TGT[i].pb={}--clear position buffer
				_=#TGT[i].b
				if _>AT then
					for k=1,_-AT do
						T.remove(TGT[i].b,1)
					end
				end
				_=#TGT[i].b
				E=M.max(M.min(_-1,Mf(TGT[i].r[1]/2000*AT)),1)--checked
				TGT[i].s=E
				if _>2 then
					sum=emptbl
					for j=_,_-E+1,-1 do
						for k=1,3 do
							sum[k]=sum[k]+TGT[i].b[j][k]
						end
					end
					old={}
					TGT[i].g={}
					for j=1,3 do
						old[j]=TGT[i].p[j]
						temp2=sum[j]/E
						TGT[i].p[j]=temp2
						--Av(n,v,t)
						temp1=Av(TGT[i].vb[j],sum[j]/E-old[j],vavgl)
						TGT[i].v[j]=temp1
						TGT[i].g[j]=temp2+temp1*(TGT[i].s+5)*0.5--idk why dont work
					end
					TGT[i].va=Mr(TGT[i].v[1]^2+TGT[i].v[2]^2+TGT[i].v[3]^2)
					if TGT[i].va>PN('min react speed mps')/60 and TGT[i].va<PN('max react speed mps')/60 and -TGT[i].d/TGT[i].va>PN('ApproachRate/AbsSpeed') then danger=true ddir=TGT[i].r[2] end
				else
					TGT[i].p=TGT[i].b[_]
					TGT[i].g=TGT[i].p
				end
			end
			TGT[i].l=TGT[i].l+1
		end
	end
	if danger then
		dangerCnt=(dangerCnt+1)%PN('ticks per chaff')
		if dangerCnt==10 then
			if ddir>0 then
				deployL=true
			else
				deployR=true
			end
		else
			deployL,deployR=false,false
		end
	else
		dangerCnt=0
	end
	SN(32,ddir)
	SB(30,danger)
	SB(31,deployL)
	SB(32,deployR)
end