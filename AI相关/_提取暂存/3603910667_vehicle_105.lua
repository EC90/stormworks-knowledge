-- source: steam id 3603910667 / vehicle.xml block#105
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
pi=M.pi
pi2=M.pi*2
floor=M.floor
T=true
F=false

timer=0
function onTick()
	chaff_on=F
	for a=1,5 do
		chaff_on=chaff_on or ( GN(12+(a-1)*4)%1*10>0.5 and GN(12+(a-1)*4)%1*10<1.5 )
	end
	if chaff_on and timer<300 then
		timer=timer+1
	else
		timer=0
	end
	if timer==1 then
		chaff=T
	else
		chaff=F
	end
	SB(1,chaff)
end