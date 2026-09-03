-- source: steam id 3793328793 / vehicle.xml block#31
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793328793
i = 0
-- Tick function that will be executed every logic tick
function onTick()
	blinker = input.getBool(5)
	if blinker then
		if i == 30 then
			red = math.random()
			green = 1 - math.random()
			blue = math.abs(math.random() - 1)
		end
		i = (i+1)%31
	end
	output.setNumber(1, red)
	output.setNumber(2, green)
	output.setNumber(3, blue)
end