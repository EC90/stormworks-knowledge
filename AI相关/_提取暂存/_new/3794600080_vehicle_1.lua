-- source: steam id 3794600080 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794600080
Ch = 16
Ss = 0
Sc = false

function onTick()
	tX = input.getNumber(3)
	tY = input.getNumber(4)
	T = input.getBool(1) and not P
	PL = input.getBool(1) and not P
	P = input.getBool(1)
	Ss = input.getNumber(1)
	
	if T then
		if iPIR(tX,tY,38,26,7,3) then
			mute = not mute
		end
	end
	
	if T then
		if iPIR(tX,tY,12,21,7,9) then
			D = not D
		end
	end
	
	if T then
		if iPIR(tX,tY,30,26,7,9) then
			Sc = not Sc
		end
	end
	
	output.setBool(1,mute)
	output.setBool(2,D)
	output.setBool(3,Sc)
	
	
	if Sc then
		Ch = Ch + 1
	end
	
	if (not Sc and Ch > 99) or Ch < 0 then
		Ch = 0
	elseif Sc and Ch > 106 then
		Ch = 0
	end
	
	
	if PL and iPIR(tX,tY,22,26,3,3) then
		Ch = Ch - 1
		PL = false
	end
	
	if PL and iPIR(tX,tY,26,26,3,3) then
		Ch = Ch + 1
		PL = false
	end
	
	
	if Ss > 0.1 and Sc then
		Sc = false
		Ch = Ch - 7
	end
	
	
	if T then
		if iPIR(tX,tY,48,9,6,6) then
			Sc = false
			Ch = 16
		end
	end
	
	output.setNumber(1,Ch)
	
	ChD = math.max(0,math.min(99,Ch))
end


function iPIR(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	
	screen.setColor(1,1,1)
	screen.drawClear()
	
	screen.setColor(0,0,0)
	screen.drawRect(1,1,w-3,h-3)
	screen.drawRectF(19,6,28,19)
	screen.drawLine(5,7,18,7)
	screen.drawLine(5,9,18,9)
	screen.drawLine(5,11,18,11)
	screen.drawLine(5,13,18,13)
	screen.drawLine(5,15,18,15)
	screen.drawLine(5,17,18,17)
	
	screen.setColor(55,20,2)
	screen.drawRectF(21,8,24,13)
	
	screen.setColor(40,14,1)
	screen.drawRectF(36,9,8,4)
	screen.setColor(1,1,1)
	screen.drawRectF(36,9,Ss*8,4)
	screen.setColor(55,20,2)
	screen.drawLine(36,8,36,13)
	screen.drawLine(38,8,38,13)
	screen.drawLine(40,8,40,13)
	screen.drawLine(42,8,42,13)
	screen.drawTriangleF(36,9,44,9,36,13)
	
	screen.setColor(1,1,1)
	screen.drawTextBox(22,9,10,5,string.format("%02.0f", ChD))
	

	
	screen.setColor(5,0,0)
	screen.drawRectF(12,21,6,8)
	screen.setColor(8,8,8)
	screen.drawText(13,23,"D")
	
	
	if D then
		screen.setColor(1,1,1)
	else
		screen.setColor(40,14,1)
	end
	
	screen.drawLine(32,12,36,12)
	screen.drawRectF(33,10,2,2)
	
	screen.setColor(1,3,8)
	screen.drawRectF(22,26,3,3)
	screen.drawRectF(26,26,3,3)
	screen.drawRectF(30,26,7,3)
	screen.drawRectF(38,26,7,3)
	
	screen.setColor(10,10,10)
	screen.drawLine(23,27,23,28)
	screen.drawLine(27,27,27,28)
	screen.drawLine(31,27,36,27)
	screen.drawLine(39,27,44,27)
	screen.drawLine(23,22,23,24)
	screen.drawLine(27,22,27,24)
	screen.drawLine(33,22,33,24)
	screen.drawLine(41,22,41,24)
	
	screen.setColor(1,1,1)
	if not mute then
		screen.drawRectF(41,16,2,4)
		screen.drawRectF(40,17,1,2)
	else
		screen.setColor(40,14,1)
		screen.drawRectF(41,16,2,4)
		screen.drawRectF(40,17,1,2)
		screen.setColor(1,1,1)
		screen.drawLine(39,19,44,14)
	end
	
	if Sc then
		screen.setColor(1,1,1)
	else
		screen.setColor(40,14,1)
	end
	screen.drawText(32,15,"S")
	
	
	if P and iPIR(tX,tY,22,26,3,3) then
		screen.setColor(1,1,1)
	else
		screen.setColor(40,14,1)
	end
	screen.drawLine(22,18,25,18)
	
	if P and iPIR(tX,tY,26,26,3,3) then
		screen.setColor(1,1,1)
	else
		screen.setColor(40,14,1)
	end
	screen.drawLine(26,18,29,18)
	screen.drawLine(27,17,27,20)
	
	screen.setColor(8,3,2)
	screen.drawRectF(49,9,4,6)
	screen.drawRectF(48,10,6,4)
	screen.setColor(8,8,8)
	screen.drawLine(50,10,52,10)
	screen.drawLine(49,11,49,13)
	screen.drawLine(50,13,52,13)
	
	screen.setColor(6,6,6)
	screen.drawRect(58,24,2,4)
	screen.setColor(14,14,14,180)
	screen.drawLine(56,21,56,26)
	screen.drawLine(58,21,58,23)
	screen.drawLine(57,23,58,23)
	screen.drawLine(58,24,58,26)
end