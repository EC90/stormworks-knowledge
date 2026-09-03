-- source: steam id 2778980873 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2778980873
ssc = screen.setColor
pi = math.pi
iGN = input.getNumber 
iGB = input.getBool
pGN = property.getNumber
sdl = screen.drawLine
s = screen 
h1 = 2
a = 150
range = 0
rangeold = 0
speed = 0
function onTick()
ed = iGB(5)
if ed then
	iX = iGN(3)
	iY = iGN(4)
	yawangle = iGN(5)*pi*2
	pitchangle = iGN(6)*pi*-2
	modifier = pGN("Zoom Modifier")
	rw = pGN("HUD Square Diameter")
	zoom = clamp(iGN(7),0,1)
	range = iGN(8)
	strength = iGN(9)
	lasrange = iGN(10)
	pr = iGB(1) and not isp
	isp = iGB(1)
	ed = iGB(5)
	bk = iGB(6)
	rcv = iGB(7)
mass = range * strength
speed = (range-rangeold)*-60
rangeold = range
zm1 = modifier *(zoom*4.5)+ 0.2



	if pr then
		if ispr(iX,iY,2,h1,15,10) 
		then ifr = not ifr 
			elseif ispr(iX,iY,25,h1,15,10) then
			tgt = not tgt
				elseif ispr(iX,iY,48,h1,15,10) then
				las = not las
		end
	end
	
	if las then
		output.setNumber(1, lasrange)
		else
		output.setNumber(1, range)
	end
	
	output.setBool(1, ifr)
	output.setBool(2, tgt)
	output.setBool(3, las)
	output.setBool(4, ed)
	output.setBool(5, rcv)
end

if rcv then 
output.setBool(2, rcv)
end

end

function ispr(x, y, rectX, rectY, rectW, rectH)
return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
if ed and range >= 0.1 then
	w = screen.getWidth()			
	h = screen.getHeight()	
	x = w/2+math.tan(yawangle)*w*zm1-5
	y = h/2+math.tan(pitchangle)*h*zm1-5				
	ssc(42,46,33)
	s.drawRect(x,y,rw,rw)
				
	ssc(1,1,1,210)
	s.drawRectF(x,y+13,31,21)
				
	ssc(191,191,191,255)
	s.drawText(x+2,y+14,string.format('%.2f',range/1000)..'km')
	s.drawText(x+2,y+21,string.format('%d',((speed)/0.016)//1)..'m/s')
	s.drawText(x+2,y+28,string.format('%.2f', (mass)/1000)..'T')
end

if ed then
	w = screen.getWidth()			
	h = screen.getHeight()
	ssc(42,46,33)
	s.drawCircle(w / 2, h / 2, 2)
	if range <= 0.1 then
		sdl(32, 28, 32, 10)
		sdl(32, 36, 32, 54)
		sdl(28,32,10,32)
		sdl(36,32,54,32)
		if bk then
			sdl(w*0.125,h*0.125,w*0.25,h*0.125)
			sdl(w*0.125,h*0.125,w*0.125,h*0.25)			
			sdl(w*0.875,h*0.125,w*0.75,h*0.125)
			sdl(w*0.875,h*0.125,w*0.875,h*0.25)
			sdl(w*0.125,h*0.875,w*0.25,h*0.875)
			sdl(w*0.125,h*0.875,w*0.125,h*0.75)	
			sdl(w*0.875,h*0.875,w*0.75,h*0.875)
			sdl(w*0.875,h*0.875,w*0.875,h*0.75)
		end
		
	end
	
	ssc(0,0,0,210)
	s.drawRectF(0,0,64,9)

	ssc(a,a,a)
	if ifr then 
		s.drawRectF(2,h1-1,15,7)
		ssc(0,0,0)
	end
	s.drawTextBox(2,h1,15,10, "IFR")

	ssc(a,a,a)
	if tgt then
		s.drawRectF(24,h1-1,16,7)
		ssc(0,0,0)
	end
	s.drawTextBox(25,h1,15,10, "TGT")

	ssc(a,a,a)
	if las then 
		s.drawRectF(47,h1-1,16,7)
		ssc(0,0,0)
	end
	s.drawTextBox(48,h1,15,10, "LAS")
	ssc(a,a,a)
	

end		
end

function clamp(x, y, z)
return math.max(y, math.min(x, z))
end