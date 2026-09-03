-- source: steam id 3791064111 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3791064111
--inner (atan(y/(z/tan(1))*x))*w
--outer (atan(y/(w/tan(1)+z)*x))*a
flipn = 1
left = 0
right = 0
inner = 0
outer = 0
wheelPosition = 0
function onTick()
	thisAxleDistance = property.getNumber("Axle Distance from Pivot (m)")
	furthestAxleDistance = property.getNumber("Furthest Axle's Distance from Pivot Point (m)")
	distanceOfWheels = property.getNumber("Distance Between Wheels (m)")
	flip = property.getBool("Axle is behind Pivot")
	steerLimit = property.getNumber("Steering limit")
	
	wheelPosition = input.getNumber(1)
	
	if flip then
		flipn = -1
	else
		flip = 1
	end
	
	
	inner = (math.atan(thisAxleDistance/(furthestAxleDistance/math.tan(steerLimit))*wheelPosition)) * flipn
	outer = (math.atan(thisAxleDistance/(furthestAxleDistance/math.tan(steerLimit)+distanceOfWheels)*wheelPosition)) *flipn
	
	if wheelPosition >= 0 then
		left = outer
		right = inner
	elseif wheelPosition <= 0 then
		left = inner
		right = outer
	end
	
	output.setNumber(1, left * -1)
	output.setNumber(2, right)
	
end