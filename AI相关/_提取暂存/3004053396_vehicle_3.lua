-- source: steam id 3004053396 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3004053396
	i,m = input,math
	gn,gb = i.getNumber,i.getBool

function clamp(x,l,h) return m.min(h,m.max(x,l)) end

function onTick()

	magCount,trkX1,trkX2,trkY1,trkY2,trtCount = gn(1),gn(2),gn(3),gn(4),gn(5),gn(6)
	armA,armB = gb(6),gb(7)

	a,b = clamp(magCount-12,0,12),clamp(magCount,0,12)
	
end
	
S=screen
SC=S.setColor
DRF=S.drawRectF
DTX=S.drawText

function onDraw()



SC(11,11,11)
DRF(4,21.5,19,3)
DRF(4,25.5,19,3)
DRF(4,29.5,19,3)
DRF(4,33.5,19,3)
DRF(4,37.5,19,3)
DRF(4,41.5,19,3)
DRF(0,0.5,96,64)--bkgrnd
SC(0,0,0,20)
DRF(26,7.5,55,3)
DRF(26,56.5,55,3)
DRF(33,20.5,27,27)
DRF(66,20.5,27,27)
SC(52,52,52)
DRF(27,6.5,55,3)
DRF(27,55.5,55,3)

if a==0 then SC(255,0,0) else SC(0,255,0) end
DRF(34,19.5,27,27)--a
if b==0 then SC(255,0,0) else SC(0,255,0) end
DRF(67,19.5,27,27)--b


SC(255,255,255)

DTX(42,30,string.format("%02.0f",a))
DTX(75,30,string.format("%02.0f",b))

if trtCount>0 then
DRF(4,21.5,19,3)--missiles
else end
if trtCount>1 then
DRF(4,25.5,19,3)
else end
if trtCount>2 then
DRF(4,29.5,19,3)
else end
if trtCount>3 then
DRF(4,33.5,19,3)
else end
if trtCount>4 then
DRF(4,37.5,19,3)
else end
if trtCount>5 then
DRF(4,41.5,19,3)
else end

SC(0,0,0,20)
DRF(76-(trkX1*52),5.5,7,7)
DRF(76-(trkX2*52),54.5,7,7)


SC((trkY1*255),(trkY1*255),(trkY1*255))
DRF(77-(trkX1*52),4.5,7,7)
if armA then
	SC(0,0,0,20)
	DRF(75-(trkX1*52),13.5,9,5)
	SC((trkY1*255),(trkY1*255),(trkY1*255))
	DRF(76-(trkX1*52),12.5,9,5)
else end
SC((trkY2*255),(trkY2*255),(trkY2*255))
DRF(77-(trkX2*52),53.5,7,7)--track x pos
if armB then
	SC(0,0,0,20)
	DRF(75-(trkX2*52),48.5,9,5)
	SC((trkY2*255),(trkY2*255),(trkY2*255))
	DRF(76-(trkX2*52),47,9,5)
else end


end	

	