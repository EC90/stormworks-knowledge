-- source: steam id 3793369421 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793369421
function onTick()
	
	T = input.getNumber(1)
	if (T <= 1) and (T >= 0.1) then
	c = (c + 0.01) else
	c = (0)
	end
	if (c > 1) then
	c = 1
	end
	
	output.setNumber(1, c)

end
	
