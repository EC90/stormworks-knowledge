-- source: steam id 3603910667 / vehicle.xml block#77
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
pN=property.getNumber
pB=property.getBool
M=math
abs=M.abs
sin=M.sin
cos=M.cos
tan=M.tan
sqrt=M.sqrt
asin=M.asin
atan=M.atan
exp=M.exp
floor=M.floor
pi=M.pi
pi2=M.pi*2
S=string
T=true
F=false

FlueRateBuf=0
FlueFilter={}
FlueLeakage=0
for i=1,pN("FilterLength") do
	FlueFilter[i]=0
end

function onTick()
	MaxFlue,FlueLevel,Speed=GN(1),GN(2),GN(3)
	if MaxFlue<1 then
		MaxFlue=1
	end
	Air,Flue,Tempture=0,0,-100
	for i=1,4 do
		Air=Air+GN(i*3+1)
		Flue=Flue+GN(i*3+2)
		if Tempture<GN(i*3+3) then
			Tempture=GN(i*3+3)
		end
	end
	if FlueRateBuf==0 then
		FlueRateBuf=abs(Flue)
	end
	Broken=GB(1) and GB(2)
	
	FlueRate=FlueLevel-FlueRateBuf
	FlueRateBuf=FlueLevel
	FlueDelta=-FlueRate-Flue
	
	table.insert(FlueFilter,FlueDelta)
	table.remove(FlueFilter,1)
	
	FlueLeakage=FlueLeakage+(FlueDelta-FlueFilter[1])/pN("FilterLength")
	
	FlueLeak=FlueLeakage>pN("LeakageThreshold")
	
	FlueScale=FlueLevel/MaxFlue
	if Flue<0.00001 then
		FlueTime=0
	else
		FlueTime=FlueLevel/Flue/60
	end
	
	SN(1,MaxFlue)
	SN(2,FlueLevel)
	SN(3,Tempture)
	SN(4,Air)
	SN(5,Flue)
	SN(6,FlueLeakage)
	SN(7,FlueScale)
	SN(8,FlueTime)
	
	SB(1,Broken)
	SB(2,FlueLeak)
end