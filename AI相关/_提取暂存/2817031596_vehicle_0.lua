-- source: steam id 2817031596 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2817031596
s,scr,i,o,p,m = self,screen,input,output,property,math
pgn,pgb,gn,gb,sn,sb,sf = p.getNumber,p.getBool,i.getNumber,i.getBool,o.setNumber,o.setBool,string.format
pi2,abs,sqrt = m.pi*2,m.abs,m.sqrt

turn = 0.15+pgn("Turn speed")*0.03
throtSens = 0.08+pgn("Throttle sensitivity")*0.02
throtMaxFwd = pgn("Forward max throttle")
throtMaxRev = -pgn("Reverse max throttle")
brakeSens = 0.1+pgn("Brakes sensitivity")*0.02
revMode = pgb("Engage reverse")
revInvert = pgb("Invert steering on reverse")
revIdle = pgb("Disengage reverse when idle")
throttle = 0
brakes = 0
rev = 1
revSm = 1
throtMax = throtMaxFwd
throtAxisOld = 0
throtAxisSm = 0
t = 0

function clamp(x,min,max)
	return m.max(m.min(x,m.max(max,min)),m.min(min,max))
end

function lerp(min,max,t)
	return min*(1-clamp(t,0,1))+max*clamp(t,0,1)
end

function sgn(x)
	return x >= 0 and 1 or -1
end
										
function onTick()											
	
	steerAxis = gn(1)
	throtAxis = gn(2)
	angular = gn(3)
	speed = gn(4)
	
	if revIdle and abs(speed) < 1 and abs(throtAxis) < 0.5 and abs(steerAxis) < 0.1 then 
		t = m.min(t+1,60)
	else
		t = 0
	end
	
	if (abs(speed) < 1 and throtAxis > 0.5 and (revMode or throtAxisOld < 0.5)) or t >= 60 then
		rev = 1
		throtMax = throtMaxFwd
	elseif abs(speed) < 1 and throtAxis < -0.5 and (revMode or throtAxisOld > -0.5) then
		rev = -1
		throtMax = throtMaxRev
	end
	throtAxisOld = throtAxis
	
	revSm = revSm+0.05*(rev-revSm)
	
	throtAxisSm = throtAxisSm+throtSens*(rev*throtAxis-throtAxisSm)
	steerAxisSm = steerAxis*(revInvert and 1 or revSm)*(revMode and 1-0.5*brakes or 1)
	
	throttle = clamp(throtAxisSm,0,1)
	
	brakes = -clamp(throtAxisSm,-1,0)
	
	steer = clamp(5*(steerAxisSm*turn-angular),-1,1)
		
	motor1 = lerp(steer, clamp(throtMax-revSm*abs(steer)+steer,-throtMax*0.5,throtMax), throttle)-brakeSens*brakes*speed
	motor2 = lerp(-steer, clamp(throtMax-revSm*abs(steer)-steer,-throtMax*0.5,throtMax), throttle)-brakeSens*brakes*speed
	
	sn(1,motor1)
	sn(2,motor2)
	sb(1,rev == -1)
end										