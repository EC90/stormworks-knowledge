-- source: steam id 2793900947 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947

function onTick()
	on = input.getBool(25)
	
	if on then
		
		for i=1,32 do
			output.setNumber(i,(math.random()-.5)*2000)
			
			a = false
			if math.random() >= .5 then
				a = true
			end
			
			output.setBool(i,a)
		end
		
	else
	end
end