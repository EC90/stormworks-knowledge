-- source: steam id 3444168361 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3444168361
x=0
s=property.getNumber("smoothing")
noDetectTick=0
resetXTick=3*60
function onTick()
	if input.getBool(1) then
		x=input.getNumber(1)*(1-s)+x*s
		noDetectTick=0
	else
		noDetectTick=noDetectTick+1
		if noDetectTick>resetXTick then
			x=0
		end
	end
	output.setNumber(1,x)
end