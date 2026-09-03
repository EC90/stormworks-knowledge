-- source: steam id 3168029480 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3168029480
--SRC
S=screen
SC=S.setColor

DC=S.drawCircle
DCF=S.drawCircleF
L=S.drawLine
DT=S.drawText
DTB=S.drawTextBox
DR=S.drawRect
DRF=S.drawRectF

M=math
Ma=M.abs
Mc=M.cos
Mf=M.floor
Ms=M.sin
Mr=M.sqrt
P2=M.pi*2

GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
T=table

isswp=PN('Sweep Mode')
swpspd=PN('Sweep Speed %')*0.00006366
swplmt=PN('Sweep Limit')*4
mts=PN('Expired Max Target Speed mps')/60

if isswp==1 then lfspn=swplmt/swpspd else lfspn=1/swpspd end
tcd=false
outx,outy=0,0
R={}
curb={0}
curo=0
z=1
w,h=64,64
ctd=0
maxlife=300
dftz=8000
function DC(x,y,r) for i=1,360 do x1=x+r*Ms(P2*i/360) y1=y-r*Mc(P2*i/360) x2=x+r*Ms(P2*(i+1)/360) y2=y-r*Mc(P2*(i+1)/360) L(x1,y1,x2,y2) end end
function DCp(x,y,r,s,e) for i=s,e do x1=x+r*Ms(P2*i/360) y1=y-r*Mc(P2*i/360) x2=x+r*Ms(P2*(i+1)/360) y2=y-r*Mc(P2*(i+1)/360) L(x1,y1,x2,y2) end end
function PB(bx,by,bw,bh) if tc and tx>bx and tx<bx+bw and ty>by and ty<by+bh then return true else return false end end
function DB(bx,by,bw,bh,msg,stts) if stts then SC(30,90,30) DRF(bx,by,bw,bh) SC(0,0,0,200) DT(bx+1,by+1,msg) SC(22,222,22) else SC(0,0,0,200) DRF(bx,by,bw,bh) SC(30,90,30) DT(bx+1,by+1,msg) end end
function Mp(x,min,max) return M.max(min,M.min(x,max)) end
function E2R(E) local x,y,z=E[1],E[2],E[3] return {{Mc(y)*Mc(z),Mc(x)*Mc(y)*Ms(z)+Ms(x)*Ms(y),Ms(x)*Mc(y)*Ms(z)-Mc(x)*Ms(y)},{-Ms(z),Mc(x)*Mc(z),Ms(x)*Mc(z)},{Ms(y)*Mc(z),Mc(x)*Ms(y)*Ms(z)-Ms(x)*Mc(y),Ms(x)*Ms(y)*Ms(z)+Mc(x)*Mc(y)}} end
function tM(M) local t={{},{},{}} for i=1,3 do for j=1,3 do t[i][j]=M[j][i] end end return t end
function Mv(M,v) local t={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end t[i]=_ end return t end
function R2G(r) local t=Mv(tM(E2R(Eu)),{r[1]*Mc(r[3]*P2)*Ms(r[2]*P2),r[1]*Mc(r[3]*P2)*Mc(r[2]*P2),r[1]*Ms(r[3]*P2)}) return {t[1]+sp[1],t[2]+sp[2],t[3]+sp[3]} end
function G2L(l) return Mv(E2R(Eu),{l[1]-sp[1],l[2]-sp[2],l[3]-sp[3]}) end
function L2DAE(l) local x,y,z=l[1],l[2],l[3] return Mr(l[1]^2+l[2]^2+l[3]^2),M.atan(x,y),M.atan(z,y) end
function onTick()
tx=GN(4) ty=GN(5) tc=GB(2)
T.insert(curb,(GN(6)+0.5)%1-0.5)
if #curb>6 then T.remove(curb,1) end
cur=(GN(6)+0.5)%1-0.5
sp={GN(7),GN(8),GN(9)} Eu={GN(10),GN(11),GN(12)}
SN(1,0)
SN(2,0)
if GN(1)>25 then
	Tg=R2G({GN(1),GN(2),GN(3)})
	T.insert(R,{Tg,0})
	SN(1,Tg[1])
	SN(2,Tg[2])
end
if #R>0 then
	for i=1,#R do
		R[i][2]=R[i][2]+1
	end
end
if #R>1 then
	for i=1,#R do
		if R[i][2]>maxlife then T.remove(R,i) break end
	end
end
--zoom btns
zi=PB(0,0,w,0.5*h-1)
zo=PB(0,0.5*h+1,w,0.5*h)
if zi and not tcd then z=M.min(z*2,4) end
if zo and not tcd then z=M.max(z*0.5,0.25) end
tcd=tc
end
function onDraw()
w,h=S.getWidth(),S.getHeight()
SC(3,3,3) S.drawClear()
--good circle
SC(5,15,5)
DT(w-15,1,'RDR')
DT(w/2+2,3,Mf(Mf(dftz/z/1000)))
DT(w/2+2,h/2-5,Mf(Mf(dftz/z/2000)))
DT(w/2+2,0.75*h-5,Mf(Mf(dftz/z/4000)))
for i=-2,2 do
dcx1=w/2+(h-1)*Ms(P2*i*45/360)
dcy1=h/2-(h-1)*Mc(P2*i*45/360)
L(w/2,h,dcx1,dcy1)
end
SC(10,30,10)
DCp(w/2,h,(h-1),-45,45)
DCp(w/2,h,(0.75*h-1),-90,90)
DCp(w/2,h,(h/2-1),-90,90)
DCp(w/2,h,(h/4-1),-90,90)
--search line
for i=1,#curb do
dslx=w/2+(h-1)*Ms(P2*curb[i])
dsly=h/2-(h-1)*Mc(P2*curb[i])
SC(11,111,11,i*10)
L(w/2,h,dslx,dsly)
end
curo=cur
--draw target
if #R>0 then
	for i=1,#R do
		Rd,Ra,Re=L2DAE(G2L(R[i][1]))
		dtx=w/2+h*Ms(Ra)*(Rd/dftz*z)
		dty=h-h*Mc(Ra)*(Rd/dftz*z)
		alf=228*(1-R[i][2]/maxlife)
		if Re<0.02 then SC(111,222,22,alf) elseif Re>-0.02 then SC(22,222,111,alf) else SC(22,222,22,alf) end
		DCF(dtx,dty,1.4)
	end
end
DB(w-6,h/4-5,5,7,"+",zi)
DB(w-6,0.75*h-5,5,7,"-",zo)
end