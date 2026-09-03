-- source: steam id 2213181424 / vehicle.xml block#21
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
dL = screen.drawLine 

function onTick()
act=input.getBool(32)
if act then

RB = input.getBool(1)
t1 = input.getNumber(5)*33
R1 = math.max(0, math.min(14, input.getNumber(6)))/14*33
T1 = math.max(0, math.min(0.74, input.getNumber(7)))/0.74*33
FU1 = input.getNumber(8)
t2 = input.getNumber(9)*33
R2 = math.max(0, math.min(14, input.getNumber(10)))/14*33
T2 = math.max(0, math.min(0.74, input.getNumber(11)))/0.74*33
FU2 = input.getNumber(12)
t3 = input.getNumber(13)*33
R3 = math.max(0, math.min(14, input.getNumber(14)))/14*33
T3 = math.max(0, math.min(0.74, input.getNumber(15)))/0.74*33
FU3 = input.getNumber(16)
Rtn = isPressed and isPointInRectangle(inputX, inputY, 15, 59, 33, 5)
output.setBool(32, Rtn)
end
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
end
function onDraw()
if act then
w = screen.getWidth()		  
h = screen.getHeight()
	
--ind
screen.setColor(100,25,0)
dL(5,46-t1,7,46-t1)
dL(4,47-t1,7,47-t1)
dL(5,48-t1,7,48-t1)
	
dL(26,46-t2,28,46-t2)
dL(25,47-t2,28,47-t2)
dL(26,48-t2,28,48-t2)
	
dL(47,46-t3,49,46-t3)
dL(46,47-t3,49,47-t3)
dL(47,48-t3,49,48-t3)

dL(11,46-R1,13,46-R1)
dL(10,47-R1,13,47-R1)
dL(11,48-R1,13,48-R1)

dL(32,46-R2,34,46-R2)
dL(31,47-R2,34,47-R2)
dL(32,48-R2,34,48-R2)
	
dL(53,46-R3,55,46-R3)
dL(52,47-R3,55,47-R3)
dL(53,48-R3,55,48-R3)
	
dL(17,46-T1,19,46-T1)
dL(16,47-T1,19,47-T1)
dL(17,48-T1,19,48-T1)

dL(38,46-T2,40,46-T2)
dL(37,47-T2,40,47-T2)
dL(38,48-T2,40,48-T2)
	
dL(59,46-T3,61,46-T3)
dL(58,47-T3,61,47-T3)
dL(59,48-T3,61,48-T3)
					
screen.setColor(25,50,100)

-- Lnes
dL(21,0,21,58)
dL(42,0,42,58)
dL(0,58,64,58)

dL(8,44,9,44) -- Idle levels
dL(29,44,30,44)
dL(50,44,51,44)

-- En
screen.drawTextBox(1,0,21,9,"EN1",0,0)
screen.drawTextBox(22,0,21,9, "EN2",0,0)
screen.drawTextBox(43,0,20,9,"EN3",0,0)

--Thr
dL(4,9,4,13)
dL(3,10,6,10)
	
dL(25,9,25,13)
dL(24,10,27,10)
	
dL(46,9,46,13)
dL(45,10,48,10)

dL(3,14,3,48)
dL(24,14,24,48)
dL(45,14,45,48)

-- RPS
screen.drawCircle(10.5,10.5,1.5)
screen.drawCircle(31.5,10.5,1.5)
screen.drawCircle(52.5,10.5,1.5)

screen.setColor(100,0,0)
dL(9,14,9,48)
dL(30,14,30,48)
dL(51,14,51,48)

screen.setColor(150,100,0)
dL(9,26,9,36)
dL(30,26,30,36)
dL(51,26,51,36)

screen.setColor(0,50,0)
dL(9,29,9,33)
dL(30,29,30,33)
dL(51,29,51,33)

screen.setColor(25,50,100)


--Temp
dL(16,9,16,13)
dL(15,9,18,9)
	
dL(37,9,37,13)
dL(36,9,39,9)
	
dL(58,9,58,13)
dL(57,9,60,9)

screen.setColor(100,0,0)
dL(15,14,15,20)
dL(36,14,36,20)
dL(57,14,57,20)

screen.setColor(150,100,0)
dL(15,20,15,24)
dL(36,20,36,24)
dL(57,20,57,24)

screen.setColor(0,50,0)
dL(15,24,15,48)
dL(36,24,36,48)
dL(57,24,57,48)
	
-- FU
screen.setColor(0,50,0)
screen.drawRectF(5,50,11,7)
if RB then
screen.setColor(100,0,0)
screen.drawRectF(5,50,11,7)
elseif FU1<0.5 then
screen.setColor(150,100,0)
screen.drawRectF(5,50,11,7)
end

screen.setColor(0,50,0)
screen.drawRectF(26,50,11,7)
if RB then
screen.setColor(100,0,0)
screen.drawRectF(26,50,11,7)
elseif FU2<0.5 then
screen.setColor(150, 100, 0)
screen.drawRectF(26,50,11,7)
end

screen.setColor(0,50,0)
screen.drawRectF(47,50,11,7)
if RB then
screen.setColor(100,0,0)
screen.drawRectF(47,50,11,7)
elseif FU3<0.5 then
screen.setColor(150, 100, 0)
screen.drawRectF(47,50,11,7)
end

screen.setColor(0, 0, 0)

if RB then
screen.drawTextBox(1,49,20,9,"RB",0,0)
screen.drawTextBox(43,49,20,9,"RB",0,0)
screen.drawTextBox(22,49,20,9,"RB",0,0)
else
screen.drawTextBox(1,49,20,9,"FU",0,0)
screen.drawTextBox(43,49,20,9,"FU",0,0)
screen.drawTextBox(22,49,20,9,"FU",0,0)
end

end
end