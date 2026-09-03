-- source: steam id 3267716101 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3267716101
--PYOs ANTICAUSAL FCS Modern Tank Build Pivot 0622rbd
GetNum=input.getNumber
b7=input.getBool
SetNum=output.setNumber
b8=output.setBool
PN=property.getNumber
Math=math
MathAtan=Math.atan
aq=Math.abs
MathCos=Math.cos
MathFlr=Math.floor
MathSin=Math.sin
ar=Math.sqrt
Pi2=Math.pi*2
function MathClamp(u,p,O)
	return Math.max(Math.min(O,u),p)
end
function as(e)
	local q, r, s=e[1], e[2], e[3]
	return {{MathCos(r)*MathCos(s),MathCos(q)*MathCos(r)*MathSin(s)+MathSin(q)*MathSin(r),MathSin(q)*MathCos(r)*MathSin(s)-MathCos(q)*MathSin(r)},{-MathSin(s),MathCos(q)*MathCos(s),MathSin(q)*MathCos(s)},{MathSin(r)*MathCos(s),MathCos(q)*MathSin(r)*MathSin(s)-MathSin(q)*MathCos(r),MathSin(q)*MathSin(r)*MathSin(s)+MathCos(q)*MathCos(r)}}
end
function aP(Math)
	local f={{},{},{}}
	for p=1,3 do
		for j=1,3 do
			f[p][j]=Math[j][p]
		end
	end
	return f
end
function at(Math,u)
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
	return at(as(SelfEu),{e[1],e[2],e[3]})
end
function aR(Z)
	return MathAtan(Z[1],Z[2]), MathAtan(Z[3],Z[2])
end
function av(e)
	return MathAtan(e[1],e[2])/Pi2, MathAtan(e[3],ar(e[1]^2+e[2]^2))/Pi2
end
function Cps2Delta(P,f)
	P,f=P%1, f%1
	if P-f>0.5 then
		f=f+1
	elseif P-f<-0.5 then
		f=f-1
	end
	return P-f
end
Q={}
a7={}
aS={}
function Pid(t,u,a0,aT,p,aU,aw,ax)
	if not Q[t] then
		Q[t]=0
		a7[t]=0
		aS[t]={}
	end
	Q[t]=MathClamp(Q[t]+p*(a0-u),-ax,ax)
	local aV=MathClamp(aT*(a0-u),-aw,aw)+Q[t]+aU*(a0-u-a7[t])
	a7[t]=a0-u
	return aV
end
function MathDist(O,a9)
	return ar((O[1]-a9[1])^2+(O[2]-a9[2])^2+(O[3]-a9[3])^2)
