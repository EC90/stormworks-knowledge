-- source: steam id 2868626488 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2868626488
i  = input
o  = output
m  = math
gn = i.getNumber
sn = o.setNumber
pi = m.pi
pi2= pi*2
si = m.sin
co = m.cos
as = m.asin
abs= m.abs

phi   = 0
theta = 0

function onTick()
	xt = gn(1)
	yt = gn(2)
	zt = gn(3)
	cm = gn(4)
	
	theta = xt*pi2
	
	phi = -as(si(yt*pi2)/co(xt*pi2))
	if zt > 0 then
		phi = (-yt/abs(yt))*pi - phi
	end
	
	if cm<=0 then
		psi = -(cm*360)
	else
		psi = 360*(1-cm)
	end
	
	phi = phi*180/pi
	theta =theta*180/pi
	
	sn(1,phi)
	sn(2,theta)
	sn(3,psi)
	
end