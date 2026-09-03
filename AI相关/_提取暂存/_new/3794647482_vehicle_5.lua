-- source: steam id 3794647482 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794647482
current = 0
initialized = false


function onTick()
	
	x = input.getNumber(1)
	z = input.getNumber(2)
	
	if not initialized then
		current = x
		initialized = true
	end
	
	if z < 1 then
		z = 1
	end
	
	base = 1 / z
	
	k = 1 - (1 - base) * (1 - base)
	
	current = current + (x - current) * k
	
	output.setNumber(1,current)
	
end