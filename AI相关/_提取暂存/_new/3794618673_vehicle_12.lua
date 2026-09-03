-- source: steam id 3794618673 / vehicle.xml block#12
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794618673
--features

s = screen
sc = s.setColor
dl = s.drawLine
drf = s.drawRectF
dr =s.drawRect



function onTick()
bgr = input.getNumber(30)
bgg = input.getNumber(31)
bgb = input.getNumber(32)

temp = input.getNumber(10)
time = input.getNumber(11)
timeh24 = input.getNumber(12)
min = (time*1440)%60
end

function onDraw()

	
	sc(bgr, bgg, bgb)
	screen.drawClear() 	
	
	
	sc(0,10,10)
	dr(0,0,15,18)
	
	dr(15,0,16,18)
	
	dr(0,18,31,13)

	--temperature
	sc(0,9,9)
	screen.drawTextBox(15, 4, 16, 6, string.format("%.0f", temp), 0,0)
	screen.drawTextBox(15, 11, 16, 6, "C", 0,0)
	
	
	--time
	sc(0,9,9)
	s.drawTextBox(4, 18, 24, 13, string.format("%.0f", timeh24),-1,0)
	s.drawTextBox(4, 18, 24, 13, ":",0,0)
	s.drawTextBox(3, 18, 24, 13, string.format("%.0f", min),1,0)
end