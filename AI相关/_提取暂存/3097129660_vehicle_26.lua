-- source: steam id 3097129660 / vehicle.xml block#26
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.abs
function Mf(x) return M.floor(x+0.5) end
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
function SortR(a,b) local taa,tae=L2AE(G2L(a)) tba,tbe=L2AE(G2L(b)) return Ma(taa)+Ma(tae)<Ma(tba)+Ma(tbe) end
function Dst(t) return Mr((sp[1]-t[1])^2+(sp[2]-t[2])^2+(sp[3]-t[3])^2) end
mw,mh,md=16,16,16 U={} W={} Z={} for i=1,8 do Z[i]={} end Uo=0
dxb,dyb,dzb={},{},{}
s1o=0 L=0 Wo={}
A=3 AT=PN('average ticks')
cnt=0
function onTick()
s1=GN(32)
sp={GN(4),GN(8),GN(12)} Eu={GN(16),GN(20),GN(24)}
R={} U={} W={}
for i=1,8 do if GN(4*i-3)>25 then T.insert(R,{GN(4*i-3),GN(4*i-2),GN(4*i-1)}) end end
if #R>0 then
U[1]=R[1] T.insert(Z[1],R2G(R[1]))
if #R>1 then
for i=2,#R do
mk=0
for j=1,#U do
da=Ma(U[j][2]-R[i][2]) de=Ma(U[j][3]-R[i][3]) dd=Ma(U[j][1]-R[i][1])
if da<0.002+D2T(U[j][1],mw) and de<0.002+D2T(U[j][1],mh) and dd<0.02*U[j][1]+md then
T.insert(Z[j],R2G(R[i])) mk=0 break
else mk=1
end
end
if mk>0 then
T.insert(U,R[i]) T.insert(Z[#U],R2G(R[i]))
end
end
end
if #R~=Uo then
A=8
for i=#U+1,8 do
Z[i]={}
end
end
for i=1,#U do
if #Z[i]>A then
for k=1,M.max(#Z[i]-A,1) do
T.remove(Z[i],1)
end
end
_x,_y,_z=0,0,0
for j=1,#Z[i] do
_x=_x+Z[i][j][1] _y=_y+Z[i][j][2] _z=_z+Z[i][j][3]
end
W[i]={_x/#Z[i],_y/#Z[i],_z/#Z[i]}
end
if #W>1 then table.sort(W,SortR) end
else
U={} W={} for i=1,8 do Z[i]={} end
end
Uo=#R
if #W>0 then
if L>0 then
if #W>1 then
if L>#W or Mr((W[L][1]-Wo[1])^2+(W[L][2]-Wo[2])^2+(W[L][3]-Wo[3])^2)>16 then
L=0
for i=1,#W do
if Mr((W[i][1]-Wo[1])^2+(W[i][2]-Wo[2])^2+(W[i][3]-Wo[3])^2)<32 then L=i end
end
end
else
L=1
end
end
if s1>0 and s1o<1 then if L==0 then L=1 Wo=W[1] else L=0 end end
if L>0 then
cnt=cnt+1
dx=Av(dxb,W[L][1]-Wo[1],A) dy=Av(dyb,W[L][2]-Wo[2],A) dz=Av(dzb,W[L][3]-Wo[3],A)
Wo=W[L]
vt=Mr(dx^2+dy^2+dz^2)
A=Mf(Mp(2-vt,0.5,1)*AT)
W[L]={W[L][1]+0.5*A*dx,W[L][2]+0.5*A*dy,W[L][3]+0.5*A*dz}
H,V=L2AE(G2L(W[L]))
else
cnt=0
A=AT/3 H,V=0,0
end
else
A=1 H,V=0,0 L=0
end
if L>0 then SN(1,W[L][1]) SN(2,W[L][2]) SN(3,W[L][3]) else SN(1,0) SN(2,0) SN(3,0) end
SN(21,H/P)
SN(22,V/P)
SN(23,Mp(0.05*(1-A/AT),0.01,0.125))
fx0,fy0=0.5*((M.floor(GN(28)/1000)-500)*0.002),-1.38*((GN(28)%1000-500)*0.002)-0.0439
s1o=s1
end
fov=1.1125
S=screen
SC=S.setColor
DR=S.drawRect
DT=S.drawText
DL=S.drawLine
function DST(x,y,o)
for i=1,4 do
a=(i+0.5*o)*pi/2
DL(x+4*I(a),y+4*O(a),x+3*I(a),y+3*O(a))
end
end
function onDraw()
w=S.getWidth() h=S.getHeight()
fx,fy=Mf(w*(fx0/(fov*w/h))),Mf(h*(fy0/fov))
dcx,dcy=0,0
if #W>0 then
	for i=1,#W do
		dcxr,dcyr=L2AE(G2L(W[i]))
		dcx,dcy=Mf(w/2+w*(dcxr/(fov*w/h))),Mf(h/2-h*(dcyr/fov))
		SC(22,222,22,166)
		DST(fx+dcx,fy+dcy,1)
		if i<2 or i==L then
			DT(fx+dcx-6,fy+dcy+5,SF('%2.1f',Dst(W[i])/1000))
		end
		if i==L then
			if cnt>60 then SC(222,22,22,166) else SC(22,222,22,166) end
			DST(fx+dcx,fy+dcy,0)
		end
	end
end
end