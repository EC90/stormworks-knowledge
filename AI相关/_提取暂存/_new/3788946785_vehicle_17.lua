-- source: steam id 3788946785 / vehicle.xml block#17
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788946785
up = 0
old = 0

coef = 0.0005
function onTick()
	Alt = input.getNumber(1)
	seat = input.getBool(1)
	gyro = input.getBool(2)		
	delAlt = Alt - old
	coef = math.min(math.max(math.abs(Alt*.5),0.0000000000),0.01)	 
		if (Alt<0 and delAlt<0)  and seat then
			up = up + coef
		elseif (Alt>0 and delAlt>0) and seat  then
			up = up - coef
		elseif (Alt>0 and delAlt<0 and Alt<0.0001) and seat  then
			up = up + coef^2
		elseif (Alt<0 and delAlt>0 and Alt>-0.0001) and seat  then
			up = up - coef^2 
		elseif gyro then
			up = 0
		end		

	old = Alt
	output.setNumber(1, up)		
end

