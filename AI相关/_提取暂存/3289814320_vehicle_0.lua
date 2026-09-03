-- source: steam id 3289814320 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3289814320

x=property.getNumber("RNG Seed")//1|0

pi2=math.pi

A=214013
B=2531011
M=0x7FFFFFFF

Scale=property.getNumber("Scale")

function rand()
	x=("i4"):unpack(("i8"):pack(x*A))
	x=("i4"):unpack(("i8"):pack(x+B))
	x=("i4"):unpack(("i8"):pack(x%M - (x<0 and M or 0)))

	return (((x>>16)&0x7FFF) / 0x7FFF)*2-1
end

ox,oy=rand(),rand()

function onTick()
	if input.getBool(1) then
		ox,oy=rand(),rand()
	end

	output.setNumber(1,math.atan(Scale*ox,1000)/pi2*4)
	output.setNumber(2,math.atan(Scale*oy,1000)/pi2*4)
	output.setNumber(3,x)
end

