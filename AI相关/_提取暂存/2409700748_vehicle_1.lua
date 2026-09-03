-- source: steam id 2409700748 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2409700748


function onTick()
	alt = math.floor(input.getNumber(1))
	spd = math.floor(input.getNumber(2))	
	
end

function onDraw()
	w = screen.getWidth()				
	h = screen.getHeight()					
	screen.setColor(0, 255, 0)	
	screen.drawText(0,0,spd .. "")
	if (alt < 100) then
	screen.drawTextBox(16,0,16,5,alt .. "p",1,-1) 
	end
end