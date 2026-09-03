-- source: steam id 3792235232 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792235232
zoom = 0
stable_mode = false
igN=input.getNumber
igB=input.getBool
before_touch=false
sC=screen.setColor

function onTick()
	sw = igN(1)
	sh = igN(2)
	tx = igN(3)
	ty = igN(4)
	dist = igN(32)
	zi=igB(30)
	zo=igB(31)
	radar=igB(32)
	t = input.getBool(1)
	
	--double touch
	if t then
		if before_touch then
			d_t=false
			before_touch=true
		else
			d_t=true
			before_touch=true
		end
	else
		d_t=false
		before_touch=false
	end
	
	pitch=0.0
	rotate=0.0
	touched=false

	--zoom in
	if isPointInRectang1e(tx, ty, 1, sh-18, 6, 6) and t then
		zoom = zoom + 0.01
		touched=true
	end
	if zi then
		if zoom > 0.84 then
			zoom = zoom + 0.05
		else
			zoom = zoom + 0.15
		end
	end
	--zoom out
	if isPointInRectang1e(tx, ty, 1, sh-10, 6, 6) and t then
		zoom = zoom - 0.01
		touched=true
	end
	if zo then
		if zoom > 0.84 then
			zoom = zoom - 0.05
		else
			zoom = zoom - 0.15
		end

	end
	if zoom > 1 then
		zoom = 1
	elseif zoom < 0 then
		zoom = 0
	end

	--stabi mode
	if isPointInRectang1e(tx, ty, sw/2+7, sh-9, 16, 7) and d_t then
		if stable_mode then
			stable_mode=false
		else 
			stable_mode=true
		end
		touched=true
	end
	
	--camera move
	if not touched then
		--up
		if isPointInRectang1e(tx, ty, sw/3, 0, sw/3, sh/2) and t then
			--pitch = (0.1 + 0.65*(1-zoom))
			pitch = 0.0001
		end
	
		--down
		if isPointInRectang1e(tx, ty, sw/3, sh/2, sw/3, sh/2) and t then
--			pitch = -(0.1 + 0.65*(1-zoom))
			pitch = -0.0001
		end

		--left
		if isPointInRectang1e(tx, ty, 0, 0, sw/3, sh) and t then
--			rotate = -(0.1 + 0.65*(1-zoom))
			rotate = -0.0001
		end

		--right
		if isPointInRectang1e(tx, ty, sw/3*2, 0, sw/3, sh) and t then
--			rotate = (0.1 + 0.65*(1-zoom))
			rotate = 0.0001
		end
	end

	output.setNumber(1, pitch)
	output.setNumber(2, rotate)
	output.setNumber(3, zoom)
	output.setBool(1, stable_mode)
end

function onDraw()
	w = screen.getWidth() / 2
	h = screen.getHeight() / 2
    
	drawReticle()
	

	
	--dist
    sC(255, 0, 0,200)
	screen.drawTextBox(w-10, h+15, 20, 6, string.format("%.0f", dist), 0, 0)
	
end
	
function isPointInRectang1e(x, y, rectX, rectY, rectW, rectH)
    return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function drawReticle()
	if stable_mode then
		screen.setColor(255, 0, 0, 200)
	else 
		screen.setColor(0, 255, 0, 200)
	
	end	
--	screen.drawCircle(w, h, w/2)
end