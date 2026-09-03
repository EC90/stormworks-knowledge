-- source: steam id 2793900947 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947
s,i,o,p,m = self,input,output,property,math
pgn,pgb,gn,gb,sn,sb = p.getNumber,p.getBool,i.getNumber,i.getBool,o.setNumber,o.setBool
pi2,abs,sqrt = m.pi*2,m.abs,m.sqrt

size = pgn("Cylinder size")
rpsMin = m.max(pgn("RPS at throttle 0"), 3)
rpsMax = m.max(pgn("RPS at throttle 1"), rpsMin)
afr = pgn("Air-to-Fuel ratio")
protection = pgn("Overheat protection")
auto = not pgb("Autostart if engine stalls")

mean = 0
tick = 1
ratios = {}
tickMax = 10

overheat = false
starter = false
t1,t2 = 0,0
rpsOld = 0
stall = false

for i = 1,tickMax do 
	ratios[i] = 0
end

function clamp(x,min,max)
	return m.max(m.min(x,m.max(max,min)),m.min(min,max))
end

function lerp(min,max,t)
	local t = clamp(t, 0, 1)
	return min*(1-t)+max*t
end

function pid(p,i,d)
    return{p=p,i=i,d=d,error=0,diff=0,integral=0, 
		run=function(s,sp,pv,min,max,reset)
			local reset = reset or false 
			local error,diff,out
			error = sp-pv
			diff = error-s.error
			s.error = error
			s.diff = diff
			out = error*s.p+s.integral+diff*s.d
			if reset then
				s.integral = 0
			elseif out > min and out < max then 
				s.integral = clamp(s.integral+error*s.i,min,max)
			end
			return clamp(error*s.p+s.integral+diff*s.d,min,max)
		end
	}
end

pidAfr = pid(0.01, 0.002, 0)
pidEngine = pid(0.1-0.02*size, 0.002, 0)

function onTick()	
	air = gn(1)
	fuel = gn(2)
	temperature = gn(3)
	rps = gn(4)
	throttle = gn(5)
	
	onPulse = gb(1) and not on
	on = gb(1)
	
	rpsSp = lerp(rpsMin, rpsMax, throttle)
	
	if protection == 0 then
		rpsSp = lerp(lerp(rpsMin, rpsMax, throttle), 3, (temperature-100)/10)
	elseif protection == 1 then
		if temperature > 110 then
			overheat = true
		elseif temperature < 100 then
			overheat = false
		end
	end
	
	if not overheat and on and rps >= 2 then
			
		if fuel > 0 then 
			ratios[tick] = air/fuel
		else
			ratios[tick] = 0	
		end	
		
		tick = tick+1
		if tick > tickMax then 
			tick = 1
		end
		
		mean = 0
		for i,ratio in ipairs(ratios) do
			mean = mean+ratio
		end
		mean = mean/tickMax
		
		if mean > 0 then 
			boost = pidAfr:run(afr, mean, -0.52, 0.2)
		else
			boost = pidAfr:run(0, 0, 0, 0, true)
		end
		
		if size < 2 then
			rpsC = rps
		else
			rpsC = rpsOld
		end
		
		airManifold = pidEngine:run(rpsSp, rpsC, 0.01, 1)
		fuelManifold = airManifold*(0.48-boost)		
	else
		airManifold = 0
		fuelManifold = 0
		pidEngine:run(0, 0, 0, 0, true)
		pidAfr:run(0, 0, 0, 0, true)
		tick = 1
	end
	
	if rpsOld >= 2 and rps < 2 then
		stall = true
	end
	if auto or onPulse then 
		stall = false
	end
	if rps >= 2 then 
		t1,t2 = 0,m.min(t2+1,30)
	else 
		t1,t2 = m.min(t1+1,60),0
	end
	if on and not stall and t2 < 30 and t1 >= 60 and not overheat then
		starter = true	
	elseif not on or overheat or t2 >= 30 then
		starter = false
	end	
	
	rpsOld = rps
	
	sn(1, airManifold)
	sn(2, fuelManifold)
	
	sb(1, starter)
end