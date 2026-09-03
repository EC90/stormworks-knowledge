-- source: steam id 2836937357 / vehicle.xml block#11
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2836937357
range = 5
function onTick()
	mx = 64
	my = 64
	Compass = input.getNumber(10)
	HDG = (((360 + Compass) % 1)*360)
	HDG2 = (((360 + -Compass) % 1)*360)
	gpsx = input.getNumber(11)
	gpsy = input.getNumber(12)
	navx = input.getNumber(13)
	navy = input.getNumber(14)
	speedF = input.getNumber(15)
	speedR = input.getNumber(16)
	speedT = math.sqrt(speedF^2 + speedR^2)
	speedA = ((math.atan(speedF,speedR)*180/math.pi-180)+360)%360
	deltaX = (gpsx - navx)
	deltaY = (gpsy - navy)
	dtt = (math.sqrt(((gpsx - navx)^2) + ((gpsy - navy)^2)))/1850
	htt = ((math.atan(deltaX,deltaY)*180/math.pi-180)+360)%360
	speedScale = (speedT/100)*45
	if navx == 0  or navy == 0 then navLine = false else navLine = true end
	if dtt > 9 then range = 1.5 end
	if dtt < 9 then range = 5 end	
	if dtt < 3 then range = 15 end
	
	output.setNumber(1,htt)
	output.setNumber(2,dtt)
	
end
function onDraw()
    screen.setColor(0,0,0)
    screen.drawClear()
	screen.setColor(255,255,255)
	screen.drawTriangleF(mx/2-2,my,mx/2+2,my,mx/2,my-4)
	screen.drawCircle(mx/2,my,15)
	screen.drawCircle(mx/2,my,30)
	screen.drawCircle(mx/2,my,45)
	screen.setColor(255,255,255)
	screen.drawRect(mx/2-10,0,20,8)
	screen.drawText((mx/2-2+(39)*math.cos(math.rad(HDG-90))),(my+(39)*math.sin(math.rad(HDG-90))), "N")
	screen.drawText((mx/2-2+(39)*math.cos(math.rad(HDG-45))),(my+(39)*math.sin(math.rad(HDG-45))), "NE")
	screen.drawText((mx/2-2+(39)*math.cos(math.rad(HDG))),(my+(39)*math.sin(math.rad(HDG))), "E")
	screen.drawText((mx/2-2+(39)*math.cos(math.rad(HDG+45))),(my+(39)*math.sin(math.rad(HDG+45))), "SE")
	screen.drawText((mx/2-2+(39)*math.cos(math.rad(HDG+90))),(my+(39)*math.sin(math.rad(HDG+90))), "S")
	screen.drawText((mx/2-2+(39)*math.cos(math.rad(HDG+135))),(my+(39)*math.sin(math.rad(HDG+135))), "SW")
	screen.drawText((mx/2-2+(39)*math.cos(math.rad(HDG-180))),(my+(39)*math.sin(math.rad(HDG-180))), "W")
	screen.drawText((mx/2-2+(39)*math.cos(math.rad(HDG-135))),(my+(39)*math.sin(math.rad(HDG-135))), "NW")
	if range == 15 then
	screen.drawText (mx/2,my-10,"1")
	screen.drawText (mx/2+5,my-25,"2")
	screen.drawText (mx/2+10,my-40,"3") end
	if range == 5 then
	screen.drawText (mx/2,my-10,"3")
	screen.drawText (mx/2+5,my-25,"6")
	screen.drawText (mx/2+10,my-40,"9") end
	if range == 1.5 then
	screen.drawText (mx/2,my-10,"10")
	screen.drawText (mx/2+5,my-25,"20")
	screen.drawText (mx/2+10,my-40,"30") end
	if navLine then
	screen.setColor(255, 0, 102)
	screen.drawLine(mx/2,my,(mx/2-2+(dtt*range)*math.cos(math.rad(HDG+htt-90))),(my+(dtt*range)*math.sin(math.rad(HDG+htt-90))))
	screen.setColor(5,5,5)
	screen.drawCircleF((mx/2-2+(dtt*range)*math.cos(math.rad(HDG+htt-90))),(my+(dtt*range)*math.sin(math.rad(HDG+htt-90))), 5)
	screen.setColor(255, 0, 102)
	screen.drawText((mx/2-2+(dtt*range)*math.cos(math.rad(HDG+htt-90))-2),(my+(dtt*range)*math.sin(math.rad(HDG+htt-90))-2), "W")
	screen.drawCircle((mx/2-2+(dtt*range)*math.cos(math.rad(HDG+htt-90))),(my+(dtt*range)*math.sin(math.rad(HDG+htt-90))), 5)
	end
	screen.setColor(0, 255, 255)
	screen.drawLine(mx/2,my,(mx/2-2+(speedScale)*math.cos(math.rad(speedA))),(my+(speedScale)*math.sin(math.rad(speedA))))
	screen.drawLine((mx/2-2+(42)*math.cos(math.rad(speedA))),(my+(42)*math.sin(math.rad(speedA))),(mx/2-2+(46)*math.cos(math.rad(speedA))),(my+(46)*math.sin(math.rad(speedA))))
	screen.setColor(0,0,0)
	screen.drawRectF(0,0,mx,16)
	screen.setColor(255,255,255)
	screen.drawLine(0,16,my,16)
	screen.drawRect(mx/2-10,8,20,8)
	screen.drawLine(mx/2-1,18,mx/2-1,22)
	screen.drawLine(mx/2+1,18,mx/2+1,22)
	screen.drawText(mx/2-8,10,string.format("%03.0f",HDG2))
	screen.drawText(mx/2-8,2,"HDG")
	if navLine then
	screen.setColor(255, 0, 102)
	screen.drawText(mx/2-30,9,string.format("%02.1f",(dtt)))
	screen.drawText(mx/2-30,2,string.format("%03.0f",(htt)))
	else
	screen.setColor(255, 0, 102)
	screen.drawText(mx/2-30,9,"---")
	screen.drawText(mx/2-30,2,"---")
	end
	screen.setColor(0, 255, 255)
	screen.drawText(mx/2+12,9,string.format("%02.0f",(speedT)))
	screen.drawText(mx/2+12,2,"GS")
	end