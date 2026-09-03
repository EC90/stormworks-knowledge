-- source: steam id 3358095813 / vehicle.xml block#40
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3358095813
GB=input.getBool
GN=input.getNumber
PN=property.getNumber
SN=output.setNumber
SB=output.setBool
M=math
Ma=M.atan
Mb=M.abs
Mc=M.cos
Mf=M.floor
Ms=M.sin
Mr=M.sqrt
P=M.pi*2
T=table
TS=T.insert
function Mp(a,b,c)
return M.max(M.min(c,a),b)
end

function E2R(_)
local d,e,f=_[1],_[2],_[3]return{{Mc(e)*Mc(f),Mc(d)*Mc(e)*Ms(f)+Ms(d)*Ms(e),Ms(d)*Mc(e)*Ms(f)-Mc(d)*Ms(e)},{-Ms(f),Mc(d)*Mc(f),Ms(d)*Mc(f)},{Ms(e)*Mc(f),Mc(d)*Ms(e)*Ms(f)-Ms(d)*Mc(e),Ms(d)*Ms(e)*Ms(f)+Mc(d)*Mc(e)}}
end

function tM(M)
local g={{},{},{}}
for b=1,3 do
for h=1,3 do
g[b][h]=M[h][b]end
end
return g 
end

function Mv(M,a)
local g={}
for b=1,3 do
_=0
for h=1,3 do
_=_+M[h][b]*a[h]end
g[b]=_ 
end
return g 
end

function G2L(_)
return Mv(E2R(Eu),{_[1],_[2],_[3]})
end

function L2AE(i)
return Ma(i[1],i[2]),Ma(i[3],i[2])
end

function G2CP(_)
return Ma(_[1],_[2])/P,Ma(_[3],Mr(_[1]^2+_[2]^2))/P 
end

function CD(j,g)j,g=j%1,g%1
if j-g>0.5 then
g=g+1 
elseif j-g<-0.5 then
g=g-1 
end
return j-g 
end
Is={}
Ds={}
Dss={}
function pid(k,a,l,m,b,n,o,p)
if not Is[k]then
Is[k]=0
Ds[k]=0
Dss[k]={}
end
Is[k]=Mp(Is[k]+b*(l-a),-p,p)
local q=Mp(m*(l-a),-o,o)+Is[k]+n*(l-a-Ds[k])Ds[k]=l-a
return q 
end

function dst(c,r)
return Mr((c[1]-r[1])^2+(c[2]-r[2])^2+(c[3]-r[3])^2)
end

function Av(s,a,g)
g=M.max(Mf(g),1)
TS(s,a)
local l=0
if#s>g then
for b=1,#s-g do
table.remove(s,1)
break 
end
end
for b=1,#s do
l=l+s[b]end
return l/#s 
end
tgtg={0,0,0}
tgto={0,0,0}
tgtgv={0,0,0}
aim={0,0,0}
life=0
tgtd=0
eta=0
temp={}
vzo=0
launch=0
vzmax=0
zstart=0
etao=0
tgtdo=0
function onTick()
Sp={GN(1),GN(3),GN(2)}
Eu={GN(4),GN(6),GN(5)}vx,vy,vz=GN(7),GN(8),GN(9)
tgt={GN(11),GN(12),GN(13)}
tgtv={GN(14),GN(15),GN(16)}
if launch==0 then
zstart=GN(2)
end
if GN(17)==0 then
launch=launch+1 
end
Ksd=Mp(launch/PN('Start Delay'),0,1)
if tgt[1]~=0 then
if life>0 then
if tgtv[1]==0 and dst(tgto,tgt)/life<8 and life<600 then
tgtgv={(tgt[1]-tgto[1])/life,(tgt[2]-tgto[2])/life,(tgt[3]-tgto[3])/life}
else tgtgv={0,0,0}
end
else 
if tgtv[1]~=0 then
tgtgv=tgtv
else tgtgv={tgt[1]-tgto[1],tgt[2]-tgto[2],tgt[3]-tgto[3]}
end
end
life=0
tgtg=tgt
tgto=tgt
else life=life+1
if life<PN('lifespan')then
tgtg={tgto[1]+tgtgv[1]*life,tgto[2]+tgtgv[2]*life,tgto[3]+tgtgv[3]*life}
else tgto={0,0,0}
tgtg={0,0,0}
tgtgv={0,0,0}
end
end
if tgtg[1]~=0 then
if tgtg[3]<PN('path active alt')+zstart then
zofst=Mp((tgtd-PN('path active dist'))/PN('path active dist'),0,1)*PN('path height')else zofst=0
end
aim={tgtg[1]+eta*tgtgv[1],tgtg[2]+eta*tgtgv[2],tgtg[3]+eta*tgtgv[3]+zofst}
if tgtd~=0 then
tgtdd=Av(temp,Mp(dst(tgtg,Sp)-tgtd,-3*vz,3*vz),4)else tgtdd=-1 
end
tgtd=dst(tgtg,Sp)
eta=Mp(-tgtd/tgtdd+PN('Lead offset'),0,PN('Max Lead'))taa,tea=L2AE(G2L({aim[1]-Sp[1],aim[2]-Sp[2],aim[3]-Sp[3]}))
Kv=Mp(vz/60,0,1)
if vz>30 then
ta,te=taa-Ma(vx,vz)*Kv,tea-Ma(vy,vz)*Kv else ta,te=taa,tea 
end
Knear=1+PN('K end')*Mp(100-tgtd,0,1)
K=Ksd*Kv*Knear
if tgtd<PN('PN active distance')then
ao=pid(3,GN(18),0,PN('K pn'),0.06*PN('K pn'),0,1,0.3)
eo=-pid(4,GN(19),0,PN('K pn'),0.06*PN('K pn'),0,1,0.3)
elseif tgtd<PN('radar fin active distance')and GN(20)~=0 and-tgtdd*60>vz*PN('radar fin active velocity')then
ao=GN(20)*PN('K radar fin')
eo=GN(21)*PN('K radar fin')else ao=-pid(1,ta,0,PN('P')*K,PN('I')*K,PN('D')*K,PN('P max'),PN('I max')*K)
eo=-pid(2,te,0,PN('P')*K,PN('I')*K,PN('D')*K,PN('P max'),PN('I max')*K)
end
SN(21,tgtd)
SN(22,tgtdd)
SN(23,eta)
fseta=-tgtd/tgtdd<PN('VT Fuse tick')and tgtdo>0 and tgtdo<50
fsmiss=eta>etao and tgtdd>1 and tgtdo<50 and tgtdo>0 and tgtd<50 and etao<10
vtfuse=fseta
or fsmiss else aim={0,0,0}
eta=PN('Max Lead')
tgtd=0
ao=0
eo=0
end
etao=eta
tgtdo=tgtd
if vz-vzo<-PN('impact speed gate')and vzo>30 then
impactfuse=true
else impactfuse=false
end
vzmax=M.max(vzmax,vz)
vzo=vz
SB(1,launch>PN('Start Delay')
and(vtfuse or impactfuse)and GN(22)>0)
SN(1,ao)
SN(2,eo*PN('Y mtpl'))
SN(11,aim[1])
SN(12,aim[2])
SN(13,aim[3])
SN(14,tgtgv[1])
SN(15,tgtgv[2])
SN(16,tgtgv[3])
SN(17,vzmax)end