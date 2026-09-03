-- source: steam id 3097129660 / vehicle.xml block#17
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.atan
Mas=M.asin
Mb=M.abs
Mc=M.cos
Mf=M.floor
Ms=M.sin
Mr=M.sqrt
pi2=M.pi*2
pi=M.pi
t1={} t2={} t3={}
t4={} t5={} t6={}
PitI,RolI,YawI=0,0,0
dPo,dRo,dYo=0,0,0
function Mp(value,vmin,vmax)
return math.max(math.min(vmax,value),vmin) end
function Av(n,v,t)
table.insert(n,v) local s=0 if #n>t then for i=1,#n-t do table.remove(n,1) end end for i=1,#n do s=s+n[i] end return s/#n end
function E2R(E)
qx,qy,qz=E[1],E[2],E[3] return {{Mc(qy)*Mc(qz),Mc(qx)*Mc(qy)*Ms(qz)+Ms(qx)*Ms(qy),Ms(qx)*Mc(qy)*Ms(qz)-Mc(qx)*Ms(qy)},{-Ms(qz),Mc(qx)*Mc(qz),Ms(qx)*Mc(qz)},{Ms(qy)*Mc(qz),Mc(qx)*Ms(qy)*Ms(qz)-Ms(qx)*Mc(qy),Ms(qx)*Ms(qy)*Ms(qz)+Mc(qx)*Mc(qy)}} end
function tM(M)
N={{},{},{}} for i=1,3 do for j=1,3 do N[i][j]=M[j][i] end end return N end
function Mv(M,v)
u={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end u[i]=_ end return u end
function inPro(u,v)
_=0 for i=1,3 do _=_+u[i]*v[i] end return _ end
function CD(c,t)
c,t=c%1,t%1
if (c-t)>0.5 then t=t+1
elseif (c-t)<-0.5 then t=t-1
end
return (c-t) end
Is={}
Ds={}
Dss={}
function pid(id,v,s,p,i,d,plmt,ilmt)
	if not Is[id] then Is[id]=0 Ds[id]=0 Dss[id]={} end
	Is[id]=Mp(Is[id]+i*(s-v),-ilmt,ilmt)
	local rst=Mp(p*(s-v),-plmt,plmt)+Is[id]+d*(s-v-Av(Dss[id],Ds[id],3))
	Ds[id]=s-v
	return rst end
G0=9.80665
Rair0=1.225
Ralto=0
aftb=false
vnext=0
thr=0
power=PN('thrust power')
vmax=PN('Max Speed')/3.6
altmax=PN('Max Altitude')
KeepAo=false
function onTick()
Gear=not GB(1) LandAs=GB(2) AirB=GB(3) AftB=GB(4)
AimA=GB(5) KeepA=GB(6) Bat=GB(9) Eng=GB(10)
alt=GN(2)
Ralt=GN(25)
Eu={GN(4),GN(6),GN(5)}
p=GN(15) r=GN(16) c=GN(17)
if AirB then Kab=1.6 else Kab=1 end
mass=PN('Weight')+GN(26)*0.8+GN(29)
Rair=Rair0*(1-0.0065*alt/288.15)^(G0/(287.058*0.0065)-1)
Kpa=Rair/Rair0
--flycon
as=Mv(E2R(Eu),{GN(10),GN(12),GN(11)})
asx,asz,asy=Av(t1,as[1],4),Av(t2,as[2],4),Av(t3,as[3],4)
vx,vy,vz=GN(7),GN(8),GN(9)
ad,ws,lr=GN(21),GN(22),GN(23)
Kv=440*Mp(vz,50,300)^(-1.4)
Ki=Mp(vz/40,0,1)
if KeepA then
if not KeepAo then altT=alt dirT=c
else altT=altT-ws*0.5 dirT=(dirT-lr*0.001+0.5)%1-0.5 end
pO=-pid(5,p,Mp((altT-alt)/50,-1,1)*0.03,5,0.01,10,0.3,0.1)
yO=-pid(6,CD(c,dirT),0,20,0.01,25,0.5,0.1)
rO=r*4+ad
elseif AimA and GN(27)~=0 and GN(28)~=0 then
pO=pid(7,GN(28),0,10,0.2,7,0.3,0.1)+ws
yO=-pid(8,GN(27),0,33,0.5,22,0.5,0.15)+lr
rO=r*4+ad+yO*0.6
else pO=ws+p*Mp((alt-3500)/500,0,1) yO=lr rO=ad end
KeepAo=KeepA
dbg=GN(30)
Kpar=Rair0/Rair
Pit=pid(1,asx,pO*0.1*Kab,5*Kv,0.15*Kv*Ki,4*Kv,0.6,0.2)*Kpar+pO*0.3*Kv
Yaw=pid(2,asy,yO*0.075*Kab,4*Kv,0.04*Kv*Ki,3*Kv,0.4,0.2)*Kpar+yO*0.3*Kv
Rol=pid(3,-asz,rO*0.2*Kab,3*Kv,0.03*Kv*Ki,2*Kv,1,0.2)*Kpar+rO*1*Kv
if not(Bat and Eng) then Pit,Rol,Yaw=0,0,0 end 
SN(1,Pit)
SN(2,Rol)
SN(3,Yaw)
SN(4,Pit+Rol)
SN(5,Pit-Rol)
--power sim
thr=GN(24)
b=tM(E2R(Eu))
if AftB and thr>0.9 then Kaftb=1 else Kaftb=0.7 end
mach=340.3-0.00293*alt
Kdrag=mass*G0/(Rair0*vmax^2*1)
if Gear then Kgr=1.2 else Kgr=1 end
aoaH=Ma(0.33*vx,vz)
aoaV=Ma(vy,vz)
Az=1+PN('AOA Multiplier')*Mb(Ms(aoaH))*0.2+PN('AOA Multiplier')*Mb(Ms(aoaV))
drag=Kgr*Kab*Rair*M.max(vz,0)^2*Kdrag*Az/G0*(0.5+0.5*Mp(((vz/mach)-0.9)/0.1,0,1))
Kpv=1+0.11*Ms(-pi*vz/vmax)
Gadd=Ms(-p*pi2)*Mp(vz/30,0,1)*mass
force=power*thr*Kpa*Kpv*Kaftb
if thr==0 and Ralt<5 and vz<60 then brake=Mp(vz/3,0,0.3) else brake=0 end
acc=Av(t5,(force-drag+Gadd)*G0/mass+brake,64)
vnext=Mp(vnext+acc/60,0,vmax)
if LandAs then if Ralt>3 then vnext=(Mp(Ralt/50,0,1)*50+200)/3.6 else vnext=0 end end
if Ralt<5 and thr<0.3 then vnext=thr*100/3.6 end
if Bat and Eng then ThrMin=0.02 else ThrMin=0 end
ThrMax=0.4
Thr=Av(t6,Mp(pid(4,vz,vnext,0.02,0.001,0.04,1,0.2),ThrMin,ThrMax),4)
if not Eng then vnext=0 end
if vnext-vz>30 and Thr==ThrMax then vnext=vz end
SN(11,Thr)
SN(12,acc)
SN(13,force)
SN(14,drag)
SN(15,p)
SN(16,r)
SN(17,c)
Ralto=Ralt
if vnext==0 and vz<5 then
brkL,brkR=1,1
else
brkL=(Mp((vz-vnext)/60,0,1)-Yaw)*0.5
brkR=(Mp((vz-vnext)/60,0,1)+Yaw)*0.5
end
SN(21,brkL)
SN(22,brkR)
if Bat and Eng and (AirB or (vz-vnext)>20) then SN(23,0.4) else SN(23,0) end
end