-- source: steam id 3228447235 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3228447235
iB=input.getBool
iN=input.getNumber
oB=output.setBool
oN=output.setNumber
pB=property.getBool
pN=property.getNumber

sc=screen
sC=sc.setColor
dR=sc.drawRect
dRF=sc.drawRectF
dT=sc.drawText
fo=string.format

AUnt=pN("Unit of Altitude")
VUnt=pN("Unit of Velocity")
OIType=pN("Overlaied Image Type")
DpA=pN("Dot per Angle (pixel/deg)")
dHUD=pN("Distance between HUD and center of seat (m)")+0.066
EInt=pN("Elevation Interval (deg)")
BarR=24--(pixel), length of elevation bar
SpcR=12--(pixel), length of internal space of elevation bar
GapN=2--Number of gap in a elevation bar representing negative pitch
GapL=(BarR-SpcR)/(2*GapN+1)
PStl=pN("Pitch Style")
VStl=pN("Velocity Display Style")
SwSp=50--Criterion velocity for shitching FPM and VV when Velocity Display Style==3
DpS=pN("Dot per Speed (pixel/(m/s))")

OffW=pN("Monitor center horizontal offset (pxiel)")
OffH=pN("Monitor center vertical offset (pxiel)")
CalibMode=pB("Monitor center offset calibration mode")
Col0={pN("Indicator color R (0~255)"),pN("Indicator color G (0~255)"),pN("Indicator color B (0~255)")}

if CalibMode then CalibModeN=1 else CalibMode=0 end

SetTbl={Col0[1],Col0[2],Col0[3],AUnt,VUnt,OIType,DpA,dHUD,EInt,BarR,SpcR,GapN,GapL,PStl,VStl,DpS,SwSp,OffW,OffH,CalibModeN}

function onTick()
	SendCh=iN(1)
	if SendCh>0 and SendCh<=#SetTbl then
		act=true
		oN(1,SendCh)
		oN(2,SetTbl[SendCh])
	else
		act=false
	end
	
	oN(32,#SetTbl)
end

function onDraw()
	w=sc.getWidth()
	if act and false then
		dT(0,0,"Initializing params")
		dT(0,6,fo("%d",SendCh).."/"..fo("%d",#SetTbl).." done")
		dR(0,12,w-1,5)
		dRF(0,12,(w-1)*(SendCh/#SetTbl),5)
		dT(0,18,SetTbl[SendCh])
	end
end