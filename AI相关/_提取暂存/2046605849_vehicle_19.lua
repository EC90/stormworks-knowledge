-- source: steam id 2046605849 / vehicle.xml block#19
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
	[1] = function()
		sayThis = "PREFLIGHT CHECKLIST \n\n1.Start ground cart \n\n2.(cockpit) Ground power ON"
	end,
	[2] = function()	
		sayThis = "\n6.Brake ON \n\n7.(optional) RSO set XPDR transponder code to 4400"
	end,
	[3] = function()
		sayThis = "9.Arm fire suppression systems \n\n10.Throttle to 5% \n\n11. L and R fuel pumps ON"
	end,
	[4] = function()	
		sayThis = "15.Generator 1 and 2 ON \n\n16.APU OFF,\nAPU Generator off,\nGround power off"
	end,
	[5] = function()	
		sayThis = "19.Enable nose wheel steering \n\n20.Left and Right afterburner pumps ON"
	end,
	[6] = function()	
		sayThis = "23.Close Canopy, throttle up and takeoff \n\n24.Retract Landing Gear"
	end,
	[7] = function()	
		sayThis = "\n\n\nIN THE CASE OF AN ENGINE FIRE"
	end,
	[8] = function()	
		sayThis = "Note:\nEngine Sync without a fire has a high chance of damaging both engines"
	end,
	
}


-- Draw function that will be executed when this script renders to a screen
function onDraw()
	w = screen.getWidth()				  -- Get the screen's width and height
	h = screen.getHeight()					
	screen.setColor(255, 40, 0)			 -- Set draw color to green
	screen.drawTextBox(2, 2, w, h, sayThis)
end