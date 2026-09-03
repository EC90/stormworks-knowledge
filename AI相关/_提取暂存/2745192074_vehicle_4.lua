-- source: steam id 2745192074 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2745192074
function onTick()
	Yaw = input.getNumber(1)
	Pitch = input.getNumber(2)
	
	output.setNumber(1, Yaw)
	output.setNumber(2, Pitch)
end
