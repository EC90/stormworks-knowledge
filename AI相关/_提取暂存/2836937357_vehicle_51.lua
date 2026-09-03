-- source: steam id 2836937357 / vehicle.xml block#51
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2836937357
x=0 
arr={} 
st=false 
function onTick() 

t=input.getBool(1) 

if t then st=false y=x table.insert(arr,y) x=math.random(1,9) end  
output.setNumber(2,math.floor(x)) end 