-- source: steam id 3004053396 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3004053396
a,b,c,d = false,false,false,false

function onTick()

if not a then
	if input.getBool(1) then a=true end
end

if not b then
	if input.getBool(2) then b=true end
end

if not c then
	if input.getBool(3) then c=true end
end

if not d then
	if input.getBool(4) then d=true end
end

output.setBool(1,a) output.setBool(2,b) output.setBool(3,c) output.setBool(4,d) 

end