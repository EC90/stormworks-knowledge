-- source: steam id 2901328677 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2901328677
s,i,o,p,m = self,input,output,property,math
pgn,pgb,gn,gb,sn,sb = p.getNumber,p.getBool,i.getNumber,i.getBool,o.setNumber,o.setBool
pi2,abs,sqrt = m.pi*2,m.abs,m.sqrt
					
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
		run=function(s,sp,pv,min,max,maxI,reset)
			local reset = reset or false
			local maxI = maxI or max 
			local error,diff,out
			error = sp-pv
			diff = error-s.error
			s.error = error
			s.diff = diff
			out = error*s.p+s.integral+diff*s.d
			if reset then
				s.integral = 0
			elseif out > min and out < max then 
				s.integral = clamp(s.integral+error*s.i,min,maxI)
			end
			return clamp(error*s.p+s.integral+diff*s.d,min,max)
		end
	}
end

rpsMin = pgn("Idle RPS")
rpsMax = pgn("Throttle RPS")
boostMin = pgn("Reduce if RPS overshoots")
brSens = pgn("Brakes sensitivity")
wsSens = pgn("Throttle sensitivity")*0.01
thrLow = pgn("Reverse and low gear max throttle")
revMode = pgb("Engage reverse")
steerMax = pgn("Steering max")
steerMin = pgn("Steering min")
redStart = pgn("Start steering reduction at speed")
redFull = pgn("Full steering reduction at speed")
thrLow1 = 2*thrLow-4*thrLow^2+3*thrLow^3

wsT,wsB,wsOld,t1,t2,t3,t4 = 0,0,0,0,0,0,0
reverse,reverseOld = false,false
									
pidEngine = pid(0.1, 0.004, 0)
				
function onTick()
	ad = gn(1)
	ws = gn(2)
	speed = abs(gn(11))
	rps = gn(12)

	on = gb(1)
	park = gb(31)
	
	if speed < 0.5 then
		t4 = m.min(t4+1,30)
		if ws > 0.5 and (revMode or wsOld < 0.5) and (not revMode or t4 >= 30) then 
			reverse = false
		elseif ws < -0.5 and (revMode or wsOld > -0.5) and (not revMode or t4 >= 30) then
			reverse = true
		end
	else t4 = 0
	end
	
	if reverse ~= reverseOld then
		wsT,wsB = 0,0
	end
	wsOld = ws
	reverseOld = reverse
	
	wsR = reverse and -1 or 1
	wsT = m.max(wsT+clamp(wsR*ws-wsT, -wsSens, wsSens), 0)
	wsB = m.min(wsB+clamp(wsR*ws-wsB, -wsSens, wsSens), 0)

	if reverse then
		throttle = wsT*thrLow
		thrClutch = wsT*thrLow1
	else
		throttle = wsT
		thrClutch = wsT*(1-t3)
	end
	
	rpsSp = lerp(rpsMin,rpsMax,throttle)
	
	boost = lerp(boostMin,0.7,2*(rpsSp-rps)/(rpsMax-rpsMin))
	
	if on and rps > 2 then	
		air = pidEngine:run(rpsSp, rps, 0, 1, boost)	
	else
		air = pidEngine:run(0,0,0,0,0,true)
	end
	
	t3 = park and m.min(t3+0.02, 1) or m.max(t3-0.05, 0)

	brakes = lerp(-wsB*0.2*clamp(brSens/(speed+brSens), 0, 1), 1, t3)	
	
	steering = sgn(ad)*ad^2*lerp(steerMax, steerMin, clamp((speed-redStart)/(redFull-redStart), 0, 1))
	
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

	sn(1,air)
	sn(2,air*0.48)
	sn(3,thrClutch)
	sn(4,rpsSp)
	sn(5,brakes)
	sn(6,steering)
	sn(7,-steering)
	sn(8,on and gn(3) or 0)

	sb(1,starter)
	sb(2,on and reverse)
	sb(3,gb(3))
	sb(4,on and brakes > 0.01)
end