-- source: steam id 2793900947 / vehicle.xml block#25
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947
function onTick()
    x=input.getNumber(1)
	heading=(math.fmod((1-x),1)*360)
	output.setNumber(1, heading)
end