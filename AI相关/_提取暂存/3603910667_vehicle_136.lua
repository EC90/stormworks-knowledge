-- source: steam id 3603910667 / vehicle.xml block#136
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

delay=0
N=90
expdelay=5

timer=0

function onTick()
	slSP={GN(7),GN(9),GN(8)}
	dis=GN(13)
	--delta=((delay*(N/60-1)+dis)*N+delay*-N)*((120-N)/N)
	--delay=delay*(N/60-1)+dis
	--spd=delta
	spd=delay-dis
	delay=dis
	SB(1,dis/spd<expdelay and dis~=0 and dis<40 and GN(14)==0 and slSP[2]>100)
	
	--if GN(14)==0 then
	--timer=timer+1
	--end
end
	
function sgn(x)
	if x>0 then
	y=1
	else
	y=-1
	end
	return y
end