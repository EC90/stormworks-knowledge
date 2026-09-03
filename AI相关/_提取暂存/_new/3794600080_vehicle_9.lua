-- source: steam id 3794600080 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794600080
target = {}
dist = {}

function onTick()
	audio = input.getBool(19)

	rangeM = input.getNumber(9)*1000
	
	if audio then
		for i=1, 8 do
			target[i] = input.getBool(i)
			dist[i] = input.getNumber(i+9)
			if target[i] and dist[i] < rangeM and dist[i] ~= 0 then
				audioOut = true
			end
		end
		output.setBool(1, audioOut)
		audioOut = false
	end
end