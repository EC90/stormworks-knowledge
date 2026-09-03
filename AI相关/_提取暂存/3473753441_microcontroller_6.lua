-- source: steam id 3473753441 / microcontroller.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3473753441
theta = 0
function onTick()
	x = input.getNumber(1)
	y = input.getNumber(2)
	z = input.getNumber(3)
	theta = (y-128000)/100000
	
	output.setNumber(1,X(x,y,z))
	output.setNumber(2,z)
	output.setNumber(3,Z(x,y,z))
end
	
function X(a,b,c)
	if(b<128000) then
		return a
	elseif(b>442159.265359) then
		return 200000-a
	else
		return 100000-((100000-a)*math.cos(theta))
	end
end
	
function Z(a,b,c)
	if(b<128000) then
		return b
	elseif(b>442159.265359) then
		return 570159.265359-b
	else
		return 128000+((100000-a)*math.sin(theta))
	end
end