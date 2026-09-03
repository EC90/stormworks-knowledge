-- source: steam id 2793900947 / vehicle.xml block#16
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947
function onTick()
    value=input.getNumber(4)
	x=input.getBool(6)
end
function onDraw()
	w=screen.getWidth()
    h=screen.getHeight()
	if not x then
    screen.setColor(0,150,0)
	screen.drawText( 68 , h - 10 , string.format( "Gear%1.0f" , value ) )
	else
    screen.setColor(0,150,0)
	screen.drawText( 60 , h - 10 , ("Reverse"))	
	end
end

 
	