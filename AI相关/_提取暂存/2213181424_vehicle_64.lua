-- source: steam id 2213181424 / vehicle.xml block#64
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
integral = 0
pvOld = 0
out = 0
											
max = 1
min = -1
											
function onTick()
	setpoint = input.getNumber(1)
	pv = input.getNumber(2)
	P = input.getNumber(3)
	I = input.getNumber(4)
	D = input.getNumber(5)
	trim = input.getNumber(6)*0.05
											
	on = input.getBool(1)
	right = input.getBool(2)
											
											
	if on then 	
		error = setpoint - pv
		diff = pv - pvOld	
											
		if out < max and out > min then
			integral = integral + I*error
			integral = math.max(math.min(integral, max), min)
		end
											
		Kp = P*error
		Ki = integral
		Kd = -D*diff
											
		out = Kp+Ki+Kd
		out = math.max(math.min(out, max), min)
											
	else
		integral = 0
		out = 0
	end
											
	pvOld = pv
											
	if right then out = -out end
											
	output.setNumber(1, out+trim)
end