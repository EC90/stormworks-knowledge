-- source: steam id 3119724150 / vehicle.xml block#59
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3119724150
-- This uses the game's basis. That is,
--     vehicle   world   color
-- x   right     east    red
-- y   up        up      green
-- z   forward   north   blue
-- Better constant.
IN=input.getNumber
OB=output.setNumber
M=math
Mc=M.cos
Ms=M.sin
Ma=M.atan
MS=M.sqrt
function onTick()
tau=2*math.pi
-- Get angles.
x=IN(4)
y=IN(5)
z=IN(6)
-- sin, 'cos I like it.
cx,sx=Mc(x),Ms(x)
cy,sy=Mc(y),Ms(y)
cz,sz=Mc(z),Ms(z)
-- Build matrix.
m00=cy*cz
m01=-cx*sz+sx*sy*cz
m02=sx*sz+cx*sy*cz
m10=cy*sz
m11=cx*cz+sx*sy*sz
m12=-sx*cz+cx*sy*sz
m20=-sy
m21=sx*cy
m22=cx*cy
-- Alternatively, compute tilts stably.
tilt_x=Ma(m10,MS(m00*m00+m20*m20))/tau
tilt_y=Ma(m11,MS(m01*m01+m21*m21))/tau
tilt_z=Ma(m12,MS(m02*m02+m22*m22))/tau
-- Compute compasses.
compass_x=Ma(m00,m20)/-tau
compass_y=Ma(m01,m21)/-tau
compass_z=Ma(m02,m22)/-tau
-- Get global angular velocities.
ax=IN(10)
ay=IN(11)
az=IN(12)
-- Transform them to the local frame.
angular_x=m00*ax+m10*ay+m20*az
angular_y=m01*ax+m11*ay+m21*az
angular_z=m02*ax+m12*ay+m22*az
OB(1,tilt_x)
OB(2,tilt_y)
OB(3,tilt_z)
OB(4,compass_x)
OB(5,compass_y)
OB(6,compass_z)
OB(7,angular_x)
OB(8,angular_y)
OB(9,angular_z)
end