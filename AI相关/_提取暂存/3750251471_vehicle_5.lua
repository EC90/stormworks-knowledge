-- source: steam id 3750251471 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3750251471

m = math
p = 1
d = 15
maxSpd = 0.4
minP = -0.16
maxP = 0.38
offset = 0.005
prevX = 0

function clamp(a, b, c)
	return m.min(m.max(a, b), c)
end

function onTick()
	currX = input.getNumber(9)
	currY = input.getNumber(10)
	
	diffX = currX - prevX
	outYaw = clamp(currX * p + diffX * d, -maxSpd, maxSpd)
	
	targetP = clamp(currY*4 + offset, minP, maxP)
	
	output.setNumber(1, -outYaw)
	output.setNumber(2, -targetP)
	
	prevX = currX
	
	if input.getBool(1) then output.setNumber(3,1) else output.setNumber(3,0) end
	
	if input.getBool(2) then output.setNumber(4,1) else output.setNumber(4,0) end
	
end