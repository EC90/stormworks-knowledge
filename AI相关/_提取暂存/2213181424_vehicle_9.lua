-- source: steam id 2213181424 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
winchout = false
winchin = false
connect = false
safe = true
function onTick()
act = input.getBool(2)
if act then
	-- Read the touchscreen data from the script's composite input
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)
	
	winch1l = input.getNumber(5)
	
	if not lastPressed and isPressed and not safe and isPointInRectangle(inputX, inputY, 7, 0, 7, 15) then
        connect = not connect
    end
	
	
	if not lastPressed and not winchout and isPressed and isPointInRectangle(inputX, inputY, 16, 0, 15, 15) then
        winchin = not winchin
    end


	if not lastPressed and not winchin and isPressed and isPointInRectangle(inputX, inputY, 16, 16, 15, 15) then
        winchout = not winchout
    end

	if not lastPressed and isPressed and isPointInRectangle(inputX, inputY, 0, 0, 7, 15) then
        safe = not safe
    end

	if winch1l < 0.1 then 
	winchin = false 
	end
	if winch1l > 19.9 then 
	winchout = false 
	end
	
	lastPressed = isPressed
	
	output.setBool(1, winchin)
	output.setBool(2, winchout)
	output.setBool(3, connect)

end	
end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
if act then
	w = screen.getWidth()			
	h = screen.getHeight()					

screen.setColor(25,50,100)
screen.drawRect(0, 0, 15, 15)
screen.setColor(100,0,0)
if safe then  -- lock
screen.drawRectF(1, 1, 7, 14)
screen.setColor(0,0,0)
screen.drawRectF(2,8,5,3)
screen.drawRectF(2,6,1,2)
screen.drawRectF(6,6,1,2)
screen.drawRectF(3,5,3,1)
else	
screen.drawRectF(2,8,5,3)
screen.drawRectF(2,4,1,4)
screen.drawRectF(6,4,1,2)
screen.drawRectF(3,3,3,1)
end

screen.setColor(25,50,100)
if not safe then
screen.setColor(100,0,0)
screen.drawRectF(8, 1, 7, 14)
screen.drawRect(0, 0, 15, 15)
screen.setColor(0,0,0)
end

if connect then
screen.drawRectF(11,5,1,2)
screen.drawRectF(9,7,5,1)
screen.drawRectF(9,8,5,1)
screen.drawRectF(11,9,1,2)
else
screen.drawRectF(11,3,1,2)
screen.drawRectF(9,5,5,1)
screen.drawRectF(9,10,5,1)
screen.drawRectF(11,11,1,2)
end


screen.setColor(25, 50, 100)
screen.drawRect(0, 16, 15, 15) -- Winch lengths

if winch1l >19.5 then
screen.setColor(100,0,0)
else
screen.setColor(100,25,0)
end
screen.drawRectF(5, 20, 6,(winch1l/20)*11)

screen.setColor(25,50,100)
screen.drawLine(3, 19, 13, 19)
screen.drawLine(3, 30, 13, 30)

if winch1l > 0.1 then 
	screen.drawTriangleF(24, 4, 20, 13, 29, 14) 
	end

if winchin then --Up arrow
screen.setColor(0,100,0)
screen.drawRectF(17, 0, 15, 16)
screen.setColor(0,0,0)
screen.drawTriangleF(24, 4, 20, 13, 29, 14) 
end
screen.drawRect(16, 0, 15, 15)

screen.setColor(25,50,100)

if winch1l < 19.9 then 
	screen.drawTriangleF(24, 29, 19.5, 19, 29, 19)
	end
 
if winchout then -- Down Arrow
screen.setColor(150,100,0)
screen.drawRectF(17, 17, 15, 15)
screen.setColor(0,0,0)
screen.drawTriangleF(24, 29, 19.5, 19, 29, 19)
end
screen.drawRect(16, 16, 15, 15)

end
end