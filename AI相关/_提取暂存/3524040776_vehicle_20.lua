-- source: steam id 3524040776 / vehicle.xml block#20
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--PYO's FCS CMD v20250505
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
MathAtan=M.atan
MathAbs=M.abs
MathCos=M.cos
MathFlr=M.floor
MathSin=M.sin
MathSq=M.sqrt
Pi=M.pi
P2=M.pi*2
function MathClamp(v,min,max)
	return M.max(M.min(v,max),min)
end
function E2R(e)
	local q,r,s=e[1],e[2],e[3]
	return {{MathCos(r)*MathCos(s),MathCos(q)*MathCos(r)*MathSin(s)+MathSin(q)*MathSin(r),MathSin(q)*MathCos(r)*MathSin(s)-MathCos(q)*MathSin(r)},{-MathSin(s),MathCos(q)*MathCos(s),MathSin(q)*MathCos(s)},{MathSin(r)*MathCos(s),MathCos(q)*MathSin(r)*MathSin(s)-MathSin(q)*MathCos(r),MathSin(q)*MathSin(r)*MathSin(s)+MathCos(q)*MathCos(r)}}
end
function tM(m)
	local f={{},{},{}}
	for p=1,3 do
		for j=1,3 do
			f[p][j]=m[j][p]
		end
	end
	return f
end
function Mv(m,u)
	local f={}
	for p=1,3 do
		local e=0
		for j=1,3 do
			e=e+m[j][p]*u[j]
		end
		f[p]=e
	end
	return f
end
function R2G(r)
	local t=Mv(tM(E2R(HullEu)),{r[1]*MathCos(r[3]*P2)*MathSin(r[2]*P2),r[1]*MathCos(r[3]*P2)*MathCos(r[2]*P2),r[1]*MathSin(r[3]*P2)})
	return {t[1]+HullPos[1],t[2]+HullPos[2],t[3]+HullPos[3]}
end
function G2L(g)
	return Mv(E2R(HullEu),{g[1],g[2],g[3]})
end
function L2AE(l)--rad
	return MathAtan(l[1],l[2])/P2,MathAtan(l[3],l[2])/P2
end
function L2G(l)
	return Mv(tM(E2R(HullEu)),{l[1],l[2],l[3]})
end
function G2CpsPit(g)
	return MathAtan(g[1],g[2])/P2,MathAtan(g[3],MathSq(g[1]^2+g[2]^2))/P2
end
function CpsPit2G(d,cps,pit)
	local _={0,0,0}
	_[3]=MathSin(pit*P2)*d
	_[1]=MathSin(cps*P2)*MathCos(pit*P2)*d
	_[2]=MathCos(cps*P2)*MathCos(pit*P2)*d
	return {_[1]+HullPos[1],_[2]+HullPos[2],_[3]+HullPos[3]}
end
function Cps2Delta(c,d)
	c,d=c%1,d%1
	if c-d>0.5 then
		d=d+1
	elseif c-d<-0.5 then
		d=d-1
	end
	return c-d
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
	return MathSq((O[1]-a9[1])^2+(O[2]-a9[2])^2+(O[3]-a9[3])^2)
