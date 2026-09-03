-- source: steam id 1969765716 / vehicle.xml block#18
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
nP=true
function onTick()
timer = input.getBool(6)
if timer then nP = false end

	LR = input.getBool(1)
	KCA = input.getBool(2)
	KA = input.getBool(3)
	AP = input.getBool(4)
	isP = input.getBool(5)
	SH = input.getBool(7)
	inputX = input.getNumber(1)
	inputY = input.getNumber(2)

	NextP = isP and isPIR(inputX, inputY, 16, 24, 16, 8)
	if NextP == nil then return false end
	if NextP and not Nextp then nP = not nP end
	Nextp = NextP
	if not nP then
		KCA_ = isP and isPIR(inputX, inputY, 0, 0, 32, 8)
		KA_ = isP and isPIR(inputX, inputY, 0, 8, 32, 8)
		LR_ = isP and isPIR(inputX, inputY, 0, 16, 16, 8)
		AP_ = isP and isPIR(inputX, inputY, 16, 16, 16, 8)
		SH_ = isP and isPIR(inputX, inputY, 0, 24, 16, 8)
	elseif nP then
		RBAY_ = isP and isPIR(inputX, inputY, 0, 0, 32, 8)
		LB_ = isP and isPIR(inputX, inputY, 0, 8, 16, 8)
		LL_ = isP and isPIR(inputX, inputY, 16, 8, 16, 8)
		NAV_ = isP and isPIR(inputX, inputY, 0, 16, 16, 8)
		SL_ = isP and isPIR(inputX, inputY, 16, 16, 16, 8)
		CPR = isP and isPIR(inputX, inputY, 0, 24, 16, 8)
	end
	if RBAY_ == nil then return false end
	if RBAY_ and not rbay_ then RBAY = not RBAY end
	rbay_ = RBAY_

	if LB_ == nil then return false end
	if LB_ and not lb_ then LB = not LB end
	lb_ = LB_
	
	if LL_ == nil then return false end
	if LL_ and not ll_ then LL = not LL end
	ll_ = LL_

	if NAV_ == nil then return false end
	if NAV_ and not nav_ then NAV = not NAV end
	nav_ = NAV_
	
	if SL_ == nil then return false end
	if SL_ and not sl_ then SL = not SL end
	sl_ = SL_
	
	output.setBool(1,LR_)
	output.setBool(2,KCA_)
	output.setBool(3,KA_)
	output.setBool(4,AP_)
	output.setBool(5,RBAY)
	output.setBool(6,LB)
	output.setBool(7,LL)
	output.setBool(9,NAV)
	output.setBool(10,SL)
	output.setBool(11,CPR)
	output.setBool(12,SH_)
end

function isPIR(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
	screen.setColor(255,255,0,50)
	screen.drawRect(0,0,31,31)
	screen.drawLine(1,8,31,8)
	screen.drawLine(1,16,31,16)
	screen.drawLine(1,24,31,24)
	screen.drawLine(16,25,16,31)
	screen.drawLine(16,17,16,24)
	if nP then screen.setColor(0, 255, 0) else screen.setColor(255, 0, 0) end
	screen.drawText(21,26,"-")
	screen.drawText(23,26,">")
	
	if nP then
		screen.setColor(255,255,0,50)
		screen.drawLine(16,9,16,16)
		if RBAY then screen.setColor(0, 255, 0) else screen.setColor(255, 0, 0) end
			screen.drawText(4, 2, "R.BAY")
			
		if LB then screen.setColor(0, 255, 0) else screen.setColor(255, 0, 0) end
			screen.drawText(1, 10, "L.B")

		if LL then screen.setColor(0, 255, 0) else screen.setColor(255, 0, 0) end
			screen.drawText(17, 10, "L.L")
		
		if NAV then screen.setColor(0, 255, 0) else screen.setColor(255, 0, 0) end
			screen.drawText(2, 18, "NAV")
		
		if SL then screen.setColor(0, 255, 0) else screen.setColor(255, 0, 0) end
			screen.drawText(17, 18, "S.L")
			
		if CPR then screen.setColor(0, 255, 0) else screen.setColor(255, 0, 0) end
			screen.drawText(2, 26, "RFC")	
	else
		
		if KCA then screen.setColor(0, 255, 0) else screen.setColor(255, 0, 0) end
			screen.drawText(3, 2, "KC.ALT")

		if KA then screen.setColor(0, 255, 0) else screen.setColor(255, 0, 0) end
			screen.drawText(3, 10, "K.ALT")

		if LR then screen.setColor(0, 255, 0) else screen.setColor(255, 0, 0) end
			screen.drawText(3, 18, "LR")

		if AP then screen.setColor(0, 255, 0) else screen.setColor(255, 0, 0) end
			screen.drawText(20, 18, "AP")
		
		if SH then screen.setColor(0, 255, 0) else screen.setColor(255, 0, 0) end
			screen.drawText(3, 26, "SH")
	end
end