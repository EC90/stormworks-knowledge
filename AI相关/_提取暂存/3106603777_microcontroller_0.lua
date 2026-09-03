-- source: steam id 3106603777 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3106603777
pi2 = math.pi*2
function onTick()
	Ax = input.getNumber(1)			 
	Ay = input.getNumber(2)
	Az = input.getNumber(3)
	
	d = input.getNumber(4)
	c = input.getNumber(5) * pi2
	t = input.getNumber(6) * pi2
	
	output.setNumber(1, d * math.cos(t) * math.sin(-c) + Ax)
	output.setNumber(2, d * math.cos(t) * math.cos(c) + Ay)
	output.setNumber(3, d * math.sin(t) + Az)





end

