-- source: steam id 3793489743 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793489743
--Weather Icons page 1

s = screen
sc = s.setColor
dl = s.drawLine
drf = s.drawRectF
dr =s.drawRect



function onTick()

bgr = input.getNumber(30)
bgg = input.getNumber(31)
bgb = input.getNumber(32)


sunrain = input.getBool(10)
sun = input.getBool(11)
rain = input.getBool(12)
thunder = input.getBool(13)
sunsnowrain = input.getBool(14)
sunsnow = input.getBool(15)
moonc = input.getBool(30)
sunc = input.getBool(31)
moonh = input.getBool(32)
end

function onDraw()

	if sunc then
	
	--sun
	
	x1 = -0.5
	y1 = -0.5
	
	sc(255, 255, 0)			 
	drf(x1+4, y1+5.5, 6, 4)  
	drf(x1+5, y1+4.5, 4, 6)  
	
	dl(x1+7, y1+2, x1+7, y1+3)
	dl(x1+10, y1+4, x1+11, y1+3)
	dl(x1+11, y1+7, x1+12, y1+7)
	dl(x1+10, y1+10, x1+11, y1+11)
	dl(x1+7, y1+12, x1+7, y1+11)
	dl(x1+4, y1+10, x1+3, y1+11)
	dl(x1+7, y1+12, x1+7, y1+11)
	dl(x1+2, y1+7, x1+3, y1+7)
	dl(x1+3, y1+3, x1+4, y1+4)
	end
	
	if moonc then
	
	--moon
	
	sc(100,100,100)
	screen.drawCircleF(6, 6, 5)
	
	
	end
	
	
	if moonh then
	
	--moon half

	sc(100,100,100)
	screen.drawCircleF(7, 9, 5)
	
	sc(bgr, bgg, bgb)
	screen.drawCircleF(5, 9, 4)
	
	end
	
	if sunrain then
	--sun cloud rain
	
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
	
	
	--rain
	x4 = 1.5
	y4 = 11
	
	sc(255,255,255)
	dl(x4+1, y4+4, x4+4, y4+1)
	dl(x4+5, y4+4, x4+7, y4+1)
	dl(x4+8, y4+4, x4+10, y4+1)
	
	end
	
	if sun then
	--sun
	x1 = 0.5
	y1 = 1.5
	
	sc(255, 255, 0)			 
	drf(x1+4, y1+5.5, 6, 4)  
	drf(x1+5, y1+4.5, 4, 6)  
	
	dl(x1+7, y1+2, x1+7, y1+3)
	dl(x1+10, y1+4, x1+11, y1+3)
	dl(x1+11, y1+7, x1+12, y1+7)
	dl(x1+10, y1+10, x1+11, y1+11)
	dl(x1+7, y1+12, x1+7, y1+11)
	dl(x1+4, y1+10, x1+3, y1+11)
	dl(x1+7, y1+12, x1+7, y1+11)
	dl(x1+2, y1+7, x1+3, y1+7)
	dl(x1+3, y1+3, x1+4, y1+4)
	end
	
	if rain then
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
	
	
	--rain
	x4 = 1.5
	y4 = 11
	
	sc(255,255,255)
	dl(x4+1, y4+4, x4+4, y4+1)
	dl(x4+5, y4+4, x4+7, y4+1)
	dl(x4+8, y4+4, x4+10, y4+1)
	end
	
	if thunder then
	
	--cloud
	x2 = -0.5
	y2 = 0
	
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
	
	--thunder rain
	x5 = 1.5
	y5 = 8
	sc(255,255,255)
	dl(x5+1, y5+4, x5+4, y5+1)
	dl(x5+8, y5+4, x5+10, y5+1)
	
	sc(255,255,0)
	dl(x5+4, y5+4, x5+7, y5+1)
	dl(x5+3, y5+5, x5+7, y5+5)
	dl(x5+7, y5+5, x5+4, y5+8)
	
	end
	
	if sunsnowrain then
	
	--sun cloud snow rain
	
	--cloud
	x2 = -0.5
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
	
	x9 = 1
	y9 = 11
	
	
	sc(255,255,255)
	dl(x9+1, y9+4, x9+4, y9+1)
	dl(x9+5, y9+4, x9+8, y9+1)
	dl(x9+9, y9+4, x9+12, y9+1)
	dl(x9+9, y9+2, x9+12, y9+5)
	end


end