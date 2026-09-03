-- source: steam id 2891786782 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2891786782
function onTick()
	tiltX = input.getNumber(1)
	tiltY = input.getNumber(2)
	speed = input.getNumber(3)

end


function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	wm = w/2
	hm = h/2
	
	tiltXText = tiltX*400
	tiltXText = math.floor(tiltXText+0.5)
	
	tiltYText = tiltY*400
	tiltYText = math.floor(tiltYText+0.5)
	
	tiltX = tiltX * 550	--gibt die geschwindigkeit an mit der die linien hoch und runter beweget werden
	tiltX = math.floor(tiltX+0.5)  		 --round value
	
	tiltY = (tiltY  * math.pi/2)/0.25		--rechnet tiltY in radialwinkel um

	
	lineRate = -math.sin(math.abs(tiltY)) * 5 + 10  --gibt de abstand zwischen den linien an ... siehe line 27
	lineRate = math.floor(lineRate+0.5)
	
	screen.setColor(0, 255, 0, 50)
	
	for i=1,h do --durchleauft alle y koordinaten	
			if ((i-tiltX)%lineRate == 0) then --fragt wann line gezeichnet werden soll

				shiftY = math.tan(tiltY)*(i-hm) --gibt an wie viel die linien nach links oder recht bewegt werden sollen
				
				v1 = 5 * math.cos(tiltY) --siehe blatt
				if (tiltY>0) then
					v1 = v1 * (-1) --invertiere fuer neigung nach rechts
				end
				
				v2 = math.sqrt(25-v1^2) --siehe blatt
			
				x1 = ((wm)+shiftY) --ursprungspunkt der liene x
				x2 = i-2			--ursprungspunkt der liene y
				y1 = x1+v1 	--endpunkt der liene siehe blatt
				y2 = x2+v2	--endpunkt der liene siehe blatt
				
				screen.drawLine(x1, x2, y1, y2) --zeichne ein teil der linie
				y1 = x1-v1  --endpunkt auf der anderen seite des ursprungs
				y2 = x2-v2
				screen.drawLine(x1, x2, y1, y2)
			end	
	end
	
	screen.setColor(255, 0, 0)
	
	shiftY = math.tan(tiltY)*(tiltX+2)
	v1 = 10 * math.cos(tiltY)
	if (tiltY>0) then
		v1 = v1 * (-1)
	end
	v2 = math.sqrt(100-v1^2)
			
	x1 = (wm)+shiftY
	x2 = hm+tiltX
	y1 = x1+v1 
	y2 = x2+v2
	screen.drawLine(x1, x2, y1, y2)
	y1 = x1-v1 
	y2 = x2-v2
	screen.drawLine(x1, x2, y1, y2)
	
	--Draw plane
	screen.setColor(0, 255, 0)
	screen.drawLine(wm-5, hm+1, wm+6, hm+1)
	screen.drawLine(wm-5, hm, wm-20, hm)
	screen.drawLine(wm+5, hm, wm+10, hm)
	screen.drawRect(wm-1, hm-1, 2, 2)
	
	drawText()
	
	
end
	
function drawText()
		
		screen.setColor(0, 255, 0)
		if (tiltXText > -10 and tiltXText < 10) then
		if (tiltXText >= 0) then
		screen.drawText(w-11, hm-2, tiltXText)
		screen.drawRect(w-13, hm-4, 7, 8)
		else
		screen.drawText(w-16, hm-2, tiltXText)
		screen.drawRect(w-18, hm-4, 12, 8)
		end
	else	
		if (tiltXText >= 0) then
		screen.drawText(w-11, hm-2, tiltXText)
		screen.drawRect(w-13, hm-4, 12, 8)
		else
		screen.drawText(w-16, hm-2, tiltXText)
		screen.drawRect(w-18, hm-4, 17, 8)
		end
	end
	
	if (tiltYText < 0) then
		screen.drawTriangleF(wm-7, h-8, wm-7, h, wm-15, h-4)
	end
	if (tiltYText > 0) then
		screen.drawTriangleF(wm+8, h-8, wm+8, h, wm+16, h-4)
	end
	
	tiltYText = math.abs(tiltYText)
	if (tiltYText < 10) then
		screen.drawText(wm-1, h-7, tiltYText)
		screen.drawRect(wm-3, h-9, 7, 8)
	else	
		screen.drawText(wm-4, h-7, tiltYText)
		screen.drawRect(wm-6, h-9, 12, 8)
	end
	
	
	speed = math.floor(speed+0.5)
	
	if (speed < 10 and speed >= 0)then
		screen.drawText(wm-25, hm-2, speed)
		screen.drawRect(wm-27, hm-3, 7, 6)
	elseif ((speed < 100 and speed >=10) or (speed<0 and speed > -10)) then
		screen.drawText(wm-30, hm-2, speed)
		screen.drawRect(wm-32, hm-3, 12, 6)
	elseif ((speed < 1000 and speed >=100) or (speed<= -10 and speed > -100)) then
		screen.drawText(wm-35, hm-2, speed)
		screen.drawRect(wm-37, hm-3, 17, 6)
	elseif (speed >= 1000  or (speed<= -100 and speed > -1000)) then
		screen.drawText(wm-40, hm-2, speed)
		screen.drawRect(wm-42, hm-3, 22, 6)
		
	end
	
end