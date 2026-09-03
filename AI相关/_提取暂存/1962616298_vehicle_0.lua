-- source: steam id 1962616298 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1962616298
function onTick()
	p = input.getNumber(1) -- pitch angle
	ba1 = input.getNumber(2) -- bank angle
	inv = input.getNumber(3) -- inverted angle
	if inv>0 then -- check if artificial horizon should be upside down
		ba = ba1 
	elseif ba1>0 and inv<0 then 
		ba = 90+(90-ba1)
	elseif ba1<0 and inv<0 then 
		ba = -90+(-90-ba1)
	else 
		ba = ba1
	end
end

function onDraw()
		screen.setColor(0, 0, 0,0)
	screen.drawClear()
	w = screen.getWidth()
	h = screen.getHeight()
	a1 = h/2 -- center height
	if w<65 then
		b1 = w/2 -- center width
	else
		b1 = (w/2)-10
	end
	--p1 = p+a
	r = 1.5*w
	o = math.rad(ba) -- bank angle radians
	soh = math.sin(o)
	cah = math.cos(o)
	a = a1+(p*cah) -- center of rotation for horizon x value
	b = b1+(p*soh) -- center of rotation for horizon y value
	y1 = r*soh
	x1 = r*cah
	r2 = 90+(2*w)
	x2 = r2*soh
	y2 = r2*cah

	screen.setColor(255, 255, 255)
	--screen.drawText(4, 4, p) -- displays pitch angle on screen
	--screen.drawText(4, 10, ba) -- displays bank angle on screen
	screen.drawLine(-x1+b, y1+a-cah, x1+b, -y1+a-cah) -- horizon
	
	cx = -10*soh
	cy = -10*cah
	screen.drawLine((-4*cah)+cx+b, (4*soh)+cy+a, (4*cah)+cx+b, (-4*soh)+cy+a) -- 10 u
	cx = -20*soh
	cy = -20*cah
	screen.drawLine((-4*cah)+cx+b, (4*soh)+cy+a, (4*cah)+cx+b, (-4*soh)+cy+a) -- 20 u
	--screen.drawLine(b-4, p1+20, b+4, p1+20) -- 20 u
	cx = -30*soh
	cy = -30*cah
	screen.drawLine((-4*cah)+cx+b, (4*soh)+cy+a, (4*cah)+cx+b, (-4*soh)+cy+a) -- 30 u
	cx = -40*soh
	cy = -40*cah
	screen.drawLine((-4*cah)+cx+b, (4*soh)+cy+a, (4*cah)+cx+b, (-4*soh)+cy+a) -- 40 u
	cx = -50*soh
	cy = -50*cah
	screen.drawLine((-4*cah)+cx+b, (4*soh)+cy+a, (4*cah)+cx+b, (-4*soh)+cy+a) -- 50 u
	cx = -60*soh
	cy = -60*cah
	screen.drawLine((-4*cah)+cx+b, (4*soh)+cy+a, (4*cah)+cx+b, (-4*soh)+cy+a) -- 60 u
	cx = -70*soh
	cy = -70*cah
	screen.drawLine((-4*cah)+cx+b, (4*soh)+cy+a, (4*cah)+cx+b, (-4*soh)+cy+a) -- 70 u
	cx = -80*soh
	cy = -80*cah
	screen.drawLine((-4*cah)+cx+b, (4*soh)+cy+a, (4*cah)+cx+b, (-4*soh)+cy+a) -- 80 u
	
	cx = 10*soh
	cy = 10*cah
	screen.drawLine((-4*cah)+cx+b, (4*soh)+cy+a, (4*cah)+cx+b, (-4*soh)+cy+a) -- 10 d
	--screen.drawLine(b - 4, p1 - 10, b + 4, p1 - 10) -- 10 d
	cx = 20*soh
	cy = 20*cah
	screen.drawLine((-4*cah)+cx+b, (4*soh)+cy+a, (4*cah)+cx+b, (-4*soh)+cy+a) -- 20 d
	cx = 30*soh
	cy = 30*cah
	screen.drawLine((-4*cah)+cx+b, (4*soh)+cy+a, (4*cah)+cx+b, (-4*soh)+cy+a) -- 30 d
	cx = 40*soh
	cy = 40*cah
	screen.drawLine((-4*cah)+cx+b, (4*soh)+cy+a, (4*cah)+cx+b, (-4*soh)+cy+a) -- 40 d
	cx = 50*soh
	cy = 50*cah
	screen.drawLine((-4*cah)+cx+b, (4*soh)+cy+a, (4*cah)+cx+b, (-4*soh)+cy+a) -- 50 d
	cx = 60*soh
	cy = 60*cah
	screen.drawLine((-4*cah)+cx+b, (4*soh)+cy+a, (4*cah)+cx+b, (-4*soh)+cy+a) -- 60 d
	cx = 70*soh
	cy = 70*cah
	screen.drawLine((-4*cah)+cx+b, (4*soh)+cy+a, (4*cah)+cx+b, (-4*soh)+cy+a) -- 70 d
	cx = 80*soh
	cy = 80*cah
	screen.drawLine((-4*cah)+cx+b, (4*soh)+cy+a, (4*cah)+cx+b, (-4*soh)+cy+a) -- 80 d
	
	screen.setColor(255, 0, 0)
	cxu1 = -86*soh
	cyu1 = -86*cah
	cxu2 = -94*soh
	cyu2 = -94*cah
	
	cxd1 = 86*soh
	cyd1 = 86*cah
	cxd2 = 94*soh
	cyd2 = 94*cah
	screen.drawLine((-7*cah)+cxu1+b, (7*soh)+cyu1+a, (7*cah)+cxu2+b, (-7*soh)+cyu2+a) -- 90 degree X
	screen.drawLine((-7*cah)+cxu2+b, (7*soh)+cyu2+a, (7*cah)+cxu1+b, (-7*soh)+cyu1+a)
	screen.drawLine((-7*cah)+cxd1+b, (7*soh)+cyd1+a, (7*cah)+cxd2+b, (-7*soh)+cyd2+a) -- -90 degree X
	screen.drawLine((-7*cah)+cxd2+b, (7*soh)+cyd2+a, (7*cah)+cxd1+b, (-7*soh)+cyd1+a)
	
	screen.setColor(255, 255, 0)
	screen.drawTriangleF(b1, a1, b1-6, a1+5, b1+6, a1+5) -- center piece of artificial horizon
	screen.drawLine(b1-14, a1, b1-7, a1)
	screen.drawLine(b1+7, a1, b1+14, a1)
end