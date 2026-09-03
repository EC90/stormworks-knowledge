-- source: steam id 2900758088 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2900758088

function onTick()		
					
	r = input.getNumber(1)
	g = input.getNumber(2)
	b = input.getNumber(3)
	v = input.getNumber(4)
	ud = input.getNumber(5)
	lr = input.getNumber(6)

end

function onDraw()
	w = screen.getWidth()				 
	h = screen.getHeight()
	
	screen.setColor(r, g, b, v)			 
    
    screen.drawLine(w/2+lr   ,  h/2+10+ud  ,w/2+lr     , h/2+2+ud)
    screen.drawLine(w/2+10+lr,  h/2+ud     ,w/2+2+lr   , h/2+ud)
    screen.drawLine(w/2+lr   ,  h/2-10+ud  ,w/2+lr     , h/2-2+ud)
    screen.drawLine(w/2-10+lr,  h/2+ud     ,w/2-2+lr   , h/2+ud)

end