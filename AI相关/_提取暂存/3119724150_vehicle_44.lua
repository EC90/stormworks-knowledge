-- source: steam id 3119724150 / vehicle.xml block#44
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3119724150
function onTick()
Mod=input.getBool(1)
fix=input.getBool(8)
R1=input.getNumber(3)
x=input.getNumber(5)
y=input.getNumber(6)
R2=property.getNumber("Static Radar Range")
if fix then fr=25000 else fr=18000 end
if Mod then R=(50*R2)/fr else R=(50*R1)/fr end
output.setNumber(1,R)
end
function onDraw()
screen.drawMap(x,y,R)
end