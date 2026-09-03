-- source: steam id 2936283512 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2936283512
i  = input
o  = output
m  = math
gn = i.getNumber
sn = o.setNumber
pi = m.pi
pi2= pi*2
si = m.sin
co = m.cos
ta = m.tan
as = m.asin
ac = m.acos
at = m.atan
abs= m.abs
deg= m.deg
rad= m.rad
mod= m.fmod
sq = m.sqrt
ins= table.insert
rem= table.remove

grr= {{0,0,0},{0,0,0},{0,0,0}}

function makematC(phi, the, psi)
	mar = {{co(the)*co(psi), si(phi)*si(the)*co(psi)-co(phi)*si(psi), co(phi)*si(the)*co(psi)+si(phi)*si(psi)}, {co(the)*si(psi), si(phi)*si(the)*si(psi)+co(phi)*co(psi), co(phi)*si(the)*si(psi)-si(phi)*co(psi)}, {-si(the), si(phi)*co(the), co(phi)*co(the)}}
	return mar
end

function rotate(mat, vec)
	temp = {0, 0, 0}
	for i=1, 3 do
		ali = 0
		for j=1, 3 do
			ali = ali + mat[i][j] * vec[j]
		end
		temp[i] = ali
	end
	return temp
end


function Mtrans(maa)
	for i=1, 3 do
		for j=1, 3 do
			grr[j][i] = maa[i][j]
		end
	end
	return grr
end


function onTick()

	sn(1,gn(1))--Map X
	sn(2,gn(3))--Map Y
	sn(3,gn(2))--Altitude
	
	EFB = makematC(gn(4), gn(5), gn(6))
	
	cphi = -at(EFB[2][1],EFB[2][2])
	cthe = as(EFB[2][3])
	cpsi = at(EFB[3][3], EFB[1][3])
	
	sn(4, cphi)--roll
	sn(5, cthe)--pitch
	sn(6, mod(pi2*1.25-cpsi,pi2))--nautical azimuth(North:0, clockwise, 0->+pi2) 
	sn(15,cpsi)--raw azimuth(East:0, counterclockwise, -pi<-0->+pi), for calc. use
	
	rot = {gn(10),gn(11),gn(12)}
	MAG = Mtrans(EFB)
	ang = rotate(MAG, rot)
	
	--eul = {cphi, cthe, -cpsi}
	AMS = makematC(cphi,cthe,-cpsi)
	vel = {gn(9),gn(7),-gn(8)}
	for i=1,3 do
		sn(i+6, vel[i])
	end
	--7~9  : local linear speed, x:forward +, y:right +, z:downward +
	
	sn(10, -ang[3]*pi2)
	sn(11, -ang[1]*pi2)
	sn(12,  ang[2]*pi2)
	--10~12: local angular speed, roll, pitch, yaw
	
	sn(13,gn(13))--abs. linear speed
	sn(14,gn(17))--compass, for compatibility, not recomended
	
	--tiltx = cthe/pi2
	--tilty = as(-si(cphi)*co(cthe))/pi2
	tiltz = as(-co(cphi)*co(cthe))/pi2
	
	sn(16,gn(15))--tilt x
	sn(17,gn(16))--tilt y
	sn(18,tiltz)--tilt z, for compatibility
	
	vew = rotate(AMS, vel)
	sn(19, vew[1])
	sn(20, -vew[2])
	sn(21, -vew[3])
	--19~21: world linear speed, X:East +, Y:North +, Z:upward +
	
end