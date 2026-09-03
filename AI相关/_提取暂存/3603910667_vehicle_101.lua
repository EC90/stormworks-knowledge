-- source: steam id 3603910667 / vehicle.xml block#101
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
F=false

function onTick()
SN(1,GN(13))
SN(2,GN(14))
SN(3,GN(15))
SN(4,GN(16))
SN(5,GN(17))
SN(6,GN(18))
end