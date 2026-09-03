-- source: steam id 3378671427 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3378671427
--PYO's FCS TRT v20250505
GN=input.getNumber
GetBool=input.getBool
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
Math=math
MathAtan=Math.atan
MathAbs=Math.abs
MathCos=Math.cos
MathFlr=Math.floor
MathSin=Math.sin
ar=Math.sqrt
P2=Math.pi*2
function MathClamp(u,p,O)
	return Math.max(Math.min(O,u),p)
end
function E2R(e)
	local q,r,s=e[1],e[2],e[3]
	return {{MathCos(r)*MathCos(s),MathCos(q)*MathCos(r)*MathSin(s)+MathSin(q)*MathSin(r),MathSin(q)*MathCos(r)*MathSin(s)-MathCos(q)*MathSin(r)},{-MathSin(s),MathCos(q)*MathCos(s),MathSin(q)*MathCos(s)},{MathSin(r)*MathCos(s),MathCos(q)*MathSin(r)*MathSin(s)-MathSin(q)*MathCos(r),MathSin(q)*MathSin(r)*MathSin(s)+MathCos(q)*MathCos(r)}}
end
function tM(Math)
	local f={{},{},{}}
	for p=1,3 do
		for j=1,3 do
			f[p][j]=Math[j][p]
		end
	end
	return f
end
function Mv(Math,u)
	local f={}
	for p=1,3 do
		e=0
		for j=1,3 do
			e=e+Math[j][p]*u[j]
		end
		f[p]=e
	end
	return f
end
function aQ(e)
	return Mv(E2R(GunEu),{e[1],e[2],e[3]})
end
function aR(Z)
	return MathAtan(Z[1],Z[2]),MathAtan(Z[3],Z[2])
end
function G2PitCps(e)
	return MathAtan(e[1],e[2])/P2,MathAtan(e[3],ar(e[1]^2+e[2]^2))/P2
end
function Cps2Delta(P,f)
	P,f=P%1,f%1
	if P-f>0.5 then
		f=f+1
	elseif P-f<-0.5 then
		f=f-1
	end
	return P-f
end
Is={}
Ds={}
Dss={}
function Pid(id,v,s,p,i,d,plmt,ilmt,dlmt)
	if not Is[id] then
		Is[id]=0
		Ds[id]=0
		Dss[id]={}
	end
	Is[id]=MathClamp(Is[id]+i*(s-v),-ilmt,ilmt)
	local output=MathClamp(p*(s-v),-plmt,plmt)+Is[id]+MathClamp(d*(s-v-Ds[id]),-dlmt,dlmt)
	Ds[id]=s-v
	return output
end
function MathDist(O,a9)
	return ar((O[1]-a9[1])^2+(O[2]-a9[2])^2+(O[3]-a9[3])^2)
