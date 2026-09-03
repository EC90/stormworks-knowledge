-- source: steam id 2084796098 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2084796098
function onTick()
	-- Example that adds two composite channels together and outputs the result
	dit= input.getNumber(1)
	tie= input.getNumber(2)
	dist= math.floor(dit)
	time= math.floor(tie)
	end
	
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(0, 255, 0)			 -- Set draw color to green
	screen.drawText(w/2-15, h/2+10, 'D '.. dist)
	screen.drawText(w/2-15, h/2-10, 'T '.. time)
	screen.drawText(w/2-15, h/2, 'Remain')
end