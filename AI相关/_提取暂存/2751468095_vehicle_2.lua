-- source: steam id 2751468095 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2751468095
function onTick()
nvd=input.getBool(1)
reverse=input.getBool(2)
gear=input.getNumber(1)
coordinates=input.getNumber(2)
heading=input.getNumber(3)
speed=input.getNumber(4)
highbeam=input.getBool(3)
park=input.getBool(4)
reversewarn=input.getBool(5)
leftblink=input.getBool(6)
rightblink=input.getBool(7)
hazard=input.getBool(8)
end

function onDraw()
x=0
y=0
w=screen.getWidth()
h=screen.getHeight()
if nvd then
screen.setColor(0,200,105,50)
screen.drawCircleF(w/2, h/2, 16)
end
if highbeam then
screen.setColor(0,5,205)
screen.drawLine(12+x,14+y,12.25+x,16.25+y)
screen.drawLine(13+x,13+y,13.25+x,17.25+y)
screen.drawLine(14+x,13+y,14.25+x,17.25+y)
screen.drawLine(16+x,13+y,17.25+x,13.25+y)
screen.drawLine(16+x,15+y,18.25+x,15.25+y)
screen.drawLine(16+x,17+y,17.25+x,17.25+y)
end
if park then
screen.setColor(47,0,0)
screen.drawRectF(89+x,11+y,1,3)
screen.drawRectF(87+x,11+y,1,3)
screen.drawRectF(88+x,13+y,1,1)
screen.drawRectF(88+x,11+y,1,1)
screen.drawRectF(87+x,14+y,1,2)
screen.drawRectF(87+x,17+y,4,1)
screen.drawRectF(85+x,11+y,1,6)
screen.drawRectF(86+x,17+y,1,1)
screen.drawRectF(86+x,9+y,5,1)
screen.drawRectF(85+x,10+y,1,1)
screen.drawLine(91+x,10+y,91.25+x,16.25+y)
end
if reversewarn then
screen.setColor(47,0,0)
screen.drawRectF(4+x,17+y,1,1)
screen.drawRectF(5+x,17+y,1,1)
screen.drawRectF(6+x,17+y,3,1)
screen.drawRectF(9+x,17+y,1,1)
screen.drawRectF(10+x,17+y,1,1)
screen.drawRectF(9+x,16+y,1,1)
screen.drawRectF(9+x,15+y,1,1)
screen.drawRectF(5+x,15+y,1,2)
screen.drawRectF(5+x,14+y,1,1)
screen.drawRectF(9+x,14+y,1,1)
screen.drawRectF(6+x,13+y,3,1)
screen.drawRectF(7+x,12+y,1,1)
screen.drawRectF(6+x,14+y,1,3)
screen.drawRectF(7+x,14+y,2,3)
screen.setColor(0,0,0)
screen.drawRectF(7+x,13+y,1,2)
screen.drawRectF(7+x,16+y,1,1)
screen.drawRectF(7+x,15+y,1,1)
screen.setColor(47,0,0)
screen.drawRectF(7+x,13+y,1,1)
screen.drawRectF(10+x,16+y,1,1)
screen.drawRectF(4+x,16+y,1,1)
end
if leftblink or hazard then
screen.setColor(238,56,0)
screen.drawRect(35+x,29+y,2,1)
screen.drawLine(34+x,28+y,34.25+x,31.25+y)
screen.drawLine(33+x,29+y,33.25+x,30.25+y)
end
if rightblink or hazard then
screen.setColor(238,56,0)
screen.drawRect(58+x,29+y,2,1)
screen.drawLine(61+x,28+y,61.25+x,31.25+y)
screen.drawLine(62+x,29+y,62.25+x,30.25+y)
end
		screen.setColor(0,150,0)
		screen.drawText( 4 , h - 10 , string.format( "%1.0fKm/H" , speed ) )
			screen.setColor(0,150,0)
			screen.drawText(coordinates, 2,string.format("%1.0f", heading))
			screen.drawRect(40,0,17,8)
					if not reverse then
    				screen.setColor(0,150,0)
					screen.drawText( 68 , h - 10 , string.format( "Gear%1.0f" , gear ) )
					else
    				screen.setColor(0,150,0)
					screen.drawText( 60 , h - 10 , ("Reverse"))	
					end
end