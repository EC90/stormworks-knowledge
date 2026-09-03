-- source: steam id 2446775682 / microcontroller.xml block#20
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2446775682
function onTick()

	page = input.getNumber(31)
	osb = input.getNumber(32)

	clr = input.getBool(16)
	rdr = input.getNumber(10)
	
	if page==2 and osb==11 then color=true else color=false end
	output.setBool(1, color)
	ap = input.getBool(15)
	pitch = input.getNumber(18)
	roll = input.getNumber(19)
	comps = input.getNumber(3)
	spd = input.getNumber(12)
	ias = input.getNumber(26)
	alt = input.getNumber(20)
	apalt = input.getNumber(25)
	y1=(pitch*720)+(roll*400)+36
	y2=(pitch*720)-(roll*400)+36
	y=(y1+y2)/2
	al = input.getNumber(27)
	q = input.getNumber(28)
	hld = input.getBool(22)
	
	apup = input.getNumber(21)
	hydlo = input.getBool(5)
	pump1 = input.getNumber(23)
	pump2 = input.getNumber(24)
	
	loctr = input.getBool(6)
	closing = input.getBool(7)
	epirb = input.getNumber(22)
end
function onDraw()

if page==2 then
	if clr==false then
	screen.setColor(5, 5, 150)
	screen.drawRectF(0, 0, 70, 70)
	screen.setColor(25, 10, 5)
	else
	screen.setColor(5, 5, 5)
	screen.drawRectF(0, 0, 70, 70)
	screen.setColor(1, 1, 1)
	end
	screen.drawTriangleF(0, y1, 64, y2, 0, 600)
	screen.drawTriangleF(0, y1, 64, y2, 64, 600)
	screen.setColor(210, 210, 210)
	screen.drawLine(0, y1-1, 64, y2-1)
	screen.drawLine(15, y+20, 23, y+20)
	screen.drawLine(41, y+20, 49, y+20)
	screen.drawTextBox(22, y+17, 20, 8,"-10", 0, 0)
	screen.drawLine(15, y+40, 23, y+40)
	screen.drawLine(41, y+40, 49, y+40)
	screen.drawTextBox(22, y+37, 20, 8,"-20", 0, 0)
	screen.drawLine(15, y+60, 23, y+60)
	screen.drawLine(41, y+60, 49, y+60)
	screen.drawTextBox(22, y+57, 20, 8,"-30", 0, 0)
	screen.drawLine(15, y+80, 23, y+80)
	screen.drawLine(41, y+80, 49, y+80)
	screen.drawTextBox(22, y+77, 20, 8,"-40", 0, 0)
	screen.drawLine(15, y+100, 23, y+100)
	screen.drawLine(41, y+100, 49, y+100)
	screen.drawTextBox(22, y+97, 20, 8,"-50", 0, 0)
	screen.drawLine(15, y-20, 23, y-20)
	screen.drawLine(41, y-20, 49, y-20)
	screen.drawTextBox(22, y-23, 20, 8,"10", 0, 0)
	screen.drawLine(15, y-40, 23, y-40)
	screen.drawLine(41, y-40, 49, y-40)
	screen.drawTextBox(22, y-43, 20, 8,"20", 0, 0)
	screen.drawLine(15, y-60, 23, y-60)
	screen.drawLine(41, y-60, 49, y-60)
	screen.drawTextBox(22, y-63, 20, 8,"30", 0, 0)
	screen.drawLine(15, y-80, 23, y-80)
	screen.drawLine(41, y-80, 49, y-80)
	screen.drawTextBox(22, y-83, 20, 8,"40", 0, 0)
	screen.drawLine(15, y-100, 23, y-100)
	screen.drawLine(41, y-100, 49, y-100)
	screen.drawTextBox(22, y-103, 20, 8,"50", 0, 0)
	if al~=0 and q~=0 then
	screen.setColor(210, 210, 0)
	screen.drawLine(30+q, 36+al, 31+q, 36+al)
	screen.drawLine(33+q, 36+al, 35+q, 36+al)
	screen.drawLine(32+q, 35+al, 32+q, 33+al)
	screen.drawCircle(32+q, 36+al, 1)
	end
	screen.setColor(0, 0, 0, 200)
	screen.drawRectF(0, 29, 20, 13)
	screen.drawRectF(40, 29, 25, 13)
	screen.drawRectF(54, 49, 9, 10)
	screen.setColor(0, 0, 0)
	screen.drawRectF(22, 52, 20, 10)

	screen.setColor(255, 255, 0)
	screen.drawTextBox(5, 34, 20, 10,(string.format("%0.0f", spd)), -1, 0)
	screen.setColor(210,210, 210)
	screen.drawTextBox(39, 28, 20, 10,(string.format("%0.0f", alt)), 1, 0)
	screen.drawTextBox(39, 34, 20, 10,(string.format("%0.0f", rdr)).."r", 1, 0)
	screen.drawTextBox(22, 52, 20, 10,(string.format("%0.0f", comps)), 0, 0)
	screen.drawTextBox(5, 28, 20, 10,(string.format("%0.0f", ias)), -1, 0)
	screen.drawLine(32, 36, 29, 39)
	screen.drawLine(32, 36, 35, 39)
	screen.drawText(55, 50, "n")
	screen.setColor(0, 0, 0)
	screen.drawText(5, 50, "mnu")
	if ap==true then
	screen.setColor(0, 0, 0)
	screen.drawRectF(0, 0, 64, 11)
	if hld==true then
	screen.setColor(200,0,200)
	else
	screen.setColor(200, 200,200)
	end
	screen.drawTextBox(5, 5, 64, 5,(string.format("%0.0f", apalt)), -1, 0)
	screen.drawTextBox(5, 5, 56, 5,"athld", 1, 0)
	end
end

if page==23 then
	screen.setColor(0, 255, 0)
	screen.drawText(20, 5, "loctr")
	screen.drawText(25, 55, "mnu")
	if loctr==true then
	screen.drawText(5, 11, "epirb avlbl")
	screen.drawText(5, 20, "d:"..(string.format("%0.1f", epirb)))
	
	if closing==true then screen.drawText(5, 30, "closing") else screen.drawText(5, 30, "leaving") end
	else
	screen.drawText(5, 20, "no epirb")
end
end
end