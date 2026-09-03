-- source: steam id 3119724150 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3119724150
w,h,H,n=48,96,80,88
I=input
O=output
P=property
PN=P.getNumber
IN=I.getNumber
ON=O.setNumber
IB=I.getBool
OB=O.setBool
function onTick()
R1=PN("Scan Radar Range")
R2=PN("Static Radar Range")
MMLL=6
TLL=12
Active=IB(1)
Mod=IB(2)
Rng=IN(1)
Azm=IN(2)*32--Sapma
Ele=IN(3)*48--Ters orantl
MissileMin=IN(4)
MissileMax=IN(5)
Speed=IN(6)
if Mod then R=R2 else R=R1 end
if MissileMin==0 or MissileMax==0 then
    MissileMin=200
    MissileMax=2000
end
MinLine=math.floor((MissileMin/(R/H))+math.abs(Speed/H))
MaxLine=math.floor((MissileMax/(R/H)-math.abs(Azm))-Ele)
TargetL=math.floor(Rng/(R/H))
end
function onDraw()
	if Rng>0 and Active then
	screen.setColor(0,255,0)
	screen.drawLine(h-MMLL,n-MinLine,h,n-MinLine)
	screen.drawLine(h-MMLL,n-MaxLine,h,n-MaxLine)
	screen.drawLine(h-TLL,n-TargetL,h,n-TargetL)
	end
end