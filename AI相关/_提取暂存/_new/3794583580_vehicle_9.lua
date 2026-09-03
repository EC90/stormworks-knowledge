-- source: steam id 3794583580 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794583580

desiredTemp = 0
function onTick()

	screenSizes = {{w=32,h=32},{w=64,h=64},{w=160,h=96},{w=288,h=160}}
	screenSize = screenSizes[property.getNumber("Monitor Size")]
	buttonsOffset = {x=math.floor(screenSize.w * 0.4)+5,y=math.floor(screenSize.h*0.5)}

	inTemp = input.getNumber(8)
	isPressed = input.getBool(1)
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	TempUp = isPressed and isPointInRectangle(inputX,inputY,buttonsOffset.x,buttonsOffset.y-7,10,7)
	TempDown = isPressed and isPointInRectangle(inputX,inputY,buttonsOffset.x,buttonsOffset.y+2,10,7)
	output.setBool(5,TempUp)
	output.setBool(6,TempDown)
	desiredTemp = math.floor(input.getNumber(7))
	offset = input.getNumber(9)
	if(inTemp<desiredTemp+offset)then
		output.setBool(9,true)
	else
		output.setBool(9,false)
	end
end
	
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
	
function scaleX(x)
	return screen.getWidth() * (x/100)
end

function scaleY(y)
	return screen.getHeight() * (y/100)
end

function drawTextAligned(x,y,text,alignX,alignY)
	local strWidth = string.len(text)*5
	screen.drawTextBox(x-(strWidth/2), y-2.5, strWidth, 5, text, alignX, alignY)
end

function drawTextC(x,y,text)
drawTextAligned(x,y,text,0,0)
end

function onDraw()
	if(inTemp >= desiredTemp)then
		screen.setColor(34,177,36,255)
	else
		screen.setColor(237,28,26)
	end
	drawTextC(scaleX(30)-2,scaleY(40),math.floor(inTemp))
	screen.setColor(127,127,127, 127)
	drawTextC(scaleX(40)-2,scaleY(40)+7,desiredTemp)


	buttonsOffset = {x = math.floor(scaleX(40)+5),y=math.floor(scaleY(50))}
	screen.setColor(197,197,197)
	-- up
	screen.drawTriangle(buttonsOffset.x,buttonsOffset.y-2,buttonsOffset.x+5,buttonsOffset.y-7, buttonsOffset.x+10, buttonsOffset.y-2)
	-- down
	screen.drawTriangle(buttonsOffset.x,buttonsOffset.y+2,buttonsOffset.x+5,buttonsOffset.y+7, buttonsOffset.x+10, buttonsOffset.y+2)
	if(TempUp)then
		screen.setColor(34,177,36,255)
		screen.drawTriangleF(buttonsOffset.x+2,buttonsOffset.y-2,buttonsOffset.x+5,buttonsOffset.y-6, buttonsOffset.x+9,buttonsOffset.y-2)
	end
	if(TempDown)then
		screen.setColor(237,28,26)
		screen.drawTriangleF(buttonsOffset.x+1,buttonsOffset.y+3,buttonsOffset.x+5,buttonsOffset.y+8, buttonsOffset.x+10, buttonsOffset.y+3)
	end
end