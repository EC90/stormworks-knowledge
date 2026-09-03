-- source: steam id 2751468095 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2751468095
i=0
function onTick()
	WS = input.getNumber(2)
	zoom = input.getNumber(24)
	increment = 0.018*(1.05-zoom)
	max = 5
	min = -0.455
	up = WS>0
	dn = WS<0
	output.setNumber(1, i)

	if up and math.abs(i-max)>increment then i=i+increment end
	if dn and math.abs(i-min)>increment then i=i-increment end
end