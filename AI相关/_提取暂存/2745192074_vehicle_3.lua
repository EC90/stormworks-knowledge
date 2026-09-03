-- source: steam id 2745192074 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2745192074
FINDsince=0
Vdisy=0
Hdisy=0
function onTick()
	
	Vdis = input.getNumber(1)
	Hdis = input.getNumber(2)
	delay = input.getNumber(3)
	FIRE = input.getBool(1)
	
	if Vdis ~= 0 and Hdis ~= 0 and FIRE then
		FINDsince = FINDsince+1
	else
		FINDsince = 0
	end
	
	VV = Vdis-Vdisy
	HV = Hdis-Hdisy
	
	if FINDsince >= 20 then
		if (Vdis+VV*delay < 0.5 or Hdis+HV*delay < 0.5 or (Vdis+Hdis)/2 < 1) and (Vdis+Hdis)/2 < 25 then
			output.setBool(1,true)
		else
			output.setBool(1,false)
		end
	else
		output.setBool(1,false)
	end
	
	
	Vdisy=Vdis
	Hdisy=Hdis
end
