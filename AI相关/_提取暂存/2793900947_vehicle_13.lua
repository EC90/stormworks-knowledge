-- source: steam id 2793900947 / vehicle.xml block#13
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947
function onTick()
    value=input.getNumber(1)
	x=input.getNumber(2)
end
function onDraw()
    w=screen.getWidth()
    h=screen.getHeight()
    screen.setColor(0,150,0)
	screen.drawText( x , h -50 , string.format( "%0.1f'" , value ) )
end
	