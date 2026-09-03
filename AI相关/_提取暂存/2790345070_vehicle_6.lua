-- source: steam id 2790345070 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2790345070
function onTick()
	turnOnHUD = input.getBool(1)
	xSpeed = input.getNumber(2)
	ySpeed = input.getNumber(3)
	collective = input.getNumber(4)
	cushionPressure = input.getNumber(5)
	H = (((1-input.getNumber(6))%1)*360)
	fTilt = input.getNumber(7)*1000
	sTilt = input.getNumber(8)*4*3.14
	
	T = property.getNumber("Bars Transparency")
	OF = property.getNumber("Height Offset")
	FLP = property.getBool("Flip Vertically")
	Show = property.getBool("Show Heading")
end

function onDraw()
	if turnOnHUD == true then
		w = screen.getWidth()
		h = screen.getHeight()
		x = w/2
		y = h/2
		
		screen.setColor(50, 255, 50)
		
		screen.drawCircle(x+xSpeed, y+ySpeed, 3)
		screen.drawLine((x-3)+xSpeed, y+ySpeed, (x-7)+xSpeed, y+ySpeed)
		screen.drawLine((x+3)+xSpeed, y+ySpeed, (x+7)+xSpeed, y+ySpeed)
		screen.drawLine(x+xSpeed, (y-3)+ySpeed, x+xSpeed, (y-7)+ySpeed)
		
		screen.drawLine(0, 80, w, 80)
		
		screen.drawText(28, 83, "Collect")
		screen.drawText(61, 83, "i")
		screen.drawText(64, 83, "v")
		screen.drawText(68, 83, "e")
		
		screen.drawTextBox(69, 83, 20, 5, string.format("%.0f", collective), 1, 0)
		screen.drawText(90, 83, "%")
		
		screen.drawText(18, 91, "A")
		screen.drawText(22, 91, "i")
		screen.drawText(25, 91, "r")
		screen.drawText(33, 91, "Pressure")
		screen.drawTextBox(69, 91, 20, 5, string.format("%.0f", cushionPressure), 1, 0)
		screen.drawText(90, 91, "%")
		
		--Artificial Horizon
		x1rh = x+15 * math.cos(sTilt)
		y1rh = y+15 * math.sin(sTilt)
		x2rh = x+40 * math.cos(sTilt)
		y2rh = x+40 * math.sin(sTilt)
		screen.drawLine(x1rh, y1rh+fTilt, x2rh, y2rh+fTilt)
		
		x1rv = x+40 * math.cos(sTilt)
		y1rv = y+40 * math.sin(sTilt)
		x2rv = x+40 * math.cos(sTilt-0.1)
		y2rv = x+40 * math.sin(sTilt-0.1)
		screen.drawLine(x1rv, y1rv+fTilt, x2rv, y2rv+fTilt)
		
		x1lh = x-15 * math.cos(sTilt)
		y1lh = y-15 * math.sin(sTilt)
		x2lh = x-40 * math.cos(sTilt)
		y2lh = x-40 * math.sin(sTilt)
		screen.drawLine(x1lh, y1lh+fTilt, x2lh, y2lh+fTilt)
		
		x1lv = x-40 * math.cos(sTilt)
		y1lv = y-40 * math.sin(sTilt)
		x2lv = x-40 * math.cos(sTilt+0.1)
		y2lv = x-40 * math.sin(sTilt+0.1)
		screen.drawLine(x1lv, y1lv+fTilt, x2lv, y2lv+fTilt)
		
		--Compass Heading
		sp=H-math.floor(H/5)*5
		l=math.ceil((w/2-sp)/5)
		x=w/2-sp-l*5
		v=math.floor(H-w/2+x)%360
	
		if FLP == true then
			PL = -6
			P1 = 1
			P2 = 0
		else
			PL = 3
			P1 = 0
			P2 = 1
		end
	
		while (x<w) do
			if (v/15==math.floor(v/15)) then
			screen.drawLine(x, OF+13, x, 2+OF+13)
				if v==0 then 
					screen.drawText(x-1,PL+OF+13,"N")
				elseif v==45 then
					screen.drawText(x-4,PL+OF+13,"NE")
				elseif v==90 then
					screen.drawText(x-1,PL+OF+13,"E")
				elseif v==135 then
					screen.drawText(x-4,PL+OF+13,"SE")
				elseif v==180 then
					screen.drawText(x-1,PL+OF+13,"S")
				elseif v==225 then
					screen.drawText(x-4,PL+OF+13,"SW")
				elseif v==270 then
					screen.drawText(x-1,PL+OF+13,"W") 
				elseif v==315 then
					screen.drawText(x-4,PL+OF+13,"NW") 
				end
			else
				screen.drawLine(x, P1+OF+13, x, P2+OF+13)
			end
			x=x+5 v=(v+5)%360
		end
		if Show == true then
		screen.drawRect(39, OF+1, 17, 8)
		screen.drawText((w-#(string.format("%.0f", H))*5)/2+1, PL+OF, string.format("%.0f", H))
		end
	end
end