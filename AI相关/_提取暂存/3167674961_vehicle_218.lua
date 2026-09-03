-- source: steam id 3167674961 / vehicle.xml block#218
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
function onTick()
tau = 2 * math.pi
x = input.getNumber(4)
y = input.getNumber(5)
z = input.getNumber(6)
cx, sx = math.cos(x), math.sin(x)
cy, sy = math.cos(y), math.sin(y)
cz, sz = math.cos(z), math.sin(z)
m00 = cy*cz
m01 = -cx*sz + sx*sy*cz
m02 = sx*sz + cx*sy*cz
m10 = cy*sz
m11 = cx*cz + sx*sy*sz
m12 = -sx*cz + cx*sy*sz
m20 = -sy
m21 = sx*cy
m22 = cx*cy
tilt_x = math.atan(m10, math.sqrt(m00*m00 + m20*m20)) / tau
tilt_y = math.atan(m11, math.sqrt(m01*m01 + m21*m21)) / tau
tilt_z = math.atan(m12, math.sqrt(m02*m02 + m22*m22)) / tau
compass_x = math.atan(m00, m20) / -tau
compass_y = math.atan(m01, m21) / -tau
compass_z = math.atan(m02, m22) / -tau
ax = input.getNumber(10)
ay = input.getNumber(11)
az = input.getNumber(12)
angular_x = m00*ax + m10*ay + m20*az
angular_y = m01*ax + m11*ay + m21*az
angular_z = m02*ax + m12*ay + m22*az
output.setNumber(1, -tilt_x)
end