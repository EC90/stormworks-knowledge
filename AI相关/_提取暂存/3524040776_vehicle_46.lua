-- source: steam id 3524040776 / vehicle.xml block#46
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--Pyo's Mini Aegis gyro AP
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
	{false,0,1},
	{false,0,5},
	{false,0,5}
}
APtgtx=0
APtgty=0
touchX,touchY=0,0
touch=false
manual=false
function onTick()
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
	--
	APx=GN(31)
	APy=GN(32)
	--touch
	if c<0 then c360=-c*360 else c360=360-c*360 end
	APcur={Mf(vz+0.5),Mf(alt+0.5),(Mf(c360/5+0.5)*5)%360}
	touched=GN(27)>0.5 and not touch
	touch=GN(27)>0.5
	touchX,touchY=GN(25),GN(26)
	if touched then
		if touchY<7 then
			manual=not manual
		elseif touchY<13 then
			if touchX<16 then
				AutoPilot=not AutoPilot
				if AutoPilot then
					for i=1,3 do
						APtgts[i][2]=APcur[i]
					end
					APtgts[1][1]=true
					APtgts[2][1]=true
				end
			else
				if APx~=0 and not APGPS then
					APGPS=true
				elseif APGPS then
					APGPS=false
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
			if touchY>19 then
				APslN=3
			else
				APslN=1
			end
			if APslN==APsl then
				APtgts[APsl][1]=not APtgts[APsl][1]
			else
				APsl=APslN
			end
		end 
	end
	if not AutoPilot then
		APtgts[1][2]=APcur[1]
	end
	--key binding
	ad,ws,lr,ud=GN(PN('Roll Key')),GN(PN('Pitch Key')),GN(PN('Yaw Key')),GN(PN('Collective Key'))
	pO,yO,rO=ws,lr,ad
	--main
	if AutoPilot then
		APtgts[1][1]=true
		if APGPS then
			if APx~=0 then
				_1,_2=G2CpsPit({APx-mapx,APy-mapy,0})
				APtgts[3][2]=(_1*360)%360
				APtgts[1][1]=true
				APtgts[2][1]=true
				APtgts[3][1]=true
			else
				APGPS=false
				APtgts[1][2]=0
				APtgts[2][1]=false
				APtgts[3][1]=false
			end
		end
		Col=Mp(pid(4,vz,APtgts[1][2],PN('ColP'),PN('ColI'),PN('ColD'),PN('ColPM'),PN('ColIM'),PN('ColPM')),0,1)
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
		Col=ud--manual col
	end
	if Mb(vz)>3 or Mb(yO)>0.1 then
		Rol=pid(3,-r,0,PN('RolP'),PN('RolI'),PN('RolD'),PN('RolPM'),PN('RolIM'),1)
		Yaw=pid(2, asy,yO*(1-Mp(vz/50,0.1,1))*PN('YawAS'),PN('YawP'),PN('YawI'),PN('YawD'),PN('YawPM'),PN('YawIM'),1)
		if vz<-2 then
			Yaw=-Yaw
		end
	else
		Rol,Yaw=0,0
	end
	if vz<-0.1 then
		Rol=-Rol
	end
	SN(2,Rol)
	SN(3,PN('ReverseYaw')*Yaw)
	SN(4,Col)
	SB(1,manual)
	SB(2,AutoPilot)
	SN(6,APtgts[1][2])
end
S=screen
ssc=S.setColor
DR=S.drawRect
DT=S.drawText
DL=S.drawLine
function gog(x)
	if x then
		ssc(22,222,22)
	else
		ssc(16,16,16)
	end
end
apnames={'spd','alt','dir'}
function onDraw()
	ssc(8,8,8)
	S.drawClear()
	ssc(16,16,16)
	DL(1,25,32,25)
	DL(10,25,10,32)
	DL(20,25,20,32)
	ssc(22,222,22)
	if manual then
		DT(1,1,'MANUAL')
	else
		DT(1,1,'CRUISE')
	end
	gog(AutoPilot)
	DT(1,7,'ap')
	gog(APGPS)
	DT(16,7,'gps')
	--draw spd and dir
	gog(APtgts[1][1])
	msg=apnames[1]..string.format('%03.0f',APtgts[1][2]*1.944)
	DT(1,13,msg)
	gog(APtgts[3][1])
	msg=apnames[3]..string.format('%03.0f',APtgts[3][2])
	DT(1,19,msg)
	--
	APslR=Mp(APsl,2,3)
	ssc(22,222,22,128)
	DR(0,6*APslR,31,6)
	gog(touched and touchX<10 and touchY>25)
	DT(4,27,'-')
	gog(touched and touchX>20 and touchY>25)
	DT(25,27,'+')
	gog(touched and touchX>10 and touchX<20 and touchY>25)
	DT(14,27,'c')
end