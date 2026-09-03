-- source: steam id 2080343347 / microcontroller.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2080343347
V={}
columnWidth=5*8+9
lineHeight=8

function onTick()
	for i=1,32 do
		V[i]=input.getNumber(i)
	end
end

function onDraw()
	y=0
	x=0

	for i=1,32 do
		screen.setColor(30,30,30)
		name=""
		if i < 10 then
			name=" "
		end
		name = name .. tostring(i)
		screen.drawText(x*columnWidth+1, y*lineHeight, name)
		val = tostring(math.floor(V[i]*1000)/1000)
		if val == "0.0" then
			val = "0"
		end
		screen.drawText(x*columnWidth+17, y*lineHeight, val)
		y=y+1
		if (y+1)*lineHeight > screen.getHeight() then
			x=x+1
			y=0
		end
	end
end
