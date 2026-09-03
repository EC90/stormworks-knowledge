-- source: steam id 2871941850 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2871941850
--[[Debug View


function onTick()
	roll = input.getNumber(1)
	pitch = input.getNumber(2)
	collective = input.getNumber(3)
	
	FL = input.getNumber(4)
	FR = input.getNumber(5)
	RL = input.getNumber(6)
	RR = input.getNumber(7)
	
	yaw = input.getNumber(8)

end


function onDraw()
	screen.setColor(255,255,0)
	
	screen.drawText(0,0,"Rol: "..("%.2f"):format(roll))
	screen.drawText(0,10,"Pit: "..("%.2f"):format(pitch))
	screen.drawText(0,20,"Col: "..("%.2f"):format(collective))
	screen.drawText(0,30,"Yaw: "..("%.2f"):format(yaw))
	
	screen.drawText(0,45,"FL: "..("%.2f"):format(FL))
	screen.drawText(0,55,"FR: "..("%.2f"):format(FR))
	screen.drawText(0,65,"RL: "..("%.2f"):format(RL))
	screen.drawText(0,75,"RR: "..("%.2f"):format(RR))
	
end

--]]