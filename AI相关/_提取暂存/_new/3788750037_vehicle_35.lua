-- source: steam id 3788750037 / vehicle.xml block#35
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
grey = 2 
greyd = 0
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
	L=input.getNumber(17)
	E=input.getNumber(18)
	
	
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)
	
	Zoom = input.getNumber(9)
	MPC = input.getBool(2)
	-- Check if the player is pressing the rectangle at (10, 10) with width and height of 20px
	isPressingRectangle = isPressed and isPointInRectangle(inputX, inputY, 1, 26, 5, 5)
	isPressingRectangle2 = isPressed and isPointInRectangle(inputX, inputY, 1, 31, 5, 5)
	isPressingRectangle3 = isPressed and isPointInRectangle(inputX, inputY, 6, 22, 5, 5)
	isPressingRectangle4 = isPressed and isPointInRectangle(inputX, inputY, 12, 22, 5, 5)
	isPressingRectangle5 = isPressed and isPointInRectangle(inputX, inputY, 18, 22, 5, 5)
	isPressingRectangle6 = isPressed and isPointInRectangle(inputX, inputY, 24, 22, 5, 5)
	isPressingRectangle7 = isPressed and isPointInRectangle(inputX, inputY, 1, 37, 5, 5)
	isPressingRectangle8 = isPressed and isPointInRectangle(inputX, inputY, 1, 45, 5, 5)
	-- Set the composite output, on/off channel 1
	output.setBool(1, isPressingRectangle)
	output.setBool(2, isPressingRectangle2)
	output.setBool(3, isPressingRectangle3) --UP
	output.setBool(4, isPressingRectangle4) --DOWN	
	output.setBool(5, isPressingRectangle5) --LEFT
	output.setBool(6, isPressingRectangle6) --RIGHT
	output.setBool(7, isPressingRectangle7) --RESET
	output.setBool(8, isPressingRectangle8) --CLEAR
end

-- Returns true if the point (x, y) is inside the rectangle at (rectX, rectY) with width rectW and height rectH
function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
	W = screen.getWidth()				
	H = screen.getHeight()	
screen.setMapColorOcean(204-L*E, 204-L*E, 198-L*E, 255)
screen.setMapColorShallows(109-L*E, 105-L*E, 158-L*E, 255)
screen.setMapColorLand(185-L*E, 183-L*E, 48-L*E, 255)
screen.setMapColorGrass(185-L*E, 183-L*E, 48-L*E, 255)
screen.setMapColorSand(185-L*E, 183-L*E, 48-L*E, 255)
screen.setMapColorSnow(185-L*E, 183-L*E, 48-L*E, 255)				
screen.drawMap(MAPX, MAPY, Zoom)
	
end