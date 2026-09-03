-- source: steam id 2446775682 / microcontroller.xml block#37
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2446775682
function onTick()



	page = input.getNumber(31)
	osb = input.getNumber(32)
	pitch = input.getNumber(19)
	roll = input.getNumber(20)
	yaw = input.getNumber(21)
	coll = input.getNumber(22)
	pres = input.getNumber(23)
	vs = input.getNumber(24)
	alpha = input.getNumber(25)
	mapx = input.getNumber(26)
	mapy = input.getNumber(27)
	zoom = input.getNumber(28)
	acas = input.getBool(21)
	gdist = input.getNumber(26)

	
	
	
	
	
x=2
end
function onDraw()
if page==2 then
screen.setColor(200,100,200)
	if alpha>9.9 then
	screen.drawTextBox(5, 22, 20, 10,(string.format("%0.0f", alpha)), -1, 0)
	else
	screen.drawTextBox(5, 22, 20, 10,(string.format("%0.1f", alpha)), -1, 0)
	end
	if vs>9.9 then
	screen.drawTextBox(39, 22, 20, 10,(string.format("%0.0f", vs)), 1, 0)
	else 
	screen.drawTextBox(39, 22, 20, 10,(string.format("%0.1f", vs)), 1, 0)
	end

	if acas==true then
	screen.setColor(200,0,0)
	screen.drawLine(20-gdist, 20, 33-gdist, 33)
	screen.drawLine(20-gdist, 44, 33-gdist, 31)
	
	screen.drawLine(44+gdist, 44, 31+gdist, 31)
	screen.drawLine(44+gdist, 20, 31+gdist, 33)
	if gdist==0 then
	screen.drawTextBox(0, 10, 64, 10,"flyup", 0, 0)
	end
	end
end
	if page==26 then
	screen.setColor(0, 0, 0)
	screen.drawRectF(0, 0, 70, 70)
	screen.setColor(200, 200, 200)
	screen.drawLine(10+x, 50, 10+x, 14)
	screen.drawLine(11+x, 50, 11+x, 14)
	screen.drawLine(16+x, 50, 16+x, 14)
	screen.drawLine(17+x, 50, 17+x, 14)
	screen.drawText(5, 30, "c")
	screen.drawText(20+x, 30, "p")
	screen.drawText(32, 38, "hyd:")
	screen.drawText(32, 45, (string.format("%0.2f", pres)))
	screen.setColor(200, 200, 0)
	screen.drawText(7+x, 55, "-1")
	screen.drawText(12+x, 7, "1")
	
	screen.setColor(255, 0, 0)
	screen.drawLine(9+x, 32-17*coll, 13+x, 32-17*coll)
	screen.drawLine(15+x, 32+17*pitch, 19+x, 32+17*pitch)
	
	
	screen.setColor(200, 200, 200)
	screen.drawLine(25, 16, 55, 16)
	screen.drawLine(25, 17, 55, 17)
	screen.drawLine(25, 22, 55, 22)
	screen.drawLine(25, 23, 55, 23)
	screen.drawText(39, 9, "r")
	screen.drawText(39, 26, "y")
	screen.setColor(200, 200, 0)
	screen.drawText(50, 9, "1")
	screen.drawText(25, 9, "1")
	screen.drawText(23, 9, "-")
	
	screen.setColor(255, 0, 0)
	screen.drawLine(40+roll*15, 15, 40+roll*15, 19)
	screen.drawLine(40+yaw*15, 21, 40+yaw*15, 25)
		
	screen.setColor(200, 200, 200)
	screen.drawText(25, 55, "mnu")
end
end