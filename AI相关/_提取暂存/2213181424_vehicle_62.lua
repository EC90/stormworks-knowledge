-- source: steam id 2213181424 / vehicle.xml block#62
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
function math.clamp(n, low, high) return math.min(math.max(n, low), high) end
function onTick()

SL = input.getBool(4)
	tilt_l = input.getNumber(24)*-2*math.pi
	tilt_f = input.getNumber(23)*2*math.pi

	tx = input.getNumber(1)
	ty = input.getNumber(3)
	tz = input.getNumber(2)
	
	HDG =(-input.getNumber(15)*2*math.pi+2*math.pi)%(2*math.pi)
	gpsx = input.getNumber(16)
	gpsy =  input.getNumber(17)
	alt =  input.getNumber(18)
	lsosr = property.getNumber("gpssos")
	lfosr = property.getNumber("gpsfos")
	laltos  = property.getNumber("altos")



-- light coords
--forward displacement(horiz)
lposa = math.atan(laltos,lfosr)
lfos = (laltos^2+lfosr^2)^0.5
LOCfos = math.cos(tilt_f+lposa)*lfos


 -- side displacement(horiz)
lrosa = math.atan(laltos,lsosr)
lsos = (laltos^2+lsosr^2)^0.5
LOCsos = math.cos(tilt_l+lrosa)*lsos

-- net displacement (horiz)
LOCos = (LOCsos^2+LOCfos^2)^0.5
LOCosar = math.atan(LOCsos,LOCfos)

LOCosa = LOCosar + HDG
if LOCosa > 2*math.pi then LOCosa = LOCosa - 2*math.pi end

locx = gpsx + math.sin(LOCosa)*LOCos
locy = gpsy + math.cos(LOCosa)*LOCos

-- net displacement (verti)
LOCfzos = math.tan(tilt_f)*LOCfos
LOCszos = math.tan(tilt_l)*LOCsos

locz = alt + laltos + math.clamp(LOCfzos, -math.abs(lfosr), math.abs(lfosr)) + math.clamp(LOCszos, -math.abs(lsosr), math.abs(lsosr))

-------------------------------------------------------------------------------------

-- relative HDG
	dx = tx-locx
	dy = ty-locy

	tHDG = math.atan(dx,dy)
	if tHDG < 0 then tHDG = tHDG + 2*math.pi end

-- levelyaw
	if math.abs(tHDG-HDG) < 2*math.pi-math.abs(tHDG-HDG) then
	lHDG = tHDG-HDG
	else
	lHDG = 2*math.pi-math.abs(tHDG-HDG)
		if tHDG-HDG > 0 then
		lHDG = -lHDG
		end
	end
	
	lyawr = lHDG*(2/(math.pi))
	if math.abs(lyawr) > 1 then
		if lyawr < 0 then 
		lyaw = lyawr+2 
		else
		lyaw = lyawr-2 
		end
	else
	lyaw = lyawr
	end

-- levelpitch
	dz = locz - tz
	
	tdist = (math.abs(dx)^2+math.abs(dy)^2)^0.5
	lPIT = math.atan(tdist/dz)

-- hsi correction
	lPITpc = math.sqrt(1^2-(lyaw^2))*tilt_f
	if math.abs(lyawr) > 1 then lPITpc = lPITpc*-1 end
	
	lPITrc = math.sqrt(1^2-(1-(lyaw^2)))*tilt_l
	if lyawr>0 then lPITrc = lPITrc*-1 end
	
	lpitch = (lPIT-lPITpc-lPITrc)*(2/(math.pi))
	if lpitch < 0 then lpitch = 1 end
	if math.abs(lyawr) > 1 then lpitch = lpitch*-1 end

if not SL then
lyaw = 0
lpitch = 1
end

	output.setNumber(1,lyaw)
	output.setNumber(2,lpitch)
	output.setNumber(3,lHDG)
	output.setNumber(4,tHDG)
	
-- passthroughs
output.setBool(1,input.getBool(1))
output.setBool(2,input.getBool(2))
output.setBool(3,input.getBool(3))
output.setBool(4,input.getBool(4))
output.setNumber(10,input.getNumber(10))	
end
