-- source: steam id 3793281684 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793281684
-- Tick function that will be executed every logic tick
function onTick()
	owo = input.getNumber(1)	
	uwu = input.getNumber(2)		 
    speed = input.getNumber(8)
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
  
screen.setColor(255, g, b, 90)
screen.drawLine(100, h/2, w/2, h/2)
screen.drawLine(w/2, -100, w/2, 100)
screen.drawLine(-100, h/2, w/2, h/2)
end