-- source: steam id 2372828168 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2372828168
-- Tick function that will be executed every logic tick
function onTick()
load = input.getNumber(1)
loadb = (load/100)*15
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
		 -- Set draw color to green
screen.drawClear()
	screen.setColor(3,3,20)
screen.drawRectF(0,0,64,64)
screen.setColor(255, 255, 255)
screen.drawRect(0+3, 16, w-6, 4)
screen.setColor(255, 255, 255)
screen.drawRectF(0+4, 17, loadb, 3)


end