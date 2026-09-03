-- source: steam id 2628490430 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2628490430
iN=input.getNumber
oN=output.setNumber
sin=math.sin
cos=math.cos
tan=math.tan
atan=math.atan
pi2=math.pi*2

function onTick()
	roll=atan(sin(iN(1)*pi2),sin(iN(2)*pi2))
	fov=lerp(2.2,0.025,iN(3))/2
	offset=iN(4)*pi2
end

function onDraw()
	local w,h=screen.getWidth(),screen.getHeight()
	local hw,hh=w/2,h/2

	local diff=tan(offset)*hh/tan(fov)
	local centerX=hw - sin(roll)*diff
	local centerY=hh - diff+cos(roll)*diff

	screen.setColor(200,0,0,200)
	screen.drawLine(centerX-3, centerY, centerX+4, centerY)
	screen.drawLine(centerX, centerY-3, centerX, centerY+4)
end

function lerp(a,b,t)
	return a+(b-a)*t
end

function clamp(x,a,b)
	return x<a and a or x>b and b or x
end
