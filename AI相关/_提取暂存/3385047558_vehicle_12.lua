-- source: steam id 3385047558 / vehicle.xml block#12
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3385047558
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
usage=PN('Usage')
function Mp(value,vmin,vmax)
return math.max(math.min(vmax,value),vmin) end
function E2R(E)
qx,qy,qz=E[1],E[2],E[3] return {{Mc(qy)*Mc(qz),Mc(qx)*Mc(qy)*Ms(qz)+Ms(qx)*Ms(qy),Ms(qx)*Mc(qy)*Ms(qz)-Mc(qx)*Ms(qy)},{-Ms(qz),Mc(qx)*Mc(qz),Ms(qx)*Mc(qz)},{Ms(qy)*Mc(qz),Mc(qx)*Ms(qy)*Ms(qz)-Ms(qx)*Mc(qy),Ms(qx)*Ms(qy)*Ms(qz)+Mc(qx)*Mc(qy)}} end
function tM(M)
N={{},{},{}} for i=1,3 do for j=1,3 do N[i][j]=M[j][i] end end return N end
function Mv(M,v)
u={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end u[i]=_ end return u end
function inPro(u,v)
_=0 for i=1,3 do _=_+u[i]*v[i] end return _ end
function G2CpsPit(g)
	return Ma(g[1],g[2])/pi2,Ma(g[3],Mr(g[1]^2+g[2]^2))/pi2
end
function CD(c,t)
	c,t=c%1,t%1
	if (c-t)>0.5 then t=t+1
	elseif (c-t)<-0.5 then t=t-1
	end
	return (c-t)
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
cO=0
vym=PN('Max Y Speed')
--ap parameters
AutoPilot=false
APGPS=false
APsl=1
--spd alt dir
APtgts={
	{false,0,10},
	{false,0,5},
	{false,0,5}
}
APtgtx=0
APtgty=0
touchX,touchY=0,0
touch=false
eapo=0
function onTick()
	--extra 'ap' key
	eap=GN(30)>0.5 and eapo==0
	eapo=GN(30)
	--edit delt ap alt
	_=APtgts[2][2]
	if _<30 then
		APtgts[2][3]=1
	elseif _<60 then
		APtgts[2][3]=2
	elseif _<120 then
		APtgts[2][3]=5
	else
		APtgts[2][3]=10
	end
	--basic
	dalt=(GN(2)-alt)*60
	mapx,mapy=GN(1),GN(3)
	alt=GN(2)
	Eu={GN(4),GN(6),GN(5)}
	p=GN(15) r=GN(16) c=GN(17)
	--speed values
	as=Mv(E2R(Eu),{GN(10),GN(12),GN(11)})
	asx,asz,asy=as[1],as[2],as[3]
	vx,vy,vz=GN(7),GN(8),GN(9)
	--touch
	if c<0 then c360=-c*360 else c360=360-c*360 end
	APcur={Mf(vz+0.5),Mf(alt+0.5),(Mf(c360/5+0.5)*5)%360}
	touched=GN(27)>0.5 and not touch
	touch=GN(27)>0.5
	touchX,touchY=GN(25),GN(26)
	if touched or eap then
		if touchY<6 then
			if touchX<16 or eap then
				AutoPilot=not AutoPilot
				if AutoPilot then
					for i=1,3 do
						APtgts[i][2]=APcur[i]
					end
					if usage>2 then
						APtgts[1][1]=true
						APtgts[2][1]=true
					end
				end
			else
				APGPS=not APGPS
				if APGPS then
					APtgts[2][2]=alt
				end
			end
		elseif touchY>24 then
			if touchX<10 then
				APtgts[APsl][2]=APtgts[APsl][2]-APtgts[APsl][3]
				if APsl==3 then
					if APtgts[APsl][2]<0 then
						APtgts[APsl][2]=APtgts[APsl][2]+360
					end
				end
			elseif touchX>20 then
				APtgts[APsl][2]=APtgts[APsl][2]+APtgts[APsl][3]
			else
				APtgts[APsl][2]=APcur[APsl]
			end
		else
			APslN=Mp(Mf((touchY-1)/6),1,3)
			if APslN==APsl then
				APtgts[APsl][1]=not APtgts[APsl][1]
			else
				APsl=APslN
			end
		end 
	end
	--key binding
	ad,ws,lr,ud=GN(PN('Roll Key')),GN(PN('Pitch Key')),GN(PN('Yaw Key')),GN(PN('Collective Key'))
	pO,yO,rO=ws,lr,ad
	--
	APx=GN(31)
	APy=GN(32)
	--main
	if AutoPilot then
		if APGPS then
			if APx~=0 then
				if usage<3 then
					APdist=Mr((APx-mapx)^2+(APy-mapy)^2)
					APtgts[1][2]=Mp(APdist/PN('AP Brake Final Dist'),0,1)*PN('AP Default Speed')*Mp(APdist/PN('AP Brake Start Dist'),0.5,1)*3.6
				else
					APtgts[1][2]=PN('AP Default Speed')
				end
				_1,_2=G2CpsPit({APx-mapx,APy-mapy,0})
				APtgts[3][2]=(_1*360)%360
				APtgts[1][1]=true
				APtgts[2][1]=true
				APtgts[3][1]=true
			else				
				APtgts[1][1]=false
				APtgts[2][1]=false
				APtgts[3][1]=false
			end
		end
		if APtgts[1][1] then APspd=APtgts[1][2]/3.6 else APspd=0 end
		--pit
		if usage<3 then--heli
			pitT=-Mp(pid(7,vz,ws*30+APspd,0.006,0.00002,0.06,0.1,0.015,0.2),-0.15,0.15)
		else--plane
			pitT=Mp(pid(7,alt,APtgts[2][2],0.006,0.00002,0.06,0.1,0.015,0.2),-0.03,0.03)
		end
		pO=-pid(5,p,pitT,4,0.0003,8,1,0.1,1)
		--rol
		rolT=Mp(pid(8,vx,ad*10,0.006,0.00002,0.08,0.05,0.015,0.2),-0.1,0.1)
		rO=pid(6,-r,rolT,4,0.0003,8,1,0.1,1)
		--col
		if usage<3 then--heli
			if Mb(ud)<0.1 then cO=0 else cO=ud*10 end
			if APtgts[2][1] then
				APalt=APtgts[2][2]
				APcol=pid(9,alt,APalt,1,0.001,1,5,0.5,5)
			else
				APalt=alt
				APcol=0
			end
			Col=Mp(pid(4,dalt,cO+APcol,PN('ColP'),PN('ColI'),PN('ColD'),PN('ColPM'),PN('ColIM'),PN('ColPM')),0,1)
		else--plane
			Col=cO*Mp(pid(4,vz,APtgts[1][2],PN('ColP'),PN('ColI'),PN('ColD'),PN('ColPM'),PN('ColIM'),PN('ColPM')),0,1)
		end
		--yaw
		if APtgts[3][1] then
			APdir=APtgts[3][2]
			APyaw=-pid(10,CD(c,-APdir/360),0,3,0.005,6,0.5,0.1,1)
		else
			APdir=c360
			APyaw=0
		end
		yO=lr+APyaw
	else
		if PN('CollectiveMode')==1 and usage<3 then--auto col
			if Mb(ud)>0.9 and cO*ud>0 then
				cO=Mp(cO+ud*0.2*((vym-Mb(vy))/vym),-vym,vym)
			else
				if cO<20*0.9 and cO>-20*0.9 then
					cO=ud*20
				else
					if cO>ud*20*0.9 then
						cO=cO-0.2+0.2*ud
					else
						cO=cO+0.2+0.2*ud
					end
				end
			end
			Col=Mp(pid(4,vy,cO,PN('ColP'),PN('ColI'),PN('ColD'),PN('ColPM'),PN('ColIM'),0.5),0,1)
		else
			Col=Mp(ud*PN('ManualColMtpl'),PN('MinCol'),1)--manual col
		end
	end
	Pit=pid(1, asx,pO*PN('PitAS'),PN('PitP'),PN('PitI'),PN('PitD'),PN('PitPM'),PN('PitIM'),1)
	Rol=pid(3,-asz,rO*PN('RolAS'),PN('RolP'),PN('RolI'),PN('RolD'),PN('RolPM'),PN('RolIM'),1)
	Yaw=pid(2, asy,yO*PN('YawAS'),PN('YawP'),PN('YawI'),PN('YawD'),PN('YawPM'),PN('YawIM'),1)
	if usage>1 then
		fpbc=0
		frbp=0
		fybc=0
	else
		fpbc=PN('FixPitByCol')
		frbp=PN('FixRolByPit')
		fybc=PN('FixYawByCol')
	end
	SN(1,Pit+fpbc*Col)
	rolo=Rol+PN('FixRolByYaw')*Yaw+frbp*Pit
	SN(2,rolo)
	SN(6,-rolo)
	SN(3,PN('ReverseYaw')*(Yaw+fybc*Col))
	if Col<0.3 then Coladd=Mp(Mb(Pit)+Mb(Rol),0,0.3) else Coladd=0 end
	if usage<2 then--heli
		SN(4,Col+Coladd)
	elseif usage<3 then--cx heli
		SN(4,Col+Coladd-Yaw)
		SN(5,Col+Coladd+Yaw)
	else--plane
		SN(4,Col)
	end
end
S=screen
ssc=S.setColor
DR=S.drawRect
DT=S.drawText
DL=S.drawLine
--msg=string.format('%2.0f',z)..'x'
function gog(x)
	if x then
		ssc(22,222,22)
	else
		ssc(16,16,16)
	end
end
apnames={'spd','alt','dir'}
function onDraw()
	ssc(16,16,16)
	DL(1,25,32,25)
	DL(10,25,10,32)
	DL(20,25,20,32)
	gog(AutoPilot)
	DT(1,1,'ap')
	gog(APGPS)
	DT(16,1,'gps')
	for i=1,3 do
		gog(APtgts[i][1])
		msg=apnames[i]..string.format('%03.0f',APtgts[i][2])
		DT(1,i*6+1,msg)
	end
	ssc(22,222,22,128)
	DR(0,6*APsl,31,6)
	gog(touched and touchX<10 and touchY>25)
	DT(4,27,'-')
	gog(touched and touchX>20 and touchY>25)
	DT(25,27,'+')
	gog(touched and touchX>10 and touchX<20 and touchY>25)
	DT(14,27,'c')
end