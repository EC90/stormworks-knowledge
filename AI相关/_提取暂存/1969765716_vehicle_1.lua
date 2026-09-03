-- source: steam id 1969765716 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
DATA = {0,0,0,0,0,0}
seq = 0
expiry = 0

function onTick()
	seq = input.getNumber(21)
	
	selfX = input.getNumber(1)
	selfY = input.getNumber(2)
	selfA = input.getNumber(3)
	Compass = (input.getNumber(4) + 1) % 1
	
	
	if seq >= 1 and seq <= 6 then
		DATA[seq] = input.getNumber(22)
		expiry = 0
	end 

	
	DIR = (630 + (math.atan(DATA[4] - selfY, DATA[3] - selfX) * 180 / math.pi) - (Compass * 360))%360
	
	if expiry > 300 then
		output.setNumber(31, 0)
	else
		OutDIR = -DIR
		if OutDIR < -180 then OutDIR = 360 + OutDIR end
		OutDIR = OutDIR / 30
		OutDIR = math.min(math.max(OutDIR, -1), 1)
		output.setNumber(31, OutDIR)
	end
	
	if expiry < 1000 then expiry = expiry + 1 end
end


function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(0, 0, 0, 255)
	screen.drawClear()
	screen.setColor(255, 255, 255, 255)
	

	if expiry > 300 then
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
		for i = 1, 12 do
			rMark(math.pi*i/6, 8)
		end
	
		screen.setColor(255, 192, 0, 255)
		arrow(DIR, 10*h/32, 60, 10)
	end
end
	
function rMark(deg, length)
	screen.drawLine(w/2 - w/2 * math.sin(deg), h/2 - h/2 * math.cos(deg), w/2 - (w/2 - length) * math.sin(deg), h/2 - (h/2 - length) * math.cos(deg))
end
	
function arrow(deg, length, hdw, thick)
	local deg = -deg * math.pi / 180
	local hdw = hdw * math.pi / 180
	tn = thick
	screen.drawTriangleF(w/2 + length * math.sin(deg),
		h/2 - length * math.cos(deg),
		w/2 + (length / 2) * math.sin(deg + hdw),
		h/2 - (length / 2) * math.cos(deg + hdw),
		w/2 + (length / 2) * math.sin(deg - hdw),
		h/2 - (length / 2) * math.cos(deg - hdw))

	screen.drawLine(w/2 + length/2 * math.sin(deg),
		h/2 - length/2 * math.cos(deg),
		w/2 - length * math.sin(deg),
		h/2 + length * math.cos(deg))
		
	for i = 1, tn do
		thk = i * math.pi / 180
		screen.drawLine(w/2 + length/2 * math.sin(deg + thk),
			h/2 - length/2 * math.cos(deg + thk),
			w/2 - length * math.sin(deg - thk),
			h/2 + length * math.cos(deg - thk))
		
		screen.drawLine(w/2 + length/2 * math.sin(deg - thk),
			h/2 - length/2 * math.cos(deg - thk),
			w/2 - length * math.sin(deg + thk),
			h/2 + length * math.cos(deg + thk))
	end
end