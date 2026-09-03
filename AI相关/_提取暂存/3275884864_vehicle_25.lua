-- source: steam id 3275884864 / vehicle.xml block#25
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3275884864
cnt=0
function onTick()
	rad=input.getNumber(1)
	cnt=(cnt+rad*0.25)%10
	buzzer=cnt>1
	output.setBool(1,buzzer)
end