-- source: steam id 3794647482 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794647482
m=math
sin=m.sin
cos=m.cos
tan=m.tan
asin=m.asin
atan=m.atan
abs=m.abs
flr=m.floor
T=table
tup=T.unpack
tin=T.insert
pi=m.pi
pi2=pi*2
pN=property.getNumber
pB=property.getBool
iN=input.getNumber
iB=input.getBool
s=screen
Line=s.drawLine
Text=s.drawText
RF=s.drawRectF
TF=s.drawTriangleF
DC=s.drawCircle
DR=s.drawRect
Color=s.setColor
style=pN("Style")
dis=pN("Display Distance")
function onTick()
wx={}
wy={}
lock={}

	for i=1,8 do
		if iB(i) then
output.setNumber(i*2-1,iN((i-1)*4+2)*pi2)
output.setNumber(i*2,iN((i-1)*4+3)*pi2)
		else
output.setNumber(i*2-1,999)
output.setNumber(i*2,999)
		end
	end
end