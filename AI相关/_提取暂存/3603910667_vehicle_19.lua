-- source: steam id 3603910667 / vehicle.xml block#19
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667


-- Tick function that will be executed every logic tick
function onTick()
	nav = input.getBool(2) 
	nuc = input.getBool(3) 
	tow = input.getBool(4) 
	ram = input.getBool(5)
	anc = input.getBool(6)
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(2, 2, 2)			
	screen.drawRectF(0, 0, w, h)
	screen.setColor(25, 25, 25)
	screen.drawLine(w/2, 4, w/2, 30)
	screen.drawLine(w/2-4, 7, w/2+5, 7)
	screen.drawLine(w/2, 12, w/2+5, 12)
	screen.drawLine(w/2, 17, w/2+5, 17)
	screen.drawLine(w/2-4, 22, w/2+5, 22)
	screen.drawLine(w/2-4, 27, w/2, 27)
	
	
	
	screen.setColor(30, 30, 30)
	
	screen.drawCircle(w/2, 2, 1)

	screen.drawCircle(w/2-4, 5, 1)		  screen.drawCircle(w/2+4, 5, 1)
											screen.drawCircle(w/2+4, 10, 1)
											screen.drawCircle(w/2+4, 15, 1)
	screen.drawCircle(w/2-4, 20, 1)		 screen.drawCircle(w/2+4, 20, 1)
	screen.drawCircle(w/2-4, 25, 1)		 
	
	screen.drawCircle(4,h/2+2,1)
	screen.drawCircle(w-4,h/2+2,1)
	screen.drawCircle(4,h/2-2,1)
	screen.drawCircle(w-4,h/2-2,1)
	

if nav then
	screen.setColor(250, 0, 0)	--left nav light red
	screen.drawCircle(4,h/2+2,1)
	screen.drawCircle(4,h/2-2,1)
	screen.setColor(0, 250, 0) 	--right nav light green
	screen.drawCircle(w-4,h/2-2,1)
	screen.drawCircle(w-4,h/2+2,1)
	screen.setColor(250, 250, 250)
	screen.drawCircle(w/2-4, 5, 1)	--left 1 white
	screen.setColor(250, 250, 250)
	screen.drawCircle(w/2-4, 25, 1)	--left 3 white
end
if nuc then
	screen.setColor(250, 0, 0)
	screen.drawCircle(w/2+4, 5, 1)	--right 1 red
	screen.setColor(250, 0, 0)
	screen.drawCircle(w/2+4, 15, 1)	--right 3 red
end
if tow and nav then
	screen.setColor(250, 250, 0)
	screen.drawCircle(w/2-4, 20, 1)	--left 2 yellow
	screen.setColor(250, 250, 250)
	screen.drawCircle(w/2+4, 20, 1)	--right 4 white
end
if ram then
	screen.setColor(250, 0, 0)
	screen.drawCircle(w/2+4, 5, 1)	--right 1 red
	screen.setColor(250, 250, 250)
	screen.drawCircle(w/2+4, 10, 1)	--right 2 white
	screen.setColor(250, 0, 0)
	screen.drawCircle(w/2+4, 15, 1)	--right 3 red
end
if anc then
	screen.setColor(250, 250, 250)
	screen.drawCircle(w/2, 2, 1) --top white light
end
 
		
end