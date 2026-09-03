-- source: steam id 3750251471 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3750251471
s,i,o,p,m = self,input,output,property,math
pgn,pgb,gn,gb,sn,sb = p.getNumber,p.getBool,i.getNumber,i.getBool,o.setNumber,o.setBool
abs = m.abs
					
function clamp(x,min,max)
	return m.max(m.min(x,m.max(max,min)),m.min(min,max))
end

function lerp(min,max,t)
	local t = clamp(t,0,1)
	return min*(1-t)+max*t
end

function sgn(x)
	return x >= 0 and 1 or -1
end
									
function pid(p,i,d)
    return{p=p,i=i,d=d,error=0,diff=0,integral=0, 
		run=function(s,sp,pv,min,max,maxI)
			local maxI = maxI or max 
			local error,diff,out
			error = sp-pv
			diff = error-s.error
			s.error = error
			s.diff = diff
			out = error*s.p+s.integral+diff*s.d
			if out > min and out < max then 
				s.integral = clamp(s.integral+error*s.i,min,maxI)
			end
			return clamp(error*s.p+s.integral+diff*s.d,min,max)
		end
	}
end

mean = 0
tick = 1
ratios = {}
tickMax = 10

rpsMin = pgn("Idle RPS")
rpsMax = pgn("Throttle RPS")
over = pgn("Reduce if RPS overshoots")
afr = pgn("Air-to-Fuel ratio")
brSens = pgn("Brakes sensitivity")
wsSens = pgn("Throttle sensitivity")*0.01
thrLowLan = pgn("Reverse and low gear max throttle")
thrLowWat = pgn("Reverse and low gear on water max throttle")
thrWat = pgn("Turnaround on water max throttle")
revMode = pgb("Engage reverse")
steerMax = pgn("Steering max")
steerMin = pgn("Steering min")
redStart = pgn("Start steering reduction at speed")
redFull = pgn("Full steering reduction at speed")

wsT,wsB,wsJ,wsOld,t1,t2,t3,t4 = 0,0,0,0,0,0,0,0
reverse,reverseOld = false,false

pidAfr = pid(0.01, 0.002, 0)							
pidEngine = pid(0.1, 0.004, 0)
				
function onTick()



if gb(12) then
	ad = gn(1)+gn(18)
	ws = gn(2)+gn(19)
else
	ad = gn(1)
	ws = gn(2)
end
	
	
	
	air = gn(11)
	fuel = gn(12)
	temp = gn(13)
	rps = gn(14)
	speed = abs(gn(15))
	angular = gn(16)
	fluid = 1+clamp(gn(17), -1, 0)
	
	low = gb(1)
	on = gb(11)
	park = gb(31)
	
	if fluid >= 1 then
		if ws > 0.5 then reverse = false
		elseif ws < -0.5 then reverse = true
		end
	else
		if speed < 0.5 then
			t4 = m.min(t4+1,30)
			if ws > 0.5 and (revMode or wsOld < 0.5) and (not revMode or t4 >= 30) then 
				reverse = false
			elseif ws < -0.5 and (revMode or wsOld > -0.5) and (not revMode or t4 >= 30) then
				reverse = true
			end
		else t4 = 0
		end
	end
	
	if reverse ~= reverseOld then
		wsT,wsB = 0,0
	end
	wsOld = ws
	reverseOld = reverse
	
	wsR = reverse and -1 or 1
	wsT = m.max(wsT+clamp(wsR*ws-wsT, -wsSens, wsSens), 0)
	wsB = m.min(wsB+clamp(wsR*ws-wsB, -wsSens, wsSens), 0)
	wsJ = clamp(wsJ+clamp(ws-wsJ, -wsSens, wsSens), -1, 1)
	
	wsF = m.max(wsT, thrWat*abs(ad)*fluid)
	
	thrLow = lerp(thrLowLan, thrLowWat, fluid)
	throttle = (reverse or low) and wsF*thrLow or wsF
	thrClutch = (reverse or low) and wsF*(1-t3)*(0.4+0.6*thrLow) or wsF*(1-t3)
	
	rpsSp = lerp(rpsMin,rpsMax,throttle)
	
	if on and rps >= 2 then	
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
			boost = pidAfr:run(0,0,0,0,0)
		end
		overSm = lerp(over, 1, fluid)
		airManifold = pidEngine:run(rpsSp, rps, 0.01, lerp(1,0.8,(temp-80)/20), overSm)
		fuelManifold = airManifold*(0.48-boost)		
	else
		airManifold = 0
		fuelManifold = 0
		pidEngine:run(0,0,0,0,0)
		pidAfr:run(0,0,0,0,0)
		tick = 1
	end
	
	t3 = park and m.min(t3+0.02, 1) or m.max(t3-0.05, 0)

	brakes = lerp(-wsB*0.2*clamp(brSens/(speed+brSens), 0, 1), 1, t3)	
	
	steering = sgn(ad)*ad^2*lerp(steerMax, steerMin, clamp((speed-redStart)/(redFull-redStart), 0, 1))
	steeringAng = clamp(1.5*steering-1*angular*wsR,-steerMax,steerMax)
	
	if rps >= 2 then 
		t1,t2 = 0,m.min(t2+1,30)
	else 
		t1,t2 = m.min(t1+1,60),0
	end
	if on and t2 < 30 and t1 >= 60 then
		starter = true	
	elseif not on or t2 >= 30 then
		starter = false
	end	

	sn(1,airManifold)
	sn(2,fuelManifold)
	sn(3,thrClutch)
	sn(4,rpsSp)
	sn(5,brakes)
	sn(6,steeringAng)
	sn(7,wsJ)
	
	sb(1,starter)
	sb(2,reverse)
	sb(3,reverse or low)
	sb(4,park or brakes > 0.01)
	sb(5,park)
end