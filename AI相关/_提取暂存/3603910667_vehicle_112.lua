-- source: steam id 3603910667 / vehicle.xml block#112
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
--Pyo's heli gyro AP
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
inatialized=false
function Mp(value,vmin,vmax)
return math.max(math.min(vmax,value),vmin) end
function Av(n,v,t) if n==nil then n={0} end t=M.max(Mf(t),1) table.insert(n,v) local s=0 if #n>t then for i=1,#n-t do table.remove(n,1) end end for i=1,#n do s=s+n[i] end return s/#n end
function E2R(E)
qx,qy,qz=E[1],E[2],E[3] return {{Mc(qy)*Mc(qz),Mc(qx)*Mc(qy)*Ms(qz)+Ms(qx)*Ms(qy),Ms(qx)*Mc(qy)*Ms(qz)-Mc(qx)*Ms(qy)},{-Ms(qz),Mc(qx)*Mc(qz),Ms(qx)*Mc(qz)},{Ms(qy)*Mc(qz),Mc(qx)*Ms(qy)*Ms(qz)-Ms(qx)*Mc(qy),Ms(qx)*Ms(qy)*Ms(qz)+Mc(qx)*Mc(qy)}} end
function tM(M)
N={{},{},{}} for i=1,3 do for j=1,3 do N[i][j]=M[j][i] end end return N end
function Mv(M,v)
u={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end u[i]=_ end return u end
function G2L(g)
	return Mv(E2R(Eu),{g[1],g[2],g[3]})
end
function L2AE(l)
	return Ma(l[1],l[2]),Ma(l[3],l[2])
end
function inPro(u,v)
_=0 for i=1,3 do _=_+u[i]*v[i] end return _ end
function G2CpsPit(g) 
	return -Ma(g[1],g[2])/pi2,Ma(g[3],Mr(g[1]^2+g[2]^2))/pi2
end
function CD(c,t)
	c,t=c%1,t%1
	if (c-t)>0.5 then t=t+1
	elseif (c-t)<-0.5 then t=t-1
	end
	return (c-t)
end
function Md(a,b)
	return Mr((a[1]-b[1])^2+(a[2]-b[2])^2+(a[3]-b[3])^2)
end
Is={}
Ds={}
Dss={}
function pid(id,v,s,p,i,d,plmt,ilmt,dlmt)
	if not Is[id] then Is[id]=0 Ds[id]=0 Dss[id]={} end
	Is[id]=Mp(Is[id]+i*(s-v),-ilmt,ilmt)
	local rst=Mp(p*(s-v),-plmt,plmt)+Is[id]+Mp(d*(s-v-Ds[id]),-dlmt,dlmt)
	Ds[id]=s-v
	return rst
end
alt=0
APspdz=0
APspdx=0
APalt=0
APdir=0
APx=0
APy=0
distx=0
distz=0
yawDelta=0
--count after intialize
cnti=0
--cv
cvx,cvy,cvz=0,0,0
cnt=0
cvvx=0
cvvy=0
cvfns=false
--atk cnt
atk=false
cntatk=0
atkx,atky,atkz=0,0,0
ammo=PN('ammo')
--cnt autosrc
cntas=0
--cnt ap wait yaw
cntwy=0
mode=0
modeo=0
APtgtx=0
--for av
t1={}
t2={}
function onTick()
	rps=GN(24)
	--rc
	ad=GN(10)
	ws=GN(11)
	trigger=GN(25)>0.5
	altp=Mf(GN(27))
	altm=-Mf(GN(26))
	--uav
	rtb=GN(28)>0.5
	cv=GN(29)>0.5
	if GN(21)~=cvx then
		if cvx~=0 then
			cvvx=Mp(60*(GN(21)-cvx)/cnt,-20,20)
			cvvy=Mp(60*(GN(22)-cvy)/cnt,-20,20)
		else
			cvvx=0
			cvvy=0
		end
		cvx,cvy,cvz=GN(21),GN(22),GN(23)
		cnt=0
	else
		cnt=cnt+1
	end
	--atk
	if GN(14)>0.5 and atkx~=0 and ammo>0 then
		atk=true
	end
	if GN(18)~=0 then
		atkx,atky,atkz=GN(18),GN(19),GN(20)
	end
	--basic
	dalt=(GN(2)-alt)*60
	alt=GN(2)
	mapx,mapy=GN(1),GN(3)
	Eu={GN(4),GN(6),GN(5)}
	p=GN(15)
	r=GN(16)
	c=GN(17)
	--speed values
	vx,vy,vz=GN(7),GN(8),GN(9)
	--
	if Mb(GN(30)-APtgtx)>50 then
		cntwy=0
	end
	APtgtx=GN(30)
	APtgty=GN(31)
	APtgtalt=GN(32)
	if atk then
		mode=2
		APx=atkx
		APy=atky
	elseif APtgtx~=0 then
		mode=1
		APx=APtgtx
		APy=APtgty
		APalt=APtgtalt
	elseif rtb then
		mode=0
		APx=0
		APy=0
		APalt=M.max(APalt-0.05,1)
	elseif cv then
		mode=3
		APx=cvx+cnt*cvvx/60
		APy=cvy+cnt*cvvy/60
	else
		mode=0
		APx=0
		APy=0
		if inatialized and property.getBool('scan when idle') then
			cntas=cntas+1
		end
	end
	if mode~=modeo then
		cntwy=0
	end
	if APx~=0 and cnti<1 and Mb(APalt-alt)<10 then
		cntas=0
		aptgtcps,_2=G2CpsPit({APx-mapx,APy-mapy,0})
		aptgtdst=Md({mapx,mapy,0},{APx,APy,0})
		if aptgtdst>25 then
			APdir=aptgtcps
		end
		dirdlt=CD(c,aptgtcps)
		distx=Ms(dirdlt*pi2)*aptgtdst
		distz=Mc(dirdlt*pi2)*aptgtdst
		--cv speed add
		if cv and APtgtx==0 then
			cvvdir,_5=G2CpsPit({cvvx,cvvy,0})
			cvvabs=Md({cvvx,cvvy,0},{0,0,0})
			cvvdirdlt=CD(c,cvvdir)
			addspdx=Av(t1,Ms(cvvdirdlt*pi2)*cvvabs,8)
			addspdz=Av(t2,Mc(cvvdirdlt*pi2)*cvvabs,8)
			if aptgtdst>20 then cvfns=false end
			if aptgtdst>1 and not cvfns then
				APalt=cvz+3+Mp(aptgtdst*0.2,0,20)
			else
				cvfns=true
				APalt=APalt-0.03
			end
		else
			addspdx,addspdz=0,0
		end
		APspdx=Mp(Mp(distx/200,-1,1)*12+Mp(distx/10,-1,1)*1+Mp(distx/50,-1,1)*2+addspdx,-20,20)*(1-Mp(Mb(aptgtdst),0,250)/250)
		APspdz=Mp(Mp(distz/300,-1,1)*25+Mp(distz/10,-1,1)*1+Mp(distz/50,-1,1)*4+addspdz,-30,30)
	else
		APspdz=ws*5
		APspdx=0
		APdir=APdir-ad*0.001
		APalt=APalt+altp*0.04+altm*0.04
	end
	if Mb(CD(c,APdir))<0.01 then
		cntwy=cntwy+1
	end
	if cntwy<60 then
		APspdx=0
		APspdz=0
	end
	--pit
	pitT=Mp(pid(7,APspdz,vz,0.1,0.0005,0.4,0.5,0.3,0.3),-1,1)*0.08
	--rol
	rolT=Mp(pid(8,APspdx,vx,0.1,0.0005,0.4,0.5,0.3,0.3),-1,1)*0.06
	--atk ovrd
	SB(1,false or trigger)
	if atk then
		SN(27,atkx)
		SN(28,atky)
		SN(29,atkz)
		if aptgtdst<PN('atk range')*0.9 then
			APdir,pitT=G2CpsPit({atkx-mapx,atky-mapy,atkz-alt})
			if property.getBool('aim pit') then
				pitT=pitT+PN('aim offset vertical')
			else
				pitT=0
			end
			rolT=0
			if Mb(CD(c,APdir))<PN('aim ready threshold') and Mb(p-pitT)<PN('aim ready threshold') then
				cntatk=cntatk+1
			end
			if cntatk>60 then
				SB(1,true)
				cntatk=0
				atk=false
				ammo=ammo-1
			end
		end
	end
	--yaw
	if cntas>600 then
		yawDelta=0.01
	else
		yawDelta=CD(c,APdir)
	end
	--pid
	if rps>8 then
		if not inatialized then
			APdir=c
			APx=mapx
			APy=mapy
			APalt=alt
			cnti=500
			inatialized=true
		end
		Pit=-pid(1, p,pitT,PN('PitP'),PN('PitI'),PN('PitD'),PN('PitPM'),PN('PitIM'),0.4)
		Rol=-pid(3,r,rolT,PN('RolP'),PN('RolI'),PN('RolD'),PN('RolPM'),PN('RolIM'),0.4)
		Yaw=-pid(2,yawDelta,0,PN('YawP'),PN('YawI'),PN('YawD'),PN('YawPM'),PN('YawIM'),0.4)
		cO=Mp(APalt-alt,-10,10)
		Col=0.2+Mp(pid(4,dalt,cO,PN('ColP'),PN('ColI'),PN('ColD'),PN('ColPM'),PN('ColIM'),0.5),-0.7,0.7)
	else
		Pit,Rol,Yaw,Col=0,0,0,0
	end
	if rps<5 then
		inatialized=false
		ammo=PN('ammo')
	end
	krps=Mp((rps-5)/5,0,1)
	SN(1,Pit*krps)
	SN(2,Rol*krps)
	SN(4,(Col+Yaw)*krps)
	SN(5,(Col-Yaw)*krps)
	if cnti>0 then cnti=cnti-1 APalt=APalt+0.05 end
	modeo=mode
end
addspdx=0
addspdz=0
APspdx=0
APspdz=0
pitT=0
rolT=0
function onDraw()
	screen.setColor(0,0,0)
	screen.drawClear()
	screen.setColor(255,255,255)
	screen.drawText(1,1,'cvvx'..string.format('%+2.2f',addspdx))
	screen.drawText(1,7,'cvvz'..string.format('%+2.2f',addspdz))
	screen.drawText(1,13,'pitt'..string.format('%+0.3f',pitT))
	screen.drawText(1,19,'rolt'..string.format('%+0.3f',rolT))
	screen.drawText(1,25,'spdx'..string.format('%+2.2f',APspdx))
	screen.drawText(1,31,'spdz'..string.format('%+2.2f',APspdz))
end