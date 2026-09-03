-- source: steam id 2232448349 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2232448349
FD_0 = false
FD_1 = false
FD = false
FD_CH = 1

CH2 = false
CH3 = false -- 1+2
CHG_0 = false
CHG_1 = false

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()

	screen.setColor(200,100,0,255)
	screen.drawTriangleF(w/2-3*w/32, h/2+3*h/32, w/2, h/2+3*h/32, w/2, h/2)
	screen.drawTriangleF(w/2+3*w/32, h/2+3*h/32, w/2, h/2+3*h/32, w/2, h/2)
	screen.drawLine(w/2-10*w/32, h/2-1, w/2-6*w/32, h/2-1)
	screen.drawLine(w/2+6*w/32, h/2-1, w/2+10*w/32, h/2-1)
	
	screen.setColor(128,128,128,255)
	screen.drawLine(0, h/2-1, 3*w/32, h/2-1)
	screen.drawLine(w-3*w/32, h/2-1, w, h/2-1)
	screen.drawTriangleF(w/2-4*w/32, 0, w/2, 0, w/2, 4*h/32)
	screen.drawTriangleF(w/2+4*w/32, 0, w/2, 0, w/2, 4*h/32)
	
	rMark(math.pi*1/3, 3)
	rMark(math.pi*-1/3, 3)
	rMark(math.pi*1/6, 3)
	rMark(math.pi*-1/6, 3)
	rMark(math.pi*1/16, 3)
	rMark(math.pi*-1/16, 3)
	
	
	if ResetBTN then
		screen.drawRectF(TW/2-2*(TW/32), TH-5*(TH/32), 4*(TW/32), 4*(TH/32))
	end
	
	if FD_1 then
		screen.drawRectF(0, TH-7, 6, 7)
	end
	
	if FD then
		screen.setColor(0,255,0,255)
	else
		screen.setColor(128,128,128,255)
	end
	
	screen.drawTextBox(1, TH-7, 5, 7, "F", 0, 0)
	
	if CHG_1 then
		screen.drawRectF(TW-6, TH-7, 6, 7)
	end
	
	screen.setColor(255,255,255,255)
	if FD_CH == 1 then
		screen.drawTextBox(TW-5, TH-7, 5, 7, "1", 0, 0)
		
	elseif FD_CH == 2 then
		screen.drawTextBox(TW-5, TH-7, 5, 7, "2", 0, 0)

	elseif FD_CH == 3 then
		screen.drawTextBox(TW-5, TH-7, 5, 7, "+", 0, 0)
		
	end
	
end
	
function onTick()
	TW = input.getNumber(1)
	TH = input.getNumber(2)
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)

	B = input.getNumber(23)
	P = input.getNumber(24)
	
	isPressed = input.getBool(1)
	ResetBTN = isPressed and isInRect(inputX, inputY, TW/2-3*(TW/32), TH-6*(TH/32), 6*(TW/32), 6*(TH/32))
	
	
	FD_1 = isPressed and isInRect(inputX, inputY, 0, TH-7, 6, 7)
	CHG_1 = isPressed and isInRect(inputX, inputY, TW-6, TH-7, 6, 7)

	if FD_1 and not FD_0 and not FD then
		FD = true
	elseif FD_1 and not FD_0 and FD then
		FD = false
	end
	FD_0 = FD_1


	if CHG_1 and not CHG_0 then
		FD_CH = FD_CH + 1
		if FD_CH > 3 then FD_CH = 1 end
	end
	
	if FD_CH == 1 then
		CH2 = false
		CH3 = false
	elseif FD_CH == 2 then
		CH2 = true
		CH3 = false
	elseif FD_CH == 3 then
		CH2 = false
		CH3 = true
	end
	CHG_0 = CHG_1
	
	--C = TW/2
	--M = TH/2
	--BR = math.rad(B)
	--CB = math.cos(BR)
	--IM = M + (P*CB)
	output.setBool(32, ResetBTN)
	output.setBool(31, FD)
	output.setBool(30, CH2)
	output.setBool(29, CH3)
	
end

function rMark(deg, length)
	if deg > 0 then offset_w = -1 else offset_w = 0 end
	screen.drawLine(w/2 + offset_w - w * math.sin(deg),
	 h/2 -1 - h * math.cos(deg),
	 w/2 + offset_w - (w/2 - length) * math.sin(deg),
	 h/2 -1 - (h/2 - length) * math.cos(deg))
end

function isInRect(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end