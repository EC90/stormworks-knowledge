-- source: steam id 2213181424 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2213181424
-- Tick function that will be executed every logic tick
function onTick()
	
	buzzm = input.getBool(1)
	buzzr = input.getBool(2)
	
	pmain = input.getNumber(1)
	pres = input.getNumber(2)
	fmain = input.getBool(3)
	fres = input.getBool(4)
		 	 
	
	if pmain <0.2 then
		output.setBool(1, true)
		else
		output.setBool(1, false)
		end
	if pres <0.50 then
		output.setBool(2, true)
		else
		output.setBool(2, false)
		end
end

function onDraw()
	w = screen.getWidth()				  
	h = screen.getHeight()					
	screen.setColor(0, 0, 0)			
	screen.drawClear()
	
	screen.setColor(0,0,0)	

-- main 
if buzzm then
	screen.setColor(100,0,0)
elseif fmain then
	screen.setColor(0,50,0)
end
	screen.drawRectF(0,0,22,h)


screen.setColor(0,0,0)
screen.drawRectF(2,9,17,20)

if pmain <0.2 then
	screen.setColor(100, 0, 0)
elseif pmain <0.30 then
	screen.setColor(150, 112, 0)
else
	screen.setColor(0, 50, 0)
end
	screen.drawRectF(2,29,17,-20*pmain)

if buzzm or fmain then
screen.setColor(0,0,0)
else
screen.setColor(25,50,100)
end
	screen.drawTextBox(1, 1, 30, 7, "MAIN", -1, 0)
	screen.drawLine(1, 10, 1, 28)
	screen.drawLine(19, 10, 19, 28)
	screen.drawLine(3, 8, 18, 8)
	screen.drawLine(3, 29, 18, 29)
	screen.drawLine(2, 9, 3, 9)
	screen.drawLine(18, 9, 19, 9)
	screen.drawLine(2, 28, 3, 28)
	screen.drawLine(18, 28, 19, 28)


-- reserve
screen.setColor(0,0,0)	
if buzzr then
	screen.setColor(100,0,0)
elseif fres then
	screen.setColor(0,50,0)
end
screen.drawRectF(22,0,10,h)

screen.setColor(0,0,0)	
screen.drawRectF(24,9,6,20)

if pres <0.50 then
	screen.setColor(100, 0, 0)
elseif pres <0.99 then
	screen.setColor(150, 112, 0)
else
	screen.setColor(0, 50, 0)
end
	screen.drawRectF(24,29,6,-20*pres)

if buzzr or fres then
screen.setColor(0,0,0)
else
screen.setColor(25,50,100)
end
	screen.drawTextBox(1, 1, 28, 7, "R",1, 0)
	screen.drawLine(1+22, 10, 1+22, 28)
	screen.drawLine(19+11, 10, 19+11, 28)
	screen.drawLine(3+22, 8, 18+11, 8)
	screen.drawLine(3+22, 29, 18+11, 29)
	
	screen.drawLine(2+22, 9, 3+22, 9)
	screen.drawLine(18+11, 9, 19+11, 9)
	screen.drawLine(2+22, 28, 3+22, 28)
	screen.drawLine(18+11, 28, 19+11, 28)
	

end