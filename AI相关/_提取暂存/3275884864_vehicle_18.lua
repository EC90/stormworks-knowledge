-- source: steam id 3275884864 / vehicle.xml block#18
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3275884864
--datalink3radarDenoiser
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
O=M.cos
I=M.sin
pi=M.pi
P=pi*2
T=table
SF=string.format
function Mp(x,min,max) return M.max(min,M.min(x,max)) end
function Av(n,v,t) if n==nil then n={0} end t=M.max(Mf(t),1) table.insert(n,v) local s=0 if #n>t then for i=1,#n-t do table.remove(n,1) end end for i=1,#n do s=s+n[i] end return s/#n end
function D2T(d,w) return M.atan(w,d)/P end
function E2R(E) local x,y,z=E[1],E[2],E[3] return {{O(y)*O(z),O(x)*O(y)*I(z)+I(x)*I(y),I(x)*O(y)*I(z)-O(x)*I(y)},{-I(z),O(x)*O(z),I(x)*O(z)},{I(y)*O(z),O(x)*I(y)*I(z)-I(x)*O(y),I(x)*I(y)*I(z)+O(x)*O(y)}} end
function tM(M) local t={{},{},{}} for i=1,3 do for j=1,3 do t[i][j]=M[j][i] end end return t end
function Mv(M,v) local t={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end t[i]=_ end return t end
function R2G(r) local t=Mv(tM(E2R(Eu)),{r[1]*O(r[3]*P)*I(r[2]*P),r[1]*O(r[3]*P)*O(r[2]*P),r[1]*I(r[3]*P)}) return {t[1]+sp[1],t[2]+sp[2],t[3]+sp[3]} end
function G2L(g) return Mv(E2R(Eu),{g[1]-sp[1],g[2]-sp[2],g[3]-sp[3]}) end
function L2AE(l) local x,y,z=l[1],l[2],l[3] return M.atan(x,y),M.atan(z,y) end
function SortR(a,b) return Ma(a.a)+Ma(a.e)<Ma(b.a)+Ma(b.e) end
function Dst(p1,p2) return Mr((p1[1]-p2[1])^2+(p1[2]-p2[2])^2+(p1[3]-p2[3])^2) end
AT=200
U={}
id=1
mw,mh,md=9,9,9
s1o=0 L=0
function onTick()
	s1=GB(1)
	rdr=GB(5)
	lsr=GN(32)
	sp={GN(4),GN(8),GN(12)} Eu={GN(16),GN(20),GN(24)}
	if #U>0 then
		for i=1,#U do
			if U[i].l>10 then
				T.remove(U,i)
				break
			end
		end
	end
	if #U>0 then
		for i=1,#U do
			if U[i].l==0 then
				if #U[i].dN>1 then
					_u,_v,_w=0,0,0
					for j=1,#U[i].dN do
						_u=_u+U[i].dN[j][1]
						_v=_v+U[i].dN[j][2]
						_w=_w+U[i].dN[j][3]
					end
					_=#U[i].dN
					T.insert(U[i].dB,{_u/_,_v/_,_w/_})
				else
					T.insert(U[i].dB,U[i].dN[1])
				end
				U[i].dN={}
				if #U[i].dB>AT then
					for k=1,M.max(#U[i].dB-AT,1) do
						T.remove(U[i].dB,1)
					end
				end
				E=M.min(#U[i].dB-1,Mf(U[i].d/2000*AT))
				U[i].E=E
				if #U[i].dB>2 then
					_x,_y,_z=0,0,0
					_X,_Y,_Z=U[i][1],U[i][2],U[i][3]
					for j=#U[i].dB,#U[i].dB-E+1,-1 do
						_x=_x+U[i].dB[j][1]
						_y=_y+U[i].dB[j][2]
						_z=_z+U[i].dB[j][3]
					end
					U[i][1],U[i][2],U[i][3]=_x/E,_y/E,_z/E
					U[i].vx,U[i].vy,U[i].vz=Av(U[i].xv,_x/E-_X,99),Av(U[i].yv,_y/E-_Y,99),Av(U[i].zv,_z/E-_Z,99)
					U[i].xg,U[i].yg,U[i].zg=U[i][1]+U[i].vx*E/2,U[i][2]+U[i].vy*E/2,U[i][3]+U[i].vz*E/2
					U[i].v=Mr(U[i].vx^2+U[i].vy^2+U[i].vz^2)
				end
				U[i].d=Dst(U[i],sp)
				U[i].a,U[i].e=L2AE(G2L({U[i].xg,U[i].yg,U[i].zg}))
			end
			U[i].l=U[i].l+1
		end
	end
	for i=1,8 do
		if GN(4*i-3)>25 then
			r=R2G({GN(4*i-3),GN(4*i-2),GN(4*i-1)})
			r.xg,r.yg,r.zg=r[1],r[2],r[3]
			r.dN={r} r.dB={}
			r.d,r.a,r.e=GN(4*i-3),GN(4*i-2)*P,GN(4*i-1)*P
			r.l,r.v=0,0
			r.E=1
			r.xv,r.yv,r.zv={},{},{}
			r.vx,r.vy,r.vz=0,0,0
			if #U>0 then
				F=0
				for j=1,#U do
					dd=Ma(U[j].d-r.d)/P
					da=Ma(U[j].a-r.a)/P
					de=Ma(U[j].e-r.e)/P
					if da<0.002+D2T(U[j].d,mw) and de<0.002+D2T(U[j].d,mh) and dd<0.02*U[j].d+md then
						T.insert(U[j].dN,{r[1],r[2],r[3]})
						U[j].l=0
						F=0
						break
					else
						F=1
					end
				end
				if F>0 then
					r.id=id
					id=id+1
					T.insert(U,r)
				end
			else
				r.id=id
				id=id+1
				T.insert(U,r)
			end
		end
	end
	for i=1,8 do
		SN(i,0)
	end
	if #U>0 then
		SN(1,U[1][1])
		SN(2,U[1][2])
		SN(3,U[1][3])
		if #U==1 then
			cur=1
			total=1
		end
		if #U>1 then
			cur=cur+1
			total=M.min(9,#U)
			if cur>total then cur=2 end
			SN(4,U[cur][1])
			SN(5,U[cur][2])
			SN(6,U[cur][3])
		end
		SN(7,cur)
		SN(8,total)
	end
end