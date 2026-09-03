-- source: steam id 2891786782 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2891786782
point={}
int = 0
max = property.getNumber('Max Distance')
min = property.getNumber('Min Distance')
inc = property.getNumber('Distance Incrament')
distance, max, min, inc = property.getNumber('Min Distance'), property.getNumber('Max Distance'), property.getNumber('Min Distance'), property.getNumber('Distance Incrament')
if property.getBool('Logo') then int=60 end
function onTick()
	tox = input.getNumber(1)
	toy = input.getNumber(2)
	if input.getBool(1) and isPointInRectangle(tox, toy, 2, 2, 6, 6) and distance < max then distance = distance + inc end
	if input.getBool(1) and isPointInRectangle(tox, toy, 2, 8, 6, 6) and distance > min then distance = distance - inc end
	angle = 6.28318531 * (input.getNumber(4)+0.75)
	for k,i in ipairs(point) do
		if i[2]-angle<0.2 and i[2]-angle>0 then table.remove(point, k) end
	end
	if input.getNumber(3) > 0 then table.insert(point, {input.getNumber(3), angle}) end
end

function onDraw()
	w = screen.getWidth()				  
	h = screen.getHeight()
	if int<60 then
	int = int+1
	screen.setColor(0, 255, 0)
	screen.drawTextBox(0, 0, w, h, "Energy Systems", 0, 0)
	screen.drawRectF(6, h-(h/5), (w-12) * (int/60), 8)
	screen.setColor(255, 255, 255)
	screen.drawRect(6, h-(h/5), w-12, 8)
	else
	screen.setColor(10, 10, 10)
	screen.drawCircle(w/2, h/2, h/6)
	screen.drawCircle(w/2, h/2, h/3)
	screen.drawCircle(w/2, h/2, h/2)
	screen.setColor(0, 0, 0)
	screen.drawRectF(2, 2, 6, 12)					
	screen.setColor(0, 255, 0)
	screen.drawRect(2, 2, 6, 6)
	screen.drawText(4, 3, "+")
	screen.drawRect(2, 8, 6, 6)
	screen.drawText(4, 9, "-")
	screen.drawText(2, h-8, math.floor(distance))
	screen.drawLine(w/2, h/2, (w/2) + ((h/2) * math.cos(angle)), (h/2) + ((h/2) * math.sin(angle)))
	for k,i in ipairs(point) do

		l = h * (i[1]/distance)
		angl = i[2]
		screen.drawRectF((w/2) + ((l/2) * math.cos(angl)), (h/2) + ((l/2) * math.sin(angl)), 1, 1)
	
	end
	end
end
	function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
