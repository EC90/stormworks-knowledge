-- source: steam id 3788946785 / vehicle.xml block#16
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788946785
up = 0
old = 0
coef = 0.0005

function onTick()
	Alt = input.getNumber(1)
	seat = input.getBool(1)		
	delAlt = Alt - old
	
	coef = math.min(math.max(math.abs(0.1*Alt),0.00000000000),0.0001)	 
		if (Alt<0 and delAlt<0)  and seat then
			up = up + coef
		elseif (Alt>0 and delAlt>0) and seat  then
			up = up - coef
		elseif (Alt>0 and delAlt<0 and Alt< 0.02) and seat  then
			up = up + coef*0.5
		elseif (Alt<0 and delAlt>0 and Alt> -0.02) and seat  then
			up = up - coef*0.5
		elseif (Alt>0 and delAlt<0 and Alt> 0.03) and seat  then
			up = up - coef*0.3
		elseif (Alt<0 and delAlt>0 and Alt< -0.03) and seat  then
			up = up + coef*0.3	
		end		
				
	
	old = Alt			
	output.setNumber(1, up)		
end

