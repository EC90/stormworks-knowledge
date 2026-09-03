-- source: steam id 2637243907 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2637243907
integral, pvOld, out = 0, 0, 0
											
min, max = 0, 1
											
P, I, D = 0.2, 0.0005, 0
											
function onTick()
	setpoint = input.getNumber(1)
	pv = input.getNumber(2)
											
	on = input.getBool(1)
											
	if on and pv > 2 then
		error = setpoint - pv
		diff = pv - pvOld	
											
		if out < max and out > min then
			integral = integral + I*error
		end		
		integral = math.max(math.min(integral, max), min)
											
		out = math.max(math.min(P*error+integral-D*diff, max), min)
											
	else
		integral = 0
		out = 0
	end
											
	pvOld = pv
											
	output.setNumber(1, out)
	output.setNumber(2, out*0.49)
end