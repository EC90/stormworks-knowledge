-- source: steam id 3275884864 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3275884864
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Mb=M.abs
U=M.cos
Mf=M.floor
V=M.sin
Mr=M.sqrt
P=M.pi*2
function onTick()
	lr=GN(3)
	ud=GN(4)
	sA=GB(4)
	rdr=GB(5)
	stb=GB(6)
	if sA then a=1 else a=0 end
	if rdr then b=1 else b=0 end
	if stb then c=1 else c=0 end
	SN(1,Mf((lr*0.98+1)*50)*100000+Mf((ud*0.98+1)*50)*1000+a*100+b*10+c*1)
	if GB(2) then SN(2,9) elseif GB(3) then SN(2,1) else SN(2,5) end
end