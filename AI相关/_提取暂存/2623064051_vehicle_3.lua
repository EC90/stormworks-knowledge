-- source: steam id 2623064051 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2623064051
integral = 0
pvOld = 0
out = 0

min = 0.05
max = 1
P,I,D = 0.3,0.002,0

function clamp(x, min, max)
return math.max(math.min(x, max), min)
end

function onTick()
	setpoint = input.getNumber(1)
	pv = input.getNumber(2)
	
	on = input.getBool(1)
	
	if on then 	
		error = setpoint - pv
		diff = pv - pvOld	
			
		if out < max and out > min then
			integral = clamp(integral + I*error, min, max)
		end
			
		Kp = P*error
		Ki = integral
		Kd = -D*diff
			
		out = clamp(Kp+Ki+Kd, min, max)
			
	else
		integral = 0
		out = 0
	end
	
	pvOld = pv

	output.setNumber(1, out)
	
end