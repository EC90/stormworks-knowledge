-- source: steam id 2627500609 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2627500609
function onTick()
	x = input.getNumber(1)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()					
	
	r =10
	
	Cx,Cy = w/2+50*x,h/2-2

	screen.setColor(0, 255, 0,200)		
	screen.drawCircle(Cx, Cy, r)
	screen.drawLine(Cx,Cy-r,Cx,Cy+r)
	screen.drawLine(Cx-r,Cy,Cx+r,Cy)


end