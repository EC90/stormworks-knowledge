-- source: steam id 3444942572 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3444942572
frequency = 0
function onTick()
	on = input.getBool(20)
	if on and not prevOn then frequency = input.getNumber(20) end
	prevOn = on
	output.setNumber(1,frequency)
	
end

