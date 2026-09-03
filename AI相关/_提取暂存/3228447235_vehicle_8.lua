-- source: steam id 3228447235 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3228447235
iB=input.getBool
iN=input.getNumber
oB=output.setBool
oN=output.setNumber
m=math
pi=m.pi
pi2=2*pi
rads=pi/180
s=m.sin
c=m.cos
t=m.tan

pN=property.getNumber
SSw=pN("Sweep Speed (deg/s)")*rads/60	--rad/tick
HSMin=pN("Min Horizontal Sweep Angle (deg)")*rads	--rad
HSMax=pN("Max Horizontal Sweep Angle (deg)")*rads	--rad
VSMin=pN("Min Vertical Sweep Angle (deg)")*rads		--rad
VSMax=pN("Max Vertical Sweep Angle (deg)")*rads		--rad
NVSw=pN("Number of Horizontal Sweep Level")
RType=pN("Radar Mode")
if RType==0     then isSR,isTR=true,false
elseif RType==1 then isSR,isTR=true,true
elseif RType==2 then isSR,isTR=false,true
else isSR,isTR=false,false
end
function distV(V1,V2)
	_=0
	for i=1,3 do
		_=_+(V1[i]-V2[i])^2	
	end
	return _^0.5
end
function PolToOrth(r,a,e)
	v={r*s(a)*c(e),r*c(a)*c(e),r*s(e)}
	return v
end
function OrthToPol(v)
	r=distV(v,{0,0,0})
	a=at(v[1],v[2])
	e=as(v[3]/r)
	return r,a,e
end
function Mv(M,v)
	V={}
	for i=1,3 do
		_=0
		for j=1,3 do
			_=_+M[j][i]*v[j]
		end
		V[i]=_
	end
	return V
end
function inPro(u,v)
	_=0
	for i=1,3 do
		_=_+u[i]*v[i]
	end
	return _
end
function outPro(u,v)
	w={}
	w[1]=u[2]*v[3]-u[3]*v[2]
	w[2]=u[3]*v[1]-u[1]*v[3]
	w[3]=u[1]*v[2]-u[2]*v[1]
	return w
end
function AngleToBasis(Q)
	ex={c(Q[1])*s(-Q[2]),c(Q[1])*c(-Q[2]),s(Q[1])}
	ey={c(Q[3])*s(-Q[4]),c(Q[3])*c(-Q[4]),s(Q[3])}
	ez=outPro(ex,ey)
	if m.abs(inPro(ex,ey))>0.1 then er=true else er=false end
	return {ex,ey,ez},er
end
function clamp(x,min,Max)
	if x<min or x>Max then clamped=true else clamped=false end
	return m.min(Max,m.max(min,x)),clamped
end
PO,PT,PR={},{},{}
SweepO=false
wait=0
TAL,TEL=0,0
TALO,TELO=0,0
LocalTargetRange=1000
WaitTimeCoef=0.5

function onTick()
	--Data Input
	for i=1,3 do
		PO[i]=iN(i+24)	--25,26,27
		PT[i]=iN(i)	--1,2,3
		PR[i]=PT[i]-PO[i]
	end
	if distV(PT,{0,0,0})==0 then isEXT=false else isEXT=true end
	QO={iN(28)*pi2,iN(29)*pi2,iN(30)*pi2,iN(31)*pi2}
	es,QError=AngleToBasis(QO)
	Act=iN(32)

	OUT={}
	Sweep=false
	test=false
	if Act==1 and isTR and isEXT then
		for i=1,3 do
			OUT[i]=PT[i]
		end
	elseif Act==1 and isSR then
		Sweep=true
		if SweepO then
			if wait==0 then
				test=true
				TAL=TAL+SwDir*SSw
				if (TAL>HSMax and SwDir>0) or (TAL<HSMin and SwDir<0) then
					if m.abs(TAL)>pi then
						TAL=TAL-(TAL/m.abs(TAL))*pi2
						if CurNVSw==NVSw then
							wait=TEL-VSMin/SSw*WaitTimeCoef
							CurNVSw=1
						else
							wait=(VSMax-VSMin)/m.max(NVSw-1,1)/SSw*WaitTimeCoef
							CurNVSw=m.min(CurNVSw+1,NVSw)
						end
					else
						if SwDir>0 then
							TAL=HSMax
						elseif SwDir<0 then
							TAL=HSMin
						end
						SwDir=-SwDir
						if CurNVSw==NVSw then
							wait=m.max(TAL-HSMin,TEL-VSMin)/SSw*WaitTimeCoef
							CurNVSw=1
							SwDir=1
							TAL=HSMin
						else
							wait=(VSMax-VSMin)/m.max(NVSw-1,1)/SSw*WaitTimeCoef
							CurNVSw=m.min(CurNVSw+1,NVSw)
						end
					end
				end
				TEL=VSMin+(VSMax-VSMin)*(CurNVSw-1)/m.max(NVSw-1,1)
			end
		else
			CurNVSw=1
			SwDir=1
			TAL,TEL=HSMin,VSMin
		end
		Tv=PolToOrth(LocalTargetRange,clamp(TAL,TALO-SSw,TALO+SSw),clamp(TEL,TELO-SSw,TELO+SSw))
		TV=Mv(es,Tv)
		for i=1,3 do
			OUT[i]=TV[i]+PO[i]
		end
		wait=m.max(wait-1,0)
	else
		for i=1,3 do
			OUT[i]=0
		end
	end

	--Output
	for i=1,3 do
		oN(i,OUT[i])
	end

	--Update
	SweepO=Sweep
	TALO,TELO=TAL,TEL
end

function onDraw()
	screen.drawText(0,0,"TAL "..TAL/rads)
	screen.drawText(0,7,"TEL "..TEL/rads)
	screen.drawText(0,14,"CurNVSw "..CurNVSw)
	screen.drawText(0,21,"SwDir "..SwDir)
	screen.drawText(0,28,"SSw "..SSw)
	screen.drawText(0,35,"wait "..wait)
	if Search then screen.drawText(0,42,"search") end
	if test then screen.drawText(0,49,"test") end
end