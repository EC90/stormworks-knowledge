-- source: steam id 3789438208 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3789438208
S=screen
SC=S.setColor
DRF=S.drawRectF
DL=S.drawLine
DRF=S.drawRectF

function onTick()
	
c = input.getNumber(1)
r = input.getBool(1)
l = input.getBool(2)
end


function onDraw()


SC(255,89,0,150*c)
DRF(0,0.5,4,2)
DRF(0,2.5,2,2)
DRF(28,0.5,4,2)
DRF(30,2.5,2,2)
DRF(28,30.5,4,2)
DRF(30,28.5,2,2)
DRF(0,30.5,4,2)
DRF(0,28.5,2,2)
SC(255,89,0,100*c)
DRF(0,26.5,2,2)
DRF(2,28.5,2,2)
DRF(4,30.5,2,2)
DRF(26,30.5,2,2)
DRF(28,28.5,2,2)
DRF(30,26.5,2,2)
DRF(30,4.5,2,2)
DRF(28,2.5,2,2)
DRF(26,0.5,2,2)
DRF(0,4.5,2,2)
DRF(2,2.5,2,2)
DRF(4,0.5,2,2)
SC(255,89,0,50*c)
DRF(0,6.5,2,2)
DRF(2,4.5,2,2)
DRF(4,2.5,2,2)
DRF(6,0.5,2,2)
DRF(26,2.5,2,2)
DRF(28,4.5,2,2)
DRF(24,0.5,2,2)
DRF(30,6.5,2,2)
DRF(30,24.5,2,2)
DRF(28,26.5,2,2)
DRF(26,28.5,2,2)
DRF(24,30.5,2,2)
DRF(6,30.5,2,2)
DRF(4,28.5,2,2)
DRF(2,26.5,2,2)
DRF(0,24.5,2,2)
DRF(0,22.5,2,2)
DRF(30,22.5,2,2)
DRF(0,8.5,2,2)
DRF(30,8.5,2,2)
DRF(0,10.5,2,12)
DRF(30,10.5,2,12)
DRF(8,30.5,16,2)
DRF(8,0.5,16,2)
DRF(8,30.5,16,2)
DRF(8,0.5,16,2)
if l then
SC(255,168,0,255*c)
DRF(0,0.5,2,4)
DRF(2,0.5,2,2)
SC(255,168,0,200*c)
DRF(0,4.5,2,2)
DRF(2,2.5,2,2)
DRF(4,0.5,2,2)
end


if r then
SC(255,168,0,255*c)
DRF(28,0.5,4,2)
DRF(30,2.5,2,2)
SC(255,168,0,200*c)
DRF(26,0.5,2,2)
DRF(28,2.5,2,2)
DRF(30,4.5,2,2)
end
end