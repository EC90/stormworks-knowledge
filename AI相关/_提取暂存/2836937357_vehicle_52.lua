-- source: steam id 2836937357 / vehicle.xml block#52
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2836937357
x=0   
function onTick() 

t=input.getBool(1) 
output.setNumber(2, math.floor(x))

if t then 
x=math.random(30,300)
end
end