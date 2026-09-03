-- source: steam id 2751468095 / vehicle.xml block#12
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2751468095
i=0
function onTick()
	WS = input.getNumber(2)
	zoom = input.getNumber(24)
	x=input.getNumber(25)
	increment = 0.014*(1.05-zoom)
	max = 1.3
	min = -0.474
	up = WS>0
	dn = WS<0
	output.setNumber(1, i)

	if up and math.abs(i-max)>increment then i=i+increment end
	if dn and math.abs(i-min)>increment then i=i-increment end
end