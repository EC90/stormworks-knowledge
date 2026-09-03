-- source: steam id 3262317900 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3262317900
--radar to gps for fcs rebuild
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
Math=math
MathAbs=Math.abs
function MathRnd(f)
	return Math.floor(f+0.5)
end
MathFlr=Math.floor
MathSqr=Math.sqrt
MathCos=Math.cos
MathSin=Math.sin
pi=Math.pi
P2=pi*2
Tbl=table
T000={0,0,0}
function MathClamp(v,min,max)
	return Math.max(min,Math.min(v,max))
end
function Avrg(tbl,value,time)
	time=Math.max(MathRnd(time),1)
	Tbl.insert(tbl,value)
	local sum=0
	if #tbl>time then
		local delete=#tbl-time
		for i=1,delete do
			Tbl.remove(tbl,1)
			break
		end
	else
		time=#tbl
	end
	for i=1,time do
		sum=sum+tbl[i]
	end
	return sum/time
end
function Dist2Turn(Dist,Delta)
	return Math.atan(Delta,Dist)/P2
end
function E2R(e)
	local x,y,z=e[1],e[2],e[3]
	return {{MathCos(y)*MathCos(z),MathCos(x)*MathCos(y)*MathSin(z)+MathSin(x)*MathSin(y),MathSin(x)*MathCos(y)*MathSin(z)-MathCos(x)*MathSin(y)},{-MathSin(z),MathCos(x)*MathCos(z),MathSin(x)*MathCos(z)},{MathSin(y)*MathCos(z),MathCos(x)*MathSin(y)*MathSin(z)-MathSin(x)*MathCos(y),MathSin(x)*MathSin(y)*MathSin(z)+MathCos(x)*MathCos(y)}}
end
function tM(e)
	local k={{},{},{}}
	for i=1,3 do
		for j=1,3 do
			k[i][j]=e[j][i]
		end
	end
	return k
end
function Mv(m,u)
	local output={}
	for i=1,3 do
		local temp=0
		for j=1,3 do
			temp=temp+m[j][i]*u[j]
		end
		output[i]=temp
	end
	return output
end
function R2G(d)
	local k=Mv(tM(E2R(SelfEul)),{d[1]*MathCos(d[3]*P2)*MathSin(d[2]*P2),d[1]*MathCos(d[3]*P2)*MathCos(d[2]*P2),d[1]*MathSin(d[3]*P2)})
	return {k[1]+SelfPos[1],k[2]+SelfPos[2],k[3]+SelfPos[3]}
end
function G2L(O)
	return Mv(E2R(SelfEul),{O[1]-SelfPos[1],O[2]-SelfPos[2],O[3]-SelfPos[3]})
end
function L2AE(P)
	local f,j,n=P[1],P[2],P[3]
	return Math.atan(f,j),Math.atan(n,j)
end
function CompareAE(a,b)
	return MathAbs(a.rdr[2])+MathAbs(a.rdr[3]-ViewY)<MathAbs(b.rdr[2])+MathAbs(b.rdr[3]-ViewY)
end
function Dst(a,b)
	return MathSqr((a[1]-b[1])^2+(a[2]-b[2])^2+(a[3]-b[3])^2)
