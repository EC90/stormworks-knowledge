-- source: steam id 3603910667 / vehicle.xml block#38
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
pN=property.getNumber
pB=property.getBool
M=math
abs=M.abs
sin=M.sin
cos=M.cos
tan=M.tan
sqrt=M.sqrt
asin=M.asin
acos=M.acos
atan=M.atan
exp=M.exp
pi=M.pi
pi2=M.pi*2
floor=M.floor
T=true
F=false

tgt_id=1
weapon_id=1

function onTick()
	for i=1,8 do
		if GB(i) then
			tgt_id=i
		end
	end
	for i=9,12 do
		if GB(i) then
			weapon_id=i-8
		end
	end
	SN(1,tgt_id)
	SN(2,weapon_id)
	SB(1,GB(13))
end
S=screen
SC=S.setColor
DL=S.drawLine
DR=S.drawRect
DF=S.drawRectF
DT=S.drawText
function onDraw()
	
end
	
function clamp0(x)
	if x<0 then x=0 end
	if x>1 then x=1 end
	return x
end