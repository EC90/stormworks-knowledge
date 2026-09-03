-- source: steam id 2859126618 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2859126618
--Constants
GAIN = 2

-- Tick function that will be executed every logic tick
function onTick()
	x = math.cos(input.getNumber(1))
	y = math.sin(input.getNumber(1))
	z = input.getNumber(2)
	w = input.getNumber(3)
	
	--Calculations
	Output = ((x*z+y*w)/(math.sqrt(x^2+y^2)*math.sqrt(z^2+w^2)))*GAIN
	Distance = math.sqrt(z^2+w^2)
	
	--Output
	output.setNumber(1, Output)
	output.setNumber(2, Distance)
end