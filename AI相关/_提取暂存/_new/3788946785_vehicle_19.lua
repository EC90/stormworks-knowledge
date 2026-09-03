-- source: steam id 3788946785 / vehicle.xml block#19
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788946785
iN=input.getNumber
kp=0
ki=0.075
kd=0.1
I=0
e0=0
out = 0
function onTick()
	on = input.getBool(1)
	if on then
	V = iN(1)
	SP = iN(2)
	Tilt = iN(3)
	
	e = SP - V
	if math.abs(V) < 0.7 and math.abs(Tilt) < 0.02 then 
	I = math.min(math.max(I+e,-5),5)
	kd=10
	else
	I=0
	kd=0
	end
	D = e - e0
	e0 = e
	
	out = kp*e + kd*D + ki*I

	end
	out = math.min(math.max(out,-1),1)
	output.setNumber(1,out)
end


