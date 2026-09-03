-- source: steam id 2778980873 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2778980873
function onTick()
	Drive = input.getBool(1)
	Second = input.getBool(2)
	Third = input.getBool(3)
	Fourth = input.getBool(4)
	Reverse = input.getBool(5)
	
	CGear = 0
	if Drive then 
		CGear = 1
		end
	if Second then
		CGear = 2
		end
	if Third then
		CGear = 3
		end
	if Fourth then
		CGear = 4
		end
	if Reverse then
		CGear = 1
	end
	output.setNumber(1, CGear)
end
