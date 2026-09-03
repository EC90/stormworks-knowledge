-- source: steam id 2232448349 / vehicle.xml block#27
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2232448349
function round(I, B)
	local M = 10^(B or 0)
		return math.abs(math.floor(I*M+0.5)/M)
end	
function hex2rgb(hex)
    hex = hex:gsub("#","")
    	return {r=tonumber("0x"..hex:sub(1,2)), g=tonumber("0x"..hex:sub(3,4)), b=tonumber("0x"..hex:sub(5,6))}
end
function onTick()
	Input=round(input.getNumber(1),2)
	Pos=property.getNumber("Number Position")
	yes=property.getNumber("Dial Color Fill")
	min=property.getNumber("Min")
	max=property.getNumber("Max")
	PosX=property.getNumber("X Position")
	PosY=property.getNumber("Y Position")
	t=property.getNumber("Dial Color Transparency (0-255)")
	bt=property.getNumber("Dial Background Transparency (0-255)")
	if min > max then
	min = max
	end
	V=((Input-min)/(max-min))*100
	if V > 100 then
	V = 100
	elseif V < 0 then
	V = 0
	end
	Unit = property.getText("Unit Symbol")
	BGC = hex2rgb(property.getText("Background Color (Hex)"))
	LC = hex2rgb(property.getText("Frame Color (Hex)"))
	DC = hex2rgb(property.getText("Dial Solid Color (Hex)"))
	TC = hex2rgb(property.getText("Number Color (Hex)"))
	UC = hex2rgb(property.getText("Unit Text Color (Hex)"))
	PC = hex2rgb(property.getText("Dial Pointer Color (Hex)"))
end
function onDraw()
	if Pos == 0 then
		screen.setColor(BGC["r"],BGC["g"],BGC["b"],bt)
		screen.drawCircleF(PosX,PosY,8)
		for i = 1,50 do
			ang1=-(V*0.00094)*i
			t1x=((math.cos(ang1))*(11-19)-(math.sin(ang1))*(12-12)+PosX)
			t1y=((math.sin(ang1))*(11-19)-(math.cos(ang1))*(12-12)+PosY)
			if yes == 1 then
				screen.setColor(math.sin((V/80)^2)*200,math.sin(1.59-V/63)*255,0,t)
			elseif yes == 2 then
				screen.setColor(math.sin(1.59-V/63)*200,math.sin((V/80)^2)*255,0,t)
			else
				screen.setColor(DC["r"],DC["g"],DC["b"],t)
			end
			if i == 50 then
				screen.setColor(PC["r"],PC["g"],PC["b"])
			end
			screen.drawLine(PosX,PosY,t1x,t1y)
		end
		screen.setColor(LC["r"],LC["g"],LC["b"])
		screen.drawCircle(PosX,PosY,8)
		screen.setColor(BGC["r"],BGC["g"],BGC["b"])
			screen.drawRectF(PosX-19,PosY-8,19,9)
		screen.setColor(LC["r"],LC["g"],LC["b"])
			screen.drawRect(PosX-19,PosY-8,19,8)
		screen.setColor(TC["r"],TC["g"],TC["b"])
			if Input < 10 then
			screen.drawTextBox(PosX-19,PosY-8,20,9,string.format("%.1f",Input),0,0)
			else
			screen.drawTextBox(PosX-19,PosY-8,20,9,string.format("%.0f",Input),0,0)
			end
			screen.setColor(UC["r"],UC["g"],UC["b"])
			screen.drawText((PosX-14)-#Unit*2,PosY+4,Unit)
	else
			screen.setColor(BGC["r"],BGC["g"],BGC["b"],bt)
			screen.drawCircleF(PosX,PosY,8)
		for i = 1,50 do
			ang2=(V*0.00094)*i
			t2x=((math.cos(ang2))*(50-42)-(math.sin(ang2))*(12-12)+PosX)
			t2y=((math.sin(ang2))*(50-42)-(math.cos(ang2))*(12-12)+PosY)
			if yes == 1 then
				screen.setColor(math.sin((V/80)^2)*200,math.sin(1.59-V/63)*255,0,t)
			elseif yes == 2 then
				screen.setColor(math.sin(1.59-V/63)*200,math.sin((V/80)^2)*255,0,t)
			else
				screen.setColor(DC["r"],DC["g"],DC["b"],t)
			end
			if i == 50 then
				screen.setColor(PC["r"],PC["g"],PC["b"])
			end
				screen.drawLine(PosX,PosY,t2x,t2y)
		end
		screen.setColor(LC["r"],LC["g"],LC["b"])
		screen.drawCircle(PosX,PosY,8)
		screen.setColor(BGC["r"],BGC["g"],BGC["b"])
			screen.drawRectF(PosX,PosY-8,19,9)
		screen.setColor(LC["r"],LC["g"],LC["b"])
			screen.drawRect(PosX,PosY-8,19,8)
		screen.setColor(TC["r"],TC["g"],TC["b"])
			if Input < 10 then
			screen.drawTextBox(PosX,PosY-8,20,9,string.format("%.1f",Input),0,0)
			else
			screen.drawTextBox(PosX,PosY-8,20,9,string.format("%.0f",Input),0,0)
			end
			screen.setColor(UC["r"],UC["g"],UC["b"])
			screen.drawText(14+PosX-#Unit*2,PosY+4,Unit)
	end
end