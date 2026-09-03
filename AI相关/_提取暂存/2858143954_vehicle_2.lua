-- source: steam id 2858143954 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2858143954

function onTick()

	x1 = input.getNumber(1)
	y1 = input.getNumber(2)
	x2 = input.getNumber(3)
	y2 = input.getNumber(4)
	z1 = input.getNumber(5)	
	wid=60

	vx=x2-x1
	vy=y2-y1
	px=vy
	py=-1*vx
	len=math.sqrt(px*px+py*py)
	nx=px/len
	ny=py/len
	r1x=x1+nx*wid/2
	r1y=y1+ny*wid/2
	r2x=x1-nx*wid/2
	r2y=y1-ny*wid/2
	r3x=x2+nx*wid/2
	r3y=y2+ny*wid/2
	r4x=x2-nx*wid/2
	r4y=y2-ny*wid/2

	output.setNumber(1, x1)
	output.setNumber(2, y1)
	output.setNumber(3, x2)
	output.setNumber(4, y2)
	output.setNumber(5, r1x)
	output.setNumber(6, r1y)
	output.setNumber(7, r2x)
	output.setNumber(8, r2y)
	output.setNumber(9, r3x)
	output.setNumber(10, r3y)
	output.setNumber(11, r4x)
	output.setNumber(12, r4y)	
	output.setNumber(13, z1)

end
