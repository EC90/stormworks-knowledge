-- source: steam id 3789438208 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3789438208
samples = {}

tick = 1
iter = 1
tickStart = 1

fuelD = 0
fuelDOld = 0
fuelA = 0
fuelAOld = 0
speedA = 0
speedAOld = 0

rate1 = 0
rate2 = 0
time = 0
range = 0

start = false

function onTick()
	fuel = math.max(input.getNumber(1), 0)
	speed = math.abs(input.getNumber(2))
	
	sampleMax = property.getNumber("Sampling time")
	
	if tickStart < 60 then tickStart = tickStart+1
	end
	
	if not start and tickStart >= 60 and fuel > 0 then
		start = true
		for i = 1,sampleMax do
			samples[i] = {} 
			samples[i][1] = fuel
			samples[i][2] = 0
		end
		fuelA = fuel
		fuelAOld = fuel
	end	
	
	if start then	
		if tick > 60 then
			fuelAOld = fuelA
			fuelDOld = fuelD
			speedAOld = speedA
			speedA = 0
			fuelA = 0
			
			tick = 0
			
			samples[iter][1] = fuel
			samples[iter][2] = speed
			
			for i in pairs(samples) do
				fuelA = fuelA + samples[i][1]
				speedA = speedA + samples[i][2]
			end
			fuelA = fuelA/sampleMax
			speedA = speedA/sampleMax
			fuelD = fuelAOld - fuelA
			
			iter = iter+1
			if iter > sampleMax then iter = 1
			end		
		end
		
		tick1 = tick/60
		rate1 = math.max(fuelDOld*(1-tick1)+fuelD*tick1, 0)
		fuelALerp = math.max(fuelAOld*(1-tick1)+fuelA*tick1, 0)
		speedALerp = math.max(speedAOld*(1-tick1)+speedA*tick1, 0)
		
		if rate1 > 0.001 then
			time = math.min(fuelALerp/(rate1*60), 1000)
			range = math.min(speedALerp*time*0.06, 10000)
		else 
			time = 0
			range = 0
		end
		
		if speed > 1 then rate2 = rate1*1000/speed
		else rate2 = 0
		end
			
		tick = tick+1
	end

	output.setNumber(1, rate1)
	output.setNumber(2, rate2)
	output.setNumber(3, math.floor(time))
	output.setNumber(4, math.floor(range))
end