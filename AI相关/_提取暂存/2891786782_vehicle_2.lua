-- source: steam id 2891786782 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2891786782
--default values
xold1 = 0
yold1 = 0
xold2 = 0
yold2 = 0
xold3 = 0
yold3 = 0
xold4 = 0
yold4 = 0
xold5 = 0
yold5 = 0
xold6 = 0
yold6 = 0
xold7 = 0
yold7 = 0
xold8 = 0
yold8 = 0
xold9 = 0
yold9 = 0
xnew = 0
ynew = 0
targnum = 0

--code aliases for minimizing the script
igb = input.getBool
ign = input.getNumber
ssc = screen.setColor
sdr = screen.drawRect
sdt = screen.drawText


function onTick()

	--get FOV angle
	xt = (property.getNumber("HUD Field of View"))*(100)
	yt = -(xt)
	
	--get maximum missile range
	maxran = property.getNumber("Missile range in KM")
	
	--get jitter reduction setting
	jitred = property.getBool("Target 1 jitter reduction")
	
	--get target number color setting
	ttclr = property.getBool("Target number text color")
	
	--get hud tinting setting
	tint = property.getBool("HUD tint")
	
	--get radar data
	targ1 = igb(1)
	targ2 = igb(2)
	targ3 = igb(3)
	targ4 = igb(4)
	targ5 = igb(5)
	targ6 = igb(6)
	targ7 = igb(7)
	targ8 = igb(8)
	dist = ign(1)
	x1 = ign(2)
	y1 = ign(3)
	x2 = ign(6)
	y2 = ign(7)
	x3 = ign(10)
	y3 = ign(11)
	x4 = ign(14)
	y4 = ign(15)
	x5 = ign(18)
	y5 = ign(19)
	x6 = ign(22)
	y6 = ign(23)
	x7 = ign(26)
	y7 = ign(27)
	x8 = ign(30)
	y8 = ign(31)
	
	--jitter reduction
	xnew = (xold1+xold2+xold3+xold4+xold5+xold6+xold7+xold8+xold9+x1)*0.1
	ynew = (yold1+yold2+yold3+yold4+yold5+yold6+yold7+yold8+yold9+y1)*0.1
	xold9 = xold8
	yold9 = yold8
	xold8 = xold7
	yold8 = yold7
	xold7 = xold6
	yold7 = yold6
	xold6 = xold5
	yold6 = yold5
	xold5 = xold4
	yold5 = yold4
	xold4 = xold3
	yold4 = yold3
	xold3 = xold2
	yold3 = yold2
	xold2 = xold1
	yold2 = yold1
	xold1 = x1
	yold1 = y1
	
	--convert distance from meters to km, and restrict to 1 decimal place and 9.9km
	dist = (math.floor(dist/100))/10
	if dist > 9.86 then
		dist = 9.9
	end
	
	--convert radar data to screen position
	x0 = xnew*xt
	y0 = ynew*yt
	x1 = x1*xt
	y1 = y1*yt
	x2 = x2*xt
	y2 = y2*yt
	x3 = x3*xt
	y3 = y3*yt
	x4 = x4*xt
	y4 = y4*yt
	x5 = x5*xt
	y5 = y5*yt
	x6 = x6*xt
	y6 = y6*yt
	x7 = x7*xt
	y7 = y7*yt
	x8 = x8*xt
	y8 = y8*yt
	
end

function onDraw()
	
	--screen tinting
	if tint == true then
		ssc(15, 15, 0)
		screen.drawClear()
	end
	
	--get screen size
	w = screen.getWidth()
	h = screen.getHeight()
	
	--draw center square (green)
	ssc(0, 255, 0)
	sdr((w/2)-4, (h/2)-12, 7, 7)
	
	--draw outline square (orange)
	ssc(255, 128, 0)	
	sdr((w/2)-30, (h/2)-32, 59, 51)
	
	--target number exception for one target (because targ2 is solved before targ1)
	if targ1 == true then
		targnum = 1
	end
	
	--draw targets 2-8 (orange)
	screen.setColor(255, 128, 0, 128)
	if targ2 == true then
		targnum = 2
		sdr((w/2)-3+x2, (h/2)-11+y2, 3, 3)
	end
	if targ3 == true then
		targnum = 3
		sdr((w/2)-3+x3, (h/2)-11+y3, 3, 3)
	end
	if targ4 == true then
		targnum = 4
		sdr((w/2)-3+x4, (h/2)-11+y4, 3, 3)
	end
	if targ5 == true then
		targnum = 5
		sdr((w/2)-3+x5, (h/2)-11+y5, 3, 3)
	end
	if targ6 == true then
		targnum = 6
		sdr((w/2)-3+x6, (h/2)-11+y6, 3, 3)
	end
	if targ7 == true then
		targnum = 7
		sdr((w/2)-3+x7, (h/2)-11+y7, 3, 3)
	end
	if targ8 == true then
		targnum = 8
		sdr((w/2)-3+x8, (h/2)-11+y8, 3, 3)
	end
	
	--draw target 1 (red)
	if targ1 == true then
		ssc(255, 0, 0)
		
		--smooth target (if enabled)
		if jitred == true then
			sdr((w/2)-3+x0, (h/2)-11+y0, 5, 5)
			ssc(255, 0, 0, 128)
		end
		
		sdr((w/2)-3+x1, (h/2)-11+y1, 5, 5) --accurate target
		ssc(255, 0, 0) --revert to red
		
		--change distance text to green when within range
		if dist < maxran then
			ssc(0, 255, 0)
		end
		
		--draw target distance text
		sdt((w/2)+4+x0, (h/2)-10+y0, dist)
		
		--change target number color on setting
		if ttclr == true then
			ssc(0, 255, 0)
		end
		
		--draw target number text
		sdt((w/2)-22, (h/2)+25, "Targets:")
		sdt((w/2)+17, (h/2)+25, targnum)
	end
	
end