-- source: steam id 3473753441 / microcontroller.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3473753441
-- Tick function that will be executed every logic tick
function onTick()
	progradeX = input.getNumber(1)
	progradeY = input.getNumber(2)
	progradeZ = input.getNumber(3)
	downX = -input.getNumber(4)
	downY = input.getNumber(5)
	downZ = input.getNumber(6)
	normalX,normalY,normalZ = normalize(cross(progradeX,progradeY,progradeZ,downX,downY,downZ))
	radialX,radialY,radialZ = cross(normalX,normalY,normalZ,progradeX,progradeY,progradeZ)
	
	
	output.setNumber(1,progradeX)
	output.setNumber(2,progradeY)
	output.setNumber(3,progradeZ)
	output.setNumber(4,normalX)
	output.setNumber(5,normalY)
	output.setNumber(6,normalZ)
	output.setNumber(7,radialX)
	output.setNumber(8,radialY)
	output.setNumber(9,radialZ)
end
	
function cross(x1,y1,z1,x2,y2,z2)
	return y1*z2 - z1*y2, z1*x2 - x1*z2, x1*y2 - y1*x2
end
	
function magnitude(x,y,z)
	r = math.sqrt((x*x)+(y*y)+(z*z))
	if(r==0) then 
		r = 0.001 
	end
	return r
end
	
function normalize(x,y,z)
	return x/magnitude(x,y,z),y/magnitude(x,y,z),z/magnitude(x,y,z)
end