end
rstY=0
AimOfstX,AimOfstY=0,0
AimTGTX,AimTGTY=0,0
False=false
isLockO=False
aimStdX,aimStdY=0,0
TGTDist=200
LSRpos={0,0,0}
cnt=0
kPivot=PN('pivot k')
xlimit=PN('x limit')/360
isxlimit=PN('x limit')~=0
isSpdPvt=PN('elevator type')
isAimLsr=PN('laser behavior')>0.5
function onTick()
	HullPos={GN(1),GN(3),GN(2)}
	HullEu={GN(4),GN(6),GN(5)}
	HullCps=GN(17)
	--angular speed
	ascps=GN(10)
	aspit=GN(11)
	--?
	PvtPit=GN(15)
	PvtCps=-GN(16)
	--
	Zoom=2^(GN(14)%10)/4
	--key input
	MergedNum=GN(28)
	LR=MathFlr(MergedNum/1e5)/50-1
	UD=MathFlr(MergedNum%1e5/1e3)/50-1
	if MergedNum%1e3>99 then
		SlowAim=0.2/Zoom
	else
		SlowAim=1/Zoom
	end
	isRadar=MergedNum%100>9
	Stab=MergedNum%10>0
	--cur rot
	TrtRot=GN(27)
	TrtReset=MathFlr(GN(14)/10)
	EleMin=PN('-')/360
	EleMax=PN('+')/360
	--radar and laser
	TGTvel={GN(24),GN(25),GN(26)}
	if isRadar then
		RDRpos={GN(21),GN(22),GN(23)}
		LSRpos={0,0,0}
	else
		if GN(21)~=0 and GN(22)~=0 then
			if isAimLsr then
				if MathDist({GN(21),GN(22),GN(23)},LSRpos)>50 then
					LSRpos={GN(21),GN(22),GN(23)}
					AimOfstX,AimOfstY=0,0
				end
			else
				TGTDist=MathDist({GN(21),GN(22),GN(23)},HullPos)
			end
		end
		RDRpos={0,0,0}
	end
	--gps
	GPSpos={GN(30),GN(31),GN(32)}
	isGPS=GPSpos[1]~=0 and GPSpos[2]~=0
	if isGPS then
		if MathDist(GPSpos,RDRpos)<PN('gps target search range') then
			cnt=math.min(cnt+1,120)
		else
			cnt=math.max(cnt-2,0)
		end
		if cnt<60 then
			TGTpos=GPSpos
			TGTvel={0,0,0}
		else
			TGTpos=RDRpos
		end
	elseif isRadar then
		TGTpos=RDRpos
		cnt=0
	else
		TGTpos=LSRpos
		cnt=0
	end
	SN(26,cnt)
	--aim cal
	if TrtReset>0 then
		if TGTpos[1]~=0 and TGTpos[2]~=0 then
			mode=3
			--aim at xyz
			TGTDist=MathDist(TGTpos,HullPos)
			AimPos={TGTpos[1],TGTpos[2],TGTpos[3]}
			AimTGTX,AimTGTY=G2CpsPit({AimPos[1]-HullPos[1],AimPos[2]-HullPos[2],AimPos[3]-HullPos[3]})
			AimOfstX=AimOfstX+LR*SlowAim*0.001
			AimOfstY=AimOfstY+UD*SlowAim*0.001
			--AimOfstG=L2G({AimOfstY,0,AimOfstX})
			--these to output
			--aimCps=AimTGTX+AimOfstG[3]
			--aimPit=AimTGTY+AimOfstG[1]
			aimCps=AimTGTX+AimOfstX
			aimPit=AimTGTY+AimOfstY
			AimPos=CpsPit2G(TGTDist,aimCps,aimPit)
			--aimStdX,aimStdY=L2AE(G2L({AimPos[1]-HullPos[1],AimPos[2]-HullPos[2],AimPos[3]-HullPos[3]}))
		else
			--general or stab
			AimOfstX,AimOfstY=0,0
			if Stab then
				mode=2
				--AimOfstG=L2G({-UD*SlowAim*0.001,0,LR*SlowAim*0.001})
				AimOfstX,AimOfstY=LR*SlowAim*0.001,UD*SlowAim*0.001
				if aimStdY+0.005>EleMax then AimOfstY=math.min(AimOfstY,0) end
				if aimStdY-0.005<EleMin then AimOfstY=math.max(AimOfstY,0) end
				--these to output
				--aimCps=aimCps+AimOfstG[3]
				--aimPit=aimPit+AimOfstG[1]
				aimCps=aimCps+AimOfstX
				aimPit=aimPit+AimOfstY
				AimPos=CpsPit2G(TGTDist,aimCps,aimPit)
				--aimStdX,aimStdY=L2AE(G2L({AimPos[1]-HullPos[1],AimPos[2]-HullPos[2],AimPos[3]-HullPos[3]}))
			else
				mode=1
				if isxlimit then
					aimStdX=MathClamp(Cps2Delta(aimStdX+LR*SlowAim*0.001,0),-xlimit,xlimit)
				else
					aimStdX=aimStdX+LR*SlowAim*0.001
				end
				aimStdY=MathClamp(aimStdY+UD*SlowAim*0.001,EleMin,EleMax)
				AimPos=R2G({TGTDist,aimStdX,aimStdY})
				aimCps,aimPit=PvtCps,PvtPit
			end
		end
	else
		mode=0
		aimStdX=0
		aimStdY=0
		AimPos=R2G({TGTDist,aimStdX,aimStdY})
		aimCps,aimPit=PvtCps,PvtPit
	end
	--reverse when xlimit
	conA=isxlimit and Cps2Delta(aimStdX,0)<TrtRot-0.49
	conB=isxlimit and Cps2Delta(aimStdX,0)>TrtRot+0.49
	if conA or conB then
		mode=0
	end
	--output for pivots
	if Is[3] then
		Is[3]=rstY
	end
	if mode<2 then
		deltCps=Cps2Delta(TrtRot,aimStdX)
		rstX=Pid(1,deltCps*P2,0,PN('pivot x p'),PN('pivot x i'),PN('pivot x d'),PN('pivot x p m'),PN('pivot x i m'),PN('pivot x d m'))
		--prevent spike
		rstY=aimStdY*4
	else
		deltCps=Cps2Delta(PvtCps,aimCps)
		rstX=ascps*PN('x stab')+Pid(2,deltCps*P2,0,PN('pivot x p'),PN('pivot x i'),PN('pivot x d'),PN('pivot x p m'),PN('pivot x i m'),PN('pivot x d m'))
		rstY=MathClamp(-aspit*PN('y stab')+Pid(3,PvtPit,aimPit,0,PN('pivot y i'),PN('pivot y d'),0,1,1),EleMin*4,EleMax*4)
		aimStdX=Cps2Delta(TrtRot,0)
		aimStdY=rstY/4
	end
	--x limit
	if isxlimit then
		if TrtRot+deltCps>xlimit then
			if TrtRot+deltCps>0.5 then
				rstX=-rstX
			else
				if TrtRot>xlimit then
					rstX=M.min(rstX,0)
				end
			end
		elseif TrtRot+deltCps<-xlimit then
			if TrtRot+deltCps<-0.5 then
				rstX=-rstX
			else
				if TrtRot<-xlimit then
					rstX=M.max(rstX,0)
				end
			end
		end
	end
	if isGPS then SN(6,1e4) else SN(6,0) end
	SN(3,rstX)
	SN(4,rstY)
	--output for static camera installed on hull
	SN(1,aimStdX*8)
	SN(2,aimStdY*8)
	--output hull-space angle in turn
	SN(9,aimStdX)
	SN(10,aimStdY)
	--
	--if isSpdPvt then
	--	PvtY=Pid(2,PvtPit,aimPit,0,PN('pivot y i'),PN('pivot y d'),0,1,1)
	--else
	--	PvtY=aimStdY
	--end
	--output for radar monitor
	tempX,tempY=0,MathClamp(MathFlr(2e3*rstY*0.25+500.5),0,999)
	SN(5,tempX*1000+tempY)
	--update status
	isLockO=TGTpos[1]~=0 and TGTpos[2]~=0
	--output for turrets
	SN(11,AimPos[1])
	SN(12,AimPos[2])
	SN(13,AimPos[3])
	--radar target vel
	SN(14,TGTvel[1])
	SN(15,TGTvel[2])
	SN(16,TGTvel[3])
	--wind
	WindDir=GN(12)
	WindStr=GN(13)
	HullV=Mv(tM(E2R(HullEu)),{GN(7),GN(9),GN(8)})
	WindV={WindStr*MathSin((WindDir-HullCps)*P2)-HullV[1],WindStr*MathCos((WindDir-HullCps)*P2)-HullV[2],0}
	--aim status
	SN(17,WindV[1])
	SN(18,WindV[2])
	SN(19,mode)
	SN(20,aimPit)
	SN(21,aimCps)
	SN(22,aimStdX)
	SN(23,aimStdY)
	SN(24,TGTDist)
	SN(25,GN(29))--trigger
	--to mng
	SN(7,HullCps)
	SN(8,GN(16))
end
Scr=screen
SetC=Scr.setColor
DTB=Scr.drawTextBox
DL=Scr.drawLine
function onDraw()
	mntX=Scr.getWidth()
	mntY=Scr.getHeight()
	SetC(22,222,22)
	x,y=MathFlr(mntX/2+0.5),MathFlr(mntY/2+0.5)
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
end