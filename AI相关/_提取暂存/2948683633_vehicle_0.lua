-- source: steam id 2948683633 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2948683633
-- Tick function that will be executed every logic tick
function onTick()
physx,physy,physz = input.getNumber(4), input.getNumber(5), input.getNumber(6)

cx, sx = math.cos(physx), math.sin(physx)
cy, sy = math.cos(physy), math.sin(physy)
cz, sz = math.cos(physz), math.sin(physz)

m00, m02 = cy*cz, sx*sz + cx*sy*cz
m10, m12 = cy*sz, -sx*cz + cx*sy*sz
m20, m22 = -sy, cx*cy

tilt = {x = math.atan(m10,math.sqrt(m00^2+m20^2)) or 0,
        y = math.atan(m12,math.sqrt(m02^2+m22^2)) or 0}
output.setNumber(1,tilt.x*5)
end
