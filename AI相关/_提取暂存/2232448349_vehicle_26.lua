-- source: steam id 2232448349 / vehicle.xml block#26
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2232448349
function onTick()
	ctr1=input.getBool(4)
	if ctr1 then
		ctr=not ctr
	end
	output.setBool(1, ctr)
	hdg=math.ceil(input.getNumber(14)-0.5)
	rad=hdg*(math.pi/180)
end
	
function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()
	a=h/2
	b=w/2
	sin=math.sin(rad)
	cos=math.cos(rad)
	screen.setColor(255, 255, 255)
	if ctr and w>63 then
		r=a*0.625 -- radius of compass circle
		r1=7 -- less radius of 90 degree marks
		r2=5 -- less radius of 30 degree marks
		cx=b
		cy=a
		screen.drawText(cx-((sin)*(r+4))-2, cy-((cos)*(r+4))-2, "N") -- cardinal directions
		screen.drawText(cx-((cos)*(r+4))-2, cy+((sin)*(r+4))-2, "W")
		screen.drawText(cx+((sin)*(r+4))-2, cy+((cos)*(r+4))-2, "S")
		screen.drawText(cx+((cos)*(r+4))-2, cy-((sin)*(r+4))-2, "E") 
		elseif w>63 then
		r=2*w
		r1=8
		r2=6
		r3=4 -- less radius of 10 degree marks
		if w>65 then r4=3 -- less radius of 5 degree marks
			else r4=2
		end
		cx=b
		cy=h+(r-15)
--		screen.drawLine(32, h-10, 32, h)
		for i=1, 36 do -- draws degree labels
			if i <10 then
				screen.drawText(cx+Si(i)*(r+4)-7, cy-Co(i)*(r+4)-2, "0" .. (i)*10)
				else
				screen.drawText(cx+Si(i)*(r+4)-7, cy-Co(i)*(r+4)-2, (i)*10)
			end
		end
		ang1={1, 2, 4, 5, 7, 8, 10, 11, 13, 14, 16, 17, 19, 20, 22, 23, 25, 26, 28, 29, 31, 32, 34, 35}
		for i=1, 24 do -- draws 10 degree ticks
			screen.drawLine(cx+Si(ang1[i])*r, cy-Co(ang1[i])*r, cx+Si(ang1[i])*(r-r3), cy-Co(ang1[i])*(r-r3))
		end
		for i=0.5, 35.5 do -- draws 5 degree ticks
			screen.drawLine(cx+Si(i)*r, cy-Co(i)*r, cx+Si(i)*(r-r4), cy-Co(i)*(r-r4))
		end
		if w>65 then
			for i=0.1, 36, 0.1 do -- draws 1 degree ticks
				screen.drawLine(cx+Si(i)*r, cy-Co(i)*r, cx+Si(i)*(r-2), cy-Co(i)*(r-2))
			end
		end
	end
	if w>63 then
		for i = 0, 36, 0.1 do -- draws a smooth circle
			screen.drawLine(cx+Si(i)*r, cy-Co(i)*r, cx+Si(i+0.1)*r, cy-Co(i+0.1)*r)
		end
		tick={0, 9, 18, 27}
		for i=1, 4 do -- draws 90 degree ticks
			screen.drawLine(cx+Si(tick[i])*r, cy-Co(tick[i])*r, cx+Si(tick[i])*(r-r1), cy-Co(tick[i])*(r-r1))
		end
		tick={3, 6, 12, 15, 21, 24, 30, 33}
		for i=1, 8 do -- draws 30 degree ticks
			screen.drawLine(cx+Si(tick[i])*r, cy-Co(tick[i])*r, cx+Si(tick[i])*(r-r2), cy-Co(tick[i])*(r-r2))
		end
	end
	if ctr and w>63 then
		screen.setColor(100, 100, 255)
		screen.drawLine(cx, cy-(r-1), cx, cy-(r/2)) -- draws pointer for centered compass
		screen.setColor(10, 10, 10)
		screen.drawRectF(b-9, a-3, 18, 7)
		screen.setColor(255, 255, 255)
		screen.drawRect(b-9, a-4, 18, 8)
		if hdg<100 and hdg>9 then
			screen.drawText(b-7, a-2, "0" .. hdg)
			elseif hdg<10 then
			screen.drawText(b-7, a-2, "00" .. hdg)
			else
			screen.drawText(b-7, a-2, hdg)
		end
		else
		screen.setColor(10, 10, 10)
		screen.drawRectF(b-9, h-6, 18, 7)
		screen.setColor(255, 255, 255)
		screen.drawRect(b-9, h-8, 18, 8)
		if hdg<100 and hdg>9 then
			screen.drawText(b-7, h-6, "0" .. hdg)
			elseif hdg<10 then
			screen.drawText(b-7, h-6, "00" .. hdg)
			else
			screen.drawText(b-7, h-6, hdg)
		end
		screen.drawTriangleF(b+sin*4, a-cos*4, b+math.sin(rad+130*math.pi/180)*3, a-math.cos(rad+130*math.pi/180)*3, b+math.sin(rad+230*math.pi/180)*3, a-math.cos(rad+230*math.pi/180)*3)
		if w>63 then
			screen.drawTriangleF(b, h-14, b+4, h-7, b-4, h-7)
		end
	end
end
	
function Co(x)
	return math.cos(-rad+(10*x*math.pi/180))
end

function Si(x)
	return math.sin(-rad+(10*x*math.pi/180))
end