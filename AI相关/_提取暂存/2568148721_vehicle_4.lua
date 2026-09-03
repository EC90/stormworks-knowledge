-- source: steam id 2568148721 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2568148721
igN = input.getNumber
osN = output.setNumber
igB = input.getBool
osB = output.setBool
ssC = screen.setColor
sdL = screen.drawLine
sdC = screen.drawCircle
sdR = screen.drawRect
sdTF = screen.drawTriangleF
sdRF= screen.drawRectF
sdCF = screen.drawCircleF
sdT = screen.drawText
stf = string.format
sts = string.sub

p1,p2,p3,p4,p5,p6,p7,p8=0,0,0,0,0,0,0,0

function onTick()
	bar_1 = igB(1) or igB(2) or igB(3) 
	bar_2 = igB(4) or igB(5) or igB(6) 
	bar_3 = igB(7) or igB(8) or igB(9)
	bar_4 = igB(10) or igB(11) or igB(12)
	bar_5 = igB(13) or igB(14) or igB(15)
	bar_6 = igB(16) or igB(17) or igB(18)
	bar_7 = igB(19) or igB(20) or igB(21)
	bar_8 = igB(22) or igB(23) or igB(24) or igB(25)
	
	position = (igN(1)/igN(2))*18
	if igB(32) == true then
		if bar_1 == true then p1 = 5 end
		if bar_2 == true then p2 = 5 end
		if bar_3 == true then p3 = 5 end
		if bar_4 == true then p4 = 5 end
		if bar_5 == true then p5 = 5 end
		if bar_6 == true then p6 = 5 end
		if bar_7 == true then p7 = 5 end
		if bar_8 == true then p8 = 5 end
	end
	
	if p1 >= 0 then p1=p1-0.1 end
	if p2 >= 0 then p2=p2-0.1 end
	if p3 >= 0 then p3=p3-0.1 end
	if p4 >= 0 then p4=p4-0.1 end
	if p5 >= 0 then p5=p5-0.1 end
	if p6 >= 0 then p6=p6-0.1 end
	if p7 >= 0 then p7=p7-0.1 end
	if p8 >= 0 then p8=p8-0.1 end
end

function soundbar(x,y,power)
	if 1 <= power then
		ssC(150,0,0)
		sdL(x,y,x+4,y)
	end
	if 2 <= power then
		ssC(150,0,0)
		sdL(x,y-2,x+4,y-2)
	end
	if 3 <= power then
		ssC(150,150,0)
		sdL(x,y-4,x+4,y-4)
	end
	if 4 <= power then
		ssC(0,150,0)
		sdL(x,y-6,x+4,y-6)	
	end	
end

function onDraw()
	soundbar(32,24,p1)
	soundbar(32+5*1,24,p2)
	soundbar(32+5*2,24,p3)
	soundbar(32+5*3,24,p4)
	soundbar(32+5*4,24,p5)
	soundbar(32+5*5,24,p6)
	soundbar(32+5*6,24,p7)
	soundbar(32+5*7,24,p8)
	ssC(50,50,50)
	sdL(72,21,91,21)
	ssC(255,255,255)
	sdL(72,19,72,24)
	sdL(90,19,90,24)
	sdL(80,19,80,24)
	sdL(85,19,85,24)
	sdRF(72,20,position,3)	
end