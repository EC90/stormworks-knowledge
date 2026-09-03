-- source: steam id 2013584399 / vehicle.xml block#18
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2013584399
average = 0

-- Tick function that will be executed every logic tick

function onTick()
	alpha = input.getNumber(2)
	average = (1 - alpha)*average + alpha*input.getNumber(1)
	output.setNumber(1, average)		-- Write a number to the script's composite output
end
