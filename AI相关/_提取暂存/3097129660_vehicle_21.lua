-- source: steam id 3097129660 / vehicle.xml block#21
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
--radar fcs
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.abs
function Mf(x) return M.floor(x+0.5) end
Mr=M.sqrt
Mc=M.cos
Ms=M.sin
pi=M.pi
P2=pi*2
T=table
SF=string.format
function Mp(x,min,max) return M.max(min,M.min(x,max)) end
function Av(n,v,t) if n==nil then n={0} end t=M.max(Mf(t),1) table.insert(n,v) local s=0 if #n>t then for i=1,#n-t do table.remove(n,1) end end for i=1,#n do s=s+n[i] end return s/#n end
function D2T(d,w) return M.atan(w,d)/P2 end
function E2R(E) local x,y,z=E[1],E[2],E[3] return {{Mc(y)*Mc(z),Mc(x)*Mc(y)*Ms(z)+Ms(x)*Ms(y),Ms(x)*Mc(y)*Ms(z)-Mc(x)*Ms(y)},{-Ms(z),Mc(x)*Mc(z),Ms(x)*Mc(z)},{Ms(y)*Mc(z),Mc(x)*Ms(y)*Ms(z)-Ms(x)*Mc(y),Ms(x)*Ms(y)*Ms(z)+Mc(x)*Mc(y)}} end
function tM(M) local t={{},{},{}} for i=1,3 do for j=1,3 do t[i][j]=M[j][i] end end return t end
function Mv(M,v) local t={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end t[i]=_ end return t end
function R2L(r) return {r[1]*Mc(r[3]*P2)*Ms(r[2]*P2),r[1]*Mc(r[3]*P2)*Mc(r[2]*P2),r[1]*Ms(r[3]*P2)} end
function R2G(r) local t=Mv(tM(E2R(Eu)),{r[1]*Mc(r[3]*P2)*Ms(r[2]*P2),r[1]*Mc(r[3]*P2)*Mc(r[2]*P2),r[1]*Ms(r[3]*P2)}) return {t[1]+sp[1],t[2]+sp[2],t[3]+sp[3]} end
function G2L(g) return Mv(E2R(Eu),{g[1]-sp[1],g[2]-sp[2],g[3]-sp[3]}) end
function L2AE(l) local x,y,z=l[1],l[2],l[3] return M.atan(x,y),M.atan(z,y) end
function DST(p1,p2) return Mr((p1[1]-p2[1])^2+(p1[2]-p2[2])^2+(p1[3]-p2[3])^2) end
AT=PN('average ticks')
Bxb,Byb,Bzb={},{},{}
Bgo={0,0,0}
s1o=0 BVR=false
cnt=0
function onTick()
	sp={GN(11),GN(12),GN(13)} Eu={GN(14),GN(15),GN(16)}
	Tg={GN(1),GN(2),GN(3)}
	--tck
	Hd,Vd,He,Ve=GN(17),GN(18),GN(19)*Mc(GN(20)*P2),-GN(20)/Mc(GN(19)*P2)
	LRL=false
	if Hd~=0 and Vd~=0 then if Ma((Hd-Vd)/Vd)<0.04 and Ma((DST(Tg,sp)-Vd)/Vd)<0.04 then LRL=true end end
	if LRL then Tg=R2G({(Hd+Vd)/2,Ve,He}) end
	--bvr
	Bd,Ba,Be=GN(24),GN(25),GN(26)
	s1=GN(32)
	BVR=GN(27)>0
	if s1>0 and s1o<1 then if Bd>25 then lk=not lk end end
	if Bd>25 then
		Bt=R2G({Bd,Ba,Be})
		U=M.max(U+1,AT)
		if D2T(DST(Bgo,sp),DST(Bt,Bgo))>0.003 then U=1 end
		Bg={Av(Bxb,Bt[1],U),Av(Byb,Bt[2],U),Av(Bzb,Bt[3],U)}
		Bv=DST(Bgo,Bg)
	else
		U=1 lk=false Bg={0,0,0}
	end
	Bgo=Bg
	if lk then Tg=Bg end
	s1o=s1
	--datalink
	aimG=GN(23)>=0
	arad=GN(23)>0
	aid=GN(23)-1
	SN(32,aid)
	Dg={GN(29),GN(30),GN(31)}
	if (aimG or arad)and Dg[1]~=0 then Tg=Dg end
	if Tg[1]~=0 and DST(sp,Tg)>600 then
	aimx,aimy=L2AE(G2L(Tg))
	Ax=GN(21)
	Ay=GN(22)
	SN(11,(aimx-Ax)/P2)
	SN(12,(aimy-Ay)/P2)
	else
	SN(11,0)
	SN(12,0)
	end
	fx0,fy0=0.5*((M.floor(GN(28)/1000)-500)*0.002),-1.38*((GN(28)%1000-500)*0.002)-0.0439
	SB(1,Tg[1]~=0)
	SB(2,GN(1)~=0)
	SN(4,sp[1])
	SN(5,sp[2])
	SN(6,sp[3])
	SN(1,Tg[1])
	SN(2,Tg[2])
	SN(3,Tg[3])
	wp=GN(7)
	if (wp==5 or wp==9) and Tg[1]~=0 then cnt=cnt+1 else cnt=0 end
	if BVR and cnt>90 then rdy=true elseif cnt>60 then rdy=true else rdy=false end
	SB(3,rdy)
	SN(14,GN(6))
end
fov=1.1125
S=screen
SC=S.setColor
DR=S.drawRect
DT=S.drawText
DL=S.drawLine
Bab,Beb={},{}
function Dst(x,y,o)
	for i=1,4 do
		a=(i+0.5*o)*pi/2
		DL(x+3*Ms(a),y+3*Mc(a),x+2*Ms(a),y+2*Mc(a))
	end
end
function onDraw()
	w=S.getWidth() h=S.getHeight()
	fx,fy=w*(fx0/(fov*w/h)),h*(fy0/fov)
	if BVR then
		dcxr,dcyr=0.02*P2,0.02*P2
		dcx,dcy=Mf(w*(dcxr/(fov*w/h))),Mf(h*(dcyr/fov))
		SC(22,222,22,99)
		DR(Mf(w/2-dcx+fx),Mf(h/2+fy),2*dcx,2*dcy)
		if Bd>25 then
			SC(22,222,22,166)
			dcxr,dcyr=L2AE(G2L(Bg))
			dcx,dcy=Mf(w/2+w*(dcxr/(fov*w/h))+fx),Mf(h/2-h*(dcyr/fov)+fy)
			DT(dcx-6,dcy+4,SF('%2.1f',DST(Bg,sp)/1000))
			DT(dcx-6,dcy-10,SF('%3.0f',Mf(Bv*3.6/10)*10))
			Dst(dcx,dcy,1)
			if lk then
				if rdy then SC(222,22,22,166) end
				Dst(dcx,dcy,0)
			end
		end
	end
	if aimG and Dg[1]~=0 then
		SC(22,222,22,166)
		dcxr,dcyr=L2AE(G2L(Dg))
		dcx,dcy=Mf(w/2+w*(dcxr/(fov*w/h))+fx),Mf(h/2-h*(dcyr/fov)+fy)
		DT(dcx-6,dcy+4,SF('%2.1f',DST(Dg,sp)/1000))
		Dst(dcx,dcy,1)
		if arad then
			msg=string.format('%0.0f',aid)
			DT(dcx-string.len(msg)*2.5,dcy-8,msg)
		else
			DT(dcx-7,dcy-8,'GPS')
		end
		if rdy then SC(222,22,22,166) end
		Dst(dcx,dcy,0)
	end
end