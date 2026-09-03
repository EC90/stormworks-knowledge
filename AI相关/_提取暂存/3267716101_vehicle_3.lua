-- source: steam id 3267716101 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3267716101
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
isAK=PN('key binding')
kSA=PN('Slow Aim Swtich Key')
kRDR=PN('radar switch key')
kStb=PN('stabilizer switch key')
if invert < 1 then
	kZO=PN('Zoom In')
	kZI=PN('Zoom Out')
else
	kZI=PN('Zoom In')
	kZO=PN('Zoom Out')
end
function onTick()
	lr=GN(1+isAK)
	ud=GN(2+isAK)
	sA=GB(kSA)
	rdr=GB(kRDR)
	stb=GB(kStb)
	if sA then a=1 else a=0 end
	if rdr then b=1 else b=0 end
	if stb then c=1 else c=0 end
	SN(1,Mf((lr*0.98+1)*50)*100000+Mf((ud*0.98+1)*50)*1000+a*100+b*10+c*1)
	if GB(kZI) then
		SN(2,9)
	elseif GB(kZO) then
		SN(2,1)
	else SN(2,5)
	end
end