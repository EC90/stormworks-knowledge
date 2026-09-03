-- source: steam id 3603910667 / vehicle.xml block#13
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
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
invert=PN('invert zoom control')
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
	zoomin=2.5+invert*0.5
	zoomout=2.5-invert*0.5
	if GB(zoomout) then
		SN(2,9)
	elseif GB(zoomin) then
		SN(2,1)
	else SN(2,5)
	end
end