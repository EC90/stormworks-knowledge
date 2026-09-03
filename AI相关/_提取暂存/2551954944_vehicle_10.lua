-- source: steam id 2551954944 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2551954944
yaw = -math.pi/2
points = {}

function onTick()
	dist = input.getNumber(1)
	elv = input.getNumber(2)*math.pi*2
	fov = math.rad(63-input.getNumber(3)*62.5)
	fov2 = math.atan(0.33*math.tan(fov))
	
	if dist ~= 0 then
		for i, v in ipairs(points) do
			if math.abs(v.y-yaw) <= 0.1 then v.y = (v.y+yaw)/2; v.e = (v.e+elv)/2; v.size = v.size+0.1; v.d = (v.d+dist)/2; temp = true else temp = false end
		end
		if #points == 0 then temp = false end
		if not temp then table.insert(points,{y = yaw, e = elv, t = 0,d=dist,size=0.5}) end
	end
	
	for i, v in ipairs(points) do
		if v.t >= 120 then table.remove(points,i)
		else
			v.t = v.t+1
		end
	end
	
	if yaw >= fov2 then yaw = -fov2 end
	yaw = yaw + fov2/60
	output.setNumber(1, yaw/math.pi/2)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	f = math.atan((w/h)*math.tan(fov))
	
	screen.setColor(0,255,0)
	
	--screen.drawText(2,2,"fov:"..string.format("%.2f",math.deg(fov))..",f:"..string.format("%.2f",math.deg(f)))
	
	for i, v in ipairs(points) do
	screen.setColor(0,255,0)
	x = w/2 + w/2 * (math.tan(v.y)/math.tan(f))
	y = h/2 - h/2 * (math.tan(v.e)/math.tan(fov))
	screen.drawRect(x-3*v.size,y-3*v.size,7*v.size,7*v.size)
	--screen.setColor(64,64,64)
	--screen.drawText(x-3,y-3,string.format("%.2f",math.deg(v.y)))
	
	--screen.setColor(255,0,0)
	--screen.drawRectF(w/2+v.d*math.cos(v.y-math.pi/2)/4,h/2+v.d*math.sin(v.y-math.pi/2)/4,1,1)
	end
	
	--screen.setColor(0,0,255)
	--screen.drawRectF(w/2,h/2,1,1)
	
	
end