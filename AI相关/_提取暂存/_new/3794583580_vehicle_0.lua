-- source: steam id 3794583580 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794583580
-- Tick function that will be executed every logic tick
function onTick()
	scan= input.getBool(2)
	lock= input.getBool(3)
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)
	mute= input.getBool(4)
    auto= input.getBool(5)

	isPressingMute = isPressed and isPointInRectangle(inputX, inputY, 0, w/2, w, h/4)
	
	isPressingAuto = isPressed and isPointInRectangle(inputX, inputY, 0, w/4*3, w, h/4)
	
	-- Set the composite output, on/off channel 1
	output.setBool(1, isPressingMute)
	output.setBool(2, isPressingAuto)
end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end


-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(1, 1, 1)			
	screen.drawLine(0, h / 4, w, h/4)
	screen.drawLine(0, h/2, w, h/2)
	screen.drawLine(0, h/4*3,w, h/4*3)
	
if lock==true then
	screen.setColor(100, 0, 0)
	screen.drawRectF(0, 0, w, h/4)
	screen.setColor(255, 255, 255)
	screen.drawTextBox(w/5, 2, w, h/4, "lock")
else
    screen.setColor(10, 0, 0)
    screen.drawRectF(0, 0, w, h/4)
    screen.setColor(10, 10, 10)
    screen.drawTextBox(w/5, 2, w, h/4, "lock")
end

if scan==true then
    screen.setColor(0, 100, 0)
    screen.drawRectF(0, h/4+1, w, h/4-1)
	screen.setColor(255, 255, 255)
	screen.drawTextBox(w/5, h/4+2, w, h/4, "scan")
else
    screen.setColor(0, 10, 0)
    screen.drawRectF(0, h/4+1, w, h/4-1)
    screen.setColor(10, 10, 10)
    screen.drawTextBox(w/5, h/4+2, w, h/4, "scan")
end

if mute==true then
    screen.setColor(0, 50, 0)
    screen.drawRectF(0, h/2+1, w, h/4-1)
	screen.setColor(0, 5, 0)
	screen.drawTextBox(w/5, h/2+2, w, h/4, "mute")
else
    screen.setColor(0, 5, 0)
    screen.drawRectF(0, h/2+1, w, h/4-1)
    screen.setColor(0, 50, 0)
    screen.drawTextBox(w/5, h/2+2, w, h/4, "mute")
end

if auto==true then
    screen.setColor(0, 50, 0)
    screen.drawRectF(0, h/4*3+1, w, h/4-1)
	screen.setColor(0, 5, 0)
	screen.drawTextBox(2, h/4*3+2, w, h/4, "manual")
else
    screen.setColor(0, 5, 0)
    screen.drawRectF(0, h/4*3+1, w, h/4-1)
    screen.setColor(0, 50, 0)
    screen.drawTextBox(w/5, h/4*3+2, w, h/4, "auto")
end
	 
end
	