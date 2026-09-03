-- source: steam id 3603910667 / vehicle.xml block#156
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
acos=M.acos
atan=M.atan
exp=M.exp
pi=M.pi
pi2=M.pi*2

subfilter=0

delay={0,0,0}

function onTick()
SB(1,GN(1)~=0)
SN(1,GN(1)*1.5)
SN(2,GN(2)*1.5)
end
	
function sgn(x)
	if x>0 then
	y=1
	else
	y=-1
	end
	return y
end