-- source: steam id 2751468095 / vehicle.xml block#20
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2751468095
function onTick()
    x=input.getNumber(28)
    elevation=input.getNumber(19)
    y=math.abs(x%1)
    if y > 0.34 and y < 0.64 then 
    z=true
    else
    z=false
    end
	if elevation > 0.0431 then
	g=true
	else
	g=false
	end
    if z and g then
    b=0.0469
    end
    if not z then
    b=0
    end
    truelevation=elevation-b
    output.setNumber(1, truelevation)
end