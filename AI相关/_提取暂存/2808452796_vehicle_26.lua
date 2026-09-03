-- source: steam id 2808452796 / vehicle.xml block#26
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2808452796
function onTick()
	rotationX = input.getNumber(4)
	rotationY = input.getNumber(5)
    rotationZ = input.getNumber(6)

    cx, sx = math.cos(rotationX), math.sin(rotationX)
    cy, sy = math.cos(rotationY), math.sin(rotationY)
    cz, sz = math.cos(rotationZ), math.sin(rotationZ)

    m00 = cy*cz
    m01 = -cx*sz + sx*sy*cz
    m02 = sx*sz + cx*sy*cz
    m10 = cy*sz
	m11 = cx*cz + sx*sy*sz
    m12 = -sx*cz + cx*sy*sz
    m20 = -sy
    m21 = sx*cy
    m22 = cx*cy
    tilt_x = math.atan(m10, math.sqrt(m00*m00 + m20*m20))
	tilt_y = math.atan(m11, math.sqrt(m01*m01 + m21*m21))
    tilt_z = math.atan(m12, math.sqrt(m02*m02 + m22*m22))

    roll = math.atan(math.sin(tilt_x), math.sin(-tilt_z))
	output.setNumber(1,roll*property.getNumber("Roll Stability Multiplier"))
end