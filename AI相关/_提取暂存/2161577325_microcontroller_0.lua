-- source: steam id 2161577325 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2161577325
bubbles = {}

totalBubbleCount = 10

--[[

this script allows two display types:

"percent":
number input channel 1 = relative fill level of tank (0 = empty, 1 = full)


"absolute":
number input channel 1 = fuel level of tank
number input channel 2 = capacity of tank

]]--
function onTick()
	level = input.getNumber(1)
	capacity = input.getNumber(2)
	
	if input.getBool(1) then
		type = "absolute"
	else
		type = "percent"
	end
end

function onDraw()
	SW = screen.getWidth()
	SH = screen.getHeight()
	
	if type == "percent" then
		relativeFill = level
	elseif type == "absolute" then
		if capacity == 0 then
			return error("leak")
		end
		relativeFill = level / capacity
	else
		return error("invalid type!")
	end
	
	maxHeight = screen.getHeight() * relativeFill
	
	-- bubble color
	screen.setColor(0,40,100)
	for ib, b in ipairs(bubbles) do
		if b.y > maxHeight then
			table.remove(bubbles, ib)
		else
			b.y = b.y + b.speed
			
			screen.drawCircle(b.x,SH-b.y,b.r)
		end
	end
	
	screen.drawRectF(0, SH-maxHeight, SW,1)
	screen.setColor(0,0,0)
	screen.drawRectF(0, 0, SW, SH-maxHeight)
	
	screen.setColor(100,100,100)
	if type == "percent" then
		screen.drawTextBox(0,0,SW,SH, math.floor(level*100) .. "%", 0,0)
	elseif type == "absolute" then
		screen.drawTextBox(0,0,SW,SH, math.floor(level) .. "/" .. math.floor(capacity), 0,0)
	end
	
	if #bubbles < totalBubbleCount and math.random() > 0.5 then
		table.insert(bubbles, createBubble())
	end
end

function createBubble()
	r = (math.random()*2+1) * SW/32
	return {
		x = math.random(0,SW),
		y = -r,
		r = r,
		speed = math.random()*2+0.25
	}
end

function error(message)
	screen.setColor(255,0,0)
	screen.drawTextBox(0,0,SW,SH,message,0,0)
end