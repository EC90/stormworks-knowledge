-- source: steam id 1969765716 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
DATA = {0,0,0,0,0,0}
seq = 0
expiry = 0
GS_STANDARD = 3
ILS = "N/A"
BKCRS = false

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
	


	if (DATA[4] == DATA[6]) and (DATA[3] == DATA[5]) then
		ILS = "N/A"
	else
		ILS = "OK"
	end

	if expiry < 1000 then expiry = expiry + 1 end
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(0, 0, 0, 255)
	screen.drawClear()

	if expiry > 300 or ILS == "N/A" then
		for i = 0, w+8, 8 do
			screen.setColor(255, 0, 0, 255)
			screen.drawLine(i-8, 20*h/32, i, 12*h/32)
			screen.drawLine(i-7, 20*h/32, i+1, 12*h/32)
			screen.drawLine(i-6, 20*h/32, i+2, 12*h/32)
			screen.drawLine(i-5, 20*h/32, i+3, 12*h/32)
			screen.setColor(255, 255, 255, 255)
			screen.drawLine(i-4, 20*h/32, i+4, 12*h/32)
			screen.drawLine(i-3, 20*h/32, i+5, 12*h/32)
			screen.drawLine(i-2, 20*h/32, i+6, 12*h/32)
			screen.drawLine(i-1, 20*h/32, i+7, 12*h/32)
		end
	else
		screen.setColor(255, 255, 255, 255)
		screen.drawCircle(w/2, h/2, 2*h/32)
		screen.drawLine(w/2-15*w/32, h/2-1*h/32, w/2-15*w/32, h/2+2*h/32)
		screen.drawLine(w/2-12*w/32, h/2-1*h/32, w/2-12*w/32, h/2+2*h/32)
		screen.drawLine(w/2-9*w/32, h/2-1*h/32, w/2-9*w/32, h/2+2*h/32)
		screen.drawLine(w/2-6*w/32, h/2-1*h/32, w/2-6*w/32, h/2+2*h/32)
		screen.drawLine(w/2-3*w/32, h/2-1*h/32, w/2-3*w/32, h/2+2*h/32)		
		screen.drawLine(w/2+15*w/32, h/2-1*h/32, w/2+15*w/32, h/2+2*h/32)
		screen.drawLine(w/2+12*w/32, h/2-1*h/32, w/2+12*w/32, h/2+2*h/32)
		screen.drawLine(w/2+9*w/32, h/2-1*h/32, w/2+9*w/32, h/2+2*h/32)
		screen.drawLine(w/2+6*w/32, h/2-1*h/32, w/2+6*w/32, h/2+2*h/32)
		screen.drawLine(w/2+3*w/32, h/2-1*h/32, w/2+3*w/32, h/2+2*h/32)
		screen.drawLine(w/2-1*w/32, h/2-9*h/32, w/2+2*w/32, h/2-9*h/32)		
		screen.drawLine(w/2-1*w/32, h/2-6*h/32, w/2+2*w/32, h/2-6*h/32)		
		screen.drawLine(w/2-1*w/32, h/2-3*h/32, w/2+2*w/32, h/2-3*h/32)		
		screen.drawLine(w/2-1*w/32, h/2+3*h/32, w/2+2*w/32, h/2+3*h/32)
		screen.drawLine(w/2-1*w/32, h/2+6*h/32, w/2+2*w/32, h/2+6*h/32)
		screen.drawLine(w/2-1*w/32, h/2+9*h/32, w/2+2*w/32, h/2+9*h/32)
		screen.drawLine(w/2-1*w/32, h/2+12*h/32, w/2+2*w/32, h/2+12*h/32)
		screen.drawLine(w/2-1*w/32, h/2+15*h/32, w/2+2*w/32, h/2+15*h/32)


	end
end
	
function Limit(num, min, max)
	out = num
	out = math.max(out, min)
	out = math.min(out, max)
	return out
end