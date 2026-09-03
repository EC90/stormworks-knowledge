-- source: steam id 2891786782 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2891786782
grey = 50 
greyd = 20
cr = 0
cg = 200
cb = 0
trans = 100
ctrans = 255



-- Tick function that will be executed every logic tick
function onTick()
	X = input.getNumber(10)
	Y = input.getNumber(11)
	MAPX = input.getNumber(12)
	MAPY = input.getNumber(13)	
	
	
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)
	
	Zoom = input.getNumber(9)
	MPC = input.getBool(2)
	-- Check if the player is pressing the rectangle at (10, 10) with width and height of 20px
	isPressingRectangle = isPressed and isPointInRectangle(inputX, inputY, 1, 2, 5, 5)
	isPressingRectangle2 = isPressed and isPointInRectangle(inputX, inputY, 1, 8, 5, 5)
	isPressingRectangle3 = isPressed and isPointInRectangle(inputX, inputY, (W/2)-2, 1, 5, 5)
	isPressingRectangle4 = isPressed and isPointInRectangle(inputX, inputY, (W/2)-2, H-6, 5, 5)
	isPressingRectangle5 = isPressed and isPointInRectangle(inputX, inputY, 1, (H/2)-2, 5, 5)
	isPressingRectangle6 = isPressed and isPointInRectangle(inputX, inputY, W-6, (H/2)-2, 5, 5)
	isPressingRectangle7 = isPressed and isPointInRectangle(inputX, inputY, W-6, 2, 5, 5)
	-- Set the composite output, on/off channel 1
	output.setBool(1, isPressingRectangle)
	output.setBool(2, isPressingRectangle2)
	output.setBool(3, isPressingRectangle3) --UP
	output.setBool(4, isPressingRectangle4) --DOWN	
	output.setBool(5, isPressingRectangle5) --LEFT
	output.setBool(6, isPressingRectangle6) --RIGHT
	output.setBool(7, isPressingRectangle7) --RESET	
end

-- Returns true if the point (x, y) is inside the rectangle at (rectX, rectY) with width rectW and height rectH
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
	W = screen.getWidth()				
	H = screen.getHeight()	
	if MPC then
	screen.setMapColorOcean(5, 5, 5)
	screen.setMapColorShallows(10, 10, 10)
	screen.setMapColorLand(20, 20, 20)
	screen.setMapColorGrass(25, 25, 25)
	screen.setMapColorSand(30, 30, 30)
	screen.setMapColorSnow(50, 50, 50)
	else
	screen.setMapColorOcean(20, 70, 120)
	screen.setMapColorShallows(31, 168, 245)
	screen.setMapColorLand(80, 80, 80)
	screen.setMapColorGrass(0, 158, 29)
	screen.setMapColorSand(186, 162, 104)
	screen.setMapColorSnow(200, 200, 200)					
	end	
	screen.drawMap(MAPX, MAPY, Zoom)
	if isPressingRectangle then
	screen.setColor(greyd, greyd, greyd, 50)
	else
	screen.setColor(grey, grey, grey, trans)
	end
	screen.drawRectF(1, 2, 5, 5)
	if isPressingRectangle2 then
	screen.setColor(greyd, greyd, greyd, 50)
	else
	screen.setColor(grey, grey, grey, trans)
	end
	screen.drawRectF(1, 8, 5, 5)
	if isPressingRectangle3 then
	screen.setColor(greyd, greyd, greyd, 50)
	else
	screen.setColor(grey, grey, grey, trans)
	end
	screen.drawRectF((W/2)-2, 1, 6, 5) --TOP	
	if isPressingRectangle4 then
	screen.setColor(greyd, greyd, greyd, 50)
	else
	screen.setColor(grey, grey, grey, trans)
	end
	screen.drawRectF((W/2)-2, H-6, 5, 5) --BOTTOM
	if isPressingRectangle5 then
	screen.setColor(greyd, greyd, greyd, 50)
	else
	screen.setColor(grey, grey, grey, trans)
	end
	screen.drawRectF(1, (H/2)-2, 5, 5) --LEFT	
	if isPressingRectangle6 then
	screen.setColor(greyd, greyd, greyd, 50)
	else
	screen.setColor(grey, grey, grey, trans)
	end
	screen.drawRectF(W-6, (H/2)-2, 5, 5) --RIGHT
	if isPressingRectangle7 then
	screen.setColor(greyd, greyd, greyd, 50)
	else
	screen.setColor(grey, grey, grey, trans)
	end
	screen.drawRectF(W-6, 2, 5, 5) --RESET
	if MPC then
	screen.setColor(200, 200, 200)
	else
	screen.setColor(0, 200, 0)
	end
	screen.drawTextBox(2, 2, 5, 5, "+", 0, 0)
	screen.drawTextBox(2, 8, 5, 5, "-", 0, 0)
	screen.drawTextBox((W/2)-1, 1, 5, 5, "U", 0, 0)
	screen.drawTextBox((W/2)-1, H-6, 5, 5, "D", 0, 0)
	screen.drawTextBox(2, (H/2)-2, 5, 5, "<", 0, 0)
	screen.drawTextBox(W-5, (H/2)-2, 5, 5, ">", 0, 0)
	screen.drawTextBox(W-5, 2, 5, 5, "R", 0, 0)
	
end