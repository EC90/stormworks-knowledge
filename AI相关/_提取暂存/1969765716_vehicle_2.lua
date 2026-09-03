-- source: steam id 1969765716 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
mode = "A"
int_mode = 2

BTN = {0,1,1,1,1,1,1,1,0,
	   1,0,0,0,0,0,0,0,1,
	   1,0,0,0,0,0,0,0,1,
	   1,0,0,0,0,0,0,0,1,
	   1,0,0,0,0,0,0,0,1,
	   1,0,0,0,0,0,0,0,1,
	   1,0,0,0,0,0,0,0,1,
	   1,0,0,0,0,0,0,0,1,
	   0,1,1,1,1,1,1,1,0}

function onTick()
	isPressed1 = input.getBool(1)
	isPressed2 = input.getBool(2)
	w = input.getNumber(1)
	h = input.getNumber(2)
	iX1 = input.getNumber(3)
	iY1 = input.getNumber(4)
	iX2 = input.getNumber(5)
	iY2 = input.getNumber(6)
	OBS_UP = false
	OBS_DN = false
	OBS_HDG = false
	OBS_180 = false
	
	if (isPressed1 and isInRect(iX1, iY1, 0, 0, 8, 8)) or
	   (isPressed2 and isInRect(iX2, iY2, 0, 0, 8, 8)) then
		mode = "I"
		int_mode = 1
		
	elseif (isPressed1 and isInRect(iX1, iY1, w-9, h-9, 8, 8)) or
	   (isPressed2 and isInRect(iX2, iY2, w-9, h-9, 8, 8)) then
		mode = "A"
		int_mode = 2

	elseif (isPressed1 and isInRect(iX1, iY1, w-9, 0, 8, 8)) or
	   (isPressed2 and isInRect(iX2, iY2, w-9, 0, 8, 8)) then
		mode = "V"
		int_mode = 4
		
	elseif mode == "V" and
			((isPressed1 and isInRect(iX1, iY1, 0, 9, 8, h-8)) or
			(isPressed2 and isInRect(iX2, iY2, 0, 9, 8, h-8))) and
			((isPressed1 and isInRect(iX1, iY1, w-8, 9, 8, h-8)) or
			(isPressed2 and isInRect(iX2, iY2, w-8, 9, 8, h-8))) then

			OBS_UP = true
			OBS_DN = true
	
	elseif mode == "V" and
			((isPressed1 and isInRect(iX1, iY1, 0, 9, 8, h-8)) or
			(isPressed2 and isInRect(iX2, iY2, 0, 9, 8, h-8))) then
			OBS_DN = true
	
	elseif mode == "V" and		
			((isPressed1 and isInRect(iX1, iY1, w-8, 9, 8, h-8)) or
			(isPressed2 and isInRect(iX2, iY2, w-8, 9, 8, h-8))) then
			OBS_UP = true

	elseif mode == "V" and		
			((isPressed1 and isInRect(iX1, iY1,8, 0, w-16, 9)) or
			(isPressed2 and isInRect(iX2, iY2, 8, 0, w-16, 9))) then			
			OBS_HDG = true
			
	elseif mode == "V" and		
			((isPressed1 and isInRect(iX1, iY1,8, h-8, w-16, 9)) or
			(isPressed2 and isInRect(iX2, iY2, 8, h-8, w-16, 9))) then			
			OBS_180 = true
		
	elseif isPressed1 and isPressed2 then
		mode = "D"
		int_mode = 3
		
	end

	output.setBool(11, OBS_DN)
	output.setBool(12, OBS_UP)
	output.setBool(13, OBS_HDG)
	output.setBool(14, OBS_180)
	output.setNumber(20, int_mode)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()

	
	screen.setColor(0, 0, 0, 192)	
	screen.drawRectF(1, 1, 7, 7)
	screen.drawRectF(w-8, 1, 7, 7)
	screen.drawRectF(w-8, h-8, 7, 7)
	screen.setColor(255, 255, 255, 255)
	PenguinDraw(0,0,9,BTN)
	PenguinDraw(w-9,0,9,BTN)
	PenguinDraw(w-9,h-9,9,BTN)

	
	if mode == "I" then
		screen.setColor(0, 255, 0, 255)
		screen.drawTextBox(2, 2, 5, 5, "I", 1, 0)
	else
		screen.setColor(255, 255, 255, 255)
		screen.drawTextBox(2, 2, 5, 5, "I", 1, 0)
	end

	if mode == "V" then
		screen.setColor(0, 255, 0, 255)
		screen.drawTextBox(w-7, 2, 5, 5, "V", 1, 0)
	else
		screen.setColor(255, 255, 255, 255)
		screen.drawTextBox(w-7, 2, 5, 5, "V", 1, 0)
	end
	
	if mode == "A" then
		screen.setColor(0, 255, 0, 255)
		screen.drawTextBox(w-7, h-7, 5, 5, "A", 1, 0)
	else
		screen.setColor(255, 255, 255, 255)
		screen.drawTextBox(w-7, h-7, 5, 5, "A", 1, 0)
	end
	
	
		
	
end
	
function isInRect(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
	
function PenguinDraw(s,y,w,BM)
	x = s
	for i=1, #BM do
		if BM[i] == 1 then screen.drawRectF(x, y, 1, 1) end
		x = x + 1
		if i%w == 0 then x = s y = y + 1 end
	end
end