-- source: steam id 3097129660 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
t1,t2,t3={},{},{}
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
M=math
Mf=M.floor
function Av(n,v,t)
	table.insert(n,v) local s=0 if #n>t then for i=1,#n-t do table.remove(n,1) end end for i=1,#n do s=s+n[i] end return s/#n end
function onTick()
SN(1,Mf(Av(t1,GN(1)*60,30)))
SN(2,Mf(Av(t2,GN(2)*60,30)))
SN(4,Mf(Av(t3,GN(4),30)))
SN(3,GN(3))
end
