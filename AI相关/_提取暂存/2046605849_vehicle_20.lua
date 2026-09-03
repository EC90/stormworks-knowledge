-- source: steam id 2046605849 / vehicle.xml block#20
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2046605849
page = 1
function onTick()
	turnPage = input.getBool(1)
	backPage = input.getBool(2)
--Advance Button	
if turnPage == true and (page < 10) then
    page = (page + 1)
elseif
	turnPage == true and (page == 11) then
	page = 1
end
--Reverse Button	
if backPage == true and (page > 0) then
	page = (page - 1)
elseif
	backPage == true and (page == 1) then
	page = 8
end
f = switch[page]
if(f) then
	f()
else
	sayThis = ""
end
end

switch = {
--text per line   "------------OOOOOOOOOOOO------------OOOOOOOOOOOO------------OOOOOOOOOOOO------------OOOOOOOOOOOO
	[1] = function()
		sayThis = "3.APU ON \n\n4.APU Generator ON \n\n5.System power ON"
	end,
	[2] = function()	
		sayThis = "\n8.(optional) RSO touch both center  screens to  calibrate  cameras"
	end,
	[3] = function()
		sayThis = "12.Start engine 1 \n\n13.Start engine 2, wait for RPS to level \n\n14.Throttle to 11%"
	end,
	[4] = function()	
		sayThis = "17. Disconnect left and right ground ports \n\n18. Disconnect service vehicle"
	end,
	[5] = function()	
		sayThis = "21. Release Brake, 15% Throttle for taxi \n\n22.If needed, enable Pitch and Roll Stabilize"
	end,
	[6] = function()	
		sayThis = "25.Retract shock cones \n\n26. (optional) RSO set TCAS mode to 'normal'"
	end,
	[7] = function()	
		sayThis = "1. Extinguish damaged engine \n\n2.Sync engines"
	end,
	[8] = function()	
		sayThis = "\n\n\n     END"
	end,
	
}


-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(255, 40, 0)			 -- Set draw color to green
	screen.drawTextBox(2, 2, w, h, sayThis)
end