-- source: steam id 2827580728 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2827580728
igN=input.getNumber
igB=input.getBool
sdL=screen.drawLine
sdT=screen.drawText
sdTB=screen.drawTextBox
sdR=screen.drawRect
pgN=property.getNumber
poff=pgN("Seat center to HUD distance")
Sunit=pgN("Speed units")
Aunit=pgN("Altitude units")

function dHor(tiltf, tiltl, tiltt, off, gap, width, doff, pov)
	tiltf=tiltf-off/360
	
	xoff=48+modX
	yoff=36-modY
	
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
mode = 1

function onTick()
	tiltf = igN(1)
	tiltl = igN(2)
	tiltt = igN(3)
	comp= igN(4)
	alt = igN(5)
	speedf = igN(6)
	speedv = igN(7)
	speedh = igN(8)
	lookX = igN(9)
	lookY = igN(10)
	
	ARM = igB(1)
	RWR = igB(2)
	
	cMode = igB(5)
	
	modX = lookX*pgN("X modifier")  								--parallax correction (tune these values for different HUD-to-seat distances)
	modY = lookY*pgN("Y modifier")
		
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
	
	if comp>0 then
		head=360*(1-comp)										--compass heading in degrees
	else
		head=comp*-360
	end
	
	if cMode then
		if mode<5 then
			mode=mode+1
		else
			mode=1
		end
	end
	output.setNumber(1,mode)
end




function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	
	if mode==5 then
		screen.setColor(0, 0, 0)
		screen.drawRectF(-1,-1,100,100)
	end
	
	screen.setColor(0, 255, 0)
	
	if mode==1 or mode==2 then
		dHor(tiltf, tiltl, tiltt, 0, 20, 60, 0.004*math.abs(tiltt)/tiltt, poff)    --horizon
	end
	
	if mode==1 then
		for i=-90, -10, 10 do
			dHor(tiltf, tiltl, tiltt, i, 14, 34, -0.004, poff)					--levels below horizon
		end
	
		for i=90, 10, -10 do
			dHor(tiltf, tiltl, tiltt, i, 14, 34, 0.004, poff)					--levels above horizon
		end
	end
	
	if mode>0 and mode<4 then
	
		DIY=36+math.tan(AoA)*1.5/0.57*61-modY									--angle of attack
		DIX=48+math.tan(AoAh)*1.5/0.57*61+modX
	
		if math.abs(speedf)>1 then
			screen.drawCircle(DIX, DIY, 3)							
			sdL(DIX+3, DIY, DIX+8, DIY)
			sdL(DIX-3, DIY, DIX-8, DIY)
			sdL(DIX, DIY-3, DIX, DIY-6)
		end
	
	
		sdTB(1, 84, 6, 8, "M", 0, 0)
		sdTB(7, 84, 22, 8, math.abs(math.floor(speedf/3.43)/100), 0, 0)			--Mach number
	
		sdR(1, 1, 17, 8)
			if Sunit==1 then
				dspeed=speedf*1.9438
			elseif Sunit==2 then
				dspeed=speedf*3.6
			end
		sdTB(2, 2, 17, 8, math.abs(math.floor(dspeed)), 0, 0)			--speed in chosen units
	
		sdR(73, 1, 22, 8)
			if Aunit==1 then
				dalt=alt*3.28
			elseif Aunit==2 then
				dalt=alt
			end
		if dalt>10000 then
			sdTB(74, 2, 22, 8, string.format("%0.0f", math.floor(dalt)/1000) .."k", 0, 0)
		else
			sdTB(74, 2, 22, 8, math.floor(dalt)%10000, 0, 0)					--altitude in chosen units
		end
	
		sdR(40, 83, 17, 8)
		sdTB(41, 84, 17, 8, math.floor(head), 0, 0)							--heading in degrees
	
		if ARM then
			sdT(80, 85, "ARM")									--Master Arm
		end
		if RWR then
			sdT(80, 78, "RWR")
		end

		sdR(46+modX, 36-modY, 3, 3)								--Aiming reticle
	end

end