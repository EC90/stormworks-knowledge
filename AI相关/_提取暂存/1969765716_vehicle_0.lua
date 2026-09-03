-- source: steam id 1969765716 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
DATA = {0,0,0,0,0,0}
seq = 0
expiry = 0
GS_STANDARD = 3
ILS = "N/A"
BKCRS = false
PTT = 0

function onTick()
	seq = input.getNumber(21)
	
	selfX = input.getNumber(1)
	selfY = input.getNumber(2)
	selfA = input.getNumber(3)
	Compass = input.getNumber(4)
	
	if seq >= 1 and seq <= 6 then
		DATA[seq] = input.getNumber(22)
		expiry = 0
	end 
	
	LOC_COMPASS = math.atan(DATA[4] - DATA[6], DATA[3] - DATA[5])
	LOC_DIR = ((LOC_COMPASS / math.pi * -180) + 90 + 360) % 360
	LOC_HDG = string.format("%02.0f", (((LOC_DIR + 358)%360) +2) / 10)	
	BEARING = ((math.atan(DATA[4] - selfY, DATA[3] - selfX) / math.pi * -180) + 270 + 360) % 360
	
	DME1 = math.sqrt((DATA[3] - selfX)^2 + (DATA[4] - selfY)^2) --/ 2
	DME = math.sqrt(DME1^2 + (DATA[1] - selfA)^2)

	--GND_DIST = math.sqrt((DATA[3] - selfX)^2 +(DATA[4] - selfY)^2)
	GS_DIST = math.abs(DME * math.cos(math.abs(LOC_DIR - BEARING) * math.pi / 180))
	GS_ALT = math.abs(selfA - (DATA[1] + DATA[2]))
	GS_deg = math.atan(GS_ALT, GS_DIST) * 180 / math.pi
	--GS_deg = math.atan(GS_ALT, GND_DIST) * 180 / math.pi
	GS_barY = GS_STANDARD - GS_deg
	
	DEV = math.abs((BEARING - 180) - (LOC_DIR - 180))
	if DEV > 90 and DEV <= 270 then
	--if BEARING - 180 + 90 > LOC_DIR - 180 and BEARING - 180 <= LOC_DIR - 180 + 90 then
		LX = (((LOC_DIR + 360 - BEARING)%360) - 180)
		BKCRS = false
	else
		LX = (((LOC_DIR + 540 - BEARING)%360) - 180)
		BKCRS = true
	end

	if (DATA[4] == DATA[6]) and (DATA[3] == DATA[5]) then
		ILS = "N/A"
	else
		ILS = "OK"
	end
	
	OutX = Limit(LX /2.5, -1, 1)
	OutY = Limit(GS_barY / 0.7, -1, 1)
	--GPS DATA
	MIM_D = (math.abs(DATA[2]) + 61) / math.tan(GS_STANDARD/180 * math.pi)
	TDZ_D = math.abs(DATA[2] / math.tan(GS_STANDARD/180 * math.pi))
	if DME > MIM_D + 10 then
		MIM_X = DATA[3] + MIM_D * -math.cos(LOC_COMPASS)
		MIM_Y = DATA[4] + MIM_D * -math.sin(LOC_COMPASS)
		MIM_A = DATA[1] + 60
		PTT = 2
	elseif DME > TDZ_D + 10 then
		MIM_X = DATA[3] + TDZ_D * -math.cos(LOC_COMPASS)
		MIM_Y = DATA[4] + TDZ_D * -math.sin(LOC_COMPASS)
		MIM_A = DATA[1]
		PTT = 1
	else
		MIM_X = DATA[3]
		MIM_Y = DATA[4]
		MIM_A = DATA[1]
		PTT = 0
	end
	output.setNumber(10, PTT)
	output.setNumber(11, selfX)
	output.setNumber(12, selfY)
	output.setNumber(13, selfA)
	output.setNumber(14, MIM_X)
	output.setNumber(15, MIM_Y)
	output.setNumber(16, MIM_A)
	output.setNumber(31, -OutX)
	output.setNumber(32, -OutY)
	if property.getNumber("ILS Auto Reverse Course") then
		output.setBool(32, false)
	else
		output.setBool(32, BKCRS)
	end
	
	if expiry < 1000 then expiry = expiry + 1 end
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()

	if expiry > 300 or ILS == "N/A" then
		--flag written
		
	else
		screen.setColor(255, 255, 255, 255)
		--scale bars written
		
		if BKCRS then
			screen.drawTriangleF(24*w/32, 19*h/32, 31*w/32, 19*h/32, 27*w/32, 23*h/32)
			LX1 = w/2 + LX * 15/2.5*w/32

		else
			screen.drawTriangleF(24*w/32, 14*h/32, 31*w/32, 14*h/32, 27*w/32, 10*h/32)
			LX1 = w/2 - LX * 15/2.5*w/32
			
		end

		LX1 = Limit(LX1, w/2-15*w/32, w/2+15*w/32)

		screen.setColor(255, 0, 255, 255)
		screen.drawLine(LX1, 0, LX1, h)		

		GS1 = h/2 - GS_barY * 15/0.7 * h/32
		GS1 = Limit(GS1, h/2-15*h/32, h/2+15*h/32)
		screen.drawLine(0, GS1, w, GS1)

	
		screen.setColor(255, 255, 255, 255)
		screen.drawTextBox(6, 1, (w - 12), 8, LOC_HDG, 0, -1)
		screen.drawTextBox(0, h-12, w/2-2*w/32, 7, string.format("%03.0f", LOC_DIR), 1, -1)
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