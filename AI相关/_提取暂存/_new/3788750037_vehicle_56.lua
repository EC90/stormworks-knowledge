-- source: steam id 3788750037 / vehicle.xml block#56
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
Data={}
Volumes={}
debug=true
iB=input.getBool
iN=input.getNumber
oB=output.setBool
oN=output.setNumber
pN=property.getNumber
pB=property.getBool
old_rps=0
old_temp=0

cylinder_count=pN("Cylinder Count")
idle=pN("Idle RPS")
limiter=pN("Limiter RPS")
set_afr=pN("AFR")
clutch_rps=pN("Clutch RPS")
gen_clutch_set=pN("Generator")/100
th_mode=pN("Throttle Mode")
temp_safety=pB("Temperature Safety")
gen_mode=pB("Generator at idle")
function onTick()
	toggle=iB(1)
	air_volume=iN(1)
	fuel_volume=iN(2)
	temp=iN(3)
	rps=iN(4)
	th=math.abs(iN(5))
	notn=false
	if th==0 then n=true else if n then notn=true end n=false end
	battery=iN(6)
	
	if th_mode~=0 then
		if temp_safety and temp>100 then
			th=th*clamp((115-temp)/15,0,1)
		end
		if gen_mode and n then
			th=clamp((1-battery)*100,0,1)
		end
	end
	
	if th_mode==0 then
		if th>2.5 then
			toggle=true
		end
		th=PID(th,rps,.1-.02,.002,0,0,1,toggle,"th")
	elseif th_mode==1 then
		set_rps=idle*(1-th)+limiter*th
		th=PID(set_rps,rps,.1-.02,.002,0,0,1,toggle,"th")
	elseif th_mode==2 then
		idle_th=PID(idle,rps,.1-.02,.002,0,0,1,toggle,"idle_th")
		limiter_th=PID(limiter,rps,.1-.02,.002,0,0,1,toggle,"limiter_th")
		th=math.min(math.max(th,idle_th),limiter_th)
	elseif th_mode==3 then
		th=th
	end
	
	air_manifold=th
	
	afr=ratio(air_volume,fuel_volume)
	afr_ratio=PID(set_afr,afr,.01,.002,0,-.5,.2,toggle,"afr")*clamp(afr,0,1)
	fuel_manifold=air_manifold*(0.485-afr_ratio)
	
	clutch=PID(rps,clutch_rps,.01,.002,.05,0,1,toggle and not notn,"clutch")
	if n then gen_clutch=clutch else gen_clutch=gen_clutch_set*clutch end
	if rps<3 or n or not toggle then clutch=0 end
	if rps<3 or not toggle then gen_clutch=0 end
	
	if rps<2 and toggle then
		starter=true
	elseif rps>2.5 or not toggle then
		starter=false
	end
	
	consumption=fuel_volume*60*cylinder_count
	temp_delta=(temp-old_temp)*60
	
	oN(1,rps)
	oN(2,air_manifold)
	oN(3,afr)
	oN(4,temp)
	oN(5,consumption)
	oN(6,clutch^(1/3))
	oN(7,gen_clutch^(1/3))
	oN(8,fuel_manifold)
	oN(9,temp_delta)
	oN(10,battery)
	oN(11,idle)
	oN(12,limiter)
	oN(13,cylinder_count)
	oB(1,toggle)
	oB(2,starter)
	old_rps=rps
	old_temp=temp
end
function PID(set,data,p,i,d,min,max,on,id)
	if not Data[id] then Data[id]={old_data=0,integral=0,out=0} end
	if on then
		error=set-data
		diff=data-Data[id].old_data
		if Data[id].out<max and Data[id].out>min then
			integral=clamp(Data[id].integral+(i*error),min,max)
			Data[id].integral=integral
		end
		out=clamp(p*error+Data[id].integral-d*diff,min,max)
		Data[id].old_data=data
		Data[id].out=out
		return out
	else
		Data[id]={old_data=0,integral=0,out=0}
		return 0
	end
end
function clamp(x,y,z)
	if x<y then return y elseif x>z then return z else return x end
end
function ratio(a,f)
	if f==0 then afr=0 else afr=a/f end
	table.insert(Volumes,{air=a,fuel=f})
	if #Volumes>10 then table.remove(Volumes,1) end
	sum=0
	for i,v in pairs(Volumes) do
		if v.fuel>0 then
			sum=sum+v.air/v.fuel
		end
	end
	return sum/#Volumes
end