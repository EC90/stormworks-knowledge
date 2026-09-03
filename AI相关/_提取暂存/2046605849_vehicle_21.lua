-- source: steam id 2046605849 / vehicle.xml block#21
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2046605849
-- Set our desired heading to 0 to start with
desiredHeading = 0

-- Tick function that will be executed every logic tick
function onTick()

	-- Read all our inputs and assign them to variables
	currentHeading = input.getNumber(1)
	systemEnabled  = input.getBool(2)
	justToggledOn  = input.getBool(3)
	justToggledOff = input.getBool(4)
	adjustLeft     = input.getBool(5)
	adjustRight    = input.getBool(6)
	
	-- If our system was just enabled, set our new desired
	-- heading to our current heading
	if (systemEnabled and justToggledOn)
	then 
		desiredHeading = currentHeading
	end
	
	-- If our system was just disabled, set our new desired
	-- heading back to 0
	if (not systemEnabled and justToggledOff)
	then 
		desiredHeading = 0
	end
	
	-- If we are recieving an input to adjust our heading right,
	-- then subtract one degree from our desired heading
	if (systemEnabled and adjustRight)
	then 
		desiredHeading = desiredHeading - 1
		-- Compensate for compass wrap. If we go below -180,
		-- we need to start back at 180 instead of -181
		if (desiredHeading < -180)
		then
			desiredHeading = 180
		end
	end
	
	-- If we are recieving an input to adjust our heading left,
	-- then add one degree from our desired heading
	if (systemEnabled and adjustLeft)
	then
		desiredHeading = desiredHeading + 1
		-- Compensate for compass wrap. If we go above 180,
		-- we need to start back at -179 instead of 181
		if (desiredHeading >= 180)
		then
			desiredHeading = -179
		end
	end
	
	-- Get our difference between our actual heading and our desired heading
	headingError = desiredHeading - currentHeading
	
	-- This logic corrects for compass wrap
	if(headingError > 180)
	then
		currentHeading = currentHeading + 360
	elseif(headingError < -180)
	then
		currentHeading = currentHeading - 360
	end
	
	output.setNumber(1, desiredHeading)		-- Write a number to the script's composite output
	output.setNumber(2, currentHeading)		-- Write a number to the script's composite output
end