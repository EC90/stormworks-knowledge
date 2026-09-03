-- source: steam id 3074335771 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3074335771
baffles = property.getNumber("Baffles (total deg stern)")
function onTick()
	for i = 1, 13 do
		c = i * 2
		if math.abs(input.getNumber(c - 1)) < 0.5 - baffles / 720 then
			output.setNumber(c - 1, input.getNumber(c - 1))
			output.setNumber(c, input.getNumber(c))
			output.setBool(i, input.getBool(i))
		else
			output.setNumber(c - 1, 0)
			output.setNumber(c, 0)
			output.setBool(i, false)	
		end
	end	
end