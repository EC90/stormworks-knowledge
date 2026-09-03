-- source: steam id 3167674961 / vehicle.xml block#209
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
horizSensitivity = property.getNumber("Horizontal Sensitivity")
vertSensitivity = property.getNumber("Vertical Sensitivity")
distdive = property.getNumber("Distance To Dive")

function onTick()
	raddis=input.getNumber(1)
	lasdis=input.getNumber(25)	
	output.setBool(1,(lasdis>0 and lasdis<distdive) or raddis>0)
	if lasdis >0 then
    output.setNumber(1,input.getNumber(26)*horizSensitivity)
    output.setNumber(2,input.getNumber(27)*vertSensitivity)	
	else
	output.setNumber(1,0)
    output.setNumber(2,0)
		for i = 8, 1, -1 do
			if input.getBool(i) then
				xInput = input.getNumber(2+((i-1)*4))
				yInput = input.getNumber(3+((i-1)*4))
				distance = input.getNumber(1+((i-1)*4))
           	 output.setNumber(1,xInput*horizSensitivity)
           	 output.setNumber(2,yInput*vertSensitivity)
            	break
			end
		end
	end
end
	