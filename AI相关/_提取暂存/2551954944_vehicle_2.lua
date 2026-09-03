-- source: steam id 2551954944 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2551954944

page = 0

function onTick()
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressedPulse = input.getBool(3) -- Pulse version of touch input
	isPressedHold = input.getBool(1) -- default touch input
	
	nextPage = input.getBool(4)
	previousPage = input.getBool(5)
	nextPageHold = input.getBool(6)
	previousPageHold = input.getBool(7)

	isPressingTriangle1Hold = isPressedHold and isPointInTriangle1()
	isPressingTriangle2Hold = isPressedHold and isPointInTriangle2() 
	
	isPressingTriangle1 = isPressedPulse and isPointInTriangle1() -- (externally pulsed)
	isPressingTriangle2 = isPressedPulse and isPointInTriangle2() -- (externally pulsed)
	
	numberOfPages = property.getNumber("numberOfPages")
	transparency = property.getNumber("transparency")
	
	enableButtons = property.getBool("enableButtons")
	enableLine = property.getBool("enableLine")
	enableRectangle = property.getBool("enableRectangle")
	
	if (enableButtons and isPressingTriangle1) or nextPage then b = 1 elseif 
		not1(isPressingTriangle1, isPressingTriangle2, nextPage, previousPage) then 
		b = 0 
	end 
	
	-- Decides if counter should go up or down -- and if no inputs are active then b = 0
	
	if (enableButtons and isPressingTriangle2) or previousPage then b = -1 elseif
		not1(isPressingTriangle1, isPressingTriangle2, nextPage, previousPage) then 
		b = 0 
	end
	
	page = page + b -- Page counter
	if page > numberOfPages - 1 then page = 0 end -- Loops counter to page 0 if its higher than page number of pages
	if page < 0 then page = numberOfPages - 1 end -- Loops counter to page number of pages if its lower than page 0
	
	if page == 0 then text = property.getText("page1text") end -- Page titles
	if page == 1 then text = property.getText("page2text") end
	if page == 2 then text = property.getText("page3text") end
	if page == 3 then text = property.getText("page4text") end
	if page == 4 then text = property.getText("page5text") end
	if page == 5 then text = property.getText("page6text") end
	if page == 6 then text = property.getText("page7text") end

	output.setNumber(3, page) -- Goes to thresholds
end

function isPointInTriangle1()
	return ((inputX == 58 or inputX == 59) and (inputY <= 63 and inputY >= 59)) or -- Checks if inputX and inputY are within triangle
	
		((inputX == 60 or inputX == 61) and (inputY <= 62 and inputY >= 60)) or
	
		(inputX == 62 and inputY == 61)
end

function isPointInTriangle2()
	return ((inputX == 56 or inputX == 55) and (inputY <= 63 and inputY >= 59)) or -- Checks if inputX and inputY are within triangle
	
		((inputX == 54 or inputX == 53) and (inputY <= 62 and inputY >= 60)) or
	
		(inputX == 52 and inputY == 61)
end

function not1(x,y,z,w)
    return not (x or y or z or w)
end

function onDraw()
	screen.setColor((property.getNumber("rectangleR")), (property.getNumber("rectangleG")), (property.getNumber("rectangleB")), transparency)
	
	if enableRectangle then
		screen.drawRectF(0, 57, 64, 7) -- Draws rectangle at bottom of display
	end
	
	screen.setColor((property.getNumber("lineR")), (property.getNumber("lineG")), (property.getNumber("lineB")), transparency)
	
	if enableLine then
		screen.drawLine(0,56, 64, 56) -- Draws line at bottom of display
	end
	
	screen.setColor((property.getNumber("textR")), (property.getNumber("textG")), (property.getNumber("textB")), transparency)
	
	if enableButtons then
		screen.drawTriangle(61.5, 60, 57, 58, 57, 62) -- Triangle 1
		screen.drawTriangle(55, 62, 55, 58, 50.5, 60) -- Triangle 2
	end

	if enableButtons and (isPressingTriangle1Hold or nextPageHold) then
		screen.drawTriangleF(61.5, 61, 57, 59, 57, 63) -- Next page
	end

	if enableButtons and (isPressingTriangle2Hold or previousPageHold) then
		screen.drawTriangleF(55, 63, 55, 59, 50.5, 61) -- Previous page
	end

	screen.drawTextBox(5, 58, 59, 5, text, -1, -1) -- Draws page titles
end