-- source: steam id 3103568867 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3103568867
function onTick()
	Yaw = input.getNumber(1)
	Pitch = input.getNumber(2)
	
	output.setNumber(1, Yaw)
	output.setNumber(2, Pitch)
end
