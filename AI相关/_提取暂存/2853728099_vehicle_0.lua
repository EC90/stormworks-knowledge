-- source: steam id 2853728099 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2853728099
clicks = {600,600,600,600,600,600}
tickCounter = 0
lastTick = 0

avg = 220
buttonPressed = false

function onTick()
	tickCounter = tickCounter + 1
	value = input.getBool(1)
	
	output.setBool(1,false)
	
	if getAverage() < avg then
		output.setBool(1,true)
	end
	
	if value == true and buttonPressed == false then 
		buttonPressed = true
		timeSinceLastTick = tickCounter - lastTick
		lastTick = tickCounter
		if timeSinceLastTick <= 3 then timeSinceLastTick=600 end 
		enqueue(timeSinceLastTick)
	else
		buttonPressed = false
	end
end
	
-- This is a REALLY bad defined-size queue, don't copy this, I made it cuz I didn't have a lot of time
function enqueue(item)
	clicks[1] = clicks[2]
	clicks[2] = clicks[3]
	clicks[3] = clicks[4]
	clicks[4] = clicks[5]
	clicks[5] = clicks[6]
	clicks[6] = item
end
	
function getAverage()
	sum = clicks[1]+clicks[2]+clicks[3]+clicks[4]+clicks[5]+clicks[6]
	average = sum/6
	return average
end