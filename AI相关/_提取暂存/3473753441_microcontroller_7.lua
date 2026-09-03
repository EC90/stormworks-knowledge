-- source: steam id 3473753441 / microcontroller.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3473753441
-- matrix's are tables 

-- {a,b,c,d,e,f,g,h,i} =
-- [a b c]
-- [c d f]
-- [g h i]

-- vectors are also tables

-- {x,y,z} = 
-- (x)
-- |y|
-- (z)

function onTick()
	thetaX = -input.getNumber(1)
	thetaY = -input.getNumber(2)
	thetaZ = -input.getNumber(3)
	mode = input.getBool(1)
	inV = {}
	inV.x = input.getNumber(4)
	inV.y = input.getNumber(5)
	inV.z = input.getNumber(6)
	Mr = multiply(rotMatrix(1,-thetaX),multiply(rotMatrix(3,-thetaZ),rotMatrix(2,-thetaY)))
	outV = transform(Mr, inV)
	output.setNumber(1,outV.x)
	output.setNumber(2,outV.y)
	output.setNumber(3,outV.z)
end
	
	
function transform(M, v)
	x = M[1]*v.x + M[2]*v.y + M[3]*v.z
	y = M[4]*v.x + M[5]*v.y + M[6]*v.z
	z = M[7]*v.x + M[8]*v.y + M[9]*v.z
	vo = {}
	vo.x = x
	vo.y = y
	vo.z = z
	return vo
end


function fromS(v1, v2, v3)
	M = {}
	M[1] = v1.x
	M[2] = v2.x
	M[3] = v3.x
	M[4] = v1.y
	M[5] = v2.y
	M[6] = v3.y
	M[7] = v1.z
	M[8] = v2.z
	M[9] = v3.z
	return M
end


function fromL(vs)
	M = {}
	M[1] = vs[1].x
	M[2] = vs[2].x
	M[3] = vs[3].x
	M[4] = vs[1].y
	M[5] = vs[2].y
	M[6] = vs[3].y
	M[7] = vs[1].z
	M[8] = vs[2].z
	M[9] = vs[3].z
	return M
end


function to(M)
	vos = {}
	vo1 = {}
	vo2 = {}
	vo3 = {}
	vo1.x = M[1]
	vo1.y = M[4]
	vo1.z = M[7]
	vo2.x = M[2]
	vo2.y = M[5]
	vo2.z = M[8]
	vo3.x = M[3]
	vo3.y = M[6]
	vo3.z = M[9]
	vos[1] = vo1
	vos[2] = vo2
	vos[3] = vo3
	return vos
end


function multiply(M1, M2)
	vs = to(M2)
	vos = {}
	for i=1,3 do
		vos[i] = transform(M1, vs[i])
	end
	return fromL(vos)
end


function rotMatrix(axis, angle)
	M = {}
	cos = math.cos(angle)
	sin = math.sin(angle)
	if(axis==1) then
		M[1] = 1
		M[2] = 0
		M[3] = 0
		M[4] = 0
		M[5] = cos
		M[6] = -sin
		M[7] = 0
		M[8] = sin
		M[9] = cos
	elseif(axis==2) then
		M[1] = cos
		M[2] = 0
		M[3] = sin
		M[4] = 0
		M[5] = 1
		M[6] = 0
		M[7] = -sin
		M[8] = 0
		M[9] = cos
	else
		M[1] = cos
		M[2] = -sin
		M[3] = 0
		M[4] = sin
		M[5] = cos
		M[6] = 0
		M[7] = 0
		M[8] = 0
		M[9] = 1
	end
	return M
end
	
	