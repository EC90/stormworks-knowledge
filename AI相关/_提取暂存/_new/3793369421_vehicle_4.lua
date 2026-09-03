-- source: steam id 3793369421 / vehicle.xml block#4
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793369421
-- Tick function that will be executed every logic tick
function onTick()
	
	bombs = {}    -- new array of bomb inputs
	
	-- assign bool for each bomb
	bombs[1] = input.getBool(1)
	bombs[2] = input.getBool(2)
	bombs[3] = input.getBool(3)
	bombs[4] = input.getBool(4)
	bombs[5] = input.getBool(5)
	bombs[6] = input.getBool(6)
	bombs[7] = input.getBool(7)
	bombs[8] = input.getBool(8)
	bombs[9] = input.getBool(9)
	bombs[10] = input.getBool(10)
	bombs[11] = input.getBool(11)
	bombs[12] = input.getBool(12)
	
	-- assign bool for button pushed
	buttonPushed = input.getBool(13)
	
	--initalDrop set by User
	initialDrop = input.getNumber(14)
	--current number of dropped bombs calculated in for loop
	currentDropped = 0
	
	-- inital interval time betwen drops. Set by User
	intialTimeInterval = input.getNumber(15)
	--current interval calc in for loop
	currentTimeInterval = 0
	
	
	if buttonPushed then
		
		for i=1,12,1 do
			if currentDropped < initialDrop then
				if bombs[i] then
					output.setBool(i,true)
					output.setNumber(i+12,currentTimeInterval)
					currentTimeInterval = currentTimeInterval + intialTimeInterval
					currentDropped = currentDropped + 1
				
				end
			end
		end		
			
	end
	
	
	
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(0, 255, 0)			 -- Set draw color to green
	screen.drawCircleF(w / 2, h / 2, 30)   -- Draw a 30px radius circle in the center of the screen
end