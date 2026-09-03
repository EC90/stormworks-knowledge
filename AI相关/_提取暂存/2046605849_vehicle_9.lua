-- source: steam id 2046605849 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2046605849
x=0
y=0
z=0
k=0
set1=0
set2=0
consumptHour=0
per100kph=0
fuel=0
absConsumptHout=0
consumptMin = 0
minToFill = 0
consumptSec = 0
time=1
function onTick()

	speed = input.getNumber(11)
	fluidLvl = input.getNumber(12)
	capacity = input.getNumber(13)
	time = input.getNumber(14)
	distance = input.getNumber(15)
	
	percent = fluidLvl / capacity
	
	if distance == 1 then
	convert = 3.6
	elseif distance == 2 then
	convert = 2.236936
	elseif distance == 3 then
	convert = 1.943844
	end
	
	if x ~= 601 then
		x=x+1
		y=y+fluidLvl
		z=z+fluidLvl
	end
	
	if x == 300 then
		set1 = z/600
		z=0
	end
	
	if x == 600 then
		set2 = y/600	
		consumptHour=math.floor((set1-set2)*720)	
		per100kph = math.floor(consumptHour/((speed*convert)/100))
		fuel = math.floor(set2)
		absConsumptHout = math.abs(consumptHour)
		
		consumptMin=math.floor(math.abs((set1-set2)*12))
		consumptSec=math.floor((math.abs((set1-set2)/5))*100)/100
		minToFill = math.floor(math.abs((capacity-set2) / consumptMin))
		x=0
		y=0
	end
	
	if k ~= 1200 then
		k=k+1
	end
	
	
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)
	
	isPressingRectangle = isPressed and isPointInRectangle(inputX, inputY, 1, 12, 64, 14)	
	output.setBool(1, isPressingRectangle)
	
		
end
	
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
	


function onDraw()
if k == 1200 then

	screen.setColor(10, 10, 10)
	screen.drawRectF(0, 12, 64, 41)
	
	if isPressingRectangle then
		screen.setColor(20, 20, 20)
		screen.drawRectF(0, 12, 64, 13)
	end

	screen.setColor(70, 70, 70)
	screen.drawTextBox(2, 2, 60, 5, "consumption", 0, 0)
	
	screen.setColor(10, 10, 10)
	screen.drawRectF(3, 9, 59, 2)
	
	screen.setColor(20, 20, 20)
	screen.drawRectF(((x/600)*58)+2, 9, 2, 2)
	
	screen.setColor(40, 40, 40)
	screen.drawRect(2, 8, 59, 3)
	screen.drawLine(0, 11, 64, 11)
	
	screen.setColor(70, 70, 70)
	if time == 1 then
		screen.drawText(2, 13, "L/HOUR")
	elseif time == 2 then
		screen.drawText(2, 13, "L/MIN")
	elseif time == 3 then
		screen.drawText(2, 13, "L/SEC")
	end
	screen.setColor(27, 70, 12)
	if consumptHour < -5 or consumptHour > 5 then
		if time == 1 then
			screen.drawText(2, 19, absConsumptHout)
		elseif time == 2 then 
			screen.drawText(2, 19, consumptMin)
		elseif time == 3 then 
			screen.drawText(2, 19, consumptSec)
		end
	else 
		screen.drawText(2, 19, "--")
	end
	screen.setColor(40, 40, 40)
	screen.drawLine(0, 25, 64, 25)
	screen.drawLine(56, 14, 60, 18)
	screen.drawLine(56, 22, 61, 17)
	
	screen.setColor(70, 70, 70)
	if consumptHour < -30 then
		screen.drawText(2, 27, "FILL MIN")
		screen.setColor(27, 70, 12)
		screen.drawText(2, 33, minToFill)
	else	
		if convert == 3.6 then
			screen.drawText(2, 27, "L/100 KM")
		elseif convert == 2.236936 then
			screen.drawText(2, 27, "L/100 MILES")
		elseif convert == 1.943844 then
			screen.drawText(2, 27, "L/100 KNOTS")
		end
		screen.setColor(27, 70, 12)
		if speed > 5 then
			screen.drawText(2, 33, per100kph)
		else 
			screen.drawText(2, 33, "--") 
		end
	end
	
	screen.setColor(40, 40, 40)
	screen.drawLine(0, 39, 64, 39)
	
	screen.setColor(70, 70, 70)
	screen.drawText(2, 41, "FUEL L")
	screen.setColor(27, 70, 12)
	screen.drawText(2, 47, fuel)
	screen.setColor(40, 40, 40)
	screen.drawLine(0, 53, 64, 53)
	
	screen.drawRect(2, 53, 59, 8)
	screen.setColor(20, 20, 20)
	screen.drawRect(3, 54, 57, 6)
	screen.setColor(10, 27, 4)
	screen.drawRectF(4, 55, percent*56, 5)
	
	
else
	screen.drawTextBox(2, 27, 60, 5, "loading", 0, 0)
	screen.drawRect(2, 33, 59, 8)
	screen.setColor(12, 20, 70)
	screen.drawRectF(3, 34, (k/1200)*58, 7)
end
end