end
ShellParaAll={
	{rg=1000,lf=150,v0=1000,dg=0.98,dw=0.002},--l
	{rg=2500,lf=600,v0=900,dg=0.995,dw=0.002},--h
	{rg=1500,lf=300,v0=1000,dg=0.99,dw=0.001},--r
	{rg=5000,lf=1500,v0=800,dg=0.998,dw=0.001},--b
	{rg=7000,lf=2400,v0=700,dg=0.999,dw=0.00075},--a
	{rg=7000,lf=2400,v0=600,dg=0.9995,dw=0.000375},--berth
	{rg=800,lf=120,v0=800,dg=0.975,dw=0.0025},--mg1
	{rg=1200,lf=120,v0=1600,dg=0.975,dw=0.0025},--mg2
	{rg=1600,lf=120,v0=2400,dg=0.975,dw=0.0025},--mg3
}
Gravt={0,0,-0.5}
GunY=0
bb=0
bc=0
AimOfstX, AimOfstY=0, 0
AimTGTX, AimTGTY=0, 0
ShellDrop=0
ShellETA=0
False=false
StabO=False
isLockO=False
deg360=360
kPivot=PN('pivot k')
kRst=PN('rst when rld')
kCam=PN('cam')
TGTDist=0
function onTick()
	ShellPara=ShellParaAll[GetNum(29)]
	Aiming=False
	SelfPos={GetNum(1),GetNum(3),GetNum(2)}
	SelfEu={GetNum(4),GetNum(6),GetNum(5)}
	SelfV=at(aP(as(SelfEu)),{GetNum(7),GetNum(9),GetNum(8)})
	kAcc=PN('acc k')
	BreechDir=(PN('breech dir')*0.25-GetNum(18))*Pi2
	if GetNum(29)==4 then
	FixRaw=GetNum(12)%1e6
	FixRawX=kAcc*(MathFlr(FixRaw/1e3)-5e2)/5e5
	FixRawY=-kAcc*(FixRaw%1e3-5e2)/5e5
	FixX=FixRawX*MathCos(BreechDir)+FixRawY*MathSin(BreechDir)
	FixY=-FixRawX*MathSin(BreechDir)+FixRawY*MathCos(BreechDir)
	else
		FixX,FixY=0,0
	end
	kLoaded=MathFlr(GetNum(12)/1e6)
	gunLoaded=kLoaded>0
	rstY=Math.max(kRst,kLoaded)
	TrtPit=GetNum(15)
	GunPit=GetNum(16)
	GunCps=GetNum(17)
	Zoom=2^(GetNum(14)%10)/4
	TGTpos={GetNum(21),GetNum(22),GetNum(23)}
	TGTv={GetNum(24),GetNum(25),GetNum(26)}
	GPSpos={GetNum(30),GetNum(31),GetNum(32)}
	isGPS=GPSpos[1]~=0 and GPSpos[2]~=0
	if isGPS then
		TGTpos=GPSpos
		TGTv={0,0,0}
	end
	isTGT=TGTpos[1]~=0 and TGTpos[2]~=0
	isLock=(isTGT and isRadar) or isGPS
	MergedNum=GetNum(28)
	LR=MathFlr(MergedNum/1e5)/50-1
	UD=MathFlr(MergedNum%1e5/1e3)/50-1
	if MergedNum%1e3>99 then
		SlowAim=0.2/Zoom
	else
		SlowAim=1/Zoom
	end
	isRadar=MergedNum%100>9
	Stab=MergedNum%10>0
	if Stab then
		StabX=-GetNum(10)*4*kPivot
		StabY=-GetNum(11)*0.05
	else
		StabX=0
		StabY=0
	end
	TrtRot=GetNum(27)
	CosTrtRot=MathCos(TrtRot*Pi2)
	TrtReset=MathFlr(GetNum(14)/10)
	if rstY>0 then
		if CosTrtRot<-0.85 then
			GunYMin=PN('ele back')/deg360
		elseif CosTrtRot<-0.55 then
			GunYMin=PN('ele side')/deg360
		else
			GunYMin=PN('-')/deg360
		end
		GunYMax=PN('+')/deg360
	else
		tempY=PN('ele loading')/deg360
		GunYMin=tempY
		GunYMax=tempY
	end
	if isTGT then
		TGTDist=MathDist(TGTpos,SelfPos)
		ARM=TGTDist<ShellPara.rg
		if ARM then
			WindDir=GetNum(19)
			WindStr=GetNum(20)
			WindV={WindStr*MathSin((WindDir-GunCps)*Pi2)-SelfV[1],WindStr*MathCos((WindDir-GunCps)*Pi2)-SelfV[2],0}
			ShellETA=1.5+0.07*TGTDist+1E-05*TGTDist^2
			ShellDrop=-2E-05*TGTDist-4.2E-09*TGTDist^2
			for w=1,3 do
				AimPos={TGTpos[1]+TGTv[1]*ShellETA,TGTpos[2]+TGTv[2]*ShellETA,TGTpos[3]+TGTv[3]*ShellETA}
				am=AimPos
				TGTDist=MathDist(AimPos,SelfPos)
				ShellPos={GetNum(1),GetNum(3),GetNum(2)}
				aK,aL=av({AimPos[1]-SelfPos[1],AimPos[2]-SelfPos[2],AimPos[3]-SelfPos[3]})
				b1=ShellPara.v0*MathSin(aL*Pi2-ShellDrop)
				aM=ShellPara.v0*MathCos(aL*Pi2-ShellDrop)
				an={SelfV[1]+aM*MathSin(aK*Pi2),SelfV[2]+aM*MathCos(aK*Pi2),SelfV[3]+b1}
				for p=1, ShellPara.lf do
					for j=1,3 do
						ShellPos[j]=ShellPos[j]+an[j]/62
						an[j]=an[j]*ShellPara.dg+Gravt[j]-WindV[j]*ShellPara.dw
					end
					if MathDist(ShellPos,SelfPos)>TGTDist then
						b2=MathAtan(ShellPos[3]-TGTpos[3],TGTDist)
						ShellDrop=ShellDrop+b2
						ShellETA=p
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
	if isLock and TrtReset>0 then
		AimOfstX=AimOfstX+LR*SlowAim*0.0005
		AimOfstY=AimOfstY+UD*SlowAim*0.0005
		AimTGTX,AimTGTY=av({AimPos[1]-SelfPos[1],AimPos[2]-SelfPos[2],AimPos[3]-SelfPos[3]})
		GunX=Pid(1,Cps2Delta(-GunCps,AimTGTX+AimOfstX+FixX)*Pi2,0,4,0.1,16,0.2,0.1)
		GunY=Pid(2,GunPit,AimTGTY+AimOfstY-ShellDrop/Pi2+FixY,0,0.2*rstY,0.2*rstY,0.5,1)
		tempX,tempY=aR(aQ({TGTpos[1]-SelfPos[1],TGTpos[2]-SelfPos[2],TGTpos[3]-SelfPos[3]}))
		ScpX=(tempX/Pi2+AimOfstX)*8
		ScpY=(tempY/Pi2+AimOfstY)*8
		Aiming=aq(Cps2Delta(-GunCps,AimTGTX+AimOfstX+FixX)*Pi2)>MathAtan(2,TGTDist) or aq(GunPit-(AimTGTY+AimOfstY-ShellDrop/Pi2+FixY))*Pi2>MathAtan(2,TGTDist)
	else
		AimOfstX, AimOfstY=0, 0
		if Stab and TrtReset>0 then
			if not StabO then
				AimTGTX=-GunCps-FixX
				AimTGTY=GunPit+ShellDrop/Pi2-FixY
			elseif isLockO then
				AimTGTX=-GunCps-FixX
				AimTGTY=AimTGTY
			else
				AimTGTX=AimTGTX+LR*SlowAim*0.002
				AimTGTY=AimTGTY+UD*SlowAim*0.001
			end
			GunX=Pid(3,Cps2Delta(-GunCps,AimTGTX+FixX)*Pi2,0,4,0.005,6,0.75,0.05)
			GunY=Pid(4,GunPit,AimTGTY-ShellDrop/Pi2+FixY,0,0.2*rstY,0.2*rstY,0.5,1)
			ScpY=(AimTGTY-TrtPit)*8
		else
			if TrtReset<1 then
				AimTGTX=0
				AimTGTY=0
			elseif StabO or isLockO then
				AimTGTX=TrtRot-FixX
				AimTGTY=ScpY/8
			else
				AimTGTX=AimTGTX+LR*SlowAim*0.002
				AimTGTY=AimTGTY+UD*SlowAim*0.001
			end
			GunX=Pid(5,Cps2Delta(TrtRot,AimTGTX+FixX)*Pi2,0,4,0.005,6,0.5,0.1)
			GunY=(AimTGTY-ShellDrop/Pi2+FixY)*4
			ScpY=AimTGTY*8
		end
		ScpX=-FixX*8
	end
	tempY=MathClamp(GunY+StabY,GunYMin*4,GunYMax*4)
	SetNum(1,ScpX)
	SetNum(2,ScpY-tempY*kCam)
	SetNum(3,GunX*kPivot+StabX)
	SetNum(4,tempY)
	tempX,tempY=MathClamp(MathFlr(500*ScpX+500.5),0,999), MathClamp(MathFlr(500*ScpY+500.5),0,999)
	SetNum(5,tempX*1000+tempY)
	StabO=Stab
	isLockO=isLock
	SetNum(6,(ShellETA-1)/62 or 0)
