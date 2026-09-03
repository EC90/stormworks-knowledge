-- source: steam id 3788750037 / vehicle.xml block#69
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
function onTick()

curX = input.getNumber(3)
curY = input.getNumber(4)

targetX = input.getNumber(1)
targetY = input.getNumber(2)
         
updatedX = input.getNumber(5)
updatedY = input.getNumber(6)

update = input.getBool(2)

if update == true and distance < search then

distance=((updatedX-curX)^2 + (updatedY-curY)^2)^.5

else 

distance=((targetX-curX)^2 + (targetY-curY)^2)^.5

end

search = 4000
output.setBool(2, distance < search)
end