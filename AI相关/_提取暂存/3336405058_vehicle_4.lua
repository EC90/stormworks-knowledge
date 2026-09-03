-- source: steam id 3336405058 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3336405058
--PYO's ANTICAUSAL FCS HAC Build Accuracy Data
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
cnt1=-200
cnt2=1
SF=string.format
PN=property.getNumber
M=math
Mb=M.abs
Mc=M.cos
Mf=M.floor
Ms=M.sin
Mr=M.sqrt
P=M.pi*2
ofst={500500}
function onTick()
	if loaded and not GB(1) then cnt1=0 cnt2=cnt2+1 end
	loaded=GB(1)
	if loaded then add=1e6 else add=0 end
	if cnt2>#ofst then out=500500 else out=ofst[cnt2]end
	SN(1,out+add)
end