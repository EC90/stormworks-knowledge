-- source: steam id 3788743617 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788743617
-- Tick function that will be executed every logic tick
function onTick()
	isPressed = input.getBool(1)
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	zoom_out = isPressed and isPointInRectangle(inputX, inputY, 0,25,6,6)
	zoom_in = isPressed and isPointInRectangle(inputX, inputY, 25,25,6,6)	
	output.setBool(2, zoom_out)
	output.setBool(3, zoom_in)
end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

S=screen
SC=S.setColor
DR=S.drawRect
DRF=S.drawRectF
DL=S.drawLine

function onDraw()		
	w = screen.getWidth()				  
	h = screen.getHeight()					
	screen.setColor(5, 5, 5)	
	
SC(2, 2, 2)
if zoom_out then
SC(5, 5, 5)
else
SC(0, 0, 0)
end
DRF(1,26.5,5,5)

SC(2, 2, 2)
if zoom_in then
SC(5, 5, 5)
else
SC(0, 0, 0)
end
DRF(26,26.5,5,5)

SC(100,100,100)
DL(2,28,4.25,28.25)
DL(27,28,29.25,28.25)
DL(28,27,28.25,27.25)
DL(28,29,28.25,29.25)
SC(5, 5, 5)
DR(0,25,6,6)
DR(25,25,6,6)

end