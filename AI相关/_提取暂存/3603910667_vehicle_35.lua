-- source: steam id 3603910667 / vehicle.xml block#35
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
-- Tick function that will be executed every logic tick
function onTick()
	s = input.getNumber(1)
	vr = input.getNumber(3)
		
	p=math.pi		 -- Read the first number from the script's composite input

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(0, 255, 0)			 -- Set draw color to green
	screen.drawLine(2, 22, 30, 22)
	screen.drawLine(30, 22, 30, 22-math.tan(10*5/90*p/2)*28)
	screen.drawLine(2, 22, 30, 22-math.tan(10*5/90*p/2)*28)
	screen.setColor(255, 0, 0)
	screen.drawCircleF(2+math.cos((vr+5/90*0.25)*10/0.25*p/2)*s/2000*28,22-math.sin((vr+5/90*0.25)*10/0.25*p/2)*s/2000*28,1)
	
	end
end