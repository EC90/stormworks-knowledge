-- source: steam id 2046605849 / vehicle.xml block#10
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2046605849
-- -> 0deg V90deg <180deg ^270deg
tyaw = 0
yawup = 1
targets = {}
srans = {45,60,90,180}
mode = 1
sran = srans[mode]
touched = false

zoom = {5000,2500,1000,500,50}
zoomMode = 1
clicked = false

found = {}

function onTick()
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)
	tdis = input.getNumber(7)	
	--sran = input.getNumber(8)	--45d, 90d, 180d
	sspd = input.getNumber(8)	--scanspeed
	tdet = input.getBool(3)	--target detected	
	revs = input.getBool(4)	--downward?	
	
	if (math.abs(tyaw)>sran) and (sran~=180) then yawup = yawup*-1 end
	tyaw = tyaw + yawup*sspd/5
	if tyaw>=180 then tyaw = -180 end
	
	
	for i,v in ipairs(found) do
		v[3] = v[3]-1
		if v[3]<0 then table.remove(found,i) end
	end
	
	if tdet then
		table.insert(found, {tyaw, tdis, 255})
	end
	
	isPressingRectangle = isPressed and isPointInRectangle(inputX, inputY, 2,2,8,8)
	
	if isPressingRectangle then
		clicked = true
	end
	
	if not isPressed then
		if clicked then
			zoomMode = (zoomMode+1)%#zoom
			clicked = false
		elseif touched then
			mode = (mode+1)%#srans
			yawup = 1
			tyaw = 0
			found = nil
			found = {}
		end
	end
	touched = isPressed
	sran = srans[mode+1]
		
	if revs then
		output.setNumber(1, -tyaw/360)
	else
		output.setNumber(1, tyaw/360)
	end
	output.setNumber(2, radius)
	output.setNumber(3, centerH)
end

function drawPixel(x, y)
	screen.drawText(x-1, y-4, ".")
end

function drawArcDash(x, y, r, st, w)
	for i=st, (st+w)-1 do
		x1, y1 = x + r*math.cos(math.rad(i)), y + r*math.sin(math.rad(i))
		drawPixel(x1,y1)
	end
end

function drawBackground(x, y, r, st, w)
	local k = math.floor(math.log(r))
	for i=1, k do
		drawArcDash(x, y, r*i/k, st, w) 
	end
	if sran ~= 180 then		
		x1, y1 = x + r*math.cos(math.rad(st)), y + r*math.sin(math.rad(st))
		screen.drawLine(x, y, x1, y1)
		x1, y1 = x + r*math.cos(math.rad(st+w)), y + r*math.sin(math.rad(st+w))
		screen.drawLine(x, y, x1, y1)
	end
end

function drawButton(x,y,w,h)
	if clicked then 
		screen.setColor(255,255,0)
	else	
		screen.setColor(0,64,0)
	end
	screen.drawRect(x, y, w, h)
	screen.drawTextBox(x+1, y+1, w, h, "R", 0, 0)
end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
	screenH, screenW = screen.getHeight(), screen.getWidth()
	screen.setColor(0,32,0)
	
	if sran ~= 180 then
		radius = screenW/(2*math.sin(math.rad(sran)))*0.9
	else
		radius = screenH/2*0.9
	end
	centerH = screenH/2 + screenH*(180-sran)/300
	
	drawBackground(screenW/2, centerH, radius, 270-sran, 2*sran)	
	
	x3, y3 = screenW/2 + radius*math.cos(math.rad(tyaw-90)), centerH + radius*math.sin(math.rad(tyaw-90))
	screen.drawLine(screenW/2, centerH, x3, y3)
		
	--screen.drawText(0,0,screenW.."x"..screenH)
	--screen.drawText(0, 0, sran*2)
	screen.drawTextBox(0, 0, screenW, screenH, zoom[zoomMode+1].."m", 1, -1)
	
	for i, v in ipairs(found) do
		screen.setColor(0, 255, 0, v[3])
		xt, yt = screenW/2 + radius*v[2]/zoom[zoomMode+1]*math.cos(math.rad(v[1]-90)), centerH + radius*v[2]/zoom[zoomMode+1]*math.sin(math.rad(v[1]-90))
		drawPixel(xt, yt)
	end
	
	--screen.drawText(screenW/2, centerH, tyaw)
	
	drawButton(2,2,8,8)
	
end