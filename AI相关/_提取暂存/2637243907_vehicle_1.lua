-- source: steam id 2637243907 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2637243907
s,scr,i,o,m = self,screen,input,output,math
sc,dl,dt,dtb,dr,dc = scr.setColor,scr.drawLine,scr.drawText,scr.drawTextBox,scr.drawRect,scr.drawCircle
pgb,gn,gb,sn,sf = property.getBool,i.getNumber,i.getBool,o.setNumber,string.format
pi2,abs = m.pi*2,m.abs
trim = 0.04
yaw1 = 0.4
yaw2 = 0.2								
timer = 0
altOld = 0
					
function clamp(x,min,max)
return m.max(m.min(x, max), min)
end

function sgn(x)
return (x >= 0 and 1) or -1
end

function pid(p,i,d)
    return{p=p,i=i,d=d,error=0,diff=0,integral=0, 
		run=function(s,sp,pv,min,max,reset)
			local error,diff,out
			error = sp-pv
			diff = error-s.error
			out = error*s.p+s.integral+diff*s.d
			s.error = error
			s.diff = diff
			if reset then s.integral = clamp(s.integral-0.1*s.integral,min,max)
			elseif out > min and out < max then s.integral = clamp(s.integral+error*s.i,min,max)
			end
			return clamp(error*s.p+s.integral+diff*s.d,min,max)
		end
	}
end
										
pidC = pid(8,0.04,20)
pidP = pid(4,0,60)
pidR = pid(4,0,60)
pidY = pid(6,0,10)
pidMP = pid(0.2,0.02,0)
pidHR = pid(0.02,0.0002,0)
pidHP = pid(0.02,0.0002,0)
arrP = pgb("Pitch axis")
arrR = pgb("Roll axis")
											
function onTick()											
	ad = (arrR and gn(3)) or gn(1)
	ws = (arrP and gn(2)) or gn(4)
	lr = (arrR and gn(1)) or gn(3)
	ud = (arrP and gn(4)) or gn(2)							
	mX = gn(9)
	mY = gn(10)								
	alt = gn(11)
	tiltP = gn(12)
	tiltR = gn(13)
	angular = gn(14)
	speedP = gn(15)
	speedR = gn(16)						
	compass = gn(17)
	fuel = gn(18)
	ammo = gn(19)*2
	on = gb(1)
	keyboard = gb(2)
	low = gb(6)									
	trigger = gb(31)
	seat = gb(32)
	delta = alt-altOld
	altOld = alt
	speed = abs(speedP)/m.max(m.cos(pi2*tiltP),0.01)
	heading = (1-compass)%1*360
	reset = (abs(speedP) < 0.1 and abs(speedR) < 0.1 and abs(delta) < 0.1) or not (on and seat)
	fire = ((trigger and ammo > 0) and -0.015) or 0
	l = (low and 16) or 0
	if keyboard then
		pitchI,yawI = ud,lr
		pX,pY,cX,cY = 0,-0.01,0,-2
		pidMP:run(0,0,0,0,true)
	else
		pitchI = pidMP:run(0,clamp(sgn(mY+0.004)*m.max(15*(abs(mY+0.004)-0.007),0),-1,1),-1,1,reset)
		yawI = sgn(mX)*clamp(15*(abs(mX)-0.008),0,1)	
		pX = clamp(mX*4.2,-0.13,0.13)
		pY = clamp(mY*4.2,-0.12,0.12)											
		cX = clamp(m.tan(mX*pi2)*90,-19,19)
		cY = clamp(m.tan(mY*pi2)*95,-22,18)
	end
	if abs(yawI) < 0.1 and abs(pitchI) < 0.1 and abs(ad) < 0.1 then timer = m.min(timer+1,120)
	else timer = 0
	end
	if timer >= 120 then
		holdP = pidHP:run(0,speedP,-0.05,0.05)
		holdR = pidHR:run(0,speedR,-0.05,0.05)
	else holdP,holdR = 0,0
	end
	fins1 = pitchI
	fins2 = yawI+ad
	col = pidC:run(ws*0.15,delta,0,1)
	pitch = pidP:run(pitchI*0.12*m.sqrt(1-abs(ad)*0.5),-tiltP,-1,1)+trim+fire+holdP
	roll = pidR:run(ad*0.12*m.sqrt(1-abs(pitchI)*0.5),-tiltR,-1,1)+holdR
	yaw = pidY:run(0.14*clamp((yawI+pitchI*ad*yaw1-ad*yaw2),-1,1),angular,-0.5,0.5)
	sn(1,col-yaw)
	sn(2,col+yaw)
	sn(3,pitch)
	sn(4,roll)
	sn(5,-roll)
	sn(6,pX)
	sn(7,pY)
	sn(8,fins1)
	sn(9,fins2)
end
											
function onDraw()																				
	sc(255,255,255,220)
	dl(47+cX,43-cY+l,49+cX,45-cY+l)
	dl(46+cX,44-cY+l,48+cX,46-cY+l)	
	dl(70,46+l,70,46+23*pitchI+l)
	dl(24,46+l,24,46+23*pitchI+l)
	dl(47,22+l,47+22*yawI,22+l)
	dtb(7,47+l,15,5,sf("%.0f",speed*3.6),0,0)
	dtb(74,47+l,15,5,sf("%.0f",alt),0,0)									
	dtb(0,14,96,5,sf("%.0f",heading),0,0)
	dt(27,80+l*0.5,sf("%.0f",fuel))
	dt(70,80+l*0.5,sf("%.0f",ammo))
	sc(255,255,255,120)
	dr(26,24+l,42,44)
	dc(47,46+l,4)
	dl(66,46+l,68,46+l)
	dl(27,46+l,29,46+l)
	dl(47,25+l,47,27+l)
	dl(47,66+l,47,68+l)
	dt(7,40+l,"KPH")
	dt(79,40+l,"M")
	dt(11,80+l*0.5,"FUL")
	dt(54,80+l*0.5,"GUN")
	rc = m.cos(pi2*tiltR)
	rs = m.sin(pi2*tiltR)
	dl(47+7*rc,46+7*rs+l,47+14*rc,46+14*rs+l)
	dl(47-7*rc,46-7*rs+l,47-14*rc,46-14*rs+l)
	for step = 1,91,10 do
		offset = m.fmod(heading,20)*0.5
		if step+offset < 94 then dl(step+offset,8,step+offset,10) end
	end
	dl(1,7,95,7)
	for step = 30,70,10 do
		offset = -m.fmod(alt,4)*2.5
		dl(93,step+offset+l,95,step+offset+l)
	end
	dl(95,20+l,95,71+l)
	for step = 30,70,10 do
		offset = -m.fmod(speed,4)*2.5
		dl(2,step+offset+l,4,step+offset+l)
	end
	dl(1,20+l,1,71+l)								
end