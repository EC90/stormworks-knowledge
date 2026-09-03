-- source: steam id 2604564917 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2604564917
tau = math.pi*2
gps = {}
ang = {}
tiltSensor={} --forward, up, left

GetNumber = function(...)
	local result={}
	for i,v in ipairs({...}) do result[i]=input.getNumber(v) end
	return table.unpack(result)
end

MatrixMul = function(m1,m2) --Assuming matrix multiplication is possible
	local r = {}
	for i=1,#m2 do
		r[i] = {}
		for j=1,#m1[1] do
			r[i][j] = 0
			for k=1,#m1 do
				r[i][j] = r[i][j] + m1[k][j] * m2[i][k]
			end
		end
	end
	return r
end


function onTick()
	gps.x,gps.y,gps.z, tiltSensor.forward, tiltSensor.up, tiltSensor.left, compass = GetNumber(1,2,3, 4,5,6,7)
    OFFSET = {GetNumber(8,9,10)}

	ang.x, ang.y, ang.z=tiltSensor.forward*tau, math.asin(math.sin(tiltSensor.left*tau)/math.sin((.25-tiltSensor.forward)*tau)), compass*tau
	if tiltSensor.up < 0 then ang.y = math.pi-ang.y end

	local sx,sy,sz, cx,cy,cz = math.sin(ang.x),math.sin(ang.y),math.sin(ang.z), math.cos(ang.x),math.cos(ang.y),math.cos(ang.z)
    rotationMatrixZXY = {
        {cz*cy-sz*sx*sy,	sz*cy+cz*sx*sy,		-cx*sy},
        {-sz*cx,			cz*cx,				sx},
        {cz*sy+sz*sx*cy,	sz*sy-cz*sx*cy,		cx*cy}
    }

    offset = MatrixMul(rotationMatrixZXY, {OFFSET})[1]

	output.setNumber(1, gps.x + offset[1])
	output.setNumber(2, gps.y + offset[2])
	output.setNumber(3, gps.z + offset[3])
end