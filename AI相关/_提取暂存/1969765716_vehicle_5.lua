-- source: steam id 1969765716 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
DATA = {0,0,0,0,0,0}
seq = 0
expiry = 0
GS_STANDARD = 3

BKCRS = false
SETCRS = 0

function onTick()
	seq = input.getNumber(21)
	
	selfX = input.getNumber(1)
	selfY = input.getNumber(2)
	selfA = input.getNumber(3)
	Compass = input.getNumber(4)
	
	HDG = math.floor(((360 - Compass) % 1)*360)
	
	OBS_UP = input.getBool(12)
	OBS_DN = input.getBool(11)
	OBS_HDG = input.getBool(13)
	OBS_180 = input.getBool(14)
	
	if OBS_UP and OBS_DN then
		SETCRS = 0
	
	elseif OBS_UP then
		SETCRS = SETCRS + 1
			
	elseif OBS_DN then
		SETCRS = SETCRS - 1
		
	elseif OBS_HDG then
		SETCRS = HDG
	
	elseif OBS_180 then
		SETCRS = SETCRS + 180
	
	end
	
	SETCRS = (SETCRS + 360) % 360
	
	if seq >= 1 and seq <= 6 then
		DATA[seq] = input.getNumber(22)
		expiry = 0
	end 
	
	--LOC_DIR = ((math.atan(DATA[4] - DATA[6], DATA[3] - DATA[5]) / math.pi * -180) + 90 + 360) % 360
	--LOC_HDG = string.format("%02.0f", (((LOC_DIR + 358)%360) +2) / 10)	
	BEARING = ((math.atan(DATA[4] - selfY, DATA[3] - selfX) / math.pi * -180) + 270 + 360) % 360
	
	--DME = math.sqrt((DATA[3] - selfX)^2 + (DATA[4] - selfY)^2)
	--DME = math.sqrt(DME^2 + (DATA[1] - selfA)^2)

	--GND_DIST = math.sqrt((DATA[3] - selfX)^2 +(DATA[4] - selfY)^2)
	--GS_DIST = math.abs(DME * math.cos(math.abs(LOC_DIR - BEARING) * math.pi / 180))
	--GS_ALT = math.abs(selfA - (DATA[1] + DATA[2]))
	--GS_deg = math.atan(GS_ALT, GS_DIST) * 180 / math.pi
	--GS_barY = GS_STANDARD - GS_deg
	
	DEV = math.abs((BEARING - 180) - (SETCRS - 180))
	if DEV > 90 and DEV <= 270 then
	--if BEARING - 180 + 90 > SETCRS - 180 and BEARING - 180 <= SETCRS - 180 + 90 then
		LX = (((SETCRS + 360 - BEARING)%360) - 180)
		BKCRS = false
	else
		LX = (((SETCRS + 540 - BEARING)%360) - 180)
		BKCRS = true
	end

	if (DATA[4] == DATA[6]) and (DATA[3] == DATA[5]) then
		ILS = "N/A"
	else
		ILS = "OK"
	end
	
	OutX = Limit(LX /10, -1, 1)
	--OutY = Limit(GS_barY / 1.4, -1, 1)
	output.setNumber(31, -OutX)
	output.setNumber(32, 0)
	output.setBool(32, BKCRS)
	
	if expiry < 1000 then expiry = expiry + 1 end
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()

	if expiry > 300 then
		--flag written
		
	else
		screen.setColor(255, 255, 255, 255)
		--scale bars written
		
		if BKCRS then
			screen.drawTriangleF(24*w/32, 19*h/32, 31*w/32, 19*h/32, 27*w/32, 23*h/32)
			LX1 = w/2 + LX * 15/10*w/32

		else
			screen.drawTriangleF(24*w/32, 14*h/32, 31*w/32, 14*h/32, 27*w/32, 10*h/32)
			LX1 = w/2 - LX * 15/10*w/32
			
		end

		LX1 = Limit(LX1, w/2-15*w/32, w/2+15*w/32)

		screen.setColor(0, 255, 0, 255)
		screen.drawLine(LX1, 0, LX1, h)		

		--GS1 = h/2 - GS_barY * 15/1.4 * h/32
		--GS1 = Limit(GS1, h/2-15*h/32, h/2+15*h/32)
		--screen.drawLine(0, GS1, w, GS1)

	
		screen.setColor(255, 255, 255, 255)
		--screen.drawTextBox(6, 1, (w - 12), 8, LOC_HDG, 0, -1)
		
		TAIL_DIR = (SETCRS + 180) % 360
		if TAIL_DIR == 0 then TAIL_DIR = 360 end
		if SETCRS == 0 then SETCRS = 360 end
		screen.drawTextBox(0, 8, w, 7, string.format("%03.0f", SETCRS), 0, -1)
		screen.drawTextBox(0, h-12, w, 7, string.format("%03.0f", TAIL_DIR), 0, -1)
		--debug
		--screen.drawTextBox(6, 15, (w - 12), 8, BEARING, 0, -1)
		--screen.drawTextBox(0, 8, w/2-2*w/32, 7, LOC_DIR, 1, -1)
	end
end
	
function Limit(num, min, max)
	out = num
	out = math.max(out, min)
	out = math.min(out, max)
	return out
end