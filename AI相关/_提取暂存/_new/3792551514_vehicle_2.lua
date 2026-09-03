-- source: steam id 3792551514 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3792551514
scr = screen

function onTick()
	fuel = input.getNumber(1)
	spd = input.getNumber(2)
	dif = (input.getNumber(3))*-1
	fcap = input.getNumber(4)
end

function rd(num, dec)
	if dec > 0 then
		local mult = 10^(dec or 0)
		return math.floor(num * mult + 0.5) / mult
	else
		return math.floor(num)
	end
end

function onDraw()
	
	w = scr.getWidth()
	h = scr.getHeight()
	
	--uptime
	if dif*60 > 0 then
		uptime = fuel/(dif*60)
	else
		uptime = (fcap-fuel)/(dif*-60)
	end
	
scr.setColor(60, 60, 60)
		if spd < 6 then
			scr.drawTextBox((w/2)+16, 23, 32, 5, '-', 0, 0)
		elseif uptime > 1 and uptime < 300 then
			scr.drawTextBox((w/2)+16, 23, 32, 5, tostring(rd(uptime,0))..'m', 0, 0)
		else
			scr.drawTextBox((w/2)+16, 23, 32, 5, '-', 0, 0)			
		end
	
	--range
		ms = 'km'
		range = rd(spd*60/1000*uptime, 0)

scr.setColor(60, 60, 60)
		if spd < 6 then
			scr.drawTextBox((w/2)+16, 17, 32, 5, '-', 0, 0)
		elseif range < 10000 then
			scr.drawTextBox((w/2)+16, 17, 32, 5, tostring(range)..ms, 0, 0)
		elseif range < 100000 then
			scr.drawTextBox((w/2)+16, 17, 32, 5, 'far', 0, 0)
		else
			scr.drawTextBox((w/2)+16, 17, 32, 5, '-', 0, 0)
		end
end