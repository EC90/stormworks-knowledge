-- source: steam id 2213181424 / vehicle.xml block#8
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
state = -0.286
function onTick()
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)
	crash = input.getBool(5)

	close = isPressed and isPointInRectangle(inputX, inputY, 1, 0, 63, 9)
	level = isPressed and isPointInRectangle(inputX, inputY, 1, 11, 63, 9)
	open = isPressed and isPointInRectangle(inputX, inputY, 1, 23, 63, 9)
	
if open or crash then
state = 0.24
elseif close and not crash then
state = -0.286
elseif level and not crash then
state = 0
end



output.setNumber(1,state)

end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()


screen.setColor(25, 50, 100)
screen.drawTextBox(1, 2, 31, 7, "Close", h_align, v_align)
if state == -0.286 then
screen.drawRectF(0, 1, 31, 11)
screen.setColor(0, 0, 0)
screen.drawTextBox(1, 2, 31, 7, "Close", h_align, v_align)
end
screen.drawRect(0, 0, 32, 10)

screen.setColor(25, 50, 100)
screen.drawTextBox(1, 13, 31, 7, "Level", h_align, v_align)
if state == 0 then
screen.setColor(150, 112, 0)
screen.drawRectF(0, 12, 31, 11)
screen.setColor(0, 0, 0)
screen.drawTextBox(1, 13, 31, 7, "Level", h_align, v_align)
end
screen.drawRect(0, 11, 32, 10)

screen.setColor(25, 50, 100)
screen.drawTextBox(1, 24, 31, 7, "Open", h_align, v_align)
if state == 0.24 then
screen.setColor(100, 0, 0)
screen.drawRectF(0, 23, 31, 11)
screen.setColor(0, 0, 0)
screen.drawTextBox(1, 24, 31, 7, "Open", h_align, v_align)
end
screen.drawRect(0, 22, 32, 9)

end