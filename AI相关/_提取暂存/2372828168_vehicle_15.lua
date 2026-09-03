-- source: steam id 2372828168 / vehicle.xml block#15
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2372828168
r = 100
ra = 10
rb = 18.5
rc = 27
rd = 35.5
re = 44
rf = 52.5
-- Tick function that will be executed every logic tick
function onTick()
	roll = input.getNumber(1)
	roll = roll*math.pi*2
	top = input.getNumber(2)
	pitch = input.getNumber(3)
	pitch = pitch*math.pi*2
	if top > 0 then
		roll = -roll
		pi13 = math.pi/3
		pi23 = 2*math.pi/3
	else
		pitch = -pitch
		pi13 = -math.pi/3
		pi23 = -2*math.pi/3
	end
	c = 15 + pitch*r
	output.setNumber(1, c)
	X1 = (15-c)*cos((math.pi/2)-roll)*cos(roll)
	Y1 = (15-c)*cos((math.pi/2)-roll)*sin(roll)
	
	if pitch > -0.96 and pitch < 0.96 then
	xA = r*cos(roll) + 32 
	yA = r*sin(roll) + c
	xB = -r*cos(roll) + 32
	yB = -r*sin(roll) + c
	xC = ra*cos(roll+1) + 32 + X1
	yC = ra*sin(roll+1) + c + Y1
	xD = -ra*cos(roll-1) + 32 + X1
	yD = -ra*sin(roll-1) + c + Y1
	
	xE = ra*cos(roll-1) + 32 + X1
	yE = ra*sin(roll-1) + c + Y1
	xF = -ra*cos(roll+1) + 32 + X1
	yF = -ra*sin(roll+1) + c + Y1
	
	xG = rb*cos(roll+1.28) + 32 + X1
	yG = rb*sin(roll+1.28) + c + Y1
	xH = -rb*cos(roll-1.28) + 32 + X1
	yH = -rb*sin(roll-1.28) + c + Y1
	
	xI = rb*cos(roll-1.28) + 32 + X1
	yI = rb*sin(roll-1.28) + c + Y1
	xJ = -rb*cos(roll+1.28) + 32 + X1
	yJ = -rb*sin(roll+1.28) + c + Y1
	
	xK = rc*cos(roll+1.37) + 32 + X1
	yK = rc*sin(roll+1.37) + c + Y1
	xL = -rc*cos(roll-1.37) + 32 + X1
	yL = -rc*sin(roll-1.37) + c + Y1

	xM = rc*cos(roll-1.37) + 32 + X1
	yM = rc*sin(roll-1.37) + c + Y1
	xN = -rc*cos(roll+1.37) + 32 + X1
	yN = -rc*sin(roll+1.37) + c + Y1
	
	xO = rd*cos(roll-1.42) + 32 + X1
	yO = rd*sin(roll-1.42) + c + Y1
	xP = -rd*cos(roll+1.42) + 32 + X1
	yP = -rd*sin(roll+1.42) + c + Y1
	
	xQ = rd*cos(roll+1.42) + 32 + X1
	yQ = rd*sin(roll+1.42) + c + Y1
	xR = -rd*cos(roll-1.42) + 32 + X1
	yR = -rd*sin(roll-1.42) + c + Y1
	
	xS = re*cos(roll-1.45) + 32 + X1
	yS = re*sin(roll-1.45) + c + Y1
	xT = -re*cos(roll+1.45) + 32 + X1
	yT = -re*sin(roll+1.45) + c + Y1
	
	xU = re*cos(roll+1.45) + 32 + X1
	yU = re*sin(roll+1.45) + c + Y1
	xV = -re*cos(roll-1.45) + 32 + X1
	yV = -re*sin(roll-1.45) + c + Y1
	
	xW = rf*cos(roll-1.47) + 32 + X1
	yW = rf*sin(roll-1.47) + c + Y1
	xX = -rf*cos(roll+1.47) + 32 + X1
	yX = -rf*sin(roll+1.47) + c + Y1
	
	xY = rf*cos(roll+1.47) + 32 + X1
	yY = rf*sin(roll+1.47) + c + Y1
	xZ = -rf*cos(roll-1.47) + 32 + X1
	yZ = -rf*sin(roll-1.47) + c + Y1
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
	screen.setColor(2, 255, 2, 255)
	screen.drawLine(r*cos(roll-0.004) + 32 , r*sin(roll-0.004) + c, -r*cos(roll+0.004) + 32, -r*sin(roll+0.004) + c)
	if pitch > -0.96 and pitch < 0.96 then
	screen.drawLine(xA, yA, xB, yB)
	screen.drawLine(xC, yC, xD, yD)
	screen.drawLine(xE, yE, xF, yF)
	screen.drawLine(xG, yG, xH, yH)
	screen.drawLine(xI, yI, xJ, yJ)
	screen.drawLine(xK, yK, xL, yL)
	screen.drawLine(xM, yM, xN, yN)
	screen.drawLine(xO, yO, xP, yP)
	screen.drawLine(xQ, yQ, xR, yR)
	screen.drawLine(xS, yS, xT, yT)
	screen.drawLine(xU, yU, xV, yV)
	screen.drawLine(xW, yW, xX, yX)
	screen.drawLine(xY, yY, xZ, yZ)
	end
end