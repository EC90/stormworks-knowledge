-- source: steam id 3793489743 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793489743
--weather icons page 2

s = screen
sc = s.setColor
dl = s.drawLine
drf = s.drawRectF
dr =s.drawRect


function onTick()

bgr = input.getNumber(30)
bgg = input.getNumber(31)
bgb = input.getNumber(32)

sunsnow = input.getBool(15)
snowflake = input.getBool(16)
snowcloud = input.getBool(17)

end

function onDraw()
	
	if sunsnow then
	--sun cloud snow
	
	--cloud
	x2 = 0.5
	y2 = 3
	
	sc(255,255,255)
	dl(x2+7, y2+2, x2+9, y2+2)
	dl(x2+6, y2+3, x2+10, y2+3)
	dl(x2+5, y2+4, x2+12, y2+4)
	dl(x2+3, y2+5, x2+13, y2+5)
	dl(x2+2, y2+6, x2+13, y2+6)
	dl(x2+2, y2+7, x2+13, y2+7)
	
	sc(64,64,64)
	dl(x2+10, y2+3, x2+10, y2+5)
	dl(x2+5, y2+5, x2+6, y2+4)
	dl(x2+9, y2+5, x2+8, y2+5)
	dl(x2+14, y2+6, x2+14, y2+8)
	dl(x2+3, y2+8, x2+13, y2+8)
	
	
	--one snowflake rain
	
	x11 = 0
	y11 = 11
	
	sc(255, 255, 255)
	dl(x11+5, y11+5, x11+8, y11+2)
	dl(x11+5, y11+3, x11+8, y11+6)
	dl(x11+9, y11+4, x11+12, y11+1)
	dl(x11+9, y11+2, x11+12, y11+5)
	
	end
	
	if snowflake then
	--snowflake
	
	x7 = 1
	y7 = 1
	
	sc(255,255,255)
	dl(x7+7, y7+2, x7+7, y7+13)
	dl(x7+2, y7+7, x7+13, y7+7)
	
	dl(x7+6, y7+3, x7+9, y7+3)
	dl(x7+11, y7+6, x7+11, y7+9)
	dl(x7+8, y7+11, x7+5, y7+11)
	dl(x7+3, y7+8, x7+3, y7+5)
	
	dl(x7+6, y7+6, x7+9, y7+6)
	dl(x7+6, y7+8, x7+9, y7+8)
	

	
	dl(x7+10, y7+3, x7+10, y7+5)
	dl(x7+11, y7+4, x7+9, y7+4)
	dl(x7+9, y7+5, x7+10, y7+5)
	
	dl(x7+11, y7+10, x7+9, y7+10)
	dl(x7+10, y7+11, x7+10, y7+9)
	dl(x7+9, y7+9, x7+10, y7+9)
	
	dl(x7+4, y7+11, x7+4, y7+9)
	dl(x7+3, y7+10, x7+5, y7+10)
	dl(x7+5, y7+9, x7+6, y7+9)
	
	dl(x7+3, y7+4, x7+5, y7+4)
	dl(x7+4, y7+3, x7+4, y7+5)
	dl(x7+5, y7+5, x7+6, y7+5)
	
	sc(bgr,bgg,bgb) 							--center Point
	dl(x7+7, y7+7, x7+8, y7+8)
	
	end
	
	if snowcloud then
	
	--snowcloud
	
	--cloud
	x2 = 0.5
	y2 = 3
	
	sc(255,255,255)
	dl(x2+7, y2+2, x2+9, y2+2)
	dl(x2+6, y2+3, x2+10, y2+3)
	dl(x2+5, y2+4, x2+12, y2+4)
	dl(x2+3, y2+5, x2+13, y2+5)
	dl(x2+2, y2+6, x2+13, y2+6)
	dl(x2+2, y2+7, x2+13, y2+7)
	
	sc(64,64,64)
	dl(x2+10, y2+3, x2+10, y2+5)
	dl(x2+5, y2+5, x2+6, y2+4)
	dl(x2+9, y2+5, x2+8, y2+5)
	dl(x2+14, y2+6, x2+14, y2+8)
	dl(x2+3, y2+8, x2+13, y2+8)
	
	
	--snow
	
	x10 = 2
	y10 = 11
	
	sc(255,255,255)
	dl(x10+1, y10+4, x10+4, y10+1)
	dl(x10+1, y10+2, x10+4, y10+5)
	dl(x10+3, y10+4, x10+6, y10+1)
	dl(x10+3, y10+2, x10+6, y10+5)
	dl(x10+5, y10+4, x10+8, y10+1)
	dl(x10+5, y10+2, x10+8, y10+5)
	dl(x10+7, y10+4, x10+10, y10+1)
	dl(x10+7, y10+2, x10+10, y10+5)
	dl(x10+9, y10+4, x10+12, y10+1)
	dl(x10+9, y10+2, x10+12, y10+5)
	end
	
end