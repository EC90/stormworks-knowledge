-- source: steam id 2933258043 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2933258043
PY = 0
PY = PY
function onTick()
	LY = input.getNumber(10)
	LX = input.getNumber(9)
	FOV = input.getNumber(4)
	CTRL = input.getBool(1)
	LY = math.min(math.max(LY,-0.048),0.048)
	FOV = math.min(math.max(FOV,0.144),0.72)
	LX = LX/(FOV*10)
	LX = math.min(math.max(LX,-0.048),0.048)
		
if CTRL then
PY = PY+LY/12/(FOV*10)
end
PY = math.min(math.max(PY,-0.11),0.08)
	
	output.setNumber(10, PY)
	if CTRL then
	output.setNumber(9, LX)
	end
	output.setNumber(4, FOV)			
end


	

