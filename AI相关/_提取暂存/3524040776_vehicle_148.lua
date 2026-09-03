-- source: steam id 3524040776 / vehicle.xml block#148
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776

GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.abs
function Mf(a)
	return M.floor(a+0.5)
end
mF=M.floor
Mr=M.sqrt
Mc=M.cos
Ms=M.sin
pi=M.pi
P=pi*2
T=table
TS=T.insert
function Mp(a,b,c)
	return M.max(b,M.min(a,c))
end

function Av(tbl,value,samples)
	local samples=M.max(Mf(samples),1)
	TS(tbl,value)
	local g=0
	if#tbl>samples then
		for h=1,#tbl-samples do
			table.remove(tbl,1)
			break 
		end
	end
	for h=1,#tbl do
		g=g+tbl[h]
	end
	if #tbl<10 then
		return 0
	else
		return g/#tbl 
	end
end
function D2T(i,j)
	return M.atan(j,i)/P 
end
function E2R(k)
	local a,l,m=k[1],k[2],k[3]return{{Mc(l)*Mc(m),Mc(a)*Mc(l)*Ms(m)+Ms(a)*Ms(l),Ms(a)*Mc(l)*Ms(m)-Mc(a)*Ms(l)},{-Ms(m),Mc(a)*Mc(m),Ms(a)*Mc(m)},{Ms(l)*Mc(m),Mc(a)*Ms(l)*Ms(m)-Ms(a)*Mc(l),Ms(a)*Ms(l)*Ms(m)+Mc(a)*Mc(l)}}
end
function tM(M)
	local f={{},{},{}}
	for h=1,3 do
		for n=1,3 do
			f[h][n]=M[n][h]
		end
	end
	return f 
end
function Mv(M,e)
	local f={}
	for h=1,3 do
		_=0
		for n=1,3 do
			_=_+M[n][h]*e[n]end
		f[h]=_ 
	end
	return f 
end
function R2G(r)
	local f=Mv(tM(E2R(Eu)),{r[1]*Mc(r[3]*P)*Ms(r[2]*P),r[1]*Mc(r[3]*P)*Mc(r[2]*P),r[1]*Ms(r[3]*P)})
	return{f[1]+sp[1],f[2]+sp[2],f[3]+sp[3]}
end
function G2L(o)
	return Mv(E2R(Eu),{o[1],o[2],o[3]})
end
function L2AE(p)
	local a,l,m=p[1],p[2],p[3]
	return M.atan(a,l),M.atan(m,l)
end
function Dst(q,s)
	return Mr((q[1]-s[1])^2+(q[2]-s[2])^2+(q[3]-s[3])^2)
end
function SortD(t,u)
	return Dst(hpo,t.pr)<Dst(hpo,u.pr)
end
function SortL(t,u)
	return t.l<u.l 
end
function kalman_init()
	local v={}
	v.x=0
	v.P=1
	v.Q=property.getNumber('Q')/1e6
	v.R=property.getNumber('R')/1e6
	v.K=0
	return v 
end
function kalman_update(v,m)v.P=v.P+v.Q
	v.K=v.P/(v.P+v.R)v.x=v.x+v.K*(m-v.x)v.P=(1-v.K)*v.P
	return v.x 
end
kalmana=kalman_init()
kalmane=kalman_init()
function Vsb(w,x)
	return{w[1]-x[1],w[2]-x[2],w[3]-x[3]}
end
function Vcs(w,x)
	return{w[2]*x[3]-w[3]*x[2],w[3]*x[1]-w[1]*x[3],w[1]*x[2]-w[2]*x[1]}
end
function Vdt(w,x)
	return w[1]*x[1]+w[2]*x[2]+w[3]*x[3]
end
function Vma(e)
	return Mr(e[1]*e[1]+e[2]*e[2]+e[3]*e[3])
end
function Vsc(e,y)
	return{e[1]*y,e[2]*y,e[3]*y}
end
function Cav(z,A)
	local B=Vsb(z,sp)
	local C=Vsc(Vsb(A,sv),60)
	local D=Vma(B)
	if D<1e-6 then
		return{0,0,0}
	end
	local E=Vcs(B,C)
	local F=D*D
	return Vsc(E,1/F)
