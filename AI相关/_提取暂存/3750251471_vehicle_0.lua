-- source: steam id 3750251471 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3750251471

-- Tick function that will be executed every logic tick
function onTick()
	buz = false
    front = input.getBool(1)
	frontleft = input.getBool(2)
	left = input.getBool(3)
	rearleft = input.getBool(4)
	rear = input.getBool(5)
	rearright = input.getBool(6)
	right = input.getBool(7)
	frontright = input.getBool(8)
	rad = 0
	if front then
		buz = true rad=131
	end
	if left then
		buz = true rad=14
	end
	if rear then
		buz = true rad=56
	end
	if right then
		buz = true rad=224
	end
	output.setBool(1,buz)
	output.setNumber(1,rad)
end