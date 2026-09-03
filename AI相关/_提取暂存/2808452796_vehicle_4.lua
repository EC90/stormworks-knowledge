-- source: steam id 2808452796 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2808452796
igN=input.getNumber
igB=input.getBool
sdL=screen.drawLine
sdTB=screen.drawTextBox

function dHor(tiltf, tiltl, tiltt, off, gap, width, doff, pov)
	tiltf=tiltf-off/360
	
	xoff=48+modX
	yoff=35-modY
	
	hor=math.tan(tiltf*2*math.pi)*pov/0.57*61
	if math.abs(hor)<=80 then
		hord=math.tan((tiltf+doff)*2*math.pi)*pov/0.57*61
	
		horx=hor*math.sin(tiltl*2*math.pi)+xoff
		hory=hor*math.cos(tiltl*2*math.pi)+yoff
		hordx=hord*math.sin(tiltl*2*math.pi)+xoff
		hordy=hord*math.cos(tiltl*2*math.pi)+yoff
	
		horyr=hory+math.sin(-tiltl*2*math.pi)*width/2
		horxr=horx+math.cos(-tiltl*2*math.pi)*width/2
		horyl=hory-math.sin(-tiltl*2*math.pi)*width/2
		horxl=horx-math.cos(-tiltl*2*math.pi)*width/2
	
		horyrs=hory+math.sin(-tiltl*2*math.pi)*gap/2
		horxrs=horx+math.cos(-tiltl*2*math.pi)*gap/2
		horyls=hory-math.sin(-tiltl*2*math.pi)*gap/2
		horxls=horx-math.cos(-tiltl*2*math.pi)*gap/2
	
		hordyrs=hordy+math.sin(-tiltl*2*math.pi)*width/2
		hordxrs=hordx+math.cos(-tiltl*2*math.pi)*width/2
		hordyls=hordy-math.sin(-tiltl*2*math.pi)*width/2
		hordxls=hordx-math.cos(-tiltl*2*math.pi)*width/2
	
		sdL(horxrs, horyrs, horxr, horyr)
		sdL(horxls, horyls, horxl, horyl)
		
		sdL(horxl, horyl, hordxls, hordyls)
		sdL(horxr, horyr, hordxrs, hordyrs)
	end
end






modX = 0
modY = 0

function onTick()
	tiltf = igN(1)
	tiltl = igN(2)
	tiltt = igN(3)
	compass= igN(4)
	altitude = igN(5)
	speedf = igN(6)
	speedv = igN(7)
	speedh = igN(8)
	lookX = igN(9)
	lookY = igN(10)
	
	ARM = igB(1)
	SAS = igB(2)
	
	modX = lookX*180  								--parallax correction (tune these values for different HUD-to-seat distances)
	modY = lookY*390
		
	poff=1.5   													-- HUD-to-seat distance  (default 1.5)
		
	if tiltf < 0 then
		tiltl=tiltl*(1-math.tan(tiltf*2*math.pi))
	else
		tiltl=tiltl*(1+math.tan(tiltf*2*math.pi))
	end
	
	if tiltt < 0 then
		tiltf=-tiltf
		tiltl=-tiltl
	end
	
	AoA=math.atan(speedv, speedf)   								--angle of attack
	AoAh=math.atan(speedh, speedf)
	
	if compass>0 then
		head=360*(1-compass)										--compass heading in degrees
	else
		head=compass*-360
	end
end




function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()					
	screen.setColor(0, 155, 0)
	
	dHor(tiltf, tiltl, tiltt, 0, 20, 60, 0.004*math.abs(tiltt)/tiltt, poff)    --horizon
	
	for i=-90, -10, 10 do
		dHor(tiltf, tiltl, tiltt, i, 14, 34, -0.004, poff)					--levels below horizon
	end
	
	for i=90, 10, -10 do
		dHor(tiltf, tiltl, tiltt, i, 14, 34, 0.004, poff)					--levels above horizon
	end
	
	DIY=35+math.tan(AoA)*1.5/0.57*61-modY									--angle of attack
	DIX=48+math.tan(AoAh)*1.5/0.57*61+modX
	
	if math.abs(speedf)>1 then
		screen.drawCircle(DIX, DIY, 3)							
		sdL(DIX+3, DIY, DIX+8, DIY)
		sdL(DIX-3, DIY, DIX-8, DIY)
		sdL(DIX, DIY-3, DIX, DIY-6)
	end
	
	sdTB(1, 84, 6, 8, "M", 0, 0)
	sdTB(7, 84, 22, 8, math.abs(math.floor(speedf/3.4)/100), 0, 0)			--Mach number
	
	screen.drawRect(1, 1, 17, 8)
	sdTB(2, 2, 17, 8, math.abs(math.floor(speedf*1.9438)), 0, 0)			--speed in knots
	
	screen.drawRect(73, 1, 22, 8)
	sdTB(76, 2, 22, 8, math.floor(altitude)%10000, 0, 0)					--altitude in meters
	
	screen.drawRect(40, 83, 17, 8)
	sdTB(41, 84, 17, 8, math.floor(head), 0, 0)							--heading in degrees
	
	if ARM then
		screen.drawText(80, 85, "ARM")									--Master Arm
	end
	if SAS then
		screen.drawText(80, 78, "SAS")									--Stability Augmentation System
	end

	screen.setColor(100, 0, 0)
	screen.drawRect(46+modX, 33-modY, 3, 3)								--Aiming reticle


end