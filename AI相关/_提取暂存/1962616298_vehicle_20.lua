-- source: steam id 1962616298 / vehicle.xml block#20
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1962616298
inp={}
bool={}
engn=property.getNumber("Number of Engines")
mrps=property.getNumber("Max Engine RPS")

function onTick()
	for i=1, 32 do
		inp[i]=input.getNumber(i)
		bool[i]=input.getBool(i)
	end
end

function onDraw()
	screen.setColor(0, 0, 0)
	screen.drawClear()
	h=screen.getHeight()
	w=screen.getWidth()
	a=h/2
	b=w/2
	det=inp[24]
	det=math.ceil(det-0.5)
	if det==0 and engn>1 then --
		r=h*3/16
		for k=1, engn do
			if inp[k*2-1]<0.5 then -- 
				rps=0
			elseif inp[k*2-1]<mrps*1/12 then
				rps=mrps*1/12
			elseif inp[k*2-1]>mrps*23/24 then
				rps=mrps
			else
				rps=inp[k*2-1]
			end
			if rps<mrps*0.5 then -- 
				screen.setColor(255, 255, 255)
			elseif rps<mrps*0.75 then
				screen.setColor(255, 255, 255-255*(rps-0.5*mrps)/(0.25*mrps))
			else
				screen.setColor(255, 255-255*(rps-0.75*mrps)/(0.25*mrps), 0)
			end	
			for i=3, 36*rps/mrps, 3 do -- rps indication
				screen.drawTriangleF(inp[k+24]-3, inp[k+28]+3, inp[k+24]-3+Si(i)*r, inp[k+28]+3-Co(i)*r, inp[k+24]-3+Si(i-3)*r, inp[k+28]+3-Co(i-3)*r)
			end
			if inp[k*2]<0 then -- sets temp for graphical display
				temp=0
			elseif inp[k*2]>120 then
				temp=120
			else
				temp=inp[k*2]
			end
			if temp<20 then -- temp dependent color
				screen.setColor(0, 255, 0)
			elseif temp>100 then
				screen.setColor(255, 0, 0)
			else
				d=(temp-20)/80
				screen.setColor(255*d, (1-d)*255, 0)
			end
			screen.drawRectF(inp[k+24]+r-1, inp[k+28]+r+2.5, 4, -2*(r-0.5)*temp/120) -- temp indication
			
			screen.setColor(200, 200, 200)
			for i=0, 36, 3 do
				screen.drawLine(inp[k+24]-3+Si(i)*r, inp[k+28]+2-Co(i)*r, inp[k+24]-3+Si(i+3)*r, inp[k+28]+2-Co(i+3)*r)
			end
			screen.drawText(inp[k+24]-9, inp[k+28]-r-4, "ENG"..k)
			screen.drawRect(inp[k+24]+r-1, inp[k+28]-r+2, 4, 2*r)
   	 end
	else -- detailed view
		r=h*3/16
		if engn==1 then
			det=1
		else -- back button
			screen.setColor(50, 50, 50, 50)
			screen.drawRectF(0, -0.5, 11, 12)
			screen.setColor(200, 200, 200, 200)
			screen.drawLine(2, 5, 9, 5)
			screen.drawLine(2, 5, 6, 1)
			screen.drawLine(2, 5, 6, 9)
		end
		screen.drawText(b-10, 3, "ENG"..det)
		if inp[det*2-1]<0.5 then -- rps for graphical display
			rps=0
		elseif inp[det*2-1]<mrps*1/12 then
			rps=mrps*1/12
		elseif inp[det*2-1]>mrps*23/24 then
			rps=mrps
		else
			rps=inp[det*2-1]
		end
		if rps<mrps*0.5 then -- rps dependent color
			screen.setColor(255, 255, 255)
		elseif rps<mrps*0.75 then
			screen.setColor(255, 255, 255-255*(rps-0.5*mrps)/(0.25*mrps))
		else
			screen.setColor(255, 255-255*(rps-0.75*mrps)/(0.25*mrps), 0)
		end	
		for i=1, 36*rps/mrps, 1 do -- rps indication
			screen.drawTriangleF(b/2-3, a/2+6, b/2-3+Si(i)*r, a/2+6-Co(i)*r, b/2-3+Si(i-1)*r, a/2+6-Co(i-1)*r)
		end
		if inp[det*2]<0 then -- temp for graphical display
			temp=0
		elseif inp[det*2]>120 then
			temp=120
		else
			temp=inp[det*2]
		end
		if temp<20 then -- temp dependent color
			screen.setColor(0, 255, 0)
		elseif temp>100 then
			screen.setColor(255, 0, 0)
		else
			d=(temp-20)/80
			screen.setColor(255*d, (1-d)*255, 0)
		end
		screen.drawRectF(b/2+r, a/2+5.5+r, 4, -2*(r-0.5)*temp/120) -- temp indication
		screen.setColor(255, 255, 255)
		for i=0, 36, 1 do
			screen.drawLine(b/2-3+Si(i)*r, a/2+5-Co(i)*r, b/2-3+Si(i+1)*r, a/2+5-Co(i+1)*r)
		end
		screen.drawRect(b/2+r-1, a/2-r+5, 4, 2*r)
		screen.drawText(3, a/2+8+r, "RPS:") -- numerical value displays
		rps=(math.ceil(inp[det*2-1]*100-0.5))/100
		screen.drawTextBox(3, a/2+8+r, w-6, 7, rps, 1, -1)
		screen.drawText(3, a/2+16+r, "Temp:")
		temp=(math.ceil(inp[det*2]*10-0.5))/10
		screen.drawTextBox(3, a/2+16+r, w-6, 7, math.ceil(inp[det*2]*10-0.5)/10, 1, -1)
		screen.drawText(3, a/2+24+r, "THRT:")
		thrt=(math.ceil(inp[det+18]*1000-0.5))/10
		screen.drawTextBox(3, a/2+24+r, w-6, 7, thrt.."%", 1, -1)
		if bool[det+6] then
			screen.drawTextBox(w-30, a/2-r+6, 29, 7, "START", 1, -1)
		end
		if bool[det+10] then
			screen.drawTextBox(w-30, a/2-r+14, 29, 7, "REV", 1, -1)
		end
	end
end

function Co(x)
    return math.cos(10*x*math.pi/180)
end

function Si(x)
    return math.sin(10*x*math.pi/180)
end