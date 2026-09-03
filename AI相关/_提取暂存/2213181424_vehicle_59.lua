-- source: steam id 2213181424 / vehicle.xml block#59
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
state = 0
function onTick()

	-- Read the touchscreen data from the script's composite input
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)

	
	isPressingRectangle = isPressed and isPointInRectangle(inputX, inputY, 10, 10, 20, 20)


	output.setNumber(1, state)
	
	
	if isPressed and isPointInRectangle(inputX, inputY, 4,0,17,8) then
	state = 0
	end
	
	if isPressed and isPointInRectangle(inputX, inputY, 10,8,22,8) then
	state = 0.5
	end
	
	if isPressed and isPointInRectangle(inputX, inputY, 0,24,31,8) then
	state = 1
	end
	
end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end		



function onDraw()
	w = screen.getWidth()				  
	h = screen.getHeight()					
	screen.setColor(50, 50, 50)			
	screen.drawCircleF(0.5, 15, 6)
	
	
if state == 0 then
screen.drawRectF(5,0,16,7)
screen.setColor(0, 0, 0)
end
screen.drawText(6,1,"OFF")

screen.setColor(50, 50, 50)
if state == 0.5 then
screen.drawRectF(11,8,21,7)
screen.setColor(0, 0, 0)
end
screen.drawText(12,9,"IDLE")


screen.setColor(50, 50, 50)
if state == 1 then
screen.drawRectF(1,24,30,7)
screen.setColor(0, 0, 0)
end
screen.drawText(2,25,"FLIGHT")

screen.setColor(20, 20, 20)

if state == 0 then
screen.drawLine(1, 14, 1+4, 14-7)
screen.drawLine(2, 15, 2+4, 15-7)
screen.drawLine(1, 16, 1+4, 16-7)
screen.drawLine(0, 15, 0+4, 15-7)
screen.drawLine(1, 15, 1+4, 14-7)
end

if state == 0.5 then
screen.drawLine(1, 14, 1+6, 14-3)
screen.drawLine(2, 15, 2+6, 15-3)
screen.drawLine(1, 16, 1+6, 16-3)
screen.drawLine(0, 15, 0+6, 15-3)
screen.drawLine(1, 15, 1+6, 14-3)
end

if state == 1 then
screen.drawLine(1, 14, 1+4, 14+7)
screen.drawLine(2, 15, 2+4, 15+7)
screen.drawLine(1, 16, 1+4, 16+7)
screen.drawLine(0, 15, 0+4, 15+7)
screen.drawLine(1, 15, 1+4, 14+7)
end

end