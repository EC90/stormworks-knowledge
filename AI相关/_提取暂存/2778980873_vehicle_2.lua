-- source: steam id 2778980873 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2778980873
pN=property.getNumber
iN=input.getNumber
oN=output.setNumber
oB=output.setBool
abs=math.abs
asin=math.asin
atan=math.atan
pi2 = math.pi*2
pitch = 0
yaw = 0
thresh = 5
offset = 0
min = 0
max = 0
function onTick()

targetx = iN(1)
targety = iN(2)
targetz = iN(3)

x = iN(4)
y = iN(5)
z = iN(6)
comp = iN(7)
yawcr = iN(8)
tilt = iN(9)
bcomp = iN(10)
sy = iN(12)
sp = iN(13)
smy = iN(14)
smp = iN(15)
yclamp = pN("Yaw Clamp [Degrees]")
min = pN("Pitch Clamp Min [Degrees]")
max = pN("Pitch Clamp Max [Degrees]")
fclamp = pN("Fire Range [Degrees]")
ycon = property.getBool("Yaw Clamp")
yfon = property.getBool("Firing Clamp")
fg = input.getBool(1)
seatfire = input.getBool(2)
seat = input.getBool(3)
maim = input.getBool(4)
range = input.getBool(5)
yawcrd = abs(yawcr*360)

if range then
	offset = 0
else
	offset = iN(11)
end

if (fg or seatfire) then
fire = true
else
fire = false
end

if yfon then
	if yawcrd >= fclamp and (fg or seatfire) then
	fire = false
	elseif yawcrd <= fclamp and (fg or seatfire) then
	fire = true
	end
end
	
dx = targetx - x
dy = targety - y
dz = targetz - z
distance = math.sqrt(dx^2+dy^2+dz^2)
azimuth = atan(dx,dy)/pi2 
pitch = (asin(dz/distance)/pi2)

if ycon then 
yaw = clamp((azimuth+bcomp+0.5)%1-0.5, -yclamp/360, yclamp/360)-yawcr
else
yaw = (azimuth+bcomp+0.5)%1-0.5-yawcr
end

if (targetx == 0 and targety == 0 and targetz == 0) or (targetx >=x - thresh and targetx <=x + thresh and targety >=y - thresh and targety <=y + thresh) and not seat then
	pitch = 0
	yaw = -yawcr
	tilt = 0
end

if seat then 
	pitch = -sp
	yaw = sy * 0.08
	if maim then
	pitch = smp
	yaw = smy
	end
end

oN(1, clamp(yaw, -0.4, 0.4))
oN(2, clamp(((pitch + offset)*4)+(-tilt*4),min/90,max/90))
oB(1, fire)

end

function clamp(x, y, z)
return math.max(y, math.min(x, z))
end