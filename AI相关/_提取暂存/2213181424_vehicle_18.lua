-- source: steam id 2213181424 / vehicle.xml block#18
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
NAV=false
TRK=false
RDAR=false

PWR=false
COMM=false
FUEL=false

C=false
SAR=false
WIN=false
BDY=false

function onTick()	
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)
	
if not (NAV or TRK or RDAR or PWR or COMM or FUEL or C or SAR or WIN or BDY) then
	if isPressed and isPointInRectangle(inputX, inputY, 0, 10, 31, 9) then
		NAV = true
	end
	if isPressed and isPointInRectangle(inputX, inputY, 0, 19, 31, 9) then
		TRK = true
	end
	if isPressed and isPointInRectangle(inputX, inputY, 0, 28, 31, 9) then
		RDAR = true
	end
	
	if isPressed and isPointInRectangle(inputX, inputY, 32, 10, 31, 9) then
		PWR = true
	end
	if isPressed and isPointInRectangle(inputX, inputY, 32, 19, 31, 9) then
		COMM = true
	end
	if isPressed and isPointInRectangle(inputX, inputY, 32, 28, 31, 9) then
		FUEL = true
	end
	
	
	if isPressed and isPointInRectangle(inputX, inputY, 2, 49, 8, 9) then
		C = true
	end
	if isPressed and isPointInRectangle(inputX, inputY, 10, 49, 17, 9) then
		SAR = true
	end
	if isPressed and isPointInRectangle(inputX, inputY, 27, 49, 17, 9) then
		WIN = true
	end
	if isPressed and isPointInRectangle(inputX, inputY, 44, 49, 17, 9) then
		BDY = true
	end
end


	
if isPressed and isPointInRectangle(inputX, inputY, 15, 59, 33, 5) then
	NAV=false
	TRK=false
	RDAR=false

	PWR=false
	COMM=false
	FUEL=false

	C=false
	SAR=false
	WIN=false
	BDY=false
end
	output.setBool(1, NAV)
	output.setBool(2, TRK)
	output.setBool(3, RDAR)
	
	output.setBool(4, PWR)
	output.setBool(5, COMM)
	output.setBool(6, FUEL)
	
	output.setBool(7, C)
	output.setBool(8, SAR)
	output.setBool(9, WIN)
	output.setBool(10, BDY)
end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
if not (NAV or TRK or RDAR or PWR or COMM or FUEL or C or SAR or WIN or BDY) then
						
screen.setColor(25, 50, 100)

screen.drawTextBox(0, 2, 64, 7, "SYSTEMS", 0, 0)

screen.drawRect(0, 10, 31, 9)
screen.drawTextBox(0, 10, 31, 9, "NAV", 0, 0)
screen.drawRect(0, 19, 31, 9)
screen.drawTextBox(0, 19, 31, 9, "TRK", 0, 0)
screen.drawRect(0, 28, 31, 9)
screen.drawTextBox(0, 28, 31, 9, "RDAR", 0, 0)

screen.drawRect(32, 10, 31, 9)
screen.drawTextBox(32, 10, 31, 9, "ENG", 0, 0)
screen.drawRect(32, 19, 31, 9)
screen.drawTextBox(32, 19, 31, 9, "COMM", 0, 0)
screen.drawRect(32, 28, 31, 9)
screen.drawTextBox(32, 28, 31, 9, "FUEL", 0, 0)

screen.drawTextBox(0, 41, 64, 7, "CAMERAS", 0, 0)

screen.drawRect(2, 49, 8, 9)
screen.drawTextBox(3, 49, 8, 9, "C", 0, 0)
screen.drawRect(10, 49, 17, 9)
screen.drawTextBox(11, 49, 17, 9, "SAR", 0, 0)
screen.drawRect(27, 49, 17, 9)
screen.drawTextBox(28, 49, 17, 9, "WIN", 0, 0)
screen.drawRect(44, 49, 17, 9)
screen.drawTextBox(45, 49, 17, 9, "BDY", 0, 0)
end

if NAV or TRK or RDAR or PWR or COMM or FUEL or C or SAR or WIN or BDY then
	screen.drawRectF(16,61,32,3)
end

end