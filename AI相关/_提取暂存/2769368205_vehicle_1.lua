-- source: steam id 2769368205 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2769368205
gear = {}
gear[1] = {0,0,0}
gear[2] = {0,1,0}
gear[3] = {1,0,0}
gear[4] = {1,1,0}
gear[5] = {0,0,1}
gear[6] = {0,1,1}
gear[7] = {1,0,1}
gear[8] = {1,1,1}

function onTick()
	gManual = math.abs(math.max(input.getNumber(1),1))
	gr = gear[gManual]
	
	output.setBool(1,gr[1]==1)
	output.setBool(2,gr[2]==1)
	output.setBool(3,gr[3]==1)
end