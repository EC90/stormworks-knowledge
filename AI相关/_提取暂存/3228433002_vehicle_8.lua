-- source: steam id 3228433002 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3228433002
--Functions
iB=input.getBool
iN=input.getNumber
oB=output.setBool
oN=output.setNumber
pB=property.getBool
pN=property.getNumber

HPID=pN('Hardpoint No.')

function onTick()
	HPID_IN=iN(1)
	Mode=iN(2)
	Launch_IN=iB(1)
	Release_IN=iB(2)
	ActSeaker_IN=iB(3)
	if HPID_IN==HPID then
		if Mode==0 then
			Launch_C=false
			Launch_B=Launch_IN
		elseif Mode==1 then
			Launch_C=Launch_IN
			Launch_B=false
		else
			Launch_C=Launch_IN
			Launch_B=Launch_IN
		end
		Release=Release_IN
		ActSeaker=ActSeaker_IN
	else
		Launch_C=false
		Launch_B=false
		Release=false
		ActSeaker=false
	end
	oB(1,Launch_C)
	oB(2,Release)
	oB(3,ActSeaker)
	oB(31,Launch_B)
	oB(32,true)
end