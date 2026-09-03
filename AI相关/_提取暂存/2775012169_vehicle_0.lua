-- source: steam id 2775012169 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2775012169
function onDraw()
	w = 32
	h = 32
	screen.setColor(0,0,0,255)
	
		
			
	screen.drawLine(16,31,16,30)
	
	screen.drawLine(16,26,16,24)
	screen.drawLine(16,23,16,21)
	screen.drawLine(16,20,16,18)
	
	screen.drawLine(16,16,16,18)
		
	screen.drawLine(15,17,16,16)			
	screen.drawLine(17,17,16,16)
	
	screen.drawLine(14,18,14.5,18)
	screen.drawLine(12,18,12.5,18)
	screen.drawLine(10,18,10.5,18)
	
	screen.drawLine(18,18,18.5,18)
	screen.drawLine(20,18,20.5,18)
	screen.drawLine(22,18,22.5,18)
	
	screen.drawLine(14,20,14.5,20)
	screen.drawLine(12,20,12.5,20)
	
	
	screen.drawLine(14,22,14.5,22)
	screen.drawLine(14,24,14.5,24)
	screen.drawLine(12,24,12.5,24)
	screen.drawLine(14,26,14.5,26)
	
	screen.drawLine(18,20,18.5,20)
	screen.drawLine(20,20,20.5,20)
	
	
	screen.drawLine(18,22,18.5,22)
	screen.drawLine(18,24,18.5,24)
	screen.drawLine(20,24,20.5,24)
	screen.drawLine(18,26,18.5,26)
	
	screen.drawCircle(16, 16, 15)
	screen.drawCircle(16, 16, 14)
													
	screen.drawCircle(16, 16, 16)
	screen.drawRectF(0,0,2,32)
	for i=1,128,1 do
		screen.drawCircle(16, 16, 16+i/8)
	end
	screen.setColor(0, 0, 0,255)
	screen.drawCircle(16, 16, 15.5)
	screen.setColor(0, 0, 0,255)
	screen.drawCircle(16, 16, 15.5)
end