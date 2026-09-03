-- source: steam id 3168029480 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3168029480
GN=input.getNumber
SN=output.setNumber
function onTick()
lookx=GN(9)
looky=GN(10)
SN(1,0.0000644-0.792*lookx+0.502*lookx^2)
SN(2,-0.058-1.69*looky+1.83*looky^2)
end