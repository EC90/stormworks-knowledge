-- source: steam id 3004053396 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3004053396
tbl={}

function onTick()
count=0
for i=1,6 do tbl[i]=input.getBool(i) if not tbl[i] then count = count + 1 end end
output.setNumber(1,count)
end