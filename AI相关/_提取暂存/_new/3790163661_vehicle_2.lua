-- source: steam id 3790163661 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3790163661
PrevVal=0
function onTick()
	Val = input.getNumber(1)
	Sen=(property.getNumber("Map moving speed"))/100
	
	sen= (Sen-0)*(0-1)/(1-0)+1
	
	ValS=(Val*Sen)+(PrevVal*sen)
	
	PrevVal=ValS
	
	output.setNumber(1,ValS)
end
