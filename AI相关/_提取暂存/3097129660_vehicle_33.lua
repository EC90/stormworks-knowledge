-- source: steam id 3097129660 / vehicle.xml block#33
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
GB=input.getBool
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
disto=0
cnt=0
isTgt=false
function onTick()
    dist=GN(1)
    if isTgt and dist==0 and disto<30 and disto~=0 then vt=true else vt=false end 
    isTgt=dist~=0
    if dist<200 and isTgt then
        cnt=cnt+1
    end
    if cnt>30 then isNear=true else isNear=false end
    ddist=dist-disto
    if isTgt and ddist<0 and ddist>-1 and dist<30 then isImp=true else isImp=false end
    disto=dist
    fuse=isImp or vt
    SB(1,fuse)
end
