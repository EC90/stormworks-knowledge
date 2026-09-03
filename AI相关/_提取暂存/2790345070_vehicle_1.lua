-- source: steam id 2790345070 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2790345070
--features

s = screen
sc = s.setColor
dl = s.drawLine
drf = s.drawRectF
dr =s.drawRect



function onTick()
wda = (((1+input.getNumber(1))*360)%360)*(3.14/180)
bgr = input.getNumber(30)
bgg = input.getNumber(31)
bgb = input.getNumber(32)

temp = input.getNumber(10)
time = input.getNumber(11)
timeh24 = input.getNumber(12)
min = (time*1440)%60

x1 = 47+11*math.cos(wda-1.57)
y1 = 19+11*math.sin(wda-1.57)
end

function onDraw()

	
	sc(bgr, bgg, bgb)
	s.drawClear() 	
	
	
	sc(0,10,10)
	dr(0,0,15,18)
	
	dr(15,0,16,18)
	
	dr(0,18,31,13)

	--temperature
	sc(100,100,100)
	s.drawTextBox(15, 4, 16, 6, string.format("%.0f", temp), 0,0)
	s.drawTextBox(15, 11, 16, 6, "C", 0,0)
	
	
	--time
	sc(100,100,100)
	s.drawTextBox(4, 18, 24, 13, string.format("%.0f", timeh24),-1,0)
	s.drawTextBox(4, 18, 24, 13, ":",0,0)
	s.drawTextBox(3, 18, 24, 13, string.format("%.0f", min),1,0)
	
	--Relative Wind Direction
	sc(100,100,100)
	s.drawText(39, 1, "Wind")
	
	sc(0,9,9)
	s.drawCircle(47, 19, 11)
	
	sc(0,50,0)
	s.drawLine(45, 25, 50, 25)
	s.drawLine(44, 25, 44, 15)
	s.drawLine(50, 25, 50, 15)
	s.drawLine(44, 15, 48, 11)
	s.drawLine(50, 15, 46, 11)
	
	sc(100,100,100)
	s.drawLine(47, 19, x1, y1)
end