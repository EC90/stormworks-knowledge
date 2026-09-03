-- source: steam id 2232448349 / vehicle.xml block#30
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2232448349
i = 0
function onTick()
	Speed = input.getNumber(1)
 if (Speed > 1) then
if i ==0  then 
    FO = input.getNumber(2)  
end
if i ==60  then
	FL = input.getNumber(2)
    lkm3 = LKM(FL, FO, Speed)
    output.setNumber(1,lkm3)
    output.setNumber(2,(FL/lkm3))
end
i = (i + 1)%61
end
end
function LKM(fl2, fo2, speed2)
FU = (fo2-fl2)
LKM2 = (1000 / speed2) * FU
return LKM2
end
