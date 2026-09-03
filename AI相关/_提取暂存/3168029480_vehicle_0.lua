-- source: steam id 3168029480 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3168029480
--radar fcs
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.abs
Mf=M.floor
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
function DST(t) return Mr((sp[1]-t[1])^2+(sp[2]-t[2])^2+(sp[3]-t[3])^2) end
cnt=601
Tgo={0,0,0}
aimxo,aimyo=0,0
function onTick()
	sp={GN(1),GN(3),GN(2)} Eu={GN(4),GN(6),GN(5)}
	Tg={GN(11),GN(12),GN(13)}
	--cal
	if Tg[1]~=0 then
		Tgo=Tg
		aimx,aimy=L2AE(G2L(Tgo))
		cnt=0
	else
		cnt=cnt+1
		if cnt>600 then
			aimx,aimy=0,0
			Tgo={0,0,0}
		else
			aimx,aimy=L2AE(G2L(Tgo))
		end
	end
	SN(1,(aimx+(aimx-aimxo))/P2*8)
	SN(2,(aimy+(aimy-aimyo))/P2*8)
	--SN(1,aimx/P2*8)
	--SN(2,aimy/P2*8)
	if Tgo[1]~=0 then
		dT=(DST(Tgo))
		angT=D2T(dT,10)
		cfov=(2.2-angT*P2)/(2.2-0.025)
	else
		dT=0 cfov=0.4
	end
	SN(3,cfov)
	SB(1,GN(14)>0)
	aimxo,aimyo=aimx,aimy
end
fov=1.1125
S=screen
SC=S.setColor
DR=S.drawRect
DT=S.drawText
DL=S.drawLine
Bab,Beb={},{}
function onDraw()
	w=S.getWidth() h=S.getHeight()
	SC(22,222,22)
	DL(w/2-2,h/2,w/2-4,h/2)
	DL(w/2+2,h/2,w/2+4,h/2)
	DL(w/2,h/2-2,w/2,h/2-4)
	DL(w/2,h/2+2,w/2,h/2+4)
	if Tgo[1]~=0 then DT(8,h-6,Mf(DST(Tgo))) end
	x=Mp(w/2+aimx/P2*8*w/2,6,w-6)
	y=Mp(h/2-aimy/P2*8*h/2,6,h-6)
	SC(22,222,22,168)
	DL(x,0,x,h)
	DL(0,y,w,y)
end