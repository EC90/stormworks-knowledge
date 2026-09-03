-- source: steam id 2807959992 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2807959992
-- Tick function that will be executed every logic tick
function onTick()
	inputX=input.getNumber(3)
	inputY=input.getNumber(4)
	isPressed=input.getBool(1)
	C1=input.getBool(21)
	C2=input.getBool(22)
	C3=input.getBool(23)
	C4=input.getBool(24)
	ON1=input.getBool(6)
	ON2=input.getBool(7)
	ON3=input.getBool(8)
	ON4=input.getBool(9)
	T1=isPressed and isPointInRectangle(inputX,inputY,0,22,15,60)
	T2=isPressed and isPointInRectangle(inputX,inputY,16,22,15,60)
	T3=isPressed and isPointInRectangle(inputX,inputY,33,22,15,60)
	T4=isPressed and isPointInRectangle(inputX,inputY,49,22,15,60)
	output.setBool(11,T1)
	output.setBool(12,T2)
	output.setBool(13,T3)
	output.setBool(14,T4)
	function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
end
function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()					
	screen.setColor(30,50,160,150) 
	screen.drawCircleF(w/2,h/2,100)
	
if not T1==true and ON1==true
	then
	screen.setColor(70,70,70)
	screen.drawRectF(0,22,15,60)
	if C1==true
	then
	screen.setColor(10,10,10)
	screen.drawLine(6,52,9,52)
	screen.setColor(10,10,10)
	screen.drawLine(6,35,9,35)
	screen.setColor(30,30,30)
	screen.drawLine(7,34,7,53)
	screen.setColor(240,240,200)
	screen.drawLine(7,34,7,35)
	else
	end
	else
	screen.setColor(70,70, 70,150)
	screen.drawRectF(0,22,15,60)
	if C1 == true
	then
	screen.setColor(10,10,10)
	screen.drawLine(6,52,9,52)
    screen.setColor(10,10,10)
	screen.drawLine(6,35,9,35)
	screen.setColor(30,30,30)
	screen.drawLine(7,34,7,53)
	screen.setColor(240,240,200)
	screen.drawLine(7,34,7,35)
	else
	end
    end

if not T2==true and ON2==true
	then
	screen.setColor(70,70,70)
	screen.drawRectF(16,22,15,60)
	if C2==true
	then
	screen.setColor(10,10,10)
	screen.drawLine(21,52,26,52)
    screen.setColor(10,10,10)
	screen.drawLine(21,28,26,28)
	screen.setColor(30,30,30)
	screen.drawLine(22,25,22,53)
	screen.drawLine(23,25,23,53)
	screen.drawLine(24,25,24,53)
	screen.setColor(240,240,200)
	screen.drawLine(22,25,25,25)
	screen.drawLine(22,26,25,26)
	else
	end
	else
	screen.setColor(70,70,70,150)
	screen.drawRectF(16,22,15,60)
	if C2==true
	then
	screen.setColor(10,10,10)
	screen.drawLine(21,52,26,52)
    screen.setColor(10,10,10)
	screen.drawLine(21,28,26,28)
	screen.setColor(30,30,30)
	screen.drawLine(22,25,22,53)
	screen.drawLine(23,25,23,53)
	screen.drawLine(24,25,24,53)
	screen.setColor(240,240,200)
	screen.drawLine(22,25,25,25)
	screen.drawLine(22,26,25,26)
	else
	end
    end

if not T3==true and ON3==true
	then
	screen.setColor(70,70,70)
	screen.drawRectF(33,22,15,60)
	if C3==true
	then
	screen.setColor(10,10,10)
	screen.drawLine(38,52,43,52)
    screen.setColor(10,10,10)
	screen.drawLine(38,28,43,28)
	screen.setColor(30,30,30)
	screen.drawLine(39,25,39,53)
	screen.drawLine(40,25,40,53)
	screen.drawLine(41,25,41,53)
	screen.setColor(240,240,200)
	screen.drawLine(39,25,42,25)
	screen.drawLine(39,26,42,26)
	else
	end
	else
	screen.setColor(70,70,70,150)
	screen.drawRectF(33,22,15,60)
	if C3==true
	then
	screen.setColor(10,10,10)
	screen.drawLine(38,52,43,52)
    screen.setColor(10,10,10)
	screen.drawLine(38,28,43,28)
	screen.setColor(30,30,30)
	screen.drawLine(39,25,39,53)
	screen.drawLine(40,25,40,53)
	screen.drawLine(41,25,41,53)
	screen.setColor(240,240,200)
	screen.drawLine(39,25,42,25)
	screen.drawLine(39,26,42,26)
	else
	end
    end

if not T4==true and ON4==true
	then
	screen.setColor(70,70,70)
	screen.drawRectF(49,22,15,60)
	if C4==true
	then
	screen.setColor(10,10,10)
	screen.drawLine(55,52,58,52)
	screen.setColor(10,10,10)
	screen.drawLine(55,35,58,35)
	screen.setColor(30,30,30)
	screen.drawLine(56,34,56,53)
	screen.setColor(240,240,200)
	screen.drawLine(56,34,56,35)
	else
	end
	else
	screen.setColor(70,70,70,150)
	screen.drawRectF(49,22,15,60)
	if C4==true
	then
	screen.setColor(10,10,10)
	screen.drawLine(55,52,58,52)
	screen.setColor(10,10,10)
	screen.drawLine(55,35,58,35)
	screen.setColor(30,30,30)
	screen.drawLine(56,34,56,53)
	screen.setColor(240,240,200)
	screen.drawLine(56,34,56,35)
	else
	end
    end
end