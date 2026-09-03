-- source: steam id 3167674961 / vehicle.xml block#40
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
function onTick()
	output.setNumber(1,0)
    output.setNumber(2,0)
	output.setNumber(3,0)
	for i = 8, 1, -1 do
		if input.getBool(i) then
            output.setNumber(1,input.getNumber(2+((i-1)*4)))
            output.setNumber(2,input.getNumber(3+((i-1)*4)))
			output.setNumber(3,input.getNumber(1+((i-1)*4)))
            break
		end
	end
end