-- source: steam id 2793900947 / vehicle.xml block#17
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947
function onTick()
    value=input.getNumber(1)
end
function onDraw()
    w=screen.getWidth()
    h=screen.getHeight()
    screen.setColor(0,150,0)
	screen.drawText( 4 , h - 10 , string.format( "%1.0fKm/H" , value ) )
end
	