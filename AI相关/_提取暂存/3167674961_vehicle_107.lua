-- source: steam id 3167674961 / vehicle.xml block#107
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
sensitivity = property.getNumber("Radar Sensitivity")
distdive = property.getNumber("Distance To Dive")

function onTick()	
	output.setNumber(1,0)
    output.setNumber(2,0)
		for i = 8, 1, -1 do
			if input.getBool(i) then
				xInput = input.getNumber(2+((i-1)*4))
				yInput = input.getNumber(3+((i-1)*4))
				distance = input.getNumber(1+((i-1)*4))
        		output.setNumber(1,xInput*sensitivity)
        		output.setNumber(2,yInput*sensitivity)
            break
		end
	end
end
	