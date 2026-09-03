-- source: steam id 1969765716 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
function onTick()
	--Bank = input.getNumber(11) * 2 * math.pi
	--Pitch = input.getNumber(12) * 2 * math.pi
	P = input.getNumber(12) * 360
	B0 = input.getNumber(11)
	pi = math.pi
	pi2 = math.pi * 2
	B = (math.asin((math.sin(B0*pi2))/(math.sin((90-P)*(pi/180)))))*(180/pi)
	Up = input.getNumber(13)
	
	if Up < 0 then B = 180-B end
	--(asin((sin(x*pi2))/(sin((90-y)*(pi/180)))))*(180/pi)
	output.setNumber(23, B)
	output.setNumber(24, P)
end


function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()					
	C = w/2
	M = h/2
	BR = math.rad(B)
	SB = math.sin(BR)
	CB = math.cos(BR)
	IC = C + (P*SB) * w/180
	IM = M + (P*CB) * w/180
	L = (w+h)*2
	
	--screen.setColor(0, 255, 0, 200)
	--screen.drawText(0, 0, B)
	
	screen.setColor(32, 64, 96, 200)
	screen.drawTriangleF(-CB*L+IC, SB*L+IM, CB*L+IC, -SB*L+IM, -SB*L+IC, -CB*L+IM)
	
	screen.setColor(32, 16, 0, 200)
	screen.drawTriangleF(-CB*L+IC, SB*L+IM, CB*L+IC, -SB*L+IM, SB*L+IC, CB*L+IM)
	
		
	screen.setColor(255, 0, 0, 255)
	Xline(-90, 10, 2*w/32)
	Xline(90, 10, 2*w/32)

	
	screen.setColor(255, 255, 255, 160)
	subline(-15*w/180*SB, -15*h/180*CB, 2*w/32)
	subline(-30*w/180*SB, -30*h/180*CB, 4*w/32)
	subline(-45*w/180*SB, -45*h/180*CB, 2*w/32)
	subline(-60*w/180*SB, -60*h/180*CB, 6*w/32)
	subline(-75*w/180*SB, -75*h/180*CB, 2*w/32)
	
	subline(15*w/180*SB, 15*h/180*CB, 2*w/32)
	subline(30*w/180*SB, 30*h/180*CB, 4*w/32)
	subline(45*w/180*SB, 45*h/180*CB, 2*w/32)
	subline(60*w/180*SB, 60*h/180*CB, 6*w/32)
	subline(75*w/180*SB, 75*h/180*CB, 2*w/32)

	screen.setColor(255, 120, 0, 160)
	screen.drawTriangleF(w/2 - 13*w/32*SB,
	 h/2 - 13*h/32*CB,
	 w/2 - 10*w/32*math.sin(BR-1/6),
	 h/2 - 10*h/32*math.cos(BR-1/6),
	 w/2 - 10*w/32*math.sin(BR+1/6),
	 h/2 - 10*h/32*math.cos(BR+1/6))

	

end
		
function subline(X, Y, len)
	screen.drawLine((-len*CB)+X+IC, (len*SB)+Y+IM, (len*CB)+X+IC, (-len*SB)+Y+IM)	
end
	
function Xline(deg, degD, len)
	X1 = (deg - degD) * w/180 * SB
	Y1 = (deg - degD) * h/180 * CB
	X2 = (deg + degD) * w/180 * SB
	Y2 = (deg + degD) * h/180 * CB
	screen.drawLine((-len*CB)+X1+IC, (len*SB)+Y1+IM, (len*CB)+X2+IC, (-len*SB)+Y2+IM)
	screen.drawLine((-len*CB)+X2+IC, (len*SB)+Y2+IM, (len*CB)+X1+IC, (-len*SB)+Y1+IM)
end