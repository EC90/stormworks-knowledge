-- source: steam id 2793900947 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947
function onTick()
    value=input.getNumber(1)
end
function onDraw()
    w=screen.getWidth()
    h=screen.getHeight()
    screen.setColor(0,150,0)
	screen.drawText( 0 , h -20 , string.format( "%0.1fs" , value ) )
end
	