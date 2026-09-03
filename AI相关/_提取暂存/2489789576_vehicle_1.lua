-- source: steam id 2489789576 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2489789576
spda=0
spdkmph=0
rpsa=0
cfbw=0
cfbh=0
function onTick()
	fuel = input.getNumber(3)
	bat = input.getNumber(4)
	temp = input.getNumber(5)
	spd = input.getNumber(10)
	rps = input.getNumber(11)
	gear = input.getNumber(12)
	rev = input.getBool(3)
	mode = input.getBool(4)
	right = input.getBool(5)
	left = input.getBool(6)
	park = input.getBool(7)
end
function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	cfbw=0.1*w
	cfbh=0.35*h
	screen.setColor(220, 220, 220)
	screen.drawCircle(cfbw, cfbh, 0.25*h)
	screen.setColor(0, 0, 0)
	screen.drawRectF(0, cfbh-4, 0.8*h, 9)
	screen.setColor(244, 11, 11)
	fuela=math.pi*fuel/360+math.pi/4
	bata=-(math.pi*bat/2+math.pi/4)
	screen.drawLine(cfbw, cfbh, cfbw-0.35*h*math.cos(fuela),cfbh-0.35*h*math.sin(fuela))
	screen.drawLine(cfbw, cfbh, cfbw-0.35*h*math.cos(bata),cfbh-0.35*h*math.sin(bata))
	screen.setColor(0, 0, 0)
	screen.drawCircleF(cfbw, cfbh, 0.15*h)
	screen.setColor(220, 220, 220)
	cew=math.floor(cfbw)-2
	ceh=math.floor(cfbh)-5
	screen.drawRect(cew,ceh,2.5,5)
	screen.drawRectF(cew,ceh+3,2,3)
	screen.drawLine(cew+2,ceh,cew+4.5,ceh+2)
	screen.drawLine(cew+2,ceh+4,cew+4.5,ceh+4)
	screen.drawLine(cew+4,ceh+3,cew+4,ceh+4)
	screen.drawRect(cew,ceh+8,4,3)
	screen.drawLine(cew+1,ceh+7,cew+1,ceh+8.5)
	screen.drawLine(cew+3,ceh+7,cew+3,ceh+8.5)
	screen.setColor(222, 66, 66)
	screen.drawLine(0.5*w, 0.8*h, 0.5*w-0.64*h*math.cos(math.pi*0.75),0.8*h-0.64*h*math.sin(math.pi*0.75))
	screen.drawLine(0.5*w, 0.8*h, 0.5*w-0.64*h*math.cos(math.pi*0.875),0.8*h-0.64*h*math.sin(math.pi*0.875))
	screen.setColor(220, 220, 220)
	screen.drawLine(0.5*w, 0.8*h, 0.5*w-0.64*h*math.cos(math.pi*0.125),0.8*h-0.64*h*math.sin(math.pi*0.125))
	screen.drawLine(0.5*w, 0.8*h, 0.5*w-0.64*h*math.cos(math.pi*0.25),0.8*h-0.64*h*math.sin(math.pi*0.25))
	screen.drawLine(0.5*w, 0.8*h, 0.5*w-0.64*h*math.cos(math.pi*0.375),0.8*h-0.64*h*math.sin(math.pi*0.375))
	screen.drawLine(0.5*w, 0.8*h, 0.5*w-0.64*h*math.cos(math.pi*0.5),0.8*h-0.64*h*math.sin(math.pi*0.5))
	screen.drawLine(0.5*w, 0.8*h, 0.5*w-0.64*h*math.cos(math.pi*0.625),0.8*h-0.64*h*math.sin(math.pi*0.625))
	screen.drawCircle(0.5*w, 0.8*h, 0.65*h)
	screen.setColor(0, 0, 0)
	screen.drawRectF(0.5*w, 0.8*h, 0.65*h, 0.2*h)
	spdkmph=math.floor(math.abs(3.6*spd))
	spda=math.pi*(spdkmph/200)
	screen.setColor(244, 11, 11)
	screen.drawLine(0.5*w, 0.8*h, 0.5*w-0.65*h*math.cos(spda),0.8*h-0.65*h*math.sin(spda))
	screen.setColor(0, 0, 0)
	screen.drawCircleF(0.5*w, 0.8*h, 0.55*h)
	rpsa=math.pi*(rps/40)
	screen.setColor(244, 11, 11)
	screen.drawLine(0.5*w, 0.8*h, 0.5*w-0.54*h*math.cos(rpsa),0.8*h-0.54*h*math.sin(rpsa))
	screen.setColor(0, 0, 0)
	screen.drawCircleF(0.5*w, 0.8*h, 0.3*h)
	screen.setColor(220, 220, 220)
	--screen.drawText(0.5*w-4, 0.4*h, spdkmph)
	screen.drawTextBox(0.5*w-12,0.4*h,25,9,spdkmph,0,-1)
	screen.setColor(220, 150, 0)
	if right then
	screen.drawRectF(0.75*w, 0.1*h, 3, 3)
	end
	if left then
	screen.drawRectF(0.25*w-3, 0.1*h, 3, 3)
	end
	cgw=w-12
	cgh=2
	screen.setColor(220, 220, 220)
	if park then
	screen.setColor(244, 11, 11)
	screen.drawText(cgw,cgh,"P")
	else
	if rev then
	screen.drawText(cgw,cgh,"R")
	else
	if mode then
	screen.drawText(cgw,cgh,"S")
	else
	screen.drawText(cgw,cgh,"D")
	end
	end
	end
	screen.drawText(cgw+7,cgh,math.floor(gear+0.01))
	screen.setColor(255*rps/40,255*(1-rps/40),20)
	screen.drawTextBox(w-20,cgh+7,20,10,math.floor(rps*1.2)*50,1,-1)
	screen.setColor(220, 220, 220)
	screen.drawText(cgw-2,cgh+14,"RPM")
	screen.setColor(255*temp/120,255*(1-temp/120),20)
	ctw=5
	cth=h-25
	screen.drawLine(ctw+4,cth+15,ctw+4,cth+20)
	screen.drawLine(ctw+4,cth+15,ctw+5.5,cth+15)
	screen.drawLine(ctw+4,cth+17,ctw+5.5,cth+17)
	screen.drawLine(ctw+2,cth+19,ctw+3,cth+19)
	screen.drawLine(ctw+6,cth+19,ctw+7,cth+19)
	screen.drawLine(ctw+2,cth+21,ctw+6.5,cth+21)
end