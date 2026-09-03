-- source: steam id 3097129660 / vehicle.xml block#24
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
S=screen
SC=S.setColor
DT=S.drawText
DTF=S.drawTriangleF
M=math
Mf=M.floor
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
function onTick()
IR=GB(1)
ad=GN(1)
ws=GN(2)
ud=GN(4)
lookx=GN(9)
looky=GN(10)
w=96 h=96
puxl=23+40*lookx
puxr=w-24+40*lookx
puy=35-33.7*looky
pdxl=34+40*lookx
pdxr=w-35+40*lookx
pdy=60-53*looky
SN(1,0.0000644-0.792*lookx+0.502*lookx^2)
SN(2,-0.058-1.69*looky+1.83*looky^2)
end
function onDraw()
SC(0,0,0,128)
S.drawClear()
if not IR then
SC(0,0,0)
DTF(puxl,puy,puxr,puy,pdxl,pdy)
DTF(puxr,puy,pdxl,pdy,pdxr,pdy)
end
--SC(22,222,22)
--DT(40,32,0.001*Mf(lookx*1000))
--DT(40,38,0.001*Mf(looky*1000))
--DT(40,44,0.001*Mf(ad*1000))
--DT(40,50,0.001*Mf(ws*1000))
--DT(40,56,0.001*Mf(ud*1000))
end