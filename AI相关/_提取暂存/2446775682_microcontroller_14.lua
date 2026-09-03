-- source: steam id 2446775682 / microcontroller.xml block#14
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2446775682
function onTick()

	page = input.getNumber(31)
	osb = input.getNumber(32)
	
	thtl1 = input.getNumber(20)
	thtl2= input.getNumber(25)
	temp1 = input.getNumber(21)
	temp2 = input.getNumber(26)
	rpm1 = input.getNumber(22)
	rpm2 = input.getNumber(27)
	torq1 = input.getNumber(23)
	torq2 = input.getNumber(28)
	flow1 = input.getNumber(24)
	flow2 = input.getNumber(29)
	
	gpsx = input.getNumber(1)
	gpsy = input.getNumber(2)
	mapx = input.getNumber(4)
	mapy = input.getNumber(5)
	zoom = input.getNumber(6)
	

	
	if page==8 then
	if osb==1 then l=true else l=false end
	if osb==2 then r=true else r=false end
	if osb==3 then u=true else u=false end
	if osb==4 then d=true else d=false end
	if osb==5 then ctr=true else ctr=false end
	if osb==15 then plus=true else plus=false end
	if osb==14 then minus=true else minus=false end
	end

	output.setBool(1, r)
	output.setBool(2, l)
	output.setBool(3, u)
	output.setBool(4, d)
	output.setBool(5, ctr)
	output.setBool(6, minus)
	output.setBool(7, plus)



end
function onDraw()
if page==4 then
	screen.setColor(0,0,0)
	screen.drawRectF(0, 0, 70, 70)
	screen.setColor(0,255,0)

		screen.drawTextBox(18, 8, 30, 9, "thtl", 0, 0)
		screen.drawTextBox(18, 16, 30, 9, "temp", 0, 0)
		screen.drawTextBox(18, 24, 30, 9, "rpm", 0, 0)
		screen.drawTextBox(18, 32, 30, 9, "torq", 0, 0)
		screen.drawTextBox(18, 40, 30, 9, "flow", 0, 0)
		screen.drawTextBox(4, 8, 30, 9, (string.format("%0.0f", thtl1)), -1, 0)
		screen.drawTextBox(30, 8, 30, 9, (string.format("%0.0f", thtl2)), 1, 0)
		screen.drawTextBox(4, 16, 30, 9, (string.format("%0.0f", temp1)), -1, 0)
		screen.drawTextBox(30, 16, 30, 9, (string.format("%0.0f", temp2)), 1, 0)
		screen.drawTextBox(4, 24, 30, 9, (string.format("%0.0f", rpm1)), -1, 0)
		screen.drawTextBox(30, 24, 30, 9, (string.format("%0.0f", rpm2)), 1, 0)
		screen.drawTextBox(4, 32, 30, 9, (string.format("%0.0f", torq1)), -1, 0)
		screen.drawTextBox(30, 32, 30, 9, (string.format("%0.0f", torq2)), 1, 0)
		screen.drawTextBox(4, 40, 30, 9, (string.format("%0.0f", flow1)), -1, 0)
		screen.drawTextBox(30, 40, 30, 9, (string.format("%0.0f", flow2)), 1, 0)
		screen.drawText(25, 55, "mnu")
end
if page==8 then
	pixelX, pixelY = map.mapToScreen(mapx, mapy, zoom, 64, 64, gpsx, gpsy)
	screen.drawMap(mapx, mapy, zoom)
	screen.setMapColorOcean(1, 1, 1)
	screen.setMapColorShallows(20, 20, 20)
	screen.setMapColorLand(60, 50, 50)
	screen.setMapColorGrass(30, 50, 30)
	screen.setMapColorSand(50, 50, 0)
	screen.setMapColorSnow(100, 100, 100)
		screen.setColor(200,0,0)
	screen.drawCircleF(pixelX, pixelY, 1)
	



end


end