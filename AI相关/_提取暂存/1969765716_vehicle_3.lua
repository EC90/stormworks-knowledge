-- source: steam id 1969765716 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
DATA = {0,0,0,0,0,0}
seq = 0
expiry = 0

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
	
	DME = math.sqrt((DATA[3] - selfX)^2 + (DATA[4] - selfY)^2)
	DME = math.sqrt(DME^2 + (DATA[1] - selfA)^2)
	DME_NM = DME * 0.000539957
	DME_km = DME * 0.001
	
	if expiry > 300 then
		output.setNumber(32, -1)
	else
		output.setNumber(32, DME)
	end
	
	if expiry < 1000 then expiry = expiry + 1 end
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(0, 0, 0, 255)
	screen.drawClear()
	screen.setColor(255, 255, 255, 255)
	screen.drawTextBox(0, y, w-1, h, "DME", 0, 1)

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
		
		if DME_NM >= 100 then
			screen.drawTextBox(0, 10*h/32, w, 6, string.format("%0.0f", DME_NM).."NM", 1, 1)	
		else
			screen.drawTextBox(0, 10*h/32, w, 6, string.format("%0.1f", DME_NM).."NM", 1, 1)
		end
		
		if DME_km >= 100 then
			screen.drawTextBox(0, 17*h/32, w, 6, string.format("%0.0f", DME_km).."km", 1, 1)
		else
			screen.drawTextBox(0, 17*h/32, w, 6, string.format("%0.1f", DME_km).."km", 1, 1)
		end
	
	end
	
end
	