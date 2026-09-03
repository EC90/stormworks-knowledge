-- source: steam id 3272990065 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3272990065
count=0
nog=property.getNumber('number of guns')
rpm=property.getNumber('rate of fire')
blank=math.max(math.floor(3600/rpm),1)
gun=0
shoot=false
function onTick()
	shoot=false
	trigger=input.getBool(31)
	if count%blank==0 and trigger then shoot=true end
	if shoot then gun=gun%nog+1 end
	for i=1,32 do
		output.setBool(i,false)
	end
	output.setBool(gun,shoot)
	output.setBool(32,count%blank==0)
	if trigger or count%blank~=0 then
	count=count%3600+1
	end
end