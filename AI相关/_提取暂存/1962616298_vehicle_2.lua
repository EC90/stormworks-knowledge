-- source: steam id 1962616298 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1962616298
function onTick()
	x = input.getNumber(5)
	x = math.ceil(x-0.5)
	if x<999 then 
		IAS = x
	else 
		IAS = 999
	end
	x = math.ceil(input.getNumber(11)-0.5)
	if x<99999 then 
		alt = x
	else 
		alt = 99999
	end
	alt2 = (math.ceil((alt/10)-0.5))*10
	x = input.getNumber(12)
	if x>3000 then 
		vs = 3000
	elseif x<-3000 then 
		vs = -3000
	else 
		vs = x
	end
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	a = h/2 -- center height
	b = w/2 -- center width
	if w>33 then
	
		screen.setColor(30, 30, 30) -- airspeed tape
		screen.drawRectF(-1, a-17.5, 17, 35)
		screen.setColor(10, 10, 10)
		screen.drawRectF(-1, a-4, 17, 8)
		screen.setColor(255, 255, 255)
		screen.drawRect(-1, a-5, 17, 8)
		if IAS>1 then
			screen.drawTextBox(0, a+11, 15, 9, IAS-2, 1, -1)
		end
		if IAS>0 then
			screen.drawTextBox(0, a+5, 15, 9, IAS-1, 1, -1)
		end
		screen.drawTextBox(0, a-3, 15, 9, IAS, 1, -1)
		if IAS<999 then
			screen.drawTextBox(0, a-11, 15, 9, IAS+1, 1, -1)
		end
		if IAS<998 then
			screen.drawTextBox(0, a-17, 15, 9, IAS+2, 1, -1)
		end
		
		screen.setColor(30, 30, 30) -- vertical speed tape
		screen.drawRectF(w-6, a-18.5, 7, 37)
			
		--screen.drawRectF(w-12, a-2, 6, 7)
		screen.setColor(255, 0, 255)
		if vs>0 then 
			screen.drawRectF(w-2, a-0.5, 2, -vs*(3/500)) -- climbing indication
		end
		if vs<0 then 
			screen.drawRectF(w-2, a+0.5, 2, (-vs*(3/500))) -- descending indication
		end
		screen.setColor(255, 255, 255)
		--screen.drawText(w-11, a-2, "0")
		screen.drawLine(w-6, a-19, w-2, a-19)
		screen.drawLine(w-6, a-16, w-4, a-16)
		screen.drawLine(w-6, a-13, w-2, a-13)
		screen.drawLine(w-6, a-10, w-4, a-10)
		screen.drawLine(w-6, a-7, w-2, a-7)
		screen.drawLine(w-6, a-4, w-4, a-4)
		screen.drawLine(w-6, a-1, w, a-1)
		screen.drawLine(w-6, a+2, w-4, a+2)
		screen.drawLine(w-6, a+5, w-2, a+5)
		screen.drawLine(w-6, a+8, w-4, a+8)
		screen.drawLine(w-6, a+11, w-2, a+11)
		screen.drawLine(w-6, a+14, w-4, a+14)
		screen.drawLine(w-6, a+17, w-2, a+17)
		if w<65 then 
			screen.setColor(30, 30, 30)
			screen.drawRectF(w-12, a-3.5, 6, 7)
			screen.setColor(255, 255, 255)
			screen.drawText(w-11, a-3, "0")
		else
			screen.setColor(30, 30, 30)
			screen.drawRectF(w-17, a-18.5, 11, 37)
			screen.setColor(255, 255, 255)
			screen.drawText(w-16, a-18, "3k")
			screen.drawText(w-11, a-3, "0")
			screen.drawText(w-16, a+12, "3k")
		end
		
		screen.setColor(30, 30, 30)
		if w<65 then
			screen.drawRectF(w-26, a+21.5, 26, 7)
			screen.setColor(255, 255, 255)
			screen.drawRect(w-27, a+20, 27, 8)
			screen.drawTextBox(w-26, a+22, 25, 9, alt, 1, -1)
		else
			screen.drawRectF(w-44, a-17.5, 26, 35)
			screen.setColor(10, 10, 10)
			screen.drawRectF(w-45, a-4, 27, 8)
			screen.setColor(255, 255, 255)
			screen.drawLine(w-18, a-19, w-18, a+18)
			screen.drawRect(w-45, a-5, 27, 8)
			
			if alt2>19 then
				screen.drawTextBox(w-44, a+11, 25, 9, alt2-20, 1, -1)
			end
			if alt2>9 then
				screen.drawTextBox(w-44, a+5, 25, 9, alt2-10, 1, -1)
			end
			screen.drawTextBox(w-44, a-3, 25, 9, alt, 1, -1)
			if alt2<99981 then
				screen.drawTextBox(w-44, a-11, 25, 9, alt2+10, 1, -1)
			end
			if alt2<99971 then
				screen.drawTextBox(w-44, a-17, 25, 9, alt2+20, 1, -1)
			end
		end
	end
end