end
TGT={}
NewID=1
MergeDist=PN('merge dist')
KeyLockO=0
AimID=0
AimWait=-1
ViewX=0
ViewY=0
--delay test
cnt=0
timeE=0
timeR=0
--end
function onTick()
	if GB(4) then
		Slow=2
	else
		Slow=1
	end
	AvrgT=PN('average ticks')*Slow
	VelT=PN('v ticks')*Slow
	KeyLock=GB(1)
	KeyRdr=GB(5)
	LsrD=GN(32)
	SelfPos={GN(4),GN(8),GN(12)}
	SelfEul={GN(16),GN(20),GN(24)}
	--delayTest
	if GN(4)~=0 or GN(1)~=0 then cnt=cnt+1 end
	if GN(4)~=0 and timeE==0 then timeE=cnt end
	if GN(1)~=0 and timeR==0 then timeR=cnt end
	--test end
	if #TGT>0 then
		for i=1,#TGT do
			if TGT[i].life>10 then
				Tbl.remove(TGT,i)
				break
			end
		end
	end
	for inputN=1,8 do
		if GN(4*inputN-3)>25 then
			same=0
			tempTGT={}
			tempTGT.rdr={GN(4*inputN-3),GN(4*inputN-2),GN(4*inputN-1)}
			tempTGT.pos=R2G(tempTGT.rdr)
			if #TGT>0 then
				for TGTn=1,#TGT do
					DeltaRdr={}
					for xyz=1,3 do
						DeltaRdr[xyz]=MathAbs(TGT[TGTn].rdr[xyz]-tempTGT.rdr[xyz])
					end
					conA=DeltaRdr[2]<0.002+Dist2Turn(TGT[TGTn].rdr[1],MergeDist+TGT[TGTn].va)
					conB=DeltaRdr[3]<0.002+Dist2Turn(TGT[TGTn].rdr[1],MergeDist+TGT[TGTn].va)
					conC=DeltaRdr[1]<0.02*TGT[TGTn].rdr[1]+MergeDist+TGT[TGTn].va
					if conA and conB and conC then
						Tbl.insert(TGT[TGTn].pb,tempTGT.pos)
						TGT[TGTn].life=0
						same=0
						break
					else
						same=1
					end
				end
			else
				same=1
			end
			if same>0 then
				tempTGT.pb={tempTGT.pos}
				tempTGT.guess=tempTGT.pos
				tempTGT.bfr={}
				tempTGT.vel=T000
				tempTGT.va=0
				tempTGT.vb={{0},{0},{0}}
				tempTGT.life=0
				tempTGT.spl=1
				tempTGT.id=NewID
				NewID=NewID+1
				Tbl.insert(TGT,tempTGT)
			end
		end
	end
	if #TGT>0 then
		for CurTGT=1,#TGT do
			if TGT[CurTGT].life==0 then
				--SplS=samples
				SplS=#TGT[CurTGT].pb
				if SplS>1 then
					SumX,SumY,SumZ=0,0,0
					for pbn=1,SplS do
						SumX=SumX+TGT[CurTGT].pb[pbn][1]
						SumY=SumY+TGT[CurTGT].pb[pbn][2]
						SumZ=SumZ+TGT[CurTGT].pb[pbn][3]
					end
					Tbl.insert(TGT[CurTGT].bfr,{SumX/SplS,SumY/SplS,SumZ/SplS})
				else
					Tbl.insert(TGT[CurTGT].bfr,TGT[CurTGT].pb[1])
				end
				MergedXYZ=TGT[CurTGT].bfr[#TGT[CurTGT].bfr]
				MergedA,MergedE=L2AE(G2L(MergedXYZ))
				--update latest rdr
				TGT[CurTGT].rdr={Dst(MergedXYZ,SelfPos),MergedA/P2,MergedE/P2}
				TGT[CurTGT].pb={}
				SplS=#TGT[CurTGT].bfr
				if SplS>AvrgT then
					for t=1,SplS-AvrgT do
						Tbl.remove(TGT[CurTGT].bfr,1)
					end
				end
				SplS=#TGT[CurTGT].bfr
				SplCal=MathClamp(MathRnd(TGT[CurTGT].rdr[1]/2000*AvrgT),1,SplS-1)
				TGT[CurTGT].spl=SplCal
				--cal velocity and guess pos when sample count>2
				if SplS>2 then
					SumXYZ=T000
					for SplSn=SplS,SplS-SplCal+1,-1 do
						for xyz=1,3 do
							SumXYZ[xyz]=SumXYZ[xyz]+TGT[CurTGT].bfr[SplSn][xyz]
						end
					end
					newPos={}
					TGT[CurTGT].guess={}
					for xyz=1,3 do
						newPos[xyz]=TGT[CurTGT].pos[xyz]
						TempXYZ=SumXYZ[xyz]/SplCal
						TGT[CurTGT].pos[xyz]=TempXYZ
						AvrgVelXYZ=Avrg(TGT[CurTGT].vb[xyz],SumXYZ[xyz]/SplCal-newPos[xyz],VelT)
						TGT[CurTGT].vel[xyz]=AvrgVelXYZ
						TGT[CurTGT].guess[xyz]=TempXYZ+AvrgVelXYZ*(TGT[CurTGT].spl+5)*0.5
					end
					TGT[CurTGT].va=MathSqr(TGT[CurTGT].vel[1]^2+TGT[CurTGT].vel[2]^2+TGT[CurTGT].vel[3]^2)
				else
					TGT[CurTGT].pos=TGT[CurTGT].bfr[SplS]
					TGT[CurTGT].guess=TGT[CurTGT].pos
				end
			end
			TGT[CurTGT].life=TGT[CurTGT].life+1
		end
	end
	TGTS=TGT
	if #TGTS>1 then
		Tbl.sort(TGTS,CompareAE)
	end
	if KeyLock and LsrD~=0 and LsrD~=4000 and not KeyRdr then
		LsrPos=R2G({LsrD,0,0})
		SN(1,LsrPos[1])
		SN(2,LsrPos[2])
		SN(3,LsrPos[3])
	else
		SN(1,0)
		SN(2,0)
		SN(3,0)
	end
	if #TGTS>0 then
		if KeyLock and not KeyLockO then
			if AimID==0 then
				AimID=TGTS[1].id
				AimWait=-1
			else
				AimID=0
			end
		end
		if AimID>0 then
			TGTnum=0
			for i=1,#TGT do
				if TGT[i].id==AimID then
					TGTnum=i
					break
				end
			end
			if TGTnum~=0 then
				for i=1,3 do
					SN(i,TGT[TGTnum].guess[i])
					SN(3+i,TGT[TGTnum].vel[i]*Math.max(AimWait,0))
				end
			else
				AimWait=-1
				AimID=0
			end
		end
	else
		AimID=0
	end
	KeyLockO=KeyLock
	AimWait=Math.min(AimWait+1/50,1)
	--from pivot
	fromPVT=GN(28)
	zoom=2^(fromPVT%10)/4
	fov=P2*45.9/360/zoom
	--1=0.125turn
	ViewX=(MathFlr(fromPVT/1e4)-500)/4000
	ViewY=(MathFlr(fromPVT%1e4/10)-500)/4000
end
Scr=screen
SetC=Scr.setColor
DrawRect=Scr.drawRect
DrawText=Scr.drawText
DrawLine=Scr.drawLine
function drawIcon(x,y,angOfst)
	for i=1,4 do
		ang=(i+0.5*angOfst)*pi/2
		DrawLine(x+4*MathSin(ang),y+4*MathCos(ang),x+3*MathSin(ang),y+3*MathCos(ang))
	end
end
function onDraw()
	ScrW=Scr.getWidth()
	ScrH=Scr.getHeight()
	drawX,drawY=0,0
	SetC(22,222,22)
	if #TGTS>0 then
		for i=1,#TGTS do
			TGTa,TGTe=L2AE(G2L(TGTS[i].guess))
			TGTa,TGTe=TGTa-ViewX*P2,TGTe-ViewY*P2
			drawX,drawY=MathRnd(ScrW/2+ScrW*TGTa/(fov*ScrW/ScrH)),MathRnd(ScrH/2-ScrH*TGTe/fov)
			if AimID==0 and i==1 or TGTS[i].id==AimID then
				DrawText(drawX-6,drawY-11,string.format('%3.0f',TGTS[i].va*60))
			end
			if TGTS[i].id==AimID then
				SetC(222,22,22)
				drawIcon(drawX,drawY,0)
			else
				SetC(22,222,22)
				drawIcon(drawX,drawY,1)
			end
		end
	end
	--delayTest
	--DrawText(12,12,timeE)
	--DrawText(12,18,timeR)
	--test end
end