-- source: steam id 3789438208 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3789438208
kP = property.getNumber("P")
kI = property.getNumber("I")
kD = property.getNumber("D")
dt=0
P=0
I=0
D=0
Error=0

function onTick()
	Active  = input.getBool(1)
	
	if Active then
	
		Setpoint = input.getNumber(1)
		Process = input.getNumber(2)
		Last_Error = Error
		Error = Setpoint - Process
		dt = dt+(1/60)
	
		P = Error
		I = I + Error
		D = Error-Last_Error
		
		output.setNumber(1, (kP*P)+(kI*I)+(kD*D))
		output.setNumber(2, kP*P)
		output.setNumber(3, kI*I)
		output.setNumber(4, kD*D)
		
	else
		output.setNumber(1, 0)
	end
end