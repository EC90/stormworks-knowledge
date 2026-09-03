-- source: steam id 3603910667 / vehicle.xml block#66
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
SBTN = {0,1,1,1,1,1,1,1,0,
		1,1,0,0,0,0,0,1,1,
		1,0,0,0,1,0,0,0,1,
		1,0,0,1,1,1,0,0,1,
		1,0,1,1,1,1,1,0,1,
		1,0,0,1,1,1,0,0,1,
		1,0,0,1,1,1,0,0,1,
		1,0,0,1,1,1,0,0,1,
		1,0,0,1,1,1,0,0,1,
		1,0,0,1,1,1,0,0,1,
		1,0,0,1,1,1,0,0,1,
		1,0,0,1,1,1,0,0,1,
		1,0,1,1,1,1,1,0,1,
		1,0,0,1,1,1,0,0,1,
		1,0,0,0,1,0,0,0,1,
		1,1,0,0,0,0,0,1,1,
		0,1,1,1,1,1,1,1,0}

UB = {0,0,1,0,0,
	  0,1,1,1,0,
	  1,1,1,1,1}

DB = {1,1,1,1,1,
	  0,1,1,1,0,
	  0,0,1,0,0}	
U = {}
D = {}	
		
function onTick()
	SetFr = input.getNumber(13)
	StbyFr = input.getNumber(12)
	FrD = math.max(1, math.min(input.getNumber(11), 4))
	ID = property.getText("Label1")
	
	tX = input.getNumber(3)
	tY = input.getNumber(4)
	T1 = input.getBool(1)
	ACTIVE = input.getBool(32)

	
	SetFr = SetFr % (10^FrD)
	StbyFr = StbyFr % (10^FrD)
	if StbyFr1 == nil then StbyFr1 = -1 end
	if SetFr1 == nil then SetFr1 = -1 end
	
	for i = 1, FrD do
		U[i] = T1 and isInRect(tX, tY, 30-(i*5), 14, 5, 7)
		D[i] = T1 and isInRect(tX, tY, 30-(i*5), 24, 5, 7)
	end
	
	SET = T1 and isInRect(tX, tY, 1, 13, 9, 17)
	
	if T0 and not T1 then
		if isInRect(tX, tY, 1, 13, 9, 17) then
			output.setBool(10, true)
			---output.setBool(12, true)
			--output.setNumber(12, SetFr * 1000)
			--output.setBool(13, true)
			--output.setNumber(13, StbyFr * 1000)

			SetFr1 = StbyFr
			StbyFr1 = SetFr
					
		else
			for i = 1, FrD do
				if isInRect(tX, tY, 30-(i*5), 14, 5, 7) then
					--[[StbyFr = StbyFr + 10^(i-1)
					StbyFr = StbyFr % (10^FrD)
					output.setBool(12, true)
					output.setNumber(12, StbyFr * 1000)
					StbyFr1 = StbyFr]]
					output.setBool(12, true)
					output.setBool(12+i, true)
   
					
				elseif isInRect(tX, tY, 30-(i*5), 24, 5, 7) then
					--[[StbyFr = StbyFr - 10^(i-1)
					if StbyFr < 0 then StbyFr = StbyFr + 1000000 end
					StbyFr = StbyFr % (10^FrD)
					output.setBool(12, true)
					output.setNumber(12, StbyFr * 1000)
					StbyFr1 = StbyFr]]
					output.setBool(12, true)
					output.setBool(16+i, true)
					 

				end
			end
		end
	else
		for i = 1, 32 do
			output.setBool(i, false)
		end

		if StbyFr1 < 0 and StbyFr > 0 then StbyFr1 = StbyFr end
		if SetFr1 < 0 and SetFr > 0 then SetFr1 = SetFr end
	end


	if T1 and isInRect(tX, tY, 0, 0, w, 7) then
		output.setBool(32, true)
	else
		output.setBool(32, false)
	end
	
	T0 = T1
end

function isInRect(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(0, 0, 0, 255)
	screen.drawClear()
	
	screen.setColor(255, 255, 255, 200)
	screen.drawTextBox(1, 1, w-2, 5, ID, -1, -1)
	screen.drawTextBox(1, 7, w-2, 5, ">", -1, -1)
	
	if ACTIVE then
		screen.setColor(0, 255, 0, 255)
		screen.drawTextBox(1, 1, w-2, 5, ID, -1, -1)
	end
	
	screen.setColor(255, 64, 0, 255)	
	screen.drawTextBox(8, 7, w-10, 5, string.sub(string.format("%07.0f", SetFr), -FrD), 1, -1)
	
	screen.drawTextBox(8, 20, w-10, 5, string.sub(string.format("%07.0f", StbyFr), -FrD), 1, -1)
	
	--screen.setColor(255, 255, 255, 16)
	--screen.drawRect(1, 13, 6, 18)
	if SET then screen.setColor(255, 64, 0, 255) else screen.setColor(255, 255, 255, 16) end
	PenguinDraw(1,13,9,SBTN)
	
	for i = 1, FrD do
		if U[i] then screen.setColor(255, 64, 0, 255) else screen.setColor(255, 255, 255, 16) end
		PenguinDraw(30-(i*5),16,5,UB)

		if D[i] then screen.setColor(255, 64, 0, 255) else screen.setColor(255, 255, 255, 16) end
		PenguinDraw(30-(i*5),26,5,DB)
	end
	
end
	
function PenguinDraw(s,y,w,BM)
	x = s
	for i=1, #BM do
		if BM[i] == 1 then screen.drawRectF(x, y, 1, 1) end
		x = x + 1
		if i%w == 0 then x = s y = y + 1 end
	end
end