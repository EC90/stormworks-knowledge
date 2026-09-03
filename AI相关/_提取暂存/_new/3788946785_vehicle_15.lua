-- source: steam id 3788946785 / vehicle.xml block#15
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788946785
up = 0
old = 0

coef = 0.0005
function onTick()
	Alt = input.getNumber(1)
	seat = input.getBool(1)
			
	delAlt = Alt - old
	coef = math.min(math.max(math.abs(Alt),0.0000000000),0.001)	 
		if (Alt<0 and delAlt<0)  and seat then
			up = up + coef
		elseif (Alt>0 and delAlt>0) and seat  then
			up = up - coef
		elseif (Alt>0 and delAlt<0 and Alt<0.0005) and seat  then
			up = up + coef*0.7
		elseif (Alt<0 and delAlt>0 and Alt>-0.0005) and seat  then
			up = up - coef*0.7
		elseif (Alt>0 and delAlt<0 and Alt>0.0006) and seat  then
			up = up - coef*1.5
		elseif (Alt<0 and delAlt>0 and Alt<-0.0006) and seat  then
			up = up + coef*1.5
		end		
	up = math.min(math.max(up,-0.2),0.2)
	old = Alt
	output.setNumber(1, up)		
end

