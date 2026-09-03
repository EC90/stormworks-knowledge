-- source: steam id 3791754921 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3791754921
s=0
function onTick()
	a = input.getBool(1)
	b = input.getBool(2)
	c = input.getBool(3)
	
	if a then 
		s=s+60
		if s > 5940 then s = 5940 end
	end
	if b then
		s=s-10
		if s < 0 then s = 0 end
	end
	if c then
		s=s-1
		end
	m1=math.floor(s/60)
	s1=s-m1*60
	output.setNumber(1,m1)
	output.setNumber(2,s1)
	output.setNumber(3,s)
end