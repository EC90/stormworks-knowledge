-- source: steam id 3167674961 / vehicle.xml block#46
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
targetX = 0
targetY = 0
targetZ = 0
laserFreq = 0
previousLaunch = false
function onTick()
	launched = input.getBool(32)
	if launched and not previousLaunch then
		targetX,targetY,targetZ,laserFreq = input.getNumber(1),input.getNumber(2),input.getNumber(3),input.getNumber(4)
	end
	output.setBool(1,launched)
	output.setNumber(1,targetX)
	output.setNumber(2,targetY)
	output.setNumber(3,targetZ)
	output.setNumber(4,laserFreq)
	
	previousLaunch = launched
end
