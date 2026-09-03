-- source: steam id 2623064051 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2623064051
--Check description for details...

--Color 1. Used for static color or as color of minimum value
	r1,g1,b1 = 250,10,10
	
--Color 2. Used as color of maximum value
	r2,g2,b2 = 10,250,10
	
--Color of unfilled part
	r3,g3,b3 = 250,250,250

--Text color
	r4,g4,b4 = 250,250,250
	
--Background color
	r5,g5,b5 = 0,0,0

max = property.getNumber('Max value')
min = property.getNumber('Min value')
dec = property.getNumber('Digits after decimal point')
cm = property.getNumber('Color mode')
os = property.getNumber('Text position offset (horizontal)')
p1 = math.pi / 180

function rd(num)
	if dec > 0 then
		local mult = 10^(dec or 0)
		return math.floor(num * mult + 0.5) / mult
	else
		return math.floor(num)
	end
end

function clamp(value,bot,top)
	if bot > top then
		bot, top = top, bot
	end
	if value < top and value > bot then
		return value
	elseif value > top then
		return top
	else
		return bot
	end
end

function onTick()
	d = (max-min)
	val = rd(input.getNumber(1))
	a = (val-min / d * 260 - 220) * p1
	x = math.cos(a) * 14 + 16
	y = math.sin(a) * 14 + 17
end

function onDraw()
	--backround
	screen.setColor(r5,g5,b5)
	screen.drawRectF(0, 0, 33, 33)
	screen.drawCircleF(16, 16, 9)
	
	--text
	screen.setColor(r4,g4,b4)
	screen.drawTextBox(5,14,22,6,val,0,0)
	
	val = val - min
	screen.setColor(r1,g1,b1)
	for i = -270, 90 do
		ang = i * (p1)
		if i > (val / d * 260) - 220 then
			screen.setColor(r3,g3,b3)
		else
			if cm == 0 then --modes
				screen.setColor(r1,g1,b1)
			elseif cm == 1 then
				h = d + d*0.01
				screen.setColor(clamp(r1+(r2-r1)*((val)/h),r1,r2), clamp(g1+(g2-g1)*((val)/h),g1,g2), clamp(b1+(b2-b1)*((val)/h),b1,b2))
			else
				screen.setColor(r1+(r2-r1)*((215+i)/255),g1+(g2-g1)*((215+i)/255),b1+(b2-b1)*((215+i)/255))
			end
		end
		xc = math.cos(ang) * 14 + 16
		yc = math.sin(ang) * 14 + 17
		screen.drawCircleF(xc, yc, 1)
	end
	screen.setColor(r5,g5,b5)
	screen.drawRectF(0, 26, 33, 33)
	screen.setColor(r4,g4,b4)
	screen.drawTextBox(os, 26, 32, 6, property.getText('Text'), 0, 0)
end