end
ShellParaAll={
	{rg=1000,lf=150,v0=1000,dg=0.98,dw=0.002},--l
	{rg=2500,lf=600,v0=900,dg=0.995,dw=0.002},--h
	{rg=1500,lf=300,v0=1000,dg=0.99,dw=0.001},--r
	{rg=5000,lf=600,v0=900,dg=0.998,dw=0.001},--b
	{rg=7000,lf=600,v0=700,dg=0.999,dw=0.00075},--a
	{rg=7000,lf=600,v0=600,dg=0.9995,dw=0.000375},--berth
	{rg=800,lf=120,v0=800,dg=0.975,dw=0.0025},--mg1
	{rg=1200,lf=120,v0=1600,dg=0.975,dw=0.0025},--mg2
	{rg=1600,lf=120,v0=2400,dg=0.975,dw=0.0025},--mg3
	{rg=2300,lf=2400,v0=50,dg=0.995,dw=0.002}--rkt
}
ShellPara=ShellParaAll[PN('Wepon Type')]
Gravt={0,0,-0.5}
PvtY=0
AimOfstX,AimOfstY=0,0
AimTGTX,AimTGTY=0,0
ShellDrop=0
ShellETA=0
kPivot=PN('pivot k')
kRstX=PN('rst x when rld')
kRstY=PN('rst y when rld')
TGTDist=0
xlimit=PN('x limit')/360
isxlimit=PN('x limit')~=0
TrtDir=PN('turret direction')
rldcounter=0
reload=false
function onTick()
	Aiming=false
	--basic
	GunPos={GN(1),GN(3),GN(2)}
	GunEu={GN(4),GN(6),GN(5)}
	GunV=Mv(tM(E2R(GunEu)),{GN(7),GN(9),GN(8)})
	GunPit=GN(26)
	GunCps=-GN(27)
	--angular spd
	ascps=GN(31)
	aspit=GN(32)
	--from CMD
	TGTpos={GN(11),GN(12),GN(13)}
	TGTv={GN(14),GN(15),GN(16)}
	WindVx=GN(17)
	WindVy=GN(18)
	mode=GN(19)
	aimPit=GN(20)
	aimCps=GN(21)
	aimStdX=GN(22)+TrtDir
	aimStdY=GN(23)
	lsr=mode<2.5 and GN(24)~=TGTDist
	TGTDist=GN(24)
	--misc
	TrtRot=GN(28)
	TrtReset=GN(29)
	EleMin=PN('-')/360
	EleMax=PN('+')/360
	--drop and eta cal
	if (lsr or mode>2.5) and TrtReset>0.5 and not reload then
		if mode>2.5 then
			TGTDist=MathDist(TGTpos,GunPos)
		end
		ARM=TGTDist<ShellPara.rg
		if ARM then
			WindV={WindVx,WindVy,0}
			ShellETA=1.5+0.07*TGTDist+1E-05*TGTDist^2
			ShellDrop=-2E-05*TGTDist-4.2E-09*TGTDist^2
			for w=1,4 do
				AimPos={TGTpos[1]+TGTv[1]*ShellETA,TGTpos[2]+TGTv[2]*ShellETA,TGTpos[3]+TGTv[3]*ShellETA}
				am=AimPos
				TGTDist=MathDist(AimPos,GunPos)
				ShellPos={GN(1),GN(3),GN(2)}
				ShellCps,ShellPit=G2PitCps({AimPos[1]-GunPos[1],AimPos[2]-GunPos[2],AimPos[3]-GunPos[3]})
				Shellv0v=ShellPara.v0*MathSin(ShellPit*P2-ShellDrop)
				Shellv0h=ShellPara.v0*MathCos(ShellPit*P2-ShellDrop)
				Shellv0xyz={GunV[1]+Shellv0h*MathSin(ShellCps*P2),GunV[2]+Shellv0h*MathCos(ShellCps*P2),GunV[3]+Shellv0v}
				Shellv0hadd=10*MathCos(ShellPit*P2-ShellDrop)
				Shellv0vadd=10*MathSin(ShellPit*P2-ShellDrop)
				Shellv0add={Shellv0hadd*MathSin(ShellCps*P2),Shellv0hadd*MathCos(ShellCps*P2),Shellv0vadd}
				for SimStep=1,ShellPara.lf do
					for xyz=1,3 do
						ShellPos[xyz]=ShellPos[xyz]+Shellv0xyz[xyz]/60
						if SimStep<71 and PN('Wepon Type')==10 then
							Shellv0xyz[xyz]=Shellv0xyz[xyz]*ShellPara.dg+Gravt[xyz]+WindV[xyz]*ShellPara.dw+Shellv0add[xyz]
						else
							Shellv0xyz[xyz]=Shellv0xyz[xyz]*ShellPara.dg+Gravt[xyz]+WindV[xyz]*ShellPara.dw
						end
					end
					if MathDist(ShellPos,GunPos)>TGTDist then
						b2=MathAtan(ShellPos[3]-TGTpos[3],TGTDist)
						ShellDrop=ShellDrop+b2
						ShellETA=SimStep
						AimPos={AimPos[1]+am[1]-ShellPos[1],AimPos[2]+am[2]-ShellPos[2],AimPos[3]+am[3]-ShellPos[3]}
						break
					end
				end
			end
		else
			ShellDrop=0
			ShellETA=0
			AimPos={TGTpos[1],TGTpos[2],TGTpos[3]}
		end
	end
	--pvt
	conA=TrtReset<0.5 or (reload and kRstX>0.5)
	conB=isxlimit and Cps2Delta(aimStdX,0)<TrtRot-0.49
	conC=isxlimit and Cps2Delta(aimStdX,0)>TrtRot+0.49
	if conA or conB or conC then
		mode=0
	end
	if mode>2.5 then--aim at gps
		aimCps,aimPit=G2PitCps({AimPos[1]-GunPos[1],AimPos[2]-GunPos[2],AimPos[3]-GunPos[3]})
		aimPit=aimPit-ShellDrop/P2
	elseif mode>1.5 then
		aimPit=aimPit-ShellDrop/P2
	elseif mode>0.5 then
		aimStdY=aimStdY-ShellDrop/P2
	else
		aimStdX=0
		aimStdY=0
	end
	if mode<1.5 then
		deltCps=Cps2Delta(TrtRot,aimStdX)
		rstX=Pid(1,deltCps*P2,0,PN('pivot x p'),PN('pivot x i'),PN('pivot x d'),PN('pivot x p m'),PN('pivot x i m'),PN('pivot x d m'))
		--prevent spike
		rstY=aimStdY*4
		if Is[3] then
			Is[3]=rstY
		end
	else
		deltCps=Cps2Delta(GunCps,aimCps)
		rstX=ascps*PN('x stab')+Pid(2,deltCps*P2,0,PN('pivot x p'),PN('pivot x i'),PN('pivot x d'),PN('pivot x p m'),PN('pivot x i m'),PN('pivot x d m'))
		rstY=MathClamp(-aspit*PN('y stab')+Pid(3,GunPit,aimPit,0,PN('pivot y i'),PN('pivot y d'),0,1,1),EleMin*4,EleMax*4)
		conA=MathAbs(deltCps*P2)>MathAtan(PN('aim ready threshold'),TGTDist)
		conB=MathAbs(GunPit-aimPit)*P2>MathAtan(PN('aim ready threshold'),TGTDist)
		Aiming=conA or conB
	end
	--x limit
	if TrtRot>xlimit then
		rstX=Math.min(rstX,0)
	elseif TrtRot<-xlimit then
		rstX=Math.max(rstX,0)
	end
	SN(3,rstX)
	SN(4,rstY)
	SN(8,GN(27))
	--trigger
	SB(1,GN(25)>0.5 and (not Aiming) and (not reload) and (TrtReset>0.5))
	ammo=GN(30)
	if reload then rldcounter=rldcounter+1 end
	if (reload and ammo==PN('ammo rack')) or rldcounter>600 then reload=false rldcounter=0 end
	if ammo<0.5 then reload=true end
	ammoout=MathClamp(ammo/PN('ammo rack'),0,0.99)
	if reload then
		SN(6,1)
	else
		SN(6,0)
	end
	SB(2,reload)
	if Aiming then
		SN(5,ammoout)
	else
		SN(5,1+ammoout)
	end
	--debug
	SB(3,ARM)
end