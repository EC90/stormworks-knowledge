-- source: steam id 3097129660 / vehicle.xml block#25
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
function onTick()
    mlk=0
    for i=1,8 do
        d,a,e=GN(i*4-3),GN(i*4-2),GN(i*4-1)
        if d>300 and d<2200 then
            if M.abs(a)<0.03 and M.abs(e)<0.03 then mlk=2 end
            if M.abs(a)<0.045 and M.abs(e)<0.045 and d<980 then mlk=1 end
            break
        end
    end
    SN(1,mlk)
	SB(1,mlk>0)
end