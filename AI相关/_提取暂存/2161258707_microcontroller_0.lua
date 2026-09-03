-- source: steam id 2161258707 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2161258707
function onTick()
	key = input.getNumber(32)
	
	m = input.getNumber(31) ~ key
	
	for i=1, 30 do
		number = input.getNumber((i + key) % 30 + 1) + m/i - m/6.6
		if input.getBool((i + key) % 30 + 1) then
			number = math.floor(number + 0.5)
		end
		output.setNumber(i, number)
	end
	
	output.setNumber(31, 0)	
	output.setNumber(32, 0)
end