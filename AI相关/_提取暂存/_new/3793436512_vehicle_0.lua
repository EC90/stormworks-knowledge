-- source: steam id 3793436512 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793436512
s,i,o,p,m = self,input,output,property,math
pgn,pgb,gn,gb,sn,sb = p.getNumber,p.getBool,i.getNumber,i.getBool,o.setNumber,o.setBool
abs = m.abs

rpsMin = m.max(pgn("RPS at throttle 0"), 2.1)
rpsMax = m.max(pgn("RPS at throttle 1"), rpsMin)
mix = pgb("Mixture control")
stoP = pgn("Stoichiometry")
afrP = pgn("Air-to-Fuel ratio")
prot = pgn("Overheat protection")
mode = pgb("RPS control")
opt = pgb("Optimal mixture at high throttle")
auto = not pgb("Autostart if engine stalls")

heat,start,stall,cyl = false,false,false,false
t1,t2 = 0,0
rpsOld,stoT,afrT,floS,fuelM = 0,0,0,0,0.0000001

delay = {}
for i = 1,5 do
	delay[i] = {0.0000001, 0.0000001}
end

function clamp(x,min,max)
	return m.max(m.min(x,m.max(max,min)),m.min(min,max))
end

function lerp(min,max,t)
	local t = clamp(t,0,1)
	return min*(1-t)+max*t
end

function pid(p,i,d)
    return{p=p,i=i,d=d,error=0,diff=0,integral=0, 
		run=function(s,sp,pv,min,max,maxI,mult)
			local maxI,mult = maxI or max,mult or 1
			local error,diff,out
			error = sp-pv
			diff = error-s.error
			s.error = error
			out = error*s.p*mult+s.integral+diff*s.d*mult
			if out > min and out < max then
				s.integral = clamp(s.integral+error*s.i*mult,min,maxI)
			end
			return clamp(error*s.p*mult+s.integral+diff*s.d*mult,min,max)
		end
	}
end

pidEngine = pid(0.1, 0.002, 0)

function onTick()	
	air = gn(1)
	fuel = gn(2)
	temp = gn(3)
	rps = gn(4)
	con = gn(5)
	dyn = gn(6)
	onPulse = gn(7) > 0 and not on
	on = gn(7) > 0
	
	rpsSp = mode and clamp(con,2.1,60) or lerp(rpsMin, rpsMax, con)
	
	if prot == 0 then
		rpsSp = lerp(rpsSp, 2.1, (temp-105)/10)
	elseif prot == 1 then
		if temp > 110 then
			heat = true
		elseif temp < 100 then
			heat = false
		end
	end
	if not heat and on and rps >= 2 then
		if air == 0 and fuel == 0 and temp == 0 then
			cyl = true
			afr = (dyn >= 12.6 and dyn <= 15) and dyn or afrP
			airM = pidEngine:run(rpsSp, rps, 0, 1)
			fuelM = airM*6.88/afr
			afrT = afr
			stoT = 0
		else
			cyl = false
			flo = m.min(fuel/fuelM,0.1)
			floS = floS+clamp(flo-floS,-0.001,0.001)
			thr = pidEngine:run(rpsSp, rps, 0, 1, m.max(fuelM,0.1), 0.0015/(floS+0.0015))
			air = m.max(air,0.0000001)
			temp = clamp(temp,0,100)
			if mix then
				afr = (dyn >= 12.6 and dyn <= 15) and dyn or afrP
				sto = (temp+(1400-100*afr))/(3*temp+200)	
			else
				sto = (dyn >= 0.1 and dyn <= 1) and dyn or stoP
			end
			stoOpt = opt and 0.5 or sto
			airD,fuelD = delay[5][1],delay[5][2]
		
airM = clamp(-(1000000*thr*fuel*airD*((3*sto-1)*temp+(200*sto-1400)))/(100000000*air*fuelD),0.0001,1)	
fuelM = clamp(thr,0.0000001,clamp(-(100000000*air*fuelD)/(1000000*fuel*airD*((3*stoOpt-1)*temp+(200*stoOpt-1400))),0.0001,1))
			
			afrT = clamp(air/m.max(fuel,0.0000001),0,99)
			stoT = clamp((temp+(1400-100*afrT))/(3*temp+200),-1,1)
		end
	else
		airM,fuelM,afrT,stoT = 0.0000001,0.0000001,0,0
		pidEngine:run(0,0,0,0,0,0)
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
	if on and not stall and t2 < 30 and t1 >= 60 and not heat then
		start = true	
	elseif not on or heat or t2 >= 30 then
		start = false
	end	
	
	rpsOld=rps
	
	for i = 5,2,-1 do
		delay[i] = delay[i-1]
	end
	delay[1] = {airM, fuelM}

	sn(1, airM)
	sn(2, fuelM)
	sn(3, rps)
	sn(4, gn(3))
	sn(5, stoT)
	sn(6, afrT)
	sn(7, fuel*60)
	
	sb(1, start)
	sb(2, cyl)
end