end
hpo={0,0,0}
mergedist=PN('merge dist')
hplife=0
guesso={}
guess={}t1,t2,t3={},{},{}t4,t5,t6={},{},{}
guessa=0
guesse=0
guessolf=0
va=0
function onTick()
	sp={GN(4),GN(8),GN(12)}
	if spo then
		sv=Vsb(sp,spo)
	else
		sv={0,0,0}
	end
	spo=sp
	Eu={GN(16),GN(20),GN(24)}
	hp={GN(29),GN(30),GN(31)}
	if hp[1]~=0 then
		if GN(32)==0 and Dst(hp,hpo)>PN('Radar Search Range')+hplife*10 then
			hp={0,0,0}
			hplife=hplife+1
		else
			hpo=hp
			hplife=0
		end
	else
		hplife=hplife+1
	end
	guess={}
	-- ===  ===
	tickbuffer = {}
	local candidates = {}

	-- 
	for h = 7, 1, -1 do
		if GN(4*h-3) ~= 0 then
			local r = {}
			r.r = {GN(4*h-3), GN(4*h-2), GN(4*h-1)}
			r.p = R2G(r.r)
            r.id = h -- 
			-- 
			if Dst(r.p, hpo) < PN('Radar Search Range') + hplife * 10 then
				TS(candidates, r)
			end
		end
	end

	-- 
	--  1) (guesso.p)
	--  2)  hpo  sp 
	--   'switch proximity' mergedist
	local proximity = PN('switch proximity')
	if proximity == 0 then proximity = mergedist end

	local selected = nil
	local closest = nil
	local closest_dist = 1e12

	--  hpo/
	local basePoint = hpo

	-- 
	if guesso and guesso.p then
		for i = 1, #candidates do
			local c = candidates[i]
			local d_to_prev = Dst(c.p, guesso.p)
			--  candidate 
			if d_to_prev <= proximity then
				selected = c
				break
			end
			--  basePoint 
			local d_base = Dst(c.p, basePoint)
			if d_base < closest_dist then
				closest = c
				closest_dist = d_base
			end
		end
	else
		--  basePoint 
		for i = 1, #candidates do
			local c = candidates[i]
			local d_base = Dst(c.p, basePoint)
			if d_base < closest_dist then
				closest = c
				closest_dist = d_base
			end
		end
	end

	-- 
	if not selected and closest then
		selected = closest
	end

	--  mergedist  tickbuffer
	if selected then
		for i = 1, #candidates do
			local c = candidates[i]
			if Dst(c.p, selected.p) < mergedist then
				TS(tickbuffer, c.p)
			end
		end
		--  selected 
		if #tickbuffer == 0 then
			TS(tickbuffer, selected.p)
		end
		--  guess  r 
		guess = selected
	end

	-- ===  ===
	if #tickbuffer > 0 then
		if #tickbuffer > 1 then
			_ = {0,0,0}
			for h = 1, #tickbuffer do
				for n = 1, 3 do
					_[n] = _[n] + tickbuffer[h][n]
				end
			end
			guess.p = {_[1] / #tickbuffer, _[2] / #tickbuffer, _[3] / #tickbuffer}
		else
			-- guess.p  selected.p
			--  guess  nil 
			if not guess.p and #tickbuffer == 1 then
				guess = { p = tickbuffer[1], r = {0,0,0} }
			end
		end
	end
	if guessolf>0 and guessolf<60 then
		SN(1,0)
		SN(2,0)
		SN(3,0)
	else
		SN(1,hp[1])
		SN(2,hp[2])
		SN(3,hp[3])
	end
	SN(4,0)
	SN(5,0)
	SN(6,0)
	SN(11,0)
	SN(12,0)
	if guess.p then
		guessa,guesse=L2AE(G2L(Vsb(guess.p,sp)))
		ao=kalman_update(kalmana,guessa/P)
		eo=kalman_update(kalmane,guesse/P)
        guess.ps=R2G({guess.r[1],ao,eo})
		if guesso.ps then
			--AT=mF((1-Mp(va/0.5,0,1))*20)+20
			--spl=Mp(mF(AT*(Dst(guess.p,sp)-10)/1000),19,AT)
            -- 
            --dist = Dst(guess.p, sp)
            --AT = mF((1 - Mp(va/0.5, 0, 1)) * 30) + 30 --  30-60 
            --spl = Mp(mF(AT * dist / 1500), 10, AT)   --  10 
            --guess.v = {Av(t1, dx/dt, spl), Av(t2, dy/dt, spl), Av(t3, dz/dt, spl)}
            spl=60
			guess.v={Av(t1,(guess.ps[1]-guesso.ps[1])/guessolf,spl),Av(t2,(guess.ps[2]-guesso.ps[2])/guessolf,spl),Av(t3,(guess.ps[3]-guesso.ps[3])/guessolf,spl)}
			av=G2L(Cav(guess.p,guess.v))
			va=Av(t4,Dst(guess.v,{0,0,0}),20)
		else
			va=0
		end
        if #t1>10 then
            SN(1,guess.p[1])
            SN(2,guess.p[2])
            SN(3,guess.p[3])
            SN(4,guess.v[1])
			SN(5,guess.v[2])
			SN(6,guess.v[3])            
			SN(11,av[3])
			SN(12,av[1])
        end
		guesso=guess
        guessolf=1
	end
	if guesso.p and not guess.p then
		guessolf=guessolf+1 
	end
	SN(21,guessolf)
    SN(22, (guess and guess.id == 1)and 1 or 0)
end