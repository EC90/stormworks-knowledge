-- source: steam id 3444942572 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3444942572
positionHoldTimer,holdSmoothMultiplier,lowSensSmooth = 0,0,0

function clamp(x,min,max)
	return math.max(math.min(x,math.max(max,min)),math.min(min,max))
end

function lerp(min,max,t)
	local t=clamp(t,0,1)
	return min*(1-t)+max*t
end

function pid(p,i,d)
	return {
		p=p,i=i,d=d,error=0,dif=0,int=0,old=0,
		run = function(s,setPoint,previousvalue,minO,maxO,minI,maxI,del)
			local minI,maxI,del=minI or minO,maxI or maxO,del or 1
			local error,dif,res,out
			error = setPoint-previousvalue
			dif=error-s.error
			s.error=error
			s.dif=dif
			res=error*s.p+s.int+dif*s.d
			if res>minO and res<maxO then
				s.int=clamp(s.int+error*s.i,minI,maxI)
			end
			res=clamp(error*s.p+s.int+clamp(dif*s.d,-2*(error*s.p+s.int),2*(error*s.p+s.int)),minO,maxO)
			out=clamp(res,s.old-del,s.old+del)
			s.old=out
			return out
		end
	}
end

pidCollective = pid(0.05,0.002,0.05)
pidPitch = pid(0.5,0,10)
pidRoll = pid(0.2,0,10)
pidYaw = pid(1,0,1)
pidHoldRoll = pid(0.05,0.001,0)
pidHoldPitch = pid(0.05,0.001,0)

lowSensMultiplier = property.getNumber("Slow mode multiplier")
liftMax = property.getNumber("Lift max speed")
pitchMax = property.getNumber("Pitch max tilt")*0.015
pitchTrim = property.getNumber("Pitch trim")*0.02
yawTrim = property.getNumber("Yaw trim")
rollMax = property.getNumber("Roll max tilt")*0.015
yawMax = property.getNumber("Yaw max speed")*0.02
positionHoldDelay = property.getNumber("Position hold delay")*60
positionHoldMaxTilt = property.getNumber("Position hold max tilt")*0.1

function onTick()							
	adInput = input.getNumber(21)
	wsInput = input.getNumber(22)
	leftRightInput = input.getNumber(23)
	upDownInput = input.getNumber(24)							

	altitude = input.getNumber(2)

	rollX = input.getNumber(4)
	rollY = input.getNumber(5)
	rollZ = input.getNumber(6)

	angularSpeedX = input.getNumber(10)
	angularSpeedY = input.getNumber(11)
	angularSpeedZ = input.getNumber(12)

	speedX = input.getNumber(7)
	speedY = input.getNumber(8)
	speedZ = input.getNumber(9)

	tiltPitch = input.getNumber(15)
	tiltRoll = input.getNumber(16)

	lowSens = input.getNumber(25) == 1

	cx,sx=math.cos(rollX),math.sin(rollX)
	cy,sy=math.cos(rollY),math.sin(rollY)
	cz,sz=math.cos(rollZ),math.sin(rollZ)

	m00=cz*cy
	m01=sx*sy*cz-cx*sz
	m02=sz*sx+cz*cx*sy
	m10=cy*sz
	m11=cx*cz+sx*sy*sz
	m12=cx*sz*sy-cz*sx
	m20=-sy
	m21=sx*cy
	m22=cy*cx

	yawSpeed = m01*angularSpeedX+m11*angularSpeedY+m21*angularSpeedZ
	verticalSpeed = m10*speedX+m11*speedY+m12*speedZ

	if math.abs(tiltPitch) < 0.2 and math.abs(tiltRoll) < 0.2 and math.abs(adInput) < 0.1 and math.abs(wsInput) < 0.1 then 
		positionHoldTimer = math.min(positionHoldTimer+1,positionHoldDelay)
	else 
		positionHoldTimer = 0
	end

	if positionHoldTimer >= positionHoldDelay then
		holdSmoothMultiplier = math.min(holdSmoothMultiplier + 0.01,1)
		holdPitch = pidHoldPitch:run(0,speedZ,-positionHoldMaxTilt,positionHoldMaxTilt,-positionHoldMaxTilt*0.1,positionHoldMaxTilt*0.1) * holdSmoothMultiplier
		holdRoll = pidHoldRoll:run(0,speedX,-positionHoldMaxTilt,positionHoldMaxTilt,-positionHoldMaxTilt*0.1,positionHoldMaxTilt*0.1) * holdSmoothMultiplier
	else
		holdSmoothMultiplier = 0
		holdPitch = pidHoldPitch:run(0,0,0,0)
		holdRoll = pidHoldRoll:run(0,0,0,0)
	end

	lowSensSmooth = clamp(lowSensSmooth+(lowSens and 0.01 or -0.01),0,1)
	lowSens = lerp(1,lowSensMultiplier,lowSensSmooth)

	collective = pidCollective:run(upDownInput * lowSens * (6+liftMax),verticalSpeed,0,1,0,1,0.02)
	pitch = pidPitch:run((wsInput*lowSens+holdPitch) * (0.1+pitchMax+(math.abs(clamp(upDownInput,-1,0))*0.1)) * math.sqrt(1-math.abs(adInput)*0.5),-tiltPitch,-0.2,0.2)
	roll = pidRoll:run((clamp((adInput+wsInput*leftRightInput),-1,1) * lowSens + holdRoll) * (0.1+rollMax) * math.sqrt(1-math.abs(wsInput)*0.5),-tiltRoll,-0.2,0.2)
	yaw = pidYaw:run((0.15+yawMax) * leftRightInput,yawSpeed,-0.2,0.2) + yawTrim * math.abs(wsInput)

	output.setNumber(1,collective - yaw)
	output.setNumber(2,collective + yaw)
	output.setNumber(3,pitch + pitchTrim)
	output.setNumber(4,-pitch - pitchTrim)
	output.setNumber(5,roll)
end