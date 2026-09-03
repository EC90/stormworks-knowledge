-- source: steam id 2743034790 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2743034790

Targetdir=0
BUTTPREST=0
function onTick()
Det=input.getBool(1)
NPR=input.getBool(2)
LPR=input.getBool(3)
SYS=input.getBool(4)
TSpeed=input.getNumber(7)
Dist=input.getNumber(1)
Azi=input.getNumber(2)
Ele=input.getNumber(3)
SWEEPIN=input.getNumber(5)
ZROT=input.getNumber(6)
SRROT=input.getNumber(8)
altspeed=input.getNumber(9)
relTPos=ZROT+Azi
Freigabe=Det
and Dist>80 and Dist<800 and SYS
if Freigabe then
onTarget=Azi<0.03 and Azi>-0.03
Targetdir=Azi/4+Targetdir
if onTarget then
CORR=TSpeed*Dist/200 else CORR=0
CORR2=altspeed*Dist/100 
end
TurretAngle=relTPos+CORR
Targetat=(Ele+CORR2)*4
fire=true
else Targetdir=SWEEPIN
TurretAngle=Targetdir
fire=false
end
output.setNumber(1,Targetdir)
output.setNumber(2,Targetat)
output.setNumber(3,TurretAngle)
output.setBool(3,fire)
end

function onDraw()
end