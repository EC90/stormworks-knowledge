-- source: steam id 3167674961 / vehicle.xml block#74
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
function onTick()
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
tilt_x = math.atan(m10, math.sqrt(m00*m00 + m20*m20)) / (math.pi*2)
output.setNumber(1, tilt_x*0.2)
end