-- source: steam id 2213181424 / vehicle.xml block#56
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
-- Tick function that will be executed every logic tick
function onTick()
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)
	SCT = input.getBool(2)
	APT = input.getBool(3)
	AHT = input.getBool(4)

	

Cntrl = isPressed and isPointInRectangle(inputX, inputY, 0, 17, 31, 14)
AP = isPressed and isPointInRectangle(inputX, inputY, 0, 0, 15, 16)
AH = isPressed and isPointInRectangle(inputX, inputY, 16, 0, 15, 16)
	output.setBool(1, Cntrl)
	output.setBool(3, AP)
	output.setBool(2, AH)
end


function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end


function onDraw()
	w = screen.getWidth()				  
	h = screen.getHeight()					
	screen.setColor(0, 0, 0)			
	screen.drawClear()
	
	screen.setColor(25, 50, 100)
		 	screen.drawRect(0, 0, 15, 16)
			screen.drawTextBox(1, 1, 14, 15, "AP", 0, 0)
	if APT then
	screen.setColor(25, 50, 100)
			screen.drawRectF(1, 1, 15, 16)
	screen.setColor(150, 150, 150)
			screen.drawTextBox(1, 1, 14, 15, "AP", 0, 0)		
	end
				
	screen.setColor(25, 50, 100)		
			screen.drawRect(16, 0, 15, 16)
			screen.drawTextBox(18, 1, 14, 15, "AS", 0, 0)
	if AHT then
	screen.setColor(25, 50, 100)
			screen.drawRectF(17, 1, 15, 16)
	screen.setColor(150, 150, 150)
			screen.drawTextBox(18, 1, 14, 15, "AS", 0, 0)	
	end
	
	screen.setColor(100, 0, 0)
			screen.drawRect(0, 17, 31, 14)
			screen.drawTextBox(0, 18, 32, 13, " TAKE CNTRL", 0, 0)

	if SCT then
			screen.setColor(100, 0, 0)
			screen.drawRectF(1, 18, 31, 14)
	screen.setColor(150, 150, 150)	
			screen.drawTextBox(0, 18, 32, 13, " GIVE CNTRL", 0, 0)
	end
		
end