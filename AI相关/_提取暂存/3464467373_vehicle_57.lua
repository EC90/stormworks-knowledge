-- source: steam id 3464467373 / vehicle.xml block#57
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3464467373
--datalink3dataRecievingForMSL
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
M=math
Mb=M.abs
function Mf(x) return M.floor(x+0.5) end
mF=M.floor
P=M.pi*2
SLID={0,0,0,0,0}
Key=0
timer1=0
launch=false
parentID=0
target={0,0,0}
rtFreq=0
Freq=0
rt=false
function onTick()
	parent=GN(13)~=0
	if parent then
		SLID={GN(2),GN(3),GN(4),0,0}
		Key=GN(8)
		parentID=GN(13)
		target={GN(27),GN(28),GN(29)}
		timer1=0
	end
	Time=GN(9)
	mainFreq=mF(100+400*(M.sin(1000*Time+Key)+1))
	if timer1<120 and not parent then
		timer1=timer1+1
	end
	if timer1>10 then
		if SLID[1]~=0 then
			rtFreq=mainFreq+SLID[1]
			SLID[4]=SLID[2]
			SLID[5]=SLID[1]
		elseif SLID[3]~=0 then
			rtFreq=mainFreq+parentID
			SLID[4]=SLID[3]
			SLID[5]=parentID
		end
		Freq=rtFreq
	end
	--try rtFreq
	if timer1>11 and timer1<20 then
		if GN(17)~=0 then rt=true end
	end
	--fallback to mainFreq
	if timer1>20 then
		if rt then
			Freq=rtFreq
			if SLID[4]==mF(GN(20)/1e3) then
				target={GN(17),GN(18),GN(19)}
			end
		else
			Freq=mainFreq
			if GN(1)==SLID[5] then
				if SLID[4]==1 then
					target={GN(5),GN(6),GN(7)}
				else
					if SLID[4]==mF(GN(15)/1e5) then
						target={GN(10),GN(11),GN(12)}
					end
				end
			end
		end
	end
	SN(1,target[1])
	SN(2,target[2])
	SN(3,target[3])
	SN(4,GN(13))
	SN(32,Freq)
end