end
Scr=screen
SetC=Scr.setColor
DTB=Scr.drawTextBox
DL=Scr.drawLine
function onDraw()
	mntX=Scr.getWidth()
	mntY=Scr.getHeight()
	SetC(22,222,22)
	--CamFov=Pi2*45.9/deg360/Zoom
	--x, 	y=MathFlr(mntX/2+0.5+mntY*AimOfstX*Pi2/CamFov), MathFlr(mntY/2+0.5-mntY*AimOfstY*Pi2/CamFov)
	x, 	y=MathFlr(mntX/2+0.5), MathFlr(mntY/2+0.5)
	DL(x-2,y,x-4,y)
	DL(x+2,y,x+4,y)
	DL(x,y-2,x,y-4)
	DL(x,y+2,x,y+4)
	DTB(0,mntY-6,mntX,6,string.format('%4.0f',TGTDist) .. 'm',0,0)
	if isGPS then
		SetC(222,22,22)
		DTB(0,9,mntX,6,'GPS OVR',0,0)
		SetC(22,222,22)
	end
	if gunLoaded then
		if Aiming then
			SetC(222,222,22)
			DTB(0,mntY-13,mntX,6,'aiming',0,0)
		else
			DTB(0,mntY-13,mntX,6,'ready',0,0)
		end
	else
		SetC(222,22,22)
		DTB(0,mntY-13,mntX,6,'loading',0,0)
	end
end