-- source: steam id 3788743617 / vehicle.xml block#9
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788743617
-- Tick function that will be executed every logic tick
function onTick()
	isPressed = input.getBool(1)
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	next_page = isPressed and isPointInRectangle(inputX, inputY, 0,0,6,6)
	output.setBool(2, next_page)
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
if next_page then
SC(5, 5, 5)
else
SC(0, 0, 0)
end
DRF(1,1.5,5,5)

SC(100,100,100)
DL(2,2,4.25,2.25)
DL(2,3,2.25,4.25)
SC(5, 5, 5)
DR(0,0,6,6)

end