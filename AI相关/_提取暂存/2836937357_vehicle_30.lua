-- source: steam id 2836937357 / vehicle.xml block#30
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2836937357
r = 100
ra = 61
rb = 69.5
rc = 78
rd = 86.5
re = 95
rf = 103.5
-- Tick function that will be executed every logic tick
function onTick()
	roll = input.getNumber(1)
	roll = roll*math.pi*2
	top = input.getNumber(2)
	pitch = input.getNumber(3)
	pitch = pitch*math.pi*2
	if top > 0 then
		roll = -roll
	else
		pitch = -pitch
	end
	c = 32 + pitch*r
	output.setNumber(1, c)
	X1 = (32-c)*cos((math.pi/2)-roll)*cos(roll)
	Y1 = (32-c)*cos((math.pi/2)-roll)*sin(roll)
	
	if pitch < -0.175 and pitch > -1.48 then
	xC = ra*cos(roll+1.485) + 32 + X1  --d
	yC = ra*sin(roll+1.485) + c + Y1
	xD = -ra*cos(roll-1.485) + 32 + X1
	yD = -ra*sin(roll-1.485) + c + Y1
	
	xG = rb*cos(roll+1.495) + 32 + X1  --d 
	yG = rb*sin(roll+1.495) + c + Y1
	xH = -rb*cos(roll-1.495) + 32 + X1
	yH = -rb*sin(roll-1.495) + c + Y1
	
	xK = rc*cos(roll+1.5) + 32 + X1  --d
	yK = rc*sin(roll+1.5) + c + Y1
	xL = -rc*cos(roll-1.5) + 32 + X1
	yL = -rc*sin(roll-1.5) + c + Y1
	
	xQ = rd*cos(roll+1.51) + 32 + X1  --d
	yQ = rd*sin(roll+1.51) + c + Y1
	xR = -rd*cos(roll-1.51) + 32 + X1
	yR = -rd*sin(roll-1.51) + c + Y1
	
	xU = re*cos(roll+1.512) + 32 + X1  --d
	yU = re*sin(roll+1.512) + c + Y1
	xV = -re*cos(roll-1.512) + 32 + X1
	yV = -re*sin(roll-1.512) + c + Y1
	
	xY = rf*cos(roll+1.52) + 32 + X1  --d
	yY = rf*sin(roll+1.52) + c + Y1
	xZ = -rf*cos(roll-1.52) + 32 + X1
	yZ = -rf*sin(roll-1.52) + c + Y1
	end
	if pitch > 0.175 and pitch < 1.48 then
	xE = ra*cos(roll-1.485) + 32 + X1
	yE = ra*sin(roll-1.485) + c + Y1
	xF = -ra*cos(roll+1.485) + 32 + X1
	yF = -ra*sin(roll+1.485) + c + Y1
	
	xI = rb*cos(roll-1.495) + 32 + X1
	yI = rb*sin(roll-1.495) + c + Y1
	xJ = -rb*cos(roll+1.495) + 32 + X1
	yJ = -rb*sin(roll+1.495) + c + Y1

	xM = rc*cos(roll-1.5) + 32 + X1
	yM = rc*sin(roll-1.5) + c + Y1
	xN = -rc*cos(roll+1.5) + 32 + X1
	yN = -rc*sin(roll+1.5) + c + Y1
	
	xO = rd*cos(roll-1.51) + 32 + X1
	yO = rd*sin(roll-1.51) + c + Y1
	xP = -rd*cos(roll+1.51) + 32 + X1
	yP = -rd*sin(roll+1.51) + c + Y1
	
	xS = re*cos(roll-1.512) + 32 + X1
	yS = re*sin(roll-1.512) + c + Y1
	xT = -re*cos(roll+1.512) + 32 + X1
	yT = -re*sin(roll+1.512) + c + Y1
	
	xW = rf*cos(roll-1.52) + 32 + X1
	yW = rf*sin(roll-1.52) + c + Y1
	xX = -rf*cos(roll+1.52) + 32 + X1
	yX = -rf*sin(roll+1.52) + c + Y1
	end
end

function cos(a)
	return math.cos(a)
end

function sin(a)
	return math.sin(a)
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	screen.setColor(255, 255, 255, 200)
	if pitch < -0.175 and pitch > -1.48 then
	screen.drawLine(xC, yC, xD, yD) --d
	screen.drawLine(xG, yG, xH, yH) --d
	screen.drawLine(xK, yK, xL, yL) --d
	screen.drawLine(xQ, yQ, xR, yR) --d
	screen.drawLine(xU, yU, xV, yV) --d
	screen.drawLine(xY, yY, xZ, yZ) --d
	end
	if pitch > 0.175 and pitch < 1.48 then
	screen.drawLine(xE, yE, xF, yF)
	screen.drawLine(xI, yI, xJ, yJ)
	screen.drawLine(xM, yM, xN, yN)
	screen.drawLine(xO, yO, xP, yP)
	screen.drawLine(xS, yS, xT, yT)
	screen.drawLine(xW, yW, xX, yX)
	end
end