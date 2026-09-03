-- source: steam id 2836937357 / vehicle.xml block#35
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2836937357
si=math.sin
co=math.cos
pi=math.pi
pi2=pi*2
s=screen
ip=input

zoom=15

function onTick()
	ALT=ip.getNumber(2)
	SPD=ip.getNumber(1)

	
end
function onDraw()
	w=s.getWidth()
	h=s.getHeight()

	
	s.setColor(44,112,181)
	s.drawLine(0, 54, 96, 54)
	s.setColor(0,0,0)
	s.drawRectF(0, 55, 96, 9)
	s.setColor(200,200,200)
	s.drawText(4,57,"SPD:")
	s.drawText(45,57,"ALT:")
	s.drawText(23,57,string.format("%.0f" , SPD ))
	s.drawText(65,57,string.format("%.0f" , ALT ))
	
	
end
