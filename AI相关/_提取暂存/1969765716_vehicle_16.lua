-- source: steam id 1969765716 / vehicle.xml block#16
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
function onTick()
isP = input.getBool(1)
iX = input.getNumber(3)
iY = input.getNumber(4)

switch = isP and iPIR(iX,iY,0,0,32,8)
if switch and not switch_ then SWITCH = not SWITCH end
switch_ = switch
output.setBool(1,SWITCH)
end

function iPIR(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end