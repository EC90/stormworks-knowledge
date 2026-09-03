-- source: steam id 3167674961 / vehicle.xml block#31
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
horizSensitivity = property.getNumber("Horizontal Sensitivity")
vertSensitivity = property.getNumber("Vertical Sensitivity")
releaseAlt = property.getNumber("Cluster Release Altitude")
launchCluster = false

function onTick()
	output.setNumber(1,0)
    output.setNumber(2,0)
	for i = 8, 1, -1 do
		if input.getBool(i) then
			xInput = input.getNumber(2+((i-1)*4))
			yInput = input.getNumber(3+((i-1)*4))
			distance = input.getNumber(1+((i-1)*4))
            output.setNumber(1,xInput*horizSensitivity)
            output.setNumber(2,yInput*vertSensitivity)
			if distance < releaseAlt then launchCluster = true end
            break
		end
	end
	
	output.setBool(1,launchCluster)
end