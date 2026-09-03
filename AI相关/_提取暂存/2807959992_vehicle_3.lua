-- source: steam id 2807959992 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2807959992

function onTick()
D= input.getNumber(32)
C1 = input.getBool(21)
C2 = input.getBool(22)
C3 = input.getBool(23)
C4 = input.getBool(24)
LLR = input.getBool(32)
LCR= input.getBool(31)
end


function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	if C1 == true then
	if D<=110 and D>=0.1
	then
	screen.setColor(200,0,0)
	screen.drawCircleF(7.5, 17, 4)
	screen.setColor(35,35,35)
	screen.drawText(3, 58, "CR")
	else
	screen.setColor(35,35,35)
	screen.drawCircleF(7.5, 17, 4)
	screen.setColor(12,12,12)
	screen.drawText(3, 58, "CR")
	end
	else
	screen.setColor(40,40,40)
	screen.drawRectF(0,22,15,60)
	end
	
	
	
	if C4 == true then
	if D<=110 and D>=0.1
	then
	screen.setColor(200,0,0)
	screen.drawCircleF(56.5, 17, 4)
	screen.setColor(35,35,35)
	screen.drawText(52, 58, "CR")
	else
	screen.setColor(35,35,35)
	screen.drawCircleF(56.5, 17, 4)
	screen.setColor(12,12,12)
	screen.drawText(52, 58, "CR")
	end
	else
	screen.setColor(40,40,40)
	screen.drawRectF(49,22,15,60)
	end   
	
	
	
	if C2 == true then
	if D<=210 and D>=0.1
	then
	screen.setColor(200,0,0)
	screen.drawCircleF(23, 17, 3.5)
	screen.setColor(12,12,12)
	screen.drawText(19, 58, "LR")
	else
	screen.setColor(35,35,35)
	screen.drawCircleF(23, 17, 3.5)
	screen.setColor(12,12,12)
	screen.drawText(19, 58, "LR")
	end
	else
	screen.setColor(40,40,40)
	screen.drawRectF(16,22,15,60)
	end
	
	
	
	if C3 == true then
	if D<=210 and D>=0.1
	then
	screen.setColor(200,0,0)
	screen.drawCircleF(40, 17, 3.5)
	screen.setColor(12,12,12)
	screen.drawText(36, 58, "LR")
	else
	screen.setColor(35,35,35)
	screen.drawCircleF(40, 17, 3.5)
	screen.setColor(12,12,12)
	screen.drawText(36, 58, "LR")
	end
	else
	screen.setColor(40,40,40)
	screen.drawRectF(33,22,15,60)
	end
	
	
	
	
	if LLR == true
	then
	screen.setColor(200, 0, 0)
	screen.drawTextBox(5.5, 2, 55, 3,"Missile Lock")
	else
	screen.setColor(35,35,35)
	screen.drawTextBox(5.5, 2, 55, 3,"Missile Lock")
	end
	
	if LCR == true
	then
	screen.setColor(200, 0, 0)
	screen.drawTextBox(5.5, 2, 55, 3,"Missile Lock")
	else
	
	end
	
	end