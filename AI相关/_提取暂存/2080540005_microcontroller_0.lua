-- source: steam id 2080540005 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2080540005
data = {}


intervalCounter = 0
function onTick()
	interval = input.getNumber(32)
	
	if not input.getBool(32)then
		intervalCounter = intervalCounter + 1
		
		if intervalCounter > interval then
			intervalCounter = 0
			now = {}
			for i=1,4 do	
				now[i] = input.getNumber(i)
			end
			table.insert(data,1,now)
			
			if #data > 100 then
				table.remove(data,#data)
			end
		end
	end
end

function onDraw()
	SW = screen.getWidth()
	SH = screen.getHeight()
	
	
	screen.setColor(120,120,120)
	
	for di,d in ipairs(data) do
		columnWidth = SW/(#d + 1)
		
		screen.drawText(1, (di-1) * 7, "#" .. di)
		for i=1,#d do
			maxChars = math.floor((columnWidth - 5) / 5)
			val = d[i]
			valstring = tostring(val)
			if valstring == "0.0" then
				valstring = "0"
			end
			sub = string.sub(valstring,1,maxChars)
			if string.len(tostring(math.floor(val))) > maxChars then
				sub = "too long"
			end
			screen.drawText(i * columnWidth + 1, (di-1) * 7, sub)
		end
	end
end