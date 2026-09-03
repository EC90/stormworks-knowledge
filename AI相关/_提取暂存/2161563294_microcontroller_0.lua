-- source: steam id 2161563294 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2161563294
ps = {}

initiated = false
function onDraw()
	amount = 6
	steps = 12
	
	if not initiated then
		-- init
		initiated = true
		
		exp = 0.3
		randomness = 2.5
		for i=1,amount do
			wid = screen.getWidth()*0.8/(i^exp)
			ps[i] = createPoints(screen.getWidth()/2-wid/2,screen.getWidth()/2+wid/2, steps, 0,screen.getHeight()*0.5/(i^exp), screen.getHeight()/32*((amount+1)-i)^0.3*randomness, 0.1)
		end
	end
	
	
	for i=1,amount do
		screen.setColor(i^0.6*70,i^0.6*35,0, 100)
		calcDelta(ps[i])
		drawPoints(ps[i])
	end
end
-- fromX = screen position to start with the points (from left)
-- toX = screen position to end with the points (from left)
-- steps = total number of points
-- fromY = screen position to start with the points (from bottom)
-- toY = screen position to end with the points (from bottom)
-- change = maximum random change for point delta every tick
-- changeFallback = how much point delta is removed (0.5 = 50%) every tick
function createPoints(fromX, toX, steps, fromY, toY, change, changeFallback)
	points = {
		fromX = fromX,
		toX = toX,
		steps = steps,
		fromY = fromY,
		toY = toY,
		change = change,
		changeFallback = changeFallback
	}
	stepsize = (toX-fromX)/steps
	for i=fromX, toX+stepsize/10, stepsize do
		normI = i-fromX
		normRange = toX-fromX
		table.insert(points, {
			x = i,
			y = screen.getHeight() - (xToY(normI/normRange*2 - 1) * (toY - fromY) + fromY),
			d = 0
		})
	end
	return points
end


function calcDelta(points)
	for i=1,#points do
		points[i].d = points[i].d + (math.random()-0.5)*points.change - points[i].d*points.changeFallback
	end
end

function drawPoints(points)
	for i=1,#points do
		p = points[i]
		nextP = points[i+1]
		if nextP then
			d1 = p.d + nextP.d
			d2 = nextP.d
			if points[i+2] then
				d2 = d2 + points[i+2].d
			end
			screen.drawTriangleF(p.x,screen.getHeight() - points.fromY, p.x,p.y+d1, nextP.x,screen.getHeight() - points.fromY)
			screen.drawTriangleF(p.x,p.y+d1, nextP.x,screen.getHeight() - points.fromY, nextP.x,nextP.y+d2)
		end
	end
end

function xToY(x)
	return -x^2 + 1
end
