-- source: steam id 2213181424 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
function onTick()
	open = input.getBool(1)			 -- Read the first number from the script's composite input
	
if open then
state = 0
elseif not open then
state = -1
end

output.setNumber(1,state )		-- Write a number to the script's composite output
end

