-- source: steam id 2832404885 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2832404885
min = 0
max = 0.52
maxdiff = 0

mean = 0
tick = 1
tickmax = 10
ratios = {}

for i = 1,tickmax do ratios[i] = 0 end

function clamp(x,y,z)
return math.min(math.max(x,y),z)
end

function pid(p,i,d)
    return{p=p, i=i, d=d, error=0, diff=0, integral=0, 
		run=function(self, sp, pv, min, max)
			local error,diff
			error = sp - pv
			diff = error - self.error
			self.error = error
			self.diff = diff
			self.integral = clamp(self.integral + error*self.i, min, max)
			return clamp(error*self.p + self.integral + diff*self.d, min, max)
		end
	}
end

sens = property.getNumber("RPS PID sensitivity")
pid1 = pid(0.01,0.001,0)
pid2 = pid(0.05*sens,0.0005+0.0002*sens,0)

function onTick()
	
	air = input.getNumber(1)
	fuel = input.getNumber(2)
	target = input.getNumber(4)
	rps = input.getNumber(5)
	
	afr = property.getNumber("Air-to-Fuel ratio")
	
	on = input.getBool(1)

	if on and rps > 2 then
			
		if fuel > 0 then ratios[tick] = air/fuel
		else ratios[tick] = 0	
		end	
		
		tick = tick+1
		if tick > tickmax then tick = 1 end
		
		mean = 0
		for i,ratio in ipairs(ratios) do mean = mean+ratio
		end
		mean = mean/tickmax
		
		if mean > 0 then 
		maxdiff = pid1:run(afr, mean, -0.48, 0.42)
		else maxdiff = 0
		end
		
		max = 0.52 - maxdiff
		out = pid2:run(target, rps, min, max)
	else
		out = 0
		tick = 1
	end

	output.setNumber(1, out)
	output.setNumber(2, out/max)
end