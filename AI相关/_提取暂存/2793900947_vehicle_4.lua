-- source: steam id 2793900947 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947
function onTick()
    value=input.getNumber(1)
	g=input.getNumber(2)
	r=input.getNumber(3)
end
function onDraw()
    w=screen.getWidth()
    h=screen.getHeight()
    screen.setColor(r,g,0)
	screen.drawText( 35 , h - 10 , string.format("%1.0fRNDS",value))
end
	