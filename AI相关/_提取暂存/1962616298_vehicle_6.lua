-- source: steam id 1962616298 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1962616298
function onTick()
	x = input.getNumber(8)
	if x>2 then 
		slip = 2
	elseif x<-2 then 
		slip = -2
	else 
		slip = x
	end
	--if w<63 then output.setBool(1, true)
	--end
end

function onDraw() -- slip skid indicator
	w = screen.getWidth()
	h = screen.getHeight()
	a = h/2 -- center height
	if w<65 then
		b = w/2 -- center width
	else
		b = (w/2)-10
	end
	screen.setColor(150, 150, 150)
	screen.drawTriangleF(b, 2, b-4, 6, b+4, 6)
	screen.drawRectF(b-3+(slip*5), 7, 6, 2) -- step on the ball
end