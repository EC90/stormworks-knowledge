-- source: steam id 2900758088 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2900758088
fuelb = 0
timer = 0
reset = true
function onTick()
	airv = input.getNumber(1)
	fuelv = input.getNumber(2)
	temp = clamp(input.getNumber(3),0,130)
	RPS = input.getNumber(4)
	throttlein = input.getNumber(5)-clamp(temp-109,0,15)/10
	idle = property.getNumber("idle RPS")
	idlesens = property.getNumber("idle sensitivity")
	startv = property.getNumber("start value(read the description)")
	if reset then
		reset(startv)
		reset = false
	end
	ajussp = property.getNumber("auto ajust speed(read the description)")
	desstoich = property.getNumber("desired Stoichiometric")
	setrps = property.getBool("use throttle as set RPS")
	
	if input.getNumber(6) == 1 then on = true else on = false end
	if on then
	stoich = (.01 - (airv/fuelv - 13.25)/(temp+75))*36
	if setrps then
		throttle = clamp((throttlein-RPS)*idlesens,0,1)
	else
		throttle = clamp(clamp((idle-RPS)*idlesens,0,1)+clamp(throttlein,0,1),0,1)
	end
	if RPS > 80 then
		throttle = 0
	end
	if RPS < 2.5 or throttle < 0.01 or (fuelv == 0 and map[round(temp/10)+1][round(RPS/5)+1]>0) then
		stoich =0
		desstoich =0
		timer = 20
	end
	if timer > 0 then
		stoich =0
		desstoich =0
		timer = timer-1
	end

	map[round(temp/10)+1][round(RPS/5)+1] = (map[round(temp/10)+1][round(RPS/5)+1] or 0) - ((stoich-desstoich)/100)*ajussp

	fuelb = map[round(temp/10)+1][round(RPS/5)+1]
	else
	throttle = 0
	end
	
	output.setNumber(1, throttle)
	output.setNumber(2, throttle*fuelb)
	output.setNumber(3, stoich)
	output.setNumber(4, fuelb)
end

function onDraw()

	screen.drawText(2, 2, 'fuelb='..fuelb)
	screen.drawText(2, 10, 'stoich='..round(stoich,5))
	screen.drawText(2, 18, 'fuel='..fuelv)
	screen.drawText(2, 25, 'air='..airv)
	screen.drawText(2, 33, 'temp='..temp)






end

function round(x2, decimals)
 local x = x2 or 0
	-- This should be less naive about multiplication and division if you are 
	-- care about accuracy around edges like: numbers close to the higher
	-- values of a float or if you are rounding to large numbers of decimals.
    local n = 10^(decimals or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end

function clamp(value,min,max)
	local out = value
	if value < min then out = min end
	if value > max then out = max end
return out
end

function reset(val)
	map = {}
	for v1=1,14 do
		map[v1]={}
		for v2=1,20 do
			map[v1][v2] = val
		end
	end
end





