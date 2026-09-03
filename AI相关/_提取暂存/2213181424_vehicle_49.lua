-- source: steam id 2213181424 / vehicle.xml block#49
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
function onTick()
act=input.getBool(32)
if act then
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)
	
	w1u = input.getBool(5)
	w1d = input.getBool(6)
	w2u = input.getBool(7)
	w2d = input.getBool(8)
	switch = input.getBool(9)
	l1 = input.getNumber(5)
	l2 = input.getNumber(6)
	cargo = input.getNumber(7)

end
end

-- Returns true if the point (x, y) is inside the rectangle at (rectX, rectY) with width rectW and height rectH
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH	
	
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
if act then
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()
	
screen.setColor(25,50,100)		
screen.drawRectF(16,61,32,3) --rtn

screen.setColor(0,0,0)

 -- Cntrls

screen.setColor(25,50,100)
screen.drawTextBox(4, 1, 7, 7, "1", 0, 0)
screen.drawTextBox(10, 1, 7, 7, "2", 0, 0)
if switch then
screen.drawRectF(10,0,6,8)
screen.setColor(0,0,0)
screen.drawTextBox(10, 1, 7, 7, "2", 0, 0)
else
screen.drawRectF(4,0,6,8)
screen.setColor(0,0,0)
screen.drawTextBox(4, 1, 7, 7, "1", 0, 0)
end

screen.setColor(25,50,100)
screen.drawTriangleF(16.5, 7,19, 2,22, 7)
screen.drawTriangleF(22.5, 2,26, 8,29.5, 2)
if (switch and w2u) or (not switch and w1u) then
screen.setColor(0,100,0)
screen.drawRectF(16,0,7,8)
screen.setColor(0,0,0)
screen.drawTriangleF(16.5, 7,19, 2,22, 7)
elseif (switch and w2d) or (not switch and w1d) then
screen.setColor(150,100,0)
screen.drawRectF(23,0,7,8)
screen.setColor(0,0,0)
screen.drawTriangleF(22.5, 2,26, 8,29.5, 2)
end



-- lengths

if l1 >19.5 then
screen.setColor(100,0,0)
else
screen.setColor(100,25,0)
end
screen.drawRectF(3, 20, 2,(l1/20)*32)

if l2 >19.5 then
screen.setColor(100,0,0)
else
screen.setColor(100,25,0)
end
screen.drawRectF(9, 20, 2,(l2/20)*32)

if cargo >19.5 then
screen.setColor(100,0,0)
else
screen.setColor(100,25,0)
end
screen.drawRectF(15, 20, 2,(cargo/20)*32)

screen.setColor(25,50,100)

screen.drawTextBox(1, 12, 7, 7, "1", 0, 0)
screen.drawTextBox(7, 12, 7, 7, "2", 0, 0)
screen.drawTextBox(13, 12, 7, 7, "C", 0, 0)
screen.drawLine(1,19,19,19)
screen.drawLine(1,51,19,51)

end
end