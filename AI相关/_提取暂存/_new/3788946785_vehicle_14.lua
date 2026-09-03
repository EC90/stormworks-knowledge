-- source: steam id 3788946785 / vehicle.xml block#14
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788946785

function onTick()
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	current = input.getNumber(10)
	isPressed = input.getBool(1)
	SC=screen.setColor
	
	
	isPressingRectangleR = isPressed and isPointInRectangle(inputX, inputY, 55,58.5,7,5)
	
	
	output.setBool(2,isPressingRectangleR)
end


function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()

	
	if isPressingRectangleR then
		SC(30,30,30)
		screen.drawRectF(55,58.5,7,5)
	else
		SC(100,100,100)
		screen.drawRectF(55,58.5,7,5)
	end
	
	if current == 1 then 
		SC(100,100,100)
		screen.drawText(2,58,"1" )
	elseif current == 2 then
		SC(100,100,100)
		screen.drawText(2,58,"2" )
	end
end