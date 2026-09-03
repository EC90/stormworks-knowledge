-- source: steam id 1969765716 / vehicle.xml block#17
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1969765716
function onTick()
	isP = input.getBool(9)
	
	Fuel = input.getNumber(5)
	Battery = input.getNumber(6)
	RPS = input.getNumber(9)
	ETA = input.getNumber(23)

	if isP == nil then return false end
	if isP and not t then toggle = not toggle end
	t = isP
end

function onDraw()
	screen.setColor(255,255,0,50)
	screen.drawRect(0,0,31,31)
	screen.drawLine(1,15,31,15)

	if toggle then
		screen.setColor(0,255,0,255)
		screen.drawText(2,2,"RPS:")
		screen.drawText(2,8,string.format("%.2f", RPS))
		screen.drawText(2,17,"Elec:")
		screen.drawText(2,23,string.format("%.2f", Battery))
	else
		if Fuel < 250 and Fuel > 0 then screen.setColor(255,255,0,255) elseif Fuel <= 0 then screen.setColor(255,0,0,255)
		else screen.setColor(0,255,0,255) end
		screen.drawText(2,8,string.format("%.1f", Fuel))
		screen.setColor(0,255,0,255)
		screen.drawText(2,2,"Fuel:")
		screen.drawText(2,17,"ETA:")
		screen.drawText(2,23,string.format("%.2f", ETA))
	end
end