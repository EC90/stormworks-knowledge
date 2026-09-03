-- source: steam id 3097129660 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
PN=property.getNumber
M=math
Ma=M.abs
Mf=M.floor
Mr=M.sqrt
O=M.cos
I=M.sin
pi=M.pi
P2=pi*2
T=table
SF=string.format
dd={}
db={0,0,0,0,0,0,0,0}
function onTick()
    chf=false
    for i=1,8 do
		d=GN(i*4-3)
		if d>25 and db[i]~=0 then
			dd[i]=dd[i]+(db[i]-d)
		else dd[i]=0
		end
		if dd[i]>10 then chf=true break end
		db[i]=d
    end
	SB(1,chf)
end