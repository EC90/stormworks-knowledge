-- source: steam id 2156436786 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2156436786
s=screen
s.dt=s.drawText
i=input
i.gn=i.getNumber
s.sc=s.setColor

x=0
y=0
z=0
k=1200
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

	speed = i.gn(11)
	fluidLvl = i.gn(12)
	capacity = i.gn(13)
	time = i.gn(14)
	distance = i.gn(15)
	
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
		consumptSec=math.floor((math.abs((set1-set2)/5))*10)/10
		minToFill = math.floor(math.abs((capacity-set2) / consumptMin))
		x=0
		y=0
	end
	
	if k ~= 1200 then
		k=k+1
	end
	
	
	inputX = i.gn(3)
	inputY = i.gn(4)
	isPressed = input.getBool(1)
	
	isPressingRectangle = isPressed and isPointInRectangle(inputX, inputY, 0, 0, 32, 12)	
	output.setBool(1, isPressingRectangle)
	
		
end
	function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
	

function onDraw()
if k == 1200 then

	s.sc(0, 0, 0)
	s.drawRectF(0, 0, 32, 27)
	
	if isPressingRectangle then
		s.sc(20, 20, 20)
		screen.drawRectF(0, 0, 33, 13)
	end
	
	s.sc(10, 10, 10)
	s.drawRectF(3, 28, 26, 2)
	s.sc(255, 255, 255)
	--s.drawRectF(3, 28, percent*26, 2)
	s.drawRectF(3, 28, percent*18, 2)
	
	s.sc(20, 20, 20)
	s.drawRectF(((x/600)*26)+2, 28, 2, 2)
	
	
	s.sc(40, 40, 40)
	s.drawRect(2, 27, 27, 3)
	s.drawLine(0, 27, 32, 27)
	
	s.sc(70, 70, 70)
	if time == 1 then
		s.dt(1, 1, " HOUR")
	elseif time == 2 then
		s.dt(1, 1, " MIN")
	elseif time == 3 then
		s.dt(1, 1, " SEC")
	end
	
	s.sc(20, 20, 20)
	s.dt(1, 1, "     >")
	
	if consumptHour < -20 or consumptHour > 20 then
		if time == 1 then
			if absConsumptHout < 99999 then
				s.sc(20, 20, 20)
				s.dt(1, 7, absConsumptHout .. "L")
				s.sc(40, 40, 40)
				s.dt(1, 7, absConsumptHout)
			else
				s.sc(20, 20, 20)
				s.dt(1, 7, math.floor(absConsumptHout/1000) .. "T")
				s.sc(40, 40, 40)
				s.dt(1, 7, math.floor(absConsumptHout/1000))
			end
		elseif time == 2 then 
			if consumptMin < 99999 then
				s.sc(20, 20, 20)
				s.dt(1, 7, consumptMin .. "L")
				s.sc(40, 40, 40)
				s.dt(1, 7, consumptMin)
			else
				s.sc(20, 20, 20)
				s.dt(1, 7, math.floor(consumptMin/1000) .. "T")
				s.sc(40, 40, 40)
				s.dt(1, 7, math.floor(consumptMin/1000))
			end
		elseif time == 3 then 
			s.sc(20, 20, 20)
			s.dt(1, 7, consumptSec .. "L")
			s.sc(40, 40, 40)
			s.dt(1, 7, consumptSec)
		end
	else 
		s.sc(255, 255, 255)
		s.dt(2, 7, "--")
	end
	s.sc(40, 40, 40)
	s.drawLine(0, 13, 32, 13)
	
	s.sc(70, 70, 70)
	if consumptHour < -30 then
		s.dt(1, 15, "FILL")
		s.sc(20, 20, 20)
		s.dt(1, 21, minToFill.."m")
		s.sc(50, 50, 50)
		s.dt(1, 21, minToFill)
		
	else	
		if convert == 3.6 then
			s.dt(1, 15, "100 KM")
		elseif convert == 2.236936 then
			s.dt(1, 15, "100 mi")
		elseif convert == 1.943844 then
			s.dt(1, 15, "100 Kt")
		end
		
		if speed > 5 then
			if per100kph < 99999 then
				s.sc(20, 20, 20)
				s.dt(1, 21, per100kph.."L")
				s.sc(40, 40, 40)
				s.dt(1, 21, per100kph)
			else
				s.sc(20, 20, 20)
				s.dt(1, 21, math.floor(per100kph/100) .."T")
				s.sc(40, 40, 40)
				s.dt(1, 21, math.floor(per100kph/100))
			end
		else 
			s.sc(50, 50, 50)
			s.dt(2, 21, "--") 
		end
	end
	
	
			
	
	
	
else
	s.drawTextBox(0, 7, 32, 5, "load", 0, 0)
	s.drawRect(2, 13, 27, 8)
	s.sc(12, 20, 70)
	s.drawRectF(3, 14, (k/1200)*25, 7)
end
end