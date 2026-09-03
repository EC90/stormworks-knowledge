-- source: steam id 2778980873 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2778980873
ipGN = input.getNumber
ipGB = input.getBool
pGN = property.getNumber
oSN = output.setNumber
pi2 = math.pi*2
pitch = 0
yaw = 0
thresh = pGN("JTAC Targeting Deadzone [M]")
seatp = 0
seaty = 0
seatz = 0
pitchcr = 0
yawcr = 0
sty = 0
stp = 0
stz = 0
function onTick()

targetx = ipGN(1)
targety = ipGN(2)
targetz = -ipGN(3)

x = ipGN(4)
y = ipGN(5)
z = -ipGN(6)
comp = ipGN(7)
pitchcr = ipGN(8)
yawcr = ipGN(9)

seaty = ipGN(10)*pGN("Yaw Sensitivity")
seatp = ipGN(11)*pGN("Pitch Sensitivity")
seatz = ipGN(12)*pGN("Zoom Sensitivity")

elev = ipGN(13)
range = ipGN(14)

stab = ipGN(15)
yclamp = ipGN(16)
yclamp2 = ipGN(17)

seat = ipGB(10)
laser = ipGB(11)
ed = ipGB(12)
retract = ipGB(13)
recieve = ipGB(14)

if laser and ed then
	azi = comp*-1
	lelev = elev*math.pi*2
	lazi = azi*math.pi*2
	lx=range*math.cos(lelev)*math.sin(lazi)+x
	ly=range*math.cos(lelev)*math.cos(lazi)+y
	lz=range*math.sin(lelev)-z
	output.setBool(28, range >= 4000)
	output.setBool(29, laser)
else
lx = 0
ly = 0
lz = 0
end

stz= clamp(stz+(seatz*0.0055), 0,1)

if not seat and ed and retract then
	dx = targetx - x
	dy = targety - y
	dz = targetz - z
	distance = math.sqrt(dx^2+dy^2+dz^2)
	azimuth = math.atan(dx,dy)/pi2 
	pitch = (math.asin(dz/distance)/pi2) - pitchcr*2	
	yaw = (azimuth+comp+0.5)%1-0.5
	yaw = -yaw
end
	
	if (targetx == 0 and targety == 0 and targetz == 0) or (targetx >=x - thresh and targetx <=x + thresh and targety >=y - 	thresh and targety <=y + thresh) or not ed then
		pitch = clamp(pitch*0.1, 1*(0-pitchcr), 1*(0-pitchcr))
		yaw = clamp(yaw*0.1, 1*(0-yawcr), 1*(0-yawcr))
	end


if seat and ed and retract then
	stp=stp+(seatp*(0.0026 - (stz*0.0025)))
	sty=sty+(seaty*(0.0026 - (stz*0.0025)))
	pitch = -stp - pitchcr * 2.5 + (stab*2) 
	yaw = -sty - yawcr * 2.5
else
	stp=0
	sty=0	
end



oSN(1, lx)
oSN(2, ly)
oSN(3, lz)
oSN(10, clamp(yaw, math.max(1*(-yclamp-yawcr), -0.4), math.min(1*(yclamp2-yawcr), 0.4)))
oSN(11, clamp(pitch, 1*(-0.1-pitchcr), 1*(0.03-pitchcr)))
oSN(12, stz)
oSN(30, elev)
end

function clamp(x, y, z)
return math.max(y, math.min(x, z))
end