-- source: steam id 3603910667 / vehicle.xml block#165
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
expdelay=4.2

dietimer=0
expbuf=false
function onTick()
	--[[dis=GN(1)
	delta=((delay*(N/60-1)+dis)*N+delay*-N)*((120-N)/N)
	delay=delay*(N/60-1)+dis
	spd=delta
	SB(1,dis/spd<expdelay and dis~=0 and dis<20)
	expbuf=(dis/spd<expdelay and dis~=0 and dis<20) or expbuf
	if expbuf then
	dietimer=dietimer+1
	end
	
	if dietimer>30 then
	SN(1,1)
	else
	SN(1,0)
	end]]--
	SB(1,GN(2)>0.5)
end
	
function sgn(x)
	if x>0 then
	y=1
	else
	y=-1
	end
	return y
end