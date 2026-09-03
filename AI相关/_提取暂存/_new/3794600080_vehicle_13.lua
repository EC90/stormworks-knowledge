-- source: steam id 3794600080 / vehicle.xml block#13
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794600080
-- Tick function that will be executed every logic tick
function onTick()
	speed = input.getNumber(1)			 -- Read the first number from the script's composite input
	units = input.getNumber(2)
	ones = math.floor(speed % 10) 
	tens = math.floor((speed/10) % 10)
	hundreds = math.floor((speed/100) % 10)
end

v=2
v2=21
x=3
y=2
sdrf = screen.drawRectF
sdl = screen.drawLine
function drawh()
	sdrf(21,v2+2,2,6)
	sdrf(21,v2+4,5,2)
	sdrf(24,v2+2,2,6)
end
function drawp(x)
	sdrf(15-x,v2+2,4,2)
	sdrf(15-x,v2+5,4,2)
	sdrf(15-x,v2+2,2,6)
	sdrf(18-x,v2+3,2,3)
end
function drawk()
	sdrf(7,v2+2,2,6)
	sdrf(7,v2+4,5,2)
	sdrf(11,v2+2,2,2)
	sdrf(11,v2+6,2,2)
	sdrf(10,v2+3,2,4)
end
function draws()
	sdl(25,v2+3,20,v2+7)
	sdl(23,v2+4,24,v2+4)
	sdl(21,v2+2,26,v2+2)
	sdl(21,v2+7,25,v2+7)
	sdrf(21,v2+2,2,3)
	sdrf(24,v2+5,2,3)
end
function drawm()
	sdrf(7,v2+2,2,6)
	sdrf(12,v2+2,2,6)
	sdl(9,v2+3,9,v2+6)
	sdl(10,v2+4,10,v2+7)
	sdl(11,v2+3,11,v2+6)
end
function squares(x1,w1,x2,w2,x3,w3)
	screen.setColor(42,53,25)--text color
	sdrf(x1,v2+2,w1,6)
	sdrf(x2,v2+2,w2,6)
	sdrf(x3,v2+2,w3,6)
end
function one(x,y)
	sdrf(x+6,y,2,8)--b
	sdrf(x+6,y+6,2,8)--c
end
function two(x,y)
	sdrf(x,y,8,2)--a
	sdrf(x+6,y,2,8)--b
	sdrf(x,y+6,8,2)--g
	sdrf(x,y+6,2,8)--e
	sdrf(x,y+12,8,2)--d
end

function three(x,y)
	sdrf(x,y,8,2)--a
	sdrf(x+6,y,2,8)--b
	sdrf(x+6,y+6,2,8)--c
	sdrf(x,y+12,8,2)--d
	sdrf(x,y+6,8,2)--g
end

function four(x,y)
	sdrf(x+6,y,2,8)--b
	sdrf(x+6,y+6,2,8)--c
	sdrf(x,y,2,8)--f
	sdrf(x,y+6,8,2)--g
end

function five(x,y)
	sdrf(x,y,8,2)--a
	sdrf(x+6,y+6,2,8)--c
	sdrf(x,y+12,8,2)--d
	sdrf(x,y,2,8)--f
	sdrf(x,y+6,8,2)--g
end

function six(x,y)
	sdrf(x,y,8,2)--a
	sdrf(x+6,y+6,2,8)--c
	sdrf(x,y+12,8,2)--d
	sdrf(x,y+6,2,8)--e
	sdrf(x,y,2,8)--f
	sdrf(x,y+6,8,2)--g
end

function seven(x,y)
	sdrf(x,y,8,2)--a
	sdrf(x+6,y,2,8)--b
	sdrf(x+6,y+6,2,8)--c
end

function eight(x,y)
	sdrf(x,y,8,2)--a
	sdrf(x+6,y,2,8)--b
	sdrf(x+6,y+6,2,8)--c
	sdrf(x,y+12,8,2)--d
	sdrf(x,y+6,2,8)--e
	sdrf(x,y,2,8)--f
	sdrf(x,y+6,8,2)--g
end

function nine(x,y)
	sdrf(x,y,8,2)--a
	sdrf(x+6,y,2,8)--b
	sdrf(x+6,y+6,2,8)--c
	sdrf(x,y+12,8,2)--d
	sdrf(x,y,2,8)--f
	sdrf(x,y+6,8,2)--g
end

function zero(x,y)
	sdrf(x,y,8,2)--a
	sdrf(x+6,y,2,8)--b
	sdrf(x+6,y+6,2,8)--c
	sdrf(x,y+12,8,2)--d
	sdrf(x,y+6,2,8)--e
	sdrf(x,y,2,8)--f
end

function digit(x,y,n)
	if n==0 then zero(x,y)
	elseif n==1 then one(x,y)
	elseif n==2 then two(x,y)
	elseif n==3 then three(x,y)
	elseif n==4 then four(x,y)
	elseif n==5 then five(x,y)
	elseif n==6 then six(x,y)
	elseif n==7 then seven(x,y)
	elseif n==8 then eight(x,y)
	elseif n==9 then nine(x,y)
	end
end


	
-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()
	screen.setColor(7,7,7)
	screen.drawClear()
			
	screen.setColor(31, 40, 17) --outline color
	screen.drawRect(1,v,29,17)
	screen.drawRect(5,v2,21,8)

	
		
	screen.setColor(51,60,32)--fill color
	sdrf(2,v+1,29,17)
	sdrf(6,v2+1,21,8)


	screen.setColor(42,53,25)--text color
	eight(x,v+y)
	eight(x+9,v+y)
	eight(x+18,v+y)

	screen.setColor(4,4,4)
	if speed > 99 then
		
	digit(x,v+y,hundreds)
	
	end
	
	if speed > 9 then
	
	digit(x+9,v+y,tens)


	end
	digit(x+18,v+y,ones)



	if units == 1 then
		squares(7,7,15,5,21,5)
		screen.setColor(4,4,4)

		drawm()
		drawp(0)
		drawh()

	else if units == 2 then
		
		screen.setColor(42,53,25)--text color
		sdrf(7,v2+2,6,6)
		sdrf(14,v2+2,6,6)
		sdrf(21,v2+2,5,6)
		squares(7,6,14,6,21,5)
		screen.setColor(4,4,4)

		drawk()
		
		sdrf(14,v2+2,6,2)
		sdrf(16,v2+2,2,6)
		
		draws()
		
		else if units == 3 then
		
			squares(7,6,14,5,20,6)
			screen.setColor(4,4,4)
			drawk()
			drawp(1)
			sdrf(20,v2+2,2,6)
			sdrf(20,v2+4,6,2)
			sdrf(24,v2+2,2,6)

		
		else
			squares(7,7,15,5,21,5)
			screen.setColor(4,4,4)

			drawm()
		
			sdl(18,v2+2,14,v2+6)
			sdl(19,v2+2,14,v2+7)
			sdl(19,v2+3,14,v2+8)
			sdl(19,v2+4,15,v2+8)
		
			draws()
		end
		end
	end
end