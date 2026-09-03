-- source: steam id 2156436786 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2156436786
-- Tick function that will be executed every logic tick



function round(num,dec)
local mult = 10^(dec or 0)
return math.floor(num*mult+0.5) / mult
end



function onTick()
	he = input.getNumber(4)
	hh = input.getNumber(5)
	me = input.getNumber(6)
	mm = input.getNumber(7)
	BEA = round(input.getNumber(8),1)
	ZOM = round(input.getNumber(9)*40+15,2)
	IR = input.getBool(8)
		
end


-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()			
	
	if (IR) == true then 
	screen.setColor(0, 255, 0)			 -- Set draw color to green
	else screen.setColor(255,255,255)
	end
	
	screen.drawText(7,h-8,"T-")
	
	screen.drawText(16,h-8,string.format("%.0f",he)..string.format("%.0f",hh)..":"..string.format("%.0f",me)..string.format("%.0f",mm))	
	
	screen.drawText(25,h-60,"HDG")
	
	screen.drawText(23,h-53,BEA)
	
	screen.drawRectF(25,h-30,11,1)
	
	screen.drawRectF(30,h-35,1,11)
	
	screen.drawTriangleF(5,h-(ZOM+5),10,h-(ZOM),5,h-(ZOM-5))
	
	screen.drawRectF(5,h-57,1,45)
	
	
	
		
		if (IR) == true then
		screen.drawText(12,h-40,"IR")
		else screen.drawText(12,h-40,"CAM")
		end
		


end


