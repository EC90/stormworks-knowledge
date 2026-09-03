-- source: steam id 2751468095 / vehicle.xml block#14
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2751468095
function onTick()
    on=input.getBool(1)
	on2=input.getBool(2)
	on3=input.getBool(3)
	on4=input.getBool(4)
	range=input.getNumber(4)
	g=input.getNumber(2)
	ammo=input.getNumber(1)
	r=input.getNumber(3)
	flighttime=input.getNumber(5)
	heading=input.getNumber(6)
	coordinate=input.getNumber(7)
	rotation=input.getNumber(8)
	coordinate2=input.getNumber(9)
	elevation=input.getNumber(10)
	ammox=input.getNumber(11)
end

function onDraw()
	w=screen.getWidth()
    h=screen.getHeight()
if on2 then
	screen.setColor(0,200,105,50)
	screen.drawCircleF(w/2, h/2, 36)
end
if on then
    screen.setColor(0,150,0)
	screen.drawText( 50 , h -20 , ("RDY"))
end
if on3 then
    screen.setColor(0,150,0)
	screen.drawText( 0 , h - 10 , string.format( "%1.0fM" , range))
end
if not on3 then
    screen.setColor(150,0,0)
	screen.drawText( 0 , h -10 , string.format("N/A"))
end
if on4 then
	screen.setColor(0,150,0)
	screen.drawText(43,4,"STAB")
end
    screen.setColor(0,150,0)
	screen.drawText( 0 , h -20 , string.format("%0.1fs",flighttime))
		screen.setColor(r,g,0)
		screen.drawText( ammox , h - 10 , string.format("%1.0fRNDS",ammo))
			screen.setColor(0,150,0,175)
			screen.drawRect(30,28,4,4)
			screen.drawLine(32,26,32.25,27.25)
			screen.drawLine(35,30,36.25,30.25)
			screen.drawLine(32,33,32.25,34.25)
			screen.drawLine(28,30,29.25,30.25)
			screen.drawLine(32,18,32.25,23.25)
			screen.drawLine(32,37,32.25,42.25)
			screen.drawLine(39,30,42.25,30.25)
			screen.drawLine(39,25,49.25,25.25)
			screen.drawLine(39,35,49.25,35.25)
			screen.drawLine(22,30,25.25,30.25)
			screen.drawLine(15,25,25.25,25.25)
			screen.drawLine(15,36,25.25,36.25)
				screen.setColor(0,150,0)
				screen.drawText(coordinate, 2,string.format("%1.0f", heading))
					screen.drawRect(23,0,17,8)
					screen.setColor(0,100,0)
					screen.drawTriangleF(3,11.5,6,8.5,9,11.5)
					screen.setColor(0,150,0)
					screen.drawRect(3,12,6,9)
					x1 = 6 + 7 * math.cos((rotation*6.28)-1.57)
					y1 = 16 + 7 * math.sin((rotation*6.28)-1.57)
					screen.drawLine(6, 16, x1, y1)
						screen.setColor(0,150,0)
						screen.drawText( coordinate2 , h -50 , string.format( "%0.1f'" , elevation ) )
end