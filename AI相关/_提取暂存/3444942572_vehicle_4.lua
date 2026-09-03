-- source: steam id 3444942572 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3444942572
password = 0
function onTick()
	on = input.getBool(20)
	if on and not prevOn then password = input.getNumber(21) end
	prevOn = on
	output.setNumber(1,password)
	
end

