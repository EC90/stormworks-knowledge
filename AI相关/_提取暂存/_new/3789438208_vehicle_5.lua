-- source: steam id 3789438208 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3789438208
i=input
s=0
function onTick()
S=round(i.getNumber(1),0)
up=i.getBool(2)
down=i.getBool(3)
r=i.getBool(1)

if up then
s=s+1
end

if down then
s=s-1
end

if r then
s=0
end

output.setNumber(1,s+S)
end
function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end