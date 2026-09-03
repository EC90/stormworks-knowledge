-- source: steam id 3167674961 / vehicle.xml block#11
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
horizSensitivity = property.getNumber("Horizontal Sensitivity")
vertSensitivity = property.getNumber("Vertical Sensitivity")

function onTick()
	output.setNumber(1,0)
    output.setNumber(2,0)
	for i = 8, 1, -1 do
		if input.getBool(i) then
			xInput = input.getNumber(2+((i-1)*4))
			yInput = input.getNumber(3+((i-1)*4))
			distance = input.getNumber(1+((i-1)*4))
			if distance > 987 then
            	output.setNumber(1,xInput*horizSensitivity)
            	output.setNumber(2,yInput*vertSensitivity)
			end
			output.setNumber(5,xInput)
			output.setNumber(6,yInput)
			output.setNumber(3,distance)
            break
		end
	end
end