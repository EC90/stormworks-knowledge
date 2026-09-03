-- source: steam id 2161259069 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2161259069
function onTick()
	key = input.getNumber(32)

	m = math.floor(math.random(10000,100000))
	for i=1, 30 do
		it = ((i + key) % 30) + 1
		output.setNumber(it, input.getNumber(i) + m/6.6 - m/i)
		output.setBool(it, input.getNumber(i) == math.floor(input.getNumber(i)))
	end
	output.setNumber(31, m ~ key)
end