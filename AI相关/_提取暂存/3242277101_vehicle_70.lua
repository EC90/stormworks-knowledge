-- source: steam id 3242277101 / vehicle.xml block#70
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3242277101
--gps to ad
GetNum=input.getNumber
GetBool=input.getBool
SetNum=output.setNumber
b8=output.setBool
ProptNum=property.getNumber
Math=math
MathAtan=Math.atan
MathAbs=Math.abs
MathCos=Math.cos
MathFlr=Math.floor
MathSin=Math.sin
MathSqrt=Math.sqrt
Pi2=Math.pi*2
function L2AE(e)
	return MathAtan(e[1],e[2])/Pi2, MathAtan(e[3],MathSqrt(e[1]^2+e[2]^2))/Pi2
end
function MathClamp(u,p,O)
	return Math.max(Math.min(O,u),p)
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
function onTick()
	SelfPos={GetNum(3),GetNum(4),0}
	TGTpos={GetNum(1),GetNum(2),0}
	AP=TGTpos[1]~=0 and TGTpos[2]~=0
	if AP then
		AimTGTX,AimTGTY=L2AE({TGTpos[1]-SelfPos[1],TGTpos[2]-SelfPos[2],TGTpos[3]-SelfPos[3]})
		ado=Pid(1,Cps2Delta(-GetNum(5),AimTGTX)*Pi2,0,GetNum(6),GetNum(7),GetNum(8),1,0.2)
	else
		ado=0
	end
	SetNum(1,-ado)
end