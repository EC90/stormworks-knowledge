-- source: steam id 3794618673 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794618673

MinRange=10
MargeDist=10
MargeDistCoef=0.025
MaxTGT=32
HoldTick=180
iB=input.getBool
iN=input.getNumber
oB=output.setBool
oN=output.setNumber
m=math
pi=m.pi
pi2=2*pi
s=m.sin
c=m.cos
t=m.tan
as=m.asin
ac=m.acos
at=m.atan
sc=screen
dT=sc.drawText
dL=sc.drawLine
dC=sc.drawCircle
fo=string.format
tb=table
tI=tb.insert
tR=tb.remove
pN=property.getNumber
pD={pN("GPS X horizontal offset (m)"
),pN("GPS Y directional offset (m)"
),pN("Altimeter vertical offset (m)"
)}
delay=pN("Process Delay (tick)"
)
Marge=property.getBool("Marge close targets"
)
DAD=pN("Installation Posture"
)
tSm=pN("Smoothing tick"
)
MaxHist=tSm+1
RMode=pN("Radar Mode"
)
if RMode==0 then
isSR,isTR=true,false 
elseif RMode==1 then
isSR,isTR=true,true 
elseif RMode==2 then
isSR,isTR=false,true 
end
if DAD>0 then
if DAD==2 then
fy=pi/2 
elseif DAD==3 then
fy=pi
elseif DAD==4 then
fy=-pi/2 else fy=0
end
rx={c(fy),0,-s(fy)}
ry={0,1,0}
rz={s(fy),0,c(fy)}
else fx=pi/2
if DAD==-2 then
fz=pi/2 
elseif DAD==-3 then
fz=0
elseif DAD==-4 then
fz=-pi/2 else fz=pi
end
rx={c(fz),s(fz),0}
ry={-s(fz)*c(fx),c(fz)*c(fx),s(fx)}
rz={s(fz)*s(fx),-c(fz)*s(fx),c(fx)}
end
rs={rx,ry,rz}
function distV(j,k)
_=0
for i=1,3 do
_=_+(j[i]-k[i])^2 
end
_=_^0.5
return _ 
end

function outPro(l,n)
w={}w[1]=l[2]*n[3]-l[3]*n[2]w[2]=l[3]*n[1]-l[1]*n[3]w[3]=l[1]*n[2]-l[2]*n[1]return w 
end

function AngleToBasis(o)
ex={c(o[1])*s(-o[2]),c(o[1])*c(-o[2]),s(o[1])}
ey={c(o[3])*s(-o[4]),c(o[3])*c(-o[4]),s(o[3])}
ez=outPro(ex,ey)return{ex,ey,ez}
end

function Mv(p,n)
V={}
for i=1,3 do
_=0
for q=1,3 do
_=_+p[q][i]*n[q]end
V[i]=_ 
end
return V 
end

function inv(r,u,v)a,b,C,d,e,f,g,h,i=r[1],u[1],v[1],r[2],u[2],v[2],r[3],u[3],v[3]det=a*e*i+d*h*C+g*b*f-g*e*C-a*h*f-d*b*i
E1={(e*i-f*h)/det,(f*g-d*i)/det,(d*h-e*g)/det}
E2={(C*h-b*i)/det,(a*i-C*g)/det,(b*g-a*h)/det}
E3={(b*f-C*e)/det,(C*d-a*f)/det,(a*e-b*d)/det}
return E1,E2,E3,det 
end

function PolToOrth(x)
VO={}VO[1]=x[1]*c(x[3])*s(x[2])VO[2]=x[1]*c(x[3])*c(x[2])VO[3]=x[1]*s(x[3])
return VO 
end
cID=1
function RegisterTGT(y)
tI(TGT,{y,ID=cID,S=y})if#TGT>MaxTGT then
tR(TGT,1)
end
cID=cID+1 
end
PTG={}
TGT={}
function onTick()
oB(30,isSR)
oB(31,isTR)
oB(32,true)
PO={iN(4),iN(8),iN(12)}
QO={iN(16)*pi2,iN(20)*pi2,iN(24)*pi2,iN(28)*pi2}
es=AngleToBasis(QO)
cb=iN(32)*pi2
for i=1,8 do
det=iB(i)dist,azim,elev=iN(i*4-3),iN(i*4-2)*pi2,iN(i*4-1)*pi2
if det and dist>MinRange then
PTP={dist,azim,elev}
PTL=PolToOrth(PTP)
for q=1,3 do
PTL[q]=PTL[q]+pD[q]end
PTL=Mv(rs,PTL)PTG[i]=Mv(es,PTL)
for q=1,3 do
PTG[i][q]=PTG[i][q]+PO[q]end
PTG[i][4]=delay
PTG[i][5]=true
PTG[i].d=dist
else PTG[i]={0,0,0,-1,false,-1}
end
end
if Marge then
for i=8,2,-1 do
for z=i-1,1,-1 do
if PTG[i][5]and PTG[z][5]and distV(PTG[i],PTG[z])<m.max(MargeDist,PTG[i].d*MargeDistCoef)then
for q=1,3 do
PTG[z][q]=(PTG[z][q]+PTG[i][q])/2 
end
PTG[i]={0,0,0,-1,false,-1}
break 
end
end
end
end
for i=1,8 do
if PTG[i][5]then
if#TGT>0 then
for z=1,#TGT do
distk=distV(PTG[i],TGT[z][1])
if z==1 or distk<dist then
dist=distk
km=z
end
end
if dist<m.max(MargeDist,PTG[i].d*MargeDistCoef)then
tI(TGT[km],1,PTG[i])if#TGT[km]>MaxHist then
tR(TGT[km])
end
for q=1,3 do
cmin=TGT[km][1][q]cmax=cmin
for A=1,#TGT[km]do
cl=TGT[km][A][q]if cl<cmin then
cmin=cl
elseif cl>cmax then
cmax=cl
end
end
TGT[km].S[q]=(cmin+cmax)/2 
end
TGT[km].S[4]=PTG[i][4]PTG[i][6]=TGT[km].ID else PTG[i][6]=cID
RegisterTGT(PTG[i])
end
else PTG[i][6]=cID
RegisterTGT(PTG[i])
end
end
end
if#TGT>0 then
for z=#TGT,1,-1 do
if TGT[z].S[4]>HoldTick then
tR(TGT,z)
end
end
end
OUT={}
for i=1,8 do
if PTG[i][5]then
ki=-1
for z=1,#TGT do
if PTG[i][6]==TGT[z].ID then
ki=z
break 
end
end
OUT[i]={}
for q=1,4 do
OUT[i][q]=TGT[ki].S[q]end
OUT[i][5]=true
OUT[i][6]=#TGT[ki]else OUT[i]={0,0,0,-1,false,-1}
end
for q=1,4 do
oN(i*4-(4-q),OUT[i][q])
end
oB(i,OUT[i][5])
end
if#TGT>0 then
for z=1,#TGT do
TGT[z].S[4]=TGT[z].S[4]+1 
end
end
end

function onDraw()
dT(0,0,"OUTPUT DATA"
)
dT(0,7,"  ----X "
.."----Y "
.."----Z "
)
for i=1,8 do
dT(0,7+i*7,i)
for q=1,3 do
dT(5+(q-1)*30,7+i*7,fo("%6.0f"
,OUT[i][q]))
end
dT(100,7+i*7,OUT[i][6])
end
end