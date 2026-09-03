-- source: steam id 2793900947 / vehicle.xml block#24
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2793900947
function onTick()
    x=input.getNumber(1)
	k=input.getNumber(2)
	heading=(math.fmod((1-x),1)*360)
end
function onDraw()
    w=screen.getWidth()
    h=screen.getHeight()
    screen.setColor(0,150,0)
	screen.drawText(k, 2,string.format("%1.0f", heading))
	screen.drawRect(40,0,17,8)
end
	