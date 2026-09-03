-- source: steam id 3261800786 / vehicle.xml block#13
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3261800786
--datalink3deleteWayP
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
M=math
isnearo=false
dlt=property.getNumber('Way Point Delete Threshold')
function onTick()
    sx,sy,sz=GN(2),GN(3),GN(4)
    wpx,wpy,wpz=GN(30),GN(31),GN(32)
    dist=M.sqrt((wpx-sx)^2+(wpy-sy)^2+(wpz-sz)^2)
    isnear=dist<dlt 
    if isnear and not isnearo then
        dltwp=true
    else
        dltwp=false
    end
    isnearo=isnear
    SB(1,dltwp)
end