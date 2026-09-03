-- source: steam id 2080410615 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2080410615
travelSpeed = 0
crossSpeed = 0

MAX_G = 3

function onTick()
	travelSpeedDiff = travelSpeed - input.getNumber(1)
	crossSpeedDiff = crossSpeed - input.getNumber(2)
	
	travelAccel = travelSpeedDiff / (1/60)
	crossAccel = crossSpeedDiff / (1/60)
	
	travelG = travelAccel / 9.81
	crossG = crossAccel / 9.81
	
	travelSpeed = input.getNumber(1)
	crossSpeed = input.getNumber(2)
end

function onDraw()
	S = screen
	SW = S.getWidth()
	SH = S.getHeight()
	
	r = math.min(SW,SH) / 3.1
	cx = SW/2
	cy = SH/2 + r/4
	
	
	S.setColor(120,120,120)
	S.drawTextBox(0,0,SW,9, string.format("%.1f", (travelG^2 + crossG^2)^0.5  ) .. "g", 0,0)
	for i=1,MAX_G do
		S.drawCircle(cx,cy,i/MAX_G * r)		
	end
	S.drawCircleF(cx,cy,1)
	
	px = cx + (crossG / MAX_G) * r
	py = cy + (-travelG / MAX_G) * r
	S.setColor(120,0,0)
	S.drawCircleF(px,py,2)
	S.drawLine(cx,cy,px,